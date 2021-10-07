Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726CFC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5857361077
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbhJGNzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbhJGNyv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 09:54:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD8C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 06:52:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m22so19466411wrb.0
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1YVwpBWhduPIBEGb/ezIwHU0s9Zks8sJ5fKK/j9jicM=;
        b=lzMkY3t/Q9fcUr1h4wCNrpVC+cxXzPITwdpNBQkY6XwBnuoZC7O7YK5334iZJqS69Z
         oFHeJwVmsGClBnZR8VuG4Ts8/9dYiF4k+XH24u4ft9r6y3Pt4yyU3iresGQuzQpTIPWI
         I9ghZoHa9tvJB9oqHGFEMXOeiXrTBzTfDiWZGK0MH/An7tWiYvK6NfgT6zbZt3NKr4Xe
         P58y3XYKdJyz5nlwJghaBLJB7HrklOJdEtFhDxchYGImAZx3FzwrudV+geMpayrwZRC1
         PlhvlEDFZpf9Ibcp7iMl8nJElBkYli0z0fsLmXlDSelQ2upr9vlS5KVwLfdnTuXdX3vb
         UNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1YVwpBWhduPIBEGb/ezIwHU0s9Zks8sJ5fKK/j9jicM=;
        b=yefPZcgs82boIpwUxkWm54oJ9Wt+4Tc1FmRH51DiOn4AOtC6upZSxRctQlEpAZgmT4
         chYyM6r9okalwDpNlDR/V3KPxxYl7YMdg1v5ptmq/SpvPOuSBp6CB61yDhmQZNLAx06e
         s9oTtYfDqQDc2q2i0OZ6QJcNghktZV0Rc47VqKnkHCojH+qLER+6D6gocrknb/Fegsxp
         Bipmh5y4E8uuqhglXGRpwjfPsXu4BukIuLGfOLfswJlI50BGmLNtFiPgboiNvDnSlihc
         FN9xYXe+8vCULWiY8Jhwhrr6F3Zg+Op/X4n3gm8JE/Ktfi1bEvkLdS0nbKztlLma+HPn
         7wIw==
X-Gm-Message-State: AOAM532Vgs2ceUz8HF6EE42EoYqG6OQAVxU2oIxZrTuZFgV0IRKCzNqM
        bkfSyCtLaITlJhmf8bY4n6/gZqbAYJk=
X-Google-Smtp-Source: ABdhPJzwgj0MYBiCJZ8hUmFt32Kj+scBjTwLoarFCuwdSGbzXaoZTjEzJUfvb2hWPXAzlsw6YBvb/Q==
X-Received: by 2002:a7b:ce05:: with SMTP id m5mr317289wmc.14.1633614776224;
        Thu, 07 Oct 2021 06:52:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15sm15607423wrl.74.2021.10.07.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:52:55 -0700 (PDT)
Message-Id: <7d5a353e74d2f2a1ed3f9275425bb564265323d6.1633614772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
        <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 13:52:50 +0000
Subject: [PATCH v2 3/5] fsmonitor: config settings are repository-specific
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Move FSMonitor config settings to a new `struct fsmonitor_settings`
structure.  Add a lazily-loaded pointer to `struct repo_settings`.
Create `fsm_settings__get_*()` getters to lazily look up fsmonitor-
related config settings.

Get rid of the `core_fsmonitor` global variable, and add support for
the new `core.useBuiltinFSMonitor` config setting.  Move config code
to lookup the existing `core.fsmonitor` value to `fsmonitor-settings.[ch]`.

The `core_fsmonitor` global variable was used to store the pathname to
the FSMonitor hook and it was used as a boolean to see if FSMonitor
was enabled.  This dual usage will lead to confusion when we add
support for a builtin FSMonitor based on IPC, since the builtin
FSMonitor doesn't need the hook pathname.

Replace the boolean usage with an `enum fsmonitor_mode` to represent
the state of FSMonitor.  And only set the pathname when in HOOK mode.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile               |  1 +
 builtin/update-index.c | 19 +++++++--
 cache.h                |  1 -
 config.c               | 14 ------
 config.h               |  1 -
 environment.c          |  1 -
 fsmonitor-settings.c   | 97 ++++++++++++++++++++++++++++++++++++++++++
 fsmonitor-settings.h   | 21 +++++++++
 fsmonitor.c            | 63 ++++++++++++++++-----------
 fsmonitor.h            | 18 ++++++--
 repo-settings.c        |  2 +
 repository.h           |  3 ++
 t/README               |  4 +-
 13 files changed, 194 insertions(+), 51 deletions(-)
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h

diff --git a/Makefile b/Makefile
index d51fd8b33ce..29ed7c4aba6 100644
--- a/Makefile
+++ b/Makefile
@@ -898,6 +898,7 @@ LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
 LIB_OBJS += fsmonitor-ipc.o
+LIB_OBJS += fsmonitor-settings.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..79db3ff37e2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1214,14 +1214,25 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (fsmonitor > 0) {
-		if (git_config_get_fsmonitor() == 0)
+		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
+			warning(_("core.useBuiltinFSMonitor is unset; "
+				"set it if you really want to enable the "
+				"builtin fsmonitor"));
 			warning(_("core.fsmonitor is unset; "
-				"set it if you really want to "
-				"enable fsmonitor"));
+				"set it if you really want to enable the "
+				"hook-based fsmonitor"));
+		}
 		add_fsmonitor(&the_index);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
-		if (git_config_get_fsmonitor() == 1)
+		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+		if (fsm_mode == FSMONITOR_MODE_IPC)
+			warning(_("core.useBuiltinFSMonitor is set; "
+				"remove it if you really want to "
+				"disable fsmonitor"));
+		if (fsm_mode == FSMONITOR_MODE_HOOK)
 			warning(_("core.fsmonitor is set; "
 				"remove it if you really want to "
 				"disable fsmonitor"));
diff --git a/cache.h b/cache.h
index d092820c943..8f4e3c8bd1d 100644
--- a/cache.h
+++ b/cache.h
@@ -989,7 +989,6 @@ extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
-extern const char *core_fsmonitor;
 
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
diff --git a/config.c b/config.c
index 2dcbe901b6b..6b6e9cacac3 100644
--- a/config.c
+++ b/config.c
@@ -2502,20 +2502,6 @@ int git_config_get_max_percent_split_change(void)
 	return -1; /* default value */
 }
 
-int git_config_get_fsmonitor(void)
-{
-	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
-		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
-
-	if (core_fsmonitor && !*core_fsmonitor)
-		core_fsmonitor = NULL;
-
-	if (core_fsmonitor)
-		return 1;
-
-	return 0;
-}
-
 int git_config_get_index_threads(int *dest)
 {
 	int is_bool, val;
diff --git a/config.h b/config.h
index f119de01309..69d733824a0 100644
--- a/config.h
+++ b/config.h
@@ -610,7 +610,6 @@ int git_config_get_pathname(const char *key, const char **dest);
 int git_config_get_index_threads(int *dest);
 int git_config_get_split_index(void);
 int git_config_get_max_percent_split_change(void);
-int git_config_get_fsmonitor(void);
 
 /* This dies if the configured or default date is in the future */
 int git_config_get_expiry(const char *key, const char **output);
diff --git a/environment.c b/environment.c
index 9da7f3c1a19..68f90632245 100644
--- a/environment.c
+++ b/environment.c
@@ -82,7 +82,6 @@ int protect_hfs = PROTECT_HFS_DEFAULT;
 #define PROTECT_NTFS_DEFAULT 1
 #endif
 int protect_ntfs = PROTECT_NTFS_DEFAULT;
-const char *core_fsmonitor;
 
 /*
  * The character that begins a commented line in user-editable file
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
new file mode 100644
index 00000000000..2770266f5ee
--- /dev/null
+++ b/fsmonitor-settings.c
@@ -0,0 +1,97 @@
+#include "cache.h"
+#include "config.h"
+#include "repository.h"
+#include "fsmonitor-settings.h"
+
+/*
+ * We keep this structure defintion private and have getters
+ * for all fields so that we can lazy load it as needed.
+ */
+struct fsmonitor_settings {
+	enum fsmonitor_mode mode;
+	char *hook_path;
+};
+
+void fsm_settings__set_ipc(struct repository *r)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_IPC;
+}
+
+void fsm_settings__set_hook(struct repository *r, const char *path)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_HOOK;
+	s->hook_path = strdup(path);
+}
+
+void fsm_settings__set_disabled(struct repository *r)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_DISABLED;
+	FREE_AND_NULL(s->hook_path);
+}
+
+static int check_for_ipc(struct repository *r)
+{
+	int value;
+
+	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) &&
+	    value) {
+		fsm_settings__set_ipc(r);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int check_for_hook(struct repository *r)
+{
+	const char *const_str;
+
+	if (repo_config_get_pathname(r, "core.fsmonitor", &const_str))
+		const_str = getenv("GIT_TEST_FSMONITOR");
+
+	if (const_str && *const_str) {
+		fsm_settings__set_hook(r, const_str);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void lookup_fsmonitor_settings(struct repository *r)
+{
+	struct fsmonitor_settings *s;
+
+	CALLOC_ARRAY(s, 1);
+
+	r->settings.fsmonitor = s;
+
+	if (check_for_ipc(r))
+		return;
+
+	if (check_for_hook(r))
+		return;
+
+	fsm_settings__set_disabled(r);
+}
+
+enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
+{
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->mode;
+}
+
+const char *fsm_settings__get_hook_path(struct repository *r)
+{
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->hook_path;
+}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
new file mode 100644
index 00000000000..50b29234616
--- /dev/null
+++ b/fsmonitor-settings.h
@@ -0,0 +1,21 @@
+#ifndef FSMONITOR_SETTINGS_H
+#define FSMONITOR_SETTINGS_H
+
+struct repository;
+
+enum fsmonitor_mode {
+	FSMONITOR_MODE_DISABLED = 0,
+	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor */
+	FSMONITOR_MODE_IPC = 2,  /* core.useBuiltinFSMonitor */
+};
+
+void fsm_settings__set_ipc(struct repository *r);
+void fsm_settings__set_hook(struct repository *r, const char *path);
+void fsm_settings__set_disabled(struct repository *r);
+
+enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
+const char *fsm_settings__get_hook_path(struct repository *r);
+
+struct fsmonitor_settings;
+
+#endif /* FSMONITOR_SETTINGS_H */
diff --git a/fsmonitor.c b/fsmonitor.c
index ec4c46407c5..63174630c0e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
 #include "run-command.h"
 #include "strbuf.h"
 
@@ -148,15 +149,18 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 /*
  * Call the query-fsmonitor hook passing the last update token of the saved results.
  */
-static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
+static int query_fsmonitor_hook(struct repository *r,
+				int version,
+				const char *last_update,
+				struct strbuf *query_result)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int result;
 
-	if (!core_fsmonitor)
+	if (fsm_settings__get_mode(r) != FSMONITOR_MODE_HOOK)
 		return -1;
 
-	strvec_push(&cp.args, core_fsmonitor);
+	strvec_push(&cp.args, fsm_settings__get_hook_path(r));
 	strvec_pushf(&cp.args, "%d", version);
 	strvec_pushf(&cp.args, "%s", last_update);
 	cp.use_shell = 1;
@@ -238,17 +242,28 @@ void refresh_fsmonitor(struct index_state *istate)
 	struct strbuf last_update_token = STRBUF_INIT;
 	char *buf;
 	unsigned int i;
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 
-	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
+	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
+	    istate->fsmonitor_has_run_once)
 		return;
 
-	hook_version = fsmonitor_hook_version();
-
 	istate->fsmonitor_has_run_once = 1;
 
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
+
+	if (fsm_mode == FSMONITOR_MODE_IPC) {
+		/* TODO */
+		return;
+	}
+
+	assert(fsm_mode == FSMONITOR_MODE_HOOK);
+
+	hook_version = fsmonitor_hook_version();
+
 	/*
-	 * This could be racy so save the date/time now and query_fsmonitor
+	 * This could be racy so save the date/time now and query_fsmonitor_hook
 	 * should be inclusive to ensure we don't miss potential changes.
 	 */
 	last_update = getnanotime();
@@ -256,13 +271,14 @@ void refresh_fsmonitor(struct index_state *istate)
 		strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
 
 	/*
-	 * If we have a last update token, call query_fsmonitor for the set of
+	 * If we have a last update token, call query_fsmonitor_hook for the set of
 	 * changes since that token, else assume everything is possibly dirty
 	 * and check it all.
 	 */
 	if (istate->fsmonitor_last_update) {
 		if (hook_version == -1 || hook_version == HOOK_INTERFACE_VERSION2) {
-			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION2,
+			query_success = !query_fsmonitor_hook(
+				r, HOOK_INTERFACE_VERSION2,
 				istate->fsmonitor_last_update, &query_result);
 
 			if (query_success) {
@@ -292,13 +308,17 @@ void refresh_fsmonitor(struct index_state *istate)
 		}
 
 		if (hook_version == HOOK_INTERFACE_VERSION1) {
-			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
+			query_success = !query_fsmonitor_hook(
+				r, HOOK_INTERFACE_VERSION1,
 				istate->fsmonitor_last_update, &query_result);
 		}
 
-		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
-		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
-			core_fsmonitor, query_success ? "success" : "failure");
+		trace_performance_since(last_update, "fsmonitor process '%s'",
+					fsm_settings__get_hook_path(r));
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor process '%s' returned %s",
+				 fsm_settings__get_hook_path(r),
+				 query_success ? "success" : "failure");
 	}
 
 	/*
@@ -434,7 +454,8 @@ void remove_fsmonitor(struct index_state *istate)
 void tweak_fsmonitor(struct index_state *istate)
 {
 	unsigned int i;
-	int fsmonitor_enabled = git_config_get_fsmonitor();
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	int fsmonitor_enabled = (fsm_settings__get_mode(r) > FSMONITOR_MODE_DISABLED);
 
 	if (istate->fsmonitor_dirty) {
 		if (fsmonitor_enabled) {
@@ -454,16 +475,8 @@ void tweak_fsmonitor(struct index_state *istate)
 		istate->fsmonitor_dirty = NULL;
 	}
 
-	switch (fsmonitor_enabled) {
-	case -1: /* keep: do nothing */
-		break;
-	case 0: /* false */
-		remove_fsmonitor(istate);
-		break;
-	case 1: /* true */
+	if (fsmonitor_enabled)
 		add_fsmonitor(istate);
-		break;
-	default: /* unknown value: do nothing */
-		break;
-	}
+	else
+		remove_fsmonitor(istate);
 }
diff --git a/fsmonitor.h b/fsmonitor.h
index f20d72631d7..f9201411aa7 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -3,6 +3,7 @@
 
 #include "cache.h"
 #include "dir.h"
+#include "fsmonitor-settings.h"
 
 extern struct trace_key trace_fsmonitor;
 
@@ -57,7 +58,11 @@ int fsmonitor_is_trivial_response(const struct strbuf *query_result);
  */
 static inline int is_fsmonitor_refreshed(const struct index_state *istate)
 {
-	return !core_fsmonitor || istate->fsmonitor_has_run_once;
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+	return fsm_mode <= FSMONITOR_MODE_DISABLED ||
+		istate->fsmonitor_has_run_once;
 }
 
 /*
@@ -67,7 +72,11 @@ static inline int is_fsmonitor_refreshed(const struct index_state *istate)
  */
 static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
 {
-	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+	if (fsm_mode > FSMONITOR_MODE_DISABLED &&
+	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
 		istate->cache_changed = 1;
 		ce->ce_flags |= CE_FSMONITOR_VALID;
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
@@ -83,7 +92,10 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
  */
 static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
 {
-	if (core_fsmonitor) {
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+	if (fsm_mode > FSMONITOR_MODE_DISABLED) {
 		ce->ce_flags &= ~CE_FSMONITOR_VALID;
 		untracked_cache_invalidate_path(istate, ce->name, 1);
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
diff --git a/repo-settings.c b/repo-settings.c
index b93e91a212e..0ca85f54bb8 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -20,6 +20,8 @@ void prepare_repo_settings(struct repository *r)
 	if (r->settings.initialized++)
 		return;
 
+	r->settings.fsmonitor = NULL; /* lazy loaded */
+
 	/* Defaults */
 	r->settings.index_version = -1;
 	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
diff --git a/repository.h b/repository.h
index a057653981c..89a1873ade7 100644
--- a/repository.h
+++ b/repository.h
@@ -4,6 +4,7 @@
 #include "path.h"
 
 struct config_set;
+struct fsmonitor_settings;
 struct git_hash_algo;
 struct index_state;
 struct lock_file;
@@ -34,6 +35,8 @@ struct repo_settings {
 	int command_requires_full_index;
 	int sparse_index;
 
+	struct fsmonitor_settings *fsmonitor; /* lazy loaded */
+
 	int index_version;
 	enum untracked_cache_setting core_untracked_cache;
 
diff --git a/t/README b/t/README
index b92155a822e..6dc4a1d10cf 100644
--- a/t/README
+++ b/t/README
@@ -405,8 +405,8 @@ every 'git commit-graph write', as if the `--changed-paths` option was
 passed in.
 
 GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
-code path for utilizing a file system monitor to speed up detecting
-new or changed files.
+code path for utilizing a (hook based) file system monitor to speed up
+detecting new or changed files.
 
 GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
 for the index version specified.  Can be set to any valid version
-- 
gitgitgadget

