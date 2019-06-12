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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0D11F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfFMRBy (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:01:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37112 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbfFLXYw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 19:24:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so8168379wmg.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCC//pn3KNrzGN31dr8tmRVR9Rr02A8N6rblEqNJqHU=;
        b=hjoLykvv85U21W0k6iEA/YxZTfN9ZjU3UOr1F/eJPpTMrWanAMIHE1NJBvO0IzBlQX
         XVPwHRduEpJUJS9jxeKmR3b26WqQAse1CM1yscYHFP+sT5gsadGIowar1nJjbc950zFB
         zgG31dPkTK0/DNij09dqVOeFpdru6KL2WGqBpuzkSdkNu5SnUwbxwPMCsNvN3NtVUlpZ
         SpUKjnUd2SkiiYq9bjxPY6tOEXeF/LM2SDB3dr+0ulcNXNVzDMr41x/BsMP6lUpWPVnn
         WPQz6h9jV1CbEQspZlIV6jvMj4SRJX3E9Dt7XkWWxu6C99PCZZS4LpwMyDytX/jOT83d
         sLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCC//pn3KNrzGN31dr8tmRVR9Rr02A8N6rblEqNJqHU=;
        b=mWFGUcVX0ifi843Jxbsan/y4TwNQrKsoxYat6Q+MAMagsaEcSbN1Ei13IPaaCUNsbt
         KDYm2jxJwk16ajUvJXkQctfqTxbqVqi4UjKBSdtctZWrfxFprIijgwoOl2h+cWzxKo8J
         zU5H2iWmRABjANhx1XpNSwg4EVgFu610ntB0STEBm8gPB0K1x84UqQGziHBOMjMMzR3W
         ZYs8M/YgOo09TDpWUg9FHAzZVn6ZGPWcqIDcStEjvDAPdGjH1UcZve/wrmHkV0gntaPw
         69rKm0RaPXKZCHEV9gWwHzA/4Amqyqs3NiCy2LfDdFAGn4WZIylOkAJ+J1ACF3r6apz1
         sODw==
X-Gm-Message-State: APjAAAV1h4cI/Eqx0I4jovZQ6Q+HRv0tp5X/Jq3sb1QGsDnQPKnR2HGQ
        ByI3MGToC/CC7WLwrpoxk9qATkNf
X-Google-Smtp-Source: APXvYqwW6e2ds71tPSfqlePDp9YKRX4Ph2KzET4ftVMgAIDLRT06cHe+qjbeRatxeNjcXMsJbloFQA==
X-Received: by 2002:a1c:99ca:: with SMTP id b193mr1013816wme.31.1560381888768;
        Wed, 12 Jun 2019 16:24:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1018:b2dd:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id o126sm1414803wmo.31.2019.06.12.16.24.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 16:24:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/3] t/helper: add test-oidmap.c
Date:   Thu, 13 Jun 2019 01:24:23 +0200
Message-Id: <20190612232425.12149-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.6.gde8b105b43
In-Reply-To: <20190612232425.12149-1-chriscool@tuxfamily.org>
References: <20190612232425.12149-1-chriscool@tuxfamily.org>
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

