Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041C020248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDKNMg (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:12:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35775 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKNMg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:12:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so3457641pfh.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xC6+vy/KjSZjQUGWAcsWM/BOX6d276GWCYSmV+UIxx4=;
        b=vAyEMm7P7Z3lXUbf5OwZHe3Wx8M3Yjxq7TJ+iKI6STzjCks25hZPcQ+Vhlo/KwZScR
         zj9nei4HJvwj/oM8bJwygic9VGakwzZwtxSL0UW+XA6MCZyfb2VMFBRyxFv19DsEVhhO
         oSO3aVpVRKr/WkNoCRPL2NP3VEGe3dcW6FoaNBdtlQ2cj16PJh7MmRv0Oj5u01sDXFhZ
         rJCOqSMLP9WU0AlDCA03nlIT2d69feFYK/mXAbhk6v+VXoFUicL/f2LXDWFcSFd2VHw1
         q/CHypNvl5JSQRtN3BtwoQEZkMC4w4WSLTnvFwHVN/EVG6X4YPI2JEtFwFsiSkBAYjAN
         V0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xC6+vy/KjSZjQUGWAcsWM/BOX6d276GWCYSmV+UIxx4=;
        b=KpXwPfE1WyEAY+Zu3NkDUaHC3ncr4cC1FcFCdfYMl+opc6RccOSMgezs/k09RhUQ8W
         JZ1PK5WGDr0IkyzvpDURVz0iIDrbzZwRe+CzQDqmJ2LMlnY3ZazyZDJUIMGMOXp7lMwd
         9kGFMEod7WGnkFacCARQuSgn/Jh9Si3h22c9w9piU9nAgBC30LcmLohyAPZKscL7S9pm
         kmsoXuh01+nKEau/qMUb4xNRvChXslc3V7hciCVZqTRurTdsGLVvKnGrfxcSe0Hy+Zge
         X4l6GDnvCUg2KDA0+aQiuRWQ5K1HDgXUBkRdKEBtLv7LMuAUaTU1GxZ3/b9WxrphFQQe
         arGw==
X-Gm-Message-State: APjAAAXVXl8zySFfVmDaFPRBshvKFA7fhBxR8HG/NI+OKl+WN8Gkggx3
        0e6RUN8KFAKanlAblDrsEfo=
X-Google-Smtp-Source: APXvYqyF3HdXHSDG0ZBVGdzqW/dD3hbjyLFelKViGNqoS4Y3IUYbdK4uKhit/dYIVegemewA0PmVuA==
X-Received: by 2002:a63:4a5a:: with SMTP id j26mr46950930pgl.361.1554988354186;
        Thu, 11 Apr 2019 06:12:34 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id h71sm7877032pge.49.2019.04.11.06.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:12:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:12:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 00/16] Add new command 'restore'
Date:   Thu, 11 Apr 2019 20:12:02 +0700
Message-Id: <20190411131218.19195-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the companion of "git switch" and is based on that topic.
This command peforms the "checkout paths" from git-checkout, git-reset
and also has a third mode to reset only worktree, leaving the index
alone.

For new people not aware of previous discussions, this command is
supposed to be a friendlier replacement for "git checkout" and
hopefully fixes some warts that have grown over the time in
git-checkout. For this reason, the last patch starts to recommend "git
restore" everywhere.

v2 should address all the comments from v1. I still haven't done that
--intent-to-add thing yet even though I'd like to make it default
behavior too. Anyway changes are

- --index is renamed to --staged to avoid conflict with --index from
  git-apply, which has different meaning.

- lots of document fixes. The comparison between restore/revert/reset
  is added in git.txt instead. I want to avoid duplicate the same
  thing on three man pages.

- --force is dropped. --ignore-unmerged takes its place.

- --recurse-submodules is dropped. I've concluded that restoring files
  across submodule boundary is not exactly supported yet. Let's leave it
  for later.

- git-rm learns about --staged as an alias of --cached (in fact it's
  more the other way around). This is to keep suggestions consistent
  because we tell people to do "git foo --staged" everywhere.

- git-reset and git-diff are moved to other groups in "git help"
  output.

Nguyễn Thái Ngọc Duy (16):
  checkout: split part of it to new command 'restore'
  restore: take tree-ish from --source option instead
  restore: make pathspec mandatory
  restore: disable overlay mode by default
  checkout: factor out worktree checkout code
  restore: add --worktree and --staged
  restore: reject invalid combinations with --staged
  restore: default to --source=HEAD when only --staged is specified
  restore: replace --force with --ignore-unmerged
  restore: support --patch
  t: add tests for restore
  completion: support restore
  user-manual.txt: prefer 'merge --abort' over 'reset --hard'
  doc: promote "git restore"
  rm: add --staged as alias for --cached
  help: move git-diff and git-reset to different groups

 .gitignore                             |   1 +
 Documentation/config/interactive.txt   |   3 +-
 Documentation/git-checkout.txt         |   3 +-
 Documentation/git-clean.txt            |   2 +-
 Documentation/git-commit.txt           |   2 +-
 Documentation/git-format-patch.txt     |   2 +-
 Documentation/git-reset.txt            |  13 +-
 Documentation/git-restore.txt (new)    | 183 +++++++++++++++
 Documentation/git-revert.txt           |   7 +-
 Documentation/git-rm.txt               |   7 +-
 Documentation/git.txt                  |  20 ++
 Documentation/gitcli.txt               |   4 +-
 Documentation/giteveryday.txt          |   5 +-
 Documentation/gittutorial-2.txt        |   4 +-
 Documentation/gittutorial.txt          |   2 +-
 Documentation/user-manual.txt          |  14 +-
 Makefile                               |   1 +
 builtin.h                              |   1 +
 builtin/checkout.c                     | 299 +++++++++++++++++++------
 builtin/clone.c                        |   2 +-
 builtin/commit.c                       |   2 +-
 builtin/rm.c                           |   7 +-
 command-list.txt                       |   7 +-
 contrib/completion/git-completion.bash |  15 ++
 git-add--interactive.perl              |  52 +++++
 git.c                                  |   1 +
 t/lib-patch-mode.sh                    |  12 +
 t/t2070-restore.sh (new +x)            |  99 ++++++++
 t/t2071-restore-patch.sh (new +x)      | 110 +++++++++
 t/t3600-rm.sh                          |   6 +-
 t/t7508-status.sh                      |  84 +++----
 t/t7512-status-help.sh                 |  20 +-
 wt-status.c                            |  30 ++-
 33 files changed, 848 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/git-restore.txt
 create mode 100755 t/t2070-restore.sh
 create mode 100755 t/t2071-restore-patch.sh

Diff:

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ee0d164d0e..a294652dd6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -570,7 +570,7 @@ $ git add frotz
 
 SEE ALSO
 --------
-linkgit:git-switch[1]
+linkgit:git-switch[1],
 linkgit:git-restore[1]
 
 GIT
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e7ac8eb9e8..7628193284 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -56,7 +56,7 @@ summary of what is included by any of the above for the next
 commit by giving the same set of parameters (options and paths).
 
 If you make a commit and then find a mistake immediately after
-that, you can recover from it with 'git restore' or 'git reset'.
+that, you can recover from it with 'git reset'.
 
 
 OPTIONS
@@ -359,7 +359,7 @@ When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
 called the "index" with 'git add'.  A file can be
 reverted back, only in the index but not in the working tree,
-to that of the last commit with `git restore --index <file>`,
+to that of the last commit with `git restore --staged <file>`,
 which effectively reverts 'git add' and prevents the changes to
 this file from participating in the next commit.  After building
 the state to be committed incrementally with these commands,
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 71c9fe3af3..01bfcecf69 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -422,7 +422,7 @@ One way to test if your MUA is set up correctly is:
 
     $ git fetch <project> master:test-apply
     $ git switch test-apply
-    $ git restore --source=HEAD --index --worktree :/
+    $ git restore --source=HEAD --staged --worktree :/
     $ git am a.patch
 
 If it does not apply correctly, there can be various reasons.
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b70281677f..633d71d36a 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -25,7 +25,8 @@ The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 	the current branch.)
 +
 This means that `git reset <paths>` is the opposite of `git add
-<paths>`.
+<paths>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <paths>...`.
 +
 After running `git reset <paths>` to update the index entry, you can
 use linkgit:git-restore[1] to check the contents out of the index to
@@ -86,8 +87,8 @@ but carries forward unmerged index entries.
 	changes, reset is aborted.
 --
 
-If you want to undo a commit other than the latest on a branch,
-linkgit:git-revert[1] is your friend.
+See "Reset, restore and revert" in linkgit:git[1] for the differences
+between the three commands.
 
 
 OPTIONS
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index a667a5ced4..b608f3f360 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -8,48 +8,60 @@ git-restore - Restore working tree files
 SYNOPSIS
 --------
 [verse]
-'git restore' [<options>] [--source=<revision>] <pathspec>...
-'git restore' (-p|--patch) [--source=<revision>] [<pathspec>...]
+'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] <pathspec>...
+'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [<pathspec>...]
 
 DESCRIPTION
 -----------
-Restore paths in the working tree by replacing with the contents in
-the restore source or remove if the paths do not exist in the restore
-source. The source is by default the index but could be from a commit.
-The command can also optionally restore content in the index from a
-commit.
+Restore specified paths in the working tree with some contents from a
+restore source. If a path is tracked but does not exist in the restore
+source, it will be removed to match the source.
 
-When a `<revision>` is given, the paths that match the `<pathspec>` are
-updated both in the index and in the working tree.
+The command can also be used to restore the content in the index with
+`--staged`, or restore both the working tree and the index with
+`--staged --worktree`.
+
+By default, the restore sources for working tree and the index are the
+index and `HEAD` respectively. `--source` could be used to specify a
+commit as the restore source.
+
+See "Reset, restore and revert" in linkgit:git[1] for the differences
+between the three commands.
 
 OPTIONS
 -------
--s<tree>::
+-s <tree>::
 --source=<tree>::
 	Restore the working tree files with the content from the given
-	tree or any revision that leads to a tree (e.g. a commit or a
-	branch).
+	tree. It is common to specify the source tree by naming a
+	commit, branch or tag associated with it.
++
+If not specified, the default restore source for the working tree is
+the index, and the default restore source for the index index is
+`HEAD`. When both `--staged` and `--worktree` are specified,
+`--source` must also be specified.
 
 -p::
 --patch::
 	Interactively select hunks in the difference between the
-	`<revision>` (or the index, if unspecified) and the working
-	tree. See the ``Interactive Mode'' section of linkgit:git-add[1]
-	to learn how to operate the `--patch` mode.
+	restore source and the restore location. See the ``Interactive
+	Mode'' section of linkgit:git-add[1] to learn how to operate
+	the `--patch` mode.
++
+Note that `--patch` can accept no pathspec and will prompt to restore
+all modified paths.
 
 -W::
 --worktree::
--I::
---index::
+-S::
+--staged::
 	Specify the restore location. If neither option is specified,
-	by default the working tree is restored. If `--index` is
-	specified without `--worktree` or `--source`, `--source=HEAD`
-	is implied. These options only make sense to use with
-	`--source`.
+	by default the working tree is restored. Specifying `--staged`
+	will only restore the index. Specifying both restores both.
 
 -q::
 --quiet::
-	Quiet, suppress feedback messages.
+	Quiet, suppress feedback messages. Implies `--no-progress`.
 
 --progress::
 --no-progress::
@@ -58,16 +70,10 @@ OPTIONS
 	is specified. This flag enables progress reporting even if not
 	attached to a terminal, regardless of `--quiet`.
 
--f::
---force::
-	If `--source` is not specified, unmerged entries are left alone
-	and will not fail the operation. Unmerged entries are always
-	replaced if `--source` is specified, regardless of `--force`.
-
 --ours::
 --theirs::
-	Check out stage #2 ('ours') or #3 ('theirs') for unmerged
-	paths.
+	When restoring files in the working tree from the index, use
+	stage #2 ('ours') or #3 ('theirs') for unmerged paths.
 +
 Note that during `git rebase` and `git pull --rebase`, 'ours' and
 'theirs' may appear swapped. See the explanation of the same options
@@ -75,67 +81,64 @@ in linkgit:git-checkout[1] for details.
 
 -m::
 --merge::
-	Recreate the conflicted merge in the specified paths.
+	When restoring files on the working tree from the index,
+	recreate the conflicted merge in the unmerged paths.
 
 --conflict=<style>::
 	The same as `--merge` option above, but changes the way the
-	conflicting hunks are presented, overriding the merge.conflictStyle
-	configuration variable.  Possible values are "merge" (default)
-	and "diff3" (in addition to what is shown by "merge" style,
-	shows the original contents).
+	conflicting hunks are presented, overriding the
+	`merge.conflictStyle` configuration variable.  Possible values
+	are "merge" (default) and "diff3" (in addition to what is
+	shown by "merge" style, shows the original contents).
+
+--ignore-unmerged::
+	When restoring files on the working tree from the index, do
+	not abort the operation if there are unmerged entries and
+	neither `--ours`, `--theirs`, `--merge` or `--conflict` is
+	specified. Unmerged paths on the working tree are left alone.
 
 --ignore-skip-worktree-bits::
-	In sparse checkout mode, by default update only entries
+	In sparse checkout mode, by default is to only update entries
 	matched by `<pathspec>` and sparse patterns in
 	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
-	patterns and unconditionally restores any files in `<pathspec>`.
-
---recurse-submodules::
---no-recurse-submodules::
-	Using `--recurse-submodules` will update the content of all initialized
-	submodules according to the commit recorded in the superproject. If
-	local modifications in a submodule would be overwritten the checkout
-	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
-	is used, the work trees of submodules will not be updated.
-	Just like linkgit:git-submodule[1], this will detach the
-	submodules HEAD.
+	patterns and unconditionally restores any files in
+	`<pathspec>`.
 
 --overlay::
 --no-overlay::
-	In overlay mode, `git checkout` never removes files from the
-	index or the working tree. In no-overlay mode, files that
-	appear in the index and working tree, but not in `--source` tree
-	are removed, to make them match `<tree-ish>` exactly. The
-	default is no-overlay mode.
+	In overlay mode, the command never removes files when
+	restoring. In no-overlay mode, tracked files that do not
+	appear in the `--source` tree are removed, to make them match
+	`<tree>` exactly. The default is no-overlay mode.
 
 EXAMPLES
 --------
 
-The following sequence checks out the `master` branch, reverts
-the `Makefile` to two revisions back, deletes hello.c by
-mistake, and gets it back from the index.
+The following sequence switches to the `master` branch, reverts the
+`Makefile` to two revisions back, deletes hello.c by mistake, and gets
+it back from the index.
 
 ------------
 $ git switch master
 $ git restore --source master~2 Makefile  <1>
 $ rm -f hello.c
-$ git restore hello.c                   <2>
+$ git restore hello.c                     <2>
 ------------
 
 <1> take a file out of another commit
 <2> restore hello.c from the index
 
-If you want to check out _all_ C source files out of the index,
-you can say
+If you want to restore _all_ C source files to match the version in
+the index, you can say
 
 ------------
 $ git restore '*.c'
 ------------
 
 Note the quotes around `*.c`.  The file `hello.c` will also be
-checked out, even though it is no longer in the working tree,
-because the file globbing is used to match entries in the index
-(not in the working tree by the shell).
+restored, even though it is no longer in the working tree, because the
+file globbing is used to match entries in the index (not in the
+working tree by the shell).
 
 To restore all files in the current directory
 
@@ -144,28 +147,36 @@ $ git restore .
 ------------
 
 or to restore all working tree files with 'top' pathspec magic (see
-linkgit::gitglossary[7])
+linkgit:gitglossary[7])
 
 ------------
 $ git restore :/
 ------------
 
-To restore a file in the index only (this is the same as using
-"git reset")
+To restore a file in the index to match the version in `HEAD` (this is
+the same as using linkgit:git-reset[1])
+
+------------
+$ git restore --staged hello.c
+------------
+
+or you can restore both the index and the working tree (this the same
+as using linkgit:git-checkout[1])
 
 ------------
-$ git restore --index hello.c
+$ git restore --source=HEAD --staged --worktree hello.c
 ------------
 
-or you can restore both the index and the working tree
+or the short form which is more practical but less readable:
 
 ------------
-$ git restore --source=HEAD --index --worktree hello.c
+$ git restore -s@ -SW hello.c
 ------------
 
 SEE ALSO
 --------
-linkgit:git-checkout[1]
+linkgit:git-checkout[1],
+linkgit:git-reset[1]
 
 GIT
 ---
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index c38bc54439..9aadc36881 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -27,9 +27,12 @@ throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the `--hard` option.  If
 you want to extract specific files as they were in another commit, you
 should see linkgit:git-restore[1], specifically the `--source`
-option  Take care with these alternatives as
+option. Take care with these alternatives as
 both will discard uncommitted changes in your working directory.
 
+See "Reset, restore and revert" in linkgit:git[1] for the differences
+between the three commands.
+
 OPTIONS
 -------
 <commit>...::
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index b5c46223c4..4271fc5eaa 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,7 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f | --force] [-n] [-r] [--staged] [--ignore-unmatch] [--quiet] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -55,10 +55,11 @@ OPTIONS
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
 
+--staged::
 --cached::
 	Use this option to unstage and remove paths only from the index.
-	Working tree files, whether modified or not, will be
-	left alone.
+	Working tree files, whether modified or not, will be left
+	alone. `--cached` is synonym for `--staged`.
 
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 00156d64aa..fbed007354 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -210,6 +210,26 @@ people via patch over e-mail.
 
 include::cmds-foreignscminterface.txt[]
 
+Reset, restore and revert
+~~~~~~~~~~~~~~~~~~~~~~~~~
+There are three commands with similar names: `git reset`,
+`git restore` and `git revert`.
+
+* linkgit:git-revert[1] is about making a new commit that reverts the
+  changes made by other commits.
+
+* linkgit:git-restore[1] is about restoring files in the working tree
+  from either the index or another commit. This command does not
+  update your branch. The command can also be used to restore files in
+  the index from another commit.
+
+* linkgit:git-reset[1] is about updating your branch, moving the tip
+  in order to add or remove commits from the branch. This operation
+  changes the commit history.
++
+`git reset` can also be used to restore the index, overlapping with
+`git restore`.
+
 
 Low-level commands (plumbing)
 -----------------------------
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 79517b22f9..1bd919f92b 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -51,8 +51,7 @@ following commands.
 
   * linkgit:git-commit[1] to advance the current branch.
 
-  * linkgit:git-reset[1] and linkgit:git-restore[1] (with
-    pathname parameters) to undo changes.
+  * linkgit:git-restore[1] to undo changes.
 
   * linkgit:git-merge[1] to merge between local branches.
 
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index e412841488..8bdb7d0bd3 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -370,7 +370,7 @@ situation:
 $ git status
 On branch master
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   closing.txt
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 6266ca21b4..59ef5cef1f 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -110,7 +110,7 @@ $ git status
 On branch master
 Changes to be committed:
 Your branch is up to date with 'origin/master'.
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   file1
 	modified:   file2
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 02713886f0..8bce75b2cf 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1446,7 +1446,7 @@ mistake, you can return the entire working tree to the last committed
 state with
 
 -------------------------------------------------
-$ git restore --index --worktree :/
+$ git restore --staged --worktree :/
 -------------------------------------------------
 
 If you make a commit that you later wish you hadn't, there are two
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e8896ddbca..bed79ae595 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -38,7 +38,7 @@ static const char * const switch_branch_usage[] = {
 	NULL,
 };
 
-static const char * const restore_files_usage[] = {
+static const char * const restore_usage[] = {
 	N_("git restore [<options>] [--source=<branch>] <file>..."),
 	NULL,
 };
@@ -68,6 +68,8 @@ struct checkout_opts {
 	int empty_pathspec_ok;
 	int checkout_index;
 	int checkout_worktree;
+	const char *ignore_unmerged_opt;
+	int ignore_unmerged;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -409,8 +411,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (opts->new_branch_log)
 		die(_("'%s' cannot be used with updating paths"), "-l");
 
-	if (opts->force && opts->patch_mode)
-		die(_("'%s' cannot be used with updating paths"), "-f");
+	if (opts->ignore_unmerged && opts->patch_mode)
+		die(_("'%s' cannot be used with updating paths"),
+		    opts->ignore_unmerged_opt);
 
 	if (opts->force_detach)
 		die(_("'%s' cannot be used with updating paths"), "--detach");
@@ -418,8 +421,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (opts->merge && opts->patch_mode)
 		die(_("'%s' cannot be used with %s"), "--merge", "--patch");
 
-	if (opts->force && opts->merge)
-		die(_("'%s' cannot be used with %s"), "-f", "-m");
+	if (opts->ignore_unmerged && opts->merge)
+		die(_("'%s' cannot be used with %s"),
+		    opts->ignore_unmerged_opt, "-m");
 
 	if (opts->new_branch)
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
@@ -427,12 +431,22 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	if (!opts->checkout_worktree && !opts->checkout_index)
 		die(_("neither '%s' or '%s' is specified"),
-		    "--index", "--worktree");
+		    "--staged", "--worktree");
 
-	if (!opts->source_tree && !opts->checkout_worktree)
+	if (!opts->checkout_worktree && !opts->from_treeish)
 		die(_("'%s' must be used when '%s' is not specified"),
 		    "--worktree", "--source");
 
+	if (opts->checkout_index && !opts->checkout_worktree &&
+	    opts->writeout_stage)
+		die(_("'%s' or '%s' cannot be used with %s"),
+		    "--ours", "--theirs", "--staged");
+
+	if (opts->checkout_index && !opts->checkout_worktree &&
+	    opts->merge)
+		die(_("'%s' or '%s' cannot be used with %s"),
+		    "--merge", "--conflict", "--staged");
+
 	if (opts->patch_mode) {
 		const char *patch_mode;
 
@@ -443,7 +457,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 		else if (!opts->checkout_index && opts->checkout_worktree)
 			patch_mode = "--patch=worktree";
 		else
-			BUG("either flag must have been set");
+			BUG("either flag must have been set, worktree=%d, index=%d",
+			    opts->checkout_worktree, opts->checkout_index);
 		return run_add_interactive(revision, patch_mode, &opts->pathspec);
 	}
 
@@ -486,8 +501,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce))
 				continue;
-			if (opts->force) {
-				warning(_("path '%s' is unmerged"), ce->name);
+			if (opts->ignore_unmerged) {
+				if (!opts->quiet)
+					warning(_("path '%s' is unmerged"), ce->name);
 			} else if (opts->writeout_stage) {
 				errs |= check_stage(opts->writeout_stage, ce, pos, opts->overlay_mode);
 			} else if (opts->merge) {
@@ -1405,8 +1421,6 @@ static struct option *add_common_options(struct checkout_opts *opts,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
-		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
-			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
@@ -1424,6 +1438,8 @@ static struct option *add_common_switch_branch_options(
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
+		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
@@ -1493,8 +1509,11 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		opts->merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
-	if (opts->force)
+	if (opts->force) {
 		opts->discard_changes = 1;
+		opts->ignore_unmerged_opt = "--force";
+		opts->ignore_unmerged = 1;
+	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
@@ -1516,8 +1535,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
 		BUG("these flags should be non-negative by now");
 	/*
-	 * convenient shortcut: "git restore --index" equals
-	 * "git restore --index --source HEAD"
+	 * convenient shortcut: "git restore --staged" equals
+	 * "git restore --staged --source HEAD"
 	 */
 	if (!opts->from_treeish && opts->checkout_index && !opts->checkout_worktree)
 		opts->from_treeish = "HEAD";
@@ -1587,7 +1606,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	if (opts->accept_pathspec && !opts->empty_pathspec_ok && !argc &&
 	    !opts->patch_mode)	/* patch mode is special */
-		die(_("pathspec is required"));
+		die(_("you must specify path(s) to restore"));
 
 	if (argc) {
 		parse_pathspec(&opts->pathspec, 0,
@@ -1737,10 +1756,12 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
 			   N_("where the checkout from")),
-		OPT_BOOL('I', "index", &opts.checkout_index,
+		OPT_BOOL('S', "staged", &opts.checkout_index,
 			   N_("restore the index")),
 		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
 			   N_("restore the working tree (default)")),
+		OPT_BOOL(0, "ignore-unmerged", &opts.ignore_unmerged,
+			 N_("ignore unmerged entries")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
@@ -1753,13 +1774,14 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.overlay_mode = 0;
 	opts.checkout_index = -1;    /* default off */
 	opts.checkout_worktree = -2; /* default on */
+	opts.ignore_unmerged_opt = "--ignore-unmerged";
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, restore_files_usage);
+			    options, restore_usage);
 	FREE_AND_NULL(options);
 	return ret;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index c530264e63..fa5982cc86 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1676,7 +1676,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (commit_index_files())
 		die(_("repository has been updated, but unable to write\n"
 		      "new_index file. Check that disk is not full and quota is\n"
-		      "not exceeded, and then \"git restore --index :/\" to recover."));
+		      "not exceeded, and then \"git restore --staged :/\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
 		write_commit_graph_reachable(get_object_directory(), 0, 0);
diff --git a/builtin/rm.c b/builtin/rm.c
index db85b33982..47c8eb100b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -217,7 +217,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 			     "staged in the index:",
 			     "the following files have changes "
 			     "staged in the index:", files_cached.nr),
-			  _("\n(use --cached to keep the file,"
+			  _("\n(use --staged to keep the file,"
 			    " or -f to force removal)"),
 			  &errs);
 	string_list_clear(&files_cached, 0);
@@ -226,7 +226,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 			  Q_("the following file has local modifications:",
 			     "the following files have local modifications:",
 			     files_local.nr),
-			  _("\n(use --cached to keep the file,"
+			  _("\n(use --staged to keep the file,"
 			    " or -f to force removal)"),
 			  &errs);
 	string_list_clear(&files_local, 0);
@@ -240,7 +240,8 @@ static int ignore_unmatch = 0;
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
-	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOL( 0 , "staged",         &index_only, N_("only remove from the index")),
+	OPT_BOOL( 0 , "cached",         &index_only, N_("synonym for --staged")),
 	OPT__FORCE(&force, N_("override the up-to-date check"), PARSE_OPT_NOCOMPLETE),
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
diff --git a/command-list.txt b/command-list.txt
index cf8dccb439..a9ac72bef4 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -81,7 +81,7 @@ git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
-git-diff                                mainporcelain           history
+git-diff                                mainporcelain           info
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
@@ -150,7 +150,7 @@ git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain           worktree
+git-reset                               mainporcelain           history
 git-restore                             mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index df91bf54bc..73ea13ede9 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -23,11 +23,6 @@ test_expect_success 'restore without pathspec is not ok' '
 	test_must_fail git restore --source=first
 '
 
-test_expect_success 'restore -p without pathspec is fine' '
-	echo q >cmd &&
-	git restore -p <cmd
-'
-
 test_expect_success 'restore a file, ignoring branch of same name' '
 	cat one >expected &&
 	echo dirty >>one &&
@@ -35,7 +30,7 @@ test_expect_success 'restore a file, ignoring branch of same name' '
 	test_cmp expected one
 '
 
-test_expect_success 'restore a file on worktree from another branch' '
+test_expect_success 'restore a file on worktree from another ref' '
 	test_when_finished git reset --hard &&
 	git cat-file blob first:./first.t >expected &&
 	git restore --source=first first.t &&
@@ -45,33 +40,60 @@ test_expect_success 'restore a file on worktree from another branch' '
 	test_cmp expected actual
 '
 
-test_expect_success 'restore a file in the index from another branch' '
+test_expect_success 'restore a file in the index from another ref' '
 	test_when_finished git reset --hard &&
 	git cat-file blob first:./first.t >expected &&
-	git restore --source=first --index first.t &&
+	git restore --source=first --staged first.t &&
 	git show :first.t >actual &&
 	test_cmp expected actual &&
 	git cat-file blob HEAD:./first.t >expected &&
 	test_cmp expected first.t
 '
 
-test_expect_success 'restore a file in both the index and worktree from another branch' '
+test_expect_success 'restore a file in both the index and worktree from another ref' '
 	test_when_finished git reset --hard &&
 	git cat-file blob first:./first.t >expected &&
-	git restore --source=first --index --worktree first.t &&
+	git restore --source=first --staged --worktree first.t &&
 	git show :first.t >actual &&
 	test_cmp expected actual &&
 	test_cmp expected first.t
 '
 
-test_expect_success 'restore --index uses HEAD as source' '
+test_expect_success 'restore --staged uses HEAD as source' '
 	test_when_finished git reset --hard &&
 	git cat-file blob :./first.t >expected &&
 	echo index-dirty >>first.t &&
 	git add first.t &&
-	git restore --index first.t &&
+	git restore --staged first.t &&
 	git cat-file blob :./first.t >actual &&
 	test_cmp expected actual
 '
 
+test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
+	git init unmerged &&
+	(
+		cd unmerged &&
+		echo one >unmerged &&
+		echo one >common &&
+		git add unmerged common &&
+		git commit -m common &&
+		git switch -c first &&
+		echo first >unmerged &&
+		git commit -am first &&
+		git switch -c second master &&
+		echo second >unmerged &&
+		git commit -am second &&
+		test_must_fail git merge first &&
+
+		echo dirty >>common &&
+		test_must_fail git restore . &&
+
+		git restore --ignore-unmerged --quiet . >output 2>&1 &&
+		git diff common >diff-output &&
+		: >empty &&
+		test_cmp empty output &&
+		test_cmp empty diff-output
+	)
+'
+
 test_done
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index 46ebcb2413..98b2476e7c 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -16,6 +16,11 @@ test_expect_success PERL 'setup' '
 	save_head
 '
 
+test_expect_success PERL 'restore -p without pathspec is fine' '
+	echo q >cmd &&
+	git restore -p <cmd
+'
+
 # note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
 
 test_expect_success PERL 'saying "n" does nothing' '
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 04e5d42bd3..5686032b8c 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -797,7 +797,7 @@ test_expect_success 'rm file with local modification' '
 	cat >expect <<-\EOF &&
 	error: the following file has local modifications:
 	    foo.txt
-	(use --cached to keep the file, or -f to force removal)
+	(use --staged to keep the file, or -f to force removal)
 	EOF
 	git commit -m "testing rm 3" &&
 	echo content3 >foo.txt &&
@@ -819,7 +819,7 @@ test_expect_success 'rm file with changes in the index' '
 	cat >expect <<-\EOF &&
 	error: the following file has changes staged in the index:
 	    foo.txt
-	(use --cached to keep the file, or -f to force removal)
+	(use --staged to keep the file, or -f to force removal)
 	EOF
 	git reset --hard &&
 	echo content5 >foo.txt &&
@@ -845,7 +845,7 @@ test_expect_success 'rm files with two different errors' '
 	(use -f to force removal)
 	error: the following file has changes staged in the index:
 	    bar1.txt
-	(use --cached to keep the file, or -f to force removal)
+	(use --staged to keep the file, or -f to force removal)
 	EOF
 	echo content >foo1.txt &&
 	git add foo1.txt &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index d5cf0185b7..738f3df2f9 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -71,7 +71,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'status (1)' '
-	test_i18ngrep "use \"git rm --cached <file>\.\.\.\" to unstage" output
+	test_i18ngrep "use \"git rm --staged <file>\.\.\.\" to unstage" output
 '
 
 strip_comments () {
@@ -94,7 +94,7 @@ test_expect_success 'status --column' '
 #   (use "git pull" to merge the remote branch into yours)
 #
 # Changes to be committed:
-#   (use "git restore --index <file>..." to unstage)
+#   (use "git restore --staged <file>..." to unstage)
 #
 #	new file:   dir2/added
 #
@@ -128,7 +128,7 @@ cat >expect <<\EOF
 #   (use "git pull" to merge the remote branch into yours)
 #
 # Changes to be committed:
-#   (use "git restore --index <file>..." to unstage)
+#   (use "git restore --staged <file>..." to unstage)
 #
 #	new file:   dir2/added
 #
@@ -278,7 +278,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
@@ -347,7 +347,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
@@ -420,7 +420,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
@@ -484,7 +484,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
@@ -542,7 +542,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
@@ -605,7 +605,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   ../dir2/added
 
@@ -676,7 +676,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	<GREEN>new file:   dir2/added<RESET>
 
@@ -802,7 +802,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 
@@ -852,7 +852,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   dir1/modified
 
@@ -896,7 +896,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 	new file:   sm
@@ -956,7 +956,7 @@ and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	new file:   dir2/added
 	new file:   sm
@@ -1068,7 +1068,7 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --source=HEAD^1 --index <file>..." to unstage)
+  (use "git restore --source=HEAD^1 --staged <file>..." to unstage)
 
 	new file:   dir2/added
 	new file:   sm
@@ -1123,7 +1123,7 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
@@ -1235,7 +1235,7 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
@@ -1295,7 +1295,7 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
@@ -1379,7 +1379,7 @@ cat > expect << EOF
 ;   (use "git pull" to merge the remote branch into yours)
 ;
 ; Changes to be committed:
-;   (use "git restore --index <file>..." to unstage)
+;   (use "git restore --staged <file>..." to unstage)
 ;
 ;	modified:   sm
 ;
@@ -1458,7 +1458,7 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
@@ -1581,7 +1581,7 @@ and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   sm
 
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 6e678456bc..1b9712c675 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -85,7 +85,7 @@ You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
   (use "git rebase --abort" to check out the original branch)
 
 Unmerged paths:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
 	both modified:   main.txt
@@ -110,7 +110,7 @@ You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   main.txt
 
@@ -148,7 +148,7 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
   (use "git rebase --abort" to check out the original branch)
 
 Unmerged paths:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
 	both modified:   main.txt
@@ -176,7 +176,7 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
   (all conflicts fixed: run "git rebase --continue")
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   main.txt
 
@@ -816,7 +816,7 @@ You are currently reverting commit $TO_REVERT.
   (use "git revert --abort" to cancel the revert operation)
 
 Unmerged paths:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
 
 	both modified:   to-revert.txt
@@ -837,7 +837,7 @@ You are currently reverting commit $TO_REVERT.
   (use "git revert --abort" to cancel the revert operation)
 
 Changes to be committed:
-  (use "git restore --index <file>..." to unstage)
+  (use "git restore --staged <file>..." to unstage)
 
 	modified:   to-revert.txt
 
diff --git a/wt-status.c b/wt-status.c
index 3098e77d72..4d065ce89e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -181,13 +181,13 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	else if (!s->is_initial) {
 		if (!strcmp(s->reference, "HEAD"))
 			status_printf_ln(s, c,
-					 _("  (use \"git restore --index <file>...\" to unstage)"));
+					 _("  (use \"git restore --staged <file>...\" to unstage)"));
 		else
 			status_printf_ln(s, c,
-					 _("  (use \"git restore --source=%s --index <file>...\" to unstage)"),
+					 _("  (use \"git restore --source=%s --staged <file>...\" to unstage)"),
 					 s->reference);
 	} else
-		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
+		status_printf_ln(s, c, _("  (use \"git rm --staged <file>...\" to unstage)"));
 
 	if (!both_deleted) {
 		if (!del_mod_conflict)
@@ -214,13 +214,13 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 	else if (!s->is_initial) {
 		if (!strcmp(s->reference, "HEAD"))
 			status_printf_ln(s, c
-					 , _("  (use \"git restore --index <file>...\" to unstage)"));
+					 , _("  (use \"git restore --staged <file>...\" to unstage)"));
 		else
 			status_printf_ln(s, c,
-					 _("  (use \"git restore --source=%s --index <file>...\" to unstage)"),
+					 _("  (use \"git restore --source=%s --staged <file>...\" to unstage)"),
 					 s->reference);
 	} else
-		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
+		status_printf_ln(s, c, _("  (use \"git rm --staged <file>...\" to unstage)"));
 	status_printf_ln(s, c, "%s", "");
 }
 


-- 
2.21.0.682.g30d2204636

