Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTTP_EXCESSIVE_ESCAPES,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC87D1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeCXHqT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:19 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:40044 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeCXHqR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:17 -0400
Received: by mail-lf0-f43.google.com with SMTP id e5-v6so21420960lfb.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2XSd5003jocWtkcPnNa3SkOwENsMHGp3bE+4hiqXuc=;
        b=dr9K/VZtCE2wzX9saQ2gExpPdEZc6Fcq8EJz5h1UG4q+arSnqMvYBFG2cW4poO3U10
         a5g0R6B2ooTW6JEOyS1pvpUOkpKI2Omy2k1sXQY1+K8bxFmjEZ5N7a136MBNNQqRjZ7a
         YC5qDNH9tAddQWPzIB5WV5i/lcnEepvm9FGFZWDtBDAycbI66fYKv8JaibDjo0P53TBR
         7xvfAiDj4xaUclxMLcgs5pfdd7Ws/MavGUH39dIFG6ksI7baZ4eNQqJ8przLvrqW4FOO
         Mv+iqv7K4nFyyP+aHql71h+S/pv61f2ALNF93o90e1OFPNPamHtpB8Juh05gjUv2U/44
         qT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2XSd5003jocWtkcPnNa3SkOwENsMHGp3bE+4hiqXuc=;
        b=mKKliE8vUVesHRKZCFeXUnqCcO+8gC8WwWBgEX5mLCynWd8a4fVkCjKiMPkEBjgFBT
         fg08COdBpSK0UOlEwAmF7uxgCr5MbxaErYnfFfmoqs/rKDW3hq5Lm/hgWGv2TqyRczeA
         2Fe2XBGgcink5nmrN2QBNm6embTR9xI84twC5q8im0ELMmJrQSiPVEWf7Dbgm9VoIRyq
         nAWdZkyjBBiGUAON890r5LYMtRFXY8Piv4/763yCWxUkOnwaIvYF17hVKYhLfPDq/z74
         lBuKl7blvXOdQCgIaRTI6fb/+2PeCXKbIwqMG1LvQuW9bkFP/GTzDmaHIY/qh7rH3/8L
         E9mg==
X-Gm-Message-State: AElRT7HzCJh2nZoACd/IgGhn28IqCTBxG+4GMVNj2dRyK3o5RpUW4yUa
        wFt7C1pCX9Huy0CBBvSzJVTwNw==
X-Google-Smtp-Source: AIpwx49nI8/7UzurEDt3yRduEFLZy9sRs6qfIj8Th5wBVV7iaLcUz+Gf5ZcIWz55d+puiL9v2F6uZQ==
X-Received: by 10.46.136.77 with SMTP id z13mr3385310ljj.126.1521877575462;
        Sat, 24 Mar 2018 00:46:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 34/36] t/helper: merge test-urlmatch-normalization into test-tool
Date:   Sat, 24 Mar 2018 08:45:03 +0100
Message-Id: <20180324074505.19100-35-pclouds@gmail.com>
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
 Makefile                               |   2 +-
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/helper/test-urlmatch-normalization.c |   5 +-
 t/t0110-urlmatch-normalization.sh      | 266 ++++++++++++-------------
 5 files changed, 139 insertions(+), 136 deletions(-)

diff --git a/Makefile b/Makefile
index 893ea64ca2..7923ec3747 100644
--- a/Makefile
+++ b/Makefile
@@ -684,6 +684,7 @@ TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
+TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -693,7 +694,6 @@ TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
-TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
 TEST_PROGRAMS_NEED_X += test-wildmatch
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 96180f0350..b3d84fdac9 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -39,6 +39,7 @@ static struct test_cmd cmds[] = {
 	{ "string-list", cmd__string_list },
 	{ "submodule-config", cmd__submodule_config },
 	{ "subprocess", cmd__subprocess },
+	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a611801061..fa53c82659 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -33,5 +33,6 @@ int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
+int cmd__urlmatch_normalization(int argc, const char **argv);
 
 #endif
diff --git a/t/helper/test-urlmatch-normalization.c b/t/helper/test-urlmatch-normalization.c
index 49b6e836be..8f4d67e646 100644
--- a/t/helper/test-urlmatch-normalization.c
+++ b/t/helper/test-urlmatch-normalization.c
@@ -1,9 +1,10 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "urlmatch.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__urlmatch_normalization(int argc, const char **argv)
 {
-	const char usage[] = "test-urlmatch-normalization [-p | -l] <url1> | <url1> <url2>";
+	const char usage[] = "test-tool urlmatch-normalization [-p | -l] <url1> | <url1> <url2>";
 	char *url1, *url2;
 	int opt_p = 0, opt_l = 0;
 
diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch-normalization.sh
index 410d5768ca..f99529d838 100755
--- a/t/t0110-urlmatch-normalization.sh
+++ b/t/t0110-urlmatch-normalization.sh
@@ -9,172 +9,172 @@ tu="$TEST_DIRECTORY/t0110/url"
 # Note that only file: URLs should be allowed without a host
 
 test_expect_success 'url scheme' '
-	! test-urlmatch-normalization "" &&
-	! test-urlmatch-normalization "_" &&
-	! test-urlmatch-normalization "scheme" &&
-	! test-urlmatch-normalization "scheme:" &&
-	! test-urlmatch-normalization "scheme:/" &&
-	! test-urlmatch-normalization "scheme://" &&
-	! test-urlmatch-normalization "file" &&
-	! test-urlmatch-normalization "file:" &&
-	! test-urlmatch-normalization "file:/" &&
-	test-urlmatch-normalization "file://" &&
-	! test-urlmatch-normalization "://acme.co" &&
-	! test-urlmatch-normalization "x_test://acme.co" &&
-	! test-urlmatch-normalization "-test://acme.co" &&
-	! test-urlmatch-normalization "0test://acme.co" &&
-	! test-urlmatch-normalization "+test://acme.co" &&
-	! test-urlmatch-normalization ".test://acme.co" &&
-	! test-urlmatch-normalization "schem%6e://" &&
-	test-urlmatch-normalization "x-Test+v1.0://acme.co" &&
-	test "$(test-urlmatch-normalization -p "AbCdeF://x.Y")" = "abcdef://x.y/"
+	! test-tool urlmatch-normalization "" &&
+	! test-tool urlmatch-normalization "_" &&
+	! test-tool urlmatch-normalization "scheme" &&
+	! test-tool urlmatch-normalization "scheme:" &&
+	! test-tool urlmatch-normalization "scheme:/" &&
+	! test-tool urlmatch-normalization "scheme://" &&
+	! test-tool urlmatch-normalization "file" &&
+	! test-tool urlmatch-normalization "file:" &&
+	! test-tool urlmatch-normalization "file:/" &&
+	test-tool urlmatch-normalization "file://" &&
+	! test-tool urlmatch-normalization "://acme.co" &&
+	! test-tool urlmatch-normalization "x_test://acme.co" &&
+	! test-tool urlmatch-normalization "-test://acme.co" &&
+	! test-tool urlmatch-normalization "0test://acme.co" &&
+	! test-tool urlmatch-normalization "+test://acme.co" &&
+	! test-tool urlmatch-normalization ".test://acme.co" &&
+	! test-tool urlmatch-normalization "schem%6e://" &&
+	test-tool urlmatch-normalization "x-Test+v1.0://acme.co" &&
+	test "$(test-tool urlmatch-normalization -p "AbCdeF://x.Y")" = "abcdef://x.y/"
 '
 
 test_expect_success 'url authority' '
-	! test-urlmatch-normalization "scheme://user:pass@" &&
-	! test-urlmatch-normalization "scheme://?" &&
-	! test-urlmatch-normalization "scheme://#" &&
-	! test-urlmatch-normalization "scheme:///" &&
-	! test-urlmatch-normalization "scheme://:" &&
-	! test-urlmatch-normalization "scheme://:555" &&
-	test-urlmatch-normalization "file://user:pass@" &&
-	test-urlmatch-normalization "file://?" &&
-	test-urlmatch-normalization "file://#" &&
-	test-urlmatch-normalization "file:///" &&
-	test-urlmatch-normalization "file://:" &&
-	! test-urlmatch-normalization "file://:555" &&
-	test-urlmatch-normalization "scheme://user:pass@host" &&
-	test-urlmatch-normalization "scheme://@host" &&
-	test-urlmatch-normalization "scheme://%00@host" &&
-	! test-urlmatch-normalization "scheme://%%@host" &&
-	! test-urlmatch-normalization "scheme://host_" &&
-	test-urlmatch-normalization "scheme://user:pass@host/" &&
-	test-urlmatch-normalization "scheme://@host/" &&
-	test-urlmatch-normalization "scheme://host/" &&
-	test-urlmatch-normalization "scheme://host?x" &&
-	test-urlmatch-normalization "scheme://host#x" &&
-	test-urlmatch-normalization "scheme://host/@" &&
-	test-urlmatch-normalization "scheme://host?@x" &&
-	test-urlmatch-normalization "scheme://host#@x" &&
-	test-urlmatch-normalization "scheme://[::1]" &&
-	test-urlmatch-normalization "scheme://[::1]/" &&
-	! test-urlmatch-normalization "scheme://hos%41/" &&
-	test-urlmatch-normalization "scheme://[invalid....:/" &&
-	test-urlmatch-normalization "scheme://invalid....:]/" &&
-	! test-urlmatch-normalization "scheme://invalid....:[/" &&
-	! test-urlmatch-normalization "scheme://invalid....:["
+	! test-tool urlmatch-normalization "scheme://user:pass@" &&
+	! test-tool urlmatch-normalization "scheme://?" &&
+	! test-tool urlmatch-normalization "scheme://#" &&
+	! test-tool urlmatch-normalization "scheme:///" &&
+	! test-tool urlmatch-normalization "scheme://:" &&
+	! test-tool urlmatch-normalization "scheme://:555" &&
+	test-tool urlmatch-normalization "file://user:pass@" &&
+	test-tool urlmatch-normalization "file://?" &&
+	test-tool urlmatch-normalization "file://#" &&
+	test-tool urlmatch-normalization "file:///" &&
+	test-tool urlmatch-normalization "file://:" &&
+	! test-tool urlmatch-normalization "file://:555" &&
+	test-tool urlmatch-normalization "scheme://user:pass@host" &&
+	test-tool urlmatch-normalization "scheme://@host" &&
+	test-tool urlmatch-normalization "scheme://%00@host" &&
+	! test-tool urlmatch-normalization "scheme://%%@host" &&
+	! test-tool urlmatch-normalization "scheme://host_" &&
+	test-tool urlmatch-normalization "scheme://user:pass@host/" &&
+	test-tool urlmatch-normalization "scheme://@host/" &&
+	test-tool urlmatch-normalization "scheme://host/" &&
+	test-tool urlmatch-normalization "scheme://host?x" &&
+	test-tool urlmatch-normalization "scheme://host#x" &&
+	test-tool urlmatch-normalization "scheme://host/@" &&
+	test-tool urlmatch-normalization "scheme://host?@x" &&
+	test-tool urlmatch-normalization "scheme://host#@x" &&
+	test-tool urlmatch-normalization "scheme://[::1]" &&
+	test-tool urlmatch-normalization "scheme://[::1]/" &&
+	! test-tool urlmatch-normalization "scheme://hos%41/" &&
+	test-tool urlmatch-normalization "scheme://[invalid....:/" &&
+	test-tool urlmatch-normalization "scheme://invalid....:]/" &&
+	! test-tool urlmatch-normalization "scheme://invalid....:[/" &&
+	! test-tool urlmatch-normalization "scheme://invalid....:["
 '
 
 test_expect_success 'url port checks' '
-	test-urlmatch-normalization "xyz://q@some.host:" &&
-	test-urlmatch-normalization "xyz://q@some.host:456/" &&
-	! test-urlmatch-normalization "xyz://q@some.host:0" &&
-	! test-urlmatch-normalization "xyz://q@some.host:0000000" &&
-	test-urlmatch-normalization "xyz://q@some.host:0000001?" &&
-	test-urlmatch-normalization "xyz://q@some.host:065535#" &&
-	test-urlmatch-normalization "xyz://q@some.host:65535" &&
-	! test-urlmatch-normalization "xyz://q@some.host:65536" &&
-	! test-urlmatch-normalization "xyz://q@some.host:99999" &&
-	! test-urlmatch-normalization "xyz://q@some.host:100000" &&
-	! test-urlmatch-normalization "xyz://q@some.host:100001" &&
-	test-urlmatch-normalization "http://q@some.host:80" &&
-	test-urlmatch-normalization "https://q@some.host:443" &&
-	test-urlmatch-normalization "http://q@some.host:80/" &&
-	test-urlmatch-normalization "https://q@some.host:443?" &&
-	! test-urlmatch-normalization "http://q@:8008" &&
-	! test-urlmatch-normalization "http://:8080" &&
-	! test-urlmatch-normalization "http://:" &&
-	test-urlmatch-normalization "xyz://q@some.host:456/" &&
-	test-urlmatch-normalization "xyz://[::1]:456/" &&
-	test-urlmatch-normalization "xyz://[::1]:/" &&
-	! test-urlmatch-normalization "xyz://[::1]:000/" &&
-	! test-urlmatch-normalization "xyz://[::1]:0%300/" &&
-	! test-urlmatch-normalization "xyz://[::1]:0x80/" &&
-	! test-urlmatch-normalization "xyz://[::1]:4294967297/" &&
-	! test-urlmatch-normalization "xyz://[::1]:030f/"
+	test-tool urlmatch-normalization "xyz://q@some.host:" &&
+	test-tool urlmatch-normalization "xyz://q@some.host:456/" &&
+	! test-tool urlmatch-normalization "xyz://q@some.host:0" &&
+	! test-tool urlmatch-normalization "xyz://q@some.host:0000000" &&
+	test-tool urlmatch-normalization "xyz://q@some.host:0000001?" &&
+	test-tool urlmatch-normalization "xyz://q@some.host:065535#" &&
+	test-tool urlmatch-normalization "xyz://q@some.host:65535" &&
+	! test-tool urlmatch-normalization "xyz://q@some.host:65536" &&
+	! test-tool urlmatch-normalization "xyz://q@some.host:99999" &&
+	! test-tool urlmatch-normalization "xyz://q@some.host:100000" &&
+	! test-tool urlmatch-normalization "xyz://q@some.host:100001" &&
+	test-tool urlmatch-normalization "http://q@some.host:80" &&
+	test-tool urlmatch-normalization "https://q@some.host:443" &&
+	test-tool urlmatch-normalization "http://q@some.host:80/" &&
+	test-tool urlmatch-normalization "https://q@some.host:443?" &&
+	! test-tool urlmatch-normalization "http://q@:8008" &&
+	! test-tool urlmatch-normalization "http://:8080" &&
+	! test-tool urlmatch-normalization "http://:" &&
+	test-tool urlmatch-normalization "xyz://q@some.host:456/" &&
+	test-tool urlmatch-normalization "xyz://[::1]:456/" &&
+	test-tool urlmatch-normalization "xyz://[::1]:/" &&
+	! test-tool urlmatch-normalization "xyz://[::1]:000/" &&
+	! test-tool urlmatch-normalization "xyz://[::1]:0%300/" &&
+	! test-tool urlmatch-normalization "xyz://[::1]:0x80/" &&
+	! test-tool urlmatch-normalization "xyz://[::1]:4294967297/" &&
+	! test-tool urlmatch-normalization "xyz://[::1]:030f/"
 '
 
 test_expect_success 'url port normalization' '
-	test "$(test-urlmatch-normalization -p "http://x:800")" = "http://x:800/" &&
-	test "$(test-urlmatch-normalization -p "http://x:0800")" = "http://x:800/" &&
-	test "$(test-urlmatch-normalization -p "http://x:00000800")" = "http://x:800/" &&
-	test "$(test-urlmatch-normalization -p "http://x:065535")" = "http://x:65535/" &&
-	test "$(test-urlmatch-normalization -p "http://x:1")" = "http://x:1/" &&
-	test "$(test-urlmatch-normalization -p "http://x:80")" = "http://x/" &&
-	test "$(test-urlmatch-normalization -p "http://x:080")" = "http://x/" &&
-	test "$(test-urlmatch-normalization -p "http://x:000000080")" = "http://x/" &&
-	test "$(test-urlmatch-normalization -p "https://x:443")" = "https://x/" &&
-	test "$(test-urlmatch-normalization -p "https://x:0443")" = "https://x/" &&
-	test "$(test-urlmatch-normalization -p "https://x:000000443")" = "https://x/"
+	test "$(test-tool urlmatch-normalization -p "http://x:800")" = "http://x:800/" &&
+	test "$(test-tool urlmatch-normalization -p "http://x:0800")" = "http://x:800/" &&
+	test "$(test-tool urlmatch-normalization -p "http://x:00000800")" = "http://x:800/" &&
+	test "$(test-tool urlmatch-normalization -p "http://x:065535")" = "http://x:65535/" &&
+	test "$(test-tool urlmatch-normalization -p "http://x:1")" = "http://x:1/" &&
+	test "$(test-tool urlmatch-normalization -p "http://x:80")" = "http://x/" &&
+	test "$(test-tool urlmatch-normalization -p "http://x:080")" = "http://x/" &&
+	test "$(test-tool urlmatch-normalization -p "http://x:000000080")" = "http://x/" &&
+	test "$(test-tool urlmatch-normalization -p "https://x:443")" = "https://x/" &&
+	test "$(test-tool urlmatch-normalization -p "https://x:0443")" = "https://x/" &&
+	test "$(test-tool urlmatch-normalization -p "https://x:000000443")" = "https://x/"
 '
 
 test_expect_success 'url general escapes' '
-	! test-urlmatch-normalization "http://x.y?%fg" &&
-	test "$(test-urlmatch-normalization -p "X://W/%7e%41^%3a")" = "x://w/~A%5E%3A" &&
-	test "$(test-urlmatch-normalization -p "X://W/:/?#[]@")" = "x://w/:/?#[]@" &&
-	test "$(test-urlmatch-normalization -p "X://W/$&()*+,;=")" = "x://w/$&()*+,;=" &&
-	test "$(test-urlmatch-normalization -p "X://W/'\''")" = "x://w/'\''" &&
-	test "$(test-urlmatch-normalization -p "X://W?'\!'")" = "x://w/?'\!'"
+	! test-tool urlmatch-normalization "http://x.y?%fg" &&
+	test "$(test-tool urlmatch-normalization -p "X://W/%7e%41^%3a")" = "x://w/~A%5E%3A" &&
+	test "$(test-tool urlmatch-normalization -p "X://W/:/?#[]@")" = "x://w/:/?#[]@" &&
+	test "$(test-tool urlmatch-normalization -p "X://W/$&()*+,;=")" = "x://w/$&()*+,;=" &&
+	test "$(test-tool urlmatch-normalization -p "X://W/'\''")" = "x://w/'\''" &&
+	test "$(test-tool urlmatch-normalization -p "X://W?'\!'")" = "x://w/?'\!'"
 '
 
 test_expect_success !MINGW 'url high-bit escapes' '
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-1")")" = "x://q/%01%02%03%04%05%06%07%08%0E%0F%10%11%12" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-2")")" = "x://q/%13%14%15%16%17%18%19%1B%1C%1D%1E%1F%7F" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-3")")" = "x://q/%80%81%82%83%84%85%86%87%88%89%8A%8B%8C%8D%8E%8F" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-4")")" = "x://q/%90%91%92%93%94%95%96%97%98%99%9A%9B%9C%9D%9E%9F" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-5")")" = "x://q/%A0%A1%A2%A3%A4%A5%A6%A7%A8%A9%AA%AB%AC%AD%AE%AF" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-6")")" = "x://q/%B0%B1%B2%B3%B4%B5%B6%B7%B8%B9%BA%BB%BC%BD%BE%BF" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-7")")" = "x://q/%C0%C1%C2%C3%C4%C5%C6%C7%C8%C9%CA%CB%CC%CD%CE%CF" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-8")")" = "x://q/%D0%D1%D2%D3%D4%D5%D6%D7%D8%D9%DA%DB%DC%DD%DE%DF" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-9")")" = "x://q/%E0%E1%E2%E3%E4%E5%E6%E7%E8%E9%EA%EB%EC%ED%EE%EF" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-10")")" = "x://q/%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF"
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-1")")" = "x://q/%01%02%03%04%05%06%07%08%0E%0F%10%11%12" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-2")")" = "x://q/%13%14%15%16%17%18%19%1B%1C%1D%1E%1F%7F" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-3")")" = "x://q/%80%81%82%83%84%85%86%87%88%89%8A%8B%8C%8D%8E%8F" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-4")")" = "x://q/%90%91%92%93%94%95%96%97%98%99%9A%9B%9C%9D%9E%9F" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-5")")" = "x://q/%A0%A1%A2%A3%A4%A5%A6%A7%A8%A9%AA%AB%AC%AD%AE%AF" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-6")")" = "x://q/%B0%B1%B2%B3%B4%B5%B6%B7%B8%B9%BA%BB%BC%BD%BE%BF" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-7")")" = "x://q/%C0%C1%C2%C3%C4%C5%C6%C7%C8%C9%CA%CB%CC%CD%CE%CF" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-8")")" = "x://q/%D0%D1%D2%D3%D4%D5%D6%D7%D8%D9%DA%DB%DC%DD%DE%DF" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-9")")" = "x://q/%E0%E1%E2%E3%E4%E5%E6%E7%E8%E9%EA%EB%EC%ED%EE%EF" &&
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-10")")" = "x://q/%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF"
 '
 
 test_expect_success 'url utf-8 escapes' '
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-11")")" = "x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD"
+	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-11")")" = "x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD"
 '
 
 test_expect_success 'url username/password escapes' '
-	test "$(test-urlmatch-normalization -p "x://%41%62(^):%70+d@foo")" = "x://Ab(%5E):p+d@foo/"
+	test "$(test-tool urlmatch-normalization -p "x://%41%62(^):%70+d@foo")" = "x://Ab(%5E):p+d@foo/"
 '
 
 test_expect_success 'url normalized lengths' '
-	test "$(test-urlmatch-normalization -l "Http://%4d%65:%4d^%70@The.Host")" = 25 &&
-	test "$(test-urlmatch-normalization -l "http://%41:%42@x.y/%61/")" = 17 &&
-	test "$(test-urlmatch-normalization -l "http://@x.y/^")" = 15
+	test "$(test-tool urlmatch-normalization -l "Http://%4d%65:%4d^%70@The.Host")" = 25 &&
+	test "$(test-tool urlmatch-normalization -l "http://%41:%42@x.y/%61/")" = 17 &&
+	test "$(test-tool urlmatch-normalization -l "http://@x.y/^")" = 15
 '
 
 test_expect_success 'url . and .. segments' '
-	test "$(test-urlmatch-normalization -p "x://y/.")" = "x://y/" &&
-	test "$(test-urlmatch-normalization -p "x://y/./")" = "x://y/" &&
-	test "$(test-urlmatch-normalization -p "x://y/a/.")" = "x://y/a" &&
-	test "$(test-urlmatch-normalization -p "x://y/a/./")" = "x://y/a/" &&
-	test "$(test-urlmatch-normalization -p "x://y/.?")" = "x://y/?" &&
-	test "$(test-urlmatch-normalization -p "x://y/./?")" = "x://y/?" &&
-	test "$(test-urlmatch-normalization -p "x://y/a/.?")" = "x://y/a?" &&
-	test "$(test-urlmatch-normalization -p "x://y/a/./?")" = "x://y/a/?" &&
-	test "$(test-urlmatch-normalization -p "x://y/a/./b/.././../c")" = "x://y/c" &&
-	test "$(test-urlmatch-normalization -p "x://y/a/./b/../.././c/")" = "x://y/c/" &&
-	test "$(test-urlmatch-normalization -p "x://y/a/./b/.././../c/././.././.")" = "x://y/" &&
-	! test-urlmatch-normalization "x://y/a/./b/.././../c/././.././.." &&
-	test "$(test-urlmatch-normalization -p "x://y/a/./?/././..")" = "x://y/a/?/././.." &&
-	test "$(test-urlmatch-normalization -p "x://y/%2e/")" = "x://y/" &&
-	test "$(test-urlmatch-normalization -p "x://y/%2E/")" = "x://y/" &&
-	test "$(test-urlmatch-normalization -p "x://y/a/%2e./")" = "x://y/" &&
-	test "$(test-urlmatch-normalization -p "x://y/b/.%2E/")" = "x://y/" &&
-	test "$(test-urlmatch-normalization -p "x://y/c/%2e%2E/")" = "x://y/"
+	test "$(test-tool urlmatch-normalization -p "x://y/.")" = "x://y/" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/./")" = "x://y/" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/.")" = "x://y/a" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/./")" = "x://y/a/" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/.?")" = "x://y/?" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/./?")" = "x://y/?" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/.?")" = "x://y/a?" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/./?")" = "x://y/a/?" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/./b/.././../c")" = "x://y/c" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/./b/../.././c/")" = "x://y/c/" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/./b/.././../c/././.././.")" = "x://y/" &&
+	! test-tool urlmatch-normalization "x://y/a/./b/.././../c/././.././.." &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/./?/././..")" = "x://y/a/?/././.." &&
+	test "$(test-tool urlmatch-normalization -p "x://y/%2e/")" = "x://y/" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/%2E/")" = "x://y/" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/a/%2e./")" = "x://y/" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/b/.%2E/")" = "x://y/" &&
+	test "$(test-tool urlmatch-normalization -p "x://y/c/%2e%2E/")" = "x://y/"
 '
 
 # http://@foo specifies an empty user name but does not specify a password
 # http://foo  specifies neither a user name nor a password
 # So they should not be equivalent
 test_expect_success 'url equivalents' '
-	test-urlmatch-normalization "httP://x" "Http://X/" &&
-	test-urlmatch-normalization "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me:%4D^p@the.HOST:80/" &&
-	! test-urlmatch-normalization "https://@x.y/^" "httpS://x.y:443/^" &&
-	test-urlmatch-normalization "https://@x.y/^" "httpS://@x.y:0443/^" &&
-	test-urlmatch-normalization "https://@x.y/^/../abc" "httpS://@x.y:0443/abc" &&
-	test-urlmatch-normalization "https://@x.y/^/.." "httpS://@x.y:0443/"
+	test-tool urlmatch-normalization "httP://x" "Http://X/" &&
+	test-tool urlmatch-normalization "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me:%4D^p@the.HOST:80/" &&
+	! test-tool urlmatch-normalization "https://@x.y/^" "httpS://x.y:443/^" &&
+	test-tool urlmatch-normalization "https://@x.y/^" "httpS://@x.y:0443/^" &&
+	test-tool urlmatch-normalization "https://@x.y/^/../abc" "httpS://@x.y:0443/abc" &&
+	test-tool urlmatch-normalization "https://@x.y/^/.." "httpS://@x.y:0443/"
 '
 
 test_done
-- 
2.17.0.rc0.348.gd5a49e0b6f

