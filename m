Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E978C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377054AbiFVRIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377221AbiFVRIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 13:08:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E23841F94
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:07:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e5so9616056wma.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9MOFaYwhklN9xn7mLOAluO+dbLKOFASu1V7ufKm4Nhc=;
        b=e4umDT6EZ0DXMUaZW29rGov2ZwRhhMiCOq3mKtK+Cdr/nwZQWQZH2JLBB5LCJqOSZA
         xe2BrQEiJns3w/p99Ck13/ulqh9W0Ckagf1XVV48QIjh6/1zv442MOeW1Xn5ktXFRcDI
         4pu4JdgP/T4k5SJJw8yFarAAYAKzvPd5oZ9w2EyOTfZN5ks2cn+n22ytuuuhFKco090T
         45QC/rPJuAo8QobmPbZSafP8u09PIHLx2RlhxOL0zlCtgIXjqECHs9KkLKrwRagiRUxR
         GHDR0aOuT5fOqrJqA5uGpaeHJDA1jL9yaOT6O9IFp+iL3nb0RcBq4U+sPO7TDVvSOWLE
         ll9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9MOFaYwhklN9xn7mLOAluO+dbLKOFASu1V7ufKm4Nhc=;
        b=XZroMbxSrehxZxA/CYx+qv+3GdaNMV/+v9tIu4G++WOVJik9U7XTs20ZRRuZWF71sW
         5Ni0vAiyOP2hsMvjd115GxpUlL7LPF4vBFdtnF0/4mplhivB3kpFN04t9ovUPRKwIx53
         X3RkVWqWKM87GQ1kjxxhS3BwFCmStlm/KVTDklnM6vEWNR0hI75+hRfWTduQMEnvnOSo
         TWZNMjL8jc0k99qzSQlAsd+bLujcvf9e8SP+PiOB/OU93EGEJHDj34ugL6Gfwf1h+KXz
         ojH5vCpF49DwfPEC7l0Pqg7yJDT7MxtXneiQm64NLY6Vle1tVeZkUQn9twK/FAZJ2VTE
         zgaw==
X-Gm-Message-State: AOAM531PuugpiZAP1c5SnTuRbMOcf2vec4Z1WQe6hxPnsb/X00G4pi8n
        EEXsCMjxOJY8A2FREOJgWFT455sd3uUB9A==
X-Google-Smtp-Source: ABdhPJwew+OkzPPqOf9Jz/4GSvC414BMd3iBPwwrAckSAI/1CVbvS5mUqMf/wXEjdmCVe6oRFETWjg==
X-Received: by 2002:a05:600c:4e91:b0:39c:7f1e:fb00 with SMTP id f17-20020a05600c4e9100b0039c7f1efb00mr47656327wmq.81.1655917632402;
        Wed, 22 Jun 2022 10:07:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cl10-20020a5d5f0a000000b0021b92171d28sm10236971wrb.54.2022.06.22.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:07:11 -0700 (PDT)
Message-Id: <525958af877c3bbd024ffd3aee0c64e469c3d6cf.1655917628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1278.v3.git.git.1655917628.gitgitgadget@gmail.com>
References: <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
        <pull.1278.v3.git.git.1655917628.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlos=20L=C3=B3pez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 17:07:08 +0000
Subject: [PATCH v3 2/2] tests: add tests for grep --max-count
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Martin =?UTF-8?Q?=C3=85gren?= [ ]" <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>,
        "Carlos L." <00xc@protonmail.com>,
        =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>

Add tests for grep's -m / --max-count to check if the option correctly
outputs limited results, and that it interacts properly with other flags
that could likely be used in conjunction.

Signed-off-by: Carlos López 00xc@protonmail.com
---
 t/t7810-grep.sh | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 69356011713..7b1b8a3cd93 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -77,6 +77,7 @@ test_expect_success setup '
 	# Say hello.
 	function hello() {
 	  echo "Hello world."
+	  echo "Hello again."
 	} # hello
 
 	# Still a no-op.
@@ -595,6 +596,88 @@ test_expect_success 'grep --files-without-match --quiet' '
 	test_must_be_empty actual
 '
 
+cat >expected <<EOF &&
+EOF
+
+test_expect_success 'grep --max-count 0 (must exit with non-zero)' '
+	test_must_fail git grep --max-count 0 foo >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF &&
+file:foo mmap bar
+EOF
+
+test_expect_success 'grep --max-count 1' '
+	git grep --max-count 1 foo >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF &&
+file:foo mmap bar
+file:foo_mmap bar
+file:foo_mmap bar mmap
+EOF
+
+test_expect_success 'grep --max-count 3' '
+	git grep --max-count 3 foo >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF &&
+file:foo mmap bar
+file:foo_mmap bar
+file:foo_mmap bar mmap
+file:foo mmap bar_mmap
+file:foo_mmap bar mmap baz
+EOF
+
+test_expect_success 'grep --max-count -1 (no limit)' '
+	git grep --max-count -1 foo >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF &&
+file-foo mmap bar
+file:foo_mmap bar
+file-foo_mmap bar mmap
+EOF
+
+test_expect_success 'grep --max-count 1 --context 2' '
+	git grep --max-count 1 --context 1 foo_mmap >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF &&
+hello.ps1=function hello() {
+hello.ps1:  echo "Hello world."
+EOF
+
+test_expect_success 'grep --max-count 1 --show-function' '
+	git grep --max-count 1 --show-function Hello hello.ps1 >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF &&
+hello.ps1=function hello() {
+hello.ps1:  echo "Hello world."
+hello.ps1:  echo "Hello again."
+EOF
+
+test_expect_success 'grep --max-count 2 --show-function' '
+	git grep --max-count 2 --show-function Hello hello.ps1 >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF &&
+hello.ps1:1
+EOF
+
+test_expect_success 'grep --max-count 1 -c' '
+	git grep --max-count 1 --count Hello hello.ps1 >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 file:foo mmap bar_mmap
 EOF
-- 
gitgitgadget
