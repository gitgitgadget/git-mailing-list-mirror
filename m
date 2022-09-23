Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33EDC04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiIWSzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiIWSzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A9109502
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s14so1394701wro.0
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=wLeJfwB0x5vNYkphAiWjsjsetnGyL3OOlu/8XEZlk/A=;
        b=AIBI7dBZ1XmjVgVyBNC9wuYudgcZA8jWxYeoWxgWS2zNg0YAIHyAJo28ZUZgQc8WEk
         ZS/EWIKH5uxS44PZDqYezyNXEJ8SDIBqfLVqyXLmPZZVi+vhWtu4EYdK+F798tjm9EHi
         ieoojHoK70jyxnFMqbVvCYpuMuT94KNOGgferB8u5O1WBpJXb9dn5SsOM/cHWw+Wl4dB
         MbRVfgM5/1nRgveZYuIdMd/Pf4X/uy+NFg8ac8NYl6Njt+RurCYjncAlVHgBtbRUPj4X
         UUAC6hXbOolH+sgqC5pZMT1VksCLA4vZRlWo8CYj2kSIuP/XaR3J0ZkWnvae/RYGpqs/
         9OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wLeJfwB0x5vNYkphAiWjsjsetnGyL3OOlu/8XEZlk/A=;
        b=vTb1prb79X2c6Nbe3VTHl7pDcp/FuM6l/F2LGuw2oBHcJwLdLrN49w9zOWaAnVB/D3
         TdTjN1qHHtBCgWsB1sMIm3iwMf8zX4rCSZV8J/WvLEfSwCEltIoc1tfBOry+N5bVecoK
         YXy+OT3e4wkYddlALT4SB1y+cmC2OILm4so7/LNdNzyY3lxjxqPHesR5BHHn6yFJHdgf
         SVTYtVzNKDdtcnEDEZWB3I+0WQmVYfs1P3BWgaifiIjLKd0XCTquhsHKgA5eVlDO1X0d
         x1SfQII0/GesHa8skGnWryaGrgJ6cyZGxf902Y3NCQMNjGMCFTUUW47sbpsLOp5xN1/3
         6GIg==
X-Gm-Message-State: ACrzQf2SdE65DE67CHmMHe7+EN2LD54chAtF54AmTeCeAFBTHAOJW0yG
        fyk+ETqTxtXyBGfHcgBhh0Rgeop054E=
X-Google-Smtp-Source: AMsMyM4/1tFU6ONPZZsbuC1t5oWIy6RKChOAlV0nE36eQE8gWp1mWDDCsyDrJl3mmsEDrbZh+zUM0w==
X-Received: by 2002:a5d:5a0d:0:b0:228:da3f:738 with SMTP id bq13-20020a5d5a0d000000b00228da3f0738mr6171050wrb.526.1663959329436;
        Fri, 23 Sep 2022 11:55:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b00223b8168b15sm7842149wrw.66.2022.09.23.11.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:29 -0700 (PDT)
Message-Id: <2e9a4a9bd819785404e8a5343385f4fb2bc06109.1663959325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:18 +0000
Subject: [PATCH 04/10] evolve: add support for parsing metacommits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

This patch adds the get_metacommit_content method, which can classify
commits as either metacommits or normal commits, determine whether they
are abandoned, and extract the content commit's object id from the
metacommit.

Signed-off-by: Stefan Xenos <sxenos@google.com>
Signed-off-by: Chris Poucet <poucet@google.com>
---
 Makefile            |   1 +
 metacommit-parser.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 metacommit-parser.h |  19 ++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 metacommit-parser.c
 create mode 100644 metacommit-parser.h

diff --git a/Makefile b/Makefile
index cac3452edb9..b2bcc00c289 100644
--- a/Makefile
+++ b/Makefile
@@ -999,6 +999,7 @@ LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
+LIB_OBJS += metacommit-parser.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
diff --git a/metacommit-parser.c b/metacommit-parser.c
new file mode 100644
index 00000000000..70c1428bfc6
--- /dev/null
+++ b/metacommit-parser.c
@@ -0,0 +1,110 @@
+#include "cache.h"
+#include "metacommit-parser.h"
+#include "commit.h"
+
+/*
+ * Search the commit buffer for a line starting with the given key. Unlike
+ * find_commit_header, this also searches the commit message body.
+ */
+static const char *find_key(const char *msg, const char *key, size_t *out_len)
+{
+	int key_len = strlen(key);
+	const char *line = msg;
+
+	while (line) {
+		const char *eol = strchrnul(line, '\n');
+
+		if (eol - line > key_len && !memcmp(line, key, key_len) &&
+		    line[key_len] == ' ') {
+			*out_len = eol - line - key_len - 1;
+			return line + key_len + 1;
+		}
+		line = *eol ? eol + 1 : NULL;
+	}
+	return NULL;
+}
+
+static struct commit *get_commit_by_index(struct commit_list *to_search, int index)
+{
+	while (to_search && index) {
+		to_search = to_search->next;
+		index--;
+	}
+
+	if (!to_search)
+		return NULL;
+
+	return to_search->item;
+}
+
+/*
+ * Writes the index of the content parent to "result". Returns the metacommit
+ * type. See the METACOMMIT_TYPE_* constants.
+ */
+static int index_of_content_commit(const char *buffer, int *result)
+{
+	int index = 0;
+	int ret = METACOMMIT_TYPE_NONE;
+	size_t parent_types_size;
+	const char *parent_types = find_key(buffer, "parent-type",
+		&parent_types_size);
+	const char *end;
+	const char *enum_start = parent_types;
+	int enum_length = 0;
+
+	if (!parent_types)
+		return METACOMMIT_TYPE_NONE;
+
+	end = &parent_types[parent_types_size];
+
+	while (1) {
+		char next = *parent_types;
+		if (next == ' ' || parent_types >= end) {
+			if (enum_length == 1) {
+				char first_char_in_enum = *enum_start;
+				if (first_char_in_enum == 'c') {
+					ret = METACOMMIT_TYPE_NORMAL;
+					break;
+				}
+				if (first_char_in_enum == 'a') {
+					ret = METACOMMIT_TYPE_ABANDONED;
+					break;
+				}
+			}
+			if (parent_types >= end)
+				return METACOMMIT_TYPE_NONE;
+			enum_start = parent_types + 1;
+			enum_length = 0;
+			index++;
+		} else {
+			enum_length++;
+		}
+		parent_types++;
+	}
+
+	*result = index;
+	return ret;
+}
+
+/*
+ * Writes the content parent's object id to "content".
+ * Returns the metacommit type. See the METACOMMIT_TYPE_* constants.
+ */
+int get_metacommit_content(struct commit *commit, struct object_id *content)
+{
+	const char *buffer = get_commit_buffer(commit, NULL);
+	int index = 0;
+	int ret = index_of_content_commit(buffer, &index);
+	struct commit *content_parent;
+
+	if (ret == METACOMMIT_TYPE_NONE)
+		return ret;
+
+	content_parent = get_commit_by_index(commit->parents, index);
+
+	if (!content_parent)
+		return METACOMMIT_TYPE_NONE;
+
+	oidcpy(content, &(content_parent->object.oid));
+	return ret;
+}
diff --git a/metacommit-parser.h b/metacommit-parser.h
new file mode 100644
index 00000000000..1c74bd6d699
--- /dev/null
+++ b/metacommit-parser.h
@@ -0,0 +1,19 @@
+#ifndef METACOMMIT_PARSER_H
+#define METACOMMIT_PARSER_H
+
+#include "commit.h"
+#include "hash.h"
+
+/* Indicates a normal commit (non-metacommit) */
+#define METACOMMIT_TYPE_NONE 0
+/* Indicates a metacommit with normal content (non-abandoned) */
+#define METACOMMIT_TYPE_NORMAL 1
+/* Indicates a metacommit with abandoned content */
+#define METACOMMIT_TYPE_ABANDONED 2
+
+struct commit;
+
+extern int get_metacommit_content(
+	struct commit *commit, struct object_id *content);
+
+#endif
-- 
gitgitgadget

