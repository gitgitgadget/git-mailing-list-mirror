Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D301F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeCQHzu (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41835 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeCQHzq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id m69-v6so18494190lfe.8
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qd529puwAMaaYSFngeGrb0wdNgig2HW7elv25uBlmh8=;
        b=TZz8doLUeBSKSkwD1Fu5MOqTjQ/ET9pDoOXlnnR8LuyNQwuiSiS2yd3Q+aURXCcYUi
         T13vNVnyLHNQC/z1nqMnJpsO43KAq5jDhcqq1Ln6jOkmqFNRbE2tuDVYRJ8nKfcQ2AR9
         35ztgl3kBjohCnKC5d0ZvRSr+RgHYewWT5oDyzVMqzVWc482gs1ExUn4rDWTAzTKhJQV
         R2LiTNMEvuFK1gn1DxEYi4vKsaemHZgRTZ3mSoHHCrVDtc2Io8pCML/QJXvRMIE9g5th
         lDQDl6N8UPNkZtv7gtjvZg7u+rfoXE9xwhnmoeFOLoYR2DsWQ2baAmWT3vFleiPAzVuL
         u/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qd529puwAMaaYSFngeGrb0wdNgig2HW7elv25uBlmh8=;
        b=FFFQhW1vkew51obcbSdk1av71K2Afjg87eaU6egWpWGkTHskVsCE6zOAAO0J0hiijX
         8j6UaXlnavPghOAzl5wHjWyhAqyOaPa/3TBjjD2w38sSP46zbrZWDsztloF5orfV1cPS
         RAhtY4lmCVtmjC0K0Lt35vhGxeUIvOuRHz0PAJfZ8jEihCmdb47uexUtyJlnnxo4e1dX
         RuAelgymZd+8ULcmrgNnqpZWJyDkAMlHn31NahCEkDlrrIS7kLnPTY6LMISr4KDs49jZ
         zNCwkBiIAwGyEglUSK1R0TRQdaUll6cma33EwvImi/+uxX6hphrwQO8/acD8aZ6bBptj
         dMRQ==
X-Gm-Message-State: AElRT7EIhD8iS75BmqMthhvBhCuzGdhmZtYKExccr9mRrqJCxnidjDD2
        T0fB8apHi+vnb/3mKJkbUKBJMw==
X-Google-Smtp-Source: AG47ELusEDWxQhZkwncsqs8hLHAJSx0b+iOUsjKr08pU+CNEYroWalXe5fyU2gUJpSsyE2zL//Hv8Q==
X-Received: by 2002:a19:4acc:: with SMTP id x195-v6mr3436983lfa.46.1521273345031;
        Sat, 17 Mar 2018 00:55:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/36] t/helper: merge test-hashmap into test-tool
Date:   Sat, 17 Mar 2018 08:53:59 +0100
Message-Id: <20180317075421.22032-15-pclouds@gmail.com>
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
 Makefile                | 2 +-
 t/helper/test-hashmap.c | 5 +++--
 t/helper/test-tool.c    | 1 +
 t/helper/test-tool.h    | 1 +
 t/t0011-hashmap.sh      | 4 ++--
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index d0bc6cfecf..f6c3ddc703 100644
--- a/Makefile
+++ b/Makefile
@@ -662,13 +662,13 @@ TEST_BUILTINS_OBJS += test-dump-cache-tree.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
+TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
-TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 9ae9281c07..6fc840ff72 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "hashmap.h"
 #include "strbuf.h"
@@ -77,7 +78,7 @@ static unsigned int hash(unsigned int method, unsigned int i, const char *key)
 
 /*
  * Test performance of hashmap.[ch]
- * Usage: time echo "perfhashmap method rounds" | test-hashmap
+ * Usage: time echo "perfhashmap method rounds" | test-tool hashmap
  */
 static void perf_hashmap(unsigned int method, unsigned int rounds)
 {
@@ -144,7 +145,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
  *
  * perfhashmap method rounds -> test hashmap.[ch] performance
  */
-int cmd_main(int argc, const char **argv)
+int test_hashmap(int argc, const char **argv)
 {
 	struct strbuf line = STRBUF_INIT;
 	struct hashmap map;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index ce13108374..924d8c80f7 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -17,6 +17,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-split-index", test_dump_split_index },
 	{ "example-decorate", test_example_decorate },
 	{ "genrandom", test_genrandom },
+	{ "hashmap", test_hashmap },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "sha1", test_sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6742558cb4..161f5becb7 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -11,6 +11,7 @@ int test_dump_cache_tree(int argc, const char **argv);
 int test_dump_split_index(int argc, const char **argv);
 int test_example_decorate(int argc, const char **argv);
 int test_genrandom(int argc, const char **argv);
+int test_hashmap(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 9c217d948c..3f1f505e89 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -4,7 +4,7 @@ test_description='test hashmap and string hash functions'
 . ./test-lib.sh
 
 test_hashmap() {
-	echo "$1" | test-hashmap $3 > actual &&
+	echo "$1" | test-tool hashmap $3 > actual &&
 	echo "$2" > expect &&
 	test_cmp expect actual
 }
@@ -232,7 +232,7 @@ test_expect_success 'grow / shrink' '
 	echo value40 >> expect &&
 	echo size >> in &&
 	echo 64 39 >> expect &&
-	cat in | test-hashmap > out &&
+	cat in | test-tool hashmap > out &&
 	test_cmp expect out
 
 '
-- 
2.16.2.903.gd04caf5039

