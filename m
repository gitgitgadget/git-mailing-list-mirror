Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D51AC433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbhLGUXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhLGUXq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125C6C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:16 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so2625878wmj.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=++i8bvpEQV9IEDgXdPdBMtBxyVJZ3SyDhXm5PZ2BsFo=;
        b=n0Pud3hQFYsfIxBA8GEHxh3BYCgnMeoba7BsmuwaKl97Z9hqOJIRB5hlnWwQshbXN/
         6XJIydVVk5Bbm8YSc+JaE6BtyUZeYLxOEKNYjWXbnFA+wDYsKf/l/SIjdlU8bCGhEPmR
         TTaRsvVgztm1qJPkn2OUhxFvwFpKHb/bxKt2SojO5SRYDS2Br7R457TRq43GfKWyJcug
         GFzlXr0/051VEg1w4SHBmSI4hQWcM5pFjJiOdI9TbQlvFNKIBvvI/KwPk587vHcskrqD
         m5d9ebGtYY/uoeH+WjzI8/G4b4mwOuoCVY04tOOtH++l4xu8myA4i9X0s+cuE2GUIfn1
         rlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=++i8bvpEQV9IEDgXdPdBMtBxyVJZ3SyDhXm5PZ2BsFo=;
        b=xN4NOYTSEyptLe82WDwQ4Cuk0mBMF3EOl1xhZR86ATO/7cKVd2tUEWRh3Ak6PNddqL
         nbCMQGW4ykC5A2pxEVPmByOI8x3Bvb5/rzZZk0MYz0jhKKmP/1TTvaaRHdKckNMQM1mg
         fj8yivV3Nf32zyFpxq2yZj7QqZ/HR6m76uWBkbuD/AmchSogGHs/5oSoSwwzmSD9aAYa
         wK44jX9zcpI4WHk67L8BZntBXHsHn3l7ICbzufrDZj08969cNAs6Koxd3tN7ybYauPtQ
         iqqnfyRQRclc2kLhTlpyCslGciwMH8sC4peRxDMNP0QjbCjGszgwWoEAIaitH2xRy8XN
         mSYg==
X-Gm-Message-State: AOAM530IET4ABk8TPbWSDoW7SVOu4OJWnLTfqjrQacm/+XMQuRSL1bW1
        iekTksy8conAEvVaQrj93w7bh7uN1e4=
X-Google-Smtp-Source: ABdhPJwk4wGpSOqOAbJwZubhOA1X5Z8wxgU89bZEdJd1oBkiyNaq9vvUl20bHTxaknFJ3TQqLDjayg==
X-Received: by 2002:a05:600c:500a:: with SMTP id n10mr10275430wmr.136.1638908414457;
        Tue, 07 Dec 2021 12:20:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k27sm3996025wms.41.2021.12.07.12.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:13 -0800 (PST)
Message-Id: <bade5e52390081ff04e0de823027d89edb2ad89a.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:03 +0000
Subject: [PATCH v2 03/10] sparse-checkout: add sanity-checks on initial
 sparsity state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Most sparse-checkout subcommands (list, add, reapply, disable)
only make sense when already in a sparse state.  Add a quick check
that will error out early if this is not the case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 12 ++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e252b82136e..e9f644ac362 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -56,6 +56,9 @@ static int sparse_checkout_list(int argc, const char **argv)
 	char *sparse_filename;
 	int res;
 
+	if (!core_apply_sparse_checkout)
+		die(_("this worktree is not sparse"));
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_list_options,
 			     builtin_sparse_checkout_list_usage, 0);
@@ -671,6 +674,9 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (!core_apply_sparse_checkout)
+		die(_("no sparse-checkout to add to"));
+
 	repo_read_index(the_repository);
 
 	argc = parse_options(argc, argv, prefix,
@@ -719,6 +725,9 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	if (!core_apply_sparse_checkout)
+		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
@@ -740,6 +749,9 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	struct pattern_list pl;
 	struct strbuf match_all = STRBUF_INIT;
 
+	if (!core_apply_sparse_checkout)
+		die(_("no active sparse-checkout to disable"));
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_disable_options,
 			     builtin_sparse_checkout_disable_usage, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..90a281bcf64 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -41,7 +41,15 @@ test_expect_success 'setup' '
 	)
 '
 
-test_expect_success 'git sparse-checkout list (empty)' '
+test_expect_success 'git sparse-checkout list (not sparse)' '
+	test_must_fail git -C repo sparse-checkout list >list 2>err &&
+	test_must_be_empty list &&
+	test_i18ngrep "this worktree is not sparse" err
+'
+
+test_expect_success 'git sparse-checkout list (not sparse)' '
+	git -C repo sparse-checkout set &&
+	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout list >list 2>err &&
 	test_must_be_empty list &&
 	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
-- 
gitgitgadget

