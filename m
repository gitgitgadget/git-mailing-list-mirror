Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7B11F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeCXHns (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:43:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37135 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeCXHnn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:43:43 -0400
Received: by mail-lf0-f67.google.com with SMTP id m16-v6so17658478lfc.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nye6n+23GuEC80Zp32kBv3cJhiuHRSDmVvGxyJDKlc=;
        b=sqwbjqFGj3av0I7XarP35jYMik3F1IxKVN9PQqRzlnJwmXMA0qkadLGf4St8LrP2ab
         viIuLP7vafS4Cgzs2cUqMi+3T03pQy1v6vmFNCsc8S6UfjEPST5O8PnTud07DRcvXrUD
         biPlW53fADAgFpQAShGhrOOeydWGpBXp1ep/0vMR1fLTKVdQzoXAKty1aWXRCs2qtIjU
         aRyE9RFzgW42P4djvYC5YZ5LTb2IrNa/NAn/J4ar+q1yTXlJ7cdOV3Ak+rTc54rv/xcO
         R9/2TmVyRcnGFpVA7blsA7vIXw0vLlie7oBhbOrejhY3VORlQ+zXeA0CE/3mT/YiOZx7
         FJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nye6n+23GuEC80Zp32kBv3cJhiuHRSDmVvGxyJDKlc=;
        b=f0gM7hlO7QvCcX308dPSWNDLKM0K2jyflgoEuoyj1ape/gQVXtAG/iXJWa2x2bXvLK
         UQvajFXcj0igNtleI/5W+5bPgxI2+7bU5fiqnQ9B1p2Ne5m/edxx5mncseapxHF1UMyH
         iAiV15+YTe+ekplQK4X0o2voS1qxptbZLrh+cHymxInCFkQDvXHTOyoXepTXMuA6O+8N
         xgi9uVuktu+7q6c2VLHsEv7YCIA4z5j770jQdHHdNxqTRJwKV/mVY23vOFlS+2hT5Go3
         MWLt445uzWiIvKhPKzbwhyoNTRLzXoqwSv6as9nSg+sS/+Biz8bA9F/q0utidbNfkzM4
         NiVw==
X-Gm-Message-State: AElRT7Fq40rR23SlsjyvLS/UqLU7IfdIMhMwyd0psRLAPtkMVUzGv4HT
        mZoskyuUyDQqCfRjwkP203LYzw==
X-Google-Smtp-Source: AG47ELsdWP9vQx6tumueW2UXID0WJr7cPew8gcVNj9E70S7w8HOQx8YLe3U3l2DbVVLxztwrZ8lO0A==
X-Received: by 10.46.41.156 with SMTP id p28mr15079479ljp.32.1521877422480;
        Sat, 24 Mar 2018 00:43:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o132-v6sm2642867lfe.91.2018.03.24.00.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:43:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/36] t/helper: merge test-ctype into test-tool
Date:   Sat, 24 Mar 2018 08:42:37 +0100
Message-Id: <20180324074308.18934-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074308.18934-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074308.18934-1-pclouds@gmail.com>
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
index bb72c47df5..92c4c2313e 100644
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
+int cmd__ctype(int argc, const char **argv)
 {
 	TEST_CLASS(isdigit, DIGIT);
 	TEST_CLASS(isspace, " \n\r\t");
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index e8d6c6b9eb..d600a31935 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -9,6 +9,7 @@ struct test_cmd {
 static struct test_cmd cmds[] = {
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
+	{ "ctype", cmd__ctype },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 3084f458a0..41805ecd1c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -3,6 +3,7 @@
 
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
+int cmd__ctype(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
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
2.17.0.rc0.348.gd5a49e0b6f

