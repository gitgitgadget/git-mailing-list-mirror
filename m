From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v1 06/25] contrib: remove 'diffall'
Date: Fri, 9 May 2014 13:12:46 -0700
Message-ID: <20140509201246.GM9218@google.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-7-git-send-email-felipe.contreras@gmail.com>
 <CAFouetj4A+z2xzciGAbsQ8th8CNwYMd5QTapar4TXRLzGdAqeQ@mail.gmail.com>
 <20140509185035.GL9218@google.com>
 <CAFouethK=VKYzTOW7dDi7tmOHaGtNp_xHxk3MSf+n1QNuXbEdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 22:12:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WirA9-0000iU-Jj
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 22:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbaEIUMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 16:12:52 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:51079 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727AbaEIUMv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 16:12:51 -0400
Received: by mail-pd0-f172.google.com with SMTP id g10so4067685pdj.31
        for <git@vger.kernel.org>; Fri, 09 May 2014 13:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1xdp6uhtF2qJHWJPXuHhpkOt/mYOiaJ0hFBcwt3/Dtw=;
        b=YZGbJ6zPljlYgn41qLxTV0i8HAFAPR1Jjg1cr+cDX+pJNO9538kCr0wiWhlr7b/uns
         0RhtUYw4ITaXF/Sr0pmpVZl7mn6YrNSIbYOMzNOl9hTNqBZJu4fy4ZHZHBjUzG7NpGRd
         zyTagraLfB61p/kRsuvJJNfPpQUC67tItn/tOu3t0YtMP9541LW/NW06Nn9DBI4FocsH
         Q3h46B3SyAXshpr1TtF0HnAqXSAdtWotiqivN3eUASZPBxRk0kykzVTg80CCXUY4ZhpM
         m+lS/hIGELDusu2NxjrYhit9I20VrfTSTEO4VY3fnTHiGzpIvdFSmh0ntaSZdk2Njdll
         eEHg==
X-Received: by 10.66.189.226 with SMTP id gl2mr24085933pac.65.1399666370820;
        Fri, 09 May 2014 13:12:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z3sm12045410pas.15.2014.05.09.13.12.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 May 2014 13:12:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFouethK=VKYzTOW7dDi7tmOHaGtNp_xHxk3MSf+n1QNuXbEdQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248637>

Hi,

Tim Henigan wrote:

> However, I like the idea of simply removing the directory from contrib
> and pointing to 'difftool --dir-diff' in the release notes.

Thanks.  I believe Junio uses commit messages as reference when
writing release notes so hopefully this should be enough to make that
happen.

-- >8 --
Subject: contrib: remove git-diffall

The functionality of the "git diffall" script in contrib/ was
incorporated into "git difftool" when the --dir-diff option was added
in v1.7.11 (ca. June, 2012).  Once difftool learned those features,
the diffall script became obsolete.

The only difference in behavior is that when comparing to the working
tree, difftool copies any files modified by the user back to the
working tree when the diff tool exits.  "git diffall" required the
--copy-back option to do the same.  All other diffall options have the
same meaning in difftool.

Make life easier for people choosing a tool to use by removing the old
diffall script.  A pointer in the release notes should be enough to
help current users migrate.

Helped-by: Tim Henigan <tim.henigan@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
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
1.9.1.423.g4596e3a
