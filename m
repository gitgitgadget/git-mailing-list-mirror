Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5041F461
	for <e@80x24.org>; Wed, 10 Jul 2019 23:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGJX7z (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 19:59:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35792 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGJX7z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 19:59:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so3421028qke.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 16:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80ph6NSFxNkHNnOpYOoHhUQRbAJvYajPVEg8eYowsDg=;
        b=QTHDIVSPPtA2EwE53DPF6I9fAuFR5RsX3YAMY2K99VOrkKfbUl7nCEUGk5iJaQ6Jyi
         Rz46Tmk/LR7xdbZoNp4A3cwtByiJjB6O/XoW0/leeA5ChL2gMg9rg6pSdqa4ubPhRlTT
         OWzy7f1nPNRbLPPG+Pdm3gAiqsPIK72HIPDhmI3fHJ8S2jPz/VnKIQtmAfNlIOuC6x0o
         6ZZW/QdVDODUW6BnvgrdwRDNKEjM99BIAzEADIUqYEIMfRLvVi1hGJQBV0jUe8VL06x1
         w7sOiKGrQ72sTYkieSvo5FHfEfSH/2TE+CA/vT6gA5n3qyLaikyxbVPufzvw1ECnIdVf
         OtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80ph6NSFxNkHNnOpYOoHhUQRbAJvYajPVEg8eYowsDg=;
        b=s9jh1WtN/mAKiAUvffF1mPR8r/BiqO1d4bvmcgtZa7S2G3nDUiGmk1XxGtI2ZFTBE/
         Fe4Y1uC8Gm4e+MVQPRe+i+czqHvJSDr8QuDw8yAmpknJZSrYrcAmpxQTwW0zvbMPMC1s
         YwlQOEpwd/d4NbQQBXgW2XkSWbpsZ1K+bsAPv0MEZXR5dDkstRg/elZ07QjhBTMAMO51
         8QfJKEC2Np3tE1O7fItrGeQsu9YXNi0v4spHtLJz+kdLH7WmmR6/kmGdiajFNoLySYrU
         eVDsdI4/qXHgJY4J5tjfKE02HF20ihIm9NmnD8cw0A/oSiPODP6l7SnpqV7WhevBX/53
         O/Nw==
X-Gm-Message-State: APjAAAUPx5Kn0m68obXAm2ZWoLAeNsrMkD/QGbs4WeSQexhgTX1ilBGH
        uL/YfQ057O31Gj2ydl2HIHzRSA==
X-Google-Smtp-Source: APXvYqx2jvRFS2VLV/nZSuKRdLEJIgMPH9QEG0wraffPjcRWvQGl5e1h4hLQNVvdeyJyg9a5IgamnQ==
X-Received: by 2002:a37:9944:: with SMTP id b65mr740950qke.105.1562803193819;
        Wed, 10 Jul 2019 16:59:53 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.16.59.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 16:59:53 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com, Daniel Ferreira <bnmvco@gmail.com>
Subject: [GSoC][PATCH v8 03/10] dir-iterator: add tests for dir-iterator API
Date:   Wed, 10 Jul 2019 20:58:57 -0300
Message-Id: <bbce6a601b9dfe018fb482298ab9e4e79968cd05.1562801254.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
References: <cover.1562801254.git.matheus.bernardino@usp.br>
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
index 0000000000..59bce868f4
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
+	sort out >./actual-iteration-sorted-output &&
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

