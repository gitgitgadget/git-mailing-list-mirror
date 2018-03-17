Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9122E1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeCQH4b (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:31 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44122 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbeCQH4E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:04 -0400
Received: by mail-lf0-f65.google.com with SMTP id g203-v6so4060565lfg.11
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RN1cDDvMraJnmatcczOzmMLDxIkSNeKq9fHg+sl4RRY=;
        b=Ed9AALHBJ6p5M6OQMTijGzG7TGjLX5988F0JdUCnF051NPu6WQZjGWE/JP3Dy1LD7Y
         cn0z3C1eDTrGJ4wUoyOtgdDm2KVNKYJfsxcWS928Q/+Y1fSpFuffBUFV5B1m6+zVf+Xi
         1q5OCtCXHeht4jt1gy/4PGJWPvGsBnufYGkKkzmdJN3F+e0UYMqeffvEVqEwK760M29t
         e8TYSbm5bfiWqjpKDn1EJ63H+J2t6ZURL9nxLKRAtqwuJTFcL5Ptx/0ND9zuFdVAcbrh
         oYgzUm+zGsrLO3gOQDSQ3MIF18Bf0MJa05Xcl7Ov19VwtJd88oEA6ExD165sPi6TSuE9
         g0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RN1cDDvMraJnmatcczOzmMLDxIkSNeKq9fHg+sl4RRY=;
        b=LTQ14DbgEe1lBNb3D6Wedanyawi7HSFcTnhdY6tfG7VpAXz0bpHYSx2oh6u1cmLY7J
         y7cBtmq2PimGgyjn6/4KZJvG0AgCFGXRyIfdFSg8CJeiy1vrd27ejVtdiYlY6vxz7Z0Y
         DMIAcYpfQDcHTJLZy8HQOPLjAgEVEv4vuU3tAlV3zZkA3SmkWLkYCbKoq3oLD8dWDSeX
         E/1VWYTWPlUO6orR3GsCQwCz+F7tzcbmQIw/LMN/2TkHmbxvM0hs/ROyYRSmu5uDtSva
         /wsL9rVIpVA1Sg70mc3Ldn9aPl5zdD9Rw30RRoCZHX8UvfwFbcKMqjHvDnCdEUPsL9aK
         XW4g==
X-Gm-Message-State: AElRT7Fm6vRgRjl+W4qUwsBdJkvah0YgBQL68xcibRHR2HHg0WvvIHy6
        cfc6kkR//zHBdsft4LeHHrlq4w==
X-Google-Smtp-Source: AG47ELvXh8QHhCLfIy2+7Ot2Wxy6X+cEXEFaPIP8KxvtKvdDcGi+W0s2qPYu9m5LMCdfaTFUyhCTlg==
X-Received: by 2002:a19:97d0:: with SMTP id z199-v6mr3143518lfd.94.1521273362977;
        Sat, 17 Mar 2018 00:56:02 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:56:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 29/36] t/helper: merge test-sigchain into test-tool
Date:   Sat, 17 Mar 2018 08:54:14 +0100
Message-Id: <20180317075421.22032-30-pclouds@gmail.com>
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
 Makefile                 | 2 +-
 t/helper/test-sigchain.c | 3 ++-
 t/helper/test-tool.c     | 1 +
 t/helper/test-tool.h     | 1 +
 t/t0005-signals.sh       | 4 ++--
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b50a0818a9..51de8882d0 100644
--- a/Makefile
+++ b/Makefile
@@ -679,6 +679,7 @@ TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha1.o
+TEST_BUILTINS_OBJS += test-sigchain.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -686,7 +687,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-strcmp-offset
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
diff --git a/t/helper/test-sigchain.c b/t/helper/test-sigchain.c
index b71edbd442..0cfbf9e0af 100644
--- a/t/helper/test-sigchain.c
+++ b/t/helper/test-sigchain.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "sigchain.h"
 
@@ -13,7 +14,7 @@ X(two)
 X(three)
 #undef X
 
-int cmd_main(int argc, const char **argv) {
+int test_sigchain(int argc, const char **argv) {
 	sigchain_push(SIGTERM, one);
 	sigchain_push(SIGTERM, two);
 	sigchain_push(SIGTERM, three);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 54d62b8b32..99db507a24 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -34,6 +34,7 @@ static struct test_cmd cmds[] = {
 	{ "scrap-cache-tree", test_scrap_cache_tree },
 	{ "sha1-array", test_sha1_array },
 	{ "sha1", test_sha1 },
+	{ "sigchain", test_sigchain },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 10d1322e0d..4c71df8c79 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -28,5 +28,6 @@ int test_run_command(int argc, const char **argv);
 int test_scrap_cache_tree(int argc, const char **argv);
 int test_sha1_array(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
+int test_sigchain(int argc, const char **argv);
 
 #endif
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index c16947cf5d..4c214bd11c 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -10,7 +10,7 @@ one
 EOF
 
 test_expect_success 'sigchain works' '
-	{ test-sigchain >actual; ret=$?; } &&
+	{ test-tool sigchain >actual; ret=$?; } &&
 	{
 		# Signal death by raise() on Windows acts like exit(3),
 		# regardless of the signal number. So we must allow that
@@ -24,7 +24,7 @@ test_expect_success 'sigchain works' '
 test_expect_success !MINGW 'signals are propagated using shell convention' '
 	# we use exec here to avoid any sub-shell interpretation
 	# of the exit code
-	git config alias.sigterm "!exec test-sigchain" &&
+	git config alias.sigterm "!exec test-tool sigchain" &&
 	test_expect_code 143 git sigterm
 '
 
-- 
2.16.2.903.gd04caf5039

