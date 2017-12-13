Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1CD1F406
	for <e@80x24.org>; Wed, 13 Dec 2017 02:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbdLMCeE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 12 Dec 2017 21:34:04 -0500
Received: from aibo.runbox.com ([91.220.196.211]:42498 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbdLMCcv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 21:32:51 -0500
Received: from [10.9.9.127] (helo=rmmprod05.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <dwheeler@dwheeler.com>)
        id 1eOwqn-00073b-Pd
        for git@vger.kernel.org; Wed, 13 Dec 2017 03:32:49 +0100
Received: from mail by rmmprod05.runbox with local (Exim 4.86_2)
        (envelope-from <dwheeler@dwheeler.com>)
        id 1eOwqn-0005Bd-OB
        for git@vger.kernel.org; Wed, 13 Dec 2017 03:32:49 +0100
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Received: from [Authenticated user (258406)] by runbox.com with http
 (RMM6); for <git@vger.kernel.org>; Wed, 13 Dec 2017 02:32:49 GMT
From:   "David A. Wheeler" <dwheeler@dwheeler.com>
To:     "git" <git@vger.kernel.org>
Subject: [PATCH] doc: Modify git-add doc to say "staging area"
Date:   Tue, 12 Dec 2017 21:32:49 -0500 (EST)
X-Mailer: RMM6
Message-Id: <E1eOwqn-0005Bd-OB@rmmprod05.runbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation of git-add so that it consistently uses
the phrase "staging area".  The current git documentation uses
inconsistent terminology ("index", "cache", and "staging area").
This commit switches git-add's documentation to consistently use
the phrase "staging area", which is higher-level and should be less
confusing for new users.

Signed-off-by: David A. Wheeler <dwheeler@dwheeler.com>
---
 Documentation/git-add.txt | 104 ++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 50 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index d50fa339d..927a152b0 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -3,7 +3,7 @@ git-add(1)
 
 NAME
 ----
-git-add - Add file contents to the index
+git-add - Add file contents to the staging area
 
 SYNOPSIS
 --------
@@ -15,23 +15,24 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This command updates the index using the current content found in
-the working tree, to prepare the content staged for the next commit.
-It typically adds the current content of existing paths as a whole,
+This command updates the staging area using the current content found
+in the working tree.
+This command typically adds the current content of existing paths as a whole,
 but with some options it can also be used to add content with
 only part of the changes made to the working tree files applied, or
 remove paths that do not exist in the working tree anymore.
 
-The "index" holds a snapshot of the content of the working tree, and it
-is this snapshot that is taken as the contents of the next commit.  Thus
-after making any changes to the working tree, and before running
-the commit command, you must use the `add` command to add any new or
-modified files to the index.
+The staging area (historically called the "index" or "cache")
+holds a snapshot of the content of the working tree, and it
+is this snapshot that is taken by default as the contents of the next commit.
+Thus after making any changes to the working tree, and before running
+the commit command, you can use the `add` command to add any new or
+modified files to the staging area.
 
 This command can be performed multiple times before a commit.  It only
 adds the content of the specified file(s) at the time the add command is
 run; if you want subsequent changes included in the next commit, then
-you must run `git add` again to add the new content to the index.
+you must run `git add` again to add the new content to the staging area.
 
 The `git status` command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
@@ -45,7 +46,9 @@ be used to add ignored files with the `-f` (force) option.
 
 Please see linkgit:git-commit[1] for alternative ways to add content to a
 commit.
-
+For example, you can use the git commit `-a` option to first automatically
+add to the staging area all the files that have been have been
+modified or deleted in the working tree.
 
 OPTIONS
 -------
@@ -53,7 +56,7 @@ OPTIONS
 	Files to add content from.  Fileglobs (e.g. `*.c`) can
 	be given to add all matching files.  Also a
 	leading directory name (e.g. `dir` to add `dir/file1`
-	and `dir/file2`) can be given to update the index to
+	and `dir/file2`) can be given to update the staging area to
 	match the current state of the directory as a whole (e.g.
 	specifying `dir` will record not just a file `dir/file1`
 	modified in the working tree, a file `dir/file2` added to
@@ -81,16 +84,16 @@ in linkgit:gitglossary[7].
 -i::
 --interactive::
 	Add modified contents in the working tree interactively to
-	the index. Optional path arguments may be supplied to limit
+	the staging area. Optional path arguments may be supplied to limit
 	operation to a subset of the working tree. See ``Interactive
 	mode'' for details.
 
 -p::
 --patch::
-	Interactively choose hunks of patch between the index and the
-	work tree and add them to the index. This gives the user a chance
+	Interactively choose hunks of patch between the staging area and the
+	work tree and add them to the staging area. This gives the user a chance
 	to review the difference before adding modified contents to the
-	index.
+	staging area.
 +
 This effectively runs `add --interactive`, but bypasses the
 initial command menu and directly jumps to the `patch` subcommand.
@@ -98,20 +101,20 @@ See ``Interactive mode'' for details.
 
 -e::
 --edit::
-	Open the diff vs. the index in an editor and let the user
+	Open the diff vs. the staging area in an editor and let the user
 	edit it.  After the editor was closed, adjust the hunk headers
-	and apply the patch to the index.
+	and apply the patch to the staging area.
 +
 The intent of this option is to pick and choose lines of the patch to
 apply, or even to modify the contents of lines to be staged. This can be
 quicker and more flexible than using the interactive hunk selector.
 However, it is easy to confuse oneself and create a patch that does not
-apply to the index. See EDITING PATCHES below.
+apply to the staging area. See EDITING PATCHES below.
 
 -u::
 --update::
-	Update the index just where it already has an entry matching
-	<pathspec>.  This removes as well as modifies index entries to
+	Update the staging area just where it already has an entry matching
+	<pathspec>.  This removes as well as modifies staging area entries to
 	match the working tree, but adds no new files.
 +
 If no <pathspec> is given when `-u` option is used, all
@@ -122,9 +125,9 @@ subdirectories).
 -A::
 --all::
 --no-ignore-removal::
-	Update the index not only where the working tree has a file
-	matching <pathspec> but also where the index already has an
-	entry.	This adds, modifies, and removes index entries to
+	Update the staging area not only where the working tree has a file
+	matching <pathspec> but also where the staging area already has an
+	entry.	This adds, modifies, and removes staging area entries to
 	match the working tree.
 +
 If no <pathspec> is given when `-A` option is used, all
@@ -134,8 +137,8 @@ subdirectories).
 
 --no-all::
 --ignore-removal::
-	Update the index by adding new files that are unknown to the
-	index and files modified in the working tree, but ignore
+	Update the staging area by adding new files that are not in the
+	staging area and files modified in the working tree, but ignore
 	files that have been removed from the working tree.  This
 	option is a no-op when no <pathspec> is used.
 +
@@ -146,18 +149,19 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 -N::
 --intent-to-add::
 	Record only the fact that the path will be added later. An entry
-	for the path is placed in the index with no content. This is
+	for the path is placed in the staging area with no content. This is
 	useful for, among other things, showing the unstaged content of
 	such files with `git diff` and committing them with `git commit
 	-a`.
 
 --refresh::
 	Don't add the file(s), but only refresh their stat()
-	information in the index.
+	information in the staging area.
 
 --ignore-errors::
-	If some files could not be added because of errors indexing
-	them, do not abort the operation, but continue adding the
+	If some files could not be added because of errors adding them
+        to the staging area,
+	do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
 	The configuration variable `add.ignoreErrors` can be set to
 	true to make this the default behaviour.
@@ -170,21 +174,21 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 
 --no-warn-embedded-repo::
 	By default, `git add` will warn when adding an embedded
-	repository to the index without using `git submodule add` to
+	repository to the staging area without using `git submodule add` to
 	create an entry in `.gitmodules`. This option will suppress the
 	warning (e.g., if you are manually performing operations on
 	submodules).
 
 --renormalize::
 	Apply the "clean" process freshly to all tracked files to
-	forcibly add them again to the index.  This is useful after
+	forcibly add them again to the staging area.  This is useful after
 	changing `core.autocrlf` configuration or the `text` attribute
 	in order to correct files added with wrong CRLF/LF line endings.
 	This option implies `-u`.
 
 --chmod=(+|-)x::
 	Override the executable bit of the added files.  The executable
-	bit is only changed in the index, the files on disk are left
+	bit is only changed in the staging area, the files on disk are left
 	unchanged.
 
 \--::
@@ -251,8 +255,8 @@ The main command loop has 6 subcommands (plus help and quit).
 
 status::
 
-   This shows the change between HEAD and index (i.e. what will be
-   committed if you say `git commit`), and between index and
+   This shows the change between HEAD and staging area (i.e. what will be
+   committed if you say `git commit`), and between staging area and
    working tree files (i.e. what you could stage further before
    `git commit` using `git add`) for each path.  A sample output
    looks like this:
@@ -265,11 +269,11 @@ status::
 +
 It shows that foo.png has differences from HEAD (but that is
 binary so line count cannot be shown) and there is no
-difference between indexed copy and the working tree
-version (if the working tree version were also different,
+difference between the versions in the staging area and the working tree
+(if the working tree version were also different,
 'binary' would have been shown in place of 'nothing').  The
 other file, git-add{litdd}interactive.perl, has 403 lines added
-and 35 lines deleted if you commit what is in the index, but
+and 35 lines deleted if you commit what is in the staging area, but
 working tree file has further modifications (one addition and
 one deletion).
 
@@ -300,7 +304,7 @@ Update>> -2
 ------------
 +
 After making the selection, answer with an empty line to stage the
-contents of working tree files for selected paths in the index.
+contents of working tree files for selected paths in the staging area.
 
 revert::
 
@@ -311,12 +315,12 @@ revert::
 add untracked::
 
   This has a very similar UI to 'update' and
-  'revert', and lets you add untracked paths to the index.
+  'revert', and lets you add untracked paths to the staging area.
 
 patch::
 
   This lets you choose one path out of a 'status' like selection.
-  After choosing the path, it presents the diff between the index
+  After choosing the path, it presents the diff between the staging area
   and the working tree file and asks you if you want to stage
   the change of each hunk.  You can select one of the following
   options and type return:
@@ -337,7 +341,7 @@ patch::
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
-that was chosen, the index is updated with the selected hunks.
+that was chosen, the staging area is updated with the selected hunks.
 +
 You can omit having to type return here, by setting the configuration
 variable `interactive.singleKey` to `true`.
@@ -345,7 +349,7 @@ variable `interactive.singleKey` to `true`.
 diff::
 
   This lets you review what will be committed (i.e. between
-  HEAD and index).
+  HEAD and staging area).
 
 
 EDITING PATCHES
@@ -353,10 +357,10 @@ EDITING PATCHES
 
 Invoking `git add -e` or selecting `e` from the interactive hunk
 selector will open a patch in your editor; after the editor exits, the
-result is applied to the index. You are free to make arbitrary changes
+result is applied to the staging area. You are free to make arbitrary changes
 to the patch, but note that some changes may have confusing results, or
 even result in a patch that cannot be applied.  If you want to abort the
-operation entirely (i.e., stage nothing new in the index), simply delete
+operation entirely (i.e., stage nothing new in the staging area), simply delete
 all lines of the patch. The list below describes some common things you
 may see in a patch, and which editing operations make sense on them.
 
@@ -377,13 +381,13 @@ Modified content is represented by "-" lines (removing the old content)
 followed by "{plus}" lines (adding the replacement content). You can
 prevent staging the modification by converting "-" lines to " ", and
 removing "{plus}" lines. Beware that modifying only half of the pair is
-likely to introduce confusing changes to the index.
+likely to introduce confusing changes to the staging area.
 --
 
 There are also more complex operations that can be performed. But beware
-that because the patch is applied only to the index and not the working
-tree, the working tree will appear to "undo" the change in the index.
-For example, introducing a new line into the index that is in neither
+that because the patch is applied only to the staging area and not the working
+tree, the working tree will appear to "undo" the change in the staging area.
+For example, introducing a new line into the staging area that is in neither
 the HEAD nor the working tree will stage the new line for commit, but
 the line will appear to be reverted in the working tree.
 
@@ -392,7 +396,7 @@ Avoid using these constructs, or do so with extreme caution.
 --
 removing untouched content::
 
-Content which does not differ between the index and working tree may be
+Content which does not differ between the staging area and working tree may be
 shown on context lines, beginning with a " " (space).  You can stage
 context lines for removal by converting the space to a "-". The
 resulting working tree file will appear to re-add the content.
-- 
2.15.1


