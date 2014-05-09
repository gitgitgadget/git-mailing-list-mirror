From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/17] contrib: remove 'diffall'
Date: Fri,  9 May 2014 14:11:30 -0500
Message-ID: <1399662703-355-5-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDs-0001jz-Vm
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbaEITMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:08 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:58661 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbaEITMG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:06 -0400
Received: by mail-yh0-f45.google.com with SMTP id b6so4125745yha.4
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uiCmfp84T8LrrAHpEh7lNfRyZ+dSwJ6pVD8/RqZE+U8=;
        b=TwA2kxDgHJuJW9gt5fLD/iTOBN18BRq2oIfveo9+0tTUbuQA0ivgEi1+PgPM8BXx32
         c3wXEYbgM0Dj6rkndJS+H9+JHU1uwORM7AHc+AHZ1a6Zzti08gDZtVDhumUE/Xk7ERYV
         VDG3xEq3wWIXtTWboiZjvSOjYmXoZuznKNH4XJ0PPEA7xX7OWfndWEVTZE9inxIgABiQ
         sFnLvGDD75e9EtNwTOUmFpLm3QmXwDGFN5yUSiz+S1rPVy86luY1Q//hl4izGRPCyR6C
         d3cu0Qc4NRAP+Fb6Tv474qXnk5CZbR4BtkydgxKoYgs1Faa+wrSBr37K4IPVUxmttfhC
         ZdbA==
X-Received: by 10.236.229.133 with SMTP id h5mr18198830yhq.64.1399662723614;
        Fri, 09 May 2014 12:12:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r46sm7410588yhd.29.2014.05.09.12.12.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:02 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248621>

There is no more need for this tool since the --dir-dirr option was
introduced.

Cc: Tim Henigan <tim.henigan@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/diffall/README      |  31 ------
 contrib/diffall/git-diffall | 257 --------------------------------------------
 2 files changed, 288 deletions(-)
 delete mode 100644 contrib/diffall/README
 delete mode 100755 contrib/diffall/git-diffall

diff --git a/contrib/diffall/README b/contrib/diffall/README
deleted file mode 100644
index 507f17d..0000000
--- a/contrib/diffall/README
+++ /dev/null
@@ -1,31 +0,0 @@
-The git-diffall script provides a directory based diff mechanism
-for git.
-
-To determine what diff viewer is used, the script requires either
-the 'diff.tool' or 'merge.tool' configuration option to be set.
-
-This script is compatible with most common forms used to specify a
-range of revisions to diff:
-
-  1. git diffall: shows diff between working tree and staged changes
-  2. git diffall --cached [<commit>]: shows diff between staged
-     changes and HEAD (or other named commit)
-  3. git diffall <commit>: shows diff between working tree and named
-     commit
-  4. git diffall <commit> <commit>: show diff between two named commits
-  5. git diffall <commit>..<commit>: same as above
-  6. git diffall <commit>...<commit>: show the changes on the branch
-     containing and up to the second, starting at a common ancestor
-     of both <commit>
-
-Note: all forms take an optional path limiter [-- <path>*]
-
-The '--extcmd=<command>' option allows the user to specify a custom
-command for viewing diffs.  When given, configured defaults are
-ignored and the script runs $command $LOCAL $REMOTE.  Additionally,
-$BASE is set in the environment.
-
-This script is based on an example provided by Thomas Rast on the
-Git list [1]:
-
-[1] http://thread.gmane.org/gmane.comp.version-control.git/124807
diff --git a/contrib/diffall/git-diffall b/contrib/diffall/git-diffall
deleted file mode 100755
index 84f2b65..0000000
--- a/contrib/diffall/git-diffall
+++ /dev/null
@@ -1,257 +0,0 @@
-#!/bin/sh
-# Copyright 2010 - 2012, Tim Henigan <tim.henigan@gmail.com>
-#
-# Perform a directory diff between commits in the repository using
-# the external diff or merge tool specified in the user's config.
-
-USAGE='[--cached] [--copy-back] [-x|--extcmd=<command>] <commit>{0,2} [-- <path>*]
-
-    --cached     Compare to the index rather than the working tree.
-
-    --copy-back  Copy files back to the working tree when the diff
-                 tool exits (in case they were modified by the
-                 user).  This option is only valid if the diff
-                 compared with the working tree.
-
-    -x=<command>
-    --extcmd=<command>  Specify a custom command for viewing diffs.
-                 git-diffall ignores the configured defaults and
-                 runs $command $LOCAL $REMOTE when this option is
-                 specified. Additionally, $BASE is set in the
-                 environment.
-'
-
-SUBDIRECTORY_OK=1
-. "$(git --exec-path)/git-sh-setup"
-
-TOOL_MODE=diff
-. "$(git --exec-path)/git-mergetool--lib"
-
-merge_tool="$(get_merge_tool)"
-if test -z "$merge_tool"
-then
-	echo "Error: Either the 'diff.tool' or 'merge.tool' option must be set."
-	usage
-fi
-
-start_dir=$(pwd)
-
-# All the file paths returned by the diff command are relative to the root
-# of the working copy. So if the script is called from a subdirectory, it
-# must switch to the root of working copy before trying to use those paths.
-cdup=$(git rev-parse --show-cdup) &&
-cd "$cdup" || {
-	echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
-	exit 1
-}
-
-# set up temp dir
-tmp=$(perl -e 'use File::Temp qw(tempdir);
-	$t=tempdir("/tmp/git-diffall.XXXXX") or exit(1);
-	print $t') || exit 1
-trap 'rm -rf "$tmp"' EXIT
-
-left=
-right=
-paths=
-dashdash_seen=
-compare_staged=
-merge_base=
-left_dir=
-right_dir=
-diff_tool=
-copy_back=
-
-while test $# != 0
-do
-	case "$1" in
-	-h|--h|--he|--hel|--help)
-		usage
-		;;
-	--cached)
-		compare_staged=1
-		;;
-	--copy-back)
-		copy_back=1
-		;;
-	-x|--e|--ex|--ext|--extc|--extcm|--extcmd)
-		if test $# = 1
-		then
-			echo You must specify the tool for use with --extcmd
-			usage
-		else
-			diff_tool=$2
-			shift
-		fi
-		;;
-	--)
-		dashdash_seen=1
-		;;
-	-*)
-		echo Invalid option: "$1"
-		usage
-		;;
-	*)
-		# could be commit, commit range or path limiter
-		case "$1" in
-		*...*)
-			left=${1%...*}
-			right=${1#*...}
-			merge_base=1
-			;;
-		*..*)
-			left=${1%..*}
-			right=${1#*..}
-			;;
-		*)
-			if test -n "$dashdash_seen"
-			then
-				paths="$paths$1 "
-			elif test -z "$left"
-			then
-				left=$1
-			elif test -z "$right"
-			then
-				right=$1
-			else
-				paths="$paths$1 "
-			fi
-			;;
-		esac
-		;;
-	esac
-	shift
-done
-
-# Determine the set of files which changed
-if test -n "$left" && test -n "$right"
-then
-	left_dir="cmt-$(git rev-parse --short $left)"
-	right_dir="cmt-$(git rev-parse --short $right)"
-
-	if test -n "$compare_staged"
-	then
-		usage
-	elif test -n "$merge_base"
-	then
-		git diff --name-only "$left"..."$right" -- $paths >"$tmp/filelist"
-	else
-		git diff --name-only "$left" "$right" -- $paths >"$tmp/filelist"
-	fi
-elif test -n "$left"
-then
-	left_dir="cmt-$(git rev-parse --short $left)"
-
-	if test -n "$compare_staged"
-	then
-		right_dir="staged"
-		git diff --name-only --cached "$left" -- $paths >"$tmp/filelist"
-	else
-		right_dir="working_tree"
-		git diff --name-only "$left" -- $paths >"$tmp/filelist"
-	fi
-else
-	left_dir="HEAD"
-
-	if test -n "$compare_staged"
-	then
-		right_dir="staged"
-		git diff --name-only --cached -- $paths >"$tmp/filelist"
-	else
-		right_dir="working_tree"
-		git diff --name-only -- $paths >"$tmp/filelist"
-	fi
-fi
-
-# Exit immediately if there are no diffs
-if test ! -s "$tmp/filelist"
-then
-	exit 0
-fi
-
-if test -n "$copy_back" && test "$right_dir" != "working_tree"
-then
-	echo "--copy-back is only valid when diff includes the working tree."
-	exit 1
-fi
-
-# Create the named tmp directories that will hold the files to be compared
-mkdir -p "$tmp/$left_dir" "$tmp/$right_dir"
-
-# Populate the tmp/right_dir directory with the files to be compared
-while read name
-do
-	if test -n "$right"
-	then
-		ls_list=$(git ls-tree $right "$name")
-		if test -n "$ls_list"
-		then
-			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
-			git show "$right":"$name" >"$tmp/$right_dir/$name" || true
-		fi
-	elif test -n "$compare_staged"
-	then
-		ls_list=$(git ls-files -- "$name")
-		if test -n "$ls_list"
-		then
-			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
-			git show :"$name" >"$tmp/$right_dir/$name"
-		fi
-	else
-		if test -e "$name"
-		then
-			mkdir -p "$tmp/$right_dir/$(dirname "$name")"
-			cp "$name" "$tmp/$right_dir/$name"
-		fi
-	fi
-done < "$tmp/filelist"
-
-# Populate the tmp/left_dir directory with the files to be compared
-while read name
-do
-	if test -n "$left"
-	then
-		ls_list=$(git ls-tree $left "$name")
-		if test -n "$ls_list"
-		then
-			mkdir -p "$tmp/$left_dir/$(dirname "$name")"
-			git show "$left":"$name" >"$tmp/$left_dir/$name" || true
-		fi
-	else
-		if test -n "$compare_staged"
-		then
-			ls_list=$(git ls-tree HEAD "$name")
-			if test -n "$ls_list"
-			then
-				mkdir -p "$tmp/$left_dir/$(dirname "$name")"
-				git show HEAD:"$name" >"$tmp/$left_dir/$name"
-			fi
-		else
-			mkdir -p "$tmp/$left_dir/$(dirname "$name")"
-			git show :"$name" >"$tmp/$left_dir/$name"
-		fi
-	fi
-done < "$tmp/filelist"
-
-LOCAL="$tmp/$left_dir"
-REMOTE="$tmp/$right_dir"
-
-if test -n "$diff_tool"
-then
-	export BASE
-	eval $diff_tool '"$LOCAL"' '"$REMOTE"'
-else
-	run_merge_tool "$merge_tool" false
-fi
-
-# Copy files back to the working dir, if requested
-if test -n "$copy_back" && test "$right_dir" = "working_tree"
-then
-	cd "$start_dir"
-	git_top_dir=$(git rev-parse --show-toplevel)
-	find "$tmp/$right_dir" -type f |
-	while read file
-	do
-		cp "$file" "$git_top_dir/${file#$tmp/$right_dir/}"
-	done
-fi
-- 
1.9.2+fc1.28.g12374c0
