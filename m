Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E141F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCQH4J (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32965 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeCQH4H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:07 -0400
Received: by mail-lf0-f68.google.com with SMTP id x205-v6so18550407lfa.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3A5xdUUm8XlFUhzFghXee7Gc0mIHilOt/p50V3EoYtc=;
        b=LnExwIQ1NjcFqrwtvjSBlmwxq1sVsRv0C0fwHWjvbXNyr10IlhK9ZblF81N2dcd9sZ
         yjIYgJXbFzPsaDTiunAIILQtHVFZlf0Meba6fJ6aRE/WmSCvZeJ+6U4PPBe00P/Wujnh
         nrQt0Ec9od8OJhxh7tWvl6QmS8JEwY7L83BwHS7kvbqREeOhAqUMmMrJ38nh02uo6a12
         lE/o0AKapoEugLFCIkphltTZM+eUavRBXVaNCJEjGdeZDylKyTeGZDGOSO9OQvlWw2go
         JvgQxls+cEY0er93DV/D9U4g1RfHJS7ZlXtKBlB1oWerjlIKuylVRZx83zE69/eVCG5Z
         0UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3A5xdUUm8XlFUhzFghXee7Gc0mIHilOt/p50V3EoYtc=;
        b=AxOeFHSPubXM67SVMEYcoWH9ySpnDRjNtPnx8SuboxiMXr5Qlgw+8zulEGY1+r7+t6
         J44r+WmlDp+5H5YUZWd3a2Td/Fp3HeKnZKYg6RI0gVnd+R7CAvawmC7jASxrzZXn6heg
         Gi1rlTySZ/FkyIDqiT4t+bIULQx5trUevyyGYn9eB8I5kpWjBWdn89AY6D2MbF3DpCb6
         adScfRMnKrgtaxlebsbQ09o23wAQe5GMpqDsL3qf33qqvbJeRNENnyh+inoPY/MrnjBG
         jTQ2DS4rwrGhgNMCMMbxX5anCNCmxR/XwnNLHU+jCkRVHzgE+vUhWgfi2D7ZpC5YEZ0C
         Y90w==
X-Gm-Message-State: AElRT7G0Qqj8UD9w3NeS+REmfY90TQt0LRB9g0sfRKlUGas/IKmFkGaK
        cwZnkE2TXUuhPc3p0gKAZ4CRdA==
X-Google-Smtp-Source: AG47ELsVHi5KW1P1uBCC3B54kX5633PlGxRThR8dLRrmhoCOJ9PI619FZ9kZXXE3joY/GvhEp5O/Ew==
X-Received: by 2002:a19:280e:: with SMTP id o14-v6mr3355562lfo.121.1521273365383;
        Sat, 17 Mar 2018 00:56:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:56:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 31/36] t/helper: merge test-string-list into test-tool
Date:   Sat, 17 Mar 2018 08:54:16 +0100
Message-Id: <20180317075421.22032-32-pclouds@gmail.com>
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
index 829ec3d7d2..4ad957c31c 100644
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
+int test_string_list(int argc, const char **argv)
 {
 	if (argc == 5 && !strcmp(argv[1], "split")) {
 		struct string_list list = STRING_LIST_INIT_DUP;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 7e684960e0..2e428825d5 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -36,6 +36,7 @@ static struct test_cmd cmds[] = {
 	{ "sha1", test_sha1 },
 	{ "sigchain", test_sigchain },
 	{ "strcmp-offset", test_strcmp_offset },
+	{ "string-list", test_string_list },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 42ebb67af6..943d92452a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -30,5 +30,6 @@ int test_sha1_array(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 int test_sigchain(int argc, const char **argv);
 int test_strcmp_offset(int argc, const char **argv);
+int test_string_list(int argc, const char **argv);
 
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
2.16.2.903.gd04caf5039

