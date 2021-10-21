Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D62EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5878B6121E
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhJUO1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhJUO1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2E6C061227
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so913063wmd.0
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=66rn+pvA2gArrNQe2ecnAfgJuM96wHeIIhc10sYmfbE=;
        b=bqt8u3OLTh6LSjY2nsn7jglO2XuZ+Xs4iXQ3iUyvc/ipCEobyb1Tg5RS4H466qR5vV
         6RervJMPnucxe2hlby/R+CDU+CWV2cMlrw+/Kf8RpAoFdME+f11yCc3AixgfKHSlyLdo
         9VAngP1ISXWuKp+GPNedUijryyOGQnli3fqOXgYxlGuxmC4gFNMSAYpi4dOodDt4/zTF
         3MKELmhHySKJOkGOl3qF5Dkxqidxug5STBXJJo+hAxGeol0wsTYJ9UNzbiLPbWzJFcl7
         XUEMAQf9cx5lk1UTBG43Dh8s1r+XBUnugozhjuA/y10IElxxHfrbz/NnASNKb/f7XgKd
         KN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=66rn+pvA2gArrNQe2ecnAfgJuM96wHeIIhc10sYmfbE=;
        b=SJddvPjzkxtP0S272yCa6b5OhDL8M9bdXgbYhYYegoxmRnHVqBXlb5G7htIZzuZa4G
         wrTZwfAG1C/VfiLGt8OAZO6lglsgXe2PvSt6Fj0MxGEdK8Y97LZyt3M0haE90N+X+Q/F
         UVOFd3ThrsQOozzUxDFL0yQ3tb8mYmZVuNp5/roOdCmegiVsOdSBTCrC/8iNd6ot1nq8
         cLwqABjWh9rGndYsg/XSlq2W1fc2GQApaVZ4sYPMtfELexugakZ+YPsAJvSBJVAvTyid
         41M/TGrDp7OsCgrZcl/lpoRxErLBxZmUXM/5gbSrc8BWk9f1FAUJwczwZBi9t1s/bkgJ
         Lx1A==
X-Gm-Message-State: AOAM532t+3Wu2efKBJdvajNiyMJf6/faDAsiB+0JH1Bdo7kHalx3+c4y
        SKmoaM0uicct5d+afplVH+332VaUZQE=
X-Google-Smtp-Source: ABdhPJxW82/ol+kPFkr1HOLzWaZnXvxrz9CeB3X32ZtDt4yn7sPBGqJEYGuV80C201rz/VbHJ+bN+A==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr7047469wmk.43.1634826316305;
        Thu, 21 Oct 2021 07:25:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm2549182wmg.14.2021.10.21.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:16 -0700 (PDT)
Message-Id: <5a40b33a00c927373c64536c87fba76a676f8a77.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:48 +0000
Subject: [PATCH v4 08/29] compat/fsmonitor/fsm-listen-win32: stub in backend
 for Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Stub in empty filesystem listener backend for fsmonitor--daemon on Windows.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
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
index 95ac224bc8d..8a26696c9ed 100644
--- a/Makefile
+++ b/Makefile
@@ -465,6 +465,11 @@ all::
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
@@ -1930,6 +1935,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
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
@@ -2805,6 +2815,9 @@ GIT-BUILD-OPTIONS: FORCE
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
index 3236a4918a3..e6a900c6fd4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -426,6 +426,11 @@ ifeq ($(uname_S),Windows)
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
@@ -609,6 +614,11 @@ ifeq ($(uname_S),MINGW)
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
index fd1399c440f..24a26743dcd 100644
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
index b93e91a212e..3ed763ad9c6 100644
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

