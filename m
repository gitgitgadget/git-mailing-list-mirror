Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009102EA17F
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842978; cv=none; b=J+uOeEcq5s/i1ODMiGMZ0n7pNQJVKZyjF3ee8JjkiAs7r1iMTRedte5W2eyt4+wlMXP7aK4nOtdW4L4dGb5VMF661cdpQ5Wt5Zga9R3aS3ySPr7uBWZxnOi3oZdLh2JSkbqiUwggN69DEKF1wp+N3/OSxgkQaQWP1ipNVLfWHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842978; c=relaxed/simple;
	bh=2Gwpr1Pq8lLFlhiCNwJ6iyDu/K0VKhAo/MhbNk8g+Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjmzxRziHH4XT1sjUPyx+4HNxCICY4hQj+IC7Hq+cyUU9ve2Pm642bBxD6xYecPDcoUoTz+2rwcoB6sb3l5A5DWawZ7s1Ej8ZuLwAzHpcbuouReJqD0u0vvcqHz23XO3HTcubfrQZoAyv7aJz2EFVW4HVxcfK2h4ae78RIFlkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mltPlXJH; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mltPlXJH"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74381e2079fso1484512a34.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842975; x=1759447775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt536kJU9yjs+tbWL+FQSC/ZQwnHSz6IoqMhHWrX39U=;
        b=mltPlXJH7IYFykiIbjxvKOKFnXt5syEMcgdaEwvu+FkZuJoR2w7qXOHFbMl1YhdMgS
         xLZefT8WdeJ1PQO8LKQp1KL4lJRpEVy+RmALIQE6DWgNvijd7WVPfmEzD39jCSXLoYgD
         yGlw0Du1J0xh+APaaWNhx28UGpOHyntDFShgTLtm8JfqPAObpc2Tq16S/gMCaRfqKUxp
         igLevqI0RLV8NWh9UX8WYdBMaE+inIpmpGxRxJq2GOg5IaxTZnnANrFz+ubf+80amJXZ
         uMtFzqDoVBgOB1mXHhS9tXuVbZeB1pvM7jepSfp8GAsecl/Nh9qq12Qgcj2C46KPWMN9
         qEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842975; x=1759447775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kt536kJU9yjs+tbWL+FQSC/ZQwnHSz6IoqMhHWrX39U=;
        b=eYnOTvf0Hg52BMsz/H1kA/SrwELXTLXkpOX8N+OVzd91jQNRXNRQu4Pdosr9nHUaiy
         mfMmop+6fyq7wYBw85pVnyLIW22jQeYwD8gIUEj423U4om1ky63gER905QNJXk1WthhB
         2vOuw5S8AkDFT6I6ArsQPnsvZpepe1sayRwonqzvVvw2mEfj36syKZG9QuX3/DT7bRXm
         mqd161zdyjf9O3F91CMBnXwjh4DNEumq5FLqT0/DFQH95Fg4TXU8D5/607h6IeZcIBiA
         bwGt3vxXciapuvIw2YmdOHgoClM8rNSQ78RkBEwGPQEhsxdCThFy07GzzYZ5JmW1AAr1
         yI3Q==
X-Gm-Message-State: AOJu0YyXsu8OmiCgAN6e+GdUORWer7XROhf4RhboMVUlMp+kg1pWKQeI
	uXYAyXpoqlrUuOAGeaWIMRBXjiWrF0+NJ61P4h0HI2h3+TRp6VFE0A+zVPtOEw==
X-Gm-Gg: ASbGncsTqaTxptR9qG8/nRLj6E3R8PYYOwkQabiZ9hlmpvlkppd8T4McoMqX6HoZy7C
	eC4frB4ZAwhbzmbHfmySREgXeFt7fRZuJiQ8z1wZ2rmA71y8iENawcQ9iFvsKy3Er2rZ//+UAEU
	sO3P2fMGlb+w4HUL60D5XOJrh45caYj6lsJ7CJzDj3u5nd7MvN5c0SST+DLx0DReaoWiiB4mZj/
	y/yhMfW9ZvL3nQZWz1QG5xBbyIoEAuBBuaeEsXesiUUlc6ssZqBHbkO1MqD4yDYT9K/AON6bULb
	ov4YehI4QIN4y6rtrfzSd5Ed5uQm/tUP8fBWdI/7/a1W+zP/6rVY8e5A7ywo6yQY+ZKrZLe42x7
	ZhC1jGTDKA4loeBzNaEH92PDDKJzsQkSAGO47Fe/BlQ==
X-Google-Smtp-Source: AGHT+IE+8AIO2HkFBGENQSDsdmD3G9vPKri5kJwGQ0uKka7hoZ10Dx+4/gBLS4QiFvWvWrVfDgUCeg==
X-Received: by 2002:a05:6830:6481:b0:741:a36f:7a2f with SMTP id 46e09a7af769-7a044bce594mr3083114a34.5.1758842974553;
        Thu, 25 Sep 2025 16:29:34 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7a2402e5d70sm674273a34.36.2025.09.25.16.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:29:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/7] builtin/repo: introduce stats subcommand
Date: Thu, 25 Sep 2025 18:29:21 -0500
Message-ID: <20250925232928.3846-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250924212426.2930029-1-jltobler@gmail.com>
References: <20250924212426.2930029-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

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

In this initial version, the "stats" subcommand only surfaces counts of
the various reference and object types in a repository. In a follow-up
series, I would like to introduce additional data points that are
present in git-sizer(1) such as largest objects, combined object sizes
by type, and other general repository shape information.

Some other general features that would be nice to introduce eventually:

- A "level of concern" meter for reported stats. This could indicate to
  users which stats may be worth looking into further.
- Links to OIDs of interesting objects that correspond to certain stats.
- Options to limit which references to use when evaluating the
  repository.

Changes since V2:

- Added clang-format patch to address false postive triggered in this
  series.
- Use varargs for stats_table_add() family of functions.
- Print to stdout directly instead of using strbuf.
- Add parse_option() earlier in the series.
- Use start_delayed_progress() instead of start_progress().
- Add test to validate --[no-]progress options.
- Some other small fixes.

Changes since V1:

- Translatable terms displayed in the table have formatting separated
  out.
- Squashed the `keyvalue` and `nul` output format patches into one.
- Added a progress meter to provide users with more feedback.
- Updated docs to outline to outline reported data in a bulleted list.
- Combined similar tests together to reduce repetitive setup.
- Added patch to improve ref-filter interface so we don't have to create
  a dummy patterns array.
- Many other renames and cleanups to improve patch clarity.

Thanks,
-Justin

Justin Tobler (7):
  builtin/repo: rename repo_info() to cmd_repo_info()
  ref-filter: allow NULL filter pattern
  clang-format: exclude control macros from SpaceBeforeParens
  builtin/repo: introduce stats subcommand
  builtin/repo: add object counts in stats output
  builtin/repo: add keyvalue and nul format for stats
  builtin/repo: add progress meter for stats

 .clang-format               |   2 +-
 Documentation/git-repo.adoc |  30 +++
 builtin/repo.c              | 372 +++++++++++++++++++++++++++++++++++-
 ref-filter.c                |   4 +-
 t/meson.build               |   1 +
 t/t1901-repo-stats.sh       | 129 +++++++++++++
 6 files changed, 532 insertions(+), 6 deletions(-)
 create mode 100755 t/t1901-repo-stats.sh

Range-diff against v2:
1:  ed04168562 = 1:  ed04168562 builtin/repo: rename repo_info() to cmd_repo_info()
2:  6aa76d1323 = 2:  6aa76d1323 ref-filter: allow NULL filter pattern
-:  ---------- > 3:  02a3fcc5fb clang-format: exclude control macros from SpaceBeforeParens
3:  dc06ca98fb ! 4:  12cfbdc464 builtin/repo: introduce stats subcommand
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	char *value;
     +};
     +
    -+static void stats_table_add(struct stats_table *table, const char *format,
    -+			    const char *name, struct stats_table_entry *entry)
    ++static void stats_table_vaddf(struct stats_table *table,
    ++			      struct stats_table_entry *entry,
    ++			      const char *format, va_list ap)
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +	struct string_list_item *item;
     +	char *formatted_name;
     +	size_t name_width;
     +
    -+	strbuf_addf(&buf, format, name);
    ++	strbuf_vaddf(&buf, format, ap);
     +	formatted_name = strbuf_detach(&buf, &name_width);
     +
     +	item = string_list_append_nodup(&table->rows, formatted_name);
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	}
     +}
     +
    -+static void stats_table_add_count(struct stats_table *table, const char *format,
    -+				  const char *name, size_t value)
    ++static void stats_table_addf(struct stats_table *table, const char *format, ...)
    ++{
    ++	va_list ap;
    ++
    ++	va_start(ap, format);
    ++	stats_table_vaddf(table, NULL, format, ap);
    ++	va_end(ap);
    ++}
    ++
    ++static void stats_table_count_addf(struct stats_table *table, size_t value,
    ++				   const char *format, ...)
     +{
     +	struct stats_table_entry *entry;
    ++	va_list ap;
     +
     +	CALLOC_ARRAY(entry, 1);
     +	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
    -+	stats_table_add(table, format, name, entry);
    ++
    ++	va_start(ap, format);
    ++	stats_table_vaddf(table, entry, format, ap);
    ++	va_end(ap);
     +}
     +
     +static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	size_t ref_total;
     +
     +	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
    -+	stats_table_add(table, "* %s", _("References"), NULL);
    -+	stats_table_add_count(table, "  * %s", _("Count"), ref_total);
    -+	stats_table_add_count(table, "    * %s", _("Branches"), refs->branches);
    -+	stats_table_add_count(table, "    * %s", _("Tags"), refs->tags);
    -+	stats_table_add_count(table, "    * %s", _("Remotes"), refs->remotes);
    -+	stats_table_add_count(table, "    * %s", _("Others"), refs->others);
    ++	stats_table_addf(table, "* %s", _("References"));
    ++	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
    ++	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
    ++	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
    ++	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
    ++	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
     +}
     +
     +static inline size_t max_size_t(size_t a, size_t b)
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	return (a > b) ? a : b;
     +}
     +
    -+static void stats_table_print(struct stats_table *table)
    ++static void stats_table_print(const struct stats_table *table)
     +{
     +	const char *name_col_title = _("Repository stats");
     +	const char *value_col_title = _("Value");
     +	size_t name_title_len = strlen(name_col_title);
     +	size_t value_title_len = strlen(value_col_title);
    -+	struct strbuf buf = STRBUF_INIT;
     +	struct string_list_item *item;
     +	int name_col_width;
     +	int value_col_width;
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	value_col_width = cast_size_t_to_int(
     +		max_size_t(table->value_col_width, value_title_len));
     +
    -+	strbuf_addf(&buf, "| %-*s | %-*s |\n", name_col_width, name_col_title,
    -+		    value_col_width, value_col_title);
    -+	strbuf_addstr(&buf, "| ");
    -+	strbuf_addchars(&buf, '-', name_col_width);
    -+	strbuf_addstr(&buf, " | ");
    -+	strbuf_addchars(&buf, '-', value_col_width);
    -+	strbuf_addstr(&buf, " |\n");
    ++	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
    ++	       value_col_width, value_col_title);
    ++	printf("| ");
    ++	for (int i = 0; i < name_col_width; i++)
    ++		putchar('-');
    ++	printf(" | ");
    ++	for (int i = 0; i < value_col_width; i++)
    ++		putchar('-');
    ++	printf(" |\n");
     +
     +	for_each_string_list_item(item, &table->rows) {
     +		struct stats_table_entry *entry = item->util;
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +			value = entry->value;
     +		}
     +
    -+		strbuf_addf(&buf, "| %-*s | %*s |\n", name_col_width,
    -+			    item->string, value_col_width, value);
    ++		printf("| %-*s | %*s |\n", name_col_width, item->string,
    ++		       value_col_width, value);
     +	}
    -+
    -+	fputs(buf.buf, stdout);
    -+	strbuf_release(&buf);
     +}
     +
     +static void stats_table_clear(struct stats_table *table)
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	}
     +}
     +
    -+static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
    -+			  const char *prefix UNUSED, struct repository *repo UNUSED)
    ++static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    ++			  struct repository *repo UNUSED)
     +{
     +	struct ref_filter filter = REF_FILTER_INIT;
     +	struct stats_table table = {
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
     +	};
     +	struct ref_stats stats = { 0 };
     +	struct ref_array refs = { 0 };
    ++	struct option options[] = { 0 };
    ++
    ++	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
    ++	if (argc)
    ++		usage(_("too many arguments"));
     +
     +	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
     +		die(_("unable to filter refs"));
4:  2832670e82 ! 5:  ab27340d58 builtin/repo: add object counts in stats output
    @@ builtin/repo.c: struct ref_stats {
      struct stats_table {
      	struct string_list rows;
      
    -@@ builtin/repo.c: static void stats_table_add_count(struct stats_table *table, const char *format,
    - 	stats_table_add(table, format, name, entry);
    +@@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, size_t value,
    + 	va_end(ap);
      }
      
     -static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
    -+static void stats_table_setup(struct stats_table *table, struct repo_stats *stats)
    ++static inline size_t get_total_object_count(struct object_stats *stats)
      {
    ++	return stats->tags + stats->commits + stats->trees + stats->blobs;
    ++}
    ++
    ++static void stats_table_setup(struct stats_table *table, struct repo_stats *stats)
    ++{
     +	struct object_stats *objects = &stats->objects;
     +	struct ref_stats *refs = &stats->refs;
     +	size_t object_total;
    @@ builtin/repo.c: static void stats_table_add_count(struct stats_table *table, con
      
      	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
     @@ builtin/repo.c: static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
    - 	stats_table_add_count(table, "    * %s", _("Tags"), refs->tags);
    - 	stats_table_add_count(table, "    * %s", _("Remotes"), refs->remotes);
    - 	stats_table_add_count(table, "    * %s", _("Others"), refs->others);
    + 	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
    + 	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
    + 	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
     +
    -+	object_total = objects->commits + objects->trees + objects->blobs + objects->tags;
    -+	stats_table_add(table, "%s", "", NULL);
    -+	stats_table_add(table, "* %s", _("Reachable objects"), NULL);
    -+	stats_table_add_count(table, "  * %s", _("Count"), object_total);
    -+	stats_table_add_count(table, "    * %s", _("Commits"), objects->commits);
    -+	stats_table_add_count(table, "    * %s", _("Trees"), objects->trees);
    -+	stats_table_add_count(table, "    * %s", _("Blobs"), objects->blobs);
    -+	stats_table_add_count(table, "    * %s", _("Tags"), objects->tags);
    ++	object_total = get_total_object_count(objects);
    ++	stats_table_addf(table, "");
    ++	stats_table_addf(table, "* %s", _("Reachable objects"));
    ++	stats_table_count_addf(table, object_total, "  * %s", _("Count"));
    ++	stats_table_count_addf(table, objects->commits, "    * %s", _("Commits"));
    ++	stats_table_count_addf(table, objects->trees, "    * %s", _("Trees"));
    ++	stats_table_count_addf(table, objects->blobs, "    * %s", _("Blobs"));
    ++	stats_table_count_addf(table, objects->tags, "    * %s", _("Tags"));
      }
      
      static inline size_t max_size_t(size_t a, size_t b)
    @@ builtin/repo.c: static void stats_count_references(struct ref_stats *stats, stru
     +	path_walk_info_clear(&info);
     +}
     +
    - static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
    --			  const char *prefix UNUSED, struct repository *repo UNUSED)
    -+			  const char *prefix, struct repository *repo)
    + static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    +-			  struct repository *repo UNUSED)
    ++			  struct repository *repo)
      {
      	struct ref_filter filter = REF_FILTER_INIT;
      	struct stats_table table = {
    @@ builtin/repo.c: static void stats_count_references(struct ref_stats *stats, stru
     +	struct repo_stats stats = { 0 };
      	struct ref_array refs = { 0 };
     +	struct rev_info revs;
    + 	struct option options[] = { 0 };
    + 
    + 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
    + 	if (argc)
    + 		usage(_("too many arguments"));
      
     +	repo_init_revisions(repo, &revs, prefix);
      	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
5:  5d1adf7905 ! 6:  f69110224d builtin/repo: add keyvalue and nul format for stats
    @@ Documentation/git-repo.adoc: supported:
     +supported:
     ++
     +`table`:::
    -+	Outputs repository stats in a human-friendly table and is used by
    -+	default. This format may change and is not intended for machine
    -+	parsing.
    ++	Outputs repository stats in a human-friendly table. This format may
    ++	change and is not intended for machine parsing. This is the default
    ++	format.
     +
     +`keyvalue`:::
     +	Each line of output contains a key-value pair for a repository stat.
    @@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
     +static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
     +				 char value_delim)
     +{
    -+	struct strbuf buf = STRBUF_INIT;
    ++	printf("references.branches.count%c%" PRIuMAX "%c", key_delim,
    ++	       (uintmax_t)stats->refs.branches, value_delim);
    ++	printf("references.tags.count%c%" PRIuMAX "%c", key_delim,
    ++	       (uintmax_t)stats->refs.tags, value_delim);
    ++	printf("references.remotes.count%c%" PRIuMAX "%c", key_delim,
    ++	       (uintmax_t)stats->refs.remotes, value_delim);
    ++	printf("references.others.count%c%" PRIuMAX "%c", key_delim,
    ++	       (uintmax_t)stats->refs.others, value_delim);
     +
    -+	strbuf_addf(&buf, "references.branches.count%c%" PRIuMAX "%c",
    -+		    key_delim, (uintmax_t)stats->refs.branches, value_delim);
    -+	strbuf_addf(&buf, "references.tags.count%c%" PRIuMAX "%c",
    -+		    key_delim, (uintmax_t)stats->refs.tags, value_delim);
    -+	strbuf_addf(&buf, "references.remotes.count%c%" PRIuMAX "%c",
    -+		    key_delim, (uintmax_t)stats->refs.remotes, value_delim);
    -+	strbuf_addf(&buf, "references.others.count%c%" PRIuMAX "%c",
    -+		    key_delim, (uintmax_t)stats->refs.others, value_delim);
    ++	printf("objects.commits.count%c%" PRIuMAX "%c", key_delim,
    ++	       (uintmax_t)stats->objects.commits, value_delim);
    ++	printf("objects.trees.count%c%" PRIuMAX "%c", key_delim,
    ++	       (uintmax_t)stats->objects.trees, value_delim);
    ++	printf("objects.blobs.count%c%" PRIuMAX "%c", key_delim,
    ++	       (uintmax_t)stats->objects.blobs, value_delim);
    ++	printf("objects.tags.count%c%" PRIuMAX "%c", key_delim,
    ++	       (uintmax_t)stats->objects.tags, value_delim);
     +
    -+	strbuf_addf(&buf, "objects.commits.count%c%" PRIuMAX "%c",
    -+		    key_delim, (uintmax_t)stats->objects.commits, value_delim);
    -+	strbuf_addf(&buf, "objects.trees.count%c%" PRIuMAX "%c",
    -+		    key_delim, (uintmax_t)stats->objects.trees, value_delim);
    -+	strbuf_addf(&buf, "objects.blobs.count%c%" PRIuMAX "%c",
    -+		    key_delim, (uintmax_t)stats->objects.blobs, value_delim);
    -+	strbuf_addf(&buf, "objects.tags.count%c%" PRIuMAX "%c",
    -+		    key_delim, (uintmax_t)stats->objects.tags, value_delim);
    -+
    -+	fwrite(buf.buf, sizeof(char), buf.len, stdout);
    -+	strbuf_release(&buf);
    ++	fflush(stdout);
     +}
     +
      static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
      {
      	for (int i = 0; i < refs->nr; i++) {
    -@@ builtin/repo.c: static void stats_count_objects(struct object_stats *stats,
    - 	path_walk_info_clear(&info);
    - }
    - 
    --static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
    --			  const char *prefix, struct repository *repo)
    -+static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
    -+			  struct repository *repo)
    - {
    - 	struct ref_filter filter = REF_FILTER_INIT;
    +@@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
      	struct stats_table table = {
      		.rows = STRING_LIST_INIT_DUP,
      	};
    @@ builtin/repo.c: static void stats_count_objects(struct object_stats *stats,
      	struct repo_stats stats = { 0 };
      	struct ref_array refs = { 0 };
      	struct rev_info revs;
    +-	struct option options[] = { 0 };
     +	struct option options[] = {
     +		OPT_CALLBACK_F(0, "format", &format, N_("format"),
     +			       N_("output format"),
    @@ builtin/repo.c: static void stats_count_objects(struct object_stats *stats,
     +		OPT_END()
     +	};
      
    -+	parse_options(argc, argv, prefix, options, repo_usage, 0);
    - 	repo_init_revisions(repo, &revs, prefix);
    - 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
    - 		die(_("unable to filter refs"));
    -@@ builtin/repo.c: static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
    + 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
    + 	if (argc)
    +@@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
      	stats_count_references(&stats.refs, &refs);
      	stats_count_objects(&stats.objects, &refs, &revs);
      
    @@ t/t1901-repo-stats.sh: test_expect_success 'repository with references and objec
      	)
      '
      
    -+test_expect_success 'repository stats with keyvalue and nul format' '
    ++test_expect_success 'keyvalue and nul format' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t1901-repo-stats.sh: test_expect_success 'repository with references and objec
     +		test_line_count = 0 err &&
     +
     +		# Replace key and value delimiters for nul format.
    -+		tr "\n" "\0" <expect | tr "=" "\n" >expect_null &&
    ++		tr "\n=" "\0\n" <expect >expect_nul &&
     +		git repo stats --format=nul >out 2>err &&
     +
    -+		test_cmp expect_null out &&
    ++		test_cmp expect_nul out &&
     +		test_line_count = 0 err
     +	)
     +'
6:  2a745c8417 ! 7:  cff5e183bb builtin/repo: add progress meter for stats
    @@ builtin/repo.c
      #include "ref-filter.h"
      #include "refs.h"
     @@ builtin/repo.c: static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
    - 	strbuf_release(&buf);
    + 	fflush(stdout);
      }
      
     -static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
    @@ builtin/repo.c: static void stats_keyvalue_print(struct repo_stats *stats, char
     +	struct progress *progress = NULL;
     +
     +	if (show_progress)
    -+		progress = start_progress(repo, _("Counting references"), refs->nr);
    ++		progress = start_delayed_progress(repo, _("Counting references"),
    ++						  refs->nr);
     +
      	for (int i = 0; i < refs->nr; i++) {
      		struct ref_array_item *ref = refs->items[i];
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
      		BUG("invalid object type");
      	}
      
    -+	object_count = stats->tags + stats->commits + stats->trees + stats->blobs;
    ++	object_count = get_total_object_count(stats);
     +	display_progress(data->progress, object_count);
     +
      	return 0;
    @@ builtin/repo.c: static void stats_count_objects(struct object_stats *stats,
      	}
      
     +	if (show_progress)
    -+		data.progress = start_progress(repo, _("Counting Objects"), 0);
    ++		data.progress = start_delayed_progress(repo, _("Counting objects"), 0);
     +
      	walk_objects_by_path(&info);
      	path_walk_info_clear(&info);
    @@ builtin/repo.c: static int cmd_repo_stats(int argc, const char **argv, const cha
      
      	switch (format) {
      	case FORMAT_TABLE:
    +
    + ## t/t1901-repo-stats.sh ##
    +@@ t/t1901-repo-stats.sh: test_expect_success 'keyvalue and nul format' '
    + 	)
    + '
    + 
    ++test_expect_success 'progress meter option' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit foo &&
    ++
    ++		GIT_PROGRESS_DELAY=0 git repo stats --progress >out 2>err &&
    ++
    ++		test_file_not_empty out &&
    ++		test_grep "Counting references: 100% (2/2), done." err &&
    ++		test_grep "Counting objects: 3, done." err &&
    ++
    ++		GIT_PROGRESS_DELAY=0 git repo stats --no-progress >out 2>err &&
    ++
    ++		test_file_not_empty out &&
    ++		test_line_count = 0 err
    ++	)
    ++'
    ++
    + test_done

base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.51.0.193.g4975ec3473b

