From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/4] git-svn.txt: make formatting more consistent.
Date: Tue,  7 Jul 2009 15:02:15 +0200
Message-ID: <d96fcc984cf5e879ce132e4b1d97f29c2c6503ad.1246971377.git.ydirson@altern.org>
References: <cover.1246971377.git.ydirson@altern.org>
 <ffe5b8e8cf2cb889cdcc04850cf867b46df9ced9.1246971377.git.ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 15:18:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOAYd-0003Vu-Iv
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 15:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbZGGNRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 09:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZGGNRw
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 09:17:52 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33740 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbZGGNRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 09:17:51 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id B806A94010B;
	Tue,  7 Jul 2009 15:17:43 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id AFAFF9401B4;
	Tue,  7 Jul 2009 15:17:40 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 45E721F09C; Tue,  7 Jul 2009 15:02:20 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <ffe5b8e8cf2cb889cdcc04850cf867b46df9ced9.1246971377.git.ydirson@altern.org>
In-Reply-To: <cover.1246971377.git.ydirson@altern.org>
References: <cover.1246971377.git.ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122843>

- correctly link paragraphs within list items
- consistently format examples
- put option alernatives on separate lines
- always use [verse] for config items
- always indent 1st paragraph of a list item, with a tab

Signed-off-by: Yann Dirson <ydirson@altern.org>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |  208 +++++++++++++++++++++-----------------------
 1 files changed, 99 insertions(+), 109 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 2818bcc..3599e01 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -26,7 +26,6 @@ Subversion updated from git by the 'dcommit' command.
 
 COMMANDS
 --------
---
 
 'init'::
 	Initializes an empty git repository with additional
@@ -105,7 +104,7 @@ COMMANDS
 
 --parent;;
 	Fetch only from the SVN parent of the current HEAD.
-
++
 This doesn't interfere with interoperating with the Subversion
 repository you cloned from, but if you wish for your local Git
 repository to be able to interoperate with someone else's local Git
@@ -118,20 +117,28 @@ the same local timezone.
 	The '--ignore-paths' option should match for every 'fetch'
 	(including automatic fetches due to 'clone', 'dcommit',
 	'rebase', etc) on a given repository.
-
++
+[verse]
 config key: svn-remote.<name>.ignore-paths
-
-	If the ignore-paths config key is set and the command
-	line option is also given, both regular expressions
-	will be used.
-
++
+If the ignore-paths config key is set and the command line option is
+also given, both regular expressions will be used.
++
 Examples:
++
+--
+Skip "doc*" directory for every fetch;;
++
+------------------------------------------------------------------------
+--ignore-paths="^doc"
+------------------------------------------------------------------------
 
-	--ignore-paths="^doc" - skip "doc*" directory for every
-	    fetch.
-
-	--ignore-paths="^[^/]+/(?:branches|tags)" - skip
-	    "branches" and "tags" of first level directories.
+Skip "branches" and "tags" of first level directories;;
++
+------------------------------------------------------------------------
+--ignore-paths="^[^/]+/(?:branches|tags)"
+------------------------------------------------------------------------
+--
 
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
@@ -147,15 +154,15 @@ Examples:
 'rebase'::
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
-
++
 This works similarly to `svn update` or 'git pull' except that
 it preserves linear history with 'git rebase' instead of
 'git merge' for ease of dcommitting with 'git svn'.
-
++
 This accepts all options that 'git svn fetch' and 'git rebase'
 accept.  However, '--fetch-all' only fetches from the current
 [svn-remote], and not all [svn-remote] definitions.
-
++
 Like 'git rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
 
@@ -186,14 +193,13 @@ and have no uncommitted changes.
 	method (e.g. `svn://` or `http://` for anonymous read) to be
 	reused if a user is later given access to an alternate transport
 	method (e.g. `svn+ssh://` or `https://`) for commit.
-
++
+[verse]
 config key: svn-remote.<name>.commiturl
-
 config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
-
-	Using this option for any other purpose (don't ask)
-	is very strongly discouraged.
---
++
+Using this option for any other purpose (don't ask) is very strongly
+discouraged.
 
 'branch'::
 	Create a branch in the SVN repository.
@@ -235,7 +241,8 @@ The following features from `svn log' are supported:
 -r/--revision=<n>[:<n>];;
 	is supported, non-numeric args are not:
 	HEAD, NEXT, BASE, PREV, etc ...
--v/--verbose;;
+-v;;
+--verbose;;
 	it's not completely compatible with the --verbose
 	output in svn log, but reasonably close.
 --limit=<n>;;
@@ -274,7 +281,6 @@ Any other arguments are passed directly to 'git log'
 	changes that haven't been committed to SVN (including local
 	working-copy edits) are shown as revision 0.
 
---
 'find-rev'::
 	When given an SVN revision number of the form 'rN', returns the
 	corresponding git commit hash (this can optionally be followed by a
@@ -340,58 +346,56 @@ Any other arguments are passed directly to 'git log'
 	"checksum mismatch" (missed a modification).  If the problem
 	file cannot be ignored forever (with --ignore-paths) the only
 	way to repair the repo is to use 'reset'.
-
++
 Only the rev_map and refs/remotes/git-svn are changed.  Follow 'reset'
 with a 'fetch' and then 'git reset' or 'git rebase' to move local
 branches onto the new tree.
 
--r/--revision=<n>;;
+-r;;
+--revision=<n>;;
 	Specify the most recent revision to keep.  All later revisions
 	are discarded.
--p/--parent;;
+-p;;
+--parent;;
 	Discard the specified revision as well, keeping the nearest
 	parent instead.
 Example:;;
 Assume you have local changes in "master", but you need to refetch "r2".
-
++
 ------------
     r1---r2---r3 remotes/git-svn
                 \
                  A---B master
 ------------
-
++
 Fix the ignore-paths or SVN permissions problem that caused "r2" to
 be incomplete in the first place.  Then:
-
++
 [verse]
 git svn reset -r2 -p
 git svn fetch
-
++
 ------------
     r1---r2'--r3' remotes/git-svn
       \
        r2---r3---A---B master
 ------------
-
++
 Then fixup "master" with 'git rebase'.
 Do NOT use 'git merge' or your history will not be compatible with a
 future 'dcommit'!
-
++
 [verse]
 git rebase --onto remotes/git-svn A^ master
-
++
 ------------
     r1---r2'--r3' remotes/git-svn
                 \
                  A'--B' master
 ------------
 
-
---
-
 OPTIONS
 -------
---
 
 --shared[={false|true|umask|group|all|world|everybody}]::
 --template=<template_directory>::
@@ -400,85 +404,81 @@ OPTIONS
 
 -r <ARG>::
 --revision <ARG>::
-
-Used with the 'fetch' command.
-
+	   Used with the 'fetch' command.
++
 This allows revision ranges for partial/cauterized history
 to be supported.  $NUMBER, $NUMBER1:$NUMBER2 (numeric ranges),
 $NUMBER:HEAD, and BASE:$NUMBER are all supported.
-
++
 This can allow you to make partial mirrors when running fetch;
 but is generally not recommended because history will be skipped
 and lost.
 
 -::
 --stdin::
-
-Only used with the 'set-tree' command.
-
+	Only used with the 'set-tree' command.
++
 Read a list of commits from stdin and commit them in reverse
 order.  Only the leading sha1 is read from each line, so
 'git rev-list --pretty=oneline' output can be used.
 
 --rmdir::
-
-Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
-
+	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
++
 Remove directories from the SVN tree if there are no files left
 behind.  SVN can version empty directories, and they are not
 removed by default if there are no files left in them.  git
 cannot version empty directories.  Enabling this flag will make
 the commit to SVN act like git.
-
++
+[verse]
 config key: svn.rmdir
 
 -e::
 --edit::
-
-Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
-
+	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
++
 Edit the commit message before committing to SVN.  This is off by
 default for objects that are commits, and forced on when committing
 tree objects.
-
++
+[verse]
 config key: svn.edit
 
 -l<num>::
 --find-copies-harder::
-
-Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
-
+	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
++
 They are both passed directly to 'git diff-tree'; see
 linkgit:git-diff-tree[1] for more information.
-
++
 [verse]
 config key: svn.l
 config key: svn.findcopiesharder
 
 -A<filename>::
 --authors-file=<filename>::
-
-Syntax is compatible with the file used by 'git cvsimport':
-
+	Syntax is compatible with the file used by 'git cvsimport':
++
 ------------------------------------------------------------------------
 	loginname = Joe User <user@example.com>
 ------------------------------------------------------------------------
-
++
 If this option is specified and 'git svn' encounters an SVN
 committer name that does not exist in the authors-file, 'git svn'
 will abort operation. The user will then have to add the
 appropriate entry.  Re-running the previous 'git svn' command
 after the authors-file is modified should continue operation.
-
++
+[verse]
 config key: svn.authorsfile
 
 --authors-prog=<filename>::
-
-If this option is specified, for each SVN committer name that does not
-exist in the authors file, the given file is executed with the committer
-name as the first argument.  The program is expected to return a single
-line of the form "Name <email>", which will be treated as if included in
-the authors file.
+	If this option is specified, for each SVN committer name that
+	does not exist in the authors file, the given file is executed
+	with the committer name as the first argument.  The program is
+	expected to return a single line of the form "Name <email>",
+	which will be treated as if included in the authors file.
 
 -q::
 --quiet::
@@ -487,16 +487,15 @@ the authors file.
 
 --repack[=<n>]::
 --repack-flags=<flags>::
-
-These should help keep disk usage sane for large fetches
-with many revisions.
-
+	These should help keep disk usage sane for large fetches with
+	many revisions.
++
 --repack takes an optional argument for the number of revisions
 to fetch before repacking.  This defaults to repacking every
 1000 commits fetched if no argument is specified.
-
++
 --repack-flags are passed directly to 'git repack'.
-
++
 [verse]
 config key: svn.repack
 config key: svn.repackflags
@@ -505,41 +504,36 @@ config key: svn.repackflags
 --merge::
 -s<strategy>::
 --strategy=<strategy>::
-
-These are only used with the 'dcommit' and 'rebase' commands.
-
+	These are only used with the 'dcommit' and 'rebase' commands.
++
 Passed directly to 'git rebase' when using 'dcommit' if a
 'git reset' cannot be used (see 'dcommit').
 
 -n::
 --dry-run::
-
-This can be used with the 'dcommit', 'rebase', 'branch' and 'tag'
-commands.
-
+	This can be used with the 'dcommit', 'rebase', 'branch' and
+	'tag' commands.
++
 For 'dcommit', print out the series of git arguments that would show
 which diffs would be committed to SVN.
-
++
 For 'rebase', display the local branch associated with the upstream svn
 repository associated with the current branch and the URL of svn
 repository that will be fetched from.
-
++
 For 'branch' and 'tag', display the urls that will be used for copying when
 creating the branch or tag.
 
---
 
 ADVANCED OPTIONS
 ----------------
---
 
 -i<GIT_SVN_ID>::
 --id <GIT_SVN_ID>::
-
-This sets GIT_SVN_ID (instead of using the environment).  This
-allows the user to override the default refname to fetch from
-when tracking a single URL.  The 'log' and 'dcommit' commands
-no longer require this switch as an argument.
+	This sets GIT_SVN_ID (instead of using the environment).  This
+	allows the user to override the default refname to fetch from
+	when tracking a single URL.  The 'log' and 'dcommit' commands
+	no longer require this switch as an argument.
 
 -R<remote name>::
 --svn-remote <remote name>::
@@ -553,33 +547,30 @@ no longer require this switch as an argument.
 	started tracking a branch and never tracked the trunk it was
 	descended from. This feature is enabled by default, use
 	--no-follow-parent to disable it.
-
++
+[verse]
 config key: svn.followparent
 
---
 CONFIG FILE-ONLY OPTIONS
 ------------------------
---
 
 svn.noMetadata::
 svn-remote.<name>.noMetadata::
-
-This gets rid of the 'git-svn-id:' lines at the end of every commit.
-
+	This gets rid of the 'git-svn-id:' lines at the end of every commit.
++
 If you lose your .git/svn/git-svn/.rev_db file, 'git svn' will not
 be able to rebuild it and you won't be able to fetch again,
 either.  This is fine for one-shot imports.
-
++
 The 'git svn log' command will not work on repositories using
 this, either.  Using this conflicts with the 'useSvmProps'
 option for (hopefully) obvious reasons.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
-
-This allows 'git svn' to re-map repository URLs and UUIDs from
-mirrors created using SVN::Mirror (or svk) for metadata.
-
+	This allows 'git svn' to re-map repository URLs and UUIDs from
+	mirrors created using SVN::Mirror (or svk) for metadata.
++
 If an SVN revision has a property, "svm:headrev", it is likely
 that the revision was created by SVN::Mirror (also used by SVK).
 The property contains a repository UUID and a revision.  We want
@@ -602,14 +593,13 @@ svn-remote.<name>.rewriteRoot::
 	metadata so users of it will see the public URL.
 
 svn.brokenSymlinkWorkaround::
-This disables potentially expensive checks to workaround broken symlinks
-checked into SVN by broken clients.  Set this option to "false" if you
-track a SVN repository with many empty blobs that are not symlinks.
-This option may be changed while 'git svn' is running and take effect on
-the next revision fetched.  If unset, 'git svn' assumes this option to be
-"true".
-
---
+	This disables potentially expensive checks to workaround
+	broken symlinks checked into SVN by broken clients.  Set this
+	option to "false" if you track a SVN repository with many
+	empty blobs that are not symlinks.  This option may be changed
+	while 'git svn' is running and take effect on the next
+	revision fetched.  If unset, 'git svn' assumes this option to
+	be "true".
 
 Since the noMetadata, rewriteRoot, useSvnsyncProps and useSvmProps
 options all affect the metadata generated and used by 'git svn'; they
-- 
1.6.3.3
