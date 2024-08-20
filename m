Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8AFC11
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167254; cv=none; b=sYCSrDNm/Qb+e8ZSgqGDOEKWsctV+n4J1lFlGXy/umbLqcTZsTtqzuZDuwSKNHNAWdPapXxEv8rXWC6pzVPIuDZMvaDwkKoQkeHWAKCsnJ25AmYPfQ9xj00B1e8leIjfWvipK4LGTlzeKOxqLsDe8ckRSFEj/MtlTIJKRWUmuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167254; c=relaxed/simple;
	bh=gVb2a0URB8nfZUnrBZZKaaAcb02JaeAzxtsIbZM/mLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0uY/jw7SNwpuh2ZadzornFMRl6JsbTuE6qHPtpikczHjzIrIc7/Vmfe0X+73MYoiuip/ffKA4Oo0lVAvSkrVQ3EyMoIu4t+lVFVF6dU6p3JY/Jtwk3VoEYbbn3F1q0IeA93ESBlRAsZBQexqYDOO7UiqorswchSDq8T8etYZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae9Y1kTy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae9Y1kTy"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso3745873a12.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167251; x=1724772051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wDon0eDUA8rgpY0rLnjmFge7TfvjXo6OlBEmOGBr5U=;
        b=Ae9Y1kTyo5QzZXoTxXqVBwlbDZr4nIOpOtgLK0B/v4q6bCiuW0l46Jln1etWB5qg39
         io0IbIN/bZaKqfJmQA6wDWLu+DTsa/GYznLBnXOERHh2mlk44syj988A23rQXTGA1/Sm
         cNcalP0fOx7jX5vYl6U1qyPMaF+MMjGAz7kAnknWCzH0UH6kkxzIhKgtXjqdWLILm9Ag
         sMe4A816PkWCzOFCaHSnpRDa4xbyQTklBhSKUcyoCyfeGkEOp9fXQwzrpGhId5aEjLp6
         lDJwjOZmQ71yHRVYZMyXg4uNuUdvv2ahpIn81OCmUmuILtJrwVXYSJ/iq/iEGK+36jMW
         V7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167251; x=1724772051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wDon0eDUA8rgpY0rLnjmFge7TfvjXo6OlBEmOGBr5U=;
        b=cqGc+oPWBc+pJv2mL2Vefm89ggi3bG6RqzdAc4aq17NaRrxZNwYttBeNBkXmOLnYpa
         ulyKYug1T1Zv2twA6jE93Z7iNRw6fCdkiYjNFR1c+0IPF78QQ5SF+Ojdhi8m0goqBr/b
         D5WtcTUNqwiGw9wR4eNGCJCI7V+otdURUhTnFoDRqxE42HgC6HyMrUlApmRqFQOhxcaa
         Es8BxiDVsAQiqxrhgPC4jkPsXnFRSBUg/D6BVrLcCHFSpc5Upn1P18amzaFtEoz4W9CO
         3VrM6Ax/s5x+DojrDbGH3qSEFzoyEfMgQuJxi5UTH4QFKPf5wIJQ3LjHC6/PP4+l+ttj
         /BEA==
X-Gm-Message-State: AOJu0YxgBC1Mx6updRa/bLXwHgH/Mlw04TbgA8R6c2iIJz7/p7e3Gv6U
	6x4IBvW//H8Zgr3kUo/a4iuxJv5ti4Ajg+11dIMlpyo1bm57/hFIbLSYFXQS
X-Google-Smtp-Source: AGHT+IFCx/NcLos2eZYY3Js+MoslKSnX6PPNFwBJpK12d8y5hVDmMUg8PbHS+6W20fHPTjk+/VryTg==
X-Received: by 2002:a17:90a:ca89:b0:2d3:cd22:e67b with SMTP id 98e67ed59e1d1-2d3dfc37c7dmr13612967a91.6.1724167250384;
        Tue, 20 Aug 2024 08:20:50 -0700 (PDT)
Received: from localhost.localdomain ([106.222.206.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d42c193c50sm5481833a91.57.2024.08.20.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:20:49 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH v4] t: migrate t0110-urlmatch-normalization to the new framework
Date: Tue, 20 Aug 2024 20:49:47 +0530
Message-ID: <20240820152008.21354-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814142057.94671-1-shyamthakkar001@gmail.com>
References: <20240814142057.94671-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper/test-urlmatch-normalization along with
t0110-urlmatch-normalization test the `url_normalize()` function from
'urlmatch.h'. Migrate them to the unit testing framework for better
performance. And also add different test_msg()s for better debugging.

In the migration, last two of the checks from `t_url_general_escape()`
were slightly changed compared to the shell script. This involves
changing

'\'' -> '
'\!' -> !

in the urls of those checks. This is because in C strings, we don't
need to escape "'" and "!". Other than these two, all the urls were
pasted verbatim from the shell script.

Another change is the removal of a MINGW prerequisite from one of the
test. It was there because[1] on Windows, the command line is a
Unicode string, it is not possible to pass arbitrary bytes to a
program. But in unit tests we don't have this limitation.

And since we can construct strings with arbitrary bytes in C, let's
also remove the test files which contain URLs with arbitrary bytes in
the 't/t0110' directory and instead embed those URLs in the unit test
code itself.

[1]: https://lore.kernel.org/git/53CAC8EF.6020707@gmail.com/

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 Makefile                                |   2 +-
 t/helper/test-tool.c                    |   1 -
 t/helper/test-tool.h                    |   1 -
 t/helper/test-urlmatch-normalization.c  |  56 -----
 t/t0110-urlmatch-normalization.sh       | 182 ----------------
 t/t0110/README                          |   9 -
 t/t0110/url-1                           | Bin 20 -> 0 bytes
 t/t0110/url-10                          | Bin 23 -> 0 bytes
 t/t0110/url-11                          | Bin 25 -> 0 bytes
 t/t0110/url-2                           | Bin 20 -> 0 bytes
 t/t0110/url-3                           | Bin 23 -> 0 bytes
 t/t0110/url-4                           | Bin 23 -> 0 bytes
 t/t0110/url-5                           | Bin 23 -> 0 bytes
 t/t0110/url-6                           | Bin 23 -> 0 bytes
 t/t0110/url-7                           | Bin 23 -> 0 bytes
 t/t0110/url-8                           | Bin 23 -> 0 bytes
 t/t0110/url-9                           | Bin 23 -> 0 bytes
 t/unit-tests/t-urlmatch-normalization.c | 271 ++++++++++++++++++++++++
 18 files changed, 272 insertions(+), 250 deletions(-)
 delete mode 100644 t/helper/test-urlmatch-normalization.c
 delete mode 100755 t/t0110-urlmatch-normalization.sh
 delete mode 100644 t/t0110/README
 delete mode 100644 t/t0110/url-1
 delete mode 100644 t/t0110/url-10
 delete mode 100644 t/t0110/url-11
 delete mode 100644 t/t0110/url-2
 delete mode 100644 t/t0110/url-3
 delete mode 100644 t/t0110/url-4
 delete mode 100644 t/t0110/url-5
 delete mode 100644 t/t0110/url-6
 delete mode 100644 t/t0110/url-7
 delete mode 100644 t/t0110/url-8
 delete mode 100644 t/t0110/url-9
 create mode 100644 t/unit-tests/t-urlmatch-normalization.c

diff --git a/Makefile b/Makefile
index 3863e60b66..d7bc19e823 100644
--- a/Makefile
+++ b/Makefile
@@ -843,7 +843,6 @@ TEST_BUILTINS_OBJS += test-submodule.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-truncate.o
-TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-userdiff.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
@@ -1346,6 +1345,7 @@ UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-strvec
 UNIT_TEST_PROGRAMS += t-trailer
+UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index da3e69128a..f8a67df7de 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -83,7 +83,6 @@ static struct test_cmd cmds[] = {
 	{ "trace2", cmd__trace2 },
 	{ "truncate", cmd__truncate },
 	{ "userdiff", cmd__userdiff },
-	{ "urlmatch-normalization", cmd__urlmatch_normalization },
 	{ "xml-encode", cmd__xml_encode },
 	{ "wildmatch", cmd__wildmatch },
 #ifdef GIT_WINDOWS_NATIVE
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 642a34578c..e74bc0ffd4 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -76,7 +76,6 @@ int cmd__subprocess(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__truncate(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
-int cmd__urlmatch_normalization(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
 #ifdef GIT_WINDOWS_NATIVE
diff --git a/t/helper/test-urlmatch-normalization.c b/t/helper/test-urlmatch-normalization.c
deleted file mode 100644
index 86edd454f5..0000000000
--- a/t/helper/test-urlmatch-normalization.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#include "test-tool.h"
-#include "git-compat-util.h"
-#include "urlmatch.h"
-
-int cmd__urlmatch_normalization(int argc, const char **argv)
-{
-	const char usage[] = "test-tool urlmatch-normalization [-p | -l] <url1> | <url1> <url2>";
-	char *url1 = NULL, *url2 = NULL;
-	int opt_p = 0, opt_l = 0;
-	int ret = 0;
-
-	/*
-	 * For one url, succeed if url_normalize succeeds on it, fail otherwise.
-	 * For two urls, succeed only if url_normalize succeeds on both and
-	 * the results compare equal with strcmp.  If -p is given (one url only)
-	 * and url_normalize succeeds, print the result followed by "\n".  If
-	 * -l is given (one url only) and url_normalize succeeds, print the
-	 * returned length in decimal followed by "\n".
-	 */
-
-	if (argc > 1 && !strcmp(argv[1], "-p")) {
-		opt_p = 1;
-		argc--;
-		argv++;
-	} else if (argc > 1 && !strcmp(argv[1], "-l")) {
-		opt_l = 1;
-		argc--;
-		argv++;
-	}
-
-	if (argc < 2 || argc > 3)
-		die("%s", usage);
-
-	if (argc == 2) {
-		struct url_info info;
-		url1 = url_normalize(argv[1], &info);
-		if (!url1)
-			return 1;
-		if (opt_p)
-			printf("%s\n", url1);
-		if (opt_l)
-			printf("%u\n", (unsigned)info.url_len);
-		goto cleanup;
-	}
-
-	if (opt_p || opt_l)
-		die("%s", usage);
-
-	url1 = url_normalize(argv[1], NULL);
-	url2 = url_normalize(argv[2], NULL);
-	ret = (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
-cleanup:
-	free(url1);
-	free(url2);
-	return ret;
-}
diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch-normalization.sh
deleted file mode 100755
index 12d817fbd3..0000000000
--- a/t/t0110-urlmatch-normalization.sh
+++ /dev/null
@@ -1,182 +0,0 @@
-#!/bin/sh
-
-test_description='urlmatch URL normalization'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-# The base name of the test url files
-tu="$TEST_DIRECTORY/t0110/url"
-
-# Note that only file: URLs should be allowed without a host
-
-test_expect_success 'url scheme' '
-	! test-tool urlmatch-normalization "" &&
-	! test-tool urlmatch-normalization "_" &&
-	! test-tool urlmatch-normalization "scheme" &&
-	! test-tool urlmatch-normalization "scheme:" &&
-	! test-tool urlmatch-normalization "scheme:/" &&
-	! test-tool urlmatch-normalization "scheme://" &&
-	! test-tool urlmatch-normalization "file" &&
-	! test-tool urlmatch-normalization "file:" &&
-	! test-tool urlmatch-normalization "file:/" &&
-	test-tool urlmatch-normalization "file://" &&
-	! test-tool urlmatch-normalization "://acme.co" &&
-	! test-tool urlmatch-normalization "x_test://acme.co" &&
-	! test-tool urlmatch-normalization "-test://acme.co" &&
-	! test-tool urlmatch-normalization "0test://acme.co" &&
-	! test-tool urlmatch-normalization "+test://acme.co" &&
-	! test-tool urlmatch-normalization ".test://acme.co" &&
-	! test-tool urlmatch-normalization "schem%6e://" &&
-	test-tool urlmatch-normalization "x-Test+v1.0://acme.co" &&
-	test "$(test-tool urlmatch-normalization -p "AbCdeF://x.Y")" = "abcdef://x.y/"
-'
-
-test_expect_success 'url authority' '
-	! test-tool urlmatch-normalization "scheme://user:pass@" &&
-	! test-tool urlmatch-normalization "scheme://?" &&
-	! test-tool urlmatch-normalization "scheme://#" &&
-	! test-tool urlmatch-normalization "scheme:///" &&
-	! test-tool urlmatch-normalization "scheme://:" &&
-	! test-tool urlmatch-normalization "scheme://:555" &&
-	test-tool urlmatch-normalization "file://user:pass@" &&
-	test-tool urlmatch-normalization "file://?" &&
-	test-tool urlmatch-normalization "file://#" &&
-	test-tool urlmatch-normalization "file:///" &&
-	test-tool urlmatch-normalization "file://:" &&
-	! test-tool urlmatch-normalization "file://:555" &&
-	test-tool urlmatch-normalization "scheme://user:pass@host" &&
-	test-tool urlmatch-normalization "scheme://@host" &&
-	test-tool urlmatch-normalization "scheme://%00@host" &&
-	! test-tool urlmatch-normalization "scheme://%%@host" &&
-	test-tool urlmatch-normalization "scheme://host_" &&
-	test-tool urlmatch-normalization "scheme://user:pass@host/" &&
-	test-tool urlmatch-normalization "scheme://@host/" &&
-	test-tool urlmatch-normalization "scheme://host/" &&
-	test-tool urlmatch-normalization "scheme://host?x" &&
-	test-tool urlmatch-normalization "scheme://host#x" &&
-	test-tool urlmatch-normalization "scheme://host/@" &&
-	test-tool urlmatch-normalization "scheme://host?@x" &&
-	test-tool urlmatch-normalization "scheme://host#@x" &&
-	test-tool urlmatch-normalization "scheme://[::1]" &&
-	test-tool urlmatch-normalization "scheme://[::1]/" &&
-	! test-tool urlmatch-normalization "scheme://hos%41/" &&
-	test-tool urlmatch-normalization "scheme://[invalid....:/" &&
-	test-tool urlmatch-normalization "scheme://invalid....:]/" &&
-	! test-tool urlmatch-normalization "scheme://invalid....:[/" &&
-	! test-tool urlmatch-normalization "scheme://invalid....:["
-'
-
-test_expect_success 'url port checks' '
-	test-tool urlmatch-normalization "xyz://q@some.host:" &&
-	test-tool urlmatch-normalization "xyz://q@some.host:456/" &&
-	! test-tool urlmatch-normalization "xyz://q@some.host:0" &&
-	! test-tool urlmatch-normalization "xyz://q@some.host:0000000" &&
-	test-tool urlmatch-normalization "xyz://q@some.host:0000001?" &&
-	test-tool urlmatch-normalization "xyz://q@some.host:065535#" &&
-	test-tool urlmatch-normalization "xyz://q@some.host:65535" &&
-	! test-tool urlmatch-normalization "xyz://q@some.host:65536" &&
-	! test-tool urlmatch-normalization "xyz://q@some.host:99999" &&
-	! test-tool urlmatch-normalization "xyz://q@some.host:100000" &&
-	! test-tool urlmatch-normalization "xyz://q@some.host:100001" &&
-	test-tool urlmatch-normalization "http://q@some.host:80" &&
-	test-tool urlmatch-normalization "https://q@some.host:443" &&
-	test-tool urlmatch-normalization "http://q@some.host:80/" &&
-	test-tool urlmatch-normalization "https://q@some.host:443?" &&
-	! test-tool urlmatch-normalization "http://q@:8008" &&
-	! test-tool urlmatch-normalization "http://:8080" &&
-	! test-tool urlmatch-normalization "http://:" &&
-	test-tool urlmatch-normalization "xyz://q@some.host:456/" &&
-	test-tool urlmatch-normalization "xyz://[::1]:456/" &&
-	test-tool urlmatch-normalization "xyz://[::1]:/" &&
-	! test-tool urlmatch-normalization "xyz://[::1]:000/" &&
-	! test-tool urlmatch-normalization "xyz://[::1]:0%300/" &&
-	! test-tool urlmatch-normalization "xyz://[::1]:0x80/" &&
-	! test-tool urlmatch-normalization "xyz://[::1]:4294967297/" &&
-	! test-tool urlmatch-normalization "xyz://[::1]:030f/"
-'
-
-test_expect_success 'url port normalization' '
-	test "$(test-tool urlmatch-normalization -p "http://x:800")" = "http://x:800/" &&
-	test "$(test-tool urlmatch-normalization -p "http://x:0800")" = "http://x:800/" &&
-	test "$(test-tool urlmatch-normalization -p "http://x:00000800")" = "http://x:800/" &&
-	test "$(test-tool urlmatch-normalization -p "http://x:065535")" = "http://x:65535/" &&
-	test "$(test-tool urlmatch-normalization -p "http://x:1")" = "http://x:1/" &&
-	test "$(test-tool urlmatch-normalization -p "http://x:80")" = "http://x/" &&
-	test "$(test-tool urlmatch-normalization -p "http://x:080")" = "http://x/" &&
-	test "$(test-tool urlmatch-normalization -p "http://x:000000080")" = "http://x/" &&
-	test "$(test-tool urlmatch-normalization -p "https://x:443")" = "https://x/" &&
-	test "$(test-tool urlmatch-normalization -p "https://x:0443")" = "https://x/" &&
-	test "$(test-tool urlmatch-normalization -p "https://x:000000443")" = "https://x/"
-'
-
-test_expect_success 'url general escapes' '
-	! test-tool urlmatch-normalization "http://x.y?%fg" &&
-	test "$(test-tool urlmatch-normalization -p "X://W/%7e%41^%3a")" = "x://w/~A%5E%3A" &&
-	test "$(test-tool urlmatch-normalization -p "X://W/:/?#[]@")" = "x://w/:/?#[]@" &&
-	test "$(test-tool urlmatch-normalization -p "X://W/$&()*+,;=")" = "x://w/$&()*+,;=" &&
-	test "$(test-tool urlmatch-normalization -p "X://W/'\''")" = "x://w/'\''" &&
-	test "$(test-tool urlmatch-normalization -p "X://W?'\!'")" = "x://w/?'\!'"
-'
-
-test_expect_success !MINGW 'url high-bit escapes' '
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-1")")" = "x://q/%01%02%03%04%05%06%07%08%0E%0F%10%11%12" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-2")")" = "x://q/%13%14%15%16%17%18%19%1B%1C%1D%1E%1F%7F" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-3")")" = "x://q/%80%81%82%83%84%85%86%87%88%89%8A%8B%8C%8D%8E%8F" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-4")")" = "x://q/%90%91%92%93%94%95%96%97%98%99%9A%9B%9C%9D%9E%9F" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-5")")" = "x://q/%A0%A1%A2%A3%A4%A5%A6%A7%A8%A9%AA%AB%AC%AD%AE%AF" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-6")")" = "x://q/%B0%B1%B2%B3%B4%B5%B6%B7%B8%B9%BA%BB%BC%BD%BE%BF" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-7")")" = "x://q/%C0%C1%C2%C3%C4%C5%C6%C7%C8%C9%CA%CB%CC%CD%CE%CF" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-8")")" = "x://q/%D0%D1%D2%D3%D4%D5%D6%D7%D8%D9%DA%DB%DC%DD%DE%DF" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-9")")" = "x://q/%E0%E1%E2%E3%E4%E5%E6%E7%E8%E9%EA%EB%EC%ED%EE%EF" &&
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-10")")" = "x://q/%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF"
-'
-
-test_expect_success 'url utf-8 escapes' '
-	test "$(test-tool urlmatch-normalization -p "$(cat "$tu-11")")" = "x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD"
-'
-
-test_expect_success 'url username/password escapes' '
-	test "$(test-tool urlmatch-normalization -p "x://%41%62(^):%70+d@foo")" = "x://Ab(%5E):p+d@foo/"
-'
-
-test_expect_success 'url normalized lengths' '
-	test "$(test-tool urlmatch-normalization -l "Http://%4d%65:%4d^%70@The.Host")" = 25 &&
-	test "$(test-tool urlmatch-normalization -l "http://%41:%42@x.y/%61/")" = 17 &&
-	test "$(test-tool urlmatch-normalization -l "http://@x.y/^")" = 15
-'
-
-test_expect_success 'url . and .. segments' '
-	test "$(test-tool urlmatch-normalization -p "x://y/.")" = "x://y/" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/./")" = "x://y/" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/.")" = "x://y/a" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/./")" = "x://y/a/" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/.?")" = "x://y/?" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/./?")" = "x://y/?" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/.?")" = "x://y/a?" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/./?")" = "x://y/a/?" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/./b/.././../c")" = "x://y/c" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/./b/../.././c/")" = "x://y/c/" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/./b/.././../c/././.././.")" = "x://y/" &&
-	! test-tool urlmatch-normalization "x://y/a/./b/.././../c/././.././.." &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/./?/././..")" = "x://y/a/?/././.." &&
-	test "$(test-tool urlmatch-normalization -p "x://y/%2e/")" = "x://y/" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/%2E/")" = "x://y/" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/a/%2e./")" = "x://y/" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/b/.%2E/")" = "x://y/" &&
-	test "$(test-tool urlmatch-normalization -p "x://y/c/%2e%2E/")" = "x://y/"
-'
-
-# http://@foo specifies an empty user name but does not specify a password
-# http://foo  specifies neither a user name nor a password
-# So they should not be equivalent
-test_expect_success 'url equivalents' '
-	test-tool urlmatch-normalization "httP://x" "Http://X/" &&
-	test-tool urlmatch-normalization "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me:%4D^p@the.HOST:80/" &&
-	! test-tool urlmatch-normalization "https://@x.y/^" "httpS://x.y:443/^" &&
-	test-tool urlmatch-normalization "https://@x.y/^" "httpS://@x.y:0443/^" &&
-	test-tool urlmatch-normalization "https://@x.y/^/../abc" "httpS://@x.y:0443/abc" &&
-	test-tool urlmatch-normalization "https://@x.y/^/.." "httpS://@x.y:0443/"
-'
-
-test_done
diff --git a/t/t0110/README b/t/t0110/README
deleted file mode 100644
index ad4a50ecd8..0000000000
--- a/t/t0110/README
+++ /dev/null
@@ -1,9 +0,0 @@
-The url data files in this directory contain URLs with characters
-in the range 0x01-0x1f and 0x7f-0xff to test the proper normalization
-of unprintable characters.
-
-A select few characters in the 0x01-0x1f range are skipped to help
-avoid problems running the test itself.
-
-The urls are in test files in this directory rather than being
-embedded in the test script for portability.
diff --git a/t/t0110/url-1 b/t/t0110/url-1
deleted file mode 100644
index 519019c5ce6c58478f048a2f39e2321370d318c6..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 20
bcmb=h($_E4XJle#VP#|I;Nuq%6ygE^Admtt

diff --git a/t/t0110/url-10 b/t/t0110/url-10
deleted file mode 100644
index b9965de6a5d74b122179821212b2c27c8ae03e80..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 23
hcmV+y0O<dCIxjDAFYxj5^Yr!h_xSnx`~3a>{|dCd5i<Y)

diff --git a/t/t0110/url-11 b/t/t0110/url-11
deleted file mode 100644
index f0a50f10096a20d597f40c775f09a71276e0050a..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 25
hcmb=h($_E4Kh$u4|APe$@AvQhFrlI0!}|Suxd5(W4xs=5

diff --git a/t/t0110/url-2 b/t/t0110/url-2
deleted file mode 100644
index 43334b05b2de3794d6020abd96e634a4e9e49cb0..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 20
bcmb=h($_E47Zwo}6PJ*bmXVc{ujc{)C{+Vx

diff --git a/t/t0110/url-3 b/t/t0110/url-3
deleted file mode 100644
index 7378c7bec247b996bc67b00a05ed89cf47d4b7a7..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 23
ecmb=h($_E4Z)j|4ZfR|6@96C6?&<C8=K=t7Jqj}b

diff --git a/t/t0110/url-4 b/t/t0110/url-4
deleted file mode 100644
index 220b198c97f942fea4960f51a2105cc42261061a..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 23
hcmV+y0O<dCIxjDAFOZRvla!T~mzbHFo1C4Vp9*`u3o`%!

diff --git a/t/t0110/url-5 b/t/t0110/url-5
deleted file mode 100644
index 1ccd9277792840955bb124bdde21f4b08bcccb63..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 23
hcmV+y0O<dCIxjDAFQB2Kqok##r>Lo_tE{cAuL^}d3^M=#

diff --git a/t/t0110/url-6 b/t/t0110/url-6
deleted file mode 100644
index e8283aac6dff049d3e02454db6e684c5790a5996..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 23
hcmV+y0O<dCIxjDAFR-z)v$VCgx45~wyS%-=zY31M4Kn}$

diff --git a/t/t0110/url-7 b/t/t0110/url-7
deleted file mode 100644
index fa7c10b615259deefd15b638b021da7c60eba1b2..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 23
hcmV+y0O<dCIxjDAFTlaV!^FkL$H>Xb%goKr&kC454l@7%

diff --git a/t/t0110/url-8 b/t/t0110/url-8
deleted file mode 100644
index 79a0ba836f5b8886b0a73f161eb292af2b105e65..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 23
hcmV+y0O<dCIxjDAFVNA_)6~`0*Vx(G+uYsW-wL6<4>JG&

diff --git a/t/t0110/url-9 b/t/t0110/url-9
deleted file mode 100644
index 8b44bec48b94467c63e8e1ad18162e465da6d6dd..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 23
hcmV+y0O<dCIxjDAFW}+g<K*S$=jiF`>+J3B?+U9u5HkP(

diff --git a/t/unit-tests/t-urlmatch-normalization.c b/t/unit-tests/t-urlmatch-normalization.c
new file mode 100644
index 0000000000..1769c357b9
--- /dev/null
+++ b/t/unit-tests/t-urlmatch-normalization.c
@@ -0,0 +1,271 @@
+#include "test-lib.h"
+#include "urlmatch.h"
+
+static void check_url_normalizable(const char *url, unsigned int normalizable)
+{
+	char *url_norm = url_normalize(url, NULL);
+
+	if (!check_int(normalizable, ==, url_norm ? 1 : 0))
+		test_msg("input url: %s", url);
+	free(url_norm);
+}
+
+static void check_normalized_url(const char *url, const char *expect)
+{
+	char *url_norm = url_normalize(url, NULL);
+
+	if (!check_str(url_norm, expect))
+		test_msg("input url: %s", url);
+	free(url_norm);
+}
+
+static void compare_normalized_urls(const char *url1, const char *url2,
+				    unsigned int equal)
+{
+	char *url1_norm = url_normalize(url1, NULL);
+	char *url2_norm = url_normalize(url2, NULL);
+
+	if (equal) {
+		if (!check_str(url1_norm, url2_norm))
+			test_msg("input url1: %s\n  input url2: %s", url1,
+				 url2);
+	} else if (!check_int(strcmp(url1_norm, url2_norm), !=, 0)) {
+		test_msg(" normalized url1: %s\n   normalized url2: %s\n"
+			 "  input url1: %s\n  input url2: %s",
+			 url1_norm, url2_norm, url1, url2);
+	}
+	free(url1_norm);
+	free(url2_norm);
+}
+
+static void check_normalized_url_length(const char *url, size_t len)
+{
+	struct url_info info;
+	char *url_norm = url_normalize(url, &info);
+
+	if (!check_int(info.url_len, ==, len))
+		test_msg("     input url: %s\n  normalized url: %s", url,
+			 url_norm);
+	free(url_norm);
+}
+
+/* Note that only "file:" URLs should be allowed without a host */
+static void t_url_scheme(void)
+{
+	check_url_normalizable("", 0);
+	check_url_normalizable("_", 0);
+	check_url_normalizable("scheme", 0);
+	check_url_normalizable("scheme:", 0);
+	check_url_normalizable("scheme:/", 0);
+	check_url_normalizable("scheme://", 0);
+	check_url_normalizable("file", 0);
+	check_url_normalizable("file:", 0);
+	check_url_normalizable("file:/", 0);
+	check_url_normalizable("file://", 1);
+	check_url_normalizable("://acme.co", 0);
+	check_url_normalizable("x_test://acme.co", 0);
+	check_url_normalizable("-test://acme.co", 0);
+	check_url_normalizable("0test://acme.co", 0);
+	check_url_normalizable("+test://acme.co", 0);
+	check_url_normalizable(".test://acme.co", 0);
+	check_url_normalizable("schem%6e://", 0);
+	check_url_normalizable("x-Test+v1.0://acme.co", 1);
+	check_normalized_url("AbCdeF://x.Y", "abcdef://x.y/");
+}
+
+static void t_url_authority(void)
+{
+	check_url_normalizable("scheme://user:pass@", 0);
+	check_url_normalizable("scheme://?", 0);
+	check_url_normalizable("scheme://#", 0);
+	check_url_normalizable("scheme:///", 0);
+	check_url_normalizable("scheme://:", 0);
+	check_url_normalizable("scheme://:555", 0);
+	check_url_normalizable("file://user:pass@", 1);
+	check_url_normalizable("file://?", 1);
+	check_url_normalizable("file://#", 1);
+	check_url_normalizable("file:///", 1);
+	check_url_normalizable("file://:", 1);
+	check_url_normalizable("file://:555", 0);
+	check_url_normalizable("scheme://user:pass@host", 1);
+	check_url_normalizable("scheme://@host", 1);
+	check_url_normalizable("scheme://%00@host", 1);
+	check_url_normalizable("scheme://%%@host", 0);
+	check_url_normalizable("scheme://host_", 1);
+	check_url_normalizable("scheme://user:pass@host/", 1);
+	check_url_normalizable("scheme://@host/", 1);
+	check_url_normalizable("scheme://host/", 1);
+	check_url_normalizable("scheme://host?x", 1);
+	check_url_normalizable("scheme://host#x", 1);
+	check_url_normalizable("scheme://host/@", 1);
+	check_url_normalizable("scheme://host?@x", 1);
+	check_url_normalizable("scheme://host#@x", 1);
+	check_url_normalizable("scheme://[::1]", 1);
+	check_url_normalizable("scheme://[::1]/", 1);
+	check_url_normalizable("scheme://hos%41/", 0);
+	check_url_normalizable("scheme://[invalid....:/", 1);
+	check_url_normalizable("scheme://invalid....:]/", 1);
+	check_url_normalizable("scheme://invalid....:[/", 0);
+	check_url_normalizable("scheme://invalid....:[", 0);
+}
+
+static void t_url_port(void)
+{
+	check_url_normalizable("xyz://q@some.host:", 1);
+	check_url_normalizable("xyz://q@some.host:456/", 1);
+	check_url_normalizable("xyz://q@some.host:0", 0);
+	check_url_normalizable("xyz://q@some.host:0000000", 0);
+	check_url_normalizable("xyz://q@some.host:0000001?", 1);
+	check_url_normalizable("xyz://q@some.host:065535#", 1);
+	check_url_normalizable("xyz://q@some.host:65535", 1);
+	check_url_normalizable("xyz://q@some.host:65536", 0);
+	check_url_normalizable("xyz://q@some.host:99999", 0);
+	check_url_normalizable("xyz://q@some.host:100000", 0);
+	check_url_normalizable("xyz://q@some.host:100001", 0);
+	check_url_normalizable("http://q@some.host:80", 1);
+	check_url_normalizable("https://q@some.host:443", 1);
+	check_url_normalizable("http://q@some.host:80/", 1);
+	check_url_normalizable("https://q@some.host:443?", 1);
+	check_url_normalizable("http://q@:8008", 0);
+	check_url_normalizable("http://:8080", 0);
+	check_url_normalizable("http://:", 0);
+	check_url_normalizable("xyz://q@some.host:456/", 1);
+	check_url_normalizable("xyz://[::1]:456/", 1);
+	check_url_normalizable("xyz://[::1]:/", 1);
+	check_url_normalizable("xyz://[::1]:000/", 0);
+	check_url_normalizable("xyz://[::1]:0%300/", 0);
+	check_url_normalizable("xyz://[::1]:0x80/", 0);
+	check_url_normalizable("xyz://[::1]:4294967297/", 0);
+	check_url_normalizable("xyz://[::1]:030f/", 0);
+}
+
+static void t_url_port_normalization(void)
+{
+	check_normalized_url("http://x:800", "http://x:800/");
+	check_normalized_url("http://x:0800", "http://x:800/");
+	check_normalized_url("http://x:00000800", "http://x:800/");
+	check_normalized_url("http://x:065535", "http://x:65535/");
+	check_normalized_url("http://x:1", "http://x:1/");
+	check_normalized_url("http://x:80", "http://x/");
+	check_normalized_url("http://x:080", "http://x/");
+	check_normalized_url("http://x:000000080", "http://x/");
+	check_normalized_url("https://x:443", "https://x/");
+	check_normalized_url("https://x:0443", "https://x/");
+	check_normalized_url("https://x:000000443", "https://x/");
+}
+
+static void t_url_general_escape(void)
+{
+	check_url_normalizable("http://x.y?%fg", 0);
+	check_normalized_url("X://W/%7e%41^%3a", "x://w/~A%5E%3A");
+	check_normalized_url("X://W/:/?#[]@", "x://w/:/?#[]@");
+	check_normalized_url("X://W/$&()*+,;=", "x://w/$&()*+,;=");
+	check_normalized_url("X://W/'", "x://w/'");
+	check_normalized_url("X://W?!", "x://w/?!");
+}
+
+static void t_url_high_bit(void)
+{
+	check_normalized_url(
+		"x://q/\x01\x02\x03\x04\x05\x06\x07\x08\x0e\x0f\x10\x11\x12",
+		"x://q/%01%02%03%04%05%06%07%08%0E%0F%10%11%12");
+	check_normalized_url(
+		"x://q/\x13\x14\x15\x16\x17\x18\x19\x1b\x1c\x1d\x1e\x1f\x7f",
+		"x://q/%13%14%15%16%17%18%19%1B%1C%1D%1E%1F%7F");
+	check_normalized_url(
+		"x://q/\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f",
+		"x://q/%80%81%82%83%84%85%86%87%88%89%8A%8B%8C%8D%8E%8F");
+	check_normalized_url(
+		"x://q/\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f",
+		"x://q/%90%91%92%93%94%95%96%97%98%99%9A%9B%9C%9D%9E%9F");
+	check_normalized_url(
+		"x://q/\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf",
+		"x://q/%A0%A1%A2%A3%A4%A5%A6%A7%A8%A9%AA%AB%AC%AD%AE%AF");
+	check_normalized_url(
+		"x://q/\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf",
+		"x://q/%B0%B1%B2%B3%B4%B5%B6%B7%B8%B9%BA%BB%BC%BD%BE%BF");
+	check_normalized_url(
+		"x://q/\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf",
+		"x://q/%C0%C1%C2%C3%C4%C5%C6%C7%C8%C9%CA%CB%CC%CD%CE%CF");
+	check_normalized_url(
+		"x://q/\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf",
+		"x://q/%D0%D1%D2%D3%D4%D5%D6%D7%D8%D9%DA%DB%DC%DD%DE%DF");
+	check_normalized_url(
+		"x://q/\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef",
+		"x://q/%E0%E1%E2%E3%E4%E5%E6%E7%E8%E9%EA%EB%EC%ED%EE%EF");
+	check_normalized_url(
+		"x://q/\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff",
+		"x://q/%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF");
+}
+
+static void t_url_utf8_escape(void)
+{
+	check_normalized_url(
+		"x://q/\xc2\x80\xdf\xbf\xe0\xa0\x80\xef\xbf\xbd\xf0\x90\x80\x80\xf0\xaf\xbf\xbd",
+		"x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD");
+}
+
+static void t_url_username_pass(void)
+{
+	check_normalized_url("x://%41%62(^):%70+d@foo", "x://Ab(%5E):p+d@foo/");
+}
+
+static void t_url_length(void)
+{
+	check_normalized_url_length("Http://%4d%65:%4d^%70@The.Host", 25);
+	check_normalized_url_length("http://%41:%42@x.y/%61/", 17);
+	check_normalized_url_length("http://@x.y/^", 15);
+}
+
+static void t_url_dots(void)
+{
+	check_normalized_url("x://y/.", "x://y/");
+	check_normalized_url("x://y/./", "x://y/");
+	check_normalized_url("x://y/a/.", "x://y/a");
+	check_normalized_url("x://y/a/./", "x://y/a/");
+	check_normalized_url("x://y/.?", "x://y/?");
+	check_normalized_url("x://y/./?", "x://y/?");
+	check_normalized_url("x://y/a/.?", "x://y/a?");
+	check_normalized_url("x://y/a/./?", "x://y/a/?");
+	check_normalized_url("x://y/a/./b/.././../c", "x://y/c");
+	check_normalized_url("x://y/a/./b/../.././c/", "x://y/c/");
+	check_normalized_url("x://y/a/./b/.././../c/././.././.", "x://y/");
+	check_url_normalizable("x://y/a/./b/.././../c/././.././..", 0);
+	check_normalized_url("x://y/a/./?/././..", "x://y/a/?/././..");
+	check_normalized_url("x://y/%2e/", "x://y/");
+	check_normalized_url("x://y/%2E/", "x://y/");
+	check_normalized_url("x://y/a/%2e./", "x://y/");
+	check_normalized_url("x://y/b/.%2E/", "x://y/");
+	check_normalized_url("x://y/c/%2e%2E/", "x://y/");
+}
+
+/*
+ * "http://@foo" specifies an empty user name but does not specify a password.
+ * "http://foo" specifies neither a user name nor a password.
+ * So they should not be equivalent.
+ */
+static void t_url_equivalents(void)
+{
+	compare_normalized_urls("httP://x", "Http://X/", 1);
+	compare_normalized_urls("Http://%4d%65:%4d^%70@The.Host", "hTTP://Me:%4D^p@the.HOST:80/", 1);
+	compare_normalized_urls("https://@x.y/^", "httpS://x.y:443/^", 0);
+	compare_normalized_urls("https://@x.y/^", "httpS://@x.y:0443/^", 1);
+	compare_normalized_urls("https://@x.y/^/../abc", "httpS://@x.y:0443/abc", 1);
+	compare_normalized_urls("https://@x.y/^/..", "httpS://@x.y:0443/", 1);
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	TEST(t_url_scheme(), "url scheme");
+	TEST(t_url_authority(), "url authority");
+	TEST(t_url_port(), "url port checks");
+	TEST(t_url_port_normalization(), "url port normalization");
+	TEST(t_url_general_escape(), "url general escapes");
+	TEST(t_url_high_bit(), "url high-bit escapes");
+	TEST(t_url_utf8_escape(), "url utf8 escapes");
+	TEST(t_url_username_pass(), "url username/password escapes");
+	TEST(t_url_length(), "url normalized lengths");
+	TEST(t_url_dots(), "url . and .. segments");
+	TEST(t_url_equivalents(), "url equivalents");
+	return test_done();
+}

Range-diff against v3:
1:  a73b89c8e0 ! 1:  ef25954bf8 t: migrate t0110-urlmatch-normalization to the new framework
    @@ Commit message
         performance. And also add different test_msg()s for better debugging.
     
         In the migration, last two of the checks from `t_url_general_escape()`
    -    were slightly changed compared to the shellscript. This involves changing
    +    were slightly changed compared to the shell script. This involves
    +    changing
     
         '\'' -> '
         '\!' -> !
     
         in the urls of those checks. This is because in C strings, we don't
         need to escape "'" and "!". Other than these two, all the urls were
    -    pasted verbatim from the shellscript.
    +    pasted verbatim from the shell script.
     
    -    Another change is the removal of MINGW prerequisite from one of the
    +    Another change is the removal of a MINGW prerequisite from one of the
         test. It was there because[1] on Windows, the command line is a
         Unicode string, it is not possible to pass arbitrary bytes to a
         program. But in unit tests we don't have this limitation.
    @@ t/unit-tests/t-urlmatch-normalization.c (new)
     +#include "test-lib.h"
     +#include "urlmatch.h"
     +
    -+static void check_url_normalizable(const char *url, int normalizable)
    ++static void check_url_normalizable(const char *url, unsigned int normalizable)
     +{
     +	char *url_norm = url_normalize(url, NULL);
     +
    @@ t/unit-tests/t-urlmatch-normalization.c (new)
     +}
     +
     +static void compare_normalized_urls(const char *url1, const char *url2,
    -+				    size_t equal)
    ++				    unsigned int equal)
     +{
     +	char *url1_norm = url_normalize(url1, NULL);
     +	char *url2_norm = url_normalize(url2, NULL);
    @@ t/unit-tests/t-urlmatch-normalization.c (new)
     +			test_msg("input url1: %s\n  input url2: %s", url1,
     +				 url2);
     +	} else if (!check_int(strcmp(url1_norm, url2_norm), !=, 0)) {
    -+		test_msg(" url1_norm: %s\n   url2_norm: %s\n"
    ++		test_msg(" normalized url1: %s\n   normalized url2: %s\n"
     +			 "  input url1: %s\n  input url2: %s",
     +			 url1_norm, url2_norm, url1, url2);
     +	}
    @@ t/unit-tests/t-urlmatch-normalization.c (new)
     +	free(url_norm);
     +}
     +
    -+/* Note that only file: URLs should be allowed without a host */
    ++/* Note that only "file:" URLs should be allowed without a host */
     +static void t_url_scheme(void)
     +{
     +	check_url_normalizable("", 0);
    @@ t/unit-tests/t-urlmatch-normalization.c (new)
     +}
     +
     +/*
    -+ * http://@foo specifies an empty user name but does not specify a password
    -+ * http://foo  specifies neither a user name nor a password
    -+ * So they should not be equivalent
    ++ * "http://@foo" specifies an empty user name but does not specify a password.
    ++ * "http://foo" specifies neither a user name nor a password.
    ++ * So they should not be equivalent.
     + */
     +static void t_url_equivalents(void)
     +{
-- 
2.46.0

