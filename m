Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FA6520437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbdJaSTp (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:19:45 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:51065 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdJaSTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:19:31 -0400
Received: by mail-pg0-f45.google.com with SMTP id y5so15351755pgq.7
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wp/OAKldDQrg/yXgisifHmRjBJJ06jRzmhFwISOGXfQ=;
        b=HD9+CTTnZ24pjfyIi2AojzwTPcZ6p/zEPa5QOlJevKQJslA4Ms72riM1RXdLqxkEpP
         O3sVw5iDFbd05CcMSUz6MH5BS8LSquIY5ka8HVdxyb9urxJOXLYnJHd7GOGVnF+Hrswz
         ejclXvuKdj9XYgYntNJhoYxqVyOn+Z64xoXkjO2cZWaIZyz/H4JrCBEWBc9FLN6hiX2c
         UzrzbDjH1sbtwH/yiTmeQTG5+H2OZXHPIoKs962awmwbiiclWRzeY1Ek/KWbKZj6wAA0
         auNhrU74Zm7gUTz0K4LAPQexI6MztWWvoxwX1L8HtLkYZJKPi2r2DNx8P2cmYT6WHpD0
         pnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wp/OAKldDQrg/yXgisifHmRjBJJ06jRzmhFwISOGXfQ=;
        b=F6guG9DjgujdGQOXl7mgfXOLCrSyWo7dWMxdjXypayYYvnNg0AbmmEagmxX7RCQJoj
         G8y1oKubcmIGQ7FkV0QFmVFyMwteVr2MhUItK4YGL341rc0woQ8F8fEoX/OjmOrLoPqa
         3g+yDSvwxRF+AViFI9ouJi/QpckMaOeWFHxgJRwIBPPboCh48/GtgRQCRziIk7AL8Aq/
         uSs8tr5zns98cUmRNrtltdN668Xsn8//95JK8W1O5Qr7iH5X47AUjDmYsNuPtqTvbBxZ
         XIzU6ngr0XLIhSmbhPSNoQGlTvZkFC9KIOm+o/Lh/rQd91N5BTljn8fODZbK3F9NybrF
         zbNQ==
X-Gm-Message-State: AMCzsaWJYA5tIGFMsrNWlshrL38+u+PrVbq4Fl+OVNhTJGe9SNcV+rak
        wygkFNcTNeLwW05d4CkOLrpvPDYISoI=
X-Google-Smtp-Source: ABhQp+T4+0fs/5Rbq9YFfhupH93ODgjDaI2dgL/o799/1sRxOhCIfFKTXdaJL9itBIum6kfP+4l09g==
X-Received: by 10.99.123.71 with SMTP id k7mr2600763pgn.312.1509473969551;
        Tue, 31 Oct 2017 11:19:29 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id a78sm4308985pfl.122.2017.10.31.11.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:19:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 8/8] diff: make struct diff_flags members lowercase
Date:   Tue, 31 Oct 2017 11:19:11 -0700
Message-Id: <20171031181911.42687-9-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171031181911.42687-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com>
 <20171031181911.42687-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the flags stored in struct diff_flags are being accessed
directly and not through macros, change all struct members from being
uppercase to lowercase.
This conversion is done using the following semantic patch:

	@@
	expression E;
	@@
	- E.RECURSIVE
	+ E.recursive

	@@
	expression E;
	@@
	- E.TREE_IN_RECURSIVE
	+ E.tree_in_recursive

	@@
	expression E;
	@@
	- E.BINARY
	+ E.binary

	@@
	expression E;
	@@
	- E.TEXT
	+ E.text

	@@
	expression E;
	@@
	- E.FULL_INDEX
	+ E.full_index

	@@
	expression E;
	@@
	- E.SILENT_ON_REMOVE
	+ E.silent_on_remove

	@@
	expression E;
	@@
	- E.FIND_COPIES_HARDER
	+ E.find_copies_harder

	@@
	expression E;
	@@
	- E.FOLLOW_RENAMES
	+ E.follow_renames

	@@
	expression E;
	@@
	- E.RENAME_EMPTY
	+ E.rename_empty

	@@
	expression E;
	@@
	- E.HAS_CHANGES
	+ E.has_changes

	@@
	expression E;
	@@
	- E.QUICK
	+ E.quick

	@@
	expression E;
	@@
	- E.NO_INDEX
	+ E.no_index

	@@
	expression E;
	@@
	- E.ALLOW_EXTERNAL
	+ E.allow_external

	@@
	expression E;
	@@
	- E.EXIT_WITH_STATUS
	+ E.exit_with_status

	@@
	expression E;
	@@
	- E.REVERSE_DIFF
	+ E.reverse_diff

	@@
	expression E;
	@@
	- E.CHECK_FAILED
	+ E.check_failed

	@@
	expression E;
	@@
	- E.RELATIVE_NAME
	+ E.relative_name

	@@
	expression E;
	@@
	- E.IGNORE_SUBMODULES
	+ E.ignore_submodules

	@@
	expression E;
	@@
	- E.DIRSTAT_CUMULATIVE
	+ E.dirstat_cumulative

	@@
	expression E;
	@@
	- E.DIRSTAT_BY_FILE
	+ E.dirstat_by_file

	@@
	expression E;
	@@
	- E.ALLOW_TEXTCONV
	+ E.allow_textconv

	@@
	expression E;
	@@
	- E.TEXTCONV_SET_VIA_CMDLINE
	+ E.textconv_set_via_cmdline

	@@
	expression E;
	@@
	- E.DIFF_FROM_CONTENTS
	+ E.diff_from_contents

	@@
	expression E;
	@@
	- E.DIRTY_SUBMODULES
	+ E.dirty_submodules

	@@
	expression E;
	@@
	- E.IGNORE_UNTRACKED_IN_SUBMODULES
	+ E.ignore_untracked_in_submodules

	@@
	expression E;
	@@
	- E.IGNORE_DIRTY_SUBMODULES
	+ E.ignore_dirty_submodules

	@@
	expression E;
	@@
	- E.OVERRIDE_SUBMODULE_CONFIG
	+ E.override_submodule_config

	@@
	expression E;
	@@
	- E.DIRSTAT_BY_LINE
	+ E.dirstat_by_line

	@@
	expression E;
	@@
	- E.FUNCCONTEXT
	+ E.funccontext

	@@
	expression E;
	@@
	- E.PICKAXE_IGNORE_CASE
	+ E.pickaxe_ignore_case

	@@
	expression E;
	@@
	- E.DEFAULT_FOLLOW_RENAMES
	+ E.default_follow_renames

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 blame.c               |  16 ++---
 builtin/add.c         |   4 +-
 builtin/am.c          |  10 +--
 builtin/blame.c       |  10 +--
 builtin/commit.c      |   4 +-
 builtin/diff.c        |   8 +--
 builtin/fast-export.c |   2 +-
 builtin/log.c         |  26 ++++----
 builtin/reset.c       |   2 +-
 builtin/rev-list.c    |   2 +-
 combine-diff.c        |  10 +--
 diff-lib.c            |  22 +++----
 diff-no-index.c       |   8 +--
 diff.c                | 170 +++++++++++++++++++++++++-------------------------
 diff.h                |  62 +++++++++---------
 diffcore-pickaxe.c    |   8 +--
 diffcore-rename.c     |   6 +-
 log-tree.c            |   2 +-
 merge-recursive.c     |   4 +-
 notes-merge.c         |   4 +-
 patch-ids.c           |   2 +-
 revision.c            |  24 +++----
 submodule.c           |  16 ++---
 tree-diff.c           |  16 ++---
 wt-status.c           |  18 +++---
 25 files changed, 228 insertions(+), 228 deletions(-)

diff --git a/blame.c b/blame.c
index dc9cc237b..28e03726f 100644
--- a/blame.c
+++ b/blame.c
@@ -209,7 +209,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
-			if (opt->flags.ALLOW_TEXTCONV &&
+			if (opt->flags.allow_textconv &&
 			    textconv_object(read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
@@ -293,7 +293,7 @@ static void fill_origin_blob(struct diff_options *opt,
 		unsigned long file_size;
 
 		(*num_read_blob)++;
-		if (opt->flags.ALLOW_TEXTCONV &&
+		if (opt->flags.allow_textconv &&
 		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
 			;
 		else
@@ -541,7 +541,7 @@ static struct blame_origin *find_origin(struct commit *parent,
 	 * same and diff-tree is fairly efficient about this.
 	 */
 	diff_setup(&diff_opts);
-	diff_opts.flags.RECURSIVE = 1;
+	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	paths[0] = origin->path;
@@ -615,7 +615,7 @@ static struct blame_origin *find_rename(struct commit *parent,
 	int i;
 
 	diff_setup(&diff_opts);
-	diff_opts.flags.RECURSIVE = 1;
+	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = origin->path;
@@ -1238,7 +1238,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 		return; /* nothing remains for this target */
 
 	diff_setup(&diff_opts);
-	diff_opts.flags.RECURSIVE = 1;
+	diff_opts.flags.recursive = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 
 	diff_setup_done(&diff_opts);
@@ -1253,7 +1253,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
 	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
 		&& (!porigin || strcmp(target->path, porigin->path))))
-		diff_opts.flags.FIND_COPIES_HARDER = 1;
+		diff_opts.flags.find_copies_harder = 1;
 
 	if (is_null_oid(&target->commit->object.oid))
 		do_diff_cache(&parent->tree->object.oid, &diff_opts);
@@ -1262,7 +1262,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			      &target->commit->tree->object.oid,
 			      "", &diff_opts);
 
-	if (!diff_opts.flags.FIND_COPIES_HARDER)
+	if (!diff_opts.flags.find_copies_harder)
 		diffcore_std(&diff_opts);
 
 	do {
@@ -1825,7 +1825,7 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 		if (fill_blob_sha1_and_mode(o))
 			die(_("no such path %s in %s"), path, final_commit_name);
 
-		if (sb->revs->diffopt.flags.ALLOW_TEXTCONV &&
+		if (sb->revs->diffopt.flags.allow_textconv &&
 		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
 				    &sb->final_buf_size))
 			;
diff --git a/builtin/add.c b/builtin/add.c
index e1d83b69a..8d08e99e9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -116,7 +116,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
-	rev.diffopt.flags.OVERRIDE_SUBMODULE_CONFIG = 1;
+	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
@@ -218,7 +218,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev.diffopt.use_color = 0;
-	rev.diffopt.flags.IGNORE_DIRTY_SUBMODULES = 1;
+	rev.diffopt.flags.ignore_dirty_submodules = 1;
 	out = open(file, O_CREAT | O_WRONLY, 0666);
 	if (out < 0)
 		die(_("Could not open '%s' for writing."), file);
diff --git a/builtin/am.c b/builtin/am.c
index 015425a0f..b281d58f3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1157,9 +1157,9 @@ static int index_has_changes(struct strbuf *sb)
 		struct diff_options opt;
 
 		diff_setup(&opt);
-		opt.flags.EXIT_WITH_STATUS = 1;
+		opt.flags.exit_with_status = 1;
 		if (!sb)
-			opt.flags.QUICK = 1;
+			opt.flags.quick = 1;
 		do_diff_cache(&head, &opt);
 		diffcore_std(&opt);
 		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
@@ -1168,7 +1168,7 @@ static int index_has_changes(struct strbuf *sb)
 			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
 		}
 		diff_flush(&opt);
-		return opt.flags.HAS_CHANGES != 0;
+		return opt.flags.has_changes != 0;
 	} else {
 		for (i = 0; sb && i < active_nr; i++) {
 			if (i)
@@ -1409,8 +1409,8 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	rev_info.show_root_diff = 1;
 	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev_info.no_commit_id = 1;
-	rev_info.diffopt.flags.BINARY = 1;
-	rev_info.diffopt.flags.FULL_INDEX = 1;
+	rev_info.diffopt.flags.binary = 1;
+	rev_info.diffopt.flags.full_index = 1;
 	rev_info.diffopt.use_color = 0;
 	rev_info.diffopt.file = fp;
 	rev_info.diffopt.close_file = 1;
diff --git a/builtin/blame.c b/builtin/blame.c
index 79db9e849..005f55aaa 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -708,8 +708,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	git_config(git_blame_config, &output_option);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
-	revs.diffopt.flags.ALLOW_TEXTCONV = 1;
-	revs.diffopt.flags.FOLLOW_RENAMES = 1;
+	revs.diffopt.flags.allow_textconv = 1;
+	revs.diffopt.flags.follow_renames = 1;
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
@@ -734,9 +734,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
 	}
 parse_done:
-	no_whole_file_rename = !revs.diffopt.flags.FOLLOW_RENAMES;
+	no_whole_file_rename = !revs.diffopt.flags.follow_renames;
 	xdl_opts |= revs.diffopt.xdl_opts & XDF_INDENT_HEURISTIC;
-	revs.diffopt.flags.FOLLOW_RENAMES = 0;
+	revs.diffopt.flags.follow_renames = 0;
 	argc = parse_options_end(&ctx);
 
 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
@@ -803,7 +803,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 	blame_date_width -= 1; /* strip the null */
 
-	if (revs.diffopt.flags.FIND_COPIES_HARDER)
+	if (revs.diffopt.flags.find_copies_harder)
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
 			PICKAXE_BLAME_COPY_HARDER);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 960e7ac08..0f368ad81 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -913,10 +913,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			 * be really confusing.
 			 */
 			struct diff_flags flags = DIFF_FLAGS_INIT;
-			flags.OVERRIDE_SUBMODULE_CONFIG = 1;
+			flags.override_submodule_config = 1;
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
-				flags.IGNORE_SUBMODULES = 1;
+				flags.ignore_submodules = 1;
 			commitable = index_differs_from(parent, &flags, 1);
 		}
 	}
diff --git a/builtin/diff.c b/builtin/diff.c
index ed41eb5a5..3476e95e1 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -44,7 +44,7 @@ static void stuff_change(struct diff_options *opt,
 	    !oidcmp(old_oid, new_oid) && (old_mode == new_mode))
 		return;
 
-	if (opt->flags.REVERSE_DIFF) {
+	if (opt->flags.reverse_diff) {
 		SWAP(old_mode, new_mode);
 		SWAP(old_oid, new_oid);
 		SWAP(old_path, new_path);
@@ -350,8 +350,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	rev.diffopt.stat_graph_width = -1;
 
 	/* Default to let external and textconv be used */
-	rev.diffopt.flags.ALLOW_EXTERNAL = 1;
-	rev.diffopt.flags.ALLOW_TEXTCONV = 1;
+	rev.diffopt.flags.allow_external = 1;
+	rev.diffopt.flags.allow_textconv = 1;
 
 	if (nongit)
 		die(_("Not a git repository"));
@@ -361,7 +361,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		diff_setup_done(&rev.diffopt);
 	}
 
-	rev.diffopt.flags.RECURSIVE = 1;
+	rev.diffopt.flags.recursive = 1;
 
 	setup_diff_pager(&rev.diffopt);
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 35c8fb65d..72672665b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1066,7 +1066,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
 	revs.diffopt.format_callback_data = &paths_of_changed_objects;
-	revs.diffopt.flags.RECURSIVE = 1;
+	revs.diffopt.flags.recursive = 1;
 	while ((commit = get_revision(&revs))) {
 		if (has_unshown_parent(commit)) {
 			add_object_array(&commit->object, NULL, &commits);
diff --git a/builtin/log.c b/builtin/log.c
index 4a24d3e48..f3d5a02be 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -121,16 +121,16 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
 	if (default_follow)
-		rev->diffopt.flags.DEFAULT_FOLLOW_RENAMES = 1;
+		rev->diffopt.flags.default_follow_renames = 1;
 	rev->verbose_header = 1;
-	rev->diffopt.flags.RECURSIVE = 1;
+	rev->diffopt.flags.recursive = 1;
 	rev->diffopt.stat_width = -1; /* use full terminal width */
 	rev->diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	rev->show_signature = default_show_signature;
-	rev->diffopt.flags.ALLOW_TEXTCONV = 1;
+	rev->diffopt.flags.allow_textconv = 1;
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
@@ -181,7 +181,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    rev->diffopt.flags.FOLLOW_RENAMES)
+	    rev->diffopt.flags.follow_renames)
 		rev->always_show_header = 0;
 
 	if (source)
@@ -391,7 +391,7 @@ static int cmd_log_walk(struct rev_info *rev)
 		fclose(rev->diffopt.file);
 
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
-	    rev->diffopt.flags.CHECK_FAILED) {
+	    rev->diffopt.flags.check_failed) {
 		return 02;
 	}
 	return diff_result_code(&rev->diffopt, 0);
@@ -483,8 +483,8 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	unsigned long size;
 
 	fflush(rev->diffopt.file);
-	if (!rev->diffopt.flags.TEXTCONV_SET_VIA_CMDLINE ||
-	    !rev->diffopt.flags.ALLOW_TEXTCONV)
+	if (!rev->diffopt.flags.textconv_set_via_cmdline ||
+	    !rev->diffopt.flags.allow_textconv)
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
 	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
@@ -666,9 +666,9 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 static void log_setup_revisions_tweak(struct rev_info *rev,
 				      struct setup_revision_opt *opt)
 {
-	if (rev->diffopt.flags.DEFAULT_FOLLOW_RENAMES &&
+	if (rev->diffopt.flags.default_follow_renames &&
 	    rev->prune_data.nr == 1)
-		rev->diffopt.flags.FOLLOW_RENAMES = 1;
+		rev->diffopt.flags.follow_renames = 1;
 
 	/* Turn --cc/-c into -p --cc/-c when -p was not given */
 	if (!rev->diffopt.output_format && rev->combine_merges)
@@ -1340,7 +1340,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		return;
 
 	diff_setup(&diffopt);
-	diffopt.flags.RECURSIVE = 1;
+	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
 
 	oidcpy(&bases->base_commit, &base->object.oid);
@@ -1511,7 +1511,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.verbose_header = 1;
 	rev.diff = 1;
 	rev.max_parents = 1;
-	rev.diffopt.flags.RECURSIVE = 1;
+	rev.diffopt.flags.recursive = 1;
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
@@ -1612,8 +1612,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	rev.zero_commit = zero_commit;
 
-	if (!rev.diffopt.flags.TEXT && !no_binary_diff)
-		rev.diffopt.flags.BINARY = 1;
+	if (!rev.diffopt.flags.text && !no_binary_diff)
+		rev.diffopt.flags.binary = 1;
 
 	if (rev.show_notes)
 		init_display_notes(&rev.notes_opt);
diff --git a/builtin/reset.c b/builtin/reset.c
index 206819ef1..4b313a018 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -166,7 +166,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
-	opt.flags.OVERRIDE_SUBMODULE_CONFIG = 1;
+	opt.flags.override_submodule_config = 1;
 
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c62382171..1d3b6b61b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -294,7 +294,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.bisect)
 		bisect_list = 1;
 
-	if (revs.diffopt.flags.QUICK)
+	if (revs.diffopt.flags.quick)
 		info.flags |= REV_LIST_QUIET;
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/combine-diff.c b/combine-diff.c
index 5a3a8b49b..23f3d25e2 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -898,7 +898,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 int show_file_header)
 {
 	struct diff_options *opt = &rev->diffopt;
-	int abbrev = opt->flags.FULL_INDEX ? GIT_SHA1_HEXSZ : DEFAULT_ABBREV;
+	int abbrev = opt->flags.full_index ? GIT_SHA1_HEXSZ : DEFAULT_ABBREV;
 	const char *a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
 	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
 	const char *c_meta = diff_get_color_opt(opt, DIFF_METAINFO);
@@ -987,7 +987,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	userdiff = userdiff_find_by_path(elem->path);
 	if (!userdiff)
 		userdiff = userdiff_find_by_name("default");
-	if (opt->flags.ALLOW_TEXTCONV)
+	if (opt->flags.allow_textconv)
 		textconv = userdiff_get_textconv(userdiff);
 
 	/* Read the result of merge first */
@@ -1413,8 +1413,8 @@ void diff_tree_combined(const struct object_id *oid,
 
 	diffopts = *opt;
 	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
-	diffopts.flags.RECURSIVE = 1;
-	diffopts.flags.ALLOW_EXTERNAL = 0;
+	diffopts.flags.recursive = 1;
+	diffopts.flags.allow_external = 0;
 
 	/* find set of paths that everybody touches
 	 *
@@ -1435,7 +1435,7 @@ void diff_tree_combined(const struct object_id *oid,
 	 * NOTE please keep this semantically in sync with diffcore_std()
 	 */
 	need_generic_pathscan = opt->skip_stat_unmatch	||
-			opt->flags.FOLLOW_RENAMES	||
+			opt->flags.follow_renames	||
 			opt->break_opt != -1	||
 			opt->detect_rename	||
 			opt->pickaxe		||
diff --git a/diff-lib.c b/diff-lib.c
index f1cc3fd51..d373358a5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -72,14 +72,14 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	int changed = ce_match_stat(ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.OVERRIDE_SUBMODULE_CONFIG)
+		if (!diffopt->flags.override_submodule_config)
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (diffopt->flags.IGNORE_SUBMODULES)
+		if (diffopt->flags.ignore_submodules)
 			changed = 0;
-		else if (!diffopt->flags.IGNORE_DIRTY_SUBMODULES &&
-			 (!changed || diffopt->flags.DIRTY_SUBMODULES))
+		else if (!diffopt->flags.ignore_dirty_submodules &&
+			 (!changed || diffopt->flags.dirty_submodules))
 			*dirty_submodule = is_submodule_modified(ce->name,
-								 diffopt->flags.IGNORE_UNTRACKED_IN_SUBMODULES);
+								 diffopt->flags.ignore_untracked_in_submodules);
 		diffopt->flags = orig_flags;
 	}
 	return changed;
@@ -229,7 +229,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
-			if (!revs->diffopt.flags.FIND_COPIES_HARDER)
+			if (!revs->diffopt.flags.find_copies_harder)
 				continue;
 		}
 		oldmode = ce->ce_mode;
@@ -363,7 +363,7 @@ static int show_modified(struct rev_info *revs,
 
 	oldmode = old->ce_mode;
 	if (mode == oldmode && !oidcmp(oid, &old->oid) && !dirty_submodule &&
-	    !revs->diffopt.flags.FIND_COPIES_HARDER)
+	    !revs->diffopt.flags.find_copies_harder)
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
@@ -494,7 +494,7 @@ static int diff_cache(struct rev_info *revs,
 	opts.head_idx = 1;
 	opts.index_only = cached;
 	opts.diff_index_cached = (cached &&
-				  !revs->diffopt.flags.FIND_COPIES_HARDER);
+				  !revs->diffopt.flags.find_copies_harder);
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
@@ -545,12 +545,12 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
 	memset(&opt, 0, sizeof(opt));
 	opt.def = def;
 	setup_revisions(0, NULL, &rev, &opt);
-	rev.diffopt.flags.QUICK = 1;
-	rev.diffopt.flags.EXIT_WITH_STATUS = 1;
+	rev.diffopt.flags.quick = 1;
+	rev.diffopt.flags.exit_with_status = 1;
 	if (flags)
 		diff_flags_or(&rev.diffopt.flags, flags);
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	object_array_clear(&rev.pending);
-	return (rev.diffopt.flags.HAS_CHANGES != 0);
+	return (rev.diffopt.flags.has_changes != 0);
 }
diff --git a/diff-no-index.c b/diff-no-index.c
index a3e194340..0ed5f0f49 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -184,7 +184,7 @@ static int queue_diff(struct diff_options *o,
 	} else {
 		struct diff_filespec *d1, *d2;
 
-		if (o->flags.REVERSE_DIFF) {
+		if (o->flags.reverse_diff) {
 			SWAP(mode1, mode2);
 			SWAP(name1, name2);
 		}
@@ -276,16 +276,16 @@ void diff_no_index(struct rev_info *revs,
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	revs->diffopt.flags.NO_INDEX = 1;
+	revs->diffopt.flags.no_index = 1;
 
-	revs->diffopt.flags.RELATIVE_NAME = 1;
+	revs->diffopt.flags.relative_name = 1;
 	revs->diffopt.prefix = prefix;
 
 	revs->max_count = -2;
 	diff_setup_done(&revs->diffopt);
 
 	setup_diff_pager(&revs->diffopt);
-	revs->diffopt.flags.EXIT_WITH_STATUS = 1;
+	revs->diffopt.flags.exit_with_status = 1;
 
 	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
 		exit(1);
diff --git a/diff.c b/diff.c
index e5f9d3078..5714382d3 100644
--- a/diff.c
+++ b/diff.c
@@ -124,18 +124,18 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	for (i = 0; i < params.nr; i++) {
 		const char *p = params.items[i].string;
 		if (!strcmp(p, "changes")) {
-			options->flags.DIRSTAT_BY_LINE = 0;
-			options->flags.DIRSTAT_BY_FILE = 0;
+			options->flags.dirstat_by_line = 0;
+			options->flags.dirstat_by_file = 0;
 		} else if (!strcmp(p, "lines")) {
-			options->flags.DIRSTAT_BY_LINE = 1;
-			options->flags.DIRSTAT_BY_FILE = 0;
+			options->flags.dirstat_by_line = 1;
+			options->flags.dirstat_by_file = 0;
 		} else if (!strcmp(p, "files")) {
-			options->flags.DIRSTAT_BY_LINE = 0;
-			options->flags.DIRSTAT_BY_FILE = 1;
+			options->flags.dirstat_by_line = 0;
+			options->flags.dirstat_by_file = 1;
 		} else if (!strcmp(p, "noncumulative")) {
-			options->flags.DIRSTAT_CUMULATIVE = 0;
+			options->flags.dirstat_cumulative = 0;
 		} else if (!strcmp(p, "cumulative")) {
-			options->flags.DIRSTAT_CUMULATIVE = 1;
+			options->flags.dirstat_cumulative = 1;
 		} else if (isdigit(*p)) {
 			char *end;
 			int permille = strtoul(p, &end, 10) * 10;
@@ -1481,7 +1481,7 @@ static void emit_rewrite_diff(const char *name_a,
 	struct emit_callback ecbdata;
 	struct strbuf out = STRBUF_INIT;
 
-	if (diff_mnemonic_prefix && o->flags.REVERSE_DIFF) {
+	if (diff_mnemonic_prefix && o->flags.reverse_diff) {
 		a_prefix = o->b_prefix;
 		b_prefix = o->a_prefix;
 	} else {
@@ -2729,7 +2729,7 @@ static void show_dirstat(struct diff_options *options)
 	dir.alloc = 0;
 	dir.nr = 0;
 	dir.permille = options->dirstat_permille;
-	dir.cumulative = options->flags.DIRSTAT_CUMULATIVE;
+	dir.cumulative = options->flags.dirstat_cumulative;
 
 	changed = 0;
 	for (i = 0; i < q->nr; i++) {
@@ -2755,7 +2755,7 @@ static void show_dirstat(struct diff_options *options)
 			goto found_damage;
 		}
 
-		if (options->flags.DIRSTAT_BY_FILE) {
+		if (options->flags.dirstat_by_file) {
 			/*
 			 * In --dirstat-by-file mode, we don't really need to
 			 * look at the actual file contents at all.
@@ -2830,7 +2830,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 	dir.alloc = 0;
 	dir.nr = 0;
 	dir.permille = options->dirstat_permille;
-	dir.cumulative = options->flags.DIRSTAT_CUMULATIVE;
+	dir.cumulative = options->flags.dirstat_cumulative;
 
 	changed = 0;
 	for (i = 0; i < data->nr; i++) {
@@ -3117,7 +3117,7 @@ static void builtin_diff(const char *name_a,
 	const char *line_prefix = diff_line_prefix(o);
 
 	diff_set_mnemonic_prefix(o, "a/", "b/");
-	if (o->flags.REVERSE_DIFF) {
+	if (o->flags.reverse_diff) {
 		a_prefix = o->b_prefix;
 		b_prefix = o->a_prefix;
 	} else {
@@ -3141,7 +3141,7 @@ static void builtin_diff(const char *name_a,
 		return;
 	}
 
-	if (o->flags.ALLOW_TEXTCONV) {
+	if (o->flags.allow_textconv) {
 		textconv_one = get_textconv(one);
 		textconv_two = get_textconv(two);
 	}
@@ -3201,13 +3201,13 @@ static void builtin_diff(const char *name_a,
 				 header.len, 0);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
-	} else if (!o->flags.TEXT &&
+	} else if (!o->flags.text &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
 		struct strbuf sb = STRBUF_INIT;
 		if (!one->data && !two->data &&
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
-		    !o->flags.BINARY) {
+		    !o->flags.binary) {
 			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
 					emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
@@ -3236,7 +3236,7 @@ static void builtin_diff(const char *name_a,
 		}
 		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf, header.len, 0);
 		strbuf_reset(&header);
-		if (o->flags.BINARY)
+		if (o->flags.binary)
 			emit_binary_diff(o, &mf1, &mf2);
 		else {
 			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
@@ -3282,7 +3282,7 @@ static void builtin_diff(const char *name_a,
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
-		if (o->flags.FUNCCONTEXT)
+		if (o->flags.funccontext)
 			xecfg.flags |= XDL_EMIT_FUNCCONTEXT;
 		if (pe)
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
@@ -3447,7 +3447,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	if (data.status)
-		o->flags.CHECK_FAILED = 1;
+		o->flags.check_failed = 1;
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
@@ -3941,9 +3941,9 @@ static void fill_metainfo(struct strbuf *msg,
 		*must_show_header = 0;
 	}
 	if (one && two && oidcmp(&one->oid, &two->oid)) {
-		int abbrev = o->flags.FULL_INDEX ? 40 : DEFAULT_ABBREV;
+		int abbrev = o->flags.full_index ? 40 : DEFAULT_ABBREV;
 
-		if (o->flags.BINARY) {
+		if (o->flags.binary) {
 			mmfile_t mf;
 			if ((!fill_mmfile(&mf, one) && diff_filespec_is_binary(one)) ||
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
@@ -3973,7 +3973,7 @@ static void run_diff_cmd(const char *pgm,
 	int must_show_header = 0;
 
 
-	if (o->flags.ALLOW_EXTERNAL) {
+	if (o->flags.allow_external) {
 		struct userdiff_driver *drv = userdiff_find_by_path(attr_path);
 		if (drv && drv->external)
 			pgm = drv->external;
@@ -4053,7 +4053,7 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	if (!o->flags.ALLOW_EXTERNAL)
+	if (!o->flags.allow_external)
 		pgm = NULL;
 
 	if (DIFF_PAIR_UNMERGED(p)) {
@@ -4152,7 +4152,7 @@ void diff_setup(struct diff_options *options)
 	options->context = diff_context_default;
 	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
-	options->flags.RENAME_EMPTY = 1;
+	options->flags.rename_empty = 1;
 
 	/* pathchange left =NULL by default */
 	options->change = diff_change;
@@ -4203,14 +4203,14 @@ void diff_setup_done(struct diff_options *options)
 	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
 	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
 	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
-		options->flags.DIFF_FROM_CONTENTS = 1;
+		options->flags.diff_from_contents = 1;
 	else
-		options->flags.DIFF_FROM_CONTENTS = 0;
+		options->flags.diff_from_contents = 0;
 
-	if (options->flags.FIND_COPIES_HARDER)
+	if (options->flags.find_copies_harder)
 		options->detect_rename = DIFF_DETECT_COPY;
 
-	if (!options->flags.RELATIVE_NAME)
+	if (!options->flags.relative_name)
 		options->prefix = NULL;
 	if (options->prefix)
 		options->prefix_length = strlen(options->prefix);
@@ -4240,18 +4240,18 @@ void diff_setup_done(struct diff_options *options)
 				      DIFF_FORMAT_DIRSTAT |
 				      DIFF_FORMAT_SUMMARY |
 				      DIFF_FORMAT_CHECKDIFF))
-		options->flags.RECURSIVE = 1;
+		options->flags.recursive = 1;
 	/*
 	 * Also pickaxe would not work very well if you do not say recursive
 	 */
 	if (options->pickaxe)
-		options->flags.RECURSIVE = 1;
+		options->flags.recursive = 1;
 	/*
 	 * When patches are generated, submodules diffed against the work tree
 	 * must be checked for dirtiness too so it can be shown in the output
 	 */
 	if (options->output_format & DIFF_FORMAT_PATCH)
-		options->flags.DIRTY_SUBMODULES = 1;
+		options->flags.dirty_submodules = 1;
 
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
@@ -4273,14 +4273,14 @@ void diff_setup_done(struct diff_options *options)
 	 * to have found.  It does not make sense not to return with
 	 * exit code in such a case either.
 	 */
-	if (options->flags.QUICK) {
+	if (options->flags.quick) {
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
-		options->flags.EXIT_WITH_STATUS = 1;
+		options->flags.exit_with_status = 1;
 	}
 
 	options->diff_path_counter = 0;
 
-	if (options->flags.FOLLOW_RENAMES && options->pathspec.nr != 1)
+	if (options->flags.follow_renames && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
 
 	if (!options->use_color || external_diff())
@@ -4630,7 +4630,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (starts_with(arg, "-C") || starts_with(arg, "--find-copies=") ||
 		 !strcmp(arg, "--find-copies")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
-			options->flags.FIND_COPIES_HARDER = 1;
+			options->flags.find_copies_harder = 1;
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -C: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_COPY;
@@ -4638,13 +4638,13 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
 	else if (!strcmp(arg, "--rename-empty"))
-		options->flags.RENAME_EMPTY = 1;
+		options->flags.rename_empty = 1;
 	else if (!strcmp(arg, "--no-rename-empty"))
-		options->flags.RENAME_EMPTY = 0;
+		options->flags.rename_empty = 0;
 	else if (!strcmp(arg, "--relative"))
-		options->flags.RELATIVE_NAME = 1;
+		options->flags.relative_name = 1;
 	else if (skip_prefix(arg, "--relative=", &arg)) {
-		options->flags.RELATIVE_NAME = 1;
+		options->flags.relative_name = 1;
 		options->prefix = arg;
 	}
 
@@ -4684,21 +4684,21 @@ int diff_opt_parse(struct diff_options *options,
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
 		enable_patch_output(&options->output_format);
-		options->flags.BINARY = 1;
+		options->flags.binary = 1;
 	}
 	else if (!strcmp(arg, "--full-index"))
-		options->flags.FULL_INDEX = 1;
+		options->flags.full_index = 1;
 	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
-		options->flags.TEXT = 1;
+		options->flags.text = 1;
 	else if (!strcmp(arg, "-R"))
-		options->flags.REVERSE_DIFF = 1;
+		options->flags.reverse_diff = 1;
 	else if (!strcmp(arg, "--find-copies-harder"))
-		options->flags.FIND_COPIES_HARDER = 1;
+		options->flags.find_copies_harder = 1;
 	else if (!strcmp(arg, "--follow"))
-		options->flags.FOLLOW_RENAMES = 1;
+		options->flags.follow_renames = 1;
 	else if (!strcmp(arg, "--no-follow")) {
-		options->flags.FOLLOW_RENAMES = 0;
-		options->flags.DEFAULT_FOLLOW_RENAMES = 0;
+		options->flags.follow_renames = 0;
+		options->flags.default_follow_renames = 0;
 	} else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
 	else if (skip_prefix(arg, "--color=", &arg)) {
@@ -4755,23 +4755,23 @@ int diff_opt_parse(struct diff_options *options,
 		return argcount;
 	}
 	else if (!strcmp(arg, "--exit-code"))
-		options->flags.EXIT_WITH_STATUS = 1;
+		options->flags.exit_with_status = 1;
 	else if (!strcmp(arg, "--quiet"))
-		options->flags.QUICK = 1;
+		options->flags.quick = 1;
 	else if (!strcmp(arg, "--ext-diff"))
-		options->flags.ALLOW_EXTERNAL = 1;
+		options->flags.allow_external = 1;
 	else if (!strcmp(arg, "--no-ext-diff"))
-		options->flags.ALLOW_EXTERNAL = 0;
+		options->flags.allow_external = 0;
 	else if (!strcmp(arg, "--textconv")) {
-		options->flags.ALLOW_TEXTCONV = 1;
-		options->flags.TEXTCONV_SET_VIA_CMDLINE = 1;
+		options->flags.allow_textconv = 1;
+		options->flags.textconv_set_via_cmdline = 1;
 	} else if (!strcmp(arg, "--no-textconv"))
-		options->flags.ALLOW_TEXTCONV = 0;
+		options->flags.allow_textconv = 0;
 	else if (!strcmp(arg, "--ignore-submodules")) {
-		options->flags.OVERRIDE_SUBMODULE_CONFIG = 1;
+		options->flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(options, "all");
 	} else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
-		options->flags.OVERRIDE_SUBMODULE_CONFIG = 1;
+		options->flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(options, arg);
 	} else if (!strcmp(arg, "--submodule"))
 		options->submodule_format = DIFF_SUBMODULE_LOG;
@@ -4846,11 +4846,11 @@ int diff_opt_parse(struct diff_options *options,
 			 &options->interhunkcontext))
 		;
 	else if (!strcmp(arg, "-W"))
-		options->flags.FUNCCONTEXT = 1;
+		options->flags.funccontext = 1;
 	else if (!strcmp(arg, "--function-context"))
-		options->flags.FUNCCONTEXT = 1;
+		options->flags.funccontext = 1;
 	else if (!strcmp(arg, "--no-function-context"))
-		options->flags.FUNCCONTEXT = 0;
+		options->flags.funccontext = 0;
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		char *path = prefix_filename(prefix, optarg);
 		options->file = xfopen(path, "w");
@@ -5600,7 +5600,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & DIFF_FORMAT_DIRSTAT && options->flags.DIRSTAT_BY_LINE)
+	if (output_format & DIFF_FORMAT_DIRSTAT && options->flags.dirstat_by_line)
 		dirstat_by_line = 1;
 
 	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT) ||
@@ -5635,8 +5635,8 @@ void diff_flush(struct diff_options *options)
 	}
 
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
-	    options->flags.EXIT_WITH_STATUS &&
-	    options->flags.DIFF_FROM_CONTENTS) {
+	    options->flags.exit_with_status &&
+	    options->flags.diff_from_contents) {
 		/*
 		 * run diff_flush_patch for the exit status. setting
 		 * options->file to /dev/null should be safe, because we
@@ -5684,11 +5684,11 @@ void diff_flush(struct diff_options *options)
 	 * diff_addremove/diff_change does not set the bit when
 	 * DIFF_FROM_CONTENTS is in effect (e.g. with -w).
 	 */
-	if (options->flags.DIFF_FROM_CONTENTS) {
+	if (options->flags.diff_from_contents) {
 		if (options->found_changes)
-			options->flags.HAS_CHANGES = 1;
+			options->flags.has_changes = 1;
 		else
-			options->flags.HAS_CHANGES = 0;
+			options->flags.has_changes = 0;
 	}
 }
 
@@ -5808,7 +5808,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 			 * to determine how many paths were dirty only
 			 * due to stat info mismatch.
 			 */
-			if (!diffopt->flags.NO_INDEX)
+			if (!diffopt->flags.no_index)
 				diffopt->skip_stat_unmatch++;
 			diff_free_filepair(p);
 		}
@@ -5857,10 +5857,10 @@ void diffcore_std(struct diff_options *options)
 		diff_resolve_rename_copy();
 	diffcore_apply_filter(options);
 
-	if (diff_queued_diff.nr && !options->flags.DIFF_FROM_CONTENTS)
-		options->flags.HAS_CHANGES = 1;
+	if (diff_queued_diff.nr && !options->flags.diff_from_contents)
+		options->flags.has_changes = 1;
 	else
-		options->flags.HAS_CHANGES = 0;
+		options->flags.has_changes = 0;
 
 	options->found_follow = 0;
 }
@@ -5872,23 +5872,23 @@ int diff_result_code(struct diff_options *opt, int status)
 	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
 			       opt->degraded_cc_to_c);
-	if (!opt->flags.EXIT_WITH_STATUS &&
+	if (!opt->flags.exit_with_status &&
 	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
 		return status;
-	if (opt->flags.EXIT_WITH_STATUS &&
-	    opt->flags.HAS_CHANGES)
+	if (opt->flags.exit_with_status &&
+	    opt->flags.has_changes)
 		result |= 01;
 	if ((opt->output_format & DIFF_FORMAT_CHECKDIFF) &&
-	    opt->flags.CHECK_FAILED)
+	    opt->flags.check_failed)
 		result |= 02;
 	return result;
 }
 
 int diff_can_quit_early(struct diff_options *opt)
 {
-	return (opt->flags.QUICK &&
+	return (opt->flags.quick &&
 		!opt->filter &&
-		opt->flags.HAS_CHANGES);
+		opt->flags.has_changes);
 }
 
 /*
@@ -5901,9 +5901,9 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 {
 	int ignored = 0;
 	struct diff_flags orig_flags = options->flags;
-	if (!options->flags.OVERRIDE_SUBMODULE_CONFIG)
+	if (!options->flags.override_submodule_config)
 		set_diffopt_flags_from_submodule_config(options, path);
-	if (options->flags.IGNORE_SUBMODULES)
+	if (options->flags.ignore_submodules)
 		ignored = 1;
 	options->flags = orig_flags;
 	return ignored;
@@ -5932,7 +5932,7 @@ void diff_addremove(struct diff_options *options,
 	 * Before the final output happens, they are pruned after
 	 * merged into rename/copy pairs as appropriate.
 	 */
-	if (options->flags.REVERSE_DIFF)
+	if (options->flags.reverse_diff)
 		addremove = (addremove == '+' ? '-' :
 			     addremove == '-' ? '+' : addremove);
 
@@ -5951,8 +5951,8 @@ void diff_addremove(struct diff_options *options,
 	}
 
 	diff_queue(&diff_queued_diff, one, two);
-	if (!options->flags.DIFF_FROM_CONTENTS)
-		options->flags.HAS_CHANGES = 1;
+	if (!options->flags.diff_from_contents)
+		options->flags.has_changes = 1;
 }
 
 void diff_change(struct diff_options *options,
@@ -5970,7 +5970,7 @@ void diff_change(struct diff_options *options,
 	    is_submodule_ignored(concatpath, options))
 		return;
 
-	if (options->flags.REVERSE_DIFF) {
+	if (options->flags.reverse_diff) {
 		SWAP(old_mode, new_mode);
 		SWAP(old_oid, new_oid);
 		SWAP(old_oid_valid, new_oid_valid);
@@ -5989,14 +5989,14 @@ void diff_change(struct diff_options *options,
 	two->dirty_submodule = new_dirty_submodule;
 	p = diff_queue(&diff_queued_diff, one, two);
 
-	if (options->flags.DIFF_FROM_CONTENTS)
+	if (options->flags.diff_from_contents)
 		return;
 
-	if (options->flags.QUICK && options->skip_stat_unmatch &&
+	if (options->flags.quick && options->skip_stat_unmatch &&
 	    !diff_filespec_check_stat_unmatch(p))
 		return;
 
-	options->flags.HAS_CHANGES = 1;
+	options->flags.has_changes = 1;
 }
 
 struct diff_filepair *diff_unmerge(struct diff_options *options, const char *path)
@@ -6134,7 +6134,7 @@ void setup_diff_pager(struct diff_options *opt)
 	 * and because it is easy to find people oneline advising "git diff
 	 * --exit-code" in hooks and other scripts, we do not do so.
 	 */
-	if (!opt->flags.EXIT_WITH_STATUS &&
+	if (!opt->flags.exit_with_status &&
 	    check_pager_config("diff") != 0)
 		setup_pager();
 }
diff --git a/diff.h b/diff.h
index 258d735c1..ed2832d7a 100644
--- a/diff.h
+++ b/diff.h
@@ -62,37 +62,37 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FLAGS_INIT { 0 }
 struct diff_flags {
-	unsigned RECURSIVE:1;
-	unsigned TREE_IN_RECURSIVE:1;
-	unsigned BINARY:1;
-	unsigned TEXT:1;
-	unsigned FULL_INDEX:1;
-	unsigned SILENT_ON_REMOVE:1;
-	unsigned FIND_COPIES_HARDER:1;
-	unsigned FOLLOW_RENAMES:1;
-	unsigned RENAME_EMPTY:1;
-	unsigned HAS_CHANGES:1;
-	unsigned QUICK:1;
-	unsigned NO_INDEX:1;
-	unsigned ALLOW_EXTERNAL:1;
-	unsigned EXIT_WITH_STATUS:1;
-	unsigned REVERSE_DIFF:1;
-	unsigned CHECK_FAILED:1;
-	unsigned RELATIVE_NAME:1;
-	unsigned IGNORE_SUBMODULES:1;
-	unsigned DIRSTAT_CUMULATIVE:1;
-	unsigned DIRSTAT_BY_FILE:1;
-	unsigned ALLOW_TEXTCONV:1;
-	unsigned TEXTCONV_SET_VIA_CMDLINE:1;
-	unsigned DIFF_FROM_CONTENTS:1;
-	unsigned DIRTY_SUBMODULES:1;
-	unsigned IGNORE_UNTRACKED_IN_SUBMODULES:1;
-	unsigned IGNORE_DIRTY_SUBMODULES:1;
-	unsigned OVERRIDE_SUBMODULE_CONFIG:1;
-	unsigned DIRSTAT_BY_LINE:1;
-	unsigned FUNCCONTEXT:1;
-	unsigned PICKAXE_IGNORE_CASE:1;
-	unsigned DEFAULT_FOLLOW_RENAMES:1;
+	unsigned recursive:1;
+	unsigned tree_in_recursive:1;
+	unsigned binary:1;
+	unsigned text:1;
+	unsigned full_index:1;
+	unsigned silent_on_remove:1;
+	unsigned find_copies_harder:1;
+	unsigned follow_renames:1;
+	unsigned rename_empty:1;
+	unsigned has_changes:1;
+	unsigned quick:1;
+	unsigned no_index:1;
+	unsigned allow_external:1;
+	unsigned exit_with_status:1;
+	unsigned reverse_diff:1;
+	unsigned check_failed:1;
+	unsigned relative_name:1;
+	unsigned ignore_submodules:1;
+	unsigned dirstat_cumulative:1;
+	unsigned dirstat_by_file:1;
+	unsigned allow_textconv:1;
+	unsigned textconv_set_via_cmdline:1;
+	unsigned diff_from_contents:1;
+	unsigned dirty_submodules:1;
+	unsigned ignore_untracked_in_submodules:1;
+	unsigned ignore_dirty_submodules:1;
+	unsigned override_submodule_config:1;
+	unsigned dirstat_by_line:1;
+	unsigned funccontext:1;
+	unsigned pickaxe_ignore_case:1;
+	unsigned default_follow_renames:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 6193c07f6..9476bd210 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -131,7 +131,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
 		return 0;
 
-	if (o->flags.ALLOW_TEXTCONV) {
+	if (o->flags.allow_textconv) {
 		textconv_one = get_textconv(p->one);
 		textconv_two = get_textconv(p->two);
 	}
@@ -222,11 +222,11 @@ void diffcore_pickaxe(struct diff_options *o)
 
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int cflags = REG_EXTENDED | REG_NEWLINE;
-		if (o->flags.PICKAXE_IGNORE_CASE)
+		if (o->flags.pickaxe_ignore_case)
 			cflags |= REG_ICASE;
 		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
-	} else if (o->flags.PICKAXE_IGNORE_CASE &&
+	} else if (o->flags.pickaxe_ignore_case &&
 		   has_non_ascii(needle)) {
 		struct strbuf sb = STRBUF_INIT;
 		int cflags = REG_NEWLINE | REG_ICASE;
@@ -236,7 +236,7 @@ void diffcore_pickaxe(struct diff_options *o)
 		strbuf_release(&sb);
 		regexp = &regex;
 	} else {
-		kws = kwsalloc(o->flags.PICKAXE_IGNORE_CASE
+		kws = kwsalloc(o->flags.pickaxe_ignore_case
 			       ? tolower_trans_tbl : NULL);
 		kwsincr(kws, needle, strlen(needle));
 		kwsprep(kws);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index bd077ee11..12dc2a056 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -405,7 +405,7 @@ static int too_many_rename_candidates(int num_create,
 		num_src > num_create ? num_src : num_create;
 
 	/* Are we running under -C -C? */
-	if (!options->flags.FIND_COPIES_HARDER)
+	if (!options->flags.find_copies_harder)
 		return 1;
 
 	/* Would we bust the limit if we were running under -C? */
@@ -463,7 +463,7 @@ void diffcore_rename(struct diff_options *options)
 			else if (options->single_follow &&
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
-			else if (!options->flags.RENAME_EMPTY &&
+			else if (!options->flags.rename_empty &&
 				 is_empty_blob_oid(&p->two->oid))
 				continue;
 			else if (add_rename_dst(p->two) < 0) {
@@ -473,7 +473,7 @@ void diffcore_rename(struct diff_options *options)
 				goto cleanup;
 			}
 		}
-		else if (!options->flags.RENAME_EMPTY &&
+		else if (!options->flags.rename_empty &&
 			 is_empty_blob_oid(&p->one->oid))
 			continue;
 		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
diff --git a/log-tree.c b/log-tree.c
index 460bb5498..8dacccc0c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -793,7 +793,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	struct commit_list *parents;
 	struct object_id *oid;
 
-	if (!opt->diff && !opt->diffopt.flags.EXIT_WITH_STATUS)
+	if (!opt->diff && !opt->diffopt.flags.exit_with_status)
 		return 0;
 
 	parse_commit_or_die(commit);
diff --git a/merge-recursive.c b/merge-recursive.c
index 9752aba4e..f6c03770b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -540,8 +540,8 @@ static struct string_list *get_renames(struct merge_options *o,
 		return renames;
 
 	diff_setup(&opts);
-	opts.flags.RECURSIVE = 1;
-	opts.flags.RENAME_EMPTY = 0;
+	opts.flags.recursive = 1;
+	opts.flags.rename_empty = 0;
 	opts.detect_rename = DIFF_DETECT_RENAME;
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
diff --git a/notes-merge.c b/notes-merge.c
index b50111cf2..b3d4d44fc 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -125,7 +125,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	       oid_to_hex(base), oid_to_hex(remote));
 
 	diff_setup(&opt);
-	opt.flags.RECURSIVE = 1;
+	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
 	diff_tree_oid(base, remote, "", &opt);
@@ -188,7 +188,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	       len, oid_to_hex(base), oid_to_hex(local));
 
 	diff_setup(&opt);
-	opt.flags.RECURSIVE = 1;
+	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
 	diff_tree_oid(base, local, "", &opt);
diff --git a/patch-ids.c b/patch-ids.c
index 189869e57..8f7c25d5d 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -61,7 +61,7 @@ int init_patch_ids(struct patch_ids *ids)
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
 	ids->diffopts.detect_rename = 0;
-	ids->diffopts.flags.RECURSIVE = 1;
+	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
 	hashmap_init(&ids->patches, patch_id_cmp, &ids->diffopts, 256);
 	return 0;
diff --git a/revision.c b/revision.c
index 6bb873501..bfde5b0cd 100644
--- a/revision.c
+++ b/revision.c
@@ -410,7 +410,7 @@ static void file_add_remove(struct diff_options *options,
 
 	tree_difference |= diff;
 	if (tree_difference == REV_TREE_DIFFERENT)
-		options->flags.HAS_CHANGES = 1;
+		options->flags.has_changes = 1;
 }
 
 static void file_change(struct diff_options *options,
@@ -422,7 +422,7 @@ static void file_change(struct diff_options *options,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
 	tree_difference = REV_TREE_DIFFERENT;
-	options->flags.HAS_CHANGES = 1;
+	options->flags.has_changes = 1;
 }
 
 static int rev_compare_tree(struct rev_info *revs,
@@ -455,7 +455,7 @@ static int rev_compare_tree(struct rev_info *revs,
 	}
 
 	tree_difference = REV_TREE_SAME;
-	revs->pruning.flags.HAS_CHANGES = 0;
+	revs->pruning.flags.has_changes = 0;
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
@@ -471,7 +471,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 		return 0;
 
 	tree_difference = REV_TREE_SAME;
-	revs->pruning.flags.HAS_CHANGES = 0;
+	revs->pruning.flags.has_changes = 0;
 	retval = diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
 	return retval >= 0 && (tree_difference == REV_TREE_SAME);
@@ -1403,8 +1403,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->abbrev = DEFAULT_ABBREV;
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
-	revs->pruning.flags.RECURSIVE = 1;
-	revs->pruning.flags.QUICK = 1;
+	revs->pruning.flags.recursive = 1;
+	revs->pruning.flags.quick = 1;
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
 	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
@@ -1917,11 +1917,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		die("--unpacked=<packfile> no longer supported.");
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
-		revs->diffopt.flags.RECURSIVE = 1;
+		revs->diffopt.flags.recursive = 1;
 	} else if (!strcmp(arg, "-t")) {
 		revs->diff = 1;
-		revs->diffopt.flags.RECURSIVE = 1;
-		revs->diffopt.flags.TREE_IN_RECURSIVE = 1;
+		revs->diffopt.flags.recursive = 1;
+		revs->diffopt.flags.tree_in_recursive = 1;
 	} else if (!strcmp(arg, "-m")) {
 		revs->ignore_merges = 0;
 	} else if (!strcmp(arg, "-c")) {
@@ -2066,7 +2066,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_ERE;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
 		revs->grep_filter.ignore_case = 1;
-		revs->diffopt.flags.PICKAXE_IGNORE_CASE = 1;
+		revs->diffopt.flags.pickaxe_ignore_case = 1;
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
 	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
@@ -2399,7 +2399,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	/* Pickaxe, diff-filter and rename following need diffs */
 	if (revs->diffopt.pickaxe ||
 	    revs->diffopt.filter ||
-	    revs->diffopt.flags.FOLLOW_RENAMES)
+	    revs->diffopt.flags.follow_renames)
 		revs->diff = 1;
 
 	if (revs->topo_order)
@@ -2408,7 +2408,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->prune_data.nr) {
 		copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
 		/* Can't prune commits with rename following: the paths change.. */
-		if (!revs->diffopt.flags.FOLLOW_RENAMES)
+		if (!revs->diffopt.flags.follow_renames)
 			revs->prune = 1;
 		if (!revs->full_diff)
 			copy_pathspec(&revs->diffopt.pathspec,
diff --git a/submodule.c b/submodule.c
index 62a93bb88..9b16adc96 100644
--- a/submodule.c
+++ b/submodule.c
@@ -183,7 +183,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		if (ignore)
 			handle_ignore_submodules_arg(diffopt, ignore);
 		else if (is_gitmodules_unmerged(&the_index))
-			diffopt->flags.IGNORE_SUBMODULES = 1;
+			diffopt->flags.ignore_submodules = 1;
 	}
 }
 
@@ -402,16 +402,16 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
-	diffopt->flags.IGNORE_SUBMODULES = 0;
-	diffopt->flags.IGNORE_UNTRACKED_IN_SUBMODULES = 0;
-	diffopt->flags.IGNORE_DIRTY_SUBMODULES = 0;
+	diffopt->flags.ignore_submodules = 0;
+	diffopt->flags.ignore_untracked_in_submodules = 0;
+	diffopt->flags.ignore_dirty_submodules = 0;
 
 	if (!strcmp(arg, "all"))
-		diffopt->flags.IGNORE_SUBMODULES = 1;
+		diffopt->flags.ignore_submodules = 1;
 	else if (!strcmp(arg, "untracked"))
-		diffopt->flags.IGNORE_UNTRACKED_IN_SUBMODULES = 1;
+		diffopt->flags.ignore_untracked_in_submodules = 1;
 	else if (!strcmp(arg, "dirty"))
-		diffopt->flags.IGNORE_DIRTY_SUBMODULES = 1;
+		diffopt->flags.ignore_dirty_submodules = 1;
 	else if (strcmp(arg, "none"))
 		die("bad --ignore-submodules argument: %s", arg);
 }
@@ -616,7 +616,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	argv_array_pushf(&cp.args, "--color=%s", want_color(o->use_color) ?
 			 "always" : "never");
 
-	if (o->flags.REVERSE_DIFF) {
+	if (o->flags.reverse_diff) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
 				 o->b_prefix, path);
 		argv_array_pushf(&cp.args, "--dst-prefix=%s%s/",
diff --git a/tree-diff.c b/tree-diff.c
index b996a23bb..fe2e466ac 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -212,9 +212,9 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		mode = 0;
 	}
 
-	if (opt->flags.RECURSIVE && isdir) {
+	if (opt->flags.recursive && isdir) {
 		recurse = 1;
-		emitthis = opt->flags.TREE_IN_RECURSIVE;
+		emitthis = opt->flags.tree_in_recursive;
 	}
 
 	if (emitthis) {
@@ -425,7 +425,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	ttree = fill_tree_descriptor(&t, oid);
 
 	/* Enable recursion indefinitely */
-	opt->pathspec.recursive = opt->flags.RECURSIVE;
+	opt->pathspec.recursive = opt->flags.recursive;
 
 	for (;;) {
 		int imin, cmp;
@@ -484,7 +484,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		/* t = p[imin] */
 		if (cmp == 0) {
 			/* are either pi > p[imin] or diff(t,pi) != ø ? */
-			if (!opt->flags.FIND_COPIES_HARDER) {
+			if (!opt->flags.find_copies_harder) {
 				for (i = 0; i < nparent; ++i) {
 					/* p[i] > p[imin] */
 					if (tp[i].entry.mode & S_IFXMIN_NEQ)
@@ -522,7 +522,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		/* t > p[imin] */
 		else {
 			/* ∀i pi=p[imin] -> D += "-p[imin]" */
-			if (!opt->flags.FIND_COPIES_HARDER) {
+			if (!opt->flags.find_copies_harder) {
 				for (i = 0; i < nparent; ++i)
 					if (tp[i].entry.mode & S_IFXMIN_NEQ)
 						goto skip_emit_tp;
@@ -608,8 +608,8 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	q->nr = 0;
 
 	diff_setup(&diff_opts);
-	diff_opts.flags.RECURSIVE = 1;
-	diff_opts.flags.FIND_COPIES_HARDER = 1;
+	diff_opts.flags.recursive = 1;
+	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->pathspec.items[0].match;
 	diff_opts.break_opt = opt->break_opt;
@@ -706,7 +706,7 @@ int diff_tree_oid(const struct object_id *old_oid,
 	strbuf_addstr(&base, base_str);
 
 	retval = ll_diff_tree_oid(old_oid, new_oid, &base, opt);
-	if (!*base_str && opt->flags.FOLLOW_RENAMES && diff_might_be_rename())
+	if (!*base_str && opt->flags.follow_renames && diff_might_be_rename())
 		try_to_follow_renames(old_oid, new_oid, &base, opt);
 
 	strbuf_release(&base);
diff --git a/wt-status.c b/wt-status.c
index 59f9f3a0b..4f76e19d3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -559,12 +559,12 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.flags.DIRTY_SUBMODULES = 1;
+	rev.diffopt.flags.dirty_submodules = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 	if (!s->show_untracked_files)
-		rev.diffopt.flags.IGNORE_UNTRACKED_IN_SUBMODULES = 1;
+		rev.diffopt.flags.ignore_untracked_in_submodules = 1;
 	if (s->ignore_submodule_arg) {
-		rev.diffopt.flags.OVERRIDE_SUBMODULE_CONFIG = 1;
+		rev.diffopt.flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	}
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
@@ -583,7 +583,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
-	rev.diffopt.flags.OVERRIDE_SUBMODULE_CONFIG = 1;
+	rev.diffopt.flags.override_submodule_config = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 	if (s->ignore_submodule_arg) {
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
@@ -949,7 +949,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	const char *c = color(WT_STATUS_HEADER, s);
 
 	init_revisions(&rev, NULL);
-	rev.diffopt.flags.ALLOW_TEXTCONV = 1;
+	rev.diffopt.flags.allow_textconv = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
@@ -2263,8 +2263,8 @@ int has_unstaged_changes(int ignore_submodules)
 
 	init_revisions(&rev_info, NULL);
 	if (ignore_submodules)
-		rev_info.diffopt.flags.IGNORE_SUBMODULES = 1;
-	rev_info.diffopt.flags.QUICK = 1;
+		rev_info.diffopt.flags.ignore_submodules = 1;
+	rev_info.diffopt.flags.quick = 1;
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_files(&rev_info, 0);
 	return diff_result_code(&rev_info.diffopt, result);
@@ -2283,8 +2283,8 @@ int has_uncommitted_changes(int ignore_submodules)
 
 	init_revisions(&rev_info, NULL);
 	if (ignore_submodules)
-		rev_info.diffopt.flags.IGNORE_SUBMODULES = 1;
-	rev_info.diffopt.flags.QUICK = 1;
+		rev_info.diffopt.flags.ignore_submodules = 1;
+	rev_info.diffopt.flags.quick = 1;
 	add_head_to_pending(&rev_info);
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
-- 
2.15.0.403.gc27cc4dac6-goog

