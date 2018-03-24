Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1031F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCXHqB (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39667 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeCXHpv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id p142-v6so21403668lfd.6
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyamsVwQ13NtlzedyifIVdWaJOqHJ28vevZuOOFCPDU=;
        b=KSbwFuOhi1OYjBUkR4i3K3z1MP6G9MLtET1s+9G56uB4RWZyHGM1i9xVpHw5l9ULqD
         GAbB2F9Dz3j0I3yNDU74kcfWvhI015b2t5X/dUSmaBaUvzb/CkrN42q7PHDOjX2CL3dn
         RyihT0XBlNH2QQPc3XEwlS/TSzKDmxNtP2Z46AtTIiKMF+0gksKJhjH2dDsFkaZL8kCC
         Bb0X7toGiQLjJPNaz6xCbNhIPQbjicVfJaI6TnrF3zBBgSOqcZOklZqpz9Qo4YKNoxyR
         UsURhyzirDDJwlgPwvUWzlT1UzaEJ84WVSkem66YrK5omULwWCMu3FMwYofiMZxGNge2
         ptXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyamsVwQ13NtlzedyifIVdWaJOqHJ28vevZuOOFCPDU=;
        b=nbGJEZsd8J84wWOHrbB7reX5bp17UamGpjGQF936xX4kgFiykW8qoaR93dIAxsPtWf
         LoO89xxZ1+Vft+d3g4r5B9UKL2dNzNZCCURB/rVCGZG7ADZFowjz+0ZjAwbDCrtktWI7
         zv3umXLYkJC24cHaUZP+NntQ5anbAM3llvTT1ankJaeR42sBCMbqYu+IjzsUfr/qszna
         ETKIZZKvOPQEcA9X0dWqxHoawdqJRJNiPKliD+R/8oSGt6sGyuV1VEQYsB7IEjMRwlJL
         A/KdLxymi4hsRYb9CCbCYjGM3d3fGMud3c6Fuj08Y5sOVHBYss1Mwsr9VgQTMtlQ19yd
         ahEg==
X-Gm-Message-State: AElRT7Fh3gb8UUAdlxmzJUX5Xx7mMt1TyrC3pA7hjT36UrSqz/bajcB6
        7haFYb0vV/worhQWiyUEnoA=
X-Google-Smtp-Source: AG47ELt6R6oxEWBB5pzrsixwbIEVzDLYvKbCUWZiNQAuZwDKFN6DoXcVHwt12t1NpSJDPR+z3+64tQ==
X-Received: by 2002:a19:48c7:: with SMTP id v190-v6mr22256663lfa.26.1521877549871;
        Sat, 24 Mar 2018 00:45:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/36] t/helper: merge (unused) test-match-trees into test-tool
Date:   Sat, 24 Mar 2018 08:44:45 +0100
Message-Id: <20180324074505.19100-17-pclouds@gmail.com>
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
 Makefile                    | 2 +-
 t/helper/test-match-trees.c | 3 ++-
 t/helper/test-tool.c        | 1 +
 t/helper/test-tool.h        | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d7342e3a8b..6552a8f4ed 100644
--- a/Makefile
+++ b/Makefile
@@ -665,13 +665,13 @@ TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
+TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 356d8edef1..96857f26ac 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,7 +1,8 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "tree.h"
 
-int cmd_main(int ac, const char **av)
+int cmd__match_trees(int ac, const char **av)
 {
 	struct object_id hash1, hash2, shifted;
 	struct tree *one, *two;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 88fbe8ddbd..3653646f3a 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -20,6 +20,7 @@ static struct test_cmd cmds[] = {
 	{ "hashmap", cmd__hashmap },
 	{ "index-version", cmd__index_version },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
+	{ "match-trees", cmd__match_trees },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b855203477..d2f009cb3e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -14,6 +14,7 @@ int cmd__genrandom(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
+int cmd__match_trees(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
-- 
2.17.0.rc0.348.gd5a49e0b6f

