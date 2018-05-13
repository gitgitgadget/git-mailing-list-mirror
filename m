Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6FC1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEMCZ4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45350 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751879AbeEMCZx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0A6BC60747;
        Sun, 13 May 2018 02:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178351;
        bh=JKitOMEA2DJPCoKPis5FmlXHEw44cp0tLh+bvAWfwKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fdeTgr+9TtYU2oerGxsQKbe4CSQauVj6aX+aS7xxSvLkJgxXl2mZrhiMgudBLmGbW
         3Zt8FBS6W4pLgTaKEKJMGPtWuCrpDQyv4PJ9XiXOdBJX0AZkxTEg+QQTvfpPOAzTxm
         6ouvPzYa4l3LhCqCTzugMuHJAR51QJGIykDkwHD5Mp7CbVsN39IfwDZw108DCZY/Mg
         9HSgt8B51vXHKDcE+wv2Hf8neQDUyFxrX6rE/TgIbmLFexa1DeOi6CLY4uWzIO67xh
         G41OFZ0KHxL31A3UBHYQ2CMWRnvK7sEtOxyOzv1g5vfRu7qjb9SZIb0WJtHrywmQz5
         igySpoLes0WEf07WtjGyEEINa6zVHbcSz706zXJ5Iy++Mdu1BOgv9SsGWVRUvU81aA
         TCTSxk+QEYmDNgONzWC1iNOeXBT5BFGGsXkTY52Py/kUaaJx+fvCaBTkXUoUAYjdBS
         cePQ+W7weCvnKvv5OQMAmZd7+ynDdzUPOMfPBV1CrhvY9P2HXK6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 20/28] t4029: fix test indentation
Date:   Sun, 13 May 2018 02:24:30 +0000
Message-Id: <20180513022438.60003-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
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
