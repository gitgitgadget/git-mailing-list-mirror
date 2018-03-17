Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F421F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeCQH4P (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38087 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbeCQH4M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id y2-v6so16399888lfc.5
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyXzy9iuuilb5OiDJ1pMlhgz3SwfcqWz/OQiMJv8tFU=;
        b=I5xGsHBD5dX1lFRxmuNSrlFtP8uMOtDPJHNMTvSel0+o2hqhes+vL3isdizFMb49sW
         wzy+/+1fSUP23k6bDMXbZN42595s/nqeXMkiVPQPaQBQnf8YPlP7eFRml/ZNpupg9AiL
         8KfXI64Z7R4E0pVlmqlgQ9o5sOnC50bdVC5YxvLlyO+5uy0NV8VfRHrsMogUJ/TvSCxi
         gYMwBOpcVqzWcgBAfYm3scBVfwD+Sn68zpwqIoBtQIfI97lr+RcPB3NN5xgn6IMGFadY
         tPcJyJtxL3f4s1FnA3s2rnz0a9BcXR348Jl2XCQv3dJ5egNuWb2zoTmsn31caBg5BqM4
         aQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyXzy9iuuilb5OiDJ1pMlhgz3SwfcqWz/OQiMJv8tFU=;
        b=NQRLoVn96mfS07afzYHS7uNt4R2ba1pOP4RVFD3xBtieuuuKDbFKQVVdz7JOSrxyxj
         GRgGZRfgYegl8Ngjo90t8FH6O1JN7B8u80q/lGdNLNs/r6Ilmyz273s0BTzAPgr8hwFL
         5p3jRSsyvpkWbbihs4L1O6lX70UqMgR6kYFi6U40OtFjZLEZbNZmXJK2U3eGnRI0jYSh
         /DUin7jeDzLFUbituUwWx4VVpGGXufHvJMGbGW1lUQar3rBJjec69AdV770Gx3jtrg0m
         TXZhJ0OyiAYAqhcgvA9os4r9gqgZajn8OH6BG1I+x4jSixAtwh6CvSe6N/xWKahf+DDL
         I86A==
X-Gm-Message-State: AElRT7HcmkYXSITFqDezKpmSJiyHn/RqjzEiIuzRo5W3P5icl8pRJ5np
        3LQF7rVQC1nBVi72pAbDEMOoPQ==
X-Google-Smtp-Source: AG47ELv3LCma4FVpw6S5ZLNdFd08PnJwe4WKiJAkvCEbuWzeod20rw7mPH3tIcVYbDYNP8GpiDZvPQ==
X-Received: by 10.46.44.17 with SMTP id s17mr3413993ljs.149.1521273371157;
        Sat, 17 Mar 2018 00:56:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:56:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 36/36] t/helper: merge test-write-cache into test-tool
Date:   Sat, 17 Mar 2018 08:54:21 +0100
Message-Id: <20180317075421.22032-37-pclouds@gmail.com>
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
 Makefile                    | 2 +-
 t/helper/test-tool.c        | 1 +
 t/helper/test-tool.h        | 1 +
 t/helper/test-write-cache.c | 3 ++-
 t/perf/p0007-write-cache.sh | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2ab76c6838..8ad9a2a1a9 100644
--- a/Makefile
+++ b/Makefile
@@ -686,13 +686,13 @@ TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
+TEST_BUILTINS_OBJS += test-write-cache.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index ebf28859b4..e4c04cd593 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -41,6 +41,7 @@ static struct test_cmd cmds[] = {
 	{ "subprocess", test_subprocess },
 	{ "urlmatch-normalization", test_urlmatch_normalization },
 	{ "wildmatch", test_wildmatch },
+	{ "write-cache", test_write_cache },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b7c8272689..c0c2d1d18c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,5 +35,6 @@ int test_submodule_config(int argc, const char **argv);
 int test_subprocess(int argc, const char **argv);
 int test_urlmatch_normalization(int argc, const char **argv);
 int test_wildmatch(int argc, const char **argv);
+int test_write_cache(int argc, const char **argv);
 
 #endif
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index b7ee039669..69de7f95aa 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -1,9 +1,10 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "lockfile.h"
 
 static struct lock_file index_lock;
 
-int cmd_main(int argc, const char **argv)
+int test_write_cache(int argc, const char **argv)
 {
 	int i, cnt = 1, lockfd;
 	if (argc == 2)
diff --git a/t/perf/p0007-write-cache.sh b/t/perf/p0007-write-cache.sh
index 261fe92fd9..09595264f0 100755
--- a/t/perf/p0007-write-cache.sh
+++ b/t/perf/p0007-write-cache.sh
@@ -23,7 +23,7 @@ test_expect_success "setup repo" '
 
 count=3
 test_perf "write_locked_index $count times ($nr_files files)" "
-	test-write-cache $count
+	test-tool write-cache $count
 "
 
 test_done
-- 
2.16.2.903.gd04caf5039

