From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 19/19] Fix some trailing whitespace
Date: Sat, 9 Mar 2013 19:31:29 +0000
Message-ID: <CALeLG_=4uJKn44i+iiinosQ28pAqj6GJQS4NAuMveW4bVRLofA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:31:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPUr-0006I2-0o
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301Ab3CITbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:31:31 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:62881 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CITba (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:31:30 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so2258366obb.11
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=B8tBfbMfhIeqQ6s5kzHE38Ca1W9ZNjAuj0ZPRJNDZrI=;
        b=Io7kJvJQvR5QVFji+Ah5NzjOJpDS/vP5iLqFNIJhtaTF0KNFkrWHKOz7SAUr/IjUg5
         xRGbwb1QpveWKO+k6LnBoHvM84VHZvwjvDOTDYnKuWj84/NJT0/o5hVz8GYAqhkc3soE
         8KNKWwHDZ5xPmS4GnuEiBUmC7g5YPjPlGZ5S23+Jst98+k2+CdWKhoTvU+9Qtn2ml9dY
         0n4JVxalUIPGH+M3AHT1EVwURHVizazKvdF5HYyk8WypsCoHAKVEr1wS+IIjx9Bvn97A
         NSB6wVcrsWXVle/OP2fcXKv0m3JEsW2lM6Cz3u3kOZKuUP64GD/qclSHCNOIf3I5VJ2Y
         o05A==
X-Received: by 10.60.14.226 with SMTP id s2mr5067499oec.124.1362857489529;
 Sat, 09 Mar 2013 11:31:29 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:31:29 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQmJ66WYCmXcNwBG5qUfuEP4n5n/Rp1l+vvoJBo9YqhHhfOA/eOs36VJePW7UKxwlXTro62J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217757>

>From 54d376c3d731ce9e528fe9095ea6c16d382b5ce3 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:36:22 +0000
Subject: [PATCH 19/19] Fix some trailing whitespace

Conflicts:
	contrib/subtree/.gitignore
	contrib/subtree/git-subtree.sh
	contrib/subtree/test.sh

Original-Author: Herman van Rink <rink@initfour.nl>

OPTS_SPEC for push and pull updated (should have been picked up in an
earlier commit)

Fixed order of cases in setting the --default parameter

Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 223 +++++++++++++++++++++--------------------
 1 file changed, 114 insertions(+), 109 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 3582a55..df1413d 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -11,10 +11,10 @@ OPTS_SPEC="\
 git subtree add   --prefix=<prefix> <commit>
 git subtree add   --prefix=<prefix> <repository> <commit>
 git subtree merge --prefix=<prefix> <commit>
-git subtree pull  --prefix=<prefix> <repository> <refspec...>
+git subtree pull  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree pull-all
 git subtree push-all
-git subtree push  --prefix=<prefix> <repository> <refspec...>
+git subtree push  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree list
 git subtree split --prefix=<prefix> <commit...>
 git subtree diff  --prefix=<prefix> [<repository> [<refspec>...]]
@@ -92,7 +92,7 @@ while [ $# -gt 0 ]; do
 		-b) branch="$1"; shift ;;
 		-P) prefix="$1"; shift ;;
 		-m) message="$1"; shift ;;
-        -f|--force) force=1 ;;
+		-f|--force) force=1 ;;
 		--no-prefix) prefix= ;;
 		--onto) onto="$1"; shift ;;
 		--no-onto) onto= ;;
@@ -113,9 +113,9 @@ prefix="${prefix%/}";
 command="$1"
 shift
 case "$command" in
-    add|merge|pull|from-submodule|pull-all|push-all|prune) default= ;;
+	add|merge|pull|pull-all|push-all|from-submodule|prune) default= ;;
+	split|push|diff|list) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
-    split|push|diff|list) default="--default HEAD" ;;
 esac

 if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" !=
"push-all" -a "$command" != "list" -a "$command" != "prune" ]; then
@@ -123,8 +123,10 @@ if [ -z "$prefix" -a "$command" != "pull-all" -a
"$command" != "push-all" -a "$c
 fi

 case "$command" in
-    pull-all);;
-    push-all);;
+	pull-all);;
+	push-all);;
+	list);;
+	prune);;
 	add) [ -e "$prefix" ] &&
 		die "prefix '$prefix' already exists." ;;
 	*)   [ -e "$prefix" ] ||
@@ -133,7 +135,7 @@ esac

 dir="$(dirname "$prefix/.")"

-if [ "$command" != "pull" -a "$command" != "add" -a "$command" !=
"push" -a "$command" != "pull-all" ]; then
+if [ "$command" != "pull" -a "$command" != "add" -a "$command" !=
"push" -a "$command" != "pull-all" -a "$command" != "diff" ]; then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs="$(git rev-parse --no-revs --no-flags "$@")" || exit $?
 	if [ -n "$dirs" ]; then
@@ -541,14 +543,14 @@ cmd_add_repository()
 	revs=FETCH_HEAD
 	set -- $revs
 	cmd_add_commit "$@"
-
-  # now add it to our list of repos
-  git config -f .gittrees --unset subtree.$dir.url
-  git config -f .gittrees --add subtree.$dir.url $repository
-  git config -f .gittrees --unset subtree.$dir.path
-  git config -f .gittrees --add subtree.$dir.path $dir
-  git config -f .gittrees --unset subtree.$dir.branch
-  git config -f .gittrees --add subtree.$dir.branch $refspec
+
+	# now add it to our list of repos
+	git config -f .gittrees --unset subtree.$dir.url
+	git config -f .gittrees --add subtree.$dir.url $repository
+	git config -f .gittrees --unset subtree.$dir.path
+	git config -f .gittrees --add subtree.$dir.path $dir
+	git config -f .gittrees --unset subtree.$dir.branch
+	git config -f .gittrees --add subtree.$dir.branch $refspec
 }

 cmd_add_commit()
@@ -721,89 +723,91 @@ cmd_merge()

 cmd_pull()
 {
-  if [ $# -gt 2 ]; then
-	    die "You should provide either <refspec> or <repository> <refspec>"
+	if [ $# -gt 2 ]; then
+		die "You should provide either <refspec> or <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
-	    ensure_clean
-      if [ $# -eq 1 ]; then
-	      repository=$(git config -f .gittrees subtree.$prefix.url)
-	      refspec=$1
-      elif [ $# -eq 2 ]; then
-        repository=$1
-        refspec=$2
-      else
-	      repository=$(git config -f .gittrees subtree.$prefix.url)
-        refspec=$(git config -f .gittrees subtree.$prefix.branch)
-      fi
-	    git fetch $repository $refspec || exit $?
-	    echo "git fetch using: " $repository $refspec
-	    revs=FETCH_HEAD
-	    set -- $revs
-	    cmd_merge "$@"
+		ensure_clean
+		if [ $# -eq 1 ]; then
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$1
+		elif [ $# -eq 2 ]; then
+			repository=$1
+			refspec=$2
+		else
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$(git config -f .gittrees subtree.$prefix.branch)
+		fi
+		git fetch $repository $refspec || exit $?
+		echo "git fetch using: " $repository $refspec
+		revs=FETCH_HEAD
+		set -- $revs
+		cmd_merge "$@"
 	else
-	    die "'$dir' must already exist. Try 'git subtree add'."
+		die "'$dir' must already exist. Try 'git subtree add'."
 	fi
 }

-cmd_diff()
-{
-    if [ -e "$dir" ]; then
-        if [ $# -eq 1 ]; then
-            repository=$(git config -f .gittrees subtree.$prefix.url)
-            refspec=$1
-        elif [ $# -eq 2 ]; then
-            repository=$1
-            refspec=$2
-        else
-            repository=$(git config -f .gittrees subtree.$prefix.url)
-            refspec=$(git config -f .gittrees subtree.$prefix.branch)
-        fi
-        # this is ugly, but I don't know of a better way to do it. My
git-fu is weak.
-        # git diff-tree expects a treeish, but I have only a
repository and branch name.
-        # I don't know how to turn that into a treeish without
creating a remote.
-        # Please change this if you know a better way!
-        tmp_remote=__diff-tmp
-        git remote rm $tmp_remote > /dev/null 2>&1
-        git remote add -t $refspec $tmp_remote $repository > /dev/null
-        # we fetch as a separate step so we can pass -q (quiet),
which isn't an option for "git remote"
-        # could this instead be "git fetch -q $repository $refspec"
and leave aside creating the remote?
-        # Still need a treeish for the diff-tree command...
-        git fetch -q $tmp_remote
-        git diff-tree -p refs/remotes/$tmp_remote/$refspec
-        git remote rm $tmp_remote > /dev/null 2>&1
-    else
-        die "Cannot resolve directory '$dir'. Please point to an
existing subtree directory to diff. Try 'git subtree add' to add a
subtree."
-    fi
+cmd_diff()
+{
+	if [ -e "$dir" ]; then
+		if [ $# -eq 1 ]; then
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$1
+		elif [ $# -eq 2 ]; then
+			repository=$1
+			refspec=$2
+		else
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$(git config -f .gittrees subtree.$prefix.branch)
+		fi
+		# this is ugly, but I don't know of a better way to do it. My git-fu is weak.
+		# git diff-tree expects a treeish, but I have only a repository and
branch name.
+		# I don't know how to turn that into a treeish without creating a remote.
+		# Please change this if you know a better way!
+		tmp_remote=__diff-tmp
+		git remote rm $tmp_remote > /dev/null 2>&1
+		git remote add -t $refspec $tmp_remote $repository > /dev/null
+		# we fetch as a separate step so we can pass -q (quiet), which
isn't an option for "git remote"
+		# could this instead be "git fetch -q $repository $refspec" and
leave aside creating the remote?
+		# Still need a treeish for the diff-tree command...
+		git fetch -q $tmp_remote
+		git diff-tree -p refs/remotes/$tmp_remote/$refspec
+		git remote rm $tmp_remote > /dev/null 2>&1
+	else
+		die "Cannot resolve directory '$dir'. Please point to an existing
subtree directory to diff. Try 'git subtree add' to add a subtree."
+	fi
 }

 cmd_push()
 {
 	if [ $# -gt 2 ]; then
-	    die "You shold provide either <refspec> or <repository> <refspec>"
+		die "You shold provide either <refspec> or <repository> <refspec>"
 	fi
 	if [ -e "$dir" ]; then
-      if [ $# -eq 1 ]; then
-	      repository=$(git config -f .gittrees subtree.$prefix.url)
-        refspec=$1
-      elif [ $# -eq 2 ]; then
-        repository=$1
-        refspec=$2
-      else
-	      repository=$(git config -f .gittrees subtree.$prefix.url)
-        refspec=$(git config -f .gittrees subtree.$prefix.branch)
-      fi
-        push_opts=
-        if [ "$force" == "1" ]; then
-            push_opts="$push_opts --force"
-        fi
-	    echo "git push using: " $repository $refspec
-	    rev=$(git subtree split --prefix=$prefix)
-	    if [ -n "$rev" ]; then
-	        git push $push_opts $repository $rev:refs/heads/$refspec
-	    else
-	        die "Couldn't push, 'git subtree split' failed."
-	    fi
+		if [ $# -eq 1 ]; then
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$1
+		elif [ $# -eq 2 ]; then
+			repository=$1
+			refspec=$2
+		else
+			repository=$(git config -f .gittrees subtree.$prefix.url)
+			refspec=$(git config -f .gittrees subtree.$prefix.branch)
+		fi
+
+		push_opts=
+		if [ "$force" == "1" ]; then
+		  push_opts="$push_opts --force"
+		fi
+
+		echo "git push using: " $repository $refspec
+		rev=$(git subtree split --prefix=$prefix)
+		if [ -n "$rev" ]; then
+			git push $push_opts $repository $rev:refs/heads/$refspec
+		else
+			die "Couldn't push, 'git subtree split' failed."
+		fi
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
 	fi
@@ -831,6 +835,7 @@ cmd_from-submodule()
 	git commit -m "Remove '$prefix/' submodule"

 	# subtree add from submodule repo.
+	# TODO: Could be determin HEAD to be a specific branch
 	cmd_add_repository $tmp_repo HEAD

 	# Update .gittrees with the original repo url
@@ -841,46 +846,46 @@ cmd_from-submodule()
 	rm -rf $tmp_repo
 }

-subtree_list()
+subtree_list()
 {
-    git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
-    while read path; do
-        repository=$(git config -f .gittrees subtree.$path.url)
-        refspec=$(git config -f .gittrees subtree.$path.branch)
-        echo "    $path        (merged from $repository branch $refspec) "
-    done
+	git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
+	while read path; do
+		repository=$(git config -f .gittrees subtree.$path.url)
+		refspec=$(git config -f .gittrees subtree.$path.branch)
+		echo "	$path		(merged from $repository branch $refspec) "
+	done
 }

 cmd_list()
 {
-  subtree_list
+  subtree_list
 }

 cmd_prune()
 {
-    git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
-    while read path; do
-        if [ ! -e "$path" ]; then
-            echo "pruning $path"
-            git config -f .gittrees --remove-section subtree.$path
-        fi
-    done
+	git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
+	while read path; do
+		if [ ! -e "$path" ]; then
+			echo "pruning $path"
+			git config -f .gittrees --remove-section subtree.$path
+		fi
+	done
 }

 cmd_pull-all()
 {
-    git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
-        while read path; do
-            git subtree pull -P $path master || exit $?
-        done
+	git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
+	while read path; do
+		git subtree pull -P $path $(git config -f .gittrees
subtree.$path.url) $(git config -f .gittrees subtree.$path.branch) ||
exit $?
+	done
 }

 cmd_push-all()
 {
-    git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
-        while read path; do
-            git subtree push -P $path master || exit $?
-        done
+	git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
+	while read path; do
+		git subtree push -P $path $(git config -f .gittrees
subtree.$path.url) $(git config -f .gittrees subtree.$path.branch) ||
exit $?
+	done
 }

 "cmd_$command" "$@"
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
