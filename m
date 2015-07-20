From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] mh: worktree-related doc fixes
Date: Mon, 20 Jul 2015 01:29:17 -0400
Message-ID: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 07:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH3eE-0008Ex-51
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 07:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbbGTF3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 01:29:44 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37667 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbbGTF3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 01:29:44 -0400
Received: by igbpg9 with SMTP id pg9so74050198igb.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=mIqrrTHBcMT53QEOcchmb7ivRYwg28YTOLGNJSWMD1A=;
        b=GnKlPTRCw0Xux24jsW9XppWiUjAJa1fPnwgCd8/bRhSm1++YSOhOGI7pOMSyo41wwC
         0aMqcmhId0rhRmOMA+I2wQUiNJPgrgjP0h4SGcePTHfYDMxjD6pj/GwmX0BPu0Xvr+g1
         RI2hCKVtCsLAKfyBaQw4loMtTBRRCZG7C6j996HHwwdvcMPVX9hMBc3/SgMZBfm6n2ds
         smWzrcWKiMPFqC+EBwEHp8LX88jgdKRNde9eWBGJQbdc2ZZzwOCwP6Kr7VsevK3JjA5S
         SdRDDCd8I2ZoTP0JzASBG333vEvwIhcf5oY1/IxW5MOsP0/6nR6Q52rz39iaC2s8OQs9
         Obtw==
X-Received: by 10.107.150.141 with SMTP id y135mr30149312iod.38.1437370183597;
        Sun, 19 Jul 2015 22:29:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm13104584iod.25.2015.07.19.22.29.42
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 22:29:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.386.g87d813d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274309>

This re-roll of Michael Haggerty's worktree-related documentation
tweaks[1] takes my review comments into account and adds one new patch.
A v1 to v2 interdiff is included below.

Changes since v1:

patch 1/5: fix additional instances of "worktree" -> "working tree"

patch 2/5: don't rename "git worktree lock" command to "git worktree
    locked" when renaming incorrect worktrees/<id>/lock to
    worktrees/<id>/locked

patch 4/5: further refine .git/worktrees and .git/worktrees/<id>/locked
    descriptions

patch 5/5 (new/optional): based upon a review comment tangent, rename
    config variable gc.pruneWorktreesExpire to gc.worktreePruneExpire;
    can be dropped if not deemed worthwhile

A couple of Michael's v1 patches were also dropped:

patch 2/6: these changes are already in master: 4d5a3c5
    (Documentation/git-worktree: fix stale "git checkout --to"
    references, 2015-07-16)

patch 4/6: incorrectly dropped unimplemented user-interface command
    "git worktree lock" from BUGS section, conflating it with low-level
    locking functionality which is already implemented

A few commit messages were also reworded.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/274190

Eric Sunshine (1):
  config: rename "gc.pruneWorktreesExpire" to "gc.worktreePruneExpire"

Michael Haggerty (4):
  Documentation/git-worktree: consistently use term "linked working
    tree"
  Documentation/git-worktree: fix incorrect reference to file "locked"
  Documentation/config: fix stale "git prune --worktree" reference
  Documentation/git-worktree: wordsmith worktree-related manpages

 Documentation/config.txt               | 12 +++++-----
 Documentation/git-worktree.txt         | 40 +++++++++++++++++-----------------
 Documentation/gitrepository-layout.txt | 22 +++++++++----------
 builtin/gc.c                           |  2 +-
 4 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.5.0.rc2.386.g87d813d

---- 8< ----
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 10bc351..746d292 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1291,7 +1291,7 @@ gc.pruneExpire::
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
 
-gc.pruneWorktreesExpire::
+gc.worktreePruneExpire::
 	When 'git gc' is run, it calls
 	'git worktree prune --expire 3.months.ago'.
 	This config variable can be used to set a different grace
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index dfac758..3234459 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -3,7 +3,7 @@ git-worktree(1)
 
 NAME
 ----
-git-worktree - Manage multiple worktrees
+git-worktree - Manage multiple working trees
 
 
 SYNOPSIS
@@ -15,7 +15,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Manage multiple worktrees attached to the same repository.
+Manage multiple working trees attached to the same repository.
 
 A git repository can support multiple working trees, allowing you to check
 out more than one branch at a time.  With `git worktree add` a new working
@@ -27,7 +27,7 @@ bare repository) and zero or more linked working trees.
 When you are done with a linked working tree you can simply delete it.
 The working tree's administrative files in the repository (see
 "DETAILS" below) will eventually be removed automatically (see
-`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
+`gc.worktreePruneExpire` in linkgit::git-config[1]), or you can run
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
 
@@ -64,22 +64,22 @@ OPTIONS
 
 -f::
 --force::
-	By default, `add` refuses to create a new worktree when	`<branch>`
-	is already checked out by another worktree. This option overrides
+	By default, `add` refuses to create a new working tree when `<branch>`
+	is already checked out by another working tree. This option overrides
 	that safeguard.
 
 -b <new-branch>::
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
-	`<branch>`, and check out `<new-branch>` into the new worktree.
+	`<branch>`, and check out `<new-branch>` into the new working tree.
 	If `<branch>` is omitted, it defaults to HEAD.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<branch>`.
 
 --detach::
-	With `add`, detach HEAD in the new worktree. See "DETACHED HEAD" in
-	linkgit:git-checkout[1].
+	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
+	in linkgit:git-checkout[1].
 
 -n::
 --dry-run::
@@ -91,7 +91,7 @@ OPTIONS
 	With `prune`, report all removals.
 
 --expire <time>::
-	With `prune`, only expire unused worktrees older than <time>.
+	With `prune`, only expire unused working trees older than <time>.
 
 DETAILS
 -------
@@ -138,9 +138,9 @@ EXAMPLES
 --------
 You are in the middle of a refactoring session and your boss comes in and
 demands that you fix something immediately. You might typically use
-linkgit:git-stash[1] to store your changes away temporarily; however, your
-worktree is in such a state of disarray (with new, moved, and removed files,
-and other bits and pieces strewn around) that you don't want to risk
+linkgit:git-stash[1] to store your changes away temporarily, however, your
+working tree is in such a state of disarray (with new, moved, and removed
+files, and other bits and pieces strewn around) that you don't want to risk
 disturbing any of it. Instead, you create a temporary linked working tree to
 make the emergency fix, remove it when done, and then resume your earlier
 refactoring session.
@@ -165,9 +165,11 @@ git-worktree could provide more automation for tasks currently
 performed manually, such as:
 
 - `remove` to remove a linked working tree and its administrative files (and
-  warn if the worktree is dirty)
-- `mv` to move or rename a worktree and update its administrative files
+  warn if the working tree is dirty)
+- `mv` to move or rename a working tree and update its administrative files
 - `list` to list linked working trees
+- `lock` to prevent automatic pruning of administrative files (for instance,
+  for a working tree on a portable device)
 
 GIT
 ---
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index fe7d4bb..577ee84 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -251,8 +251,8 @@ modules::
 	Contains the git-repositories of the submodules.
 
 worktrees::
-	Contains worktree-specific information for linked working
-	trees. Each subdirectory contains the worktree-related
+	Contains administrative data for linked
+	working trees. Each subdirectory contains the working tree-related
 	part of a linked working tree. This directory is ignored if
 	$GIT_COMMON_DIR is set, in which case
 	"$GIT_COMMON_DIR/worktrees" will be used instead.
@@ -267,9 +267,9 @@ worktrees/<id>/gitdir::
 worktrees/<id>/locked::
 	If this file exists, the linked working tree may be on a
 	portable device and not available. The presence of this file
-	prevents `worktrees/<id>` from being pruned by `git worktree
-	prune`. The file may contain a string explaining why the
-	repository is locked.
+	prevents `worktrees/<id>` from being pruned either automatically
+	or manually by `git worktree prune`. The file may contain a string
+	explaining why the repository is locked.
 
 worktrees/<id>/link::
 	If this file exists, it is a hard link to the linked .git
diff --git a/builtin/gc.c b/builtin/gc.c
index 4957c39..bcc75d9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -85,7 +85,7 @@ static void gc_config(void)
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_date_string("gc.pruneexpire", &prune_expire);
-	git_config_date_string("gc.pruneworktreesexpire", &prune_worktrees_expire);
+	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config(git_default_config, NULL);
 }
 
---- 8< ----
