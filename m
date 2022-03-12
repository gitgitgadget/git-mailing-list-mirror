Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E84C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiCLDM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiCLDMq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B8E293F1A
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e24so15539456wrc.10
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WvOGUgp3KlNUpexDxJbvxFaTaBKndFtN2ht1BZqMMqs=;
        b=k8OPLRFYWroyrwTmsshLowUxLAKfhSY0y029AtjhSVFKB+PCwOhBqcuzLhv6GhdPgs
         NVtk5fAPpl4ZqVCiXVicMFBCv6yiN57nJtjhQyX4k/+JRkoNPP+9UrNm0O89WGiH3/LM
         TIurEFxcdkjq6kMl3RCNC0h6v4IOmUS6sX57RtiQk2W4dFuBAkJba9FQauq08oUndoF+
         Qrw3FXTe5c1OJmDzvwPl6bhyl8Gum3Zcu19bYxVmedD/sPbnYDUmvgZsVcjM6ebXZWqy
         yUrBydUYQPkEoMHmNbI4tCvBVOIoTgSiAfluWPfdwKL8Tsb8+VK2w03FhDQkyrhNas2N
         JkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WvOGUgp3KlNUpexDxJbvxFaTaBKndFtN2ht1BZqMMqs=;
        b=kWlhcurUuax02l3+jtiV4DykSJ8X+5W12/oYkXLAQHQ4B1FeRdTaweXakJsL1EbGZE
         I//tlVuWuMhFCoIrjEk/Yqw2Pa4uE7jexOGemmCjGZBik7xbMn4akPNFYb50oOYEw3Iu
         iT75HhDrxt73CLyxfw3WXGTq7LFNYAtIbgGFo9rFxcDKPGrH/VOTbR1wshtpWtmbrAsz
         KoF4aJG+ryVuwbg8pKJbaUC7CWr9KxYIrHEjxuR6/f+DgboBF90MbRHPKaJxG7mzHrcN
         9wGQUJyTZZbZYnjkJVZfmcdT9Z7A05Wagm8am9YqOeGxJb6j1ZekanHxY1Q3vVlVQikS
         GemQ==
X-Gm-Message-State: AOAM533T2WMOumlKo1OhmLJFKJJBBLD/xc3+9nbQbDAiK26XNtmswQbT
        yPki12bgfENxWvqsRIqb2yllxruq5e8=
X-Google-Smtp-Source: ABdhPJyLuo5VFrtpd6kPzfRPyFAr2gOaWV3lcsvKtJouRUVSybMPqfR8t2Ot1MgDttB8tYheBlx8Sg==
X-Received: by 2002:a05:6000:137a:b0:1f1:d6ec:7b69 with SMTP id q26-20020a056000137a00b001f1d6ec7b69mr8989838wrz.78.1647054690055;
        Fri, 11 Mar 2022 19:11:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b0020373b34961sm7733326wrs.66.2022.03.11.19.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:29 -0800 (PST)
Message-Id: <4b89a3392b04acccf28f09f90e26715140461373.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:21 +0000
Subject: [PATCH v2 9/9] Documentation: some sparsity wording clarifications
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Improve the wording for a couple paragraphs in two different manuals
relating to sparse behavior.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-read-tree.txt       |  9 +++++----
 Documentation/git-sparse-checkout.txt | 10 +++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 99bb387134d..cbafb1aed49 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -375,10 +375,11 @@ have finished your work-in-progress), attempt the merge again.
 SPARSE CHECKOUT
 ---------------
 
-Note: The `update-index` and `read-tree` primitives for supporting the
-skip-worktree bit predated the introduction of
-linkgit:git-sparse-checkout[1].  Users are encouraged to use
-`sparse-checkout` in preference to these low-level primitives.
+Note: The skip-worktree capabilities in linkgit:git-update-index[1]
+and `read-tree` predated the introduction of
+linkgit:git-sparse-checkout[1].  Users are encouraged to use the
+`sparse-checkout` command in preference to these plumbing commands for
+sparse-checkout/skip-worktree related needs.
 
 "Sparse checkout" allows populating the working directory sparsely.
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index aaf3ae63853..e4a29a2baa9 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -15,11 +15,11 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This command is used to create sparse checkouts, which means that it
-changes the working tree from having all tracked files present, to only
-have a subset of them.  It can also switch which subset of files are
-present, or undo and go back to having all tracked files present in the
-working copy.
+This command is used to create sparse checkouts, which change the
+working tree from having all tracked files present to only having a
+subset of those files.  It can also switch which subset of files are
+present, or undo and go back to having all tracked files present in
+the working copy.
 
 The subset of files is chosen by providing a list of directories in
 cone mode (the default), or by providing a list of patterns in
-- 
gitgitgadget
