Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645911F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCQHzk (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39993 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeCQHzh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so14499686lfb.7
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Clt93KNVbc8CBQxXymWVr9v2o/F8ryIRV1OzkgvD04I=;
        b=XQIQ398pr5fL/XEbBzLWxeo2o37suStwemD3XHBEZpZOmYif51jA9bLcJX5g7ZS1ol
         gyee2PLOrTHnVYSrrXfVQu/Sfw88H5OoNX2llLgxpU35BXTxhq84kptYgKwbMNbVxHts
         BDv0OCiZp1F+0alYyV/AMtDIoYkD2aOGzlOdcBrzVFkBt7fUDfSOvc3zNyFL04Juhxmc
         CtHwQgEbUhLwyA08YyA8aTzU7bC6jf4V7wnJohxhyPaCriMyR/qOqUAlvEFPuf/z34HV
         +CwUHQ6AkJ9BuBhLZTMjilSxbU38BC3QBNkkzyv1l+5iOByTHbDWOtSy2X8URes33+PL
         QH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Clt93KNVbc8CBQxXymWVr9v2o/F8ryIRV1OzkgvD04I=;
        b=Xlo8idMHhZAHDxt8oobn6NGCXrTW8XmK5PMn5bWbOg8fnh4z9nUbRnfXi1ctgWQXx/
         8EX4ZIuyplJje8EbBFS0iZbtfWeGzpVYrQWqkceVckLxe8S5Mr0GtEOA4vJv/GZjxwd9
         EsLc93Id+Dh76l0THshgDhYOeIBRFywgS/tuYPqw/fDsjo1WkT4TxE5ySuFXsG4pzZMQ
         YQgCjFTcSxKF0KnZU2NX/BbWQyeS2bMDY4o6y717Zu6gO1DQI8Za8RHaBAfmCYpnkQHZ
         juVk9WHpOuubCWGdUL6tcYYAIQSxNK52Ye1BPXJL0Eaa5apypTy5irRGM1yQINchm9YW
         qvxg==
X-Gm-Message-State: AElRT7GOmK9Pl14FAmhah9Eeb+rbnblQNAGVwnkZjFKmKX43yxG/aWLa
        tJeUAT6IT4W+kEkkN1AN5a09SA==
X-Google-Smtp-Source: AG47ELu33HAutNVbS8kXat2aDfOJr/ZxxhdsHVLGE/j9vj+f+O77nbtu7xOmRHK0tMd4yzM3bHDFBg==
X-Received: by 2002:a19:cfc2:: with SMTP id f185-v6mr216496lfg.75.1521273334891;
        Sat, 17 Mar 2018 00:55:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/36] t/helper: merge test-lazy-init-name-hash into test-tool
Date:   Sat, 17 Mar 2018 08:53:49 +0100
Message-Id: <20180317075421.22032-5-pclouds@gmail.com>
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
 Makefile                                |  2 +-
 cache.h                                 |  2 +-
 name-hash.c                             |  2 +-
 t/helper/test-lazy-init-name-hash.c     | 26 ++++++++++++++-----------
 t/helper/test-tool.c                    |  1 +
 t/helper/test-tool.h                    |  1 +
 t/perf/p0004-lazy-init-name-hash.sh     |  8 ++++----
 t/t3008-ls-files-lazy-init-name-hash.sh |  2 +-
 8 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 3c0d0474af..31287cedf2 100644
--- a/Makefile
+++ b/Makefile
@@ -653,6 +653,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_BUILTINS_OBJS += test-chmtime.o
+TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-ctype
@@ -669,7 +670,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
-TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
diff --git a/cache.h b/cache.h
index d06932ed0b..8ff5ae9903 100644
--- a/cache.h
+++ b/cache.h
@@ -333,7 +333,7 @@ struct index_state {
 extern struct index_state the_index;
 
 /* Name hashing */
-extern int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
+extern int lazy_init_name_hash_for_testing(struct index_state *istate, int try_threaded);
 extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 extern void free_name_hash(struct index_state *istate);
diff --git a/name-hash.c b/name-hash.c
index 163849831c..182f630acc 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -614,7 +614,7 @@ static void lazy_init_name_hash(struct index_state *istate)
  * Requesting threading WILL NOT override guards
  * in lookup_lazy_params().
  */
-int test_lazy_init_name_hash(struct index_state *istate, int try_threaded)
+int lazy_init_name_hash_for_testing(struct index_state *istate, int try_threaded)
 {
 	lazy_nr_dir_threads = 0;
 	lazy_try_threaded = try_threaded;
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 297fb01d61..dd4e753008 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "parse-options.h"
 
@@ -9,6 +10,9 @@ static int perf;
 static int analyze;
 static int analyze_step;
 
+static int (*init_name_hash)(struct index_state *istate, int try_threaded) =
+	lazy_init_name_hash_for_testing;
+
 /*
  * Dump the contents of the "dir" and "name" hash tables to stdout.
  * If you sort the result, you can compare it with the other type
@@ -33,9 +37,9 @@ static void dump_run(void)
 
 	read_cache();
 	if (single) {
-		test_lazy_init_name_hash(&the_index, 0);
+		init_name_hash(&the_index, 0);
 	} else {
-		int nr_threads_used = test_lazy_init_name_hash(&the_index, 1);
+		int nr_threads_used = init_name_hash(&the_index, 1);
 		if (!nr_threads_used)
 			die("non-threaded code path used");
 	}
@@ -71,7 +75,7 @@ static uint64_t time_runs(int try_threaded)
 		t0 = getnanotime();
 		read_cache();
 		t1 = getnanotime();
-		nr_threads_used = test_lazy_init_name_hash(&the_index, try_threaded);
+		nr_threads_used = init_name_hash(&the_index, try_threaded);
 		t2 = getnanotime();
 
 		sum += (t2 - t1);
@@ -134,7 +138,7 @@ static void analyze_run(void)
 			read_cache();
 			the_index.cache_nr = nr; /* cheap truncate of index */
 			t1s = getnanotime();
-			test_lazy_init_name_hash(&the_index, 0);
+			init_name_hash(&the_index, 0);
 			t2s = getnanotime();
 			sum_single += (t2s - t1s);
 			the_index.cache_nr = cache_nr_limit;
@@ -143,7 +147,7 @@ static void analyze_run(void)
 			read_cache();
 			the_index.cache_nr = nr; /* cheap truncate of index */
 			t1m = getnanotime();
-			nr_threads_used = test_lazy_init_name_hash(&the_index, 1);
+			nr_threads_used = init_name_hash(&the_index, 1);
 			t2m = getnanotime();
 			sum_multi += (t2m - t1m);
 			the_index.cache_nr = cache_nr_limit;
@@ -184,14 +188,14 @@ static void analyze_run(void)
 	}
 }
 
-int cmd_main(int argc, const char **argv)
+int test_lazy_init_name_hash(int argc, const char **argv)
 {
 	const char *usage[] = {
-		"test-lazy-init-name-hash -d (-s | -m)",
-		"test-lazy-init-name-hash -p [-c c]",
-		"test-lazy-init-name-hash -a a [--step s] [-c c]",
-		"test-lazy-init-name-hash (-s | -m) [-c c]",
-		"test-lazy-init-name-hash -s -m [-c c]",
+		"test-tool lazy-init-name-hash -d (-s | -m)",
+		"test-tool lazy-init-name-hash -p [-c c]",
+		"test-tool lazy-init-name-hash -a a [--step s] [-c c]",
+		"test-tool lazy-init-name-hash (-s | -m) [-c c]",
+		"test-tool lazy-init-name-hash -s -m [-c c]",
 		NULL
 	};
 	struct option options[] = {
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index ca1f462cce..c4e9933f93 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -8,6 +8,7 @@ struct test_cmd {
 
 static struct test_cmd cmds[] = {
 	{ "chmtime", test_chmtime },
+	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e7a2a7cb5b..eaec143259 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -2,6 +2,7 @@
 #define __TEST_TOOL_H__
 
 int test_chmtime(int argc, const char **argv);
+int test_lazy_init_name_hash(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
index 8de5a98cfc..1afc08fe7f 100755
--- a/t/perf/p0004-lazy-init-name-hash.sh
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -7,8 +7,8 @@ test_perf_large_repo
 test_checkout_worktree
 
 test_expect_success 'verify both methods build the same hashmaps' '
-	test-lazy-init-name-hash --dump --single >out.single &&
-	if test-lazy-init-name-hash --dump --multi >out.multi
+	test-tool lazy-init-name-hash --dump --single >out.single &&
+	if test-tool lazy-init-name-hash --dump --multi >out.multi
 	then
 		test_set_prereq REPO_BIG_ENOUGH_FOR_MULTI &&
 		sort <out.single >sorted.single &&
@@ -46,11 +46,11 @@ test_expect_success 'calibrate' '
 '
 
 test_perf "single-threaded, $desc" "
-	test-lazy-init-name-hash --single --count=$count
+	test-tool lazy-init-name-hash --single --count=$count
 "
 
 test_perf REPO_BIG_ENOUGH_FOR_MULTI "multi-threaded, $desc" "
-	test-lazy-init-name-hash --multi --count=$count
+	test-tool lazy-init-name-hash --multi --count=$count
 "
 
 test_done
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index bdf5198b7e..8df4aa7c99 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -21,7 +21,7 @@ test_expect_success 'no buffer overflow in lazy_init_name_hash' '
 	) |
 	sed "s/^/100644 $EMPTY_BLOB	/" |
 	git update-index --index-info &&
-	test-lazy-init-name-hash -m
+	test-tool lazy-init-name-hash -m
 '
 
 test_done
-- 
2.16.2.903.gd04caf5039

