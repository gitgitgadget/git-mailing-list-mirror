Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD46C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiCLDMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiCLDMe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB762923FA
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h15so15566705wrc.6
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LBs+toRKrNAeFvILpMVU2ojoAq4HAqoAo1bWvbw2bbg=;
        b=JYTYh/EaygBgAfKLUZMD/931apAKNkcH6lEJBJ+NVoO1gft04rkCZV1sV6NL8Hp9E5
         d9IFdnzjKQnpKnSxS3sedVXX4R12VnW/R7s1aZ7F2ejnmbvdhgdzYNSCnsy5QeF+15qO
         uzt4k6T+W64dGRsw1gMNBu+P6Q29dewPr628WjjYkfVC4f4z/8X5O1zXO42X0h+O//VI
         eWOm961nvpa6wmkXyGIpDKXEvVPrZaXNgaaKFVQVv4EHFogGftBJVz+VkPsd7Vv8CATT
         JcKZSr3tHXvnlH3mz8N920NvDMNl2wKN8Yzr/z5qIEqEbxmIHra5zAkgi08QWMN1ZzhU
         Rmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LBs+toRKrNAeFvILpMVU2ojoAq4HAqoAo1bWvbw2bbg=;
        b=PqPMMYAG7zrB7Zqoh4lNlRx5p787iFz7U5U6gzY1dzmrMkdz8h5HWTO4VbLXWWiNFS
         gWxvMTbVmbV1D8rDLvxBEclaOJy5fpP3Xm5HAAvlKFkf3G54+XV3LcyD+1V/hUdmOMg6
         j8fXyjNVgMuFyj3DS+W2Ae8d7jNrFN2xePXxQu6EzUsEIaOhq1cUEjKQNtGmLurdyj5k
         UxdXQmJ0MqRP1boyQZT/WXJqefjLYAcl2oNBJz87Gq5HeKQ9+1/FTqzTKR6nfmQZ9/Ea
         UJMye76DCFjYvH9R8q4scJV9mvnqaHOJFTgfr3M6QXsbPLQrAKY7LO+6cy9sGuPe/Qvu
         jO0Q==
X-Gm-Message-State: AOAM532J783fuDBO40X4jSERHm+u3LFcwgsI5SA7CSSmxc6WUEP3NuvU
        P2V3S93Aazi6o2wmwxR146A7VSDVyKI=
X-Google-Smtp-Source: ABdhPJyDpZMBlzZ8XAhjNLv8RfqDk3a3g3ZqZUyYjL/bFZAxRBZrg7YSflQFe7G6EwCpW3jV4Xu1CQ==
X-Received: by 2002:adf:ab09:0:b0:1f0:1208:5123 with SMTP id q9-20020adfab09000000b001f012085123mr9147896wrc.146.1647054687014;
        Fri, 11 Mar 2022 19:11:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3-20020a1ca103000000b0038993e53be7sm11720166wme.39.2022.03.11.19.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:26 -0800 (PST)
Message-Id: <7333198b7785ff4ab6d424b3384c9e4d264e96b2.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:17 +0000
Subject: [PATCH v2 5/9] git-sparse-checkout.txt: shuffle some sections and
 mark as internal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

With cone mode as the default, it makes sense to discuss it before
non-cone mode.  Also, the new default means we can just use directories
in most cases and users do not need to understand patterns or their
meanings.  Let's take advantage of this to mark several sections as
"INTERNALS", notifying the user that they do not need to know all those
details in order to make use of the sparse-checkout command.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 44 +++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b9e44e3dd4c..883b7f4c44f 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -136,8 +136,8 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
 the disable command, so the easy restore of calling a plain `init`
 decreased in utility.
 
-SPARSE CHECKOUT
----------------
+INTERNALS -- SPARSE CHECKOUT
+----------------------------
 
 "Sparse checkout" allows populating the working directory sparsely.  It
 uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell Git
@@ -161,24 +161,8 @@ To repopulate the working directory with all files, use the
 `git sparse-checkout disable` command.
 
 
-FULL PATTERN SET
-----------------
-
-By default, the sparse-checkout file uses the same syntax as `.gitignore`
-files.
-
-While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
-files are included, you can also specify what files are _not_ included,
-using negative patterns. For example, to remove the file `unwanted`:
-
-----------------
-/*
-!unwanted
-----------------
-
-
-CONE PATTERN SET
-----------------
+INTERNALS -- CONE PATTERN SET
+-----------------------------
 
 The full pattern set allows for arbitrary pattern matches and complicated
 inclusion/exclusion rules. These can result in O(N*M) pattern matches when
@@ -256,8 +240,24 @@ use `git add` and `git commit` to store them, then remove any remaining files
 manually to ensure Git can behave optimally.
 
 
-SUBMODULES
-----------
+INTERNALS -- FULL PATTERN SET
+-----------------------------
+
+By default, the sparse-checkout file uses the same syntax as `.gitignore`
+files.
+
+While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
+files are included, you can also specify what files are _not_ included,
+using negative patterns. For example, to remove the file `unwanted`:
+
+----------------
+/*
+!unwanted
+----------------
+
+
+INTERNALS -- SUBMODULES
+-----------------------
 
 If your repository contains one or more submodules, then submodules
 are populated based on interactions with the `git submodule` command.
-- 
gitgitgadget

