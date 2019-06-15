Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6581F462
	for <e@80x24.org>; Sat, 15 Jun 2019 10:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfFOKHc (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 06:07:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42954 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOKHb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 06:07:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so4950824wrl.9
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJuEfzZKSEOuEOdJZwyNmKyUvX450cFJ9Dk/GASFAG4=;
        b=ExqbyTmEoH+Gy8NTxRMtyK0v7m1EacX/k4ctukThZAQbtcNOoa+RwXowesn46p/eb0
         gAyTip8y5OPdgROjXgn02PCXyTpWkEVN0rSFON2rShHmSCzj/k4WkFqMrEb+MQZ+wHlN
         3cwyd/keMm08LZYwrutZoyOvwCFCoroLD8Ld2RSDvCbA8TGa2BGjxz6YN91jbliApXuu
         28hdO/ZIOEan7HsW5/ZtZi9pYFz+OwDWlPiHvGLNE0Keabj+SW+0U57RzPci07XQyG9k
         SwcAIMbREVRxg60i9pSB/uhNSK+WHBkNk/883QsKIw9qBhPR7wcs8+hZDzOnPqsPqAU/
         /h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJuEfzZKSEOuEOdJZwyNmKyUvX450cFJ9Dk/GASFAG4=;
        b=nZoQK82uIpiX/yN7+BddTf6fSEsnz1NGDSo7rGavdyQoC5C0ASBPos/4x86p9yBYFM
         4FQ1xSlIxCIXkE2uQrNXZaSvlqI8yNEyHL+Inv9vAAmbTXaDetMbPIRYdOXi3BAMuvVp
         aiInCoKdShM26Rbj0DRdEBE9mreQH9+zhMwoVJW4nD3E/Ud52uySR0MuHfQXkGYYkjXu
         bjIDmKjB6ioYry65tdejoUTgO8HGNHV9iezPsmxtSParZqpyPC8E2TDqAR90h9e+Bu7y
         JLkjNd6b5vaZLw0PxVjTzHSc9wrViY/H7CV+mlv1pXbKLEbZz/gEgu5X3bzneILgFJXg
         Cpxg==
X-Gm-Message-State: APjAAAX7Rn/esVBiNfPGI+Qt7t1jtygyksyEXMOWGhBduqJDEmoimQMp
        2KrG0I8lK6gvmzDltFQl0qB90qB1pq0=
X-Google-Smtp-Source: APXvYqxMRfj0I93mKgk38MzO+CUE2WVKD8Js2bMzplT9ZI4wceMquhSLdnhV//sngYGDu5QoJqO9+Q==
X-Received: by 2002:adf:f544:: with SMTP id j4mr21486773wrp.150.1560593249580;
        Sat, 15 Jun 2019 03:07:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1017:d205:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id x11sm8091576wmg.23.2019.06.15.03.07.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:07:28 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/4] t/helper: add test-oidmap.c
Date:   Sat, 15 Jun 2019 12:06:59 +0200
Message-Id: <20190615100702.20762-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.3.g82edbe9b01.dirty
In-Reply-To: <20190615100702.20762-1-chriscool@tuxfamily.org>
References: <20190615100702.20762-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new helper is very similar to "test-hashmap.c" and will help
test how `struct oidmap` from oidmap.{c,h} can be used.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile               |   1 +
 t/helper/test-oidmap.c | 126 +++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 4 files changed, 129 insertions(+)
 create mode 100644 t/helper/test-oidmap.c

diff --git a/Makefile b/Makefile
index 8a7e235352..5efc7700ed 100644
--- a/Makefile
+++ b/Makefile
@@ -727,6 +727,7 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
+TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-path-utils.o
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
new file mode 100644
index 0000000000..7036588175
--- /dev/null
+++ b/t/helper/test-oidmap.c
@@ -0,0 +1,126 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "oidmap.h"
+#include "strbuf.h"
+
+/* key is an oid and value is a name (could be a refname for example) */
+struct test_entry {
+	struct oidmap_entry entry;
+	char name[FLEX_ARRAY];
+};
+
+#define DELIM " \t\r\n"
+
+/*
+ * Read stdin line by line and print result of commands to stdout:
+ *
+ * hash oidkey -> sha1hash(oidkey)
+ * put oidkey namevalue -> NULL / old namevalue
+ * get oidkey -> NULL / namevalue
+ * remove oidkey -> NULL / old namevalue
+ * iterate -> oidkey1 namevalue1\noidkey2 namevalue2\n...
+ *
+ */
+int cmd__oidmap(int argc, const char **argv)
+{
+	struct strbuf line = STRBUF_INIT;
+	struct oidmap map = OIDMAP_INIT;
+
+	setup_git_directory();
+
+	/* init oidmap */
+	oidmap_init(&map, 0);
+
+	/* process commands from stdin */
+	while (strbuf_getline(&line, stdin) != EOF) {
+		char *cmd, *p1 = NULL, *p2 = NULL;
+		struct test_entry *entry;
+		struct object_id oid;
+
+		/* break line into command and up to two parameters */
+		cmd = strtok(line.buf, DELIM);
+		/* ignore empty lines */
+		if (!cmd || *cmd == '#')
+			continue;
+
+		p1 = strtok(NULL, DELIM);
+		if (p1)
+			p2 = strtok(NULL, DELIM);
+
+		if (!strcmp("add", cmd) && p1 && p2) {
+
+			if (get_oid(p1, &oid)) {
+				printf("Unknown oid: %s\n", p1);
+				continue;
+			}
+
+			/* create entry with oidkey from p1, value = p2 */
+			FLEX_ALLOC_STR(entry, name, p2);
+			oidcpy(&entry->entry.oid, &oid);
+
+			/* add to oidmap */
+			oidmap_put(&map, entry);
+
+		} else if (!strcmp("put", cmd) && p1 && p2) {
+
+			if (get_oid(p1, &oid)) {
+				printf("Unknown oid: %s\n", p1);
+				continue;
+			}
+
+			/* create entry with oid_key = p1, name_value = p2 */
+			FLEX_ALLOC_STR(entry, name, p2);
+			oidcpy(&entry->entry.oid, &oid);
+
+			/* add / replace entry */
+			entry = oidmap_put(&map, entry);
+
+			/* print and free replaced entry, if any */
+			puts(entry ? entry->name : "NULL");
+			free(entry);
+
+		} else if (!strcmp("get", cmd) && p1) {
+
+			if (get_oid(p1, &oid)) {
+				printf("Unknown oid: %s\n", p1);
+				continue;
+			}
+
+			/* lookup entry in oidmap */
+			entry = oidmap_get(&map, &oid);
+
+			/* print result */
+			puts(entry ? entry->name : "NULL");
+
+		} else if (!strcmp("remove", cmd) && p1) {
+
+			if (get_oid(p1, &oid)) {
+				printf("Unknown oid: %s\n", p1);
+				continue;
+			}
+
+			/* remove entry from oidmap */
+			entry = oidmap_remove(&map, &oid);
+
+			/* print result and free entry*/
+			puts(entry ? entry->name : "NULL");
+			free(entry);
+
+		} else if (!strcmp("iterate", cmd)) {
+
+			struct oidmap_iter iter;
+			oidmap_iter_init(&map, &iter);
+			while ((entry = oidmap_iter_next(&iter)))
+				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
+
+		} else {
+
+			printf("Unknown command %s\n", cmd);
+
+		}
+	}
+
+	strbuf_release(&line);
+	oidmap_free(&map, 1);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 087a8c0cc9..1eac25233f 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -35,6 +35,7 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
+	{ "oidmap", cmd__oidmap },
 	{ "online-cpus", cmd__online_cpus },
 	{ "parse-options", cmd__parse_options },
 	{ "path-utils", cmd__path_utils },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7e703f3038..c7a46dc320 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -25,6 +25,7 @@ int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
+int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
-- 
2.22.0.3.g82edbe9b01.dirty

