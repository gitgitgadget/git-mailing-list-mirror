Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FA4200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeEFXTD (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41188 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752007AbeEFXSx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 458886076C;
        Sun,  6 May 2018 23:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648731;
        bh=JKitOMEA2DJPCoKPis5FmlXHEw44cp0tLh+bvAWfwKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ysXxZQ0llTtj0ybEs31BUoQ3tjP8K0rFXWPmOfLAmPtOkhc6ncn5nXbhrKvpJUKih
         sGjdjvUgqazhD/fYjnU0bSyuD8EktWhjY6Zj7tl5y6Emx0nTJY/gjWQr/6LQMLesh2
         a+PhYI6x/DSM3X0f/ofJk9hok8XJu6p6B+2vzqQr9dCb1K9xyAR+LLNMDFowApnygj
         j2Aorb69SzeYUpcB9tdHZok+mz+uwQCZRBJh8XvQCFxWbZ2EgR73YzrLNPJ96ZgnIv
         YMbh9drZNUVATFZGh8ZPAOEKdE4pcwrnm6M46XuHeMwXCBmi45QvVkSs2RG4YutMIU
         HPjXyMnZkIS7T5KV0QfNxT4JaPXy2vv+66G6YNGMuI17qz2e6KcG9DWu+pLisYuhDu
         qruhqE+H2bivzvxS1Ue1XRzGpxyyJawCPsLtBRDMv6emy0lgyu5GweJciXA2Yc1AZR
         lTCwXJGdjwAoC1IBUDaBJ20mv9+mMGX0jfrrgrJZ6U7tpLZAof8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 20/28] t4029: fix test indentation
Date:   Sun,  6 May 2018 23:17:44 +0000
Message-Id: <20180506231752.975110-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We typically indent our tests with a single tab, partially so that we
can take advantage of indented heredocs.  Make this change and move the
quote marks to be in the typical position for our tests.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4029-diff-trailing-space.sh | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 3ccc237a8d..f4e18cb8d3 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -18,22 +18,21 @@ index 5f6a263..8cb8bae 100644
 EOF
 exit 1
 
-test_expect_success \
-    "$test_description" \
-    'printf "\nx\n" > f &&
-     git add f &&
-     git commit -q -m. f &&
-     printf "\ny\n" > f &&
-     git config --bool diff.suppressBlankEmpty true &&
-     git diff f > actual &&
-     test_cmp exp actual &&
-     perl -i.bak -p -e "s/^\$/ /" exp &&
-     git config --bool diff.suppressBlankEmpty false &&
-     git diff f > actual &&
-     test_cmp exp actual &&
-     git config --bool --unset diff.suppressBlankEmpty &&
-     git diff f > actual &&
-     test_cmp exp actual
-     '
+test_expect_success "$test_description" '
+	printf "\nx\n" > f &&
+	git add f &&
+	git commit -q -m. f &&
+	printf "\ny\n" > f &&
+	git config --bool diff.suppressBlankEmpty true &&
+	git diff f > actual &&
+	test_cmp exp actual &&
+	perl -i.bak -p -e "s/^\$/ /" exp &&
+	git config --bool diff.suppressBlankEmpty false &&
+	git diff f > actual &&
+	test_cmp exp actual &&
+	git config --bool --unset diff.suppressBlankEmpty &&
+	git diff f > actual &&
+	test_cmp exp actual
+'
 
 test_done
