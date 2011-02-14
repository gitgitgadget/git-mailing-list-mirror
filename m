From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 23:32:39 +0100
Message-ID: <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:35:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp70W-0002hB-Mj
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab1BNWez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:34:55 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62141 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1BNWey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:34:54 -0500
Received: by vxb37 with SMTP id 37so3004936vxb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=CuEHUYvUVufeHsSZCxT3FE3vuovMbSLmQY2GW2LC5HM=;
        b=eWO9zTevzTPclN+Wuf1l8bL+sjpl385rdW0J9YONTxF+1dYfiI51BqK6QU4YWP9SI5
         5womMMswZKRe+XT3U9LBC2RCLdytQOLnIzJDzMqz4aP+YYJM/VWKrbN1kRvufsKuxzey
         pO5gJLNRZo3q9ENUyX2Js+P+9Hl7lPSRhMs1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=qf2w342Dp0tXa7DwVo40xBMIZLfc+YWDfSwWkYP4skJO5TT+C8az7UI3xZ2qYAqOQ3
         bIafyaJiy3KexVg31mG9uNkHDBs7OT2W0Yey50a7BiceqQIPVhUn5fpCZMk7B4kp4EbJ
         XVLv7EetMwFF43msLozOVIVA4qW80KxlgPpGY=
Received: by 10.220.182.199 with SMTP id cd7mr1742966vcb.176.1297722759707;
 Mon, 14 Feb 2011 14:32:39 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Mon, 14 Feb 2011 14:32:39 -0800 (PST)
In-Reply-To: <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: cDwB3pUiDxlRfNfy3Jhh0lqWfqY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166786>

On Sun, Feb 13, 2011 at 11:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
[...]

Thanks for the explanation.

My point is:
1. using multiple terms is confusing
2. using not descriptive terms is confusing (or at least increases learning
   curve)

Ideally only one should be used - the rest should be obsoleted/hidden from
end user.

Example from git-status:

   - 'git status' outputs <<use "git reset HEAD <file>..." to unstage>>
     But in the man page there is nothing about staging!

   - the output does not mention "index" at all - only files tracked,
     untracked, to be committed

   - man page talks about index or index file exclusively, e.g.:
     "differences between the index file and the current HEAD commit",
     "updated in index", "added to index"


In other places "index" is called "staging area" and act of updating the index
is called "staging in the index".

I ask: why do we need the "index" term at all?

   - instead of "index" use "staging" and "staging area"
   - instead of "listed in index" use "staged" or "tracked"

What is used internally is one thing, but what the end user (not git developer)
sees does not have to be related.

(I'm not sure about the "tracked vs staged" - maybe we should again get rid of
one of them, at least in some cases.)

In fact it's not that important how it is called, as long as it meets the
points from the beginning of the mail.


As you can see I'm advocating for the use of the "staging" term after all.
I'm new to git and a non-native English speaker. "Staging" seems most clear of
all of the terms. You may find it differently, but please take into
consideration that you are accustomed to it.

"Staging" gives me the feeling of changing states - from working tree to
real commit - which I believe is the purpose of it.


"Caching" means something used e.g. to improve performance. You can read the
cache, update it using original item - but the cache is just a function of the
original content.

Probably most common place when users meet "cache" is browser cache. You
clear the cache, you set the limit of cache size, but you don't expect it to
be important. Definitely unlike "cache" in git.


I didn't like the "index" at all. At first I could not understand why did you
have chosen such name. Additionally in many places it's called "index file".
It increased the confusion - why would I care if it's a file or not?

Now I see you can understand it as indexing files that should be managed by git,
or indexing changes to be introduced. But I still like  "staging" better.


I've updated docs for several basic commands to see how would it feel to have
"staging" area instead of "index file" - and it's not bad IMO. It was basically
automatic search&replace, so the result can be improved.



-- 8< --
From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Date: Mon, 14 Feb 2011 23:20:07 +0100
Subject: [PATCH] Changed index term to staging area

---
 Documentation/git-add.txt    |   66 +++++++++++++++++++++---------------------
 Documentation/git-apply.txt  |   40 ++++++++++++------------
 Documentation/git-commit.txt |   14 ++++----
 Documentation/git-diff.txt   |   22 +++++++-------
 Documentation/git-status.txt |   22 +++++++-------
 5 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index a03448f..54a50b7 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -3,7 +3,7 @@ git-add(1)

 NAME
 ----
-git-add - Add file contents to the index
+git-add - Add file contents to the staging area

 SYNOPSIS
 --------
@@ -15,23 +15,23 @@ SYNOPSIS

 DESCRIPTION
 -----------
-This command updates the index using the current content found in
+This command updates the staging area using the current content found in
 the working tree, to prepare the content staged for the next commit.
 It typically adds the current content of existing paths as a whole,
 but with some options it can also be used to add content with
 only part of the changes made to the working tree files applied, or
 remove paths that do not exist in the working tree anymore.

-The "index" holds a snapshot of the content of the working tree, and it
+The "staging area" holds a snapshot of the content of the working tree, and it
 is this snapshot that is taken as the contents of the next commit.  Thus
 after making any changes to the working directory, and before running
 the commit command, you must use the `add` command to add any new or
-modified files to the index.
+modified files to the staging area.

 This command can be performed multiple times before a commit.  It only
 adds the content of the specified file(s) at the time the add command is
 run; if you want subsequent changes included in the next commit, then
-you must run `git add` again to add the new content to the index.
+you must run `git add` again to add the new content to the staging area.

 The `git status` command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
@@ -72,39 +72,39 @@ OPTIONS
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
 See ``Interactive mode'' for details.

 -e, \--edit::
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
 	Only match <filepattern> against already tracked files in
-	the index rather than the working tree. That means that it
+	the staging area rather than the working tree. That means that it
 	will never stage new files, but that it will stage modified
 	new contents of tracked files and that it will remove files
-	from the index if the corresponding files in the working tree
+	from the staging area if the corresponding files in the working tree
 	have been removed.
 +
 If no <filepattern> is given, default to "."; in other words,
@@ -114,21 +114,21 @@ subdirectories.
 -A::
 --all::
 	Like `-u`, but match <filepattern> against files in the
-	working tree in addition to the index. That means that it
+	working tree in addition to the staging area. That means that it
 	will find new files as well as staging modified content and
 	removing files that are no longer in the working tree.

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
 	If some files could not be added because of errors indexing
@@ -205,8 +205,8 @@ The main command loop has 6 subcommands (plus help
and quit).

 status::

-   This shows the change between HEAD and index (i.e. what will be
-   committed if you say `git commit`), and between index and
+   This shows the change between HEAD and staging area (i.e. what will be
+   committed if you say `git commit`), and between staging area and
    working tree files (i.e. what you could stage further before
    `git commit` using `git add`) for each path.  A sample output
    looks like this:
@@ -219,11 +219,11 @@ status::
 +
 It shows that foo.png has differences from HEAD (but that is
 binary so line count cannot be shown) and there is no
-difference between indexed copy and the working tree
+difference between staged copy and the working tree
 version (if the working tree version were also different,
 'binary' would have been shown in place of 'nothing').  The
 other file, git-add{litdd}interactive.perl, has 403 lines added
-and 35 lines deleted if you commit what is in the index, but
+and 35 lines deleted if you commit what is in the staging area, but
 working tree file has further modifications (one addition and
 one deletion).

@@ -254,7 +254,7 @@ Update>> -2
 ------------
 +
 After making the selection, answer with an empty line to stage the
-contents of working tree files for selected paths in the index.
+contents of working tree files for selected paths in the staging area.

 revert::

@@ -265,12 +265,12 @@ revert::
 add untracked::

   This has a very similar UI to 'update' and
-  'revert', and lets you add untracked paths to the index.
+  'revert', and lets you add untracked paths to the staging area.

 patch::

   This lets you choose one path out of a 'status' like selection.
-  After choosing the path, it presents the diff between the index
+  After choosing the path, it presents the diff between the staging area
   and the working tree file and asks you if you want to stage
   the change of each hunk.  You can say:

@@ -290,12 +290,12 @@ patch::
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
-that was chosen, the index is updated with the selected hunks.
+that was chosen, the staging area is updated with the selected hunks.

 diff::

   This lets you review what will be committed (i.e. between
-  HEAD and index).
+  HEAD and staging area).


 EDITING PATCHES
@@ -303,10 +303,10 @@ EDITING PATCHES

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

@@ -327,13 +327,13 @@ Modified content is represented by "-" lines
(removing the old content)
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

@@ -342,7 +342,7 @@ Avoid using these constructs, or do so with extreme caution.
 --
 removing untouched content::

-Content which does not differ between the index and working tree may be
+Content which does not differ between the staging area and working tree may be
 shown on context lines, beginning with a " " (space).  You can stage
 context lines for removal by converting the space to a "-". The
 resulting working tree file will appear to re-add the content.
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 881652f..9b5a037 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -3,16 +3,16 @@ git-apply(1)

 NAME
 ----
-git-apply - Apply a patch to files and/or to the index
+git-apply - Apply a patch to files and/or to the staging area


 SYNOPSIS
 --------
 [verse]
-'git apply' [--stat] [--numstat] [--summary] [--check] [--index]
+'git apply' [--stat] [--numstat] [--summary] [--check] [--staged]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
-	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
+	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--staged-only]
 	  [--ignore-space-change | --ignore-whitespace ]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
@@ -21,8 +21,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Reads the supplied diff output (i.e. "a patch") and applies it to files.
-With the `--index` option the patch is also applied to the index, and
-with the `--cache` option the patch is only applied to the index.
+With the `--staged` option the patch is also applied to the staging area, and
+with the `--staged-only` option the patch is only applied to the staging area.
 Without these options, the command applies the patch only to files,
 and does not require them to be in a git repository.

@@ -55,32 +55,32 @@ OPTIONS

 --check::
 	Instead of applying the patch, see if the patch is
-	applicable to the current working tree and/or the index
-	file and detects errors.  Turns off "apply".
+	applicable to the current working tree and/or the staging
+	area and detects errors.  Turns off "apply".

---index::
+--staged::
 	When `--check` is in effect, or when applying the patch
 	(which is the default when none of the options that
 	disables it is in effect), make sure the patch is
-	applicable to what the current index file records.  If
+	applicable to what the current staging area records.  If
 	the file to be patched in the working tree is not
 	up-to-date, it is flagged as an error.  This flag also
-	causes the index file to be updated.
+	causes the staging area to be updated.

---cached::
+--staged-only::
 	Apply a patch without touching the working tree. Instead take the
-	cached data, apply the patch, and store the result in the index
-	without using the working tree. This implies `--index`.
+	sttaged data, apply the patch, and store the result in the staging area
+	without using the working tree. This implies `--staged`.

 --build-fake-ancestor=<file>::
-	Newer 'git diff' output has embedded 'index information'
+	Newer 'git diff' output has embedded 'staging area information'
 	for each blob to help identify the original version that
 	the patch applies to.  When this flag is given, and if
 	the original versions of the blobs are available locally,
-	builds a temporary index containing those blobs.
+	builds a temporary staging area containing those blobs.
 +
-When a pure mode change is encountered (which has no index information),
-the information is read from the current index instead.
+When a pure mode change is encountered (which has no staging area information),
+the information is read from the current staging area instead.

 -R::
 --reverse::
@@ -236,13 +236,13 @@ Submodules
 If the patch contains any changes to submodules then 'git apply'
 treats these changes as follows.

-If `--index` is specified (explicitly or implicitly), then the submodule
-commits must match the index exactly for the patch to apply.  If any
+If `--staged` is specified (explicitly or implicitly), then the submodule
+commits must match the staging area exactly for the patch to apply.  If any
 of the submodules are checked-out, then these check-outs are completely
 ignored, i.e., they are not required to be up-to-date or clean and they
 are not updated.

-If `--index` is not specified, then the submodule commits in the patch
+If `--staged` is not specified, then the submodule commits in the patch
 are ignored and only the absence or presence of the corresponding
 subdirectory is checked and (if possible) updated.

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b586c0f..728b2cf 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -16,26 +16,26 @@ SYNOPSIS

 DESCRIPTION
 -----------
-Stores the current contents of the index in a new commit along
+Stores the current contents of the staging area in a new commit along
 with a log message from the user describing the changes.

 The content to be added can be specified in several ways:

 1. by using 'git add' to incrementally "add" changes to the
-   index before using the 'commit' command (Note: even modified
+   staging area before using the 'commit' command (Note: even modified
    files must be "added");

 2. by using 'git rm' to remove files from the working tree
-   and the index, again before using the 'commit' command;
+   and the staging area, again before using the 'commit' command;

 3. by listing files as arguments to the 'commit' command, in which
-   case the commit will ignore changes staged in the index, and instead
+   case the commit will ignore changes staged in the staging area, and instead
    record the current content of the listed files (which must already
    be known to git);

 4. by using the -a switch with the 'commit' command to automatically
    "add" changes from all known files (i.e. all files that are already
-   listed in the index) and to automatically "rm" files in the index
+   tracked) and to automatically "rm" tracked files
    that have been removed from the working tree, and then perform the
    actual commit;

@@ -273,8 +273,8 @@ EXAMPLES
 --------
 When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
-called the "index" with 'git add'.  A file can be
-reverted back, only in the index but not in the working tree,
+ with 'git add'.  A file can be
+reverted back, only in the staging area but not in the working tree,
 to that of the last commit with `git reset HEAD -- <file>`,
 which effectively reverts 'git add' and prevents the changes to
 this file from participating in the next commit.  After building
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 4910510..eab118a 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -10,29 +10,29 @@ SYNOPSIS
 --------
 [verse]
 'git diff' [options] [<commit>] [--] [<path>...]
-'git diff' [options] --cached [<commit>] [--] [<path>...]
+'git diff' [options] --staged [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
-'git diff' [options] [--no-index] [--] <path> <path>
+'git diff' [options] [--not-staged] [--] <path> <path>

 DESCRIPTION
 -----------
-Show changes between the working tree and the index or a tree, changes
-between the index and a tree, changes between two trees, or changes
+Show changes between the working tree and the staging area or a tree, changes
+between the staging area and a tree, changes between two trees, or changes
 between two files on disk.

 'git diff' [--options] [--] [<path>...]::

 	This form is to view the changes you made relative to
-	the index (staging area for the next commit).  In other
+	the staging area for the next commit.  In other
 	words, the differences are what you _could_ tell git to
-	further add to the index but you still haven't.  You can
+	further add to the staging area but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 +
 If exactly two paths are given and at least one points outside
 the current repository, 'git diff' will compare the two files /
-directories. This behavior can be forced by --no-index.
+directories. This behavior can be forced by --not-staged.

-'git diff' [--options] --cached [<commit>] [--] [<path>...]::
+'git diff' [--options] --staged [<commit>] [--] [<path>...]::

 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -40,7 +40,7 @@ directories. This behavior can be forced by --no-index.
 	do not give <commit>, it defaults to HEAD.
 	If HEAD does not exist (e.g. unborned branches) and
 	<commit> is not given, it shows all staged changes.
-	--staged is a synonym of --cached.
+	--cached is a synonym of --staged, will be removed in version 2.0
(or whatever).

 'git diff' [--options] <commit> [--] [<path>...]::

@@ -102,12 +102,12 @@ Various ways to check your working tree::
 +
 ------------
 $ git diff            <1>
-$ git diff --cached   <2>
+$ git diff --staged   <2>
 $ git diff HEAD       <3>
 ------------
 +
 <1> Changes in the working tree not yet staged for the next commit.
-<2> Changes between the index and your last commit; what you
+<2> Changes between the staging area and your last commit; what you
 would be committing if you run "git commit" without "-a" option.
 <3> Changes in the working tree since your last commit; what you
 would be committing if you run "git commit -a"
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index dae190a..65aa798 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -12,9 +12,9 @@ SYNOPSIS

 DESCRIPTION
 -----------
-Displays paths that have differences between the index file and the
+Displays paths that have differences between the staging area and the
 current HEAD commit, paths that have differences between the working
-tree and the index file, and paths in the working tree that are not
+tree and the staging area, and paths in the working tree that are not
 tracked by git (and are not ignored by linkgit:gitignore[5]). The first
 are what you _would_ commit by running `git commit`; the second and
 third are what you _could_ commit by running 'git add' before running
@@ -91,7 +91,7 @@ In short-format, the status of each path is shown as

 where `PATH1` is the path in the `HEAD`, and ` -> PATH2` part is
 shown only when `PATH1` corresponds to a different path in the
-index/worktree (i.e. the file is renamed). The 'XY' is a two-letter
+staging area/worktree (i.e. the file is renamed). The 'XY' is a two-letter
 status code.

 The fields (including the `->`) are separated from each other by a
@@ -102,7 +102,7 @@ interior special characters backslash-escaped.

 For paths with merge conflicts, `X` and 'Y' show the modification
 states of each side of the merge. For paths that do not have merge
-conflicts, `X` shows the status of the index, and `Y` shows the status
+conflicts, `X` shows the status of the staging area, and `Y` shows the status
 of the work tree.  For untracked paths, `XY` are `??`.  Other status
 codes can be interpreted as follows:

@@ -119,13 +119,13 @@ Ignored files are not listed.
     X          Y     Meaning
     -------------------------------------------------
               [MD]   not updated
-    M        [ MD]   updated in index
-    A        [ MD]   added to index
-    D         [ M]   deleted from index
-    R        [ MD]   renamed in index
-    C        [ MD]   copied in index
-    [MARC]           index and work tree matches
-    [ MARC]     M    work tree changed since index
+    M        [ MD]   updated in staging area
+    A        [ MD]   added to staging area
+    D         [ M]   deleted from staging area
+    R        [ MD]   renamed in staging area
+    C        [ MD]   copied in staging area
+    [MARC]           staging area and work tree matches
+    [ MARC]     M    work tree changed since staging area
     [ MARC]     D    deleted in work tree
     -------------------------------------------------
     D           D    unmerged, both deleted
-- 
1.7.4.1.26.g00e6e
