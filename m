Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A15C433FE
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiCLDMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiCLDMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325AD2923FA
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r6so15155574wrr.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q3lmpojNTUhIT4ILYP6U+/G5YmRuM4xjjI0UIV8e920=;
        b=P17B224gvUFAVFq/pImPIQHQc0UllaAm93Ouad+QRwI31SV9GlcMcQL53SZqxD6p/g
         AlwD06Ly2+RhDHRX0ccNYz05r8l0ql9582iF2HnzTd3CvBk1NPek4QaKGMeyp7cjhmz+
         xbxzaz6HXdLPu3iiS97ObJ3Qv/c3j+1b4XN0k6fz3cZ5HizKaWwQZ8OCQtXp+SzwnmUV
         u2t01egQJf/L0Bk7ON4ep1UbuVMVWRRh2jJ4st75D69P66zyvUflibK75jZa2EcwEs7n
         OKae/Fqb2UBXFsxa8DzfqzEXp4ALT8rS3XsTOFcWl3gst0ZoXkZZYO1DrL+se0BWP3X3
         rkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q3lmpojNTUhIT4ILYP6U+/G5YmRuM4xjjI0UIV8e920=;
        b=IZgqjd/b98pL+SXzS+gln8I8IK92LHwdpdDEczDgdf5LbS5qeSeFGQUt4xLFsLyFga
         9T14LcgvuSZP+S960Bf55Ajoo375clcnrY2tldKRCT0HqIEnFhIFf78yAzJ0mpRO1O6P
         C31+RHn0JVJmXOukxRTRf0QgkwYF3TDKOwXrA5x+6zYvRmMtsIr19AU+rPBsN+YGnMxM
         dT9en5fm3QWYPNNPznVtzsOnW5eHjXPYvpxKwR4QUmcD7PI/nKsVG3H7GNwzLQiRAcWD
         LNn4s6XVEmdRiAhykCEDcylyPF8tQbbsFx6NU4K+ECn61cBgrMYFvLZzV1WExAbJaY8D
         OGiA==
X-Gm-Message-State: AOAM531JdOeTIIOWpcaxjZAnRBVUuHdZpRBk8XXfz5hfnM8VmaEx/VCF
        ixur7GojGhDbTIj++I0ykWIMnYWerko=
X-Google-Smtp-Source: ABdhPJwkZPIADdiiC8xml08+mxAOjv/WpaDfvKNNn7H58mrS9Sk969lXfH/EYH3VGx5l1odOAKM8bA==
X-Received: by 2002:a5d:584a:0:b0:203:97f6:5975 with SMTP id i10-20020a5d584a000000b0020397f65975mr3679345wrf.612.1647054684652;
        Fri, 11 Mar 2022 19:11:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm7959389wrm.53.2022.03.11.19.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:24 -0800 (PST)
Message-Id: <a53179764bc5d411726a095a587ea728aa9a20d3.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:14 +0000
Subject: [PATCH v2 2/9] sparse-checkout: make --cone the default
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
 Documentation/git-sparse-checkout.txt | 20 ++++++++++----------
 builtin/sparse-checkout.c             |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 88e55f432f3..4ef03120797 100644
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
+When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
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
+If `core.sparseCheckoutCone=true` (set by default or with an explicit
+`--cone`), then Git will parse the sparse-checkout file expecting
+patterns of these types. Git will warn if the patterns do not match.  If
+the patterns do match the expected format, then Git will use faster
+hash-based algorithms to compute inclusion in the sparse-checkout.
 
 In the cone mode case, the `git sparse-checkout list` subcommand will list the
 directories that define the recursive patterns. For the example sparse-checkout
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5518ed47f6c..6603a0cc029 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -397,7 +397,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 
 	/* Set cone/non-cone mode appropriately */
 	core_apply_sparse_checkout = 1;
-	if (*cone_mode == 1) {
+	if (*cone_mode) { /* also handles "not specified" (value of -1) */
 		mode = MODE_CONE_PATTERNS;
 		core_sparse_checkout_cone = 1;
 	} else {
-- 
gitgitgadget

