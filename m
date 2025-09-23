Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A551EB5DB
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596229; cv=none; b=sAuiBO3DKQDh3N5Rca3sIyY6b44dpN9l4ZOaduy4Iy9prSFWyQqYQfhyV9196QfThAHGFTJaFG3Km2ZsMTdaoKVJLJ9KHbBu5NB6x7kpaeCydxQaoToiH74n0PTq1O0QKp9Zgd02kRGd/yxlRtEVBALhjjKnQ1qupjChHAR1J1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596229; c=relaxed/simple;
	bh=dsr0tf6Sd3y5Czi62gVcpgcW2+1FR+XUVJwSjRYQ3GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfN8fwfKfWURfd/0+XY8Z7+gU8TkCFL8KHXxTkP7TbbO/OVKKicn/yCLt+FqA1eil8ieImrQSELObhasG8iwo+i+VFdG1QZAV4fKfA5Aafn8jnzYxSpktGWk+/iT/gCmXUxDQZnsFKtwp0Fy8QS+AJCg7hV4XIHdu8z0KHeibWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltvk+Lpe; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltvk+Lpe"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-626190c9c1eso1696147eaf.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596226; x=1759201026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+pl2q9LZzNCvmigIScDxzspUkEl3mECqJeZ2yjnzNg=;
        b=ltvk+LpewUxJFWazud0ZOLjfVavIxw6/U+xs2QdqKr2XlDJSulXaiAjW9KKP4GrHXf
         S3GbpRIXQAt4d/y3R/BwkpCwoTkUi+HXDy/aYqWNUfEo7B02yz9/RQHCSDxCONTpqzBQ
         N9arF1l1rUlJhXuV8Gkbzf8JzJCQD9/ZVfECqIKrkcQols5P0x/vEUu/Ggdf0mznHd7r
         QTnrn5YaGGtRdz6bvRXoA6Wf0Mj0moyJi8fzJchy2ryk/j4Ye00pAvlDrateJcObt1ZN
         XB2jjzU9F55Uc7hoqaNDqpWq59cslE6Y++h3oIj96KoM38ujx9qCFwNZvRpugv9wHMaT
         SngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596226; x=1759201026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+pl2q9LZzNCvmigIScDxzspUkEl3mECqJeZ2yjnzNg=;
        b=fl5HOQr+kr3dwWCxU/+8g/Zn1DIsEvKprCHSNQ7GEgJrYvVO50iWvECI8KmE7bPorO
         V6R8Ie9Lum6feBVBUbufLlUnNu8CeE6FgeKPY/E4gD5UcBNBNnhrah+jJBSe2P2pYg82
         O6v2rowLRUf4LH1WD8DuDSZv+W2xi36QyG6n9M/oQ3oQZTiY/a3j7uCN39N34TxqGbc2
         /AvQcyvCg8jtCE2uGrYXYAEGXpyyGSbyjTc01qYUev/fKF+8RJMcLmrZr/N5vkH3ncoJ
         VCeFOeMIqEUMDJDnYoLiJ5h5wYLiy7ROJz2YvZauAQ6h61t+53Y2JV9ZymZCXFr0/PAt
         vm2g==
X-Gm-Message-State: AOJu0Yyl55XSqswxKc2GY3ORoNzb9c7sq0fUXd+tuZQmRBvosbiZHOQc
	xXPkPich75rnlimVYZgNlD1QZZDO95jlTiwN+oENUKquV7fx20+cyLK6H1rZSQ==
X-Gm-Gg: ASbGncukcUqnE2TVZt9aCd6EBIhJi75nmks1vaDPn38KZB7lbYpcEctm9YS5KTsbQZv
	dzwyFnFiyUvRWVT0pzNcl2F+lwz45ZAnir+i+MNPRNImsxQA9O2VenPQo/nWezzHkhedbLd8UfA
	MfcTeyWIExK5Jc4Q5bpt164X7Jh5Fl6Kf7hjeM89h+U9w8zLKJu/oENo+EOFpjO8jJFPY0ydxp/
	+oYiZAZX+G7hPONYCK8GR2o46iO0VOt7FtS1Ehs6FSZl0LxEAILw/lUqLeQzhN/5OQTTZueBRVp
	t0B6bDCk0IEFNN4QZBbmSUscCiNlQvwoRT4cM8/df+gcGCzfcJaeBJx9CTUl/Ogj9xJ2Ri6lGXE
	5iLFvv6CrDStyrC0PG+NYeqJviOpaW+g=
X-Google-Smtp-Source: AGHT+IFMPbFG1PqqkOwDvhwduC3KK7Cws2azHZpZ9HsMeasjzlkVb/tvD2bRBvOQ6xirUh2q7AtfFg==
X-Received: by 2002:a05:6820:22a2:b0:621:b76e:66b9 with SMTP id 006d021491bc7-63319866a67mr610803eaf.3.1758596226461;
        Mon, 22 Sep 2025 19:57:06 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692936963esm6431664a34.23.2025.09.22.19.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:57:06 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/4] builtin/repo: introduce stats subcommand
Date: Mon, 22 Sep 2025 21:56:57 -0500
Message-ID: <20250923025700.3046260-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250923025700.3046260-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shape of a repository's history can have huge impacts on the
performance and health of the repository itself. Currently, Git lacks a
means to surface key stats/information regarding the shape of a
repository via a single command. Acquiring this information requires
users to be fairly knowledgeable about the structure of a Git repository
and how to identify the relevant data points. To fill this gap,
supplemental tools such as git-sizer(1) have been developed.

To allow users to more readily identify potential issues for a
repository, introduce the "stats" subcommand in git-repo(1) to output
stats for the repository that may be of interest to users. The goal of
this subcommand is to eventually provide similar functionality to
git-sizer(1), but in Git natively.

The initial version of this command only iterates through all references
in the repository and tracks the count of branches, tags, remotes, and
other reference types. The corresponding information is displayed in a
human-friendly table formatted in a very similar manner to git-sizer(1).
The width of each table column is adjusted automatically to satisfy the
requirements of the widest row contained.

Subsequent commits will surface additional relevant data points to
output.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |   7 ++
 builtin/repo.c              | 151 ++++++++++++++++++++++++++++++++++++
 t/meson.build               |   1 +
 t/t1901-repo-stats.sh       |  59 ++++++++++++++
 4 files changed, 218 insertions(+)
 create mode 100755 t/t1901-repo-stats.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 209afd1b61..7762329551 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
+git repo stats
 
 DESCRIPTION
 -----------
@@ -43,6 +44,12 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+stats::
+	Retrieve stats about the current repository. All references in the
+	repository are categorized and counted accordingly.
++
+The table output format may change and is not intended for machine parsing.
+
 INFO KEYS
 ---------
 In order to obtain a set of values from `git repo info`, you should provide
diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..15899dd74c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -4,12 +4,15 @@
 #include "environment.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "ref-filter.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "string-list.h"
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
+	"git repo stats",
 	NULL
 };
 
@@ -156,12 +159,160 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 	return print_fields(argc, argv, repo, format);
 }
 
+struct stats {
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
+struct stats_table_entry {
+	char *value;
+};
+
+static void stats_table_add(struct stats_table *table, const char *name,
+			    struct stats_table_entry *entry)
+{
+	int name_width = strlen(name);
+	struct string_list_item *item;
+
+	item = string_list_append(&table->rows, name);
+	item->util = entry;
+
+	if (name_width > table->name_col_width)
+		table->name_col_width = name_width;
+	if (entry) {
+		int value_width = strlen(entry->value);
+		if (value_width > table->value_col_width)
+			table->value_col_width = value_width;
+	}
+}
+
+static void stats_table_add_count(struct stats_table *table, const char *name,
+				  size_t value)
+{
+	struct stats_table_entry *entry;
+
+	CALLOC_ARRAY(entry, 1);
+	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+	stats_table_add(table, name, entry);
+}
+
+static void stats_table_setup(struct stats_table *table, struct stats *stats)
+{
+	size_t ref_total;
+
+	ref_total = stats->branches + stats->remotes + stats->tags + stats->others;
+	stats_table_add(table, _("* References"), NULL);
+	stats_table_add_count(table, _("  * Count"), ref_total);
+	stats_table_add_count(table, _("    * Branches"), stats->branches);
+	stats_table_add_count(table, _("    * Tags"), stats->tags);
+	stats_table_add_count(table, _("    * Remotes"), stats->remotes);
+	stats_table_add_count(table, _("    * Others"), stats->others);
+}
+
+static void stats_table_print(struct stats_table *table)
+{
+	const char *name_col_title = _("Repository stats");
+	const char *value_col_title = _("Value");
+	int name_col_width = strlen(name_col_title);
+	int value_col_width = strlen(value_col_title);
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+
+	if (table->name_col_width > name_col_width)
+		name_col_width = table->name_col_width;
+	if (table->value_col_width > value_col_width)
+		value_col_width = table->value_col_width;
+
+	strbuf_addf(&buf, "| %-*s | %-*s |\n", name_col_width, name_col_title,
+		    value_col_width, value_col_title);
+	strbuf_addstr(&buf, "| ");
+	strbuf_addchars(&buf, '-', name_col_width);
+	strbuf_addstr(&buf, " | ");
+	strbuf_addchars(&buf, '-', value_col_width);
+	strbuf_addstr(&buf, " |\n");
+
+	for_each_string_list_item (item, &table->rows) {
+		struct stats_table_entry *entry = item->util;
+		const char *value = "";
+
+		if (entry) {
+			struct stats_table_entry *entry = item->util;
+			value = entry->value;
+		}
+
+		strbuf_addf(&buf, "| %-*s | %*s |\n", name_col_width,
+			    item->string, value_col_width, value);
+
+		if (entry)
+			free(entry->value);
+	}
+
+	fputs(buf.buf, stdout);
+	strbuf_release(&buf);
+}
+
+static void stats_count_references(struct stats *stats, struct ref_array *refs)
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
+		}
+	}
+}
+
+static int repo_stats(int argc UNUSED, const char **argv UNUSED,
+		      const char *prefix UNUSED, struct repository *repo UNUSED)
+{
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct strvec ref_patterns = STRVEC_INIT;
+	struct stats_table table = { 0 };
+	struct ref_array refs = { 0 };
+	struct stats stats = { 0 };
+
+	filter.name_patterns = ref_patterns.v;
+	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);
+
+	stats_count_references(&stats, &refs);
+
+	stats_table_setup(&table, &stats);
+	stats_table_print(&table);
+
+	string_list_clear(&table.rows, 1);
+	strvec_clear(&ref_patterns);
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
 		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_SUBCOMMAND("stats", &fn, repo_stats),
 		OPT_END()
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 7974795fe4..071d4a5112 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -236,6 +236,7 @@ integration_tests = [
   't1701-racy-split-index.sh',
   't1800-hook.sh',
   't1900-repo.sh',
+  't1901-repo-stats.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
new file mode 100755
index 0000000000..27c32ec45f
--- /dev/null
+++ b/t/t1901-repo-stats.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='test git repo stats'
+
+. ./test-lib.sh
+
+test_expect_success 'empty repository stats' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git repo stats >out 2>err &&
+
+		cat >expect <<-EOF &&
+		| Repository stats | Value |
+		| ---------------- | ----- |
+		| * References     |       |
+		|   * Count        |     0 |
+		|     * Branches   |     0 |
+		|     * Tags       |     0 |
+		|     * Remotes    |     0 |
+		|     * Others     |     0 |
+		EOF
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success 'repository stats with references' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m init &&
+		oid="$(git rev-parse HEAD)" &&
+		git switch -c foo &&
+		git tag init &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+		git notes add -m foo &&
+		git repo stats >out 2>err &&
+
+		cat >expect <<-EOF &&
+		| Repository stats | Value |
+		| ---------------- | ----- |
+		| * References     |       |
+		|   * Count        |     5 |
+		|     * Branches   |     2 |
+		|     * Tags       |     1 |
+		|     * Remotes    |     1 |
+		|     * Others     |     1 |
+		EOF
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_done
-- 
2.51.0.193.g4975ec3473b

