Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790F2C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiITUdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITUdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:33:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08495386B0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:33:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z6so6514395wrq.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=7wBU2ZNtyaRNLLfID7o43M7zmQWO6AAXeTFR890+7Mo=;
        b=WD5OMZxLUwneyfHWN1BDYd6shTzacBbZevXwlF4CubMTpQL/CAhpDI51rZ5nJhUkq6
         NoclhnNpLkY2AD0RHz/xwnUyCKrnCKDwqQ9kltqXQIr8xM32G5DxPuHAgg3tysaOcnzg
         qbqjAxAYENdzap1/2nNpSqiXVk5HMxBcnXJeHMaYUrW9IET8J3l71DRLi+SKmCva9bW8
         DxBxspj9T1/xn5Hwd5WYa0IXxiXCLa91euJq8b2WT6PpwaMD2gUHt6XRdzCHRu9md1/m
         YfpwqZqX/5g1ZZTaYN0/nkYKwJRYu1TJ7o6rM19sZ4+8wcoES/8mI+RVH9SYNp1i1Bq5
         DIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7wBU2ZNtyaRNLLfID7o43M7zmQWO6AAXeTFR890+7Mo=;
        b=c3OYAkSaXM3gZgcbMtVNxJfTWaVYAJ7jhwMycaqQDzBifflTutSjbuLVEnjt3PX06e
         MSMQ3bwiTc8YQiLjabTcAT70xyr17ADu9zy1WWTbZOH0Kz0C6XPiKYslqdbsjpYVhNlm
         rdXSsLejegwjQNGeF7PZ5o+kmRhxlB2ogxaQtJWxQh21fOIZVQnne+sqyA6jKerhd+BP
         lEWNGtsNrRePc6zHSN9tbUeO23cwJOZ3g0HRFViWUnCWDxvqTTKa5/XAs+KLfrWwNidc
         m/NxWVcPAMigFxmD8DFRInbwlHV9GYrrxaW4Qt9fwXCmBKeMAI5++9fxGM2SII+K7p5n
         FXQw==
X-Gm-Message-State: ACrzQf1tVb1Cxm53pR9UaorR3D+b7w7GTsHp42qy9tnjtyqMG4rH2KCJ
        lHuaRuMRCiWR8K+hUmOfVZ9XSMQXEis=
X-Google-Smtp-Source: AMsMyM64htU/8nya6uGaCJEtIM6C/HHO6lv68OQjp6zmBTXtVPjdXpCQ/WMrp5rjR/bRDatDVWvkJw==
X-Received: by 2002:adf:f94b:0:b0:22a:4306:b773 with SMTP id q11-20020adff94b000000b0022a4306b773mr14792515wrr.307.1663705990363;
        Tue, 20 Sep 2022 13:33:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056000061400b00228d7078c4esm806490wrb.4.2022.09.20.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:33:09 -0700 (PDT)
Message-Id: <dbe113abb875bae568d75c23f0eadd363c3eb905.1663705986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
References: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
        <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 20:33:02 +0000
Subject: [PATCH v10 2/6] fsmonitor: relocate socket file if .git directory is
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
 compat/fsmonitor/fsm-ipc-darwin.c      | 51 ++++++++++++++++++++++++++
 compat/fsmonitor/fsm-ipc-win32.c       |  9 +++++
 compat/fsmonitor/fsm-settings-darwin.c |  2 +-
 contrib/buildsystems/CMakeLists.txt    |  2 +
 fsmonitor-ipc.c                        | 18 ++++-----
 fsmonitor-ipc.h                        |  4 +-
 8 files changed, 77 insertions(+), 13 deletions(-)
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
index 00000000000..0f551e5e572
--- /dev/null
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -0,0 +1,51 @@
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
+	char *sock_dir = NULL;
+	struct strbuf ipc_file = STRBUF_INIT;
+	unsigned char hash[SHA_DIGEST_LENGTH];
+
+	if (!r)
+		BUG("No repository passed into fsmonitor_ipc__get_path");
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
+	} else {
+		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
+	}
+	free(sock_dir);
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
index 00000000000..e08c505c148
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

