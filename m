Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14B6C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiCVSCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiCVSB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:01:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5438066223
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so2437356wmp.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sSAmNlfeMp/SuWaNgnRs8TTLxikird+cAhYFRFbfq6s=;
        b=pIogyAVZEyXJ/aPf/ojf2tA2bqRjBEFvBhjTG7/A6OpVFKBtKrN8Lr8Lptrgg6sRUX
         g0p0Y5jnpgmDcz4++pYDkaQHP7VoP7hExDTvcvqL466QYNx41qjbtpHKkouqpPBDwYjf
         rnA9FyUG/km2qvJXxHT28N6agbNFrYZqC8jsueggXG/D6ccAjEJbZpFFWhxqtedUzd1B
         v3yvZ9k3vqOIHrzn3IxFCzauzRlHtqCtRCXtwD0Ff9up5QC6PoxdDa8wlJTlk2Z+uDAb
         bl7BrPkNgZHdMdg8c+EjkGlHwCjla7ylOqCRz6jQeSb+PtGNAr3gNuALlzdXxoXbVOK1
         H88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sSAmNlfeMp/SuWaNgnRs8TTLxikird+cAhYFRFbfq6s=;
        b=gWL/cwXROCHzKpJNc0Z5vE+h/7HlvYIyvKlqOPqgWltnS1ecEY/XyoiMF6d+37sAmE
         UW8/plMx/TceN9PBOLbT0YpZutfKVb3pM6h4Ih6V5s/NTHijoUOAFcvIunh7eNze9aSG
         8E8/MgLWRFIUw8hMvHLIYbZap6h+Y1AcppXSASj65LWDy0yWYzj/pi1rhKYsSJgqwyH5
         +NlgZEfV0GyQKTE6zgTZ0WP7oj116r5YJoM8Te1QUB1g+HqbnsH4eUowJ1eaNSycega1
         Wl71DH/OZFUrPa6S7txe4bMNEYjOoh7dOaj/vsWwVgO/WMJpNhDB0QQU8D9dECipghij
         K28w==
X-Gm-Message-State: AOAM531ZHntmc8CEmP3LEVfnkXXBjcxJ6I60EWV+9aMn+hjRM45lYbMW
        4TpHT5lraG9vrpBA74OCx3vB8cie3ag=
X-Google-Smtp-Source: ABdhPJycybjhfDsbz8mIIu+ecvs89nko0b3wsG0b94H4YaVv3aBAlMwbxuGI6nbMY8D4e1S9TIC/FQ==
X-Received: by 2002:a1c:f607:0:b0:381:1db:d767 with SMTP id w7-20020a1cf607000000b0038101dbd767mr4816169wmc.165.1647972028713;
        Tue, 22 Mar 2022 11:00:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600002c600b002057f1738fcsm1218340wry.110.2022.03.22.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:27 -0700 (PDT)
Message-Id: <a29fe7266a456d88125ca1f87d4b16370caf486f.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:49 +0000
Subject: [PATCH v7 08/29] compat/fsmonitor/fsm-listen-win32: stub in backend
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

