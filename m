Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB72D9EE0
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562744; cv=none; b=YlbHY04NWebsUX5Kn0niTWscLqwgfSM0yZ28Ya8J06d2dO3i4JIKUSanpAtuj7mM7gKCO7PeSFM8uv8pLbLsYJVQOB3nzMShIqKO063XuugMKvZEe8WNY29KjJILe8WPvPVZV/wXhFucfu6EMaNJ6joYZbZVUT+Qz1Gcgl3h7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562744; c=relaxed/simple;
	bh=jFVt+u6/qfPuRQol+/loKuuzin9YQRHuVnk/sP8i80U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1V/jIl98nmBTuhL2lWh3lhOOe+6skt1BIenQF7Jz1TWkKrsqcBCFE8eBJVm0oUxSbPVXuhClLjwpSvowFVVhNn3P8m8tzsFaMPmOE64CfghRWGuSDMjaPP4OZsfwi0HFrmI0JHESwfui/uppqqQUOhykgcrk95fFNkPl05TH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpNvJlMf; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpNvJlMf"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-64fdca63b41so3380412eaf.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760562742; x=1761167542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfnPAxJObCR8kr9KnmQG/lklmjOnswsgQGhZ8Wk+UCw=;
        b=cpNvJlMfvpi5KXhRIo3pWnLVSSNQO+lM+USfHa/45yUD82nzcJzgyuB8lbXLgaujg+
         cdvQMg6oJMKc1JEP6/wvgAF+cr5N0OQTho/r04FzH8218GyMgtO+BJL0nHf3CpjGY8aB
         o36F2VicD4fdaN7NehvB5JOgUyOEdtkWNWFOkZEcBtZQ0jpsTM6ZjI/okNBR7iLazG4C
         kRQYfi0Q+rKkgb5f6lydk0EmrDRV10+Ql9/s6RvUBKgJrMzlrv5dy3YW8Q5RgJEhZ18b
         DtJdhyuTGuZpoLnPUVMg08d7ppdw2L9QGkPIYgVHj942cZeZcCCava7nI3JrdG44i+PH
         ALvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562742; x=1761167542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfnPAxJObCR8kr9KnmQG/lklmjOnswsgQGhZ8Wk+UCw=;
        b=HNJtxRY/XF/AubS1lbZUUK4we4nLhYi3cjs94iG9y7eoQXP3GNi7lIQt/ojN449FnB
         8tvvj/CZfrWhOBQLbQkHl6ntf3bwWd7Uko7Fh5y5vi9aszHF6xGOzT+3nOFSRHQ974fm
         4KjsNvXLpuYHHXGIDqnuoj6fC5TQM72+Dg+BrVx30W6KupuVgHfJIGop1htYcpahQHrw
         Eva7NftFHPvcgfpISqE7ozR3HPX9no6Waa8pXH9bLHBMPUY1mrQfG+OumbasLDDpCCMc
         QPZKGvwtBS3BXJL/6Q83uK91puQbZQBSgLB9o2e7jyVSZ2BsxZQdsbq2+euHF5vXq039
         +9XA==
X-Gm-Message-State: AOJu0YxfKY/yZeIwEBIWNzclXuNqjztn9c9DzG6gEnUU4N1idWoqf/J8
	PO1lqIlnqV4yv0G28nKyDFyGNptrou7DXKRuDBSQgv0B1MvJRwyCf4Hs0eJI6g==
X-Gm-Gg: ASbGnctxWzZgEevSsVVul2PpQ8yGXPVa7zP1zpLNZLOK6bJJQK6MibZ913KIbuGp6B5
	HaljK73SewYZ9QYz/OJOpLO/e8yBY7AiX2vcfPW5tJtAAuDDkD9rB3su/Ick8CTjCb3Uz/918P/
	8RyoB753V2vDn1lcl53R/5FYsp4TJqaCu3tHUOCqwl2kVzkPZ8z3qM37bKCKWOND7NWLOm04OQn
	EZg8kx4jz0C0mVOOlnK/tNwAJDb1idWOnjQPH9mne7mIyFl/Wc0yvSL8uj9KLu3AcNaWRAaRLBN
	RghuQLOqfHF7UiRe2HCgvg9g8IdImMYHUyXDtgrJc+ALKaQ3lMAVUzwiQ9Xzwwxg3sGzq5AufXm
	bZnT3lP6sH9a1OZ43dy6TiQjRFBFiV/vnsWMBhzb8jMTDTrKHeMPo4rmDETKPWRuAukJ5+Ggc37
	yFU1WsR7nZIOYA9AJO+vw=
X-Google-Smtp-Source: AGHT+IG6ghH3gHC2aKpXZgxk5dzIjxgP6ipGd2VQVJlGnlPwJrsnY1kg1QwfOFWBsNzSLpZ+eCCCQQ==
X-Received: by 2002:a05:6870:e249:b0:35c:cfec:df79 with SMTP id 586e51a60fabf-3c0fb331d40mr13354989fac.51.1760562741715;
        Wed, 15 Oct 2025 14:12:21 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8eecb2bsm5806932fac.20.2025.10.15.14.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:12:21 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v5 3/6] builtin/repo: introduce structure subcommand
Date: Wed, 15 Oct 2025 16:12:10 -0500
Message-ID: <20251015211213.361797-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251015211213.361797-1-jltobler@gmail.com>
References: <20250927145049.723341-1-jltobler@gmail.com>
 <20251015211213.361797-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The structure of a repository's history can have huge impacts on the
performance and health of the repository itself. Currently, Git lacks a
means to surface repository metrics regarding its structure/shape via a
single command. Acquiring this information requires users to be familiar
with the relevant data points and the various Git commands required to
surface them. To fill this gap, supplemental tools such as git-sizer(1)
have been developed.

To allow users to more readily identify repository structure related
information, introduce the "structure" subcommand in git-repo(1). The
goal of this subcommand is to eventually provide similar functionality
to git-sizer(1), but natively in Git.

The initial version of this command only iterates through all references
in the repository and tracks the count of branches, tags, remote refs,
and other reference types. The corresponding information is displayed in
a human-friendly table formatted in a very similar manner to
git-sizer(1). The width of each table column is adjusted automatically
to satisfy the requirements of the widest row contained.

Subsequent commits will surface additional relevant data points to
output and also provide other more machine-friendly output formats.

Based-on-patch-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  10 ++
 builtin/repo.c              | 193 ++++++++++++++++++++++++++++++++++++
 t/meson.build               |   1 +
 t/t1901-repo-structure.sh   |  61 ++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100755 t/t1901-repo-structure.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 209afd1b61..8193298dd5 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
+git repo structure
 
 DESCRIPTION
 -----------
@@ -43,6 +44,15 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`structure`::
+	Retrieve statistics about the current repository structure. The
+	following kinds of information are reported:
++
+* Reference counts categorized by type
+
++
+The table output format may change and is not intended for machine parsing.
+
 INFO KEYS
 ---------
 In order to obtain a set of values from `git repo info`, you should provide
diff --git a/builtin/repo.c b/builtin/repo.c
index eeeab8fbd2..4575cf9467 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -4,12 +4,16 @@
 #include "environment.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "ref-filter.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "string-list.h"
 #include "shallow.h"
+#include "utf8.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
+	"git repo structure",
 	NULL
 };
 
@@ -156,12 +160,201 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	return print_fields(argc, argv, repo, format);
 }
 
+struct ref_stats {
+	size_t branches;
+	size_t remotes;
+	size_t tags;
+	size_t others;
+};
+
+struct stats_table {
+	struct string_list rows;
+
+	int name_col_width;
+	int value_col_width;
+};
+
+/*
+ * Holds column data that gets stored for each row.
+ */
+struct stats_table_entry {
+	char *value;
+};
+
+static void stats_table_vaddf(struct stats_table *table,
+			      struct stats_table_entry *entry,
+			      const char *format, va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	char *formatted_name;
+	int name_width;
+
+	strbuf_vaddf(&buf, format, ap);
+	formatted_name = strbuf_detach(&buf, NULL);
+	name_width = utf8_strwidth(formatted_name);
+
+	item = string_list_append_nodup(&table->rows, formatted_name);
+	item->util = entry;
+
+	if (name_width > table->name_col_width)
+		table->name_col_width = name_width;
+	if (entry) {
+		int value_width = utf8_strwidth(entry->value);
+		if (value_width > table->value_col_width)
+			table->value_col_width = value_width;
+	}
+}
+
+static void stats_table_addf(struct stats_table *table, const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	stats_table_vaddf(table, NULL, format, ap);
+	va_end(ap);
+}
+
+static void stats_table_count_addf(struct stats_table *table, size_t value,
+				   const char *format, ...)
+{
+	struct stats_table_entry *entry;
+	va_list ap;
+
+	CALLOC_ARRAY(entry, 1);
+	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+
+	va_start(ap, format);
+	stats_table_vaddf(table, entry, format, ap);
+	va_end(ap);
+}
+
+static void stats_table_setup_structure(struct stats_table *table,
+					struct ref_stats *refs)
+{
+	size_t ref_total;
+
+	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
+	stats_table_addf(table, "* %s", _("References"));
+	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
+	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
+	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
+	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
+	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
+}
+
+static void stats_table_print_structure(const struct stats_table *table)
+{
+	const char *name_col_title = _("Repository structure");
+	const char *value_col_title = _("Value");
+	int name_col_width = utf8_strwidth(name_col_title);
+	int value_col_width = utf8_strwidth(value_col_title);
+	struct string_list_item *item;
+
+	if (table->name_col_width > name_col_width)
+		name_col_width = table->name_col_width;
+	if (table->value_col_width > value_col_width)
+		value_col_width = table->value_col_width;
+
+	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
+	       value_col_width, value_col_title);
+	printf("| ");
+	for (int i = 0; i < name_col_width; i++)
+		putchar('-');
+	printf(" | ");
+	for (int i = 0; i < value_col_width; i++)
+		putchar('-');
+	printf(" |\n");
+
+	for_each_string_list_item(item, &table->rows) {
+		struct stats_table_entry *entry = item->util;
+		const char *value = "";
+
+		if (entry) {
+			struct stats_table_entry *entry = item->util;
+			value = entry->value;
+		}
+
+		printf("| %-*s | %*s |\n", name_col_width, item->string,
+		       value_col_width, value);
+	}
+}
+
+static void stats_table_clear(struct stats_table *table)
+{
+	struct stats_table_entry *entry;
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &table->rows) {
+		entry = item->util;
+		if (entry)
+			free(entry->value);
+	}
+
+	string_list_clear(&table->rows, 1);
+}
+
+static void structure_count_references(struct ref_stats *stats,
+				       struct ref_array *refs)
+{
+	for (int i = 0; i < refs->nr; i++) {
+		struct ref_array_item *ref = refs->items[i];
+
+		switch (ref->kind) {
+		case FILTER_REFS_BRANCHES:
+			stats->branches++;
+			break;
+		case FILTER_REFS_REMOTES:
+			stats->remotes++;
+			break;
+		case FILTER_REFS_TAGS:
+			stats->tags++;
+			break;
+		case FILTER_REFS_OTHERS:
+			stats->others++;
+			break;
+		default:
+			BUG("unexpected reference type");
+		}
+	}
+}
+
+static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
+			      struct repository *repo UNUSED)
+{
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct stats_table table = {
+		.rows = STRING_LIST_INIT_DUP,
+	};
+	struct ref_stats stats = { 0 };
+	struct ref_array refs = { 0 };
+	struct option options[] = { 0 };
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
+		die(_("unable to filter refs"));
+
+	structure_count_references(&stats, &refs);
+
+	stats_table_setup_structure(&table, &stats);
+	stats_table_print_structure(&table);
+
+	stats_table_clear(&table);
+	ref_array_clear(&refs);
+
+	return 0;
+}
+
 int cmd_repo(int argc, const char **argv, const char *prefix,
 	     struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_SUBCOMMAND("info", &fn, cmd_repo_info),
+		OPT_SUBCOMMAND("structure", &fn, cmd_repo_structure),
 		OPT_END()
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 7974795fe4..9e426f8edc 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -236,6 +236,7 @@ integration_tests = [
   't1701-racy-split-index.sh',
   't1800-hook.sh',
   't1900-repo.sh',
+  't1901-repo-structure.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
new file mode 100755
index 0000000000..e592eea0eb
--- /dev/null
+++ b/t/t1901-repo-structure.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='test git repo structure'
+
+. ./test-lib.sh
+
+test_expect_success 'empty repository' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >expect <<-\EOF &&
+		| Repository structure | Value |
+		| -------------------- | ----- |
+		| * References         |       |
+		|   * Count            |     0 |
+		|     * Branches       |     0 |
+		|     * Tags           |     0 |
+		|     * Remotes        |     0 |
+		|     * Others         |     0 |
+		EOF
+
+		git repo structure >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success 'repository with references' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m init &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		git notes add -m foo &&
+
+		cat >expect <<-\EOF &&
+		| Repository structure | Value |
+		| -------------------- | ----- |
+		| * References         |       |
+		|   * Count            |     4 |
+		|     * Branches       |     1 |
+		|     * Tags           |     1 |
+		|     * Remotes        |     1 |
+		|     * Others         |     1 |
+		EOF
+
+		git repo structure >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_done
-- 
2.51.0.193.g4975ec3473b

