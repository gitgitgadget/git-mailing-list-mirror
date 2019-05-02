Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719D71F453
	for <e@80x24.org>; Thu,  2 May 2019 14:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfEBOsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:48:53 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:46927 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:48:53 -0400
Received: by mail-qk1-f170.google.com with SMTP id a132so1570837qkb.13
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mB5n3JEQy1vhFi3YcxAhOu5gfDalXMjUl148ZnzohqE=;
        b=s7R7tHVMvyoMdbt2DTDQvVJHlfgWTJppz0o2GMEkmi5t474JBQcATOLUWTqja7O5SP
         Tb/N8BtMLMnF3Ofqm6spL5jTyu7sye1iTHPMmFBO/WF1gMfTax2Fufwk7jTdRDNLKYQg
         3uq+JGsYAOjNJ2BzjoPC2nM1PyXeFXs0hEOhptB5csrOb41OgyZs//3Clus3CBnmn8ox
         bVU/dzvLbju7gvENCTRxldjL8CCMFxSgGQCHOkASfPdGR5QFjZ/+P+gVyk2yGCBdApGD
         s6fB9HrzDofvTe20ZxnCLcxpZnp/xf0Sn0HV2SPHqjL6F8gUhjghz78Yy2x+qRbajS/m
         QmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mB5n3JEQy1vhFi3YcxAhOu5gfDalXMjUl148ZnzohqE=;
        b=HtQLBVf6KtqfHgLpBTNzUcSZb0zyWoVJF4XSDoiRyFR2eJhCCF5tXNSF6wwpWxRYoK
         H63pvA64aqdJhl4Y8ZLxkKcecCsngBYjmRuvBqtv1Ccrw8pfAnmufX+S9FVKY2X7AB4c
         gaeh9Qf4A8xy48k4elAvzp9iGx9ILbZ9qjqtmlHgkw7eOU8f/rHAQ7v0YcFP2ZpScK7U
         MSB/cDSMSPvL/UuzfUFXwhlIZVdpWuXoC5pjWmPmpVFElXx3Yb0cV1QEzTEqim7WsxVa
         5buqoom2WgVF+X47ei7Nn3LPHnoWPe8IGuuGOnk0RJh4TlRH4m+V0cDSxnd1zSTqo9Rm
         vovg==
X-Gm-Message-State: APjAAAVhpYq5gVTIHEidtANeyMsTQ9hGANhkV4te3soOtXqcSCGhqAFT
        lgkm8SlkUUzYdjOwEYPxisC32qrdpZI=
X-Google-Smtp-Source: APXvYqx6P+fmk8L1m1DL/mH0mF3hkybbFDph3ho6xFZDBygqFnxNBZh+FOcD7GMyBHqugvu0Pd4iVA==
X-Received: by 2002:a05:620a:143c:: with SMTP id k28mr3051317qkj.278.1556808531569;
        Thu, 02 May 2019 07:48:51 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:48:51 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com, Daniel Ferreira <bnmvco@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH v6 03/10] dir-iterator: add tests for dir-iterator API
Date:   Thu,  2 May 2019 11:48:22 -0300
Message-Id: <20190502144829.4394-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502144829.4394-1-matheus.bernardino@usp.br>
References: <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190502144829.4394-1-matheus.bernardino@usp.br>
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
index 9f1b6e8926..61da7e4f35 100644
--- a/Makefile
+++ b/Makefile
@@ -713,6 +713,7 @@ TEST_BUILTINS_OBJS += test-config.o
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
index 53c06932c4..89b3bfcad8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -13,6 +13,7 @@ static struct test_cmd cmds[] = {
 	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
+	{ "dir-iterator", cmd__dir_iterator },
 	{ "drop-caches", cmd__drop_caches },
 	{ "dump-cache-tree", cmd__dump_cache_tree },
 	{ "dump-fsmonitor", cmd__dump_fsmonitor },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ffab4d19d7..0a831c839c 100644
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
2.20.1

