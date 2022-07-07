Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F43BC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiGGXCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiGGXCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:02:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEF61D58
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:02:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h17so15114771wrx.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+47/GbOutYwggWiEVTgWMbNChHz1yDrXOQT+AmNQ6P0=;
        b=mfhf+B9Bxh0GbslVYnm0dFVKx5zK18yqKNQbBjNlyDRJ8IhESL+ctizL2x8TKaV9Oa
         Ck6SkJQKz1sXHldvUeuhx4qN2UOiwmYPsvUN843duGjMi1OMJjrEsq9XjHN5P/TomyDg
         Zds4T+57Nbv0N6rJphZ2uHPQaxFu0RDhy4lnhoSS+sLv1xEJQAwCZJnHU/LRmKkmp2OZ
         OZNJg3Pwab2yAph1TE++G0pB5RRW5ztwsVIPvXOvzW13fpuqXPPM1jVTB8W2Ug9rFYmG
         9fda9HiLoQV0NyFLMIcA2meD5O1ppK0LW0nAWJaRrnUpkFxcI/Eo+hpz2i0ANElzMoRa
         Boyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+47/GbOutYwggWiEVTgWMbNChHz1yDrXOQT+AmNQ6P0=;
        b=sCDIITJ0+X77ok/uN0z0W+bjaJKoyZ+2LPQ1lcuI5L0gVP9K9LV6w+n1kJaYG+Xvfc
         w4MnISW+GOq29xaDdG+3EwBHQkDMchbYaOWTNKNp5XhfdjzJf9+y1HgbTm6ByW/h55j+
         bLXHHkfrqQDx0z32HRm0mju7cPwoIbptEOpK2CvexuRW0h5xi0OC9UUHyj/YG0VAblxi
         5/C8o/Rzpmt7Vp2OF6LRangMLzjK6zF3AluQvqNR6Iid2Pvftedskb/QAr6SRk3sZTkh
         73czHzjE8VzvXuJspB6G6F/TJdiVB/1vN6ofk1vGBgbmFzU5sOsUMZQEJ/2zEshc5UvR
         sw8w==
X-Gm-Message-State: AJIora+EXhc4i0QlNpK8oNUzU3N3bghYokBjbJpCV6J13lJ1uCys4+qk
        fqlq978noYBIVC4OGlrJb+au6/no3Ec=
X-Google-Smtp-Source: AGRyM1swETGGcE0hE9pjJ57ASAsPe8+6mEl1c9x5KXHnqDrzTcBFsi4hp277chFmghu3/hAYbHvZVA==
X-Received: by 2002:a05:6000:1a88:b0:21b:ca70:f61d with SMTP id f8-20020a0560001a8800b0021bca70f61dmr235145wry.619.1657234920218;
        Thu, 07 Jul 2022 16:02:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12-20020adff5cc000000b0021d80f53324sm4188835wrp.7.2022.07.07.16.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:01:59 -0700 (PDT)
Message-Id: <3683d20f23218260bf4f4555a385205f03012565.1657234914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 23:01:52 +0000
Subject: [PATCH v7 3/5] config: learn `git_protected_config()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

`uploadpack.packObjectsHook` is the only 'protected configuration only'
variable today, but we've noted that `safe.directory` and the upcoming
`discovery.bare` should also be 'protected configuration only'. So, for
consistency, we'd like to have a single implementation for protected
configuration.

The primary constraints are:

1. Reading from protected configuration should be fast. Nearly all "git"
   commands inside a bare repository will read both `safe.directory` and
   `discovery.bare`, so we cannot afford to be slow.

2. Protected configuration must be readable when the gitdir is not
   known. `safe.directory` and `discovery.bare` both affect repository
   discovery and the gitdir is not known at that point [1].

The chosen implementation in this commit is to read protected
configuration and cache the values in a global configset. This is
similar to the caching behavior we get with the_repository->config.

Introduce git_protected_config(), which reads protected configuration
and caches them in the global configset protected_config. Then, refactor
`uploadpack.packObjectsHook` to use git_protected_config().

The protected configuration functions are named similarly to their
non-protected counterparts, e.g. git_protected_config_check_init() vs
git_config_check_init().

In light of constraint 1, this implementation can still be improved.
git_protected_config() iterates through every variable in
protected_config, which is wasteful, but it makes the conversion simple
because it matches existing patterns. We will likely implement constant
time lookup functions for protected configuration in a future series
(such functions already exist for non-protected configuration, i.e.
repo_config_get_*()).

An alternative that avoids introducing another configset is to continue
to read all config using git_config(), but only accept values that have
the correct config scope [2]. This technically fulfills constraint 2,
because git_config() simply ignores the local and worktree config when
the gitdir is not known. However, this would read incomplete config into
the_repository->config, which would need to be reset when the gitdir is
known and git_config() needs to read the local and worktree config.
Resetting the_repository->config might be reasonable while we only have
these 'protected configuration only' variables, but it's not clear
whether this extends well to future variables.

[1] In this case, we do have a candidate gitdir though, so with a little
refactoring, it might be possible to provide a gitdir.
[2] This is how `uploadpack.packObjectsHook` was implemented prior to
this commit.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c                     | 43 ++++++++++++++++++++++++++++++++++++
 config.h                     | 16 ++++++++++++++
 t/t5544-pack-objects-hook.sh |  7 +++++-
 upload-pack.c                | 27 +++++++++++++---------
 4 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 9b0e9c93285..015bec360f5 100644
--- a/config.c
+++ b/config.c
@@ -81,6 +81,17 @@ static enum config_scope current_parsing_scope;
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
+/*
+ * Config that comes from trusted scopes, namely:
+ * - CONFIG_SCOPE_SYSTEM (e.g. /etc/gitconfig)
+ * - CONFIG_SCOPE_GLOBAL (e.g. $HOME/.gitconfig, $XDG_CONFIG_HOME/git)
+ * - CONFIG_SCOPE_COMMAND (e.g. "-c" option, environment variables)
+ *
+ * This is declared here for code cleanliness, but unlike the other
+ * static variables, this does not hold config parser state.
+ */
+static struct config_set protected_config;
+
 static int config_file_fgetc(struct config_source *conf)
 {
 	return getc_unlocked(conf->u.file);
@@ -2378,6 +2389,11 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
 	return git_config_from_file(config_set_callback, filename, cs);
 }
 
+int git_configset_add_parameters(struct config_set *cs)
+{
+	return git_config_from_parameters(config_set_callback, cs);
+}
+
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
@@ -2619,6 +2635,33 @@ int repo_config_get_pathname(struct repository *repo,
 	return ret;
 }
 
+/* Read values into protected_config. */
+static void read_protected_config(void)
+{
+	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
+
+	git_configset_init(&protected_config);
+
+	system_config = git_system_config();
+	git_global_config(&user_config, &xdg_config);
+
+	git_configset_add_file(&protected_config, system_config);
+	git_configset_add_file(&protected_config, xdg_config);
+	git_configset_add_file(&protected_config, user_config);
+	git_configset_add_parameters(&protected_config);
+
+	free(system_config);
+	free(xdg_config);
+	free(user_config);
+}
+
+void git_protected_config(config_fn_t fn, void *data)
+{
+	if (!protected_config.hash_initialized)
+		read_protected_config();
+	configset_iter(&protected_config, fn, data);
+}
+
 /* Functions used historically to read configuration from 'the_repository' */
 void git_config(config_fn_t fn, void *data)
 {
diff --git a/config.h b/config.h
index 7654f61c634..ca994d77147 100644
--- a/config.h
+++ b/config.h
@@ -446,6 +446,15 @@ void git_configset_init(struct config_set *cs);
  */
 int git_configset_add_file(struct config_set *cs, const char *filename);
 
+/**
+ * Parses command line options and environment variables, and adds the
+ * variable-value pairs to the `config_set`. Returns 0 on success, or -1
+ * if there is an error in parsing. The caller decides whether to free
+ * the incomplete configset or continue using it when the function
+ * returns -1.
+ */
+int git_configset_add_parameters(struct config_set *cs);
+
 /**
  * Finds and returns the value list, sorted in order of increasing priority
  * for the configuration variable `key` and config set `cs`. When the
@@ -505,6 +514,13 @@ int repo_config_get_maybe_bool(struct repository *repo,
 int repo_config_get_pathname(struct repository *repo,
 			     const char *key, const char **dest);
 
+/*
+ * Functions for reading protected config. By definition, protected
+ * config ignores repository config, so these do not take a `struct
+ * repository` parameter.
+ */
+void git_protected_config(config_fn_t fn, void *data);
+
 /**
  * Querying For Specific Variables
  * -------------------------------
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index dd5f44d986f..54f54f8d2eb 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -56,7 +56,12 @@ test_expect_success 'hook does not run from repo config' '
 	! grep "hook running" stderr &&
 	test_path_is_missing .git/hook.args &&
 	test_path_is_missing .git/hook.stdin &&
-	test_path_is_missing .git/hook.stdout
+	test_path_is_missing .git/hook.stdout &&
+
+	# check that global config is used instead
+	test_config_global uploadpack.packObjectsHook ./hook &&
+	git clone --no-local . dst2.git 2>stderr &&
+	grep "hook running" stderr
 '
 
 test_expect_success 'hook works with partial clone' '
diff --git a/upload-pack.c b/upload-pack.c
index 3a851b36066..09f48317b02 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1321,18 +1321,27 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		data->advertise_sid = git_config_bool(var, value);
 	}
 
-	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
-	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
-		if (!strcmp("uploadpack.packobjectshook", var))
-			return git_config_string(&data->pack_objects_hook, var, value);
-	}
-
 	if (parse_object_filter_config(var, value, data) < 0)
 		return -1;
 
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
+{
+	struct upload_pack_data *data = cb_data;
+
+	if (!strcmp("uploadpack.packobjectshook", var))
+		return git_config_string(&data->pack_objects_hook, var, value);
+	return 0;
+}
+
+static void get_upload_pack_config(struct upload_pack_data *data)
+{
+	git_config(upload_pack_config, data);
+	git_protected_config(upload_pack_protected_config, data);
+}
+
 void upload_pack(const int advertise_refs, const int stateless_rpc,
 		 const int timeout)
 {
@@ -1340,8 +1349,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 	struct upload_pack_data data;
 
 	upload_pack_data_init(&data);
-
-	git_config(upload_pack_config, &data);
+	get_upload_pack_config(&data);
 
 	data.stateless_rpc = stateless_rpc;
 	data.timeout = timeout;
@@ -1695,8 +1703,7 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 
 	upload_pack_data_init(&data);
 	data.use_sideband = LARGE_PACKET_MAX;
-
-	git_config(upload_pack_config, &data);
+	get_upload_pack_config(&data);
 
 	while (state != FETCH_DONE) {
 		switch (state) {
-- 
gitgitgadget

