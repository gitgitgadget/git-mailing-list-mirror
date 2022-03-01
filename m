Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61057C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiCASoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiCASo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66F2A263
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so21922062wrg.11
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sSAmNlfeMp/SuWaNgnRs8TTLxikird+cAhYFRFbfq6s=;
        b=qnCwhso+r4TvkGhw3VyzkXB5uMAVlzOF8k6uXqrTWcJeprvD2DIZx+2A675IY8Lmo2
         lhjPW68xktzolT00pnf7nrA2i6UrZvu13N9krwGKNDHYrzhzB5BrM2JChd2tsOKOmKp7
         CiSsOwFv0sVzlQckgVQ8RofpIou5zdGseVBU0ytO0E3gG+M33ikTXjaW6AjxuJQvMCy8
         C0CC1p2JUnjI/jbT5In/0332A/9PKGy8jfRKeTNcFf/45GdGaWKvgmr4kGolkT14RyOC
         FKvDAYyGKaT/LzrNooGQjtwU6GJCzbxxGJhs6PtVQGjt8gWvZLFhWfVk//ahO9y0oK88
         AfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sSAmNlfeMp/SuWaNgnRs8TTLxikird+cAhYFRFbfq6s=;
        b=Eg6ExdcM82cegr1S9pPoBf09zSPizEz56mvBTooC+rEx/1yQ2CUCKKudd7t2cFXcub
         3EOJQ1EsJGpS16S9jeaUi/l6iQbID/8bBCWr05ixW/AtB1GNaQMUwaxs2Fqd0aDvvfPe
         zTbf9+pZvtzAUc6fTlSqJFbNhhTTdnF/lletzifY9W9cK1YHulJPRSEfDT7/XBw8/Y8p
         5lEBZb4bmFjMJETFpScxupF5eLmndeno7ZfORfmRyBmtp7P13aYWJ5HhkOJPzQMOLis6
         ka7JbLC+VQfCy4LI4LZhQOQ8JyRGaO4WtJHw3flSJWRpZEGCs1gBuMFfirm/gb1tYiM1
         qbZA==
X-Gm-Message-State: AOAM531s5x7+xUnJa+NJmVOwf9OUKD/HbWvie0TAnx3DJLXNxEUErf4D
        NmpctE8o9f1jG64zWnR8UP/vTseLeB8=
X-Google-Smtp-Source: ABdhPJwdL2jBaGpjOD2l9UGAK1E6uZxsByTEAyY7tJskvAMLqG17KuH2G5C62pvy3pPFea39qzclKw==
X-Received: by 2002:a05:6000:18a1:b0:1ef:8e17:e82c with SMTP id b1-20020a05600018a100b001ef8e17e82cmr12230049wri.254.1646160221534;
        Tue, 01 Mar 2022 10:43:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c241100b0037c01ad7152sm4428592wmp.14.2022.03.01.10.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:41 -0800 (PST)
Message-Id: <92d3e54da7f1e6148ba521b5377af17900f7d42d.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:10 +0000
Subject: [PATCH v6 08/30] compat/fsmonitor/fsm-listen-win32: stub in backend
 for Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Stub in empty filesystem listener backend for fsmonitor--daemon on Windows.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                            | 13 ++++++++
 compat/fsmonitor/fsm-listen-win32.c | 21 +++++++++++++
 compat/fsmonitor/fsm-listen.h       | 49 +++++++++++++++++++++++++++++
 config.mak.uname                    | 10 ++++++
 contrib/buildsystems/CMakeLists.txt |  7 +++++
 repo-settings.c                     |  1 +
 6 files changed, 101 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-listen-win32.c
 create mode 100644 compat/fsmonitor/fsm-listen.h

diff --git a/Makefile b/Makefile
index 5af1d5b112e..26567d4f772 100644
--- a/Makefile
+++ b/Makefile
@@ -470,6 +470,11 @@ all::
 # directory, and the JSON compilation database 'compile_commands.json' will be
 # created at the root of the repository.
 #
+# If your platform supports a built-in fsmonitor backend, set
+# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
+# `compat/fsmonitor/fsm-listen-<name>.c` that implements the
+# `fsm_listen__*()` routines.
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -1968,6 +1973,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
 	COMPAT_OBJS += compat/access.o
 endif
 
+ifdef FSMONITOR_DAEMON_BACKEND
+	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
+	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2887,6 +2897,9 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
 	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
+ifdef FSMONITOR_DAEMON_BACKEND
+	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
+endif
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
new file mode 100644
index 00000000000..916cbea254f
--- /dev/null
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsm-listen.h"
+
+void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsm_listen__loop(struct fsmonitor_daemon_state *state)
+{
+}
+
+int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
+{
+	return -1;
+}
+
+void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/compat/fsmonitor/fsm-listen.h b/compat/fsmonitor/fsm-listen.h
new file mode 100644
index 00000000000..f0539349baf
--- /dev/null
+++ b/compat/fsmonitor/fsm-listen.h
@@ -0,0 +1,49 @@
+#ifndef FSM_LISTEN_H
+#define FSM_LISTEN_H
+
+/* This needs to be implemented by each backend */
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+struct fsmonitor_daemon_state;
+
+/*
+ * Initialize platform-specific data for the fsmonitor listener thread.
+ * This will be called from the main thread PRIOR to staring the
+ * fsmonitor_fs_listener thread.
+ *
+ * Returns 0 if successful.
+ * Returns -1 otherwise.
+ */
+int fsm_listen__ctor(struct fsmonitor_daemon_state *state);
+
+/*
+ * Cleanup platform-specific data for the fsmonitor listener thread.
+ * This will be called from the main thread AFTER joining the listener.
+ */
+void fsm_listen__dtor(struct fsmonitor_daemon_state *state);
+
+/*
+ * The main body of the platform-specific event loop to watch for
+ * filesystem events.  This will run in the fsmonitor_fs_listen thread.
+ *
+ * It should call `ipc_server_stop_async()` if the listener thread
+ * prematurely terminates (because of a filesystem error or if it
+ * detects that the .git directory has been deleted).  (It should NOT
+ * do so if the listener thread receives a normal shutdown signal from
+ * the IPC layer.)
+ *
+ * It should set `state->error_code` to -1 if the daemon should exit
+ * with an error.
+ */
+void fsm_listen__loop(struct fsmonitor_daemon_state *state);
+
+/*
+ * Gently request that the fsmonitor listener thread shutdown.
+ * It does not wait for it to stop.  The caller should do a JOIN
+ * to wait for it.
+ */
+void fsm_listen__stop_async(struct fsmonitor_daemon_state *state);
+
+#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
+#endif /* FSM_LISTEN_H */
diff --git a/config.mak.uname b/config.mak.uname
index 4352ea39e9b..26074f56bed 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -435,6 +435,11 @@ ifeq ($(uname_S),Windows)
 	# so we don't need this:
 	#
 	#   SNPRINTF_RETURNS_BOGUS = YesPlease
+
+	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
+	# These are always available, so we do not have to conditionally
+	# support it.
+	FSMONITOR_DAEMON_BACKEND = win32
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
@@ -619,6 +624,11 @@ ifeq ($(uname_S),MINGW)
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_SVN_TESTS = YesPlease
+
+	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
+	# These are always available, so we do not have to conditionally
+	# support it.
+	FSMONITOR_DAEMON_BACKEND = win32
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index e44232f85d3..0963629db7f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -285,6 +285,13 @@ else()
 	endif()
 endif()
 
+if(SUPPORTS_SIMPLE_IPC)
+	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
+	endif()
+endif()
+
 set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
 
 #header checks
diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdcc..2dfcb2b6542 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "repository.h"
 #include "midx.h"
+#include "compat/fsmonitor/fsm-listen.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
-- 
gitgitgadget

