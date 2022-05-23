Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE1FC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiEWNtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiEWNs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:48:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32854F98
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p19so363431wmg.2
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U5UspuwgHVBqo7FpE1+kOE+FRDR7ixKr1UpHpeCL9Ig=;
        b=c/D8yrmpq0wPs/aCBPf7r5Qyc7E2WWbzJ/E/66gG0mL1N7Xu8ajcZOLqQiblRi7XMt
         02Ld7y4W+0uQKDVruAhQeiDZwuvNLV+7yCsGetGJkL+gGQ/XSNtVPhZibL7D8y0AR8jw
         BLQ+kG0Kw+U4Z/AlAukA2jmyOcX8tV50wjcid7AgjQXS64FgzThRqjtqNRZ69dJ0QuF1
         /XOmJcTJKUBi8oqA62UCLWTizV7CSXm3GmQt7AWsBwk11aMJRo5MRQ7XuFq745Kfi0sM
         2zrCdn0yruk1+48wisX1hyW//qAVTAfJR4CzTVudCCmVQrXi0EL8ALDKX2tsEgdOgZ62
         h9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U5UspuwgHVBqo7FpE1+kOE+FRDR7ixKr1UpHpeCL9Ig=;
        b=b8bAEZjN+JaLVbsidbGQb7oCsQtxbieBGCLA1hJBsirPr1/cR3bDj6SBpT3u0H0g0q
         8lh5MCyTRBqRd0mktkWsRX1wbQ3pmd1JnOEVLEMAnKmQl8enaZcBZE/f/DpFahVO+/+d
         e8othFzoBU3JKhpvuIBUia39gOALlW7LVe8wH768HXBnxArWjWmkKbzIOnGOe4cIWh9o
         XV3GAYE7HjIvSKvfW7yyId4WwOVLpPRCImFNvPQ2at3cWWwlVymiDalLb1HbEyLyIWsu
         YGN8pta1K65E33DWz8qklq9n/Us4xdoQQQK8mF/3teWZGBKaKvTO1RfNyBGc/fxiVfNX
         hpsQ==
X-Gm-Message-State: AOAM530ueELTrZWMPOoTNtJ+7yKZSn+0CyiDhiP12hbIGqWJUiTzxuH2
        07sYJg0ASAv21WtolhzoydDb89WDSo4=
X-Google-Smtp-Source: ABdhPJzOM3pGfzJgTNnSaG9U5e+OzM+jrVDQbr71yor4vks8ifIzrhCc9aXDTlczhQQQ4zk7lBDdqg==
X-Received: by 2002:a05:600c:4144:b0:394:1972:1a73 with SMTP id h4-20020a05600c414400b0039419721a73mr19896439wmm.71.1653313731022;
        Mon, 23 May 2022 06:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6-20020adfc846000000b0020d02cbbb87sm10257265wrh.16.2022.05.23.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:50 -0700 (PDT)
Message-Id: <5030eeecf4f8e2dd65bc055d6a720c7d67015b1e.1653313726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:38 +0000
Subject: [PATCH v3 02/10] t1092: stress test 'git sparse-checkout set'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'sparse-index contents' test checks that the sparse index has the
correct set of sparse directories in the index after modifying the cone
mode patterns using 'git sparse-checkout set'. Add to the coverage here
by adding more complicated scenarios that were not previously tested.

In order to check paths that do not exist at HEAD, we need to modify the
test_sparse_checkout_set helper slightly:

1. Add the --skip-checks argument to the 'set' command to avoid failures
   when passing paths that do not exist at HEAD.

2. When looking for the non-existence of sparse directories for the
   paths in $CONE_DIRS, allow the rev-list command to fail because the
   path does not exist at HEAD.

This allows us to add some interesting test cases.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e7c0ae9b953..785820f9fd5 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -212,7 +212,7 @@ test_sparse_unstaged () {
 test_sparse_checkout_set () {
 	CONE_DIRS=$1 &&
 	SPARSE_DIRS=$2 &&
-	git -C sparse-index sparse-checkout set $CONE_DIRS &&
+	git -C sparse-index sparse-checkout set --skip-checks $CONE_DIRS &&
 	git -C sparse-index ls-files --sparse --stage >cache &&
 
 	# Check that the directories outside of the sparse-checkout cone
@@ -228,7 +228,9 @@ test_sparse_checkout_set () {
 	# are not sparse directory entries.
 	for dir in $CONE_DIRS
 	do
-		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
+		# Allow TREE to not exist because
+		# $dir does not exist at HEAD.
+		TREE=$(git -C sparse-index rev-parse HEAD:$dir) ||
 		! grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done
@@ -253,6 +255,19 @@ test_expect_success 'sparse-index contents' '
 		"deep/deeper2 folder1 folder2 x" \
 		"before deep/deeper1" &&
 
+	# Replace deep/deeper2 with deep/deeper1
+	# Replace folder1 with folder1/0/0
+	# Replace folder2 with non-existent folder2/2/3
+	# Add non-existent "bogus"
+	test_sparse_checkout_set \
+		"bogus deep/deeper1 folder1/0/0 folder2/2/3 x" \
+		"before deep/deeper2 folder2/0" &&
+
+	# Drop down to only files at root
+	test_sparse_checkout_set \
+		"" \
+		"before deep folder1 folder2 x" &&
+
 	# Disabling the sparse-index replaces tree entries with full ones
 	git -C sparse-index sparse-checkout init --no-sparse-index &&
 	test_sparse_match git ls-files --stage --sparse
-- 
gitgitgadget

