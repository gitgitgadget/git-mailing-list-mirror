Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66ABC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443404AbiDVCfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443394AbiDVCfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D354B843
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so5624807wra.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cQ7VO46HxU83KepgllzaoRvWa6YiqCIJUR2hs7SH9Ec=;
        b=lfT98ftimT20EkXoLE0GZmSwV9Zj8TyioIBa2WWfwpSEv49xmM+Z+8TZM1pEQgofKb
         ZIHYcc9dTrRFwVeq+IZ9RF7kMOoULwo5O0edFBVr/8FH30W98UO/aegtElJgKZXvMiA+
         IrJ5MLIC8ZOaYExq6vMjXTkRMuh5SP9/Lia1HvxPzzRMB7VwFq99arqWlNRR41jETb+j
         19WPptGINi+l+U36w85zHgN2uRBPBrcLdt6nT0uIdpOdqAKCQpg//bA2gu3lnNlrFRQC
         pDJHG5n/N+Q+A5rJZB3F0veI3e95JmiZZ3/7IGI25PYK0O4dmuNfFautjqKCssDQX+qf
         OrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=cQ7VO46HxU83KepgllzaoRvWa6YiqCIJUR2hs7SH9Ec=;
        b=fWKGhTI7r8Ve8QqI5HS3PiflzZK/PWW21lmQO9o+VRCdMCbJTOkU+j9gC5T95R+LEf
         f9BXx1zJ62fBvR04Zx2azRSJId7R554FSfuGI50wrp4AUt7yLmPBHc70Q0yMiStTj7s5
         v9nsPfVhWJEwrNCNGob/H2NVh3KBkRS4VddipEdtivpemJMSSaXr13EFqXNk0v3pZhSu
         19+hst65iXcwyeisH3LWXTT42aIu8Q6JoCAIedOWHqQwYaBGbyyuRDNfL7vL724BBzEH
         AdUzD/wMQ7CCRHpH0gk1rWgEwYaFpqiDZdVhd4dAMj3JPZfo4dsugS5PlzCnkG9po8RX
         bOfQ==
X-Gm-Message-State: AOAM531+PK2R592gZ7d5EgoDN23ahUspYETae7qwFYgpy2AtdZr3Eo9n
        aPHYNK8XSysfK8E5EOV6gp5VXbvNzoQ=
X-Google-Smtp-Source: ABdhPJx6H5vS9A1a0DMLJlOZJi/kDyspD+BTFgx01rOwYGgfR5b+XveH7U4ADss9qq4D+8EUvQxnDA==
X-Received: by 2002:a5d:56c9:0:b0:20a:c54c:70e2 with SMTP id m9-20020a5d56c9000000b0020ac54c70e2mr1738195wrw.415.1650594757815;
        Thu, 21 Apr 2022 19:32:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003928e8e85eesm530100wmq.10.2022.04.21.19.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:37 -0700 (PDT)
Message-Id: <5f0e80777de6d4dcb245f3f0281cd31cac497cbc.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:26 +0000
Subject: [PATCH v3 9/9] Documentation: some sparsity wording clarifications
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
 Documentation/git-read-tree.txt       | 11 +++++++----
 Documentation/git-sparse-checkout.txt | 10 +++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 99bb387134d..d255807798c 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -375,10 +375,13 @@ have finished your work-in-progress), attempt the merge again.
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
+sparse-checkout/skip-worktree related needs.  However, the information
+below might be useful to users trying to understand the pattern style
+used in non-cone mode of the `sparse-checkout` command.
 
 "Sparse checkout" allows populating the working directory sparsely.
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index c65d0ce96bb..3776705bf53 100644
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
