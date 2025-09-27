Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67D2E7F17
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984663; cv=none; b=qk+jFuLGctEvSzhvtN5+VleKW5JZEh9RAiv9MXT+KPxQBKmp+f7/jzSYfJX3ffObaPKLYZKoGn8NBCG8hTIdMTC2DR9wExvjAjUVeIAYbHqtj1VgjoPm4hMYK8fBetergeDEuyhebvVct5djI70xeHRGHOTVBGLKQtJTzUPvmvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984663; c=relaxed/simple;
	bh=RTN+EWoubHRIURI3ZDYCaA3mLByQ1i6t70t7snqEV04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGau5kh7d2jcHJ/U2ccIG1Tp1ZRoymVTmpEXDruL0FpmpRrshiaYlBdFTdiXtLzjGtfrlCiDobH6MGpMD3bsQ++n3EyHtbGNOK7L0iqGUu89S7YSNbrIE/VlmLTAjH5vNJVCC8I7zrajh0c2xu/UOV30XrT2h6xQF2JUiSj9VkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUt9ZHXy; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUt9ZHXy"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-643cd58c678so56934eaf.3
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758984661; x=1759589461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1uwm0TNLIHVWhjYm3JC+//WpG0knulG0d521qWecKM=;
        b=XUt9ZHXyNJx9BKVTSob/y/v3Sl+OSbuAegOufnfyGAhHItjffVSootBkKg5KVBYhgU
         Dk03mUH4kdtC1dYWykAS30P4+pNzmDFALD24VtvvoWUkPtNk//wy9mm3hQv0GAH+PDHn
         T9lSbUmu2syjHrWDDH/DuLR1QADKQw9TD0+/VpTaJQ3BsX1i9AitCwgC3nHXGKxHYVf5
         jqjas24G0CpDkyhdMmAv00T22z+hd95LMxvQ9urH7kEIOy136rDwZEHm7ychHob9MIK/
         2u72zntrSEVhX44eTFYUILhbXAyKYNJHmjrAVOBFnC69bLMIcv75/WinXmk8w/QfO9/z
         dzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758984661; x=1759589461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1uwm0TNLIHVWhjYm3JC+//WpG0knulG0d521qWecKM=;
        b=NdLiYBprpiFaCaye018DVi2QL/uRu4M+UOBmeHAsA7cMLx8R+4GfGwGg7p+Vo/n8jG
         NN3O8AZH8/vclGmX1eps9UQG+HA4HXbqmUdv/gLanBqIwvCumarr+AVEcFfLrZcQO1Bl
         dewODmAEkS2jRsxllDgBKty9RVCRI6Y55S4482gmwMtVvIbpBioQc50d94ekf/Mqlc/K
         36LvALPaQ6IUmsyzuPHxe9lGDoNXIe8qXPwZhtSslmfV5GSgCalkJjTB2V6eXi2ttGfe
         ZEtE/VuX/OzrE4P2ishFCmjQcAzbBsOpt4oqaqzCz2IQyyD2pOcLzTJ16M2morJW090g
         gpkA==
X-Gm-Message-State: AOJu0Yw4JobwySIdkd25Zho9OFGGedXJchiUsYeyngIJIJXNsifL333g
	4S4hducdreIETYfH/lgWBPg2itJuQvPxjd97HLz8Cn57EhFOJHCg1YuUOMoO9g==
X-Gm-Gg: ASbGncsLsI8bwd+YQ3aOmxUtHruX6fFaW4aVJxv42UwKD0MUdnT6yfWz8Vi285awHpS
	PAZtXWiVoEWUfp9cF36wQ7l1DMjVSZzYPOQSVE1irRxcy2GvgdChVZh/YTQcD3F5K3d0w4reS1z
	+ZIIUB7nT2zTZsyyoFFniSRGYR0di/pc4XngUyckhhvukF+2gZ7nYYed/b3ZppoMPYLCCQ9JrFn
	z4ZLgkwpAW/225SMTKZwBy9PuHOKcpNPmEEsT9JippBM8vjnz5M68iSvXnoTGADOUg1JJauAwyd
	At/hYWuNnPzewyzuMy9ZjL92KMca/O8ZNJxoOQoQvjVO1wVSDI6hSh3As4IzNLkJbp0tp/FD0VM
	7+3KxcZLFzEp/gXMXkrtOjjxWyjooiV2pES1J+C9ezQ==
X-Google-Smtp-Source: AGHT+IHKatqxn/yCyVmNgFdfNPGegj8OutMLKjGH1OLtCRCqbohy89FsP9ldu4K8wJXn989dcgnUTw==
X-Received: by 2002:a05:6808:690b:b0:43f:1c5d:8db with SMTP id 5614622812f47-43f4cbdc83dmr5980119b6e.6.1758984660845;
        Sat, 27 Sep 2025 07:51:00 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51258cf1sm1345401b6e.29.2025.09.27.07.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:51:00 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 6/7] builtin/repo: add keyvalue and nul format for stats
Date: Sat, 27 Sep 2025 09:50:48 -0500
Message-ID: <20250927145049.723341-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All repository stats are outputted in a human-friendly table form. This
format is not suitable for machine parsing. Add a --format option that
supports three output modes: `table`, `keyvalue`, and `nul`. The `table`
mode is the default format and prints the same table output as before.

With the `keyvalue` mode, each line of output contains a key-value pair
of a repository stat. The '=' character is used to delimit between keys
and values. The `nul` mode is similar to `keyvalue`, but key-values are
delimited by a NUL character instead of a newline. Also, instead of a
'=' character to delimit between keys and values, a newline character is
used. This allows stat values to support special characters without
having to cquote them. These two new modes provides output that is more
machine-friendly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc | 25 +++++++++++++++--
 builtin/repo.c              | 55 ++++++++++++++++++++++++++++++++++---
 t/t1901-repo-stats.sh       | 33 ++++++++++++++++++++++
 3 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 0b8d74ed3e..3fbce0b88c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
-git repo stats
+git repo stats [--format=(table|keyvalue|nul)]
 
 DESCRIPTION
 -----------
@@ -44,7 +44,7 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-`stats`::
+`stats [--format=(table|keyvalue|nul)]`::
 	Retrieve statistics about the current repository. The following kinds
 	of information are reported:
 +
@@ -52,7 +52,26 @@ supported:
 * Reachable object counts categorized by type
 
 +
-The table output format may change and is not intended for machine parsing.
+The output format can be chosen through the flag `--format`. Three formats are
+supported:
++
+`table`:::
+	Outputs repository stats in a human-friendly table. This format may
+	change and is not intended for machine parsing. This is the default
+	format.
+
+`keyvalue`:::
+	Each line of output contains a key-value pair for a repository stat.
+	The '=' character is used to delimit between the key and the value.
+	Values containing "unusual" characters are quoted as explained for the
+	configuration variable `core.quotePath` (see linkgit:git-config[1]).
+
+`nul`:::
+	Similar to `keyvalue`, but uses a NUL character to delimit between
+	key-value pairs instead of a newline. Also uses a newline character as
+	the delimiter between the key and value instead of '='. Unlike the
+	`keyvalue` format, values containing "unusual" characters are never
+	quoted.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index 3eefbeddba..6f41c9ada2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -15,13 +15,14 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
-	"git repo stats",
+	"git repo stats [--format=(table|keyvalue|nul)]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
+	FORMAT_TABLE,
 	FORMAT_KEYVALUE,
 	FORMAT_NUL_TERMINATED,
 };
@@ -136,6 +137,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_NUL_TERMINATED;
 	else if (!strcmp(arg, "keyvalue"))
 		*format = FORMAT_KEYVALUE;
+	else if (!strcmp(arg, "table"))
+		*format = FORMAT_TABLE;
 	else
 		die(_("invalid format '%s'"), arg);
 
@@ -158,6 +161,8 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
+		die(_("unsupported output format"));
 
 	return print_fields(argc, argv, repo, format);
 }
@@ -331,6 +336,30 @@ static void stats_table_clear(struct stats_table *table)
 	string_list_clear(&table->rows, 1);
 }
 
+static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
+				 char value_delim)
+{
+	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->refs.branches, value_delim);
+	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->refs.tags, value_delim);
+	printf("references.remotes.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->refs.remotes, value_delim);
+	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->refs.others, value_delim);
+
+	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.commits, value_delim);
+	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.trees, value_delim);
+	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.blobs, value_delim);
+	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.tags, value_delim);
+
+	fflush(stdout);
+}
+
 static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
 {
 	for (int i = 0; i < refs->nr; i++) {
@@ -415,10 +444,16 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
+	enum output_format format = FORMAT_TABLE;
 	struct repo_stats stats = { 0 };
 	struct ref_array refs = { 0 };
 	struct rev_info revs;
-	struct option options[] = { 0 };
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "format", &format, N_("format"),
+			       N_("output format"),
+			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_END()
+	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 	if (argc)
@@ -431,8 +466,20 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
 	stats_count_references(&stats.refs, &refs);
 	stats_count_objects(&stats.objects, &refs, &revs);
 
-	stats_table_setup(&table, &stats);
-	stats_table_print(&table);
+	switch (format) {
+	case FORMAT_TABLE:
+		stats_table_setup(&table, &stats);
+		stats_table_print(&table);
+		break;
+	case FORMAT_KEYVALUE:
+		stats_keyvalue_print(&stats, '=', '\n');
+		break;
+	case FORMAT_NUL_TERMINATED:
+		stats_keyvalue_print(&stats, '\n', '\0');
+		break;
+	default:
+		BUG("invalid output format");
+	}
 
 	stats_table_clear(&table);
 	release_revisions(&revs);
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
index 315b9e1767..2409edae4f 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
@@ -73,4 +73,37 @@ test_expect_success 'repository with references and objects' '
 	)
 '
 
+test_expect_success 'keyvalue and nul format' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 42 &&
+		git tag -a foo -m bar &&
+
+		cat >expect <<-\EOF &&
+		references.branches.count=1
+		references.tags.count=1
+		references.remotes.count=0
+		references.others.count=0
+		objects.commits.count=42
+		objects.trees.count=42
+		objects.blobs.count=42
+		objects.tags.count=1
+		EOF
+
+		git repo stats --format=keyvalue >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err &&
+
+		# Replace key and value delimiters for nul format.
+		tr "\n=" "\0\n" <expect >expect_nul &&
+		git repo stats --format=nul >out 2>err &&
+
+		test_cmp expect_nul out &&
+		test_line_count = 0 err
+	)
+'
+
 test_done
-- 
2.51.0.193.g4975ec3473b

