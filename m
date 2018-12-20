Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B131F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeLTMJZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:09:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37255 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTMJY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:09:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so842717pfb.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 04:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gJ9EZ6s2ppCMotQCwIgSQOgE/iuUG1zHvEyrNQD0AEU=;
        b=jcxg22o7L8zPRuleHs41VU7Xz7Nkzgf1j0bb+nV3/d0u4VZoGPJFL/h18X0Kfl/rB/
         R9l3qUCDdqCVMoHejcSMfMAlc5VSCTmHRSyS7FCrdP1C0gsv4uE1eQCQkwbqjpruumc1
         LQs8+k0+SA0Evn2wmvwc3YwpRD1VB/UPJYwNQ1+ZbeXn1VEW4l6WMeGSLpsFrpCZlqHt
         tPkNXpUum3aGitXFkyilub10iZXUHXtIR7MurvJ2g/LIzwYtQBGCH7FSDCsx4DxeRYEV
         5NJYR9MqSt5H/DmwZWtur5eC6NJWHMeFPHiTUfLOsWxkdYtShqXm58HlGnz9mGzWaDJY
         wAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gJ9EZ6s2ppCMotQCwIgSQOgE/iuUG1zHvEyrNQD0AEU=;
        b=OC5xPjZml1me6I2/b8T1/z2tSd2/IexGhAzcMcgu/sDa/R0ajT/8aUHFV0U3+h9Kll
         UF4KFXPBedTHlWl6h2a4nTb5tpQeBvW03Rok9ohgYOZv720YOGus6V225Q3lXT0uT+zz
         9Wvq825O1OVqAM94mSTb3ddQXJ33/YDWn8ibvjk4xHAQNhwODuHrN6alAEJ+kAjRdmCj
         T4kbWUq1waYpyZGxdisdEhvWfC/aIdZLXj8BKcsl8yHEb+0H/tYCLrT/aKe88OvChePz
         A2+9mRDOEs60AgsUEdOBa10seYQIl4cc9MbCPyAHzpmptw7HhUCEtVwQ1RRR/RJ9gACC
         s8uA==
X-Gm-Message-State: AA+aEWYHwSLVhXJQ++fz+9OVTXaqGVgVhB8hIo/e4qXN+ATekOFOp/pf
        +fAl2DncPXixnpVRgUxeqEWVwWWM
X-Google-Smtp-Source: AFSGD/UXLDyD5m4Xh0/KC3Cpns3zRFGoadcM479z4QlpvVNScHaNVlcr0AVhiLSgqaMwEuCZ3Tcnkg==
X-Received: by 2002:a62:b2c3:: with SMTP id z64mr23814784pfl.120.1545307762906;
        Thu, 20 Dec 2018 04:09:22 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id e123sm24413782pgc.58.2018.12.20.04.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:09:22 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:09:22 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:09:10 GMT
Message-Id: <d247ef69fe2c9d017b8d363de554a52269c0d281.1545307756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/7] add-interactive.c: implement status command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Add new files: add-interactive.c and add-interactive.h, which
will be used for implementing "application logic" of git add -i,
whereas add--helper.c will be used mostly for parsing the command line.
We're a bit lax with the command-line parsing, as the command is
intended to be called only by one internal user: the add--interactive script.

Implement add --interactive's status command in add-interactive.c and
use it in builtin add--helper.c.

It prints a numstat comparing changed files between a) the worktree and
the index; b) the index and the HEAD.

To do so, we use run_diff_index() and run_diff_files() to get changed
files, use the diffstat API on them to get the numstat and use a
combination of a hashmap and qsort() to print the result in
O(n) + O(n lg n) complexity.

This is the first interactive add command implemented in C of those
anticipated by the previous commit, which introduced
the add--helper built-in.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 Makefile              |   1 +
 add-interactive.c     | 246 ++++++++++++++++++++++++++++++++++++++++++
 add-interactive.h     |   8 ++
 builtin/add--helper.c |  32 ++++++
 4 files changed, 287 insertions(+)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h

diff --git a/Makefile b/Makefile
index 9c84b80739..2a4a5cc37b 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ LIB_H = $(shell $(FIND) . \
 	-name '*.h' -print)
 
 LIB_OBJS += abspath.o
+LIB_OBJS += add-interactive.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
diff --git a/add-interactive.c b/add-interactive.c
new file mode 100644
index 0000000000..c55d934186
--- /dev/null
+++ b/add-interactive.c
@@ -0,0 +1,246 @@
+#include "add-interactive.h"
+#include "cache.h"
+#include "commit.h"
+#include "color.h"
+#include "config.h"
+#include "diffcore.h"
+#include "revision.h"
+
+#define HEADER_INDENT "      "
+
+enum collection_phase {
+	WORKTREE,
+	INDEX
+};
+
+struct file_stat {
+	struct hashmap_entry ent;
+	struct {
+		uintmax_t added, deleted;
+	} index, worktree;
+	char name[FLEX_ARRAY];
+};
+
+struct collection_status {
+	enum collection_phase phase;
+
+	const char *reference;
+	struct pathspec pathspec;
+
+	struct hashmap file_map;
+};
+
+static int use_color = -1;
+enum color_add_i {
+	COLOR_PROMPT,
+	COLOR_HEADER,
+	COLOR_HELP,
+	COLOR_ERROR
+};
+
+static char colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_BOLD_BLUE, /* Prompt */
+	GIT_COLOR_BOLD,      /* Header */
+	GIT_COLOR_BOLD_RED,  /* Help */
+	GIT_COLOR_BOLD_RED   /* Error */
+};
+
+static const char *get_color(enum color_add_i ix)
+{
+	if (want_color(use_color))
+		return colors[ix];
+	return "";
+}
+
+static int parse_color_slot(const char *slot)
+{
+	if (!strcasecmp(slot, "prompt"))
+		return COLOR_PROMPT;
+	if (!strcasecmp(slot, "header"))
+		return COLOR_HEADER;
+	if (!strcasecmp(slot, "help"))
+		return COLOR_HELP;
+	if (!strcasecmp(slot, "error"))
+		return COLOR_ERROR;
+
+	return -1;
+}
+
+int add_i_config(const char *var,
+		const char *value, void *cbdata)
+{
+	const char *name;
+
+	if (!strcmp(var, "color.interactive")) {
+		use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+
+	if (skip_prefix(var, "color.interactive.", &name)) {
+		int slot = parse_color_slot(name);
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		return color_parse(value, colors[slot]);
+	}
+
+	return git_default_config(var, value, cbdata);
+}
+
+static int hash_cmp(const void *unused_cmp_data, const void *entry,
+			const void *entry_or_key, const void *keydata)
+{
+	const struct file_stat *e1 = entry, *e2 = entry_or_key;
+	const char *name = keydata ? keydata : e2->name;
+
+	return strcmp(e1->name, name);
+}
+
+static int alphabetical_cmp(const void *a, const void *b)
+{
+	struct file_stat *f1 = *((struct file_stat **)a);
+	struct file_stat *f2 = *((struct file_stat **)b);
+
+	return strcmp(f1->name, f2->name);
+}
+
+static void collect_changes_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	struct collection_status *s = data;
+	struct diffstat_t stat = { 0 };
+	int i;
+
+	if (!q->nr)
+		return;
+
+	compute_diffstat(options, &stat);
+
+	for (i = 0; i < stat.nr; i++) {
+		struct file_stat *entry;
+		const char *name = stat.files[i]->name;
+		unsigned int hash = strhash(name);
+
+		entry = hashmap_get_from_hash(&s->file_map, hash, name);
+		if (!entry) {
+			FLEX_ALLOC_STR(entry, name, name);
+			hashmap_entry_init(entry, hash);
+			hashmap_add(&s->file_map, entry);
+		}
+
+		if (s->phase == WORKTREE) {
+			entry->worktree.added = stat.files[i]->added;
+			entry->worktree.deleted = stat.files[i]->deleted;
+		} else if (s->phase == INDEX) {
+			entry->index.added = stat.files[i]->added;
+			entry->index.deleted = stat.files[i]->deleted;
+		}
+	}
+}
+
+static void collect_changes_worktree(struct collection_status *s)
+{
+	struct rev_info rev;
+
+	s->phase = WORKTREE;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+
+	rev.max_count = 0;
+
+	rev.diffopt.flags.ignore_dirty_submodules = 1;
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_changes_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_files(&rev, 0);
+}
+
+static void collect_changes_index(struct collection_status *s)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt = { 0 };
+
+	s->phase = INDEX;
+
+	init_revisions(&rev, NULL);
+	opt.def = s->reference;
+	setup_revisions(0, NULL, &rev, &opt);
+
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_changes_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_index(&rev, 1);
+}
+
+void add_i_print_modified(void)
+{
+	int i = 0;
+	struct collection_status s;
+	/* TRANSLATORS: you can adjust this to align "git add -i" status menu */
+	const char *modified_fmt = _("%12s %12s %s");
+	const char *header_color = get_color(COLOR_HEADER);
+	struct object_id sha1;
+
+	struct hashmap_iter iter;
+	struct file_stat **files;
+	struct file_stat *entry;
+
+	if (read_cache() < 0)
+		return;
+
+	s.reference = !get_oid("HEAD", &sha1) ? "HEAD": empty_tree_oid_hex();
+	hashmap_init(&s.file_map, hash_cmp, NULL, 0);
+
+	collect_changes_worktree(&s);
+	collect_changes_index(&s);
+
+	if (hashmap_get_size(&s.file_map) < 1) {
+		printf("\n");
+		return;
+	}
+
+	printf(HEADER_INDENT);
+	color_fprintf(stdout, header_color, modified_fmt, _("staged"),
+			_("unstaged"), _("path"));
+	printf("\n");
+
+	hashmap_iter_init(&s.file_map, &iter);
+
+	files = xcalloc(hashmap_get_size(&s.file_map), sizeof(struct file_stat *));
+	while ((entry = hashmap_iter_next(&iter))) {
+		files[i++] = entry;
+	}
+	QSORT(files, hashmap_get_size(&s.file_map), alphabetical_cmp);
+
+	for (i = 0; i < hashmap_get_size(&s.file_map); i++) {
+		struct file_stat *f = files[i];
+
+		char worktree_changes[50];
+		char index_changes[50];
+
+		if (f->worktree.added || f->worktree.deleted)
+			snprintf(worktree_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX, f->worktree.added,
+					f->worktree.deleted);
+		else
+			snprintf(worktree_changes, 50, "%s", _("nothing"));
+
+		if (f->index.added || f->index.deleted)
+			snprintf(index_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX, f->index.added,
+					f->index.deleted);
+		else
+			snprintf(index_changes, 50, "%s", _("unchanged"));
+
+		printf(" %2d: ", i + 1);
+		printf(modified_fmt, index_changes, worktree_changes, f->name);
+		printf("\n");
+	}
+	printf("\n");
+
+	free(files);
+	hashmap_free(&s.file_map, 1);
+}
diff --git a/add-interactive.h b/add-interactive.h
new file mode 100644
index 0000000000..1f4747553c
--- /dev/null
+++ b/add-interactive.h
@@ -0,0 +1,8 @@
+#ifndef ADD_INTERACTIVE_H
+#define ADD_INTERACTIVE_H
+
+int add_i_config(const char *var, const char *value, void *cbdata);
+
+void add_i_print_modified(void);
+
+#endif
\ No newline at end of file
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
index 6a97f0e191..43545d9af5 100644
--- a/builtin/add--helper.c
+++ b/builtin/add--helper.c
@@ -1,6 +1,38 @@
+#include "add-interactive.h"
 #include "builtin.h"
+#include "config.h"
+#include "revision.h"
+
+static const char * const builtin_add_helper_usage[] = {
+	N_("git add-interactive--helper <command>"),
+	NULL
+};
+
+enum cmd_mode {
+	DEFAULT = 0,
+	STATUS
+};
 
 int cmd_add__helper(int argc, const char **argv, const char *prefix)
 {
+	enum cmd_mode mode = DEFAULT;
+
+	struct option options[] = {
+		OPT_CMDMODE(0, "status", &mode,
+			 N_("print status information with diffstat"), STATUS),
+		OPT_END()
+	};
+
+	git_config(add_i_config, NULL);
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_add_helper_usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	if (mode == STATUS)
+		add_i_print_modified();
+	else
+		usage_with_options(builtin_add_helper_usage,
+				   options);
+
 	return 0;
 }
-- 
gitgitgadget

