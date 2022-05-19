Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD9C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbiESRxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbiESRx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F8A333
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e28so7656208wra.10
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JOe9/xcyWlPygpRg9fHBknYEcVKDUlk3pocQHkD5gJA=;
        b=pmQ/ScgbX/fshVsVdFeDaaL3K83mSreor28S9N+cvQjcuSWHAraPMPigVnKudYWJ7m
         2GxGBAzt/ys1eWkHztdQnT+WYUgIHkC1p92y4F/R5hgCA9UJdObEKpIw1uvLWgGLPWAa
         E/Wa7zoqUjF+iXW7KTuYqfHmzwwO7w5hGZ+cBO6Ns9NtZ7iqnyCMD/XA556a809YxwNV
         F7390kf0zFoRBTMHX1nVTuqa3Oh0bhcofknY2uyBkP4A8uOTjWCVxjUvV9qIUZo6VpIY
         IMe5+zgfvYCXkXh4i2Nuv7/gWdyiSZYT9LG5IdiLqp/c+wVFFpIo514R0mJ3PM4U0yQZ
         I+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JOe9/xcyWlPygpRg9fHBknYEcVKDUlk3pocQHkD5gJA=;
        b=lGsxJhJiMFLmQcqprucRiFrjWtLgisnnTq1V6kw5hQihETt41xUQ4q1hJq7n5QyV4m
         3CQ3NuzPR7/OPAN1iHUAWeyk2viAAFKmDMbki2ORtvEH2STBTeEM2odxY48MM41wD+tN
         JXQKyfb1C5eyyOyJ7nQtuNdnz4Vn5ZSinCoD+l4XjPYeF7Pc/IcfTt96Gl8Hc0cJbO5u
         TG1+Tkciq0MoWf4J28aZEyS38Up+CHMS5kkRVHG6y1mjmWfOwEm2z0MFrAaOEnGib3UD
         7DCTtDviqQLSRcIxZTKHJnO7zt3igwTfTBK1Y6Nh/ERE7rdWW2a+WZEjjuLvfbrYJ8fL
         Af8A==
X-Gm-Message-State: AOAM533YBPJjXHZ5WQrX7Q+HnPNuv7EGNGqKLw9mfzoN40f67iYUEyTM
        bXE7lPZW/IPCg39tpe+kYMwu6x8LrHs=
X-Google-Smtp-Source: ABdhPJwBnKx+7VGDuRKpzyLHEZ1A/KJC8GkSjBAmKmeu1VbInjzyZ73SM2ncK2ai6KyIIpqc8NXF4A==
X-Received: by 2002:adf:d23b:0:b0:20e:69df:5f02 with SMTP id k27-20020adfd23b000000b0020e69df5f02mr3686850wrh.138.1652982761444;
        Thu, 19 May 2022 10:52:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15-20020adfb30f000000b0020d12936563sm188920wrd.108.2022.05.19.10.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:41 -0700 (PDT)
Message-Id: <f2960747ed868d57bc2eccfbe49d284f5268aba4.1652982758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:29 +0000
Subject: [PATCH v2 01/10] t1092: refactor 'sparse-index contents' test
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

Before expanding this test with more involved cases, first extract the
repeated logic into a new test_sparse_checkout_set helper. This helper
checks that 'git sparse-checkout set ...' succeeds and then verifies
that certain directories have sparse directory entries in the sparse
index. It also verifies that the in-cone directories are _not_ sparse
directory entries in the sparse index.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 53 ++++++++++++++++--------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 93bcfd20bbc..e7c0ae9b953 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -205,36 +205,53 @@ test_sparse_unstaged () {
 	done
 }
 
-test_expect_success 'sparse-index contents' '
-	init_repos &&
-
+# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
+# Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
+# leaves the sparse index in a state where <s1> ... <sM> are sparse
+# directories (and <c1> ... <cN> are not).
+test_sparse_checkout_set () {
+	CONE_DIRS=$1 &&
+	SPARSE_DIRS=$2 &&
+	git -C sparse-index sparse-checkout set $CONE_DIRS &&
 	git -C sparse-index ls-files --sparse --stage >cache &&
-	for dir in folder1 folder2 x
+
+	# Check that the directories outside of the sparse-checkout cone
+	# have sparse directory entries.
+	for dir in $SPARSE_DIRS
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
 		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
-	git -C sparse-index sparse-checkout set folder1 &&
-
-	git -C sparse-index ls-files --sparse --stage >cache &&
-	for dir in deep folder2 x
+	# Check that the directories in the sparse-checkout cone
+	# are not sparse directory entries.
+	for dir in $CONE_DIRS
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 $TREE 0	$dir/" cache \
+		! grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
-	done &&
+	done
+}
 
-	git -C sparse-index sparse-checkout set deep/deeper1 &&
+test_expect_success 'sparse-index contents' '
+	init_repos &&
 
-	git -C sparse-index ls-files --sparse --stage >cache &&
-	for dir in deep/deeper2 folder1 folder2 x
-	do
-		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 $TREE 0	$dir/" cache \
-			|| return 1
-	done &&
+	# Remove deep, add three other directories.
+	test_sparse_checkout_set \
+		"folder1 folder2 x" \
+		"before deep" &&
+
+	# Remove folder1, add deep
+	test_sparse_checkout_set \
+		"deep folder2 x" \
+		"before folder1" &&
+
+	# Replace deep with deep/deeper2 (dropping deep/deeper1)
+	# Add folder1
+	test_sparse_checkout_set \
+		"deep/deeper2 folder1 folder2 x" \
+		"before deep/deeper1" &&
 
 	# Disabling the sparse-index replaces tree entries with full ones
 	git -C sparse-index sparse-checkout init --no-sparse-index &&
-- 
gitgitgadget

