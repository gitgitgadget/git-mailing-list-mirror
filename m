Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69E820964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750848AbdDBEf5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:35:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32984 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdDBEfz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:35:55 -0400
Received: by mail-qk0-f194.google.com with SMTP id p22so15440431qka.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 21:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6LQKeOHhCKYZLYxsqE83tpU/xcqWcfSiXSyr/HOGr0I=;
        b=E9484a0QzC++iGEDLtIGWSbwT3VZ4Khx01NFwwebvBEuBJfgo+6iIssgI/5EBwkiGL
         MfNBOZaKkvJEOR3heuxlr1YxjwUKqfAMKG5KenDQIL6i0bKm61WjSdvaX2ImAnHuWtzj
         PRnbUwDjZ2rB7CxyyDmcaCD4Zes3pBIGIdGMtI3kLq8gvGlevQ3BB+ZKzfZuFO5mZh8r
         ecwCisZeYd8BLMKzQoAPB0eXgOQvYUMAswY2CMLwJ+jgTrQwn36431oqYau6RQ2Bv/Rz
         SQiddyQhiKD6LvhDtuf2z1jKS2tATtH++53UWMna4Sz9mtB2KBZnCyF22d6h/GXikdbi
         zXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6LQKeOHhCKYZLYxsqE83tpU/xcqWcfSiXSyr/HOGr0I=;
        b=NDvGhMktY8UDOeSZ+YCoOf/0wPskfwkGLJRUfIK2tLJpJOaRIZe+CjRbrlcsqnDtaB
         986bxC0ozzcNsjiejFOW2A4jlF+i9L5TGE4Yt/6IVSZNM4HKUJBn8gTPHnBni3lagRRz
         E+QvWKcO/bHyLhtll/R6YoM9pJnod5dbvvCcuRo8bZZoeT/d0nq9zn0mNqzfUDdC+DKR
         UuLzRtVJvASnuj4MEMak3nSOlKe5t1bhIjEvjYvbxFlx94CTY29aYpVW7bAdunYYV8X2
         UYpTopULGAycmxKQclDaOTJjYyF24lQKcQHkCI5oL+T2TLvBsuUKW+qkQKxQGk9f9Jkq
         93YQ==
X-Gm-Message-State: AFeK/H0gvsQk3U+CX1X0O402KUWR2xyaGVF33XjIrCMfPZ0pvEWK6QAbBRzP3Tc+MAC3sw==
X-Received: by 10.55.217.82 with SMTP id u79mr8436790qki.321.1491107749662;
        Sat, 01 Apr 2017 21:35:49 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id t23sm6907383qka.37.2017.04.01.21.35.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Apr 2017 21:35:48 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, peff@peff.net,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v6 1/5] dir_iterator: add tests for dir_iterator API
Date:   Sun,  2 Apr 2017 01:35:22 -0300
Message-Id: <1491107726-21504-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
References: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create t/helper/test-dir-iterator.c, which prints relevant information
about a directory tree iterated over with dir_iterator.

Create t/t0065-dir-iterator.sh, which tests that dir_iterator does
iterate through a whole directory tree.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 Makefile                     |  1 +
 t/helper/.gitignore          |  1 +
 t/helper/test-dir-iterator.c | 28 +++++++++++++++++++++++
 t/t0065-dir-iterator.sh      | 54 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

diff --git a/Makefile b/Makefile
index a5a11e7..d0245f3 100644
--- a/Makefile
+++ b/Makefile
@@ -607,6 +607,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
+TEST_PROGRAMS_NEED_X += test-dir-iterator
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d6e8b36..9c9656d 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -3,6 +3,7 @@
 /test-config
 /test-date
 /test-delta
+/test-dir-iterator
 /test-dump-cache-tree
 /test-dump-split-index
 /test-dump-untracked-cache
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
new file mode 100644
index 0000000..06f03fc
--- /dev/null
+++ b/t/helper/test-dir-iterator.c
@@ -0,0 +1,28 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+
+int cmd_main(int argc, const char **argv) {
+	struct strbuf path = STRBUF_INIT;
+	struct dir_iterator *diter;
+
+	if (argc < 2) {
+		return 1;
+	}
+
+	strbuf_add(&path, argv[1], strlen(argv[1]));
+
+	diter = dir_iterator_begin(path.buf);
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode))
+			printf("[d] ");
+		else
+			printf("[f] ");
+
+		printf("(%s) %s\n", diter->relative_path, diter->path.buf);
+	}
+
+	return 0;
+}
diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
new file mode 100755
index 0000000..b857c07
--- /dev/null
+++ b/t/t0065-dir-iterator.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='Test directory iteration.'
+
+. ./test-lib.sh
+
+cat >expect-sorted-output <<-\EOF &&
+[d] (a) ./dir/a
+[d] (a/b) ./dir/a/b
+[d] (a/b/c) ./dir/a/b/c
+[d] (d) ./dir/d
+[d] (d/e) ./dir/d/e
+[d] (d/e/d) ./dir/d/e/d
+[f] (a/b/c/d) ./dir/a/b/c/d
+[f] (a/e) ./dir/a/e
+[f] (b) ./dir/b
+[f] (c) ./dir/c
+[f] (d/e/d/a) ./dir/d/e/d/a
+EOF
+
+test_expect_success 'dir-iterator should iterate through all files' '
+	mkdir -p dir &&
+	mkdir -p dir/a/b/c/ &&
+	>dir/b &&
+	>dir/c &&
+	mkdir -p dir/d/e/d/ &&
+	>dir/a/b/c/d &&
+	>dir/a/e &&
+	>dir/d/e/d/a &&
+
+	test-dir-iterator ./dir | sort >./actual-pre-order-sorted-output &&
+	rm -rf dir &&
+
+	test_cmp expect-sorted-output actual-pre-order-sorted-output
+'
+
+cat >expect-pre-order-output <<-\EOF &&
+[d] (a) ./dir/a
+[d] (a/b) ./dir/a/b
+[d] (a/b/c) ./dir/a/b/c
+[f] (a/b/c/d) ./dir/a/b/c/d
+EOF
+
+test_expect_success 'dir-iterator should list files in the correct order' '
+	mkdir -p dir/a/b/c/ &&
+	>dir/a/b/c/d &&
+
+	test-dir-iterator ./dir >actual-pre-order-output &&
+	rm -rf dir &&
+
+	test_cmp expect-pre-order-output actual-pre-order-output
+'
+
+test_done
--
2.7.4 (Apple Git-66)

