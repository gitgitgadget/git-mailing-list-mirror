Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079E7C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 04:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbiBPEVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:21:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245246AbiBPEVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 23:21:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4F193D1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:26 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i14so1303602wrc.10
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XS/de9nZ8Iv+oNlhfd/f9n9uf/JZJYBvZ/8IR+hcM2U=;
        b=i3ohrZb8WjdTX8fMMzlyOudnC3FgZJgn4X0KbfOyZJ87aMKIW5aGMSIAtzUcxrzUw3
         n/RA9OwcAkPJeRKXURXLEHL0gJCOPasWxsPeVMIIjfvjs0mxEIzG/5IUhVr9keYAIVZc
         q//rKwceZqR+eHCRn0mDV2HKg/s9PJkIksu7yQKMQPkLdeZ/kKHhc4Tfl2NFhKGzR0pn
         wyECmmnPE/GRT1s8ZRO4ds4b9tVCIG/5Lsgrha+Xq04C+7sLSZiQ+aXSPLFxfl04puVv
         IVWq74sryYizve5Ph01KKE+9shchqj3tRAGy37DhIH9ISJzJJuQRzYfeKBkDqJkKdckU
         yRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XS/de9nZ8Iv+oNlhfd/f9n9uf/JZJYBvZ/8IR+hcM2U=;
        b=q/AlqdDX6/EsZaAV9kRs3DCGZ56vdLZIs0bGaluKE0YRGlsTSZD0cDoz/RUN6mxP2T
         xaULsKnYLXhSeEtS/rvPhwXqHETyQIhmTe815JEqOKvp1BqLKRnQ33toNkQJUb81vGPK
         VK72/wVcD1gsgbeW+LyE0dNWRTnwJfQqhWbO0w5Gmpjo1EslWnS102lGUdkg2cJ7XgIl
         UXjWZZWuMlMYkB6FjZptOCmDV3qFpucoBX0B13fFyEAcCcRunabAF0oA5/c6NlfX+kFs
         gWbdl5Hwlt2bTmKaM9/5UnfFVwpwAXjhFI50XWk25PBGH5Cb9SX+9NjF/2rFetcvOZGc
         pbDg==
X-Gm-Message-State: AOAM530gi+fw8R6aUY1PtP27NzUXTKbR8zOD/DRhZ4+1NBuK/bpjRvP/
        WoCoyuokKa4Ebh17AcFm5mYM66L58iE=
X-Google-Smtp-Source: ABdhPJz0j2NolNChm8z9jfjSsBEfdPJ20J8NhoQpR+KNVqc+SQJ7stFr37oTuQ1HoQhKeEI/ySPeXQ==
X-Received: by 2002:a5d:5904:0:b0:1e3:3238:889 with SMTP id v4-20020a5d5904000000b001e332380889mr704405wrd.289.1644985285119;
        Tue, 15 Feb 2022 20:21:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm16305287wmk.16.2022.02.15.20.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:21:24 -0800 (PST)
Message-Id: <5215b7f7179824468da9476891833ff4cdb28404.1644985283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
        <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 04:21:19 +0000
Subject: [PATCH v3 1/5] sparse-checkout: correct reapply's handling of options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4e256731d6 ("sparse-checkout: enable reapply to take
--[no-]{cone,sparse-index}", 2021-12-14) made it so that reapply could
take additional options but added no tests.  Tests would have shown that
the feature doesn't work because the initial values are set AFTER
parsing the command line options instead of before.  Add a test and set
the initial value at the appropriate time.

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          |  6 +++---
 t/t1091-sparse-checkout-builtin.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a311483a7d2..fcd574f5fc1 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -789,15 +789,15 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 	if (!core_apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
+	reapply_opts.cone_mode = -1;
+	reapply_opts.sparse_index = -1;
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
 
 	repo_read_index(the_repository);
 
-	reapply_opts.cone_mode = -1;
-	reapply_opts.sparse_index = -1;
-
 	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
 		return 1;
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3592d124424..ce5e7c19efa 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -495,6 +495,34 @@ test_expect_failure 'sparse-checkout reapply' '
 	git -C tweak sparse-checkout disable
 '
 
+test_expect_success 'reapply can handle config options' '
+	git -C repo sparse-checkout init --cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --no-cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --cone --sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	index.sparse=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout disable
+'
+
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
-- 
gitgitgadget

