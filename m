Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C51C71153
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbjHWVy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbjHWVyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:54:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73310E5C
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:53:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d428d4956so78317887b3.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692827637; x=1693432437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLNaGvuAqYnHidi8Yx+o34fUeL1/oPEcXDU7dxSC65A=;
        b=C4bnE1jpPNDg+W2OtKjXyXCewUB16uVk3/cuNX2RphljaksQWPwcvlj6iZ3OrpS2h6
         Dmol1nC7SfiYrhGtGz/Tn6d15kw3S6cRsDlAKHOitok77Kz5RQlsi5rpcNn20gG37Aw9
         y/GO/QEgWLiHnw9Tnm3uEM1+wz469cqPwF269o7NibmgiVvsqEUtKL4YrVu2ufRd7UvB
         BLvQnWMdbhPUq7lGxCRq1ZqNDfRWsIOXrSilXfc3WLtCH0G3Fler6Rru/EcA55fywvU/
         iS4/WlzAHAg4M4gWysUurKoRSjlGCAsVqtnJyZllqO/y1eIXf5BQirYbeqgHDE3mgMxv
         EfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827637; x=1693432437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLNaGvuAqYnHidi8Yx+o34fUeL1/oPEcXDU7dxSC65A=;
        b=QdTngY7zBNwnftbMH8vckoLb6zTn6OkS7P2RINaCZ9tYhVE5G3VPlys9H2JSHvNnE2
         W9s1o+mVNMumRNWAelNmLmV6Yo651p1kfvwgl3zY+EATANj2ay9fLLXAZ+s9aIL/I7En
         d64MIUoqVJH0SdKVz6wBz82u/sytVcbOIRbWv07U+189im7R7fT2jArmeQqChO46t73m
         Y9gUuDdh4aPo9lPPvCMiRuSyFYM//1gn15VGVeGNrC4vDb1E+WJ67fPUt06bnYGc//b5
         yHqzlZhoM/JOD3xo2x9UiIojp5PyQl5YGrbcRvNAnylhcG3gzh3RexHMBNh3af71rPfV
         BjNQ==
X-Gm-Message-State: AOJu0YyyvHRzkmGzNCmvSxcOmVoN9h9JTroyXuOKglu1yormlPSlR8t0
        QbDjIQPhJ9lDcwLk55q6e0pMSxhLZjrXBK5o3hCOuxfsOOh7Z7gpBbRp66HXS0pxHn3kTDVS5XD
        +YSkM6NOdPjAA6wxFkMuvQ/CIkAMwPh3LnbyFm0dc+Er80ji6jEZs5wsq3wlaYCs=
X-Google-Smtp-Source: AGHT+IECJ7fiJwhAiETxUV6rp/FT3q3FcHQnT37r/c5xR/k3lrYaohQFXUBcnLQ6fV5K3kq0O3ZimBdPgiHvvw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:83ba:288:9608:d4be])
 (user=steadmon job=sendgmr) by 2002:a25:6983:0:b0:d49:e117:3a17 with SMTP id
 e125-20020a256983000000b00d49e1173a17mr176512ybc.4.1692827637596; Wed, 23 Aug
 2023 14:53:57 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:53:49 -0700
In-Reply-To: <cover.1692827403.git.steadmon@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <cover.1692827403.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <cb92a1f2e3098bede386d04da32fcc4f27fca51f.1692827403.git.steadmon@google.com>
Subject: [PATCH v2 2/4] config: report config parse errors using cb
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

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/config.c   |   4 +-
 bundle-uri.c       |   4 +-
 config.c           | 175 ++++++++++++++++++++++++++-------------------
 config.h           |  20 ++++--
 fsck.c             |   4 +-
 submodule-config.c |   9 ++-
 6 files changed, 129 insertions(+), 87 deletions(-)

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
index 1518f70fc2..6cf4dafc6c 100644
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
@@ -1028,6 +1031,56 @@ static void kvi_from_source(struct config_source *cs,
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
@@ -1035,8 +1088,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 	int comment = 0;
 	size_t baselen = 0;
 	struct strbuf *var = &cs->var;
-	int error_return = 0;
-	char *error_msg = NULL;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -1118,53 +1169,14 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
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
+	/*
+	 * FIXME for whatever reason, do_event passes the _previous_ event, so
+	 * in order for our callback to receive the error event, we have to call
+	 * do_event twice
+	 */
+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
+	return -1;
 }
 
 static uintmax_t get_unit_factor(const char *end)
@@ -2001,7 +2013,6 @@ static int do_config_from_file(config_fn_t fn,
 	top.origin_type = origin_type;
 	top.name = name;
 	top.path = path;
-	top.default_error_action = CONFIG_ERROR_DIE;
 	top.do_fgetc = config_file_fgetc;
 	top.do_ungetc = config_file_ungetc;
 	top.do_ftell = config_file_ftell;
@@ -2015,8 +2026,10 @@ static int do_config_from_file(config_fn_t fn,
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
@@ -2039,8 +2052,10 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
+
 	return git_config_from_file_with_options(fn, filename, data,
-						 CONFIG_SCOPE_UNKNOWN, NULL);
+						 CONFIG_SCOPE_UNKNOWN, &config_opts);
 }
 
 int git_config_from_mem(config_fn_t fn,
@@ -2057,7 +2072,6 @@ int git_config_from_mem(config_fn_t fn,
 	top.origin_type = origin_type;
 	top.name = name;
 	top.path = NULL;
-	top.default_error_action = CONFIG_ERROR_ERROR;
 	top.do_fgetc = config_buf_fgetc;
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
@@ -2076,6 +2090,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	char *buf;
 	unsigned long size;
 	int ret;
+	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
 
 	buf = repo_read_object_file(repo, oid, &type, &size);
 	if (!buf)
@@ -2086,7 +2101,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	}
 
 	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
-				  data, scope, NULL);
+				  data, scope, &config_opts);
 	free(buf);
 
 	return ret;
@@ -2187,29 +2202,32 @@ static int do_git_config_sequence(const struct config_options *opts,
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
@@ -2250,7 +2268,7 @@ int config_with_options(config_fn_t fn, void *data,
 	} else if (config_source && config_source->file) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
-							NULL);
+							&opts->parse_options);
 	} else if (config_source && config_source->blob) {
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
@@ -2288,9 +2306,11 @@ static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 
 void read_early_config(config_fn_t cb, void *data)
 {
-	struct config_options opts = {0};
 	struct strbuf commondir = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts.respect_includes = 1;
 
@@ -2322,7 +2342,9 @@ void read_early_config(config_fn_t cb, void *data)
  */
 void read_very_early_config(config_fn_t cb, void *data)
 {
-	struct config_options opts = { 0 };
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts.respect_includes = 1;
 	opts.ignore_repo = 1;
@@ -2613,7 +2635,9 @@ int git_configset_get_pathname(struct config_set *set, const char *key, const ch
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
-	struct config_options opts = { 0 };
+	struct config_options opts = {
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
+	};
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2760,12 +2784,14 @@ int repo_config_get_pathname(struct repository *repo,
 static void read_protected_config(void)
 {
 	struct config_options opts = {
-		.respect_includes = 1,
-		.ignore_repo = 1,
-		.ignore_worktree = 1,
-		.system_gently = 1,
+		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
 	};
 
+	opts.respect_includes = 1;
+	opts.ignore_repo = 1;
+	opts.ignore_worktree = 1;
+	opts.system_gently = 1;
+
 	git_configset_init(&protected_config);
 	config_with_options(config_set_callback, &protected_config, NULL,
 			    NULL, &opts);
@@ -2976,6 +3002,7 @@ struct config_store_data {
 		enum config_event_t type;
 		int is_keys_section;
 	} *parsed;
+	enum config_error_action error_action;
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
@@ -3043,6 +3070,10 @@ static int store_aux_event(enum config_event_t type, size_t begin, size_t end,
 			store->seen[store->seen_nr] = store->parsed_nr;
 		}
 	}
+	if (type == CONFIG_EVENT_ERROR) {
+		return git_config_err_fn(type, begin, end, cs,
+					 &store->error_action);
+	}
 
 	store->parsed_nr++;
 
@@ -3380,7 +3411,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		struct stat st;
 		size_t copy_begin, copy_end;
 		int i, new_line = 0;
-		struct config_parse_options opts;
+		struct config_parse_options opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
 
 		if (!value_pattern)
 			store.value_pattern = NULL;
@@ -3407,8 +3438,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
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
2.42.0.rc1.204.g551eb34607-goog

