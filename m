Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61E61F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeCQH4G (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:06 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32957 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbeCQH4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:03 -0400
Received: by mail-lf0-f65.google.com with SMTP id x205-v6so18550280lfa.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FsiXudfk+2n/yViR1l1cTzXFwViF8wjcyUocIrizPY=;
        b=Nyu+2N7gGFb+/XEWmT30/Jk325K7ij24nZtaEpMO7Z7YcHu3SzpcDFg5aUbyD78eO8
         DrEoL/lQkoX43EilUyahVoxV16SX4xaXls3lA8XlUp7oqKhVPWYqu1vdcoOSJbcMY9X6
         KN32blNLAK9b1lnVCkHacMbb1Jlh739BtgrcEvvVmYVvKrPpYwVuRhwcuocqS3o/TBeq
         3UMhknENWOSCKHregy4rTVmTwLhgwIXwZS8JB5YYOqy5wFdx4cs12Y/O++JAkei7NsiX
         DEx7qCjN6qTW6BrgyYh5E50mPr/2j9J7FUJfCIAfcGJEuSMXCgU/dwDgVpdhzCNiQ1L/
         KLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FsiXudfk+2n/yViR1l1cTzXFwViF8wjcyUocIrizPY=;
        b=QX5ckqWZWaot4k0DrEHjyOxE1pf8bLxJlSWt6cnTZN7F8a5YBX/3sRv4kIWchXP90S
         baogmEfQyagHmi7zs86fmRqABFxL0Un/ywMYUONoUnZLDIy9HFiD4UUcSuAEJoVy5hTk
         ghlm5UzAFH2UIkenTI3Ij0PGGb6MAthOv0+ynObyTbDI7+JwpphbluG7s2kCv22bXthg
         TStHGeIsSI322yr731SBJ0jbW4ZlLERf0ndkQpg2eHSd6L6eU+1bpFYU8Wy+djDNTbSG
         Tr1EdnlBJheaY7mvJVXj4My7CisGBqxWyHLBulIEXyvBl0bkQnsENn2l7+nSVBAgXAll
         L+NA==
X-Gm-Message-State: AElRT7GnzrJXgrpoEkN5nB7u+aSv0ADbT8NWZTManAKIJHGBAIefN40/
        9yhahKrSVfZLY9PAEGsKTQj8RQ==
X-Google-Smtp-Source: AG47ELtDqpVesPTHdJBLKmOwzK1+utEh2ciKAgvAvK/hR+sIS2ND1LRANDsrMZowaNn5tfdI2Z68VA==
X-Received: by 2002:a19:5789:: with SMTP id l131-v6mr3414311lfb.135.1521273361762;
        Sat, 17 Mar 2018 00:56:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:56:01 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 28/36] t/helper: merge test-sha1-array into test-tool
Date:   Sat, 17 Mar 2018 08:54:13 +0100
Message-Id: <20180317075421.22032-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                   |  2 +-
 t/helper/test-sha1-array.c |  3 ++-
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/t0064-sha1-array.sh      | 16 ++++++++--------
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index ba7c7d8a79..b50a0818a9 100644
--- a/Makefile
+++ b/Makefile
@@ -677,6 +677,7 @@ TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
+TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -685,7 +686,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-strcmp-offset
 TEST_PROGRAMS_NEED_X += test-string-list
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index edfd52d82a..1e08598beb 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "sha1-array.h"
 
@@ -7,7 +8,7 @@ static int print_oid(const struct object_id *oid, void *data)
 	return 0;
 }
 
-int cmd_main(int argc, const char **argv)
+int test_sha1_array(int argc, const char **argv)
 {
 	struct oid_array array = OID_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f12f1ec5bb..54d62b8b32 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -32,6 +32,7 @@ static struct test_cmd cmds[] = {
 	{ "revision-walking", test_revision_walking },
 	{ "run-command", test_run_command },
 	{ "scrap-cache-tree", test_scrap_cache_tree },
+	{ "sha1-array", test_sha1_array },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 92504e951f..10d1322e0d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -26,6 +26,7 @@ int test_regex(int argc, const char **argv);
 int test_revision_walking(int argc, const char **argv);
 int test_run_command(int argc, const char **argv);
 int test_scrap_cache_tree(int argc, const char **argv);
+int test_sha1_array(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
index 50b31ffe75..67484502a0 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -18,7 +18,7 @@ test_expect_success 'ordered enumeration' '
 	{
 		echo20 append 88 44 aa 55 &&
 		echo for_each_unique
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	test_cmp expect actual
 '
 
@@ -28,7 +28,7 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 		echo20 append 88 44 aa 55 &&
 		echo20 append 88 44 aa 55 &&
 		echo for_each_unique
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	test_cmp expect actual
 '
 
@@ -36,7 +36,7 @@ test_expect_success 'lookup' '
 	{
 		echo20 append 88 44 aa 55 &&
 		echo20 lookup 55
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -eq 1
 '
@@ -45,7 +45,7 @@ test_expect_success 'lookup non-existing entry' '
 	{
 		echo20 append 88 44 aa 55 &&
 		echo20 lookup 33
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -lt 0
 '
@@ -55,7 +55,7 @@ test_expect_success 'lookup with duplicates' '
 		echo20 append 88 44 aa 55 &&
 		echo20 append 88 44 aa 55 &&
 		echo20 lookup 55
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -ge 2 &&
 	test "$n" -le 3
@@ -66,7 +66,7 @@ test_expect_success 'lookup non-existing entry with duplicates' '
 		echo20 append 88 44 aa 55 &&
 		echo20 append 88 44 aa 55 &&
 		echo20 lookup 66
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -lt 0
 '
@@ -76,7 +76,7 @@ test_expect_success 'lookup with almost duplicate values' '
 		echo "append 5555555555555555555555555555555555555555" &&
 		echo "append 555555555555555555555555555555555555555f" &&
 		echo20 lookup 55
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -eq 0
 '
@@ -85,7 +85,7 @@ test_expect_success 'lookup with single duplicate value' '
 	{
 		echo20 append 55 55 &&
 		echo20 lookup 55
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -ge 0 &&
 	test "$n" -le 1
-- 
2.16.2.903.gd04caf5039

