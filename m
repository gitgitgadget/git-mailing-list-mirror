Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B38B1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeCXHps (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:45:48 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40522 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCXHpl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so21419796lfb.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4xaz9crpZ8prxY23Otf+8TSBV7S5wep7o5hiF5ERPc=;
        b=iZQpqJU/mEQxQUq/bMozubxHTLvsHp2nK+ndQzZEeRNfUzJdpOZOTlSjSjEZf3DNDV
         3ufUBy758GBiS7Aq8V9SJPjjoFeSmkRHSFMne5OMJYbJrs7LlFhCBbuFlGRxAejLz5nN
         KKaE6SlBF/qT50oWTQEESVcU1MZSVzkfZRnF/68GTNjWHfQDqz0K0j7+Pd04Hn+ZEJj3
         SDfmWv1Ha6kyMLHvJkoueTkKtVSpdaDFQ5CLe5RgG2KgxjKQsyY5j2xWtsOsDzG5f67M
         NmeKIElKhHvsfcchV4UyN8TjgqaFPChDZPAM3Nh90OF0scgwdLkLcMaFD4fcVHMkQq04
         zytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4xaz9crpZ8prxY23Otf+8TSBV7S5wep7o5hiF5ERPc=;
        b=La23hm7wzYMNE0UZ9ttANR4n6LUlpoy9HnTOZRcWgSMQ0QoODUjXfU4qHXCX96yhOi
         cpH59EeRc7FmOJDjeQzMx0h1oNGNLInNG/ve/zLXbENmj8vu16Ru6wDoouTPgKpILVWB
         g6RIPykR9StYxp9uK3zHMuA0+4/WZfKAT9N8JhVi4ZH0aTb4MsL4fTJmOFB23YG+0rgG
         1hWHZ0nIMwwjs/QlFR1MA6+PlG6MdKqyTmdHmx+AYI2ApTtVFsAHvcOsHC/g6Ah6Y7Do
         kXKS22N+/ZyrDUqajvpJjDGpowKeAjcZtllOrqo81XlVSBY5u/nx3SlAAEa80my7K/Tw
         WLDw==
X-Gm-Message-State: AElRT7F5GC3I5aRzi+q8aghuWQHybAAujeqOJJp6++u1ejM1pAE32NPe
        M9y/vftLH37ty/OaPs6rwCM=
X-Google-Smtp-Source: AG47ELubgpEAaoBtwX+fRFL/mbyMoq9Tf2lgLGB/tK0V3l6M/Xl4ip4xEuIDDH+1PF5JCI2u0+Fd1A==
X-Received: by 2002:a19:1754:: with SMTP id n81-v6mr18961155lfi.113.1521877539534;
        Sat, 24 Mar 2018 00:45:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/36] t/helper: merge test-date into test-tool
Date:   Sat, 24 Mar 2018 08:44:36 +0100
Message-Id: <20180324074505.19100-8-pclouds@gmail.com>
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
 Makefile               |  2 +-
 t/helper/test-date.c   | 17 +++++++++--------
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0006-date.sh        |  8 ++++----
 t/t1300-repo-config.sh |  2 +-
 t/test-lib.sh          |  4 ++--
 7 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index d09710dc3d..efb1872c52 100644
--- a/Makefile
+++ b/Makefile
@@ -655,10 +655,10 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
+TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
-TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-drop-caches
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index ac83687970..a0837371ab 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,13 +1,14 @@
+#include "test-tool.h"
 #include "cache.h"
 
 static const char *usage_msg = "\n"
-"  test-date relative [time_t]...\n"
-"  test-date show:<format> [time_t]...\n"
-"  test-date parse [date]...\n"
-"  test-date approxidate [date]...\n"
-"  test-date timestamp [date]...\n"
-"  test-date is64bit\n"
-"  test-date time_t-is64bit\n";
+"  test-tool date relative [time_t]...\n"
+"  test-tool date show:<format> [time_t]...\n"
+"  test-tool date parse [date]...\n"
+"  test-tool date approxidate [date]...\n"
+"  test-tool date timestamp [date]...\n"
+"  test-tool date is64bit\n"
+"  test-tool date time_t-is64bit\n";
 
 static void show_relative_dates(const char **argv, struct timeval *now)
 {
@@ -81,7 +82,7 @@ static void parse_approx_timestamp(const char **argv, struct timeval *now)
 	}
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__date(int argc, const char **argv)
 {
 	struct timeval now;
 	const char *x;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index d600a31935..e92f93ac3b 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -10,6 +10,7 @@ static struct test_cmd cmds[] = {
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
 	{ "ctype", cmd__ctype },
+	{ "date", cmd__date },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 41805ecd1c..31c20bb656 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -4,6 +4,7 @@
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
+int cmd__date(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 7ac9466d50..64ff86df8e 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -10,7 +10,7 @@ check_relative() {
 	t=$(($TEST_DATE_NOW - $1))
 	echo "$t -> $2" >expect
 	test_expect_${3:-success} "relative date ($2)" "
-	test-date relative $t >actual &&
+	test-tool date relative $t >actual &&
 	test_i18ncmp expect actual
 	"
 }
@@ -35,7 +35,7 @@ check_show () {
 	zone=$5
 	test_expect_success $prereqs "show date ($format:$time)" '
 		echo "$time -> $expect" >expect &&
-		TZ=${zone:-$TZ} test-date show:"$format" "$time" >actual &&
+		TZ=${zone:-$TZ} test-tool date show:"$format" "$time" >actual &&
 		test_cmp expect actual
 	'
 }
@@ -71,7 +71,7 @@ check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT,TIME_T_
 check_parse() {
 	echo "$1 -> $2" >expect
 	test_expect_${4:-success} "parse date ($1${3:+ TZ=$3})" "
-	TZ=${3:-$TZ} test-date parse '$1' >actual &&
+	TZ=${3:-$TZ} test-tool date parse '$1' >actual &&
 	test_cmp expect actual
 	"
 }
@@ -92,7 +92,7 @@ check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
 check_approxidate() {
 	echo "$1 -> $2 +0000" >expect
 	test_expect_${3:-success} "parse approxidate ($1)" "
-	test-date approxidate '$1' >actual &&
+	test-tool date approxidate '$1' >actual &&
 	test_cmp expect actual
 	"
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4f8e6f5fde..8780934478 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -914,7 +914,7 @@ test_expect_success 'get --expiry-date' '
 	invalid1 = "abc"
 	EOF
 	cat >expect <<-EOF &&
-	$(test-date timestamp $rel)
+	$(test-tool date timestamp $rel)
 	1275666415
 	1510441871
 	1510348087
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7ab8af47a5..483c8d6d7c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1206,5 +1206,5 @@ test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
 
-test_lazy_prereq TIME_IS_64BIT 'test-date is64bit'
-test_lazy_prereq TIME_T_IS_64BIT 'test-date time_t-is64bit'
+test_lazy_prereq TIME_IS_64BIT 'test-tool date is64bit'
+test_lazy_prereq TIME_T_IS_64BIT 'test-tool date time_t-is64bit'
-- 
2.17.0.rc0.348.gd5a49e0b6f

