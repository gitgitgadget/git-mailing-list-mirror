Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40CAC433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbiBWOaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241591AbiBWOaK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:30:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F45B2537
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id x15so5550415wrg.8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HiXIkm4cHe98fj3FpEpl6TXuWwF8f4XR2Am620N6e+c=;
        b=G1sYfsKr7SIOd3AWn/Q+Rz7Wb6X9PNXiTntDf5AzFyVTs31ytH6C4Iy8k0OhVY5TnP
         8hgEF9cC2HYChRCA5fI39e5WofYVsJTk1ahi3WbInFsJJ7og8tTI6YU0Wqrjz8imFL98
         ANaPBSMKvWnG1qXR+mrvxjnL4u54QQ1YhoRN/kgDMyqamQqCbU4bttl079XS83vdli79
         IC1f1BI4L/je0LqyLdLyhI1DyLqxeL4mrDs+TZ9bLTsPJcjDM/J7sikFYauFy9P2NGmc
         08HGCOZYNuryN9yWvKbDH9AA94gVbzs9RRTn34+riu3gkP4KxZCD1JjfdRXWRaiPOPU2
         4afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HiXIkm4cHe98fj3FpEpl6TXuWwF8f4XR2Am620N6e+c=;
        b=pGd90f7BA5YHgEqOE8n4Zkk5DLBwxrOtHm6U9dC3zHfdlHpzLxvLaM7+Zaa8QI+JcP
         CmXVUoaFrQdHe4sel9KhJ1JQv6HAlfdynTz9RdH73zg3lAR5/a2NB32UXw0gKxswjtlY
         pg83tBhjEHPrHMYt+U1QBHy/SNxKQlmBC2HgqH8aDPcbPQA14CYszhP0hNXaBkoP6wtC
         sVVwnqB2/ADz5mLSZUkpog2K5PYycIxqi66SKNjRrADEVl2tJjUZbLxnDHj4lqvvCC+H
         Or8CCEEMn79pwK9B02RTb3qUcuTk5eJjU9d49i8kTN5YktZyuKMcZYNPHtrGZv8N1vex
         C7xw==
X-Gm-Message-State: AOAM533//ozQlJ3Mb/esrq3hkLcPeWM+5F/2TePspv4UE/zpmxF3gSPv
        NFpIWfQw0HnTEVDL5FqUZqYsQO20iaQ=
X-Google-Smtp-Source: ABdhPJyxfxcXalv0ELQBrD0OIfC1hDH/fdrYUcGLZQHOLbO7g5Wi4DVLVKkxeH0rhHFyiu3U5/dePQ==
X-Received: by 2002:a5d:59ae:0:b0:1dd:66c3:c67b with SMTP id p14-20020a5d59ae000000b001dd66c3c67bmr23064598wrr.400.1645626569402;
        Wed, 23 Feb 2022 06:29:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm31349489wri.74.2022.02.23.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:29 -0800 (PST)
Message-Id: <c9afb58d967a8c051a573306730f9902f9266e33.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:17 +0000
Subject: [PATCH v3 09/11] worktree: use 'worktree' over 'working tree'
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

This is the fifth of multiple changes to git-worktree.txt, restricted to
the CONFIGURATION FILE section.

While here, clear up some language to improve readability.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 563c93a1bc4..a1ee5c43f1d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -284,13 +284,13 @@ which will handle refs correctly.
 
 CONFIGURATION FILE
 ------------------
-By default, the repository `config` file is shared across all working
-trees. If the config variables `core.bare` or `core.worktree` are
-present in the common config file and `extensions.worktreeConfig` is
-disabled, then they will be applied to the main working tree only.
+By default, the repository `config` file is shared across all worktrees.
+If the config variables `core.bare` or `core.worktree` are present in the
+common config file and `extensions.worktreeConfig` is disabled, then they
+will be applied to the main worktree only.
 
-In order to have configuration specific to working trees, you can turn
-on the `worktreeConfig` extension, e.g.:
+In order to have worktree-specific configuration, you can turn on the
+`worktreeConfig` extension, e.g.:
 
 ------------
 $ git config extensions.worktreeConfig true
@@ -303,16 +303,16 @@ versions will refuse to access repositories with this extension.
 
 Note that in this file, the exception for `core.bare` and `core.worktree`
 is gone. If they exist in `$GIT_DIR/config`, you must move
-them to the `config.worktree` of the main working tree. You may also
-take this opportunity to review and move other configuration that you
-do not want to share to all working trees:
+them to the `config.worktree` of the main worktree. You may also take this
+opportunity to review and move other configuration that you do not want to
+share to all worktrees:
 
  - `core.worktree` should never be shared.
 
  - `core.bare` should not be shared if the value is `core.bare=true`.
 
- - `core.sparseCheckout` is recommended per working tree, unless you
-   are sure you always use sparse checkout for all working trees.
+ - `core.sparseCheckout` should not be shared, unless you are sure you
+   always use sparse checkout for all worktrees.
 
 See the documentation of `extensions.worktreeConfig` in
 linkgit:git-config[1] for more details.
-- 
gitgitgadget

