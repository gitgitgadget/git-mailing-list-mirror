Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0911F609
	for <e@80x24.org>; Sun,  9 Jun 2019 04:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFIEtc (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 00:49:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55341 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfFIEtc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 00:49:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so5514048wmj.5
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 21:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oq7MYXaWMxG0fDN/89eHW6L1CBiq5MTFLH5MXXeWvM0=;
        b=iRilU9LuhLzJzrsOkw6T/gATaGUyZuZdZrkEi9Pfk7fWwe+jXse4SmqFwMxPhHRFMZ
         xoOJ4nfVqVZaue2vJcwPgWl+WHHp9muXbr+/WBaKMEV75ZgdM8iogMpxrRcVNTnxlr3A
         6PsLg2TUlMM7bfe7oaTv8PoP4U9p4HbcBzUW96eG/qq2kMrxumZMx+QUX/8kFIHyPK0m
         acly47xtGqWIA083t7Rm41Nw4CM8EvqXsvrHbCjSKYstzmttW0wadV10XzqZHMkJEwgD
         PvaqMWz64fdcUjdtM84dlswkRe1ciJOyXzH+9o9BwNjTGaiVnWwrJ5Xt4AqHC8p24SWU
         ojLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oq7MYXaWMxG0fDN/89eHW6L1CBiq5MTFLH5MXXeWvM0=;
        b=bSSj/tAgjFvk41OSXB1GWkoKvYtjL/9GvtJvjfWAf0CvCqrBzcKzSIDQkaxK47rvlA
         fP5B+WlYelGU3oRMFGMgVpKr/oufcWo731bXc+XILo/mfquRVf+DqSpJE6ZSxiveL4nH
         is1oLqGPxSW+sE5ODrTWzrJaf5LeLBVjCGXqi9l2SSiH29nVpbcvBp/1935Lf+SmBTrJ
         Ln/aElesZsz3MHE96ZuoWtEOdMkH5YbbpvjlHgOt9W5diMPUG/zodA0LNqw3RgZzDnd4
         gO1bXCFWSQSVTDxljhHo7NCooyojjBZQ9NZm16P/lIW9SenjPVKHJ5SgzuXUz37tHkoD
         A7xA==
X-Gm-Message-State: APjAAAX6CURiET8k8BGCknC8N1GETMlftBk1njtH9dtDpulK36E2kcBd
        SdiwAuL9uAfOUaIin2+zsUYFhWp4WtU=
X-Google-Smtp-Source: APXvYqxInkPsQhcwkx9RcG5wR+ykMs2StdEWEr1hSh8lBqEJSD8Aii0MomZHDyiYlhkZetLerViI1Q==
X-Received: by 2002:a05:600c:389:: with SMTP id w9mr8454349wmd.139.1560055769454;
        Sat, 08 Jun 2019 21:49:29 -0700 (PDT)
Received: from localhost.localdomain (160.10.112.78.rev.sfr.net. [78.112.10.160])
        by smtp.gmail.com with ESMTPSA id y2sm6461116wra.58.2019.06.08.21.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 21:49:29 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] t/helper: add test-oidmap.c
Date:   Sun,  9 Jun 2019 06:49:05 +0200
Message-Id: <20190609044907.32477-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.14.g9023ccb50a
In-Reply-To: <20190609044907.32477-1-chriscool@tuxfamily.org>
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new helper is very similar to "test-hashmap.c" and will help
test how `struct oidmap` from oidmap.{c,h} can be used.

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
index 0000000000..0ba122a264
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
+				printf("%u\n", sha1hash(oid.hash));
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
2.22.0.14.g9023ccb50a

