Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BE51F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeCXHqd (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40571 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeCXHqM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:12 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so21420795lfb.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEWoZ5TFy/79xPc4yWxtJujTRTNnsxfXXeOcCLQtDeo=;
        b=H7gIgX9yk6JJ5LKYwhqJMSrMn/tLdchuUT+m+TlbgNO+dITbEByIE01VmOswqHuMJf
         /zbJBnO38UpBrIBWMEyPo0ko4vWNmm+4HcP/HDrFom8N4d65zs1EFPg627bDRNtZGH0E
         k5EJkPZueRXt1jZmZXi5pN0W5tnWFExr5Pe32eJxMUVU9APMy9mAqxD7ZdyZp7ViknTu
         DBo7/1XZQ1fOhbD69OTraaF0PU8yk6gHo8yBmBL5UdfTHg4h/QADKGpZKQtGIWPkcpxa
         RAV4iSHGABw7UGep7KvwVnl2xI8k6zUcgzi8ygCULPNZxi8hk12lrpupwpEagVZfG3mR
         AR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEWoZ5TFy/79xPc4yWxtJujTRTNnsxfXXeOcCLQtDeo=;
        b=OOI3zI093DHB8aGAJ8zrbhRWczzzrwAmXZwl4ybf3kUd9oBouxn+Q5CbNAcAnL7yKg
         N5SrfUlsc06rQPPJim1JoI4Ynki82ooW9AVKAy+8tzi1qewA6d5t22sBbaEfbAjxw+1e
         PYVZ6fj08gJCSD5gYjgnDklXnqVSqDQGKDzp62rhSCyT0omHxYH47xnTQsdI/H0vYiYa
         IxOeSfmaPuoHK51Mjz5Y+XfxLEq1pNepu65Mc1QKKhH8Job550nIJ0J+XKkWUckmaim8
         53tuP7OikgKkxBXzM6FxE48cYXEcVngIeuXp05W16EJEyAlo9xWOgBm0sHLyeXCMRHzE
         fOgw==
X-Gm-Message-State: AElRT7HvCCk4zh8eQomfp+lImwtOpKn1DNWcffaS5+B4VHCbiMuHI4tZ
        lmmSsMLIf9kwPdPNhcc8eYI=
X-Google-Smtp-Source: AG47ELvMESyGJd7Non0OUF8jEe1XYTYwA62PhiLyGSZreK3n2jl/SY8ykpikci8NzseOG+oKto+kMQ==
X-Received: by 2002:a19:911a:: with SMTP id t26-v6mr21019686lfd.101.1521877571129;
        Sat, 24 Mar 2018 00:46:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 31/36] t/helper: merge test-string-list into test-tool
Date:   Sat, 24 Mar 2018 08:45:00 +0100
Message-Id: <20180324074505.19100-32-pclouds@gmail.com>
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
 Makefile                    |  2 +-
 t/helper/test-string-list.c |  3 ++-
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/perf/p0071-sort.sh        |  2 +-
 t/t0063-string-list.sh      | 48 ++++++++++++++++++-------------------
 6 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index 528a80b6a6..6819792c2b 100644
--- a/Makefile
+++ b/Makefile
@@ -681,6 +681,7 @@ TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
+TEST_BUILTINS_OBJS += test-string-list.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -688,7 +689,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 829ec3d7d2..2123dda85b 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "string-list.h"
 
@@ -41,7 +42,7 @@ static int prefix_cb(struct string_list_item *item, void *cb_data)
 	return starts_with(item->string, prefix);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__string_list(int argc, const char **argv)
 {
 	if (argc == 5 && !strcmp(argv[1], "split")) {
 		struct string_list list = STRING_LIST_INIT_DUP;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 41b8f869ae..90008533cd 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -36,6 +36,7 @@ static struct test_cmd cmds[] = {
 	{ "sha1", cmd__sha1 },
 	{ "sigchain", cmd__sigchain },
 	{ "strcmp-offset", cmd__strcmp_offset },
+	{ "string-list", cmd__string_list },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 035e82ec6a..19ad2b0df8 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -30,5 +30,6 @@ int cmd__sha1_array(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
+int cmd__string_list(int argc, const char **argv);
 
 #endif
diff --git a/t/perf/p0071-sort.sh b/t/perf/p0071-sort.sh
index 7c9a35a646..6e924f5fa3 100755
--- a/t/perf/p0071-sort.sh
+++ b/t/perf/p0071-sort.sh
@@ -16,7 +16,7 @@ test_perf 'sort(1)' '
 '
 
 test_perf 'string_list_sort()' '
-	test-string-list sort <unsorted >actual
+	test-tool string-list sort <unsorted >actual
 '
 
 test_expect_success 'string_list_sort() sorts like sort(1)' '
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index dbfc05ebdc..c6ee9f66b1 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -10,9 +10,9 @@ test_description='Test string list functionality'
 test_split () {
 	cat >expected &&
 	test_expect_success "split $1 at $2, max $3" "
-		test-string-list split '$1' '$2' '$3' >actual &&
+		test-tool string-list split '$1' '$2' '$3' >actual &&
 		test_cmp expected actual &&
-		test-string-list split_in_place '$1' '$2' '$3' >actual &&
+		test-tool string-list split_in_place '$1' '$2' '$3' >actual &&
 		test_cmp expected actual
 	"
 }
@@ -61,31 +61,31 @@ test_split ":" ":" "-1" <<EOF
 EOF
 
 test_expect_success "test filter_string_list" '
-	test "x-" = "x$(test-string-list filter - y)" &&
-	test "x-" = "x$(test-string-list filter no y)" &&
-	test yes = "$(test-string-list filter yes y)" &&
-	test yes = "$(test-string-list filter no:yes y)" &&
-	test yes = "$(test-string-list filter yes:no y)" &&
-	test y1:y2 = "$(test-string-list filter y1:y2 y)" &&
-	test y2:y1 = "$(test-string-list filter y2:y1 y)" &&
-	test "x-" = "x$(test-string-list filter x1:x2 y)"
+	test "x-" = "x$(test-tool string-list filter - y)" &&
+	test "x-" = "x$(test-tool string-list filter no y)" &&
+	test yes = "$(test-tool string-list filter yes y)" &&
+	test yes = "$(test-tool string-list filter no:yes y)" &&
+	test yes = "$(test-tool string-list filter yes:no y)" &&
+	test y1:y2 = "$(test-tool string-list filter y1:y2 y)" &&
+	test y2:y1 = "$(test-tool string-list filter y2:y1 y)" &&
+	test "x-" = "x$(test-tool string-list filter x1:x2 y)"
 '
 
 test_expect_success "test remove_duplicates" '
-	test "x-" = "x$(test-string-list remove_duplicates -)" &&
-	test "x" = "x$(test-string-list remove_duplicates "")" &&
-	test a = "$(test-string-list remove_duplicates a)" &&
-	test a = "$(test-string-list remove_duplicates a:a)" &&
-	test a = "$(test-string-list remove_duplicates a:a:a:a:a)" &&
-	test a:b = "$(test-string-list remove_duplicates a:b)" &&
-	test a:b = "$(test-string-list remove_duplicates a:a:b)" &&
-	test a:b = "$(test-string-list remove_duplicates a:b:b)" &&
-	test a:b:c = "$(test-string-list remove_duplicates a:b:c)" &&
-	test a:b:c = "$(test-string-list remove_duplicates a:a:b:c)" &&
-	test a:b:c = "$(test-string-list remove_duplicates a:b:b:c)" &&
-	test a:b:c = "$(test-string-list remove_duplicates a:b:c:c)" &&
-	test a:b:c = "$(test-string-list remove_duplicates a:a:b:b:c:c)" &&
-	test a:b:c = "$(test-string-list remove_duplicates a:a:a:b:b:b:c:c:c)"
+	test "x-" = "x$(test-tool string-list remove_duplicates -)" &&
+	test "x" = "x$(test-tool string-list remove_duplicates "")" &&
+	test a = "$(test-tool string-list remove_duplicates a)" &&
+	test a = "$(test-tool string-list remove_duplicates a:a)" &&
+	test a = "$(test-tool string-list remove_duplicates a:a:a:a:a)" &&
+	test a:b = "$(test-tool string-list remove_duplicates a:b)" &&
+	test a:b = "$(test-tool string-list remove_duplicates a:a:b)" &&
+	test a:b = "$(test-tool string-list remove_duplicates a:b:b)" &&
+	test a:b:c = "$(test-tool string-list remove_duplicates a:b:c)" &&
+	test a:b:c = "$(test-tool string-list remove_duplicates a:a:b:c)" &&
+	test a:b:c = "$(test-tool string-list remove_duplicates a:b:b:c)" &&
+	test a:b:c = "$(test-tool string-list remove_duplicates a:b:c:c)" &&
+	test a:b:c = "$(test-tool string-list remove_duplicates a:a:b:b:c:c)" &&
+	test a:b:c = "$(test-tool string-list remove_duplicates a:a:a:b:b:b:c:c:c)"
 '
 
 test_done
-- 
2.17.0.rc0.348.gd5a49e0b6f

