Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910B21F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeEPB6n (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:58:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47360 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752357AbeEPB6l (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3A87C60745;
        Wed, 16 May 2018 01:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435920;
        bh=xkJiz0C5P03Pg4SnUyMDy7SpCw8ZpxXTxpQKICjKwQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Gy2oBdR1sZOcZJDbVxt2CjBNJ/AN5pzBH91qCNHiTYdMvqiVUurGzG6rdXgLpec23
         507wBFqw8ud6mrrJ4Ks6mEWJDSMib5JZLFED83mwAt7Cs4RBN02FIWDZcikmf7u/5d
         EYwTarY04dTO78oi6n2MhoBugoStOM4+kI8UsQamlOLkupWFzKHUrPE3ZPUwpoq0eM
         cGyBmSkPHoiyh+z9gRhxpb9pP3ldglMLeE7uHKY/UegiIdriBwMRKK383Sj2E4ZeQ4
         0Kwuy0z4OscxbLlygdB5q+WPlBv3QibnIWb/y1YxlvyaahkkvDdY2dubpQ6H4djqps
         bfS39Mi/lZzBfYEDEMFz1W/y6HHZbIJFNk21+ghVVOzZBZ/NfaGjcZja5xD3FFQexu
         LL+m3XcQ3oEHKNWRbTUyr3TsSGd2vPeZNMvq845AlhNYtJE7rLqMdfd8VF66pMMx0f
         3GbNoROZxzFdHQ//CXzsAC372JWaqgA2R/N3scy84+Lk7wwcYiu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 06/28] t0000: annotate with SHA1 prerequisite
Date:   Wed, 16 May 2018 01:56:08 +0000
Message-Id: <20180516015630.661349-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this is a core test that tests basic functionality, annotate the
assertions that have dependencies on SHA-1 with the appropriate
prerequisite.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0000-basic.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 7fd87dd544..af61d083b4 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -839,7 +839,7 @@ test_expect_success 'writing tree out with git write-tree' '
 '
 
 # we know the shape and contents of the tree and know the object ID for it.
-test_expect_success 'validate object ID of a known tree' '
+test_expect_success SHA1 'validate object ID of a known tree' '
 	test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
     '
 
@@ -882,7 +882,7 @@ test_expect_success 'showing stage with git ls-files --stage' '
 	git ls-files --stage >current
 '
 
-test_expect_success 'validate git ls-files output for a known tree' '
+test_expect_success SHA1 'validate git ls-files output for a known tree' '
 	cat >expected <<-\EOF &&
 	100644 f87290f8eb2cbbea7857214459a0739927eab154 0	path0
 	120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0	path0sym
@@ -900,7 +900,7 @@ test_expect_success 'writing tree out with git write-tree' '
 	tree=$(git write-tree)
 '
 
-test_expect_success 'validate object ID for a known tree' '
+test_expect_success SHA1 'validate object ID for a known tree' '
 	test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
 '
 
@@ -908,7 +908,7 @@ test_expect_success 'showing tree with git ls-tree' '
     git ls-tree $tree >current
 '
 
-test_expect_success 'git ls-tree output for a known tree' '
+test_expect_success SHA1 'git ls-tree output for a known tree' '
 	cat >expected <<-\EOF &&
 	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
 	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
@@ -924,7 +924,7 @@ test_expect_success 'showing tree with git ls-tree -r' '
 	git ls-tree -r $tree >current
 '
 
-test_expect_success 'git ls-tree -r output for a known tree' '
+test_expect_success SHA1 'git ls-tree -r output for a known tree' '
 	cat >expected <<-\EOF &&
 	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
 	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
@@ -943,7 +943,7 @@ test_expect_success 'showing tree with git ls-tree -r -t' '
 	git ls-tree -r -t $tree >current
 '
 
-test_expect_success 'git ls-tree -r output for a known tree' '
+test_expect_success SHA1 'git ls-tree -r output for a known tree' '
 	cat >expected <<-\EOF &&
 	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
 	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
@@ -964,7 +964,7 @@ test_expect_success 'writing partial tree out with git write-tree --prefix' '
 	ptree=$(git write-tree --prefix=path3)
 '
 
-test_expect_success 'validate object ID for a known tree' '
+test_expect_success SHA1 'validate object ID for a known tree' '
 	test "$ptree" = 21ae8269cacbe57ae09138dcc3a2887f904d02b3
 '
 
@@ -972,7 +972,7 @@ test_expect_success 'writing partial tree out with git write-tree --prefix' '
 	ptree=$(git write-tree --prefix=path3/subp3)
 '
 
-test_expect_success 'validate object ID for a known tree' '
+test_expect_success SHA1 'validate object ID for a known tree' '
 	test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2
 '
 
@@ -1006,7 +1006,7 @@ test_expect_success 'git read-tree followed by write-tree should be idempotent'
 	test "$newtree" = "$tree"
 '
 
-test_expect_success 'validate git diff-files output for a know cache/work tree state' '
+test_expect_success SHA1 'validate git diff-files output for a know cache/work tree state' '
 	cat >expected <<\EOF &&
 :100644 100644 f87290f8eb2cbbea7857214459a0739927eab154 0000000000000000000000000000000000000000 M	path0
 :120000 120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0000000000000000000000000000000000000000 M	path0sym
@@ -1033,21 +1033,21 @@ test_expect_success 'no diff after checkout and git update-index --refresh' '
 ################################################################
 P=087704a96baf1c2d1c869a8b084481e121c88b5b
 
-test_expect_success 'git commit-tree records the correct tree in a commit' '
+test_expect_success SHA1 'git commit-tree records the correct tree in a commit' '
 	commit0=$(echo NO | git commit-tree $P) &&
 	tree=$(git show --pretty=raw $commit0 |
 		 sed -n -e "s/^tree //p" -e "/^author /q") &&
 	test "z$tree" = "z$P"
 '
 
-test_expect_success 'git commit-tree records the correct parent in a commit' '
+test_expect_success SHA1 'git commit-tree records the correct parent in a commit' '
 	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
 	parent=$(git show --pretty=raw $commit1 |
 		sed -n -e "s/^parent //p" -e "/^author /q") &&
 	test "z$commit0" = "z$parent"
 '
 
-test_expect_success 'git commit-tree omits duplicated parent in a commit' '
+test_expect_success SHA1 'git commit-tree omits duplicated parent in a commit' '
 	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
 	     parent=$(git show --pretty=raw $commit2 |
 		sed -n -e "s/^parent //p" -e "/^author /q" |
