Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FBE7D0AB
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjIUVlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjIUVlA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:41:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DA40047
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e758d6236so20844317b3.1
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695331053; x=1695935853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HL2MfxBAE9fvcU/jCASbb6dWUCXfEdwvjgutSJQqP1k=;
        b=XL0cj24n86a3RXNPjw/4GSw32NI0shyEi9oKGPCXCtprAEg0HapMmvP/smDweTW+PS
         q0zpk1OyLTZtXHhQsDC+UGkGy0SfbriAfE5RjwTGbGnuy0DfKMl95uqYvNDV9m+134jy
         FVOzgg+ewHiN93x2de1riZ35o5fiuaTUAeCtFr3mBCJXEQyqpKKHN0JDGCG0WTiLzMRZ
         aVeyFcXWHDXmnyDUk/OXndfwKyLYSl70RQzQJ3oHVlISmt4vSP/tDoCwzmnJT++bO2Ut
         qc9KFfBfBnwd5aPfT3uvnBjhQAXJlNummAnQOX9LlgBLU8kPmhYe+ZE/sjoSJjKmZ+B+
         UXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695331053; x=1695935853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HL2MfxBAE9fvcU/jCASbb6dWUCXfEdwvjgutSJQqP1k=;
        b=CMIOt0DlfS0PT6iFzpdE3eWWVZRuIf+CpNkh0XnXnUHfWXezz+Nfl0ihp/l5Pl1mk8
         49JIU4ILVNwalZY61bvUHIqGg0foI7bkFB2rGGRSqnvLgd/o4J9Ja4IFelSZgyw6aKOp
         9NlaaFvylxH1SqHAaHeU+GjZssixYBIYpkglKaWbg5GtsVfEivSLxEBdyvpD7vXY0n3Z
         tq9VDmaumSkoCfZAJZSdUycSw1KB7LNn71lJKWI4nvUVyze+w8MYHzvbJsNq22uYvHM+
         rzv2cq0b2Ir/CowaqTwZCyEeHPOpxrwpZe+HbkBO5eJdSAQQZ0Sz3O9zIMKweB9T4/WI
         x9tg==
X-Gm-Message-State: AOJu0Yzjl01O3WFcsaO8DAIBjxJbjAEG0gxzQqNnDZVh7zJGprLno6Hz
        f2R08AHvK1oj3aQLkAPiLT4M3NkFC4c7omqEu0RHnV3c3OiPYmRsIbKEsUSVoUALeOoKmhAEIpz
        EIHL8OWZSkcE6QjJJY/m0sn0Md3kekbdfSG+QOKG9/eK6X9lNdu0H+MlnHF7FSp0=
X-Google-Smtp-Source: AGHT+IGBiCRn5sqaiuQQ5OJjTwt7mTjGnwpLifBGCJi0A9VfPK4fXjOwXVp9jHKzsIgueU3tHn6QC2J/3c79vQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:828c:91e1:20c5:c8f])
 (user=steadmon job=sendgmr) by 2002:a25:25c6:0:b0:d81:7617:a397 with SMTP id
 l189-20020a2525c6000000b00d817617a397mr93104ybl.9.1695331052865; Thu, 21 Sep
 2023 14:17:32 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:17:22 -0700
In-Reply-To: <cover.1695330852.git.steadmon@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <cover.1695330852.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <a888045c04d27864edf5751ea8641fdba596779c.1695330852.git.steadmon@google.com>
Subject: [PATCH v3 3/5] config: report config parse errors using cb
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In a subsequent commit, config parsing will become its own library, and
it's likely that the caller will want flexibility in handling errors
(instead of being limited to the error handling we have in-tree).

Move the Git-specific error handling into a config_parser_event_fn_t
that responds to config errors, and make git_parse_source() always
return -1 (careful inspection shows that it was always returning -1
already). This makes CONFIG_ERROR_SILENT obsolete since that is
equivalent to not specifying an error event listener. Also, remove
CONFIG_ERROR_UNSET and the config_source 'default', since all callers
are now expected to specify the error handling they want.

Add a new "do_event_and_flush" function for running event callbacks
immediately, where the event does not need to calculate an end offset.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/config.c   |   4 +-
 bundle-uri.c       |   4 +-
 config.c           | 195 ++++++++++++++++++++++++++++-----------------
 config.h           |  20 +++--
 fsck.c             |   4 +-
 submodule-config.c |   9 ++-
 6 files changed, 147 insertions(+), 89 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 1c75cbc43d..e2cf49de7a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -42,7 +42,9 @@ static int actions, type;
 static char *default_value;
 static int end_nul;
 static int respect_includes_opt = -1;
-static struct config_options config_options;
+static struct config_options config_options = {
+	.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE)
+};
 static int show_origin;
 static int show_scope;
 static int fixed_value;
diff --git a/bundle-uri.c b/bundle-uri.c
index f93ca6a486..856bffdcad 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -237,9 +237,7 @@ int bundle_uri_parse_config_format(const char *uri,
 				   struct bundle_list *list)
 {
 	int result;
-	struct config_parse_options opts = {
-		.error_action = CONFIG_ERROR_ERROR,
-	};
+	struct config_parse_options opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
 
 	if (!list->baseURI) {
 		struct strbuf baseURI = STRBUF_INIT;
diff --git a/config.c b/config.c
index ff138500a2..0c4f1a2874 100644
--- a/config.c
+++ b/config.c
@@ -55,7 +55,6 @@ struct config_source {
 	enum config_origin_type origin_type;
 	const char *name;
 	const char *path;
-	enum config_error_action default_error_action;
 	int linenr;
 	int eof;
 	size_t total_len;
@@ -185,13 +184,15 @@ static int handle_path_include(const struct key_value_info *kvi,
 	}
 
 	if (!access_or_die(path, R_OK, 0)) {
+		struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
+
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
 			    !kvi ? "<unknown>" :
 			    kvi->filename ? kvi->filename :
 			    "the command line");
 		ret = git_config_from_file_with_options(git_config_include, path, inc,
-							kvi->scope, NULL);
+							kvi->scope, &config_opts);
 		inc->depth--;
 	}
 cleanup:
@@ -339,7 +340,9 @@ static int add_remote_url(const char *var, const char *value,
 
 static void populate_remote_urls(struct config_include_data *inc)
 {
-	struct config_options opts;
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
@@ -1039,6 +1042,29 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 	return 0;
 }
 
+static int do_event_and_flush(struct config_source *cs,
+			      enum config_event_t type,
+			      struct parse_event_data *data)
+{
+	int maybe_ret;
+
+	if ((maybe_ret = flush_event(cs, type, data)) < 1)
+		return maybe_ret;
+
+	start_event(cs, type, data);
+
+	if ((maybe_ret = flush_event(cs, type, data)) < 1)
+		return maybe_ret;
+
+	/*
+	 * Not actually EOF, but this indicates we don't have a valid event
+	 * to flush next time around.
+	 */
+	data->previous_type = CONFIG_EVENT_EOF;
+
+	return 0;
+}
+
 static void kvi_from_source(struct config_source *cs,
 			    enum config_scope scope,
 			    struct key_value_info *out)
@@ -1050,6 +1076,56 @@ static void kvi_from_source(struct config_source *cs,
 	out->path = cs->path;
 }
 
+int git_config_err_fn(enum config_event_t type, size_t begin_offset UNUSED,
+		      size_t end_offset UNUSED, struct config_source *cs,
+		      void *data)
+{
+	char *error_msg = NULL;
+	int error_return = 0;
+	enum config_error_action *action = data;
+
+	if (type != CONFIG_EVENT_ERROR)
+		return 0;
+
+	switch (cs->origin_type) {
+	case CONFIG_ORIGIN_BLOB:
+		error_msg = xstrfmt(_("bad config line %d in blob %s"),
+				      cs->linenr, cs->name);
+		break;
+	case CONFIG_ORIGIN_FILE:
+		error_msg = xstrfmt(_("bad config line %d in file %s"),
+				      cs->linenr, cs->name);
+		break;
+	case CONFIG_ORIGIN_STDIN:
+		error_msg = xstrfmt(_("bad config line %d in standard input"),
+				      cs->linenr);
+		break;
+	case CONFIG_ORIGIN_SUBMODULE_BLOB:
+		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
+				       cs->linenr, cs->name);
+		break;
+	case CONFIG_ORIGIN_CMDLINE:
+		error_msg = xstrfmt(_("bad config line %d in command line %s"),
+				       cs->linenr, cs->name);
+		break;
+	default:
+		error_msg = xstrfmt(_("bad config line %d in %s"),
+				      cs->linenr, cs->name);
+	}
+
+	switch (*action) {
+	case CONFIG_ERROR_DIE:
+		die("%s", error_msg);
+		break;
+	case CONFIG_ERROR_ERROR:
+		error_return = error("%s", error_msg);
+		break;
+	}
+
+	free(error_msg);
+	return error_return;
+}
+
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
 			    struct key_value_info *kvi, void *data,
 			    const struct config_parse_options *opts)
@@ -1057,8 +1133,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 	int comment = 0;
 	size_t baselen = 0;
 	struct strbuf *var = &cs->var;
-	int error_return = 0;
-	char *error_msg = NULL;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -1140,53 +1214,8 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 			break;
 	}
 
-	if (do_event(cs, CONFIG_EVENT_ERROR, &event_data) < 0)
-		return -1;
-
-	switch (cs->origin_type) {
-	case CONFIG_ORIGIN_BLOB:
-		error_msg = xstrfmt(_("bad config line %d in blob %s"),
-				      cs->linenr, cs->name);
-		break;
-	case CONFIG_ORIGIN_FILE:
-		error_msg = xstrfmt(_("bad config line %d in file %s"),
-				      cs->linenr, cs->name);
-		break;
-	case CONFIG_ORIGIN_STDIN:
-		error_msg = xstrfmt(_("bad config line %d in standard input"),
-				      cs->linenr);
-		break;
-	case CONFIG_ORIGIN_SUBMODULE_BLOB:
-		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
-				       cs->linenr, cs->name);
-		break;
-	case CONFIG_ORIGIN_CMDLINE:
-		error_msg = xstrfmt(_("bad config line %d in command line %s"),
-				       cs->linenr, cs->name);
-		break;
-	default:
-		error_msg = xstrfmt(_("bad config line %d in %s"),
-				      cs->linenr, cs->name);
-	}
-
-	switch (opts && opts->error_action ?
-		opts->error_action :
-		cs->default_error_action) {
-	case CONFIG_ERROR_DIE:
-		die("%s", error_msg);
-		break;
-	case CONFIG_ERROR_ERROR:
-		error_return = error("%s", error_msg);
-		break;
-	case CONFIG_ERROR_SILENT:
-		error_return = -1;
-		break;
-	case CONFIG_ERROR_UNSET:
-		BUG("config error action unset");
-	}
-
-	free(error_msg);
-	return error_return;
+	do_event_and_flush(cs, CONFIG_EVENT_ERROR, &event_data);
+	return -1;
 }
 
 static uintmax_t get_unit_factor(const char *end)
@@ -2023,7 +2052,6 @@ static int do_config_from_file(config_fn_t fn,
 	top.origin_type = origin_type;
 	top.name = name;
 	top.path = path;
-	top.default_error_action = CONFIG_ERROR_DIE;
 	top.do_fgetc = config_file_fgetc;
 	top.do_ungetc = config_file_ungetc;
 	top.do_ftell = config_file_ftell;
@@ -2037,8 +2065,10 @@ static int do_config_from_file(config_fn_t fn,
 static int git_config_from_stdin(config_fn_t fn, void *data,
 				 enum config_scope scope)
 {
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
+
 	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
-				   data, scope, NULL);
+				   data, scope, &config_opts);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -2061,8 +2091,10 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
+
 	return git_config_from_file_with_options(fn, filename, data,
-						 CONFIG_SCOPE_UNKNOWN, NULL);
+						 CONFIG_SCOPE_UNKNOWN, &config_opts);
 }
 
 int git_config_from_mem(config_fn_t fn,
@@ -2079,7 +2111,6 @@ int git_config_from_mem(config_fn_t fn,
 	top.origin_type = origin_type;
 	top.name = name;
 	top.path = NULL;
-	top.default_error_action = CONFIG_ERROR_ERROR;
 	top.do_fgetc = config_buf_fgetc;
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
@@ -2098,6 +2129,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	char *buf;
 	unsigned long size;
 	int ret;
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
 
 	buf = repo_read_object_file(repo, oid, &type, &size);
 	if (!buf)
@@ -2108,7 +2140,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	}
 
 	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
-				  data, scope, NULL);
+				  data, scope, &config_opts);
 	free(buf);
 
 	return ret;
@@ -2209,29 +2241,32 @@ static int do_git_config_sequence(const struct config_options *opts,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
 		ret += git_config_from_file_with_options(fn, system_config,
 							 data, CONFIG_SCOPE_SYSTEM,
-							 NULL);
+							 &opts->parse_options);
 
 	git_global_config(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file_with_options(fn, xdg_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+							 CONFIG_SCOPE_GLOBAL,
+							 &opts->parse_options);
 
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file_with_options(fn, user_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+							 CONFIG_SCOPE_GLOBAL,
+							 &opts->parse_options);
 
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file_with_options(fn, repo_config, data,
-							 CONFIG_SCOPE_LOCAL, NULL);
+							 CONFIG_SCOPE_LOCAL,
+							 &opts->parse_options);
 
 	if (!opts->ignore_worktree && worktree_config &&
 	    repo && repo->repository_format_worktree_config &&
 	    !access_or_die(worktree_config, R_OK, 0)) {
 			ret += git_config_from_file_with_options(fn, worktree_config, data,
 								 CONFIG_SCOPE_WORKTREE,
-								 NULL);
+								 &opts->parse_options);
 	}
 
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
@@ -2272,7 +2307,7 @@ int config_with_options(config_fn_t fn, void *data,
 	} else if (config_source && config_source->file) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
-							NULL);
+							&opts->parse_options);
 	} else if (config_source && config_source->blob) {
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
@@ -2310,9 +2345,11 @@ static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 
 void read_early_config(config_fn_t cb, void *data)
 {
-	struct config_options opts = {0};
 	struct strbuf commondir = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts.respect_includes = 1;
 
@@ -2344,13 +2381,14 @@ void read_early_config(config_fn_t cb, void *data)
  */
 void read_very_early_config(config_fn_t cb, void *data)
 {
-	struct config_options opts = { 0 };
-
-	opts.respect_includes = 1;
-	opts.ignore_repo = 1;
-	opts.ignore_worktree = 1;
-	opts.ignore_cmdline = 1;
-	opts.system_gently = 1;
+	struct config_options opts = {
+		.respect_includes = 1,
+		.ignore_repo = 1,
+		.ignore_worktree = 1,
+		.ignore_cmdline = 1,
+		.system_gently = 1,
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	config_with_options(cb, data, NULL, NULL, &opts);
 }
@@ -2635,7 +2673,9 @@ int git_configset_get_pathname(struct config_set *set, const char *key, const ch
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
-	struct config_options opts = { 0 };
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2786,8 +2826,10 @@ static void read_protected_config(void)
 		.ignore_repo = 1,
 		.ignore_worktree = 1,
 		.system_gently = 1,
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
 	};
 
+
 	git_configset_init(&protected_config);
 	config_with_options(config_set_callback, &protected_config, NULL,
 			    NULL, &opts);
@@ -2998,6 +3040,7 @@ struct config_store_data {
 		enum config_event_t type;
 		int is_keys_section;
 	} *parsed;
+	enum config_error_action error_action;
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
@@ -3065,6 +3108,10 @@ static int store_aux_event(enum config_event_t type, size_t begin, size_t end,
 			store->seen[store->seen_nr] = store->parsed_nr;
 		}
 	}
+	if (type == CONFIG_EVENT_ERROR) {
+		return git_config_err_fn(type, begin, end, cs,
+					 &store->error_action);
+	}
 
 	store->parsed_nr++;
 
@@ -3402,7 +3449,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		struct stat st;
 		size_t copy_begin, copy_end;
 		int i, new_line = 0;
-		struct config_parse_options opts;
+		struct config_parse_options opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
 
 		if (!value_pattern)
 			store.value_pattern = NULL;
@@ -3429,8 +3476,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		ALLOC_GROW(store.parsed, 1, store.parsed_alloc);
 		store.parsed[0].end = 0;
+		store.error_action = CONFIG_ERROR_DIE;
 
-		memset(&opts, 0, sizeof(opts));
 		opts.event_fn = store_aux_event;
 		opts.event_fn_data = &store;
 
diff --git a/config.h b/config.h
index 2537516446..8ad399580f 100644
--- a/config.h
+++ b/config.h
@@ -86,12 +86,6 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 					void *event_fn_data);
 
 struct config_parse_options {
-	enum config_error_action {
-		CONFIG_ERROR_UNSET = 0, /* use source-specific default */
-		CONFIG_ERROR_DIE, /* die() on error */
-		CONFIG_ERROR_ERROR, /* error() on error, return -1 */
-		CONFIG_ERROR_SILENT, /* return -1 */
-	} error_action;
 	/*
 	 * event_fn and event_fn_data are for internal use only. Handles events
 	 * emitted by the config parser.
@@ -100,6 +94,11 @@ struct config_parse_options {
 	void *event_fn_data;
 };
 
+#define CP_OPTS_INIT(error_action) { \
+	.event_fn = git_config_err_fn, \
+	.event_fn_data = (enum config_error_action []){(error_action)}, \
+}
+
 struct config_options {
 	unsigned int respect_includes : 1;
 	unsigned int ignore_repo : 1;
@@ -119,6 +118,15 @@ struct config_options {
 	unsigned int unconditional_remote_url : 1;
 };
 
+enum config_error_action {
+	CONFIG_ERROR_DIE, /* die() on error */
+	CONFIG_ERROR_ERROR, /* error() on error, return -1 */
+};
+
+int git_config_err_fn(enum config_event_t type, size_t begin_offset,
+		      size_t end_offset, struct config_source *cs,
+		      void *event_fn_data);
+
 /* Config source metadata for a given config key-value pair */
 struct key_value_info {
 	const char *filename;
diff --git a/fsck.c b/fsck.c
index 522ee1c18a..bc0ca11421 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1219,7 +1219,6 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		return 0;
 
 	if (oidset_contains(&options->gitmodules_found, oid)) {
-		struct config_parse_options config_opts = { 0 };
 		struct fsck_gitmodules_data data;
 
 		oidset_insert(&options->gitmodules_done, oid);
@@ -1238,10 +1237,9 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		data.oid = oid;
 		data.options = options;
 		data.ret = 0;
-		config_opts.error_action = CONFIG_ERROR_SILENT;
 		if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
 					".gitmodules", buf, size, &data,
-					CONFIG_SCOPE_UNKNOWN, &config_opts))
+					CONFIG_SCOPE_UNKNOWN, NULL))
 			data.ret |= report(options, oid, OBJ_BLOB,
 					FSCK_MSG_GITMODULES_PARSE,
 					"could not parse gitmodules blob");
diff --git a/submodule-config.c b/submodule-config.c
index b6908e295f..d97135c917 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -565,6 +565,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	enum object_type type;
 	const struct submodule *submodule = NULL;
 	struct parse_config_parameter parameter;
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
+
 
 	/*
 	 * If any parameter except the cache is a NULL pointer just
@@ -608,7 +610,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
-			    config, config_size, &parameter, CONFIG_SCOPE_UNKNOWN, NULL);
+			    config, config_size, &parameter,
+			    CONFIG_SCOPE_UNKNOWN, &config_opts);
 	strbuf_release(&rev);
 	free(config);
 
@@ -652,7 +655,9 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		struct git_config_source config_source = {
 			0, .scope = CONFIG_SCOPE_SUBMODULE
 		};
-		const struct config_options opts = { 0 };
+		struct config_options opts = {
+			.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+		};
 		struct object_id oid;
 		char *file;
 		char *oidstr = NULL;
-- 
2.42.0.515.g380fc7ccd1-goog

