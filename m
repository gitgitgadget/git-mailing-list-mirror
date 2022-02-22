Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF8FC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiBVASh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbiBVASc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578725594
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so3338133wrg.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G3FbLFEqO3aEUBUJI2bH5XLPGjurAqgIMRRvIVHdmIk=;
        b=Lz5kR4SuBhHxas1zlU88iY3gnQHGn2dZMTGY40ikvKVuP1RY2qBtrDWJJZ2RXYKef8
         8FCIO6xhhIUto0N4NNczFlofWvVKfTzbfoHicI3sBXHnEyi8zy7JYLu+HduP2F/k+4y3
         G8rmXsV2DqlvvoyvSHzp9votbyVUhdJNMZx1RhTudxSq8nBTzragPBt6c67aZZx9LLFQ
         hK/p1Sb/efRF6E18L1UrGtUT4jbao2UYcllyBW5Xw4MMQ3B/xhmz2kHmCpS09H5n/nj2
         kx7nFQp7ihfCC/efBKDn/nZL1LY6+8lgmLdOkS+D1WeSiLM5jmOnVrfz8dybA2ETiANE
         ZVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G3FbLFEqO3aEUBUJI2bH5XLPGjurAqgIMRRvIVHdmIk=;
        b=oait2+pijO/aPCEFH1K5/E1KAzO0LuxXqfqkRaJXZIP9DIYiyIXbe6zTRz/uYnkw6H
         BC+aJg8unildtkmhSDmTMpBRk9d8fGo63CHgER573qqucZUajg8loaF4AHOOrydWLCk6
         yUymPUhuPocuztblaY9uC2NDDGxesn5zfWySfL2QmQ5uaGvBIMWFYsP2no3HASUc5zHE
         saeoGIo4xohWEvOKftGrHBeWz8Zf7ROmNYTWRRS2wY4awlsSWuSKBnah7WsnHbppQmEv
         s7qSdGaEvFnpzWuohSLVpsaxkzrUkGT7yAI4GWAA0BfabIglDyUW2nQnSSaiSmKVMcIu
         UkDg==
X-Gm-Message-State: AOAM532+FJY9uc1OJ0YySuQWKoviYWinSqU7KNfjPUqX43+KfhzJx+sR
        n1SwOWZOiCoDmqjqNRAg2+9gLCZp/U8=
X-Google-Smtp-Source: ABdhPJx6VpdKVrxI+odSk9ykcXmazZ7DtEQjlOWGKJPVqRA7ij/xOOFMt4iFKdZPtdgtT8YUfYfC+w==
X-Received: by 2002:adf:f0c6:0:b0:1e7:13f7:74b9 with SMTP id x6-20020adff0c6000000b001e713f774b9mr17269610wro.361.1645489085929;
        Mon, 21 Feb 2022 16:18:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm32996565wru.41.2022.02.21.16.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:05 -0800 (PST)
Message-Id: <2801ae232ae5cd0aa431e90eb37bbaf765d64fa5.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:54 +0000
Subject: [PATCH v2 05/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is helpful to distinguish between a 'working tree' and a 'worktree'.
A worktree contains a working tree plus additional metadata. This
metadata includes per-worktree refs and worktree-specific config.

This is the first of multiple changes to git-worktree.txt, restricted to
the DESCRIPTION section.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 50 ++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index b8d53c48303..27437615436 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -25,45 +25,49 @@ Manage multiple working trees attached to the same repository.
 
 A git repository can support multiple working trees, allowing you to check
 out more than one branch at a time.  With `git worktree add` a new working
-tree is associated with the repository.  This new working tree is called a
-"linked working tree" as opposed to the "main working tree" prepared by
-linkgit:git-init[1] or linkgit:git-clone[1].
-A repository has one main working tree (if it's not a
-bare repository) and zero or more linked working trees. When you are done
-with a linked working tree, remove it with `git worktree remove`.
+tree is associated with the repository, along with additional metadata
+that differentiates that working tree from others in the same repository.
+The working tree, along with this metada, is called a "worktree".
+
+This new worktree is called a "linked worktree" as opposed to the "main
+worktree" prepared by linkgit:git-init[1] or linkgit:git-clone[1].
+A repository has one main worktree (if it's not a bare repository) and
+zero or more linked worktrees. When you are done with a linked worktree,
+remove it with `git worktree remove`.
 
 In its simplest form, `git worktree add <path>` automatically creates a
 new branch whose name is the final component of `<path>`, which is
 convenient if you plan to work on a new topic. For instance, `git
 worktree add ../hotfix` creates new branch `hotfix` and checks it out at
-path `../hotfix`. To instead work on an existing branch in a new working
-tree, use `git worktree add <path> <branch>`. On the other hand, if you
-just plan to make some experimental changes or do testing without
-disturbing existing development, it is often convenient to create a
-'throwaway' working tree not associated with any branch. For instance,
-`git worktree add -d <path>` creates a new working tree with a detached
-`HEAD` at the same commit as the current branch.
+path `../hotfix`. To instead work on an existing branch in a new worktree,
+use `git worktree add <path> <branch>`. On the other hand, if you just
+plan to make some experimental changes or do testing without disturbing
+existing development, it is often convenient to create a 'throwaway'
+worktree not associated with any branch. For instance,
+`git worktree add -d <path>` creates a new worktree with a detached `HEAD`
+at the same commit as the current branch.
 
 If a working tree is deleted without using `git worktree remove`, then
 its associated administrative files, which reside in the repository
 (see "DETAILS" below), will eventually be removed automatically (see
 `gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
-`git worktree prune` in the main or any linked working tree to
-clean up any stale administrative files.
+`git worktree prune` in the main or any linked worktree to clean up any
+stale administrative files.
 
-If a linked working tree is stored on a portable device or network share
-which is not always mounted, you can prevent its administrative files from
-being pruned by issuing the `git worktree lock` command, optionally
-specifying `--reason` to explain why the working tree is locked.
+If the working tree for a a linked worktree is stored on a portable device
+or network share which is not always mounted, you can prevent its
+administrative files from being pruned by issuing the `git worktree lock`
+command, optionally specifying `--reason` to explain why the worktree is
+locked.
 
 COMMANDS
 --------
 add <path> [<commit-ish>]::
 
-Create `<path>` and checkout `<commit-ish>` into it. The new working directory
-is linked to the current repository, sharing everything except working
-directory specific files such as `HEAD`, `index`, etc. As a convenience,
-`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
+Create a worktree at `<path>` and checkout `<commit-ish>` into it. The new worktree
+is linked to the current repository, sharing everything except per-worktree
+files such as `HEAD`, `index`, etc. As a convenience, `<commit-ish>` may
+be a bare "`-`", which is synonymous with `@{-1}`.
 +
 If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
-- 
gitgitgadget

