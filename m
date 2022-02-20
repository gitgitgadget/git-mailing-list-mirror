Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570DEC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiBTRzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:55:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiBTRy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7DF4D9EB
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x5so18413039wrg.13
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qaswKm2FOW/d3DPi0HCFCNt2vonz7RYKAFT/RooHawA=;
        b=deWYjPvUodIQW8FcGAz9SBmx3NT/o806yTYpJcJ5UkJcbg4MhXTUAj//hms9cZPPDJ
         9e01NfqfsVmC1SIUyHje/tV0gZ9sD0SWgL3L3ln/OwLtT32x8hUMTd2VMyfuzUyxRBaZ
         E6d9hWRCnnXj+nGG3GWpJoUSkDsxbM+znFMkOL32kM19ujPn1/8lgoYOVgYvIylZFEEx
         qQ6YpvsaN9CUMe+hgCkLDEtj/K7IBJhBEhekRZktl+iYWUIkZDu857lV9PBK7cKBmr1c
         xyAHxN/KOaxdtF1U1Mo/p2yP00IjEDDHFxNSgzm0mtJrNzUqOhQx+tHOViToBACCyvSy
         VaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qaswKm2FOW/d3DPi0HCFCNt2vonz7RYKAFT/RooHawA=;
        b=SPnyaVyKPXyTi7ZzvrvpkuMo7GD1IhSspIHLblIddEUTU1uOhcmqvnFmY/F7WGaXtu
         UN5Bt7qXtKyczlPZWwIykqutSY3vhhrJ6mq9Q47kZpgns090DSbjTdVC1g8gpCL7k+40
         CydgjizonyMmzztqcRHy9WPIdvrzprU021ehOOscUUX0J2kwuloX4xmU2lpY3twmIOe6
         o5xvHpWrUf2a3mpoTFlSqSV3d0gi9CZVCmeO+/5uUlBKjIXmUjL7NKo9FYAATonwa8dz
         2mX3IvjjBOy15F7GzH/6z91b/rFvgMG5lD9yfqimFHMsksSNErMs2ACWMrIqjh3FIWtY
         DfzQ==
X-Gm-Message-State: AOAM530VTtbZivKMSNGgCwDfBvS2fPtf4+RW4bVTMTzURwPdeaQNJwn2
        /EJB3d3H6/5eWrndoJhjpax9p/70h3I=
X-Google-Smtp-Source: ABdhPJyzIVxFYZ1/GXlkf3n/kmYyBJr+MeyhIOAh338FrGlVxLmMKLQ2EkumBg5NaI0es2elDY/LfA==
X-Received: by 2002:a5d:6a43:0:b0:1e3:1830:802f with SMTP id t3-20020a5d6a43000000b001e31830802fmr12521864wrw.485.1645379673420;
        Sun, 20 Feb 2022 09:54:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm43063073wrm.105.2022.02.20.09.54.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:33 -0800 (PST)
Message-Id: <a6a8eb8e7bb4520bfe37d3a79329cce7886af59c.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:21 +0000
Subject: [PATCH 05/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
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

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 53 ++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index b8d53c48303..d9705062e9d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -25,45 +25,48 @@ Manage multiple working trees attached to the same repository.
 
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
-
-If a working tree is deleted without using `git worktree remove`, then
+path `../hotfix`. To instead work on an existing branch in a new worktree,
+use `git worktree add <path> <branch>`. On the other hand, if you just
+plan to make some experimental changes or do testing without disturbing
+existing development, it is often convenient to create a 'throwaway'
+worktree not associated with any branch. For instance,
+`git worktree add -d <path>` creates a new worktree with a detached `HEAD`
+at the same commit as the current branch.
+
+If a worktree is deleted without using `git worktree remove`, then
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
+If a linked worktree is stored on a portable device or network share which
+is not always mounted, you can prevent its administrative files from being
+pruned by issuing the `git worktree lock` command, optionally specifying
+`--reason` to explain why the worktree is locked.
 
 COMMANDS
 --------
 add <path> [<commit-ish>]::
 
-Create `<path>` and checkout `<commit-ish>` into it. The new working directory
-is linked to the current repository, sharing everything except working
-directory specific files such as `HEAD`, `index`, etc. As a convenience,
-`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
+Create `<path>` and checkout `<commit-ish>` into it. The new worktree
+is linked to the current repository, sharing everything except per-worktree
+files such as `HEAD`, `index`, etc. As a convenience, `<commit-ish>` may
+be a bare "`-`", which is synonymous with `@{-1}`.
 +
 If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
-- 
gitgitgadget

