Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BA1C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349197AbiEZVtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244172AbiEZVtL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E8BA557
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i9so3622924wrc.13
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Rt8jZtS+yiXhlKyKszzHqUFdx87AzLiQnNRSQBgwxQ=;
        b=PiDPygEulMRY5T3A+f7SmDhHuj66VgNi5tyOAAGTvbb6nhWz+YrzstEofsFxVwQHiK
         nqYrsAqhbbTJr/RhJLnksVEaPkvPgwKFWeGjYbjLqSttto6Fh5xI8bwuAf2+CNez9Tkh
         5+Ejg8jcQuXKIwruLUlFAlyxj5Z2MYE4Pf3BCoIFR1M43Q/5pcw2uYtEV3BCu1DzRKvx
         ByWFJZlRDAjXMH+oLULEUwUmruEDWnnqWhmvZF+QgBAjKcVIOyIswfYltbQOoBPH0qyI
         DdoWkiR6znTMpPTlC9Mz/7hOU8WbwZnTKG7vh6cvkWg/qeJ6onfE+yuvD0gqPQihffab
         JCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Rt8jZtS+yiXhlKyKszzHqUFdx87AzLiQnNRSQBgwxQ=;
        b=Bq6uvEMsLh2sB/pM4dwtfFIwa/BkdqZtXFytdW55UUAkclMVdFKy7Meoko1sm2JKgu
         dMwjGtcwFmKBMFeUTAq9bGHnXucl8lv9dLVQ2hGG70Y6I0Eq9+4dk+HrY0dDgNwSkjSk
         crlkfSGGZRFIyoyXUJ2wpJuZ0Y51Hx0PdgL5HO6dgc/aXBBHKtDqa47GfYdEgd0loJcE
         4FNS+Kq3y18+49tBRCw3WDwh6nAILIk/dI8bgFt9rR4oECg6LYlzSIUREvsOdNH+TvZE
         SKxKBqmtGLwROz3a7BtCHwe0SVLHJOFpDLRekOsynRgpigLCYixdYOhn+TOY2JxYLOKE
         SpFg==
X-Gm-Message-State: AOAM5323KSo0qSnX2rCvLx9TZoplSrbamGHMXKmHT9Cd7ug0TqiPBaGe
        ckukBYkh0b9/AlbmM2OOHnGJmPTRz8M=
X-Google-Smtp-Source: ABdhPJx3olRzEQXad8AED2jxV4xUQyDrvsIBCY0jqyFGEPPO5klNDc1kxljW5MJRKcussAJsVKrWTA==
X-Received: by 2002:adf:d1b3:0:b0:20f:fda3:feb6 with SMTP id w19-20020adfd1b3000000b0020ffda3feb6mr8273518wrc.333.1653601748908;
        Thu, 26 May 2022 14:49:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a1c5402000000b003972dcfb614sm304749wmb.14.2022.05.26.14.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:08 -0700 (PDT)
Message-Id: <195f90cc9ef85cae95f084d204b3648da9c51d87.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:46:58 +0000
Subject: [PATCH v9 04/30] fsmonitor-settings: bare repos are incompatible with
 FSMonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Bare repos do not have a worktree, so there is nothing for the
daemon watch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c |  18 +++++
 builtin/update-index.c      |  16 +++++
 fsmonitor-settings.c        | 133 ++++++++++++++++++++++++++++++------
 fsmonitor-settings.h        |  16 +++++
 t/t7519-status-fsmonitor.sh |  23 +++++++
 5 files changed, 186 insertions(+), 20 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 46be55a4618..66b78a0353f 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1423,6 +1423,7 @@ static int try_to_start_background_daemon(void)
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
 	const char *subcmd;
+	enum fsmonitor_reason reason;
 	int detach_console = 0;
 
 	struct option options[] = {
@@ -1449,6 +1450,23 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	prepare_repo_settings(the_repository);
+	/*
+	 * If the repo is fsmonitor-compatible, explicitly set IPC-mode
+	 * (without bothering to load the `core.fsmonitor` config settings).
+	 *
+	 * If the repo is not compatible, the repo-settings will be set to
+	 * incompatible rather than IPC, so we can use one of the __get
+	 * routines to detect the discrepancy.
+	 */
+	fsm_settings__set_ipc(the_repository);
+
+	reason = fsm_settings__get_reason(the_repository);
+	if (reason > FSMONITOR_REASON_OK)
+		die("%s",
+		    fsm_settings__get_incompatible_msg(the_repository,
+						       reason));
+
 	if (!strcmp(subcmd, "start"))
 		return !!try_to_start_background_daemon();
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 876112abb21..01ed4c4976b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1237,6 +1237,22 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+		enum fsmonitor_reason reason = fsm_settings__get_reason(r);
+
+		/*
+		 * The user wants to turn on FSMonitor using the command
+		 * line argument.  (We don't know (or care) whether that
+		 * is the IPC or HOOK version.)
+		 *
+		 * Use one of the __get routines to force load the FSMonitor
+		 * config settings into the repo-settings.  That will detect
+		 * whether the file system is compatible so that we can stop
+		 * here with a nice error message.
+		 */
+		if (reason > FSMONITOR_REASON_OK)
+			die("%s",
+			    fsm_settings__get_incompatible_msg(r, reason));
+
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
 			warning(_("core.fsmonitor is unset; "
 				"set it if you really want to "
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 757d230d538..7d3177d441a 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -9,23 +9,42 @@
  */
 struct fsmonitor_settings {
 	enum fsmonitor_mode mode;
+	enum fsmonitor_reason reason;
 	char *hook_path;
 };
 
-static void lookup_fsmonitor_settings(struct repository *r)
+static enum fsmonitor_reason check_for_incompatible(struct repository *r)
+{
+	if (!r->worktree) {
+		/*
+		 * Bare repositories don't have a working directory and
+		 * therefore have nothing to watch.
+		 */
+		return FSMONITOR_REASON_BARE;
+	}
+
+	return FSMONITOR_REASON_OK;
+}
+
+static struct fsmonitor_settings *alloc_settings(void)
 {
 	struct fsmonitor_settings *s;
+
+	CALLOC_ARRAY(s, 1);
+	s->mode = FSMONITOR_MODE_DISABLED;
+	s->reason = FSMONITOR_REASON_UNTESTED;
+
+	return s;
+}
+
+static void lookup_fsmonitor_settings(struct repository *r)
+{
 	const char *const_str;
 	int bool_value;
 
 	if (r->settings.fsmonitor)
 		return;
 
-	CALLOC_ARRAY(s, 1);
-	s->mode = FSMONITOR_MODE_DISABLED;
-
-	r->settings.fsmonitor = s;
-
 	/*
 	 * Overload the existing "core.fsmonitor" config setting (which
 	 * has historically been either unset or a hook pathname) to
@@ -38,6 +57,8 @@ static void lookup_fsmonitor_settings(struct repository *r)
 	case 0: /* config value was set to <bool> */
 		if (bool_value)
 			fsm_settings__set_ipc(r);
+		else
+			fsm_settings__set_disabled(r);
 		return;
 
 	case 1: /* config value was unset */
@@ -53,18 +74,18 @@ static void lookup_fsmonitor_settings(struct repository *r)
 		return;
 	}
 
-	if (!const_str || !*const_str)
-		return;
-
-	fsm_settings__set_hook(r, const_str);
+	if (const_str && *const_str)
+		fsm_settings__set_hook(r, const_str);
+	else
+		fsm_settings__set_disabled(r);
 }
 
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
 {
 	if (!r)
 		r = the_repository;
-
-	lookup_fsmonitor_settings(r);
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
 
 	return r->settings.fsmonitor->mode;
 }
@@ -73,31 +94,55 @@ const char *fsm_settings__get_hook_path(struct repository *r)
 {
 	if (!r)
 		r = the_repository;
-
-	lookup_fsmonitor_settings(r);
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
 
 	return r->settings.fsmonitor->hook_path;
 }
 
 void fsm_settings__set_ipc(struct repository *r)
 {
+	enum fsmonitor_reason reason = check_for_incompatible(r);
+
+	if (reason != FSMONITOR_REASON_OK) {
+		fsm_settings__set_incompatible(r, reason);
+		return;
+	}
+
+	/*
+	 * Caller requested IPC explicitly, so avoid (possibly
+	 * recursive) config lookup.
+	 */
 	if (!r)
 		r = the_repository;
-
-	lookup_fsmonitor_settings(r);
+	if (!r->settings.fsmonitor)
+		r->settings.fsmonitor = alloc_settings();
 
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
+	r->settings.fsmonitor->reason = reason;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
 
 void fsm_settings__set_hook(struct repository *r, const char *path)
 {
+	enum fsmonitor_reason reason = check_for_incompatible(r);
+
+	if (reason != FSMONITOR_REASON_OK) {
+		fsm_settings__set_incompatible(r, reason);
+		return;
+	}
+
+	/*
+	 * Caller requested hook explicitly, so avoid (possibly
+	 * recursive) config lookup.
+	 */
 	if (!r)
 		r = the_repository;
-
-	lookup_fsmonitor_settings(r);
+	if (!r->settings.fsmonitor)
+		r->settings.fsmonitor = alloc_settings();
 
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_HOOK;
+	r->settings.fsmonitor->reason = reason;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 	r->settings.fsmonitor->hook_path = strdup(path);
 }
@@ -106,9 +151,57 @@ void fsm_settings__set_disabled(struct repository *r)
 {
 	if (!r)
 		r = the_repository;
-
-	lookup_fsmonitor_settings(r);
+	if (!r->settings.fsmonitor)
+		r->settings.fsmonitor = alloc_settings();
 
 	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
+	r->settings.fsmonitor->reason = FSMONITOR_REASON_OK;
+	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
+}
+
+void fsm_settings__set_incompatible(struct repository *r,
+				    enum fsmonitor_reason reason)
+{
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		r->settings.fsmonitor = alloc_settings();
+
+	r->settings.fsmonitor->mode = FSMONITOR_MODE_INCOMPATIBLE;
+	r->settings.fsmonitor->reason = reason;
 	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
 }
+
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
+{
+	if (!r)
+		r = the_repository;
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->reason;
+}
+
+char *fsm_settings__get_incompatible_msg(const struct repository *r,
+					 enum fsmonitor_reason reason)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	switch (reason) {
+	case FSMONITOR_REASON_UNTESTED:
+	case FSMONITOR_REASON_OK:
+		goto done;
+
+	case FSMONITOR_REASON_BARE:
+		strbuf_addf(&msg,
+			    _("bare repository '%s' is incompatible with fsmonitor"),
+			    xgetcwd());
+		goto done;
+	}
+
+	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
+	    reason);
+
+done:
+	return strbuf_detach(&msg, NULL);
+}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index a4c5d7b4889..8d9331c0c0a 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -4,18 +4,34 @@
 struct repository;
 
 enum fsmonitor_mode {
+	FSMONITOR_MODE_INCOMPATIBLE = -1, /* see _reason */
 	FSMONITOR_MODE_DISABLED = 0,
 	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor=<hook_path> */
 	FSMONITOR_MODE_IPC = 2,  /* core.fsmonitor=<true> */
 };
 
+/*
+ * Incompatibility reasons.
+ */
+enum fsmonitor_reason {
+	FSMONITOR_REASON_UNTESTED = 0,
+	FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
+	FSMONITOR_REASON_BARE,
+};
+
 void fsm_settings__set_ipc(struct repository *r);
 void fsm_settings__set_hook(struct repository *r, const char *path);
 void fsm_settings__set_disabled(struct repository *r);
+void fsm_settings__set_incompatible(struct repository *r,
+				    enum fsmonitor_reason reason);
 
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
 
+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
+char *fsm_settings__get_incompatible_msg(const struct repository *r,
+					 enum fsmonitor_reason reason);
+
 struct fsmonitor_settings;
 
 #endif /* FSMONITOR_SETTINGS_H */
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index a6308acf006..9a8e21c5608 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -55,6 +55,29 @@ test_lazy_prereq UNTRACKED_CACHE '
 	test $ret -ne 1
 '
 
+# Test that we detect and disallow repos that are incompatible with FSMonitor.
+test_expect_success 'incompatible bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual expect" &&
+	git init --bare bare-clone &&
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=foo \
+			update-index --fsmonitor 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual &&
+
+	test_must_fail \
+		git -C ./bare-clone -c core.fsmonitor=true \
+			update-index --fsmonitor 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual
+'
+
+test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
+	test_when_finished "rm -rf ./bare-clone actual" &&
+	git init --bare bare-clone &&
+	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
+	grep "bare repository .* is incompatible with fsmonitor" actual
+'
+
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	: >tracked &&
-- 
gitgitgadget

