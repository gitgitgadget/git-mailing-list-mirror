Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC15C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbhLHTng (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhLHTne (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:43:34 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B795C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:40:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so5860815wru.13
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5DIcA/rK56j1N1MDKr0SkoRx4hSRnncyQmOOHUYySdo=;
        b=bFVNtt+vx10QF7UDlNKaaw7A5sIapBLkUVeRSMZtqKC5y2mn+/OdRcXc5WVhhaLyVt
         RuVgekJWh6Abii9tDFiVyerRXn7EtsA9vpjsUzthgivJx3dMlVA/cMDmb7VpMnZWKlHe
         TxiUMdQVdoGVIQR4MHcmpHK0iMORrtXBJXrg8ZE0QstVHLnv0DBYK3XsUGN6v6hDp6Y0
         EPytK/KOzym3Y3/B/xKy/ID1A8Un9V8RPKUB3HceOLTrJfFlBQFuoJPn83Gh6zKzuSzp
         gW1rKoiSURr0Rj2GD7QNkAMPhySiGi2QvezviIU7bYvd5MlDVAPUb1tXbvY9ja/yGKZf
         gSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5DIcA/rK56j1N1MDKr0SkoRx4hSRnncyQmOOHUYySdo=;
        b=LRd9HvBrtxcOgB1kIQBYPCNqenh1qtMlqjGVyIEGFYO3zZsNXu8MpwFLnGD2tGScYF
         xD5+Wen3FxbCsf3ApoZDApFGI4sunq15TlxTJcTLucfWjmMwWUWCnComakJJXz+cq28R
         x0Qr8GTIxz6Z8wa9LGh3u+jZy+2WIBU8u3vkkm4AVWC0SnGAL6hO8vJCxaZ6P2P1JeJW
         mH7eiisxKsz+JqrGPWxCpziykMeHmBlpOvCYfMLSZgBqtJGUjD4o8MZtYYWp8FkVYVyj
         I1gK/cljuRWtA7biMPmcLu1a8RwWnhci5cIvqGNafC2N8dX/upgU5Qy4WANLz23Btb4Y
         ccNg==
X-Gm-Message-State: AOAM5329HkW+C5pL0CfLtKpPv3ngD4uobVT1/NNh7ceyvU8e7+zeKfct
        9ju2LFLvN2TwStNGs91caBzuvCNbk4E=
X-Google-Smtp-Source: ABdhPJxy+uw1UIZPDFLh0yqUgcu9YcvNr5j3EVD2/jICKrIJ8+HSfLfdcn5x4xrIygWcxxvJGZMHeQ==
X-Received: by 2002:adf:d1c1:: with SMTP id b1mr835804wrd.296.1638992400547;
        Wed, 08 Dec 2021 11:40:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm3539490wrn.15.2021.12.08.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:40:00 -0800 (PST)
Message-Id: <b98e5e6d2bc921ea76d8b5419d1f00e9db30a55a.1638992396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
        <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 19:39:54 +0000
Subject: [PATCH v2 4/5] t1091/t3705: remove 'test-tool read-cache --table'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that 'git ls-files --sparse' exists, we can use it to verify the
state of a sparse index instead of 'test-tool read-cache table'. Replace
these usages within t1091-sparse-checkout-builtin.sh and
t3705-add-sparse-checkout.sh.

The important changes are due to the different output format. In t3705,
wWe need to use the '--stage' output to get a file mode and OID, but
it also includes a stage value and drops the object type. This leads
to some differences in how we handle looking for specific entries.

In t1091, the test focuses on enabling the sparse index, so we do not
need the --stage flag to demonstrate how the index changes, and instead
can use a diff.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 25 ++++++++++++++++++++-----
 t/t3705-add-sparse-checkout.sh     |  8 ++++----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..680e0043c36 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -212,12 +212,27 @@ test_expect_success 'sparse-index enabled and disabled' '
 
 		git -C repo sparse-checkout init --cone --sparse-index &&
 		test_cmp_config -C repo true index.sparse &&
-		test-tool -C repo read-cache --table >cache &&
-		grep " tree " cache &&
-
+		git -C repo ls-files --sparse >sparse &&
 		git -C repo sparse-checkout disable &&
-		test-tool -C repo read-cache --table >cache &&
-		! grep " tree " cache &&
+		git -C repo ls-files --sparse >full &&
+
+		cat >expect <<-\EOF &&
+		@@ -1,4 +1,7 @@
+		 a
+		-deep/
+		-folder1/
+		-folder2/
+		+deep/a
+		+deep/deeper1/a
+		+deep/deeper1/deepest/a
+		+deep/deeper2/a
+		+folder1/a
+		+folder2/a
+		EOF
+
+		diff -u sparse full | tail -n +3 >actual &&
+		test_cmp expect actual &&
+
 		git -C repo config --list >config &&
 		! grep index.sparse config
 	)
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index f3143c92908..81f3384eeed 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -181,13 +181,13 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
-	test-tool read-cache --table >actual &&
-	grep "^100644 blob.*sparse_entry\$" actual &&
+	git ls-files --stage >actual &&
+	grep "^100644 .*sparse_entry\$" actual &&
 
 	git add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
-	test-tool read-cache --table >actual &&
-	grep "^100755 blob.*sparse_entry\$" actual &&
+	git ls-files --stage >actual &&
+	grep "^100755 .*sparse_entry\$" actual &&
 
 	git reset &&
 
-- 
gitgitgadget

