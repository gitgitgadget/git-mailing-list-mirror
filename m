Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E053C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 16:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiAMQn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 11:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbiAMQn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 11:43:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C416CC06161C
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:43:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v123so4309051wme.2
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B8sYjWF/iiVOI9HKxp3FHaiKzKBQ6qAlUF3+nG4HV5w=;
        b=FrVMNS0Dv8JX5dhk9o7jJgoQGjbEsqGTICFQm4fN0VNSD/ICd2oe3Jgd2hsfnXncb8
         4n5k6CIlxuRTpsXNMGsLjcVlvSqx9i9M7e5SIaK7k0tgcP3WeNZn2wRIS4nfDZcjyCJp
         UlwxCkvneKoC//V21NF7vYMse+2WfAiB5aW7/dzvE4vlpoEZ/imw8nRbnMeIX3ZQh5VG
         R3tKHqa7ybXvwQRZ1crLvG2QdXoAQmTE1JM+Tdm9x6i3KBzl9GqzobQQLuqK9XiIDJhV
         oHAsasH9W0ZaUIycjFXFNhxB/7lb8O1PEgF7ifok35neSK0WJQ/elId31uFYM0lQmYVb
         hJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B8sYjWF/iiVOI9HKxp3FHaiKzKBQ6qAlUF3+nG4HV5w=;
        b=q1fvwxwjfVRq1jPumT7a+rWbfC8B5eISU4+3FwC+nx6G474Sa3q1IPTptOmiofy0XY
         k9nuBcKxVEKtOkLdyWV2YWgTZ6IJzFtMaeTJ/eEhs4ZlGgWSVEppL5wqqzjA6kC345aV
         ct5QBi0EVI00mbPJEXWkXu/247YnrlyNg9nOOJSZTsExX9NaHOMOfOCsZExo3w8W/JBN
         zwUuC0m6jZS+10kEd6HBUEvLYl/2C9BycuY/eX93p1iO9mxAHxpVutWj2WyX6r6qX7MY
         I3T5yCyZp5FU5rJJUGyMogzC2mG9m9CtX8v5spIjsAaNd/JriqIDVThPkZwImbN6VoGl
         S75Q==
X-Gm-Message-State: AOAM533wV5O6AR5KHBXvfd3btRoWUxvXQGvze9eyS2pntny9Di23aX8L
        EnoR9iyOXm3wJNBrL+vLYC1I97/Tfjw=
X-Google-Smtp-Source: ABdhPJxV1Hq3rSI9dQ435ck+exGBFUgrD3E+sihvbZ+vPGQqV0FWQ40VlZe+cU38QOKwT0uB31/Lsw==
X-Received: by 2002:a05:600c:364b:: with SMTP id y11mr2291549wmq.156.1642092235027;
        Thu, 13 Jan 2022 08:43:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm4762232wry.18.2022.01.13.08.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:43:54 -0800 (PST)
Message-Id: <c74ad19616ed1e0971d5de2a3da795dc264af074.1642092230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Jan 2022 16:43:49 +0000
Subject: [PATCH 4/5] Update documentation related to sparsity and the
 skip-worktree bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make several small updates, to address a few documentation issues
I spotted:
  * sparse-checkout focused on "patterns" even though the inputs (and
    outputs in the case of `list`) are directories in cone-mode
  * The description section of the sparse-checkout documentation
    was a bit sparse (no pun intended), and focused more on internal
    mechanics rather than end user usage.  This made sense in the
    early days when the command was even more experimental, but let's
    adjust a bit to try to make it more approachable to end users who
    may want to consider using it.  Keep the scary backward
    compatibility warning, though; we're still hard at work trying to
    fix up commands to behave reasonably in sparse checkouts.
  * both read-tree and update-index tried to describe how to use the
    skip-worktree bit, but both predated the sparse-checkout command.
    The sparse-checkout command is a far easier mechanism to use and
    for users trying to reduce the size of their working tree, we
    should recommend users to look at it instead.
  * The update-index documentation pointed out that assume-unchanged
    and skip-worktree sounded similar but had different purposes.
    However, it made no attempt to explain the differences, only to
    point out that they were different.  Explain the differences.
  * The update-index documentation focused much more on (internal?)
    implementation details than on end-user usage.  Try to explain
    its purpose better for users of update-index, rather than
    fellow developers trying to work with the SKIP_WORKTREE bit.
  * Clarify that when core.sparseCheckout=true, we treat a file's
    presence in the working tree as being an override to the
    SKIP_WORKTREE bit (i.e. in sparse checkouts when the file is
    present we ignore the SKIP_WORKTREE bit).

Note that this commit, like many touching documentation, is best viewed
with the `--color-words` option to diff/log.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-read-tree.txt       | 12 +++--
 Documentation/git-sparse-checkout.txt | 76 ++++++++++++++++-----------
 Documentation/git-update-index.txt    | 57 +++++++++++++++-----
 3 files changed, 98 insertions(+), 47 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 8c3aceb8324..99bb387134d 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -375,9 +375,14 @@ have finished your work-in-progress), attempt the merge again.
 SPARSE CHECKOUT
 ---------------
 
+Note: The `update-index` and `read-tree` primitives for supporting the
+skip-worktree bit predated the introduction of
+linkgit:git-sparse-checkout[1].  Users are encouraged to use
+`sparse-checkout` in preference to these low-level primitives.
+
 "Sparse checkout" allows populating the working directory sparsely.
-It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
-Git whether a file in the working directory is worth looking at.
+It uses the skip-worktree bit (see linkgit:git-update-index[1]) to
+tell Git whether a file in the working directory is worth looking at.
 
 'git read-tree' and other merge-based commands ('git merge', 'git
 checkout'...) can help maintaining the skip-worktree bitmap and working
@@ -385,7 +390,8 @@ directory update. `$GIT_DIR/info/sparse-checkout` is used to
 define the skip-worktree reference bitmap. When 'git read-tree' needs
 to update the working directory, it resets the skip-worktree bit in the index
 based on this file, which uses the same syntax as .gitignore files.
-If an entry matches a pattern in this file, skip-worktree will not be
+If an entry matches a pattern in this file, or the entry corresponds to
+a file present in the working tree, then skip-worktree will not be
 set on that entry. Otherwise, skip-worktree will be set.
 
 Then it compares the new skip-worktree value with the previous one. If
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b81dbe06543..3da3d5a1007 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -3,9 +3,7 @@ git-sparse-checkout(1)
 
 NAME
 ----
-git-sparse-checkout - Initialize and modify the sparse-checkout
-configuration, which reduces the checkout to a set of paths
-given by a list of patterns.
+git-sparse-checkout - Reduce your working tree to a subset of tracked files
 
 
 SYNOPSIS
@@ -17,8 +15,20 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Initialize and modify the sparse-checkout configuration, which reduces
-the checkout to a set of paths given by a list of patterns.
+This command is used to create sparse checkouts, which means that it
+changes the working tree from having all tracked files present, to only
+have a subset of them.  It can also switch which subset of files are
+present, or undo and go back to having all tracked files present in the
+working copy.
+
+The subset of files is chosen by providing a list of directories in
+cone mode (which is recommended), or by providing a list of patterns
+in non-cone mode.
+
+When in a sparse-checkout, other Git commands behave a bit differently.
+For example, switching branches will not update paths outside the
+sparse-checkout directories/patterns, and `git commit -a` will not record
+paths outside the sparse-checkout directories/patterns as deleted.
 
 THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
 COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
@@ -28,7 +38,7 @@ THE FUTURE.
 COMMANDS
 --------
 'list'::
-	Describe the patterns in the sparse-checkout file.
+	Describe the directories or patterns in the sparse-checkout file.
 
 'set'::
 	Enable the necessary config settings
@@ -38,20 +48,26 @@ COMMANDS
 	list of arguments following the 'set' subcommand. Update the
 	working directory to match the new patterns.
 +
-When the `--stdin` option is provided, the patterns are read from
-standard in as a newline-delimited list instead of from the arguments.
+When the `--stdin` option is provided, the directories or patterns are
+read from standard in as a newline-delimited list instead of from the
+arguments.
 +
 When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
-input list is considered a list of directories instead of
-sparse-checkout patterns.  This allows for better performance with a
-limited set of patterns (see 'CONE PATTERN SET' below).  Note that the
-set command will write patterns to the sparse-checkout file to include
-all files contained in those directories (recursively) as well as
-files that are siblings of ancestor directories. The input format
-matches the output of `git ls-tree --name-only`.  This includes
-interpreting pathnames that begin with a double quote (") as C-style
-quoted strings.  This may become the default in the future; --no-cone
-can be passed to request non-cone mode.
+input list is considered a list of directories.  This allows for
+better performance with a limited set of patterns (see 'CONE PATTERN
+SET' below).  The input format matches the output of `git ls-tree
+--name-only`.  This includes interpreting pathnames that begin with a
+double quote (") as C-style quoted strings.  Note that the set command
+will write patterns to the sparse-checkout file to include all files
+contained in those directories (recursively) as well as files that are
+siblings of ancestor directories. This may become the default in the
+future; --no-cone can be passed to request non-cone mode.
++
+When `--no-cone` is passed or `core.sparseCheckoutCone` is not enabled,
+the input list is considered a list of patterns.  This mode is harder
+to use and less performant, and is thus not recommended.  See the
+"Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
+Set" sections below for more details.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -69,11 +85,10 @@ understand the sparse directory entries index extension and may fail to
 interact with your repository until it is disabled.
 
 'add'::
-	Update the sparse-checkout file to include additional patterns.
-	By default, these patterns are read from the command-line arguments,
-	but they can be read from stdin using the `--stdin` option. When
-	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
-	as directory names as in the 'set' subcommand.
+	Update the sparse-checkout file to include additional directories
+	(in cone mode) or patterns (in non-cone mode).  By default, these
+	directories or patterns are read from the command-line arguments,
+	but they can be read from stdin using the `--stdin` option.
 
 'reapply'::
 	Reapply the sparsity pattern rules to paths in the working tree.
@@ -117,13 +132,14 @@ decreased in utility.
 SPARSE CHECKOUT
 ---------------
 
-"Sparse checkout" allows populating the working directory sparsely.
-It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
-Git whether a file in the working directory is worth looking at. If
-the skip-worktree bit is set, then the file is ignored in the working
-directory. Git will avoid populating the contents of those files, which
-makes a sparse checkout helpful when working in a repository with many
-files, but only a few are important to the current user.
+"Sparse checkout" allows populating the working directory sparsely.  It
+uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell Git
+whether a file in the working directory is worth looking at. If the
+skip-worktree bit is set, and the file is not present in the working tree,
+then its absence is ignored. Git will avoid populating the contents of
+those files, which makes a sparse checkout helpful when working in a
+repository with many files, but only a few are important to the current
+user.
 
 The `$GIT_DIR/info/sparse-checkout` file is used to define the
 skip-worktree reference bitmap. When Git updates the working
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d97..568dbfe76b8 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -351,6 +351,10 @@ unchanged".  Note that "assume unchanged" bit is *not* set if
 the index (use `git update-index --really-refresh` if you want
 to mark them as "assume unchanged").
 
+Sometimes users confuse the assume-unchanged bit with the
+skip-worktree bit.  See the final paragraph in the "Skip-worktree bit"
+section below for an explanation of the differences.
+
 
 EXAMPLES
 --------
@@ -392,22 +396,47 @@ M foo.c
 SKIP-WORKTREE BIT
 -----------------
 
-Skip-worktree bit can be defined in one (long) sentence: When reading
-an entry, if it is marked as skip-worktree, then Git pretends its
-working directory version is up to date and read the index version
-instead.
-
-To elaborate, "reading" means checking for file existence, reading
-file attributes or file content. The working directory version may be
-present or absent. If present, its content may match against the index
-version or not. Writing is not affected by this bit, content safety
-is still first priority. Note that Git _can_ update working directory
-file, that is marked skip-worktree, if it is safe to do so (i.e.
-working directory version matches index version)
+Skip-worktree bit can be defined in one (long) sentence: Tell git to
+avoid writing the file to the working directory when reasonably
+possible, and treat the file as unchanged when it is not
+present in the working directory.
+
+Note that not all git commands will pay attention to this bit, and
+some only partially support it.
+
+The update-index flags and the read-tree capabilities relating to the
+skip-worktree bit predated the introduction of the
+linkgit:git-sparse-checkout[1] command, which provides a much easier
+way to configure and handle the skip-worktree bits.  If you want to
+reduce your working tree to only deal with a subset of the files in
+the repository, we strongly encourage the use of
+linkgit:git-sparse-checkout[1] in preference to the low-level
+update-index and read-tree primitives.
+
+The primary purpose of the skip-worktree bit is to enable sparse
+checkouts, i.e. to have working directories with only a subset of
+paths present.  When the skip-worktree bit is set, Git commands (such
+as `switch`, `pull`, `merge`) will avoid writing these files.
+However, these commands will sometimes write these files anyway in
+important cases such as conflicts during a merge or rebase.  Git
+commands will also avoid treating the lack of such files as an
+intentional deletion; for example `git add -u` will not not stage a
+deletion for these files and `git commit -a` will not make a commit
+deleting them either.
 
 Although this bit looks similar to assume-unchanged bit, its goal is
-different from assume-unchanged bit's. Skip-worktree also takes
-precedence over assume-unchanged bit when both are set.
+different.  The assume-unchanged bit is for leaving the file in the
+working tree but having Git omit checking it for changes and presuming
+that the file has not been changed (though if it can determine without
+stat'ing the file that it has changed, it is free to record the
+changes).  skip-worktree tells Git to ignore the absence of the file,
+avoid updating it when possible with commands that normally update
+much of the working directory (e.g. `checkout`, `switch`, `pull`,
+etc.), and not have its absence be recorded in commits.  Note that in
+sparse checkouts (setup by `git sparse-checkout` or by configuring
+core.sparseCheckout to true), if a file is marked as skip-worktree in
+the index but is found in the working tree, Git will clear the
+skip-worktree bit for that file.
 
 SPLIT INDEX
 -----------
-- 
gitgitgadget

