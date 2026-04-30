Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EDC381B1D
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578912; cv=none; b=XM8TC3+KHc+euNPQp18ZT/L7li91PcHbW1wniR9Aj48IA7idlOB1yQc3BrfoUBzfSNnLzgukrb7w0ns6a7F9iXWaaedeVNYGRu4WXnkXQNR2P/bchW0UWiaajV5zze6UlLYbh1BpuucHK/0fxKQlYXNxPhQmYmlfo9ZYCeke5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578912; c=relaxed/simple;
	bh=PP113QOqrwcL1aynINKThEpE5v09gstwatzhB+x/neM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Fx/JTFZTGDOwQLWxzGnLnzUfj/VBbjuDSu9K3Zjq4RPKq2VVgceUm5jKweAVXdPKr5KNiZbq+YrEnK7K32mJzX37D3JwOEjuU5fnSkgcHrGk3NwvnWfL0su0aZx6v5/5HVUGlu6i4xOsB2K5HjGPYVCu0dkJ2vGpiAJLr3gCYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9usmhMD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9usmhMD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ec37d52c0dso135253185a.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777578905; x=1778183705; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N2sVt7ntO/M1AnBGx0+XAiiqjez6TR7iTu4JCiRWdVA=;
        b=E9usmhMDrPhIct5RDgvElHHh0XfnyAgj2L1UhSMmcrHscO7cDQWkpaspwByQDCoOHn
         rfDoZRDiw3T2veKdp/JHp2m2WkeaAvu0rGPM9VKfMQtXaueZQAdJ8AtdAHEGCNxO+CWm
         NbPz++wh5uHz9xa9EmD2qelLd1glBPt2utWmKti8XzQuUbB+G1ePso9mcGso/TeIlNHl
         WcbY+V58hFcMfMMQrZy6vzw4itwCwjkFQ5TCsB4GFcDQslqDP92MNgoCR6uLZwGlcMdL
         7yj9F9TgHMr4IUCcBrLlqZWxvOTC7RXzpHaCVSaaFE0NnYluDzN1YRihUlXkFFHq8nRZ
         3LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777578905; x=1778183705;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2sVt7ntO/M1AnBGx0+XAiiqjez6TR7iTu4JCiRWdVA=;
        b=h6aboG541LExBoi8aXosakklNcFvvCAF/XY0qSuGG/TI7m2dGbAleaLrGHixMb/JVc
         S3ymouVF40pzCQ0vEaAqNCZ7BBDaa7Z7XWyCRBW2d14c4ADfw6jCTuBkizRIN81ZU7pm
         lzLWcDf/kopu5n6hBc8o6TqWzKtoWYEYUrY7oDxX9qPGS6QQnFO+xeZoiodjHDalEwBq
         Spq4BDUn0hVtz1z2sitfULqisrnDM9g/6Pg/rFYqZAq2I9NZC5LirXGmrlHfjKPhvpGv
         sDipScZIUCMsuUvjz2sg14UQ+C6unZAAgxHZLtCu4yiGtcOKtHrPYLXzbMWOuHq4se/Q
         5SeA==
X-Gm-Message-State: AOJu0YxZvcGKRtrN4kvddOvQ9ye2Ox3BGHOBIEDr6EYK7LsCBZ+K9NZ3
	O08owYjX7R9h516XCQX5w2zsnLhNJxO1Eoo+XGYvAxymYOPv1Zh/dNBPg+ZNRw==
X-Gm-Gg: AeBDietcc5YRW1lnlWOur4p3CAOXnjhWiDirC8c/azk123zOIGDi2j/AcAwLZHpiskY
	7srm5daGIpt/Vlql9d0lf9piQmJVuCIvyxx+Y4ZsZXqXDdD5wGQlQIIh1c/t9/Y93DJPuA9hInB
	7Wp0GNcetBe10bKqt/VvGVPGu/S+rJr/T8X+yciyS12PVbPDFStl+1c1jd9C5+lH0HQWRyAJJBt
	3xGaYW6WLu2yDZD6h8iB0fWZCLvYs1vIrsDe7ooUAduJuWhx5DnCp8uq4txAdS0/IoYGwrzea4s
	HDHTgdr5QHwrDmktGH4bX1nJrFfFal5fHfY4wlX9o3ePPoGFA4rmhyCft8z596KpAIE4NZa7ItJ
	ShBnvFr8eFtyq5q8NsgKV+Rm6ytjTfnFQf+obm2eMWrpkEC1swkpPbu0IbME8F9eiZXfsAFbA9W
	hQDzKLOoel33iiLQEHs5agFx4To3QRgBo/eaF0lQ==
X-Received: by 2002:a05:620a:bc5:b0:8bb:ac44:bd3c with SMTP id af79cd13be357-8fa8922bc0bmr699698785a.52.1777578904876;
        Thu, 30 Apr 2026 12:55:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.132.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fbf326db63sm306085a.22.2026.04.30.12.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:55:04 -0700 (PDT)
Message-Id: <pull.2284.git.git.1777578903593.gitgitgadget@gmail.com>
From: "Andrey Zarubin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 19:55:03 +0000
Subject: [PATCH] pretty: add diff-stat log placeholders
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Andrey Zarubin <zarandr@gmail.com>,
    Andrey Zarubin <zarandr@gmail.com>

From: Andrey Zarubin <zarandr@gmail.com>

Currently, users who want per-commit line/file change counts in
a custom log format must post-process `git log --shortstat`
output because the pretty formatter exposes no equivalent
placeholders.

Introduce `%(diff-stat:files)`, `%(diff-stat:insertions)`,
`%(diff-stat:deletions)`, and `%(diff-stat:lines)`, computed
from the same diffstat machinery as `--shortstat` and cached
once per commit during format expansion.

Short aliases are provided as `%aF`, `%aA`, and `%aR`. The
requested `%aI` and `%aD` forms are unavailable because those
names already expand to author dates, so use additions/removals
mnemonics instead.

When log output is already walking a diff, the formatter reuses
the current diff queue. Otherwise it computes a private summary
lazily, so formats without these placeholders still pay no diff
cost.

Signed-off-by: Andrey Zarubin <zarandr@gmail.com>
---
    pretty: add diff-stat log placeholders

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2284%2Fzarandr%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2284/zarandr/master-v1
Pull-Request: https://github.com/git/git/pull/2284

 Documentation/pretty-formats.adoc |  12 +++
 builtin/log.c                     |   5 +
 diff.c                            |  32 ++++--
 diff.h                            |   8 ++
 log-tree.c                        |   2 +
 pretty.c                          | 166 ++++++++++++++++++++++++++++++
 pretty.h                          |   3 +
 t/t4205-log-pretty-formats.sh     | 162 +++++++++++++++++++++++++++++
 8 files changed, 381 insertions(+), 9 deletions(-)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 2ae0eb11a9..d1b574f3ad 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -294,6 +294,18 @@ tags are added or removed at the same time.
 `exclude=<pattern>`;; Do not consider tags matching the given
    `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.
 
+++%(diff-stat:files)++:: show the number of files changed
+++%(diff-stat:insertions)++:: show the number of inserted lines
+++%(diff-stat:deletions)++:: show the number of deleted lines
+++%(diff-stat:lines)++:: show the total number of inserted and deleted lines
++
+  These placeholders are computed like `--shortstat`. By default,
+  merge commits expand to `0` unless a merge diff mode such as `-m`,
+  `-c`, or `--cc` is in effect.
++%aF+:: short alias for `%(diff-stat:files)`
++%aA+:: short alias for `%(diff-stat:insertions)`
++%aR+:: short alias for `%(diff-stat:deletions)`
+
 +%S+:: ref name given on the command line by which the commit was reached
        (like `git log --source`), only works with `git log`
 +%e+:: encoding
diff --git a/builtin/log.c b/builtin/log.c
index 8c0939dd42..017face2c0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -321,6 +321,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
+	if (w.diffstat) {
+		rev->diff = 1;
+		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+	}
+
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
diff --git a/diff.c b/diff.c
index 397e38b41c..2f018e801a 100644
--- a/diff.c
+++ b/diff.c
@@ -3195,12 +3195,14 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	strbuf_release(&out);
 }
 
-static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
+void summarize_diffstat(struct diffstat_t *data,
+			struct diff_stat_summary *summary)
 {
-	int i, adds = 0, dels = 0, total_files = data->nr;
+	int i;
 
-	if (data->nr == 0)
-		return;
+	summary->files = data->nr;
+	summary->insertions = 0;
+	summary->deletions = 0;
 
 	for (i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
@@ -3208,13 +3210,25 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
-			total_files--;
-		} else if (!data->files[i]->is_binary) { /* don't count bytes */
-			adds += added;
-			dels += deleted;
+			summary->files--;
+		} else if (!data->files[i]->is_binary) {
+			summary->insertions += added;
+			summary->deletions += deleted;
 		}
 	}
-	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
+}
+
+static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
+{
+	struct diff_stat_summary summary;
+
+	if (data->nr == 0)
+		return;
+
+	summarize_diffstat(data, &summary);
+	print_stat_summary_inserts_deletes(options, summary.files,
+					   summary.insertions,
+					   summary.deletions);
 }
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index 7eb84aadf4..798c52138d 100644
--- a/diff.h
+++ b/diff.h
@@ -449,6 +449,12 @@ struct diffstat_t {
 	} **files;
 };
 
+struct diff_stat_summary {
+	int files;
+	int insertions;
+	int deletions;
+};
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
@@ -581,6 +587,8 @@ struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
 void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat,
 		      struct diff_queue_struct *q);
+void summarize_diffstat(struct diffstat_t *diffstat,
+			struct diff_stat_summary *summary);
 void free_diffstat_info(struct diffstat_t *diffstat);
 
 #define DIFF_SETUP_REVERSE      	1
diff --git a/log-tree.c b/log-tree.c
index 7e048701d0..aa6f6dd27d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -881,6 +881,8 @@ void show_log(struct rev_info *opt)
 	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
 	ctx.output_encoding = get_log_output_encoding();
 	ctx.rev = opt;
+	ctx.diff_parent = parent;
+	ctx.diff_queue_present = diff_queued_diff.nr > 0;
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
 	if (opt->graph)
diff --git a/pretty.c b/pretty.c
index 814803980b..a50ecd31ce 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,6 +10,7 @@
 #include "hex.h"
 #include "utf8.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "pager.h"
 #include "revision.h"
 #include "string-list.h"
@@ -893,6 +894,7 @@ struct format_commit_context {
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
+	unsigned diffstat_parsed:1;
 	struct signature_check signature_check;
 	enum flush_type flush_type;
 	enum trunc_type truncate;
@@ -911,6 +913,7 @@ struct format_commit_context {
 
 	/* The following ones are relative to the result struct strbuf. */
 	size_t wrap_start;
+	struct diff_stat_summary diffstat;
 };
 
 static void parse_commit_header(struct format_commit_context *context)
@@ -939,6 +942,145 @@ static void parse_commit_header(struct format_commit_context *context)
 	context->commit_header_parsed = 1;
 }
 
+enum diff_stat_placeholder {
+	DIFF_STAT_FILES,
+	DIFF_STAT_INSERTIONS,
+	DIFF_STAT_DELETIONS,
+	DIFF_STAT_LINES,
+};
+
+static void parse_commit_diffstat(struct format_commit_context *c)
+{
+	const struct pretty_print_context *pretty_ctx = c->pretty_ctx;
+	const struct rev_info *rev = pretty_ctx->rev;
+	struct diff_options opts;
+	struct diffstat_t diffstat;
+	const struct commit *commit = c->commit;
+	const struct commit *parent = pretty_ctx->diff_parent;
+	const struct object_id *tree_oid;
+	int copied_pathspec = 0;
+	int use_current_queue = 0;
+	int use_rev_opts = rev && rev->diffopt.repo;
+
+	if (c->diffstat_parsed)
+		return;
+	c->diffstat_parsed = 1;
+	memset(&c->diffstat, 0, sizeof(c->diffstat));
+
+	if (pretty_ctx->diff_queue_present) {
+		opts = rev->diffopt;
+		compute_diffstat(&opts, &diffstat, &diff_queued_diff);
+		summarize_diffstat(&diffstat, &c->diffstat);
+		free_diffstat_info(&diffstat);
+		return;
+	}
+
+	parse_commit_or_die((struct commit *)commit);
+	tree_oid = get_commit_tree_oid(commit);
+
+	if (use_rev_opts) {
+		memcpy(&opts, &rev->diffopt, sizeof(opts));
+		copy_pathspec(&opts.pathspec, &rev->diffopt.pathspec);
+		copied_pathspec = 1;
+	} else {
+		repo_diff_setup(c->repository, &opts);
+		init_diffstat_widths(&opts);
+		opts.flags.recursive = 1;
+		opts.flags.allow_textconv = 1;
+	}
+	opts.output_format = DIFF_FORMAT_SHORTSTAT;
+	diff_setup_done(&opts);
+
+	if (!commit->parents) {
+		if (use_rev_opts && !rev->show_root_diff)
+			goto out;
+		diff_root_tree_oid(tree_oid, "", &opts);
+		use_current_queue = 1;
+		goto diffstat;
+	}
+
+	if (!parent && commit->parents->next) {
+		if (!use_rev_opts)
+			goto out;
+		if (rev->combine_merges ||
+		    (rev->separate_merges && rev->first_parent_merges))
+			parent = commit->parents->item;
+		else
+			goto out;
+	} else if (!parent) {
+		parent = commit->parents->item;
+	}
+
+	parse_commit_or_die((struct commit *)parent);
+	diff_tree_oid(get_commit_tree_oid(parent), tree_oid, "", &opts);
+	use_current_queue = 1;
+
+diffstat:
+	diffcore_std(&opts);
+	compute_diffstat(&opts, &diffstat, &diff_queued_diff);
+	summarize_diffstat(&diffstat, &c->diffstat);
+	free_diffstat_info(&diffstat);
+out:
+	if (use_current_queue) {
+		opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+		diff_flush(&opts);
+	}
+	if (copied_pathspec)
+		clear_pathspec(&opts.pathspec);
+	else
+		diff_free(&opts);
+}
+
+static void format_commit_diffstat(struct strbuf *sb,
+				   struct format_commit_context *c,
+				   enum diff_stat_placeholder which)
+{
+	int value;
+
+	parse_commit_diffstat(c);
+
+	switch (which) {
+	case DIFF_STAT_FILES:
+		value = c->diffstat.files;
+		break;
+	case DIFF_STAT_INSERTIONS:
+		value = c->diffstat.insertions;
+		break;
+	case DIFF_STAT_DELETIONS:
+		value = c->diffstat.deletions;
+		break;
+	case DIFF_STAT_LINES:
+		value = c->diffstat.insertions + c->diffstat.deletions;
+		break;
+	default:
+		BUG("unknown diff stat placeholder");
+	}
+
+	strbuf_addf(sb, "%d", value);
+}
+
+static size_t parse_diff_stat_placeholder(struct strbuf *sb,
+					  const char *placeholder,
+					  struct format_commit_context *c)
+{
+	const char *arg;
+	enum diff_stat_placeholder which;
+
+	if (skip_prefix(placeholder, "(diff-stat:files)", &arg))
+		which = DIFF_STAT_FILES;
+	else if (skip_prefix(placeholder, "(diff-stat:insertions)", &arg))
+		which = DIFF_STAT_INSERTIONS;
+	else if (skip_prefix(placeholder, "(diff-stat:deletions)", &arg))
+		which = DIFF_STAT_DELETIONS;
+	else if (skip_prefix(placeholder, "(diff-stat:lines)", &arg))
+		which = DIFF_STAT_LINES;
+	else
+		return 0;
+
+	format_commit_diffstat(sb, c, which);
+	return arg - placeholder;
+}
+
 static int istitlechar(char c)
 {
 	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
@@ -1564,6 +1706,24 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 7;
 	}
 
+	if (placeholder[0] == 'a') {
+		switch (placeholder[1]) {
+		case 'F':
+			format_commit_diffstat(sb, c, DIFF_STAT_FILES);
+			return 2;
+		case 'A':
+			format_commit_diffstat(sb, c, DIFF_STAT_INSERTIONS);
+			return 2;
+		case 'R':
+			format_commit_diffstat(sb, c, DIFF_STAT_DELETIONS);
+			return 2;
+		}
+	}
+
+	res = parse_diff_stat_placeholder(sb, placeholder, c);
+	if (res)
+		return res;
+
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
@@ -1980,6 +2140,10 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 			fmt++;
 
 		switch (*fmt) {
+		case 'a':
+			if (fmt[1] == 'F' || fmt[1] == 'A' || fmt[1] == 'R')
+				w->diffstat = 1;
+			break;
 		case 'N':
 			w->notes = 1;
 			break;
@@ -1993,6 +2157,8 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 		case '(':
 			if (starts_with(fmt + 1, "decorate"))
 				w->decorate = 1;
+			else if (starts_with(fmt + 1, "diff-stat:"))
+				w->diffstat = 1;
 			break;
 		}
 	}
diff --git a/pretty.h b/pretty.h
index fac699033e..7f0491e512 100644
--- a/pretty.h
+++ b/pretty.h
@@ -58,6 +58,8 @@ struct pretty_print_context {
 	 */
 	struct string_list in_body_headers;
 	int graph_width;
+	const struct commit *diff_parent;
+	unsigned diff_queue_present:1;
 };
 
 /* Check whether commit format is mail. */
@@ -75,6 +77,7 @@ struct userformat_want {
 	unsigned notes:1;
 	unsigned source:1;
 	unsigned decorate:1;
+	unsigned diffstat:1;
 };
 void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 3865f6abc7..230950baed 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1227,4 +1227,166 @@ test_expect_failure 'wide and decomposed characters column counting' '
 	test_cmp expected actual
 '
 
+diffstat_log_shortstat_values () {
+	git -C diffstat log --shortstat --format=tformat:commit "$@" |
+	perl -ne '
+		chomp;
+		if ($_ eq "commit") {
+			if ($seen) {
+				print "$files $insertions $deletions ",
+				      $insertions + $deletions, "\n";
+			}
+			$seen = 1;
+			($files, $insertions, $deletions) = (0, 0, 0);
+		} elsif (/^\s*(\d+) files? changed(?:, (\d+) insertions?\(\+\))?(?:, (\d+) deletions?\(-\))?$/) {
+			$files = $1;
+			$insertions = defined($2) ? $2 : 0;
+			$deletions = defined($3) ? $3 : 0;
+		}
+		END {
+			if ($seen) {
+				print "$files $insertions $deletions ",
+				      $insertions + $deletions, "\n";
+			}
+		}
+	'
+}
+
+test_diff_stat_placeholders () {
+	commit=$1
+	shift &&
+	diffstat_log_shortstat_values -1 "$@" "$commit" >expected &&
+	git -C diffstat log -1 \
+		--format="%(diff-stat:files) %(diff-stat:insertions) %(diff-stat:deletions) %(diff-stat:lines)" \
+		"$@" \
+		"$commit" >actual &&
+	sed "/^$/d" <expected >expect-nonblank &&
+	sed "/^$/d" <actual >actual-nonblank &&
+	test_cmp expect-nonblank actual-nonblank
+}
+
+test_expect_success 'set up diffstat pretty-format history' '
+	test_create_repo diffstat &&
+	(
+		cd diffstat &&
+		echo root >file &&
+		git add file &&
+		test_tick &&
+		git commit -m root &&
+		root=$(git rev-parse HEAD) &&
+		main_branch=$(git symbolic-ref --quiet --short HEAD) &&
+
+		printf "line two\nline three\n" >>file &&
+		git add file &&
+		test_tick &&
+		git commit -m text &&
+		text=$(git rev-parse HEAD) &&
+
+		printf "\000\001\002\003" >bin &&
+		git add bin &&
+		test_tick &&
+		git commit -m binary &&
+		binary=$(git rev-parse HEAD) &&
+
+		echo doomed >doomed &&
+		git add doomed &&
+		test_tick &&
+		git commit -m doomed &&
+
+		git rm doomed &&
+		test_tick &&
+		git commit -m delete-doomed &&
+		delete_only=$(git rev-parse HEAD) &&
+
+		git branch topic &&
+		git mv file renamed &&
+		test_tick &&
+		git commit -m rename &&
+		rename=$(git rev-parse HEAD) &&
+
+		git checkout topic &&
+		echo topic >topic &&
+		git add topic &&
+		test_tick &&
+		git commit -m topic &&
+
+		git checkout "$main_branch" &&
+		test_tick &&
+		git merge --no-ff -m merge topic &&
+		merge=$(git rev-parse HEAD) &&
+
+		cat >../diffstat-oids <<-EOF
+		root=$root
+		text=$text
+		binary=$binary
+		delete_only=$delete_only
+		rename=$rename
+		merge=$merge
+		EOF
+	)
+'
+
+load_diffstat_oids () {
+	. ./diffstat-oids
+}
+
+test_expect_success 'diff-stat placeholders match shortstat for root commit' '
+	load_diffstat_oids &&
+	test_diff_stat_placeholders "$root"
+'
+
+test_expect_success 'diff-stat placeholders match shortstat for normal commit' '
+	load_diffstat_oids &&
+	test_diff_stat_placeholders "$text"
+'
+
+test_expect_success 'diff-stat placeholders match shortstat for binary change' '
+	load_diffstat_oids &&
+	test_diff_stat_placeholders "$binary"
+'
+
+test_expect_success 'diff-stat placeholders match shortstat for delete-only commit' '
+	load_diffstat_oids &&
+	test_diff_stat_placeholders "$delete_only"
+'
+
+test_expect_success 'diff-stat placeholders match shortstat for rename commit' '
+	load_diffstat_oids &&
+	test_diff_stat_placeholders "$rename" -M
+'
+
+test_expect_success 'diff-stat placeholders match shortstat for merge commit' '
+	load_diffstat_oids &&
+	test_diff_stat_placeholders "$merge"
+'
+
+test_expect_success 'diff-stat placeholders match shortstat for -m merge output' '
+	load_diffstat_oids &&
+	test_diff_stat_placeholders "$merge" -m
+'
+
+test_expect_success 'diff-stat placeholders match shortstat for --cc merge output' '
+	load_diffstat_oids &&
+	test_diff_stat_placeholders "$merge" --cc
+'
+
+test_expect_success 'diff-stat aliases match shortstat' '
+	load_diffstat_oids &&
+	diffstat_log_shortstat_values -1 -M "$rename" >expected &&
+	cut -d" " -f1-3 expected >expect-alias &&
+	git -C diffstat log -1 -M --format="%aF %aA %aR" "$rename" >actual &&
+	test_cmp expect-alias actual
+'
+
+test_expect_success 'multiple diff-stat placeholders reuse one summary' '
+	load_diffstat_oids &&
+	set -- $(diffstat_log_shortstat_values -1 "$text") &&
+	printf "%s %s %s %s %s %s %s\n" \
+		"$1" "$1" "$2" "$2" "$3" "$3" "$4" >expected &&
+	git -C diffstat log -1 \
+		--format="%aF %(diff-stat:files) %aA %(diff-stat:insertions) %aR %(diff-stat:deletions) %(diff-stat:lines)" \
+		"$text" >actual &&
+	test_cmp expected actual
+'
+
 test_done

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
