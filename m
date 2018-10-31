Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6AD1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 12:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeJaVkP (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 17:40:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38574 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeJaVkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 17:40:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2-v6so8901286wmh.3
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKZKXFe1RSxM1FyUeRhla2/3g5A5CApDb41cnsh8wCY=;
        b=kDIlLK/qVyutsy7OKmyOytSaKo3DyxH+5mS2eOjt97yWkIhwDk01ml0xxYDsutgcZD
         YufnAe/5PW24qSQoIzZB26qlhx8sOF2Lw/Dj9cfPRsINlVfBr2PPvbPIwFhSM5QsqiyI
         qI8gTgy6xeuqDTwkPsUUltwWpEh3a8L4BmTMVqRrQwqMZz6xlISlAx3rMn/osH4YyJkf
         dh0uIkVSjy9TJFdhdz2O2gs+9rLheGJRM0S04KhELd9TasTbTDQm5wtBCoe5apB5pfck
         Yfsddpfmude+9t58jxZFYygRuvEWGieqTgdzozI2Jr5Y+HAjJNiVnR6v7aF0LMfqPaXh
         Q7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKZKXFe1RSxM1FyUeRhla2/3g5A5CApDb41cnsh8wCY=;
        b=Z+R1iTMrNZ1MUsnZPQhG2V8SzqW+xrOjpeO+l3Op/DZE6WlQemN/5iQqU2m4sB5B75
         d515eS/GXnVBiXtnd7AhWTqCjLBDI+gOHXM8d1qmzCQpCu0yPd8G0eI32MZ4fLUmIF2v
         MYBNrmZPGkVXXcnqsZuQ/332/vPR7ruwK/ajK6K6T8A44F968ntN+JrYYh0DVJM4ibaU
         bqQKypjiuk6ve9ov5d7zpnkY/7yZNqNd57B6v1/EwLNIfzATJ5XGkntLFskies0whwMU
         sfa7pAKJ7yRS9flSUWmJ6fb/sgefyxZtZBDGq5U5/nRqSsF4dTgoss68DEnU7YMzKMej
         b1qw==
X-Gm-Message-State: AGRZ1gIk2cLK4p/oHoKgFusf6boehrL3ZYOuyJLPrMiLNMmk4JYJmEfx
        KuXTaFQoMJZ6mv+WMz9mKgaUtI+J1+o=
X-Google-Smtp-Source: AJdET5eVJd2hdlcCJ7CTOL/SlG0BGMuz7qUWc1oQUftsAL7gGtavq1wC0UqJhsroqjlwgjzxLwxxiA==
X-Received: by 2002:a1c:1250:: with SMTP id 77-v6mr2260228wms.70.1540989741128;
        Wed, 31 Oct 2018 05:42:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l42-v6sm2336705wre.37.2018.10.31.05.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 05:42:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] tests: add a "env-bool" helper to test-tool
Date:   Wed, 31 Oct 2018 12:42:06 +0000
Message-Id: <20181031124208.29451-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.899.g0250525e69
In-Reply-To: <20181030232337.GC32038@sigill.intra.peff.net>
References: <20181030232337.GC32038@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new helper is a wrapper around the git_env_bool() function. There
are various GIT_TEST_* variables described in "Running tests with
special setups" in t/README that use git_env_bool().

A GIT_TEST_* variable implemented in shellscript won't have access to
the same semantics (historically we've used "test -n" for many of
these).

So let's add this helper so we can expose the same environment
variable behavior without exposing the implementation detail of
whether that variable happens to be checked in C or shellscript.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                 | 1 +
 t/helper/test-env-bool.c | 9 +++++++++
 t/helper/test-tool.c     | 1 +
 t/helper/test-tool.h     | 1 +
 4 files changed, 12 insertions(+)
 create mode 100644 t/helper/test-env-bool.c

diff --git a/Makefile b/Makefile
index b08d5ea258..ca624c381f 100644
--- a/Makefile
+++ b/Makefile
@@ -723,6 +723,7 @@ TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
+TEST_BUILTINS_OBJS += test-env-bool.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-index-version.o
diff --git a/t/helper/test-env-bool.c b/t/helper/test-env-bool.c
new file mode 100644
index 0000000000..956b0aa88e
--- /dev/null
+++ b/t/helper/test-env-bool.c
@@ -0,0 +1,9 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "config.h"
+
+int cmd__env_bool(int argc, const char **argv)
+{
+	assert(argc == 2);
+	return !git_env_bool(argv[1], 0);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 5df8b682aa..c4481085c4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -17,6 +17,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-fsmonitor", cmd__dump_fsmonitor },
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
+	{ "env-bool", cmd__env_bool },
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
 	{ "hashmap", cmd__hashmap },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 71f470b871..f7845fbc56 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -13,6 +13,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
+int cmd__env_bool(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
-- 
2.19.1.899.g0250525e69

