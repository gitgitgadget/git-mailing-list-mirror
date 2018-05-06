Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA2D200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEFXSj (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41090 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751913AbeEFXSh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E063E60764;
        Sun,  6 May 2018 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648716;
        bh=2CW6DsDUo3CJrhCXrqIW39V/06xwog/BDysVrtZLHL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=C2zXMrFZnP/PqTkEBaE1mNY/9Eu4ri6x0VHmqUJ4JSS4hz9vkxdUhF+pLvoZflNP5
         Awoda12M1wKrhZm2iwrZ+vrrMk6gbtV1K6/Uh60tLx5+C8HIRTl0rhmtNu72WnXBVG
         Zr9EdQzlJcYZp2asM7cYsaBU6PrlNZyIDnPj16GCZCLM2eOkxW+M5CQldmJPlexCga
         UC6KRZA8QNreN/tPy3UEzG54/EcJq9/8IjYyy3r47HmUoso4r6Ol+LfF0wGcwpw+zs
         OBdvs4xtodLIgDj+kyZKhAhlyipK0VHuC6liTPh/06F8VeCP1df1QhTCTCAXkShZWs
         wgFeVcB1WMy1y0d9ETDCl5egwST0MdeQWe41VNLvBb6GirIke4HQr28AO+iZt0a018
         r6KxmitVSTTyFqa/oJFPmEzDcQWMwiou4VoEREIM8c0NOjADBJerMl/8s8y0BToTJM
         aRM+/0qC0srbpHZaAufivC6u0NMK40V2QLnz83qoymS2TtsRDq8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 07/28] t1007: annotate with SHA1 prerequisite
Date:   Sun,  6 May 2018 23:17:31 +0000
Message-Id: <20180506231752.975110-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
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
 t/t1007-hash-object.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 532682f51c..a37753047e 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -9,13 +9,13 @@ echo_without_newline() {
 }
 
 test_blob_does_not_exist() {
-	test_expect_success 'blob does not exist in database' "
+	test_expect_success SHA1 'blob does not exist in database' "
 		test_must_fail git cat-file blob $1
 	"
 }
 
 test_blob_exists() {
-	test_expect_success 'blob exists in database' "
+	test_expect_success SHA1 'blob exists in database' "
 		git cat-file blob $1
 	"
 }
@@ -73,19 +73,19 @@ test_expect_success "Can't use --path with --no-filters" '
 
 push_repo
 
-test_expect_success 'hash a file' '
+test_expect_success SHA1 'hash a file' '
 	test $hello_sha1 = $(git hash-object hello)
 '
 
 test_blob_does_not_exist $hello_sha1
 
-test_expect_success 'hash from stdin' '
+test_expect_success SHA1 'hash from stdin' '
 	test $example_sha1 = $(git hash-object --stdin < example)
 '
 
 test_blob_does_not_exist $example_sha1
 
-test_expect_success 'hash a file and write to database' '
+test_expect_success SHA1 'hash a file and write to database' '
 	test $hello_sha1 = $(git hash-object -w hello)
 '
 
@@ -161,7 +161,7 @@ pop_repo
 for args in "-w --stdin" "--stdin -w"; do
 	push_repo
 
-	test_expect_success "hash from stdin and write to database ($args)" '
+	test_expect_success SHA1 "hash from stdin and write to database ($args)" '
 		test $example_sha1 = $(git hash-object $args < example)
 	'
 
@@ -176,14 +176,14 @@ example"
 sha1s="$hello_sha1
 $example_sha1"
 
-test_expect_success "hash two files with names on stdin" '
+test_expect_success SHA1 "hash two files with names on stdin" '
 	test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object --stdin-paths)"
 '
 
 for args in "-w --stdin-paths" "--stdin-paths -w"; do
 	push_repo
 
-	test_expect_success "hash two files with names on stdin and write to database ($args)" '
+	test_expect_success SHA1 "hash two files with names on stdin and write to database ($args)" '
 		test "$sha1s" = "$(echo_without_newline "$filenames" | git hash-object $args)"
 	'
 
