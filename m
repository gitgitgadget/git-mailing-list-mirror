Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05234C6FA83
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIWSz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiIWSzf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC61106A3E
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x18so1303458wrm.7
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=saeeViDxA8shKM5+tFUSDhs7ZdAizgQQryebkqDrAkQ=;
        b=XYkrBazqeuH2qVm6OQtrZ9FP/V4wBlyc6Hixmm63PJWj5dfcEJI5/LhQfBC/DLAZLT
         9SS0Lp3T9o7Qz3eWkGi5oJ54dt1qEXY225bQPTnHVbfbc1H7wMS3DrfPYb9kXIPZ6qS7
         AbDGhSK9hqjnd7OzKX6m53RphqXxlrT4taR8viCpWL2hW1yu+IBFwW6aZk6ZKiM+GC5L
         QoOF5iTG0MizWPIvwGY3FyO9JFiSJu73wDL9EjVd7KDtaRh6oN8e0UPizEN9qwn8802s
         qnmR61At1KyZ08dFtY0g79rNbU0t6sTdGWc6O6OJmHS6uxsAkRGVZnjsl87/s/Browsc
         BHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=saeeViDxA8shKM5+tFUSDhs7ZdAizgQQryebkqDrAkQ=;
        b=mmIjGNj67r2D3SIWOvVjsAP3WegGIJStnqJrxnc8/zN80L7YzWxvB81QDz0BfwT1Mb
         89pUYwV76ME57FtjfsnM9XDRu02J90kj7TwDcE3CNli4hD0rs18SXAQTUvbekloa5lZO
         cVKupDw7gLjldOx1NsxTLKM11cXCxbCBQrvr3D1Twufmmc1Ztpc5ok+p7fBuZ4jBCnCC
         5b38sMJmI5/SC6A4Ky0c1lxpYydycKo3lhbRCIS90NYDnNv0B8M2gH6bE4P6QZSnGv9c
         x1w3/2GD+Aa33i6jmDFfOOC1vKIw/WsfxfaNGF8lw3gwt5U//OTTP2AyCQYAHFc0xOnn
         NjWg==
X-Gm-Message-State: ACrzQf2qn5jWVzR01vSBuDFbsGrEKJSoub51ZwWqD8pyR7NnwqemwPIE
        CULR1V7hAfTMy38K+ZXpxQzgH/6bmuA=
X-Google-Smtp-Source: AMsMyM4YwwWZcrzPJ/fCQQXS04VLX9NsVXmMieMjgEfvMOcZL+6DfXwt7CZCqeL306EROD42xeQRMg==
X-Received: by 2002:a05:6000:2a6:b0:22a:fb53:316 with SMTP id l6-20020a05600002a600b0022afb530316mr6269519wry.55.1663959330271;
        Fri, 23 Sep 2022 11:55:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a5c7a942edsm3218940wmi.28.2022.09.23.11.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:29 -0700 (PDT)
Message-Id: <2b3a00a6702eb8fb12e45b833ca74155939588ef.1663959325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:19 +0000
Subject: [PATCH 05/10] evolve: add the change-table structure
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

A change table stores a list of changes, and supports efficient lookup
from a commit hash to the list of changes that reference that commit
directly.

It can be used to look up content commits or metacommits at the head
of a change, but does not support lookup of commits referenced as part
of the commit history.

Signed-off-by: Stefan Xenos <sxenos@google.com>
Signed-off-by: Chris Poucet <poucet@google.com>
---
 Makefile       |   1 +
 change-table.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
 change-table.h | 132 ++++++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+)
 create mode 100644 change-table.c
 create mode 100644 change-table.h

diff --git a/Makefile b/Makefile
index b2bcc00c289..2b847e7e7de 100644
--- a/Makefile
+++ b/Makefile
@@ -913,6 +913,7 @@ LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
+LIB_OBJS += change-table.o
 LIB_OBJS += cbtree.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
diff --git a/change-table.c b/change-table.c
new file mode 100644
index 00000000000..c61ba29f1ed
--- /dev/null
+++ b/change-table.c
@@ -0,0 +1,179 @@
+#include "cache.h"
+#include "change-table.h"
+#include "commit.h"
+#include "ref-filter.h"
+#include "metacommit-parser.h"
+
+void change_table_init(struct change_table *to_initialize)
+{
+	memset(to_initialize, 0, sizeof(*to_initialize));
+	mem_pool_init(&to_initialize->memory_pool, 0);
+	to_initialize->memory_pool.block_alloc = 4*1024 - sizeof(struct mp_block);
+	oidmap_init(&to_initialize->oid_to_metadata_index, 0);
+	string_list_init_dup(&to_initialize->refname_to_change_head);
+}
+
+static void change_list_clear(struct change_list *to_clear) {
+	string_list_clear(&to_clear->additional_refnames, 0);
+}
+
+static void commit_change_list_entry_clear(
+	struct commit_change_list_entry *to_clear) {
+	change_list_clear(&to_clear->changes);
+}
+
+void change_table_clear(struct change_table *to_clear)
+{
+	struct oidmap_iter iter;
+	struct commit_change_list_entry *next;
+	for (next = oidmap_iter_first(&to_clear->oid_to_metadata_index, &iter);
+		next;
+		next = oidmap_iter_next(&iter)) {
+
+		commit_change_list_entry_clear(next);
+	}
+
+	oidmap_free(&to_clear->oid_to_metadata_index, 0);
+	string_list_clear(&to_clear->refname_to_change_head, 0);
+	mem_pool_discard(&to_clear->memory_pool, 0);
+}
+
+static void add_head_to_commit(struct change_table *to_modify,
+	const struct object_id *to_add, const char *refname)
+{
+	struct commit_change_list_entry *entry;
+
+	/**
+	 * Note: the indices in the map are 1-based. 0 is used to indicate a missing
+	 * element.
+	 */
+	entry = oidmap_get(&to_modify->oid_to_metadata_index, to_add);
+	if (!entry) {
+		entry = mem_pool_calloc(&to_modify->memory_pool, 1,
+			sizeof(*entry));
+		oidcpy(&entry->entry.oid, to_add);
+		oidmap_put(&to_modify->oid_to_metadata_index, entry);
+		string_list_init_nodup(&entry->changes.additional_refnames);
+	}
+
+	if (!entry->changes.first_refname)
+		entry->changes.first_refname = refname;
+	else
+		string_list_insert(&entry->changes.additional_refnames, refname);
+}
+
+void change_table_add(struct change_table *to_modify, const char *refname,
+	struct commit *to_add)
+{
+	struct change_head *new_head;
+	struct string_list_item *new_item;
+	int metacommit_type;
+
+	new_head = mem_pool_calloc(&to_modify->memory_pool, 1,
+		sizeof(*new_head));
+
+	oidcpy(&new_head->head, &to_add->object.oid);
+
+	metacommit_type = get_metacommit_content(to_add, &new_head->content);
+	if (metacommit_type == METACOMMIT_TYPE_NONE)
+		oidcpy(&new_head->content, &to_add->object.oid);
+	new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);
+	new_head->remote = starts_with(refname, "refs/remote/");
+	new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
+
+	new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
+	new_item->util = new_head;
+	/* Use pointers to the copy of the string we're retaining locally */
+	refname = new_item->string;
+
+	if (!oideq(&new_head->content, &new_head->head))
+		add_head_to_commit(to_modify, &new_head->content, refname);
+	add_head_to_commit(to_modify, &new_head->head, refname);
+}
+
+void change_table_add_all_visible(struct change_table *to_modify,
+	struct repository* repo)
+{
+	struct ref_filter filter;
+	const char *name_patterns[] = {NULL};
+	memset(&filter, 0, sizeof(filter));
+	filter.kind = FILTER_REFS_CHANGES;
+	filter.name_patterns = name_patterns;
+
+	change_table_add_matching_filter(to_modify, repo, &filter);
+}
+
+void change_table_add_matching_filter(struct change_table *to_modify,
+	struct repository* repo, struct ref_filter *filter)
+{
+	struct ref_array matching_refs;
+	int i;
+
+	memset(&matching_refs, 0, sizeof(matching_refs));
+	filter_refs(&matching_refs, filter, filter->kind);
+
+	/**
+	 * Determine the object id for the latest content commit for each change.
+	 * Fetch the commit at the head of each change ref. If it's a normal commit,
+	 * that's the commit we want. If it's a metacommit, locate its content parent
+	 * and use that.
+	 */
+
+	for (i = 0; i < matching_refs.nr; i++) {
+		struct ref_array_item *item = matching_refs.items[i];
+		struct commit *commit = item->commit;
+
+		commit = lookup_commit_reference_gently(repo, &item->objectname, 1);
+
+		if (commit)
+			change_table_add(to_modify, item->refname, commit);
+	}
+
+	ref_array_clear(&matching_refs);
+}
+
+static int return_true_callback(const char *refname, void *cb_data)
+{
+	return 1;
+}
+
+int change_table_has_change_referencing(struct change_table *changes,
+	const struct object_id *referenced_commit_id)
+{
+	return for_each_change_referencing(changes, referenced_commit_id,
+		return_true_callback, NULL);
+}
+
+int for_each_change_referencing(struct change_table *table,
+	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data)
+{
+	const struct change_list *changes;
+	int i;
+	int retvalue;
+	struct commit_change_list_entry *entry;
+
+	entry = oidmap_get(&table->oid_to_metadata_index,
+		referenced_commit_id);
+	/* If this commit isn't referenced by any changes, it won't be in the map */
+	if (!entry)
+		return 0;
+	changes = &entry->changes;
+	if (!changes->first_refname)
+		return 0;
+	retvalue = fn(changes->first_refname, cb_data);
+	for (i = 0; retvalue == 0 && i < changes->additional_refnames.nr; i++)
+		retvalue = fn(changes->additional_refnames.items[i].string, cb_data);
+	return retvalue;
+}
+
+struct change_head* get_change_head(struct change_table *heads,
+	const char* refname)
+{
+	struct string_list_item *item = string_list_lookup(
+		&heads->refname_to_change_head, refname);
+
+	if (!item)
+		return NULL;
+
+	return (struct change_head *)item->util;
+}
diff --git a/change-table.h b/change-table.h
new file mode 100644
index 00000000000..166b5ed8073
--- /dev/null
+++ b/change-table.h
@@ -0,0 +1,132 @@
+#ifndef CHANGE_TABLE_H
+#define CHANGE_TABLE_H
+
+#include "oidmap.h"
+
+struct commit;
+struct ref_filter;
+
+/**
+ * This struct holds a list of change refs. The first element is stored inline,
+ * to optimize for small lists.
+ */
+struct change_list {
+	/**
+	 * Ref name for the first change in the list, or null if none.
+	 *
+	 * This field is private. Use for_each_change_in to read.
+	 */
+	const char* first_refname;
+	/**
+	 * List of additional change refs. Note that this is empty if the list
+	 * contains 0 or 1 elements.
+	 *
+	 * This field is private. Use for_each_change_in to read.
+	 */
+	struct string_list additional_refnames;
+};
+
+/**
+ * Holds information about the head of a single change.
+ */
+struct change_head {
+	/**
+	 * The location pointed to by the head of the change. May be a commit or a
+	 * metacommit.
+	 */
+	struct object_id head;
+	/**
+	 * The content commit for the latest commit in the change. Always points to a
+	 * real commit, never a metacommit.
+	 */
+	struct object_id content;
+	/**
+	 * Abandoned: indicates that the content commit should be removed from the
+	 * history.
+	 *
+	 * Hidden: indicates that the change is an inactive change from the
+	 * hiddenmetas namespace. Such changes will be hidden from the user by
+	 * default.
+	 *
+	 * Deleted: indicates that the change has been removed from the repository.
+	 * That is the ref was deleted since the time this struct was created. Such
+	 * entries should be ignored.
+	 */
+	unsigned int abandoned:1,
+		hidden:1,
+		remote:1,
+		deleted:1;
+};
+
+/**
+ * Holds the list of change refs whose content points to a particular content
+ * commit.
+ */
+struct commit_change_list_entry {
+	struct oidmap_entry entry;
+	struct change_list changes;
+};
+
+/**
+ * Holds information about the heads of each change, and permits effecient
+ * lookup from a commit to the changes that reference it directly.
+ *
+ * All fields should be considered private. Use the change_table functions
+ * to interact with this struct.
+ */
+struct change_table {
+	/**
+	 * Memory pool for the objects allocated by the change table.
+	 */
+	struct mem_pool memory_pool;
+	/* Map object_id to commit_change_list_entry structs. */
+	struct oidmap oid_to_metadata_index;
+	/**
+	 * List of ref names. The util value points to a change_head structure
+	 * allocated from memory_pool.
+	 */
+	struct string_list refname_to_change_head;
+};
+
+extern void change_table_init(struct change_table *to_initialize);
+extern void change_table_clear(struct change_table *to_clear);
+
+/* Adds the given change head to the change_table struct */
+extern void change_table_add(struct change_table *to_modify,
+	const char *refname, struct commit *target);
+
+/**
+ * Adds the non-hidden local changes to the given change_table struct.
+ */
+extern void change_table_add_all_visible(struct change_table *to_modify,
+	struct repository *repo);
+
+/*
+ * Adds all changes matching the given ref filter to the given change_table
+ * struct.
+ */
+extern void change_table_add_matching_filter(struct change_table *to_modify,
+	struct repository* repo, struct ref_filter *filter);
+
+typedef int each_change_fn(const char *refname, void *cb_data);
+
+extern int change_table_has_change_referencing(struct change_table *changes,
+	const struct object_id *referenced_commit_id);
+
+/**
+ * Iterates over all changes that reference the given commit. For metacommits,
+ * this is the list of changes that point directly to that metacommit.
+ * For normal commits, this is the list of changes that have this commit as
+ * their latest content.
+ */
+extern int for_each_change_referencing(struct change_table *heads,
+	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data);
+
+/**
+ * Returns the change head for the given refname. Returns NULL if no such change
+ * exists.
+ */
+extern struct change_head* get_change_head(struct change_table *heads,
+	const char* refname);
+
+#endif
-- 
gitgitgadget

