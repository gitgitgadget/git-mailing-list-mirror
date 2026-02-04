Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A737341323E
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214818; cv=none; b=oOupZnPOCry3aBRwxFEwDKFJN+cVkkX7eWe5KGTq8E5eVNL13tvo/eac40fx70bj+VCQB7F4Ahv7jX71JR0+k9Ws6L3mxaYNgr6OoAR8OoLOjYA6x1INSb82uD/JiF2Yq6VOgv1P5K8etCtt99l/4agxugXrUXyzfXYetv5RiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214818; c=relaxed/simple;
	bh=pJrCQTT20prgOGTOxdn63AsbvYi2UUJ/AEIPtw2j6kM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RaP14yDb/1w5nW2yK2HAUDWmrNVC3tCtp87uEzYOQqWDpNxoerG69C8sP9otATOFARE6GLyp+Q7HIRgESPhHGgmeucoskAbOYryL/2pL2qY+8Z439AvaZIcPYgeM1jPPANOZrJXZHcYY3N8I3Ttpv4uEvcnsO1oEpm7FalsUZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9Tnnrnh; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9Tnnrnh"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45efe81556fso4583803b6e.2
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770214817; x=1770819617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLc5vsQ69NBpP3Jdz60CyujRduTMeE/5hVE1rikkyOE=;
        b=D9TnnrnhIHbiBCXuINHpAABAzW/z8aIg0vj3Ds4XXXEU/jYMnu7EcU+SioyB8vKo0c
         +DDtjRqf641v7TVjv5DTdI9/LmPbbYJpCb2pJMgv7LaPQajRVrxgE6qb3q3nddOos/7X
         IznZuwywOV1ih6eX++qMZ9FIrb9IyVTulxpBiw2w9dr5aEG/mkhiSHEfLgYGHcDHXNTH
         JwR8L2AGqAHSlJvIfqWgY4G/HGuDeebcTAiWt1sO6zj+ntjaNB4hYczgbTOaIm2dqja4
         f+mjJSJn3238Bg+DJXw8V5fjddXETxs1g+DjCSW8OOIeYwy50dgXLz5v1wF3zSNA1PiZ
         HG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214817; x=1770819617;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLc5vsQ69NBpP3Jdz60CyujRduTMeE/5hVE1rikkyOE=;
        b=UPByD570hAZQ+lY7RezfhEFwskN9RcKFY9tBXniyZIckAPVL8fN8J9IfySgEWcskPE
         iNewQ4JVdLRwhhBYlg3jZcj4vH2Cl8ghhReJ3tfBnZChWSbOVrXmLrItSY21jMQO8fRO
         LWjXDZitiH6gI0l6otB5J28E6Erc3hHSDtzewwp/VhVclCcFCmSkjKdrkzeeomIttNWd
         S6hSuZkkhJhmc5djTcs1ssnUhbNDwR5dEZz+7wo0FmXkkBzdsl8XCKup+YJ7pnwhzdaJ
         cwYOSh0plwrltI5WVbgYcz7kcejscUEjGeDDwjeFag4tR622poJbbyAarf+e8Qg/1SdH
         sWCA==
X-Gm-Message-State: AOJu0YyQuwNy3qYsQnslXpp8rslVw9J1XOf7ckKjxCe8exFIldOfptun
	CQmu1tKG58Tf8ol2iZfj0DL6hlWSyJBsXGdqOQ791eWhUq8u7K2cuddDDSWXdQ==
X-Gm-Gg: AZuq6aKNMlPCRHYgCG7BHSb49U7ceB5n6ELkVTQFL4R28F4DEzJR6F/C5loOemSOYFk
	fK8FDB5gxXpmABx5GEgsS3atozGhVwtY5qa6cwwLjM7HczjsRFnn2G2RfBcefvzBE4salBRsQo/
	+6GGjHBxLbYD0MsZaWYMF2lq+FZ3lZ/71R+HHqYl7yfQijLYd0iH3wDpX0Yat+vjTM8pI0H/yEm
	w4O87zc7QWq3f87luT6NJ/Hjmk+80WoXmWDFca2JD+oh7LyQI3ez09xULy7Uyc+U19m8i5Do2tq
	1sQISwdI88gB84b4KMYzXL+vKlwLEz+H2Lw26dkp7RzwtkT4ZsnPZZrGm6+mfxMtSS4KjjRTkrm
	m11jS9nSIHvhES62A2AQoofTMShBFZ6wO4CZp1i/x9y29A3GVlvzq8mPISpY6kpjlS6Z7U2BdaH
	UuUxhmCaQjWhDvrA==
X-Received: by 2002:a05:6808:188a:b0:450:ca65:ef59 with SMTP id 5614622812f47-462d58fb80cmr1648156b6e.30.1770214816900;
        Wed, 04 Feb 2026 06:20:16 -0800 (PST)
Received: from [127.0.0.1] ([52.173.182.164])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d6655070sm1402470b6e.7.2026.02.04.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:20:16 -0800 (PST)
Message-Id: <4be089a4dda63fdc0ea2db00acb47b33befe07ef.1770214803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 14:19:59 +0000
Subject: [PATCH 07/11] config: extract location structs from builtin
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Before reusing these concepts in builtin/config-batch.c, extract the
config_location_options struct from builtin/config.c to config.h with
implementation in config.c.

The only modification in this conversion is the use of a repository
parameter instead of the_repository.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 117 ++++-------------------------------------------
 config.c         |  89 +++++++++++++++++++++++++++++++++++
 config.h         |  20 ++++++++
 3 files changed, 117 insertions(+), 109 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 288ebdfdaa..d129b1204d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -71,20 +71,6 @@ static const char *const builtin_config_edit_usage[] = {
 	OPT_STRING('f', "file", &opts.source.file, N_("file"), N_("use given config file")), \
 	OPT_STRING(0, "blob", &opts.source.blob, N_("blob-id"), N_("read config from given blob object"))
 
-struct config_location_options {
-	struct git_config_source source;
-	struct config_options options;
-	char *file_to_free;
-	int use_global_config;
-	int use_system_config;
-	int use_local_config;
-	int use_worktree_config;
-	int respect_includes_opt;
-};
-#define CONFIG_LOCATION_OPTIONS_INIT { \
-	.respect_includes_opt = -1, \
-}
-
 #define CONFIG_TYPE_OPTIONS(type) \
 	OPT_GROUP(N_("Type")), \
 	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type), \
@@ -772,93 +758,6 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
 
-static void location_options_init(struct config_location_options *opts,
-				  const char *prefix)
-{
-	if (!opts->source.file)
-		opts->source.file = opts->file_to_free =
-			xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
-
-	if (opts->use_global_config + opts->use_system_config +
-	    opts->use_local_config + opts->use_worktree_config +
-	    !!opts->source.file + !!opts->source.blob > 1) {
-		error(_("only one config file at a time"));
-		exit(129);
-	}
-
-	if (!startup_info->have_repository) {
-		if (opts->use_local_config)
-			die(_("--local can only be used inside a git repository"));
-		if (opts->source.blob)
-			die(_("--blob can only be used inside a git repository"));
-		if (opts->use_worktree_config)
-			die(_("--worktree can only be used inside a git repository"));
-	}
-
-	if (opts->source.file &&
-			!strcmp(opts->source.file, "-")) {
-		opts->source.file = NULL;
-		opts->source.use_stdin = 1;
-		opts->source.scope = CONFIG_SCOPE_COMMAND;
-	}
-
-	if (opts->use_global_config) {
-		opts->source.file = opts->file_to_free = git_global_config();
-		if (!opts->source.file)
-			/*
-			 * It is unknown if HOME/.gitconfig exists, so
-			 * we do not know if we should write to XDG
-			 * location; error out even if XDG_CONFIG_HOME
-			 * is set and points at a sane location.
-			 */
-			die(_("$HOME not set"));
-		opts->source.scope = CONFIG_SCOPE_GLOBAL;
-	} else if (opts->use_system_config) {
-		opts->source.file = opts->file_to_free = git_system_config();
-		opts->source.scope = CONFIG_SCOPE_SYSTEM;
-	} else if (opts->use_local_config) {
-		opts->source.file = opts->file_to_free = repo_git_path(the_repository, "config");
-		opts->source.scope = CONFIG_SCOPE_LOCAL;
-	} else if (opts->use_worktree_config) {
-		struct worktree **worktrees = get_worktrees();
-		if (the_repository->repository_format_worktree_config)
-			opts->source.file = opts->file_to_free =
-				repo_git_path(the_repository, "config.worktree");
-		else if (worktrees[0] && worktrees[1])
-			die(_("--worktree cannot be used with multiple "
-			      "working trees unless the config\n"
-			      "extension worktreeConfig is enabled. "
-			      "Please read \"CONFIGURATION FILE\"\n"
-			      "section in \"git help worktree\" for details"));
-		else
-			opts->source.file = opts->file_to_free =
-				repo_git_path(the_repository, "config");
-		opts->source.scope = CONFIG_SCOPE_LOCAL;
-		free_worktrees(worktrees);
-	} else if (opts->source.file) {
-		if (!is_absolute_path(opts->source.file) && prefix)
-			opts->source.file = opts->file_to_free =
-				prefix_filename(prefix, opts->source.file);
-		opts->source.scope = CONFIG_SCOPE_COMMAND;
-	} else if (opts->source.blob) {
-		opts->source.scope = CONFIG_SCOPE_COMMAND;
-	}
-
-	if (opts->respect_includes_opt == -1)
-		opts->options.respect_includes = !opts->source.file;
-	else
-		opts->options.respect_includes = opts->respect_includes_opt;
-	if (startup_info->have_repository) {
-		opts->options.commondir = repo_get_common_dir(the_repository);
-		opts->options.git_dir = repo_get_git_dir(the_repository);
-	}
-}
-
-static void location_options_release(struct config_location_options *opts)
-{
-	free(opts->file_to_free);
-}
-
 static void display_options_init(struct config_display_options *opts)
 {
 	if (opts->end_nul) {
@@ -885,7 +784,7 @@ static int cmd_config_list(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, opts, builtin_config_list_usage, 0);
 	check_argc(argc, 0, 0);
 
-	location_options_init(&location_opts, prefix);
+	location_options_init(the_repository, &location_opts, prefix);
 	display_options_init(&display_opts);
 
 	setup_auto_pager("config", 1);
@@ -944,7 +843,7 @@ static int cmd_config_get(int argc, const char **argv, const char *prefix,
 		    value_pattern))
 		die(_("--url= cannot be used with --all, --regexp or --value"));
 
-	location_options_init(&location_opts, prefix);
+	location_options_init(the_repository, &location_opts, prefix);
 	display_options_init(&display_opts);
 
 	if (display_opts.type != TYPE_COLOR)
@@ -998,7 +897,7 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 
 	comment = git_config_prepare_comment_string(comment_arg);
 
-	location_options_init(&location_opts, prefix);
+	location_options_init(the_repository, &location_opts, prefix);
 	check_write(&location_opts.source);
 
 	value = normalize_value(argv[0], argv[1], type, &default_kvi);
@@ -1044,7 +943,7 @@ static int cmd_config_unset(int argc, const char **argv, const char *prefix,
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
 		die(_("--fixed-value only applies with 'value-pattern'"));
 
-	location_options_init(&location_opts, prefix);
+	location_options_init(the_repository, &location_opts, prefix);
 	check_write(&location_opts.source);
 
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
@@ -1073,7 +972,7 @@ static int cmd_config_rename_section(int argc, const char **argv, const char *pr
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	check_argc(argc, 2, 2);
 
-	location_options_init(&location_opts, prefix);
+	location_options_init(the_repository, &location_opts, prefix);
 	check_write(&location_opts.source);
 
 	ret = repo_config_rename_section_in_file(the_repository, location_opts.source.file,
@@ -1103,7 +1002,7 @@ static int cmd_config_remove_section(int argc, const char **argv, const char *pr
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	check_argc(argc, 1, 1);
 
-	location_options_init(&location_opts, prefix);
+	location_options_init(the_repository, &location_opts, prefix);
 	check_write(&location_opts.source);
 
 	ret = repo_config_rename_section_in_file(the_repository, location_opts.source.file,
@@ -1163,7 +1062,7 @@ static int cmd_config_edit(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, opts, builtin_config_edit_usage, 0);
 	check_argc(argc, 0, 0);
 
-	location_options_init(&location_opts, prefix);
+	location_options_init(the_repository, &location_opts, prefix);
 	check_write(&location_opts.source);
 
 	ret = show_editor(&location_opts);
@@ -1231,7 +1130,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	location_options_init(&location_opts, prefix);
+	location_options_init(the_repository, &location_opts, prefix);
 	display_options_init(&display_opts);
 
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && display_opts.type) {
diff --git a/config.c b/config.c
index 7f6d53b473..9f1a7b45cf 100644
--- a/config.c
+++ b/config.c
@@ -35,6 +35,7 @@
 #include "strvec.h"
 #include "trace2.h"
 #include "wildmatch.h"
+#include "worktree.h"
 #include "write-or-die.h"
 
 struct config_source {
@@ -3592,3 +3593,91 @@ int lookup_config(const char **mapping, int nr_mapping, const char *var)
 	}
 	return -1;
 }
+
+void location_options_init(struct repository *repo,
+			   struct config_location_options *opts,
+			   const char *prefix)
+{
+	if (!opts->source.file)
+		opts->source.file = opts->file_to_free =
+			xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
+
+	if (opts->use_global_config + opts->use_system_config +
+	    opts->use_local_config + opts->use_worktree_config +
+	    !!opts->source.file + !!opts->source.blob > 1) {
+		error(_("only one config file at a time"));
+		exit(129);
+	}
+
+	if (!startup_info->have_repository) {
+		if (opts->use_local_config)
+			die(_("--local can only be used inside a git repository"));
+		if (opts->source.blob)
+			die(_("--blob can only be used inside a git repository"));
+		if (opts->use_worktree_config)
+			die(_("--worktree can only be used inside a git repository"));
+	}
+
+	if (opts->source.file &&
+			!strcmp(opts->source.file, "-")) {
+		opts->source.file = NULL;
+		opts->source.use_stdin = 1;
+		opts->source.scope = CONFIG_SCOPE_COMMAND;
+	}
+
+	if (opts->use_global_config) {
+		opts->source.file = opts->file_to_free = git_global_config();
+		if (!opts->source.file)
+			/*
+			 * It is unknown if HOME/.gitconfig exists, so
+			 * we do not know if we should write to XDG
+			 * location; error out even if XDG_CONFIG_HOME
+			 * is set and points at a sane location.
+			 */
+			die(_("$HOME not set"));
+		opts->source.scope = CONFIG_SCOPE_GLOBAL;
+	} else if (opts->use_system_config) {
+		opts->source.file = opts->file_to_free = git_system_config();
+		opts->source.scope = CONFIG_SCOPE_SYSTEM;
+	} else if (opts->use_local_config) {
+		opts->source.file = opts->file_to_free = repo_git_path(repo, "config");
+		opts->source.scope = CONFIG_SCOPE_LOCAL;
+	} else if (opts->use_worktree_config) {
+		struct worktree **worktrees = get_worktrees();
+		if (repo->repository_format_worktree_config)
+			opts->source.file = opts->file_to_free =
+				repo_git_path(repo, "config.worktree");
+		else if (worktrees[0] && worktrees[1])
+			die(_("--worktree cannot be used with multiple "
+			      "working trees unless the config\n"
+			      "extension worktreeConfig is enabled. "
+			      "Please read \"CONFIGURATION FILE\"\n"
+			      "section in \"git help worktree\" for details"));
+		else
+			opts->source.file = opts->file_to_free =
+				repo_git_path(repo, "config");
+		opts->source.scope = CONFIG_SCOPE_LOCAL;
+		free_worktrees(worktrees);
+	} else if (opts->source.file) {
+		if (!is_absolute_path(opts->source.file) && prefix)
+			opts->source.file = opts->file_to_free =
+				prefix_filename(prefix, opts->source.file);
+		opts->source.scope = CONFIG_SCOPE_COMMAND;
+	} else if (opts->source.blob) {
+		opts->source.scope = CONFIG_SCOPE_COMMAND;
+	}
+
+	if (opts->respect_includes_opt == -1)
+		opts->options.respect_includes = !opts->source.file;
+	else
+		opts->options.respect_includes = opts->respect_includes_opt;
+	if (startup_info->have_repository) {
+		opts->options.commondir = repo_get_common_dir(repo);
+		opts->options.git_dir = repo_get_git_dir(repo);
+	}
+}
+
+void location_options_release(struct config_location_options *opts)
+{
+	free(opts->file_to_free);
+}
diff --git a/config.h b/config.h
index 966a228f0e..6663964977 100644
--- a/config.h
+++ b/config.h
@@ -166,6 +166,26 @@ struct config_context {
 typedef int (*config_fn_t)(const char *, const char *,
 			   const struct config_context *, void *);
 
+struct config_location_options {
+	struct git_config_source source;
+	struct config_options options;
+	char *file_to_free;
+	int use_global_config;
+	int use_system_config;
+	int use_local_config;
+	int use_worktree_config;
+	int respect_includes_opt;
+};
+#define CONFIG_LOCATION_OPTIONS_INIT { \
+	.respect_includes_opt = -1, \
+}
+
+void location_options_init(struct repository *repo,
+			   struct config_location_options *opts,
+			   const char *prefix);
+
+void location_options_release(struct config_location_options *opts);
+
 /**
  * Read a specific file in git-config format.
  * This function takes the same callback and data parameters as `repo_config`.
-- 
gitgitgadget

