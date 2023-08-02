#!/bin/bash

# Check for help option

if [ "$1" == "-h" ] || [ "$1" == "--help" ]
 then
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -c, --create  Create a new user account."
    echo "  -d, --delete  Delete an existing user account."
    echo "  -r, --reset   Reset password for an existing user account."
    echo "  -l, --list    List all user accounts on the system."
    echo "  -h, --help    Show this help message"
    exit 0
fi

# Create a new user account 

if [ "$1" == "-c" ] || [ "$1" == "--create" ]
 then
    read -p "Enter a new username: " username
    id "$username" &>/dev/null
    if [ $? -eq 0 ]; then
        echo "The username '$username' already exists. Please choose a different username."
    else
        sudo useradd -m "$username"
        sudo passwd "$username"
        echo "User account '$username' created successfully."
    fi

# Delete an existing user account 

elif [ "$1" == "-d" ] || [ "$1" == "--delete" ]
 then
    read -p "Enter the username to delete: " username
    id "$username" &>/dev/null
    if [ $? -eq 0 ]; then
        sudo userdel -r "$username"
        echo "Done! Account '$username' deleted successfully."
    else
        echo "Sorry, The username '$username' doesn't exist.Please enter a valid username"

    fi
# Reset password for a user account

elif [ "$1" == "-r" ] || [ "$1" == "--reset" ]
 then
    read -p "Enter the username to reset password: " username
    id "$username" &>/dev/null
    if [ $? -eq 0 ]; then
        sudo passwd "$username"
        echo "Password for '$username' reset successfully."
    else
        echo "Uh-oh! '$username' doesn't exist."
    fi

# List all the user accounts

elif [ "$1" == "-l" ] || [ "$1" == "--list" ]
 then
    echo "User accounts on the system :"
    echo "Username   UID"
    echo "----------------"
    awk -F: '{print $1 "   " $3}' /etc/passwd

# Handle invalid options

else
    echo "Oops! Invalid option: $1"
    echo "Use '$0 -h' to see available options."
    exit 1
fi
