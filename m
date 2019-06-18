Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C21A1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfFRX3D (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:29:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34090 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRX3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:29:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so9771725qkt.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwF3tfzYDWjFlaGtHtkNWoMVZECCkGQuNX+SZav6ClE=;
        b=dGAvxey4CPng/IgxifZ3bAChAAMLeNAQi0NOZ3qaJ6C//ZFeF5gjMN2xtqGP4BrCkZ
         j1PAcoLeRsOTepoA6Zqbj4JPKEgdQGAnpQVBI2sLNAPQU/7t1WF7L5nf1XmrRuq/v8qR
         L8yQEhMSMn0+get14dhiVaDCtQ+uTVnHXK5WLOUSJzcoFAaj1YUx3oewF5bKMKkdvzu/
         07MZuaHG6t0wLe9dL06XaAvyVBXBgkyeKrTB4T1fjUDqLmj6b0Fn/bSGokP2XJbcnY8O
         rmdYAM/rV1skBtDvk2+14f/dVOL0qKPGgL+NqD3GhT2FYL3MKThIDIXSoZcsrsICevrA
         iC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwF3tfzYDWjFlaGtHtkNWoMVZECCkGQuNX+SZav6ClE=;
        b=q0sb9xZXjhr/iW9px/SSXVj0kxUJWRY288a9rUrvpvnDtec7qnGuZUi4wdMawyC2ef
         wo835/ux2VE0uQSVlK3xCKJ9qjbnFkOVSVnc1QL+eCMICIsd2ZdHcK4sU/ZeyOv10VuR
         VwCrF/76l9Nw3uD3nHJQjRFPLvjEUjg8gU3l5N4WsU7I7hnssfx1nufqTrqycOkz+G40
         Kad79PgX0uZDF9tj46zH71s5dOrbAgOgLZ+Zic04RlcjBvySGaf2VQlMVNVvalMTssx1
         L2aLF7bhBPfk66ZOPEzWHgm5RqTb+WgJVW0jN09xoNOQn0VtWjZZSD0T9yYDXfL2V79A
         zg7w==
X-Gm-Message-State: APjAAAW5tW7LFYxaNB7CcvV4PC2xw/DmmdSawrnRhhlQHPcZMA19ySzL
        MMCGZvs21oeaq0Wql9aKMOFQlFODG1w=
X-Google-Smtp-Source: APXvYqzzEgDfDThZlgrBSHnE6dlyA27yZPDdjMp+dpA4B1+CbNfEsBCId02HF5iR2VeYOGkCbK28Ag==
X-Received: by 2002:ae9:eb53:: with SMTP id b80mr68407120qkg.172.1560900541965;
        Tue, 18 Jun 2019 16:29:01 -0700 (PDT)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e18sm4828997qkm.49.2019.06.18.16.28.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 16:29:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, Daniel Ferreira <bnmvco@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v7 03/10] dir-iterator: add tests for dir-iterator API
Date:   Tue, 18 Jun 2019 20:27:40 -0300
Message-Id: <60c5fc6ad28a01c767befeb06601eaf6db4ca42a.1560898723.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br>
References: <cover.1560898723.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Create t/helper/test-dir-iterator.c, which prints relevant information
about a directory tree iterated over with dir-iterator.

Create t/t0066-dir-iterator.sh, which tests that dir-iterator does
iterate through a whole directory tree as expected.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
[matheus.bernardino: update to use test-tool and some minor aesthetics]
Helped-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Makefile                     |  1 +
 t/helper/test-dir-iterator.c | 33 ++++++++++++++++++++++
 t/helper/test-tool.c         |  1 +
 t/helper/test-tool.h         |  1 +
 t/t0066-dir-iterator.sh      | 55 ++++++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0066-dir-iterator.sh

diff --git a/Makefile b/Makefile
index f58bf14c7b..7e2a44cccc 100644
--- a/Makefile
+++ b/Makefile
@@ -704,6 +704,7 @@ TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
+TEST_BUILTINS_OBJS += test-dir-iterator.o
 TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-dump-cache-tree.o
 TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
new file mode 100644
index 0000000000..84f50bed8c
--- /dev/null
+++ b/t/helper/test-dir-iterator.c
@@ -0,0 +1,33 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+
+/* Argument is a directory path to iterate over */
+int cmd__dir_iterator(int argc, const char **argv)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct dir_iterator *diter;
+
+	if (argc < 2)
+		die("BUG: test-dir-iterator needs one argument");
+
+	strbuf_add(&path, argv[1], strlen(argv[1]));
+
+	diter = dir_iterator_begin(path.buf);
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode))
+			printf("[d] ");
+		else if (S_ISREG(diter->st.st_mode))
+			printf("[f] ");
+		else
+			printf("[?] ");
+
+		printf("(%s) [%s] %s\n", diter->relative_path, diter->basename,
+		       diter->path.buf);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 087a8c0cc9..7bc9bb231e 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -19,6 +19,7 @@ static struct test_cmd cmds[] = {
 	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
+	{ "dir-iterator", cmd__dir_iterator },
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
 	{ "dump-fsmonitor", cmd__dump_fsmonitor },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7e703f3038..ec0ffbd0cb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -9,6 +9,7 @@ int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
+int cmd__dir_iterator(int argc, const char **argv);
 int cmd__drop_caches(int argc, const char **argv);
 int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_fsmonitor(int argc, const char **argv);
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
new file mode 100755
index 0000000000..6e06dc038d
--- /dev/null
+++ b/t/t0066-dir-iterator.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='Test the dir-iterator functionality'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p dir &&
+	mkdir -p dir/a/b/c/ &&
+	>dir/b &&
+	>dir/c &&
+	mkdir -p dir/d/e/d/ &&
+	>dir/a/b/c/d &&
+	>dir/a/e &&
+	>dir/d/e/d/a &&
+
+	mkdir -p dir2/a/b/c/ &&
+	>dir2/a/b/c/d
+'
+
+test_expect_success 'dir-iterator should iterate through all files' '
+	cat >expected-iteration-sorted-output <<-EOF &&
+	[d] (a) [a] ./dir/a
+	[d] (a/b) [b] ./dir/a/b
+	[d] (a/b/c) [c] ./dir/a/b/c
+	[d] (d) [d] ./dir/d
+	[d] (d/e) [e] ./dir/d/e
+	[d] (d/e/d) [d] ./dir/d/e/d
+	[f] (a/b/c/d) [d] ./dir/a/b/c/d
+	[f] (a/e) [e] ./dir/a/e
+	[f] (b) [b] ./dir/b
+	[f] (c) [c] ./dir/c
+	[f] (d/e/d/a) [a] ./dir/d/e/d/a
+	EOF
+
+	test-tool dir-iterator ./dir >out &&
+	sort <out >./actual-iteration-sorted-output &&
+
+	test_cmp expected-iteration-sorted-output actual-iteration-sorted-output
+'
+
+test_expect_success 'dir-iterator should list files in the correct order' '
+	cat >expected-pre-order-output <<-EOF &&
+	[d] (a) [a] ./dir2/a
+	[d] (a/b) [b] ./dir2/a/b
+	[d] (a/b/c) [c] ./dir2/a/b/c
+	[f] (a/b/c/d) [d] ./dir2/a/b/c/d
+	EOF
+
+	test-tool dir-iterator ./dir2 >actual-pre-order-output &&
+
+	test_cmp expected-pre-order-output actual-pre-order-output
+'
+
+test_done
-- 
2.22.0

