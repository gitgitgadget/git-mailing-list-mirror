Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2784C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiCYTlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiCYTjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812B14FFDB
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:11:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so4960191wme.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sSAmNlfeMp/SuWaNgnRs8TTLxikird+cAhYFRFbfq6s=;
        b=KaSWzqtzXXm80JGITBxzg25jHC2Hmb3WKEWzMgIhF7R+HVzeY+ZZFyfW/SEWrIyTRd
         t8/dtFEczDwmMZdd5KJn/G8Tl3OQV3F+5R3hUlm8kLyO19K8ZLFslFsdSF0hzMlDptKS
         qaOAWs3eAiuia6yHpH9pS21KYvv7wYfOE29hyteupb+l0RBbzl7ti6Zp3EVCMUxglCtH
         Q7WX6QZ6kJ6YlfnOP+3lIYduh0Vk1jw4glbqVrb9rdxHxmdjTjmujGw60BFj+PM0kNbS
         LCEyliAnCL7Wa1jdzzlPL4SxEbtdbgR8/u+7w3Rtgqg1Fr+FB9qogqu9Ts/JagOYtXhK
         ZMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sSAmNlfeMp/SuWaNgnRs8TTLxikird+cAhYFRFbfq6s=;
        b=R7Tdq+92Bh/44f8Af276fz5sVNw4I9Mt8kEo+cv1YLcgMVUT0gbayYwGX0kHIbsThF
         1zPHUfhGIkXF3QiBUuwIrK/AQv4VL/Gpm63qFEgj4227Raz0dENKTiyvZZQBjhS68CuH
         fZQsb1IZQBhD7tGL43+BgyoA54+P6GDgMl74rqZVcDBBGo56xzeP5G4V2NBTh38h/MdT
         xbUphrr50kdW4U8mW/2tB7dAjAe+VKDHIgXu+yQbCJF130sVsReHSBzZTP+g+iyaEfr0
         i9ps/EHCty4/OkiCPomx4Lz3J7N6QrCdWs3smPvEgy//7Kj6Co21fCs9Q7MCcEbeZ4Do
         1zJQ==
X-Gm-Message-State: AOAM532ejPeMmP6eo7jBARt2FR4xVPlTxl62X+eHhtNGQ3tbyCz3r9lP
        Cy14q5VpWpC7JhYjIqeQq2rQrbbyQDE=
X-Google-Smtp-Source: ABdhPJzvSC++BrE4GUimKBI0rqEHrbfcQptNCvd1MCvQl5coMMR9y1huJ3lPRAAp/J6naPNgqi/VzA==
X-Received: by 2002:a05:600c:2e4c:b0:38c:7088:afd0 with SMTP id q12-20020a05600c2e4c00b0038c7088afd0mr20818506wmf.70.1648231404121;
        Fri, 25 Mar 2022 11:03:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe94a000000b002059e530da1sm2998193wrn.1.2022.03.25.11.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:23 -0700 (PDT)
Message-Id: <a29fe7266a456d88125ca1f87d4b16370caf486f.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:51 +0000
Subject: [PATCH v9 08/30] compat/fsmonitor/fsm-listen-win32: stub in backend
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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

