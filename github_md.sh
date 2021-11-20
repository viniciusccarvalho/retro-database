#!/usr/bin/env bash

# convert all the files in the root
find . -iname "*.adoc" -type f -maxdepth 1 -not -name "_*.adoc" | while read fname; do
  target=${fname//adoc/md}
  xml=${fname//adoc/xml}
  echo "converting $fname into $target"

  asciidoctor -b docbook -a leveloffset=+1 -o - "$fname" | pandoc  --markdown-headings=atx --wrap=preserve -t markdown_strict -f docbook - > "$target"
  echo deleting $xml
  rm -f "$xml"
done

# if we find a readme*.md, we rename to README.md
find . -iname "readme*.md" -not -name "README.md" -type f -maxdepth 1 | while read fname; do
  echo Renaming $fname to README.md
  mv $fname README.md
done
