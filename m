Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585CEC433FE
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356417AbiASR3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347255AbiASR3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:29:44 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE82C06161C
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:29:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so6973514wms.3
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g/OwK2IGtJnN3AzhDkiQ7pdCzEjK1f95SeANY/cCZnA=;
        b=RX3uDR+p2ccrgPPkb/22JpXkRss4qe5XDv21Smq5qmojYwXzQbavMDSZHkcztVnnEi
         DLATXZiwVVQ6jlGy9at5NmrW5hjXX9SuA7MGXk5QTRCihTnJQl+FS9c+C152ii62W2Rh
         s5oSVWe8oYOjwHplZLqLzLjKy0PJr1Jp4nkoarCC/ULC2PhKvMw4gOyvn9hcf3Gj5zH6
         WU9uh1mjPfpOCt4SBaoF/ZaidBcR6J/H2+IbHa70RcmCHrNOHRKXmldqOw7Ul3h5lX1C
         Z1z5WgiLE2YkHn0aZKueCZwQs1e+toFyUHvLmasUCbx6NkKd4q825z9P0gCb4yA09rKc
         NMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g/OwK2IGtJnN3AzhDkiQ7pdCzEjK1f95SeANY/cCZnA=;
        b=TpHDfU0zCY+b4fuSfX2B59Fbf04z6SG/SVBQZ/rtsleMt90TaQiyCncT0h4rhW/4vL
         OFlLgUZP5VccHkgdXCGN7ziKgbhdpnOB6EHFuRVMVZLdG8q3CiHD3Tiwutpb+h0Dv5MO
         AjlIs/5LWTd/XDSQl2KZByHIVBoXyUidO/fH1go9wRkFRxoEIb88Ls1tIzNBPhN0g5Uy
         S/TMkWLBuP8tT/jmR3cRoxHNJMWwkg6SVRxJDn2gYeob9zceTvkcufoBRf4AqVnE7e7+
         ZxuTuHLeqJbA+k3a/MinIXlNqERLeLV9vPTiHF8lNZuV6kxjCFWDfovjiy0PmDOol079
         LiZw==
X-Gm-Message-State: AOAM5320pvQ70R1veJ8rQsUNSEJNZKJFWjrNZ8o/aKXPhU4krw5pNbuh
        yypJNN/fYxnVGyqnhnvRwaqj5W9rxv8=
X-Google-Smtp-Source: ABdhPJzcaqIfXmMoMcSqaWBJBRhGakE4nJg3OkuyUyGTcFxVnr0onzVI66IqZThF+CfVnWvjLECz6w==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr4707077wmc.76.1642613382697;
        Wed, 19 Jan 2022 09:29:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm673526wrc.51.2022.01.19.09.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:29:42 -0800 (PST)
Message-Id: <a8ec58b93244ef8f6303c06d83fff6bab5826515.1642613380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 17:29:38 +0000
Subject: [PATCH 2/3] t1091: disable split index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 61feddcdf28 (tests: disable GIT_TEST_SPLIT_INDEX for sparse index
tests, 2021-08-26), it was already called out that the split index
feature is incompatible with the sparse index feature, and its commit
message wondered aloud whether more checks would be required to ensure
that the split index and sparse index features aren't enabled at the
same time.

We are about to introduce such additional checks, and indeed, t1091
would utterly fail with them. Therefore, let's preemptively disable the
split index for the entirety of t1091.

This partially reverts above-mentioned patch because it covered only one
test case whereas we want to cover the entire test script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1091-sparse-checkout-builtin.sh | 54 ++++++++++++++----------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 42776984fe7..b229a8274d8 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -5,6 +5,9 @@ test_description='sparse checkout builtin tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+GIT_TEST_SPLIT_INDEX=false
+export GIT_TEST_SPLIT_INDEX
+
 . ./test-lib.sh
 
 list_files() {
@@ -228,36 +231,31 @@ test_expect_success 'sparse-checkout disable' '
 '
 
 test_expect_success 'sparse-index enabled and disabled' '
-	(
-		sane_unset GIT_TEST_SPLIT_INDEX &&
-		git -C repo update-index --no-split-index &&
-
-		git -C repo sparse-checkout init --cone --sparse-index &&
-		test_cmp_config -C repo true index.sparse &&
-		git -C repo ls-files --sparse >sparse &&
-		git -C repo sparse-checkout disable &&
-		git -C repo ls-files --sparse >full &&
-
-		cat >expect <<-\EOF &&
-		@@ -1,4 +1,7 @@
-		 a
-		-deep/
-		-folder1/
-		-folder2/
-		+deep/a
-		+deep/deeper1/a
-		+deep/deeper1/deepest/a
-		+deep/deeper2/a
-		+folder1/a
-		+folder2/a
-		EOF
+	git -C repo sparse-checkout init --cone --sparse-index &&
+	test_cmp_config -C repo true index.sparse &&
+	git -C repo ls-files --sparse >sparse &&
+	git -C repo sparse-checkout disable &&
+	git -C repo ls-files --sparse >full &&
 
-		diff -u sparse full | tail -n +3 >actual &&
-		test_cmp expect actual &&
+	cat >expect <<-\EOF &&
+	@@ -1,4 +1,7 @@
+	 a
+	-deep/
+	-folder1/
+	-folder2/
+	+deep/a
+	+deep/deeper1/a
+	+deep/deeper1/deepest/a
+	+deep/deeper2/a
+	+folder1/a
+	+folder2/a
+	EOF
+
+	diff -u sparse full | tail -n +3 >actual &&
+	test_cmp expect actual &&
 
-		git -C repo config --list >config &&
-		! grep index.sparse config
-	)
+	git -C repo config --list >config &&
+	! grep index.sparse config
 '
 
 test_expect_success 'cone mode: init and set' '
-- 
gitgitgadget

