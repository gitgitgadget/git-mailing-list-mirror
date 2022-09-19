Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B60FECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiISTiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiISTiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:38:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848A175BB
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z6so802333wrq.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=NBvhNBZ7DRCHK9Lpr9kfdIMe7wvAPVlWQpq6adf3Uxk=;
        b=j8t2layLPk5hV7vYUOayEkxiMlXjKglRasczRFy34eHN7zzMyHDeDIJSkkE78ByNLd
         ZO8RrrSEP6ZEMaNPd4OiZLV3/HBpLynQerFdY4nLO7ZbWS1HM8pEiEZsYGJQAbpPg4aD
         mJLy8MKGKqribmJfsHql3j2DCBzvJrEQbCxivYRdJUnGhU3N6avOx0Mh8F6ug9dRT5bR
         XD3+msvhlL8Te4JfuAzmGmXdfOd/SzCRd3R11P4NFxRxSRxhik7uAPHVmCm5rTQAn3iG
         QvvtBRzBO6luSaAgkH837B0gtg5fCZfELDtByEB/VKmD9LWoudacTXaWgIDdcYkvWEXy
         wdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NBvhNBZ7DRCHK9Lpr9kfdIMe7wvAPVlWQpq6adf3Uxk=;
        b=lLpqY+X0AgD0YNg4mNpJ+cSWmo3qu62sgpgKPIzsTDMsd+m75pGo/jsPAIgI//NQw5
         rkowdOjoMmOMMyrJlalNNQZTLk4DfSh02eCGTFX4Rh5THunzC50SCkg/ujPicJg29MKa
         6ix5UmaCS2roIz2GZ0m59zVw3u09EM/uAV5rWK5sWO2G4CkKYSxDPnbxL+Tcjww4UNiI
         8ZxQ+R3eESDekvwnqTRiPuqK+T/O67PUgbozAtyrDO/ud5Z95Zqj5ZVmPIh1vLhH9tYY
         aIlOaLZO140Y0Q95g6NMC6lMnZKU1cZ2E35iPXTtZf9SQ4zHxNCfPyHQwO6XVVBquNss
         kiBA==
X-Gm-Message-State: ACrzQf2tziHioUmATEDCoi9z1AShlT7OwOkPOCHJyDEUqsBMdc5Y80AA
        sNuLGWLyi9+jtYZ6WOJGCU7T7xZ1hGI=
X-Google-Smtp-Source: AMsMyM457vikaULT3RGDCzqN/+bRW6r7+Ag6LcKWTF7Wr4gXIA6OXJrs+tAiGjjxz6hEoILft5iINQ==
X-Received: by 2002:a5d:64c2:0:b0:228:cb2b:f38d with SMTP id f2-20020a5d64c2000000b00228cb2bf38dmr11662912wri.491.1663616280579;
        Mon, 19 Sep 2022 12:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az24-20020adfe198000000b00228d7078c4esm15029790wrb.4.2022.09.19.12.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:38:00 -0700 (PDT)
Message-Id: <68709d788d531805d9328e16f53381fcd8d7bd5e.1663616277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
References: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
        <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 19:37:53 +0000
Subject: [PATCH v9 2/6] fsmonitor: relocate socket file if .git directory is
 remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

If the .git directory is on a remote file system, create the socket
file in 'fsmonitor.socketDir' if it is defined, else create it in $HOME.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 Makefile                               |  1 +
 builtin/fsmonitor--daemon.c            |  3 +-
 compat/fsmonitor/fsm-ipc-darwin.c      | 48 ++++++++++++++++++++++++++
 compat/fsmonitor/fsm-ipc-win32.c       |  9 +++++
 compat/fsmonitor/fsm-settings-darwin.c |  2 +-
 contrib/buildsystems/CMakeLists.txt    |  2 ++
 fsmonitor-ipc.c                        | 18 +++++-----
 fsmonitor-ipc.h                        |  4 ++-
 8 files changed, 74 insertions(+), 13 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c

diff --git a/Makefile b/Makefile
index 6e492a67547..58bb9248471 100644
--- a/Makefile
+++ b/Makefile
@@ -2034,6 +2034,7 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 2c109cf8b37..0123fc33ed2 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1343,7 +1343,8 @@ static int fsmonitor_run_daemon(void)
 	 * directory.)
 	 */
 	strbuf_init(&state.path_ipc, 0);
-	strbuf_addstr(&state.path_ipc, absolute_path(fsmonitor_ipc__get_path()));
+	strbuf_addstr(&state.path_ipc,
+		absolute_path(fsmonitor_ipc__get_path(the_repository)));
 
 	/*
 	 * Confirm that we can create platform-specific resources for the
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
new file mode 100644
index 00000000000..d48d67690ee
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -0,0 +1,48 @@
+#include "cache.h"
+#include "config.h"
+#include "strbuf.h"
+#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-path-utils.h"
+
+static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
+
+const char *fsmonitor_ipc__get_path(struct repository *r)
+{
+	static const char *ipc_path;
+	SHA_CTX sha1ctx;
+	char *sock_dir;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[SHA_DIGEST_LENGTH];
+
+	if (ipc_path)
+		return ipc_path;
+
+	ipc_path = fsmonitor_ipc__get_default_path();
+
+	/* By default the socket file is created in the .git directory */
+	if (fsmonitor__is_fs_remote(ipc_path) < 1)
+		return ipc_path;
+
+	SHA1_Init(&sha1ctx);
+	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
+	SHA1_Final(hash, &sha1ctx);
+
+	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
+
+	/* Create the socket file in either socketDir or $HOME */
+	if (sock_dir && *sock_dir) {
+		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
+					sock_dir, hash_to_hex(hash));
+		free(sock_dir);
+	} else {
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+	}
+
+	ipc_path = interpolate_path(ipc_file.buf, 1);
+	if (!ipc_path)
+		die(_("Invalid path: %s"), ipc_file.buf);
+
+	strbuf_release(&ipc_file);
+	return ipc_path;
+}
diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
new file mode 100644
index 00000000000..3a3a46db209
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-win32.c
@@ -0,0 +1,9 @@
+#include "config.h"
+#include "fsmonitor-ipc.h"
+
+const char *fsmonitor_ipc__get_path(struct repository *r) {
+	static char *ret;
+	if (!ret)
+		ret = git_pathdup("fsmonitor--daemon.ipc");
+	return ret;
+}
\ No newline at end of file
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index dba3ced6bb7..681d8bf963e 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -26,7 +26,7 @@
 static enum fsmonitor_reason check_uds_volume(struct repository *r)
 {
 	struct fs_info fs;
-	const char *ipc_path = fsmonitor_ipc__get_path();
+	const char *ipc_path = fsmonitor_ipc__get_path(r);
 	struct strbuf path = STRBUF_INIT;
 	strbuf_add(&path, ipc_path, strlen(ipc_path));
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index b88494bf59b..7e7b6b9a362 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -308,6 +308,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-win32.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-win32.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
@@ -316,6 +317,7 @@ if(SUPPORTS_SIMPLE_IPC)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 789e7397baa..c0f42301c84 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -18,7 +18,7 @@ int fsmonitor_ipc__is_supported(void)
 	return 0;
 }
 
-const char *fsmonitor_ipc__get_path(void)
+const char *fsmonitor_ipc__get_path(struct repository *r)
 {
 	return NULL;
 }
@@ -47,11 +47,9 @@ int fsmonitor_ipc__is_supported(void)
 	return 1;
 }
 
-GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
-
 enum ipc_active_state fsmonitor_ipc__get_state(void)
 {
-	return ipc_get_active_state(fsmonitor_ipc__get_path());
+	return ipc_get_active_state(fsmonitor_ipc__get_path(the_repository));
 }
 
 static int spawn_daemon(void)
@@ -81,8 +79,8 @@ int fsmonitor_ipc__send_query(const char *since_token,
 	trace2_data_string("fsm_client", NULL, "query/command", tok);
 
 try_again:
-	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
-				       &connection);
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(the_repository),
+						&options, &connection);
 
 	switch (state) {
 	case IPC_STATE__LISTENING:
@@ -117,13 +115,13 @@ try_again:
 
 	case IPC_STATE__INVALID_PATH:
 		ret = error(_("fsmonitor_ipc__send_query: invalid path '%s'"),
-			    fsmonitor_ipc__get_path());
+			    fsmonitor_ipc__get_path(the_repository));
 		goto done;
 
 	case IPC_STATE__OTHER_ERROR:
 	default:
 		ret = error(_("fsmonitor_ipc__send_query: unspecified error on '%s'"),
-			    fsmonitor_ipc__get_path());
+			    fsmonitor_ipc__get_path(the_repository));
 		goto done;
 	}
 
@@ -149,8 +147,8 @@ int fsmonitor_ipc__send_command(const char *command,
 	options.wait_if_busy = 1;
 	options.wait_if_not_found = 0;
 
-	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
-				       &connection);
+	state = ipc_client_try_connect(fsmonitor_ipc__get_path(the_repository),
+						&options, &connection);
 	if (state != IPC_STATE__LISTENING) {
 		die(_("fsmonitor--daemon is not running"));
 		return -1;
diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
index b6a7067c3af..8b489da762b 100644
--- a/fsmonitor-ipc.h
+++ b/fsmonitor-ipc.h
@@ -3,6 +3,8 @@
 
 #include "simple-ipc.h"
 
+struct repository;
+
 /*
  * Returns true if built-in file system monitor daemon is defined
  * for this platform.
@@ -16,7 +18,7 @@ int fsmonitor_ipc__is_supported(void);
  *
  * Returns NULL if the daemon is not supported on this platform.
  */
-const char *fsmonitor_ipc__get_path(void);
+const char *fsmonitor_ipc__get_path(struct repository *r);
 
 /*
  * Try to determine whether there is a `git-fsmonitor--daemon` process
-- 
gitgitgadget

