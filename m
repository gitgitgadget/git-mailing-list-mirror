Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37220C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbiBWO35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiBWO3z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44505B252C
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:27 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so3070212wme.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HnR3MbIKrJIoZ3DYzMGEr8XFfhJHemw/xfKFj5WjkYQ=;
        b=jkHchba8cujPTa2PcFfIo/ffYr6d9Jhjyvq/Hpg8n1VDlTwVhPto1SVDpjnBBO8/v4
         3RZD+VwmuExkN0Ib9n22KZIGntI+CeLewFiL5HmwPe2LrNmddtr0EW2nCXpGyjeLcW36
         Htnjc6x1f8gUjiiStBaVNxn7jp6ccmvZHreYZhYkRKTq16cFH+TLGJPIjn60Ck9dMQ51
         KK2OiKDS4gB9pgllUfMFvWF3RHV1VDxSI76UawpvJ4G+Ld4JAkelCvPey/U3PfwI0V4c
         qmGed1ANkcr3DFwi7Le1iRo3kAkg0myRQ8GNQePAnUBjoc5TiO9AaX/Gs3bFkVSQizHA
         AJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HnR3MbIKrJIoZ3DYzMGEr8XFfhJHemw/xfKFj5WjkYQ=;
        b=HjEtjCxH+36yJ/zEFtrNhTfG8jw+0dtfPPnFiFjvABEZUbam8IiGI83ICqsQJsWtBg
         4O2vOBKnJm7bQ0d3kVkfKk4cb56a7Cuc9aFC4tM5Q8WMcpH602itf+THvZ+QLRwVGpo+
         krngGt2iOhNb8M1CpuJ7WtRFKsUCiW4eL2laBGWgGKz7hYo7tv5UUvuCfXZikJV/BoA0
         4+W6rN82k26JJXQr9Htx42fIX1oI5wLoqKF22WhsHsfPPSfXX8QJNe6n+/8NPI3sNwIy
         hOXFadc+LdhAnHH5JEJL9o6MEQ84onMm7SZJxfBla1buKdQAXrb8IhrpddRhdLeejdWh
         ci0Q==
X-Gm-Message-State: AOAM532H/b0BGZ05ZfjIoSepn1PZr5ejo9NHbbC6yqGhiRIavXDtQzbT
        GGeOVTElFW78pT2BJoy7MibrnDUOrWI=
X-Google-Smtp-Source: ABdhPJw0EaZ+d3zEI6/f7Y4TSqceFiVjYs34/ilQ8N3DguKyYj2FgfgmiuHHe8u6VqAjz0hvAcbU8w==
X-Received: by 2002:a05:600c:1d28:b0:37c:a9d:d39f with SMTP id l40-20020a05600c1d2800b0037c0a9dd39fmr16594wms.172.1645626565552;
        Wed, 23 Feb 2022 06:29:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm49826430wrz.40.2022.02.23.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:25 -0800 (PST)
Message-Id: <4e66cf33648a965489508c4192a8f0a7f846266e.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:13 +0000
Subject: [PATCH v3 05/11] worktree: use 'worktree' over 'working tree'
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
index b8d53c48303..956c17c4306 100644
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
+The working tree, along with this metadata, is called a "worktree".
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
+If the working tree for a linked worktree is stored on a portable device
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

