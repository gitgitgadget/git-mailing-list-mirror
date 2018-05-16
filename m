Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9DD81F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeEPB7Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752172AbeEPB65 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 78F5F6074B;
        Wed, 16 May 2018 01:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435937;
        bh=JKitOMEA2DJPCoKPis5FmlXHEw44cp0tLh+bvAWfwKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=x84Y4tegkV30KZZOB+bK86RsPu+Pn+JrY5omda29b7CsHvYS9vln2UiCiYEUgYTdw
         8R89ghODbuRxNScMSttfMfeOyUEPD3NDdJV6txbH15kgM9PtUp3SFFXkI2kYkNf8fl
         UybZXIdVguHLJvvLtRCeggfHaM12I8pMwcnsw5XLX1q8QEPHfgd5G76yMUJK0rUAck
         G4NgP3jBK9HfG5S0UeVqLonthRFI3MQFMME9TK9XDQpVV2icxqjAbmFRTdmRwLOlzl
         cxJHzlcDhH1RUiIS8PLZT37n4GUcmOjJKjULQReNG+dxoXxQ/nTBsdKxXiUwvF2j0Y
         Y15oS4UVEonE95nKLRg+1SXpdLDWT0ZuqcGuZbQ3pV1buGoa3B/mgga0W+8h+7liCd
         aZH5CYrl6IKhaTEhC40efQiBBAY+7DmiZwaCNJmM9aArJoaDKUi4EBx/oUBIzPQJIB
         jsBq+8MMgqDAQAFBtV4Kqy5zWEi28MuaZo9KdbtgQUgaLMzAOOR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 20/28] t4029: fix test indentation
Date:   Wed, 16 May 2018 01:56:22 +0000
Message-Id: <20180516015630.661349-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
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
