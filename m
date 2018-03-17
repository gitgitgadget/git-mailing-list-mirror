Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9D51F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeCQH52 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:57:28 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44090 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeCQHzi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id g203-v6so4059684lfg.11
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZXWWjUsYDCVeypCz4cPPvE62MjoVRxd5R1kqbBtycA=;
        b=iwK2UTHrCbRKRBvqe+gwijcQi+ZylQENxo7X3GiZaw8NL4bcuh/Oe+CUA82jEGjKXv
         I6joM25Vw81ArJeN6nR8xzeLWlcFfTzuvBL3I2camnTSOpWxf/vgUzoJEF2R1cA9hxFF
         rCTwkwoXF5OlW5rwYQQRjZINjvv4/pZN21U76Jpw91GjB1S6IdN+P5Zp+aZ6Dn8qicd5
         7U7GDH+vgeXY+GX1MEWQl+CziPFbuyOaN+Mm80FbAMmwB1GurXq/y6EB1un9GKgNQW5I
         INDPO33sakhh561oENMue/2yIDJaktTJ/WwcmBn5SnASJgKn5VjlEKIrgk/nGVV0gYGK
         RDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZXWWjUsYDCVeypCz4cPPvE62MjoVRxd5R1kqbBtycA=;
        b=cDf4lAENOshMn1q3vQeCj3q/ZlmHnu5fe8cuM166gopLGB+s8kQAZEskcoT2mTZHul
         GDtU5R6kLzYJy49J8bwve8QOdd9905N+ySwS79Gvn7a351Ktee9fLzIbLxgj5AKFq1c9
         1CcpUECBurOE9MkZY8tKr7i0w1cGiu8yN2Ok+dclAL5D3BpmLGk8tmxcbOqt0/h87Bk6
         ilpDQ2Q79hblSfb+2aU5ICBv8qvbPTvTapzQQceLYsLxI0Dha8wsjbwzX8ZEc/8VTYjr
         dLSdU68ff1lNdDGVR7chU6hGqMsUYLJvq/sRtMSmfrQHsoOjHwhqKBKqE9pdm+psUlLi
         IkjQ==
X-Gm-Message-State: AElRT7Ecq3INBfNio7zxnwvW1TTY5MVUIDYteSXm9GZ5vEBr0kn638iY
        8X2wQ0xq1zfoLWO5g489j8JCRA==
X-Google-Smtp-Source: AG47ELujZkRTBwyCcya+ugly3ym6AY2hXqUwENnBWnB4yTiRaqKqtDujv5Q+k1gmG2qRSPCbDmAhGQ==
X-Received: by 10.46.66.83 with SMTP id p80mr3379623lja.3.1521273337100;
        Sat, 17 Mar 2018 00:55:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/36] t/helper: merge test-ctype into test-tool
Date:   Sat, 17 Mar 2018 08:53:51 +0100
Message-Id: <20180317075421.22032-7-pclouds@gmail.com>
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
 Makefile               | 2 +-
 t/helper/test-ctype.c  | 3 ++-
 t/helper/test-tool.c   | 1 +
 t/helper/test-tool.h   | 1 +
 t/t0070-fundamental.sh | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 227f16ad17..d09710dc3d 100644
--- a/Makefile
+++ b/Makefile
@@ -654,10 +654,10 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
+TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
-TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-drop-caches
diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index bb72c47df5..a1b0fb344a 100644
--- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 
 static int rc;
@@ -28,7 +29,7 @@ static int is_in(const char *s, int ch)
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 
-int cmd_main(int argc, const char **argv)
+int test_ctype(int argc, const char **argv)
 {
 	TEST_CLASS(isdigit, DIGIT);
 	TEST_CLASS(isspace, " \n\r\t");
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 64d1632d92..eef6a8e003 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -9,6 +9,7 @@ struct test_cmd {
 static struct test_cmd cmds[] = {
 	{ "chmtime", test_chmtime },
 	{ "config", test_config },
+	{ "ctype", test_ctype },
 	{ "lazy-init-name-hash", test_lazy_init_name_hash },
 	{ "sha1", test_sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 00eef888fa..41620666e3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -3,6 +3,7 @@
 
 int test_chmtime(int argc, const char **argv);
 int test_config(int argc, const char **argv);
+int test_ctype(int argc, const char **argv);
 int test_lazy_init_name_hash(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 991ed2a48d..70d4d98a2e 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -9,7 +9,7 @@ Verify wrappers and compatibility functions.
 . ./test-lib.sh
 
 test_expect_success 'character classes (isspace, isalpha etc.)' '
-	test-ctype
+	test-tool ctype
 '
 
 test_expect_success 'mktemp to nonexistent directory prints filename' '
-- 
2.16.2.903.gd04caf5039

