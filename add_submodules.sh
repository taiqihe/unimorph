#!/bin/bash

# Get a list of repos from the unimorph organization
repos=$(gh repo list unimorph -L 999 --json name | jq -r '.[].name')

# Loop through each repo name
for repo in $repos; do
    # Exclude the "zxx" test repo
    if [ "$repo" == "zxx" ]; then
        continue
    fi

    # Check if the repo name consists of exactly three letters
    if [[ $repo =~ ^[a-zA-Z]{3}$ ]]; then
        # Check if a directory with the name does not exist
        if [ ! -d "./$repo" ]; then
            echo "Adding $repo as a submodule..."
            # Add the repo as a submodule
            git submodule add "https://github.com/unimorph/$repo.git" "$repo"
        else
            echo "Directory $repo already exists, skipping..."
        fi
    fi
done
