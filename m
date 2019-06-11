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
	by dcvr.yhbt.net (Postfix) with ESMTP id D43E11F462
	for <e@80x24.org>; Tue, 11 Jun 2019 08:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391301AbfFKIX4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 04:23:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39569 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbfFKIXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 04:23:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so1826464wma.4
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCC//pn3KNrzGN31dr8tmRVR9Rr02A8N6rblEqNJqHU=;
        b=SHDKFfZ50vC1ddQFcVOFhkulvDrB89sQDajrMePZbSjwdh1RclyQwI06YzvFkp/6K2
         wFc0MocqlAUaAVPq+Et0nn0N6NK/ema3C5wb/fgkBy/KvIpNFlSI+wcZjLvB0f+iPT7y
         z0jFs3W6YaO5u77dj3JKFWr8HAQziBpLzgqt9VZZIwBW0gKv0vqx/cFobFkhtCsdIzlq
         pqvxUK7YwTPaTdjdwz+un+rqvQDReSEbkOPcy3YquzDQyQEDFX/Kf3X2nqI8NojaltiB
         qH92aTzAZy816Aa/dZHS1A0E5sZxvw4mePY8nEjhYw+h2GjtdrBd2DC9ClLDqUFW5qSH
         aq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCC//pn3KNrzGN31dr8tmRVR9Rr02A8N6rblEqNJqHU=;
        b=Q07B3KtZb/Ww2wcXyqJF7gCG5jjP0kwiL7KvojPyJ5yugJWLDukX/uQxl50ng23Iia
         9BAcIF2u8LVNU5sY4ytrlOs6XP/sFQhczLoPERLGpw+u+Lv8sacO9zECRf+uywMXdE8W
         UMjtSUc0iAlaBJ9mpYIp87ujktTO00xpYFFSoagxFBkRdnbwwtg50XKIRMzW/H8l2O9O
         WZaJKCVjD3+2FtrdtC0woCfR4r/Pe9GCRjIsA9gnDZZeLRxOpmGe6fNtD+er92v3cEAu
         lYv1VG68WuquHunGQrEGAIMxjbtPYbwg6T0gEqSVlq1LkvAGWU9lO5W7Hieg7a3H2lvV
         YMYQ==
X-Gm-Message-State: APjAAAXWScqqB3SzAML3GG0Q4adJf6iDBFD4YPrxkDtq0ZaY6HbmH9jS
        kxcvBLPm4IqfYwGFtFyR10xX+gbA
X-Google-Smtp-Source: APXvYqwIIIEi9Q+1KOY5CJZf9UVcD2Du5kgxPp5TZjYwZXjWsHsC1TiHh7X8zp5N9ebfV5mjTKXCNg==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr11090844wmc.95.1560241432422;
        Tue, 11 Jun 2019 01:23:52 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10dc:b342:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id o126sm2837350wmo.31.2019.06.11.01.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 01:23:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] t/helper: add test-oidmap.c
Date:   Tue, 11 Jun 2019 10:23:23 +0200
Message-Id: <20190611082325.28878-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.6.gde8b105b43
In-Reply-To: <20190611082325.28878-1-chriscool@tuxfamily.org>
References: <20190611082325.28878-1-chriscool@tuxfamily.org>
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
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile               |   1 +
 t/helper/test-oidmap.c | 134 +++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 4 files changed, 137 insertions(+)
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
index 0000000000..60e92096a1
--- /dev/null
+++ b/t/helper/test-oidmap.c
@@ -0,0 +1,134 @@
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
+		if (!strcmp("hash", cmd) && p1) {
+
+			/* print hash of oid */
+			if (!get_oid(p1, &oid))
+				printf("%x\n", ntohl(sha1hash(oid.hash)));
+			else
+				printf("Unknown oid: %s\n", p1);
+
+		} else if (!strcmp("add", cmd) && p1 && p2) {
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
2.22.0.6.gde8b105b43

