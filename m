Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129781F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeCYTVa (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42516 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751840AbeCYTVW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 03E066099C;
        Sun, 25 Mar 2018 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005681;
        bh=shSbYfwGjHxUxUjw1P81XqbJgTgwDCHsqmUc6XQ5xew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=RLMQXctbKD6jF/Z5hnhgTafNgC6DoFF5SEi0BAfBco/gQ1DyP6X/+WgbhifnsJJf+
         +dZj7yC8HscXLOFRwYdeDtcA1G5QtBQSmEpt+5BclpkEoAi15HCqm5vUcbW2GAjQCf
         mhgAShP7XqD+cBispEi+t9myymaI3S61oqIvs/vIWXVySPQDi6sxVLcQaaLcco1p78
         3whAtASW8cnGwUlLxi4d2RtvbDl1y+LNGvPCB0TsDAvDzHbU0XLbPg/giVOwbXsYBI
         YnF3gZM3jH/u1R4U0oBuLaqy/AwD7La4o3QJBy5XFoZKpTsDkUyLhMD5kyK+KSijzk
         HfiH9XOgpPiX15g7HlTmmwv5zCmdIlPXhqPjxWfEWN78L+4ceBvSR9Z3e0JEBt5DN3
         sPAPakgL7xFR7UX8fM5ngkhbqaduedoPKI+nEtJ1m25CA9Db3jsY8somZrG336pZdu
         46x1ged70LRChuM1lnCQyZojPld7hUI3NXhfUIgOMNzqRCgMN1K
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 08/10] t2101: modernize test style
Date:   Sun, 25 Mar 2018 19:20:53 +0000
Message-Id: <20180325192055.841459-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our tests start with the opening quote of the test body on the
same line as the test_expect_success call.  Additionally, our tests are
usually indented with a single tab.  Update this test to be the same as
most others, which will make it easier to use inline heredocs in the
future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2101-update-index-reupdate.sh | 52 ++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index c8bce8c2e4..168733a3c7 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -12,15 +12,16 @@ cat > expected <<\EOF
 100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	file1
 100644 9db8893856a8a02eaa73470054b7c1c5a7c82e47 0	file2
 EOF
-test_expect_success 'update-index --add' \
-	'echo hello world >file1 &&
-	 echo goodbye people >file2 &&
-	 git update-index --add file1 file2 &&
-	 git ls-files -s >current &&
-	 cmp current expected'
+test_expect_success 'update-index --add' '
+	echo hello world >file1 &&
+	echo goodbye people >file2 &&
+	git update-index --add file1 file2 &&
+	git ls-files -s >current &&
+	cmp current expected
+'
 
-test_expect_success 'update-index --again' \
-	'rm -f file1 &&
+test_expect_success 'update-index --again' '
+	rm -f file1 &&
 	echo hello everybody >file2 &&
 	if git update-index --again
 	then
@@ -29,16 +30,18 @@ test_expect_success 'update-index --again' \
 	else
 		echo happy - failed as expected
 	fi &&
-	 git ls-files -s >current &&
-	 cmp current expected'
+	git ls-files -s >current &&
+	cmp current expected
+'
 
 cat > expected <<\EOF
 100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
 EOF
-test_expect_success 'update-index --remove --again' \
-	'git update-index --remove --again &&
-	 git ls-files -s >current &&
-	 cmp current expected'
+test_expect_success 'update-index --remove --again' '
+	git update-index --remove --again &&
+	git ls-files -s >current &&
+	cmp current expected
+'
 
 test_expect_success 'first commit' 'git commit -m initial'
 
@@ -46,8 +49,8 @@ cat > expected <<\EOF
 100644 53ab446c3f4e42ce9bb728a0ccb283a101be4979 0	dir1/file3
 100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
 EOF
-test_expect_success 'update-index again' \
-	'mkdir -p dir1 &&
+test_expect_success 'update-index again' '
+	mkdir -p dir1 &&
 	echo hello world >dir1/file3 &&
 	echo goodbye people >file2 &&
 	git update-index --add file2 dir1/file3 &&
@@ -55,30 +58,33 @@ test_expect_success 'update-index again' \
 	echo happy >dir1/file3 &&
 	git update-index --again &&
 	git ls-files -s >current &&
-	cmp current expected'
+	cmp current expected
+'
 
 cat > expected <<\EOF
 100644 d7fb3f695f06c759dbf3ab00046e7cc2da22d10f 0	dir1/file3
 100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
 EOF
-test_expect_success 'update-index --update from subdir' \
-	'echo not so happy >file2 &&
+test_expect_success 'update-index --update from subdir' '
+	echo not so happy >file2 &&
 	(cd dir1 &&
 	cat ../file2 >file3 &&
 	git update-index --again
 	) &&
 	git ls-files -s >current &&
-	cmp current expected'
+	cmp current expected
+'
 
 cat > expected <<\EOF
 100644 594fb5bb1759d90998e2bf2a38261ae8e243c760 0	dir1/file3
 100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
 EOF
-test_expect_success 'update-index --update with pathspec' \
-	'echo very happy >file2 &&
+test_expect_success 'update-index --update with pathspec' '
+	echo very happy >file2 &&
 	cat file2 >dir1/file3 &&
 	git update-index --again dir1/ &&
 	git ls-files -s >current &&
-	cmp current expected'
+	cmp current expected
+'
 
 test_done
