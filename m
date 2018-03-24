Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44311F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeCXHru (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:47:50 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35061 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbeCXHph (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:37 -0400
Received: by mail-lf0-f65.google.com with SMTP id t132-v6so21409471lfe.2
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJ/2rkYMp3znSbo63qZqNg3t7OaGjnJ3RISykRcqTpo=;
        b=LOoriG986Pnpui49ISG4V9wnUF97tdZgwkmS6l3kshD3YIhmBN5n2NQEenpcgKaivM
         Mk3MKLaF8zK0WwDgMFd/ULl9IoEAbhPHJzJtBECFDrw/qjQB7cye5Ug2w5voyZn/ZMGs
         S7uf/9w/LYcIiGHuey48k1L1B6rOX75XVtQ+kK1QtWJV+zbk1kW9gr27JTbG3Ngrirev
         FTgxH8mUd8lhzdr1v6wWrm52oazfSC8npfBinLUbm7Gv99Goq8jA9ZXMSxAyTTo6VBbi
         2vicAiOQL5j0Z4sG3lllq2xzmgt8w39izu+gGH/ppt/VmXqafnRYbMbDLvDvl3pzOsxO
         X7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJ/2rkYMp3znSbo63qZqNg3t7OaGjnJ3RISykRcqTpo=;
        b=FXiYEqMleTSvvbLs0qpZp6iDT0EnCyJEBWqdaks4P8GIHldI7ubJKESOWVQXCoNzXv
         woLDlVlik1/wWCOL2F1x2Sb+vowMHRwa+k9NjY0lZB2ZFbXlzNiNjXGFW15rs+VN1V6T
         A9jNj2Ne6AYfF9pREckhex4CdZRSVYRyPZzYWqrlstYIaLf6O7bqtCUxwI70jbVcGDwX
         /Y0H/BHLfUb0NtGXJJ+mzt2uDpURR/zKK/r5nM9t4rafnk+Ep0o+z9f/2lfzS18DvdC0
         ZVXayLkcfc5kmWugNBlIXzWOr7SuhXiS+55v6UamVXa77u7Iyh3SFNWpiKIFu+Kjssfa
         6dyg==
X-Gm-Message-State: AElRT7GqEjvp+Xuj4rTWxVKEJM2xtbFCIJQQsd1ICIccvxKgLskgzMZm
        DFXLrKZfbk7sSGulM7IQ11Q=
X-Google-Smtp-Source: AG47ELucVfiXwMTitu/k6m2bgfoxqF73n3wHXx8kFhZsZE+dOlGG2P77gFkpfN6ZL+GfrpBWqx4p2Q==
X-Received: by 10.46.112.22 with SMTP id l22mr6691950ljc.70.1521877535562;
        Sat, 24 Mar 2018 00:45:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/36] t/helper: merge test-lazy-init-name-hash into test-tool
Date:   Sat, 24 Mar 2018 08:44:33 +0100
Message-Id: <20180324074505.19100-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074505.19100-1-pclouds@gmail.com>
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
 t/helper/test-lazy-init-name-hash.c     | 13 +++++++------
 t/helper/test-tool.c                    |  1 +
 t/helper/test-tool.h                    |  1 +
 t/perf/p0004-lazy-init-name-hash.sh     |  8 ++++----
 t/t3008-ls-files-lazy-init-name-hash.sh |  2 +-
 6 files changed, 15 insertions(+), 12 deletions(-)

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
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 297fb01d61..b99a37080d 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "parse-options.h"
 
@@ -184,14 +185,14 @@ static void analyze_run(void)
 	}
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__lazy_init_name_hash(int argc, const char **argv)
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
index 7a9bb9f140..afc7a518d6 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -8,6 +8,7 @@ struct test_cmd {
 
 static struct test_cmd cmds[] = {
 	{ "chmtime", cmd__chmtime },
+	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a05b8bd14c..1dc4673c3a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -2,6 +2,7 @@
 #define __TEST_TOOL_H__
 
 int cmd__chmtime(int argc, const char **argv);
+int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
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
2.17.0.rc0.348.gd5a49e0b6f

