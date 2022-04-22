Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD8C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443381AbiDVCfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443376AbiDVCfY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7054B412
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c10so9081102wrb.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tuHXimBwYebEU6fghwiMtrYIrfgCUPrazOHafCyQMTY=;
        b=VysN0HdK/9shrHabMauGCtN0/Ywq/bWxmJ1gprMblsrp8KYNLX++DUwh66uwAEs7mt
         TU1q/99E9AxwjaGLbKYz+vjYsAyExxY9JMlOKVPeCzR3ZXQO66LE4TIEb8eOsxonVsmY
         Nw4tOdME7kMKsEnVhyPNcqzAmqVNhEKjAMcxKgxAgZIrXEhQg4hwu+JGb2+ol8K7/+5L
         Tl/IXwUDCsqYK1qRrXBNZNtidVu4kA8pJY3yZ6OO8c/sW/eeDnNUaXDlvYs1v5RMIV+n
         BKR8o19DFlKq7sykup1kbaWNyG9j2MoOYIOpFZBvkPuDx82igJqQ8dOF1PBitEpb2T2i
         SeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tuHXimBwYebEU6fghwiMtrYIrfgCUPrazOHafCyQMTY=;
        b=d6voFe7v0k3hCDzavSb9YCtDY6UigPYtmu4fVici87XKipmGBTzKeDPlUs6Tm85bvL
         9KemU/5BSXdSkgFQIfQYSpaSLKNkSCZ4xeAGUFp4dGvXgTaIo+7XHd8awTx19f6hfBTs
         8YfS03skcwiUoME7FHkYQq1bDBUoaqsPHRu7beFP2cUKdXZM/FIvwKosoYWnQr96kFfm
         iuM3G+MavsYy3MVaUNPKqj3RBLPywloHYy9/kGKcNgbOP8Xti1bmjf8wbHnx/3b8uxoa
         CEeJZTJ7DyPE61eftXuZAkU4HTbDWfrXqHIs9mYKoce98gwQlI2VZIDqdmiZ/784Ss5H
         KPaQ==
X-Gm-Message-State: AOAM5321rbdETa3So/ouYv9SAnLiW3gllUSU5LNhIdEteSLZCUTuyQa4
        +b1OBkVNeKgVi/iwsDOMoC1atotiZ5w=
X-Google-Smtp-Source: ABdhPJxdSXw7MQYKHpiiJyvv17pMHMDXJwfcKycFWbZPTdodrw8KdIVUnCwJ3Z37jvIqarcj+O4R/A==
X-Received: by 2002:a5d:6dab:0:b0:20a:8684:cbc1 with SMTP id u11-20020a5d6dab000000b0020a8684cbc1mr1746464wrs.482.1650594750440;
        Thu, 21 Apr 2022 19:32:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000188400b0020a9ec6e8e3sm585146wri.55.2022.04.21.19.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:30 -0700 (PDT)
Message-Id: <d86c9179435a6f44446de525089c0fcb3df0b117.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:19 +0000
Subject: [PATCH v3 2/9] sparse-checkout: make --cone the default
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

Make cone mode the default, and update the documentation accordingly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/core.txt         |  6 ++++--
 Documentation/git-sparse-checkout.txt | 20 ++++++++++----------
 builtin/sparse-checkout.c             |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..03cf075821b 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -615,8 +615,10 @@ core.sparseCheckout::
 
 core.sparseCheckoutCone::
 	Enables the "cone mode" of the sparse checkout feature. When the
-	sparse-checkout file contains a limited set of patterns, then this
-	mode provides significant performance advantages. See
+	sparse-checkout file contains a limited set of patterns, this
+	mode provides significant performance advantages. The "non
+	cone mode" can be requested to allow specifying a more flexible
+	patterns by setting this variable to 'false'. See
 	linkgit:git-sparse-checkout[1] for more information.
 
 core.abbrev::
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 88e55f432f3..7308e744c57 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -22,8 +22,8 @@ present, or undo and go back to having all tracked files present in the
 working copy.
 
 The subset of files is chosen by providing a list of directories in
-cone mode (which is recommended), or by providing a list of patterns
-in non-cone mode.
+cone mode (the default), or by providing a list of patterns in
+non-cone mode.
 
 When in a sparse-checkout, other Git commands behave a bit differently.
 For example, switching branches will not update paths outside the
@@ -60,7 +60,7 @@ When the `--stdin` option is provided, the directories or patterns are
 read from standard in as a newline-delimited list instead of from the
 arguments.
 +
-When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
+When `--cone` is passed or `core.sparseCheckoutCone` is not false, the
 input list is considered a list of directories.  This allows for
 better performance with a limited set of patterns (see 'CONE PATTERN
 SET' below).  The input format matches the output of `git ls-tree
@@ -68,10 +68,9 @@ SET' below).  The input format matches the output of `git ls-tree
 double quote (") as C-style quoted strings.  Note that the set command
 will write patterns to the sparse-checkout file to include all files
 contained in those directories (recursively) as well as files that are
-siblings of ancestor directories. This may become the default in the
-future; --no-cone can be passed to request non-cone mode.
+siblings of ancestor directories.
 +
-When `--no-cone` is passed or `core.sparseCheckoutCone` is not enabled,
+When `--no-cone` is passed or `core.sparseCheckoutCone` is set to false,
 the input list is considered a list of patterns.  This mode is harder
 to use and less performant, and is thus not recommended.  See the
 "Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
@@ -227,10 +226,11 @@ patterns. The resulting sparse-checkout file is now
 Here, order matters, so the negative patterns are overridden by the positive
 patterns that appear lower in the file.
 
-If `core.sparseCheckoutCone=true`, then Git will parse the sparse-checkout file
-expecting patterns of these types. Git will warn if the patterns do not match.
-If the patterns do match the expected format, then Git will use faster hash-
-based algorithms to compute inclusion in the sparse-checkout.
+Unless `core.sparseCheckoutCone` is explicitly set to `false`, Git will
+parse the sparse-checkout file expecting patterns of these types. Git will
+warn if the patterns do not match.  If the patterns do match the expected
+format, then Git will use faster hash-based algorithms to compute inclusion
+in the sparse-checkout.
 
 In the cone mode case, the `git sparse-checkout list` subcommand will list the
 directories that define the recursive patterns. For the example sparse-checkout
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5518ed47f6c..61b7a7519bb 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -397,7 +397,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 
 	/* Set cone/non-cone mode appropriately */
 	core_apply_sparse_checkout = 1;
-	if (*cone_mode == 1) {
+	if (*cone_mode == 1 || *cone_mode == -1) {
 		mode = MODE_CONE_PATTERNS;
 		core_sparse_checkout_cone = 1;
 	} else {
-- 
gitgitgadget

