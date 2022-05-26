Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51794C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349208AbiEZVtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbiEZVtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF127C6E5A
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e2so3678303wrc.1
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V2qiF7m8aSYTil3cDpJgcVX4oQxYDeEfetoj3qel4cE=;
        b=mSGu2O2+3NbCJ1cPeeVrRXoEynNdjxwN7ARxU60JmSRkcs85xSOBoCRwN476l4RqPs
         X7Yp6tf7s0f3zJJ5dz4u53iqZesLVxYj7iDT5kBoVAQkbomzvr4HfXWc9xdHrm2TtY8r
         FZ4x7e9x7bCvmEIBJUVK7XZrx/pKNx7meFZZZNN6OyzbUlLaWxSjYB2i6uyQBtQ9km4T
         EwfCSt4bp5NuGUVr4/dcbv8UM6cNU9oCuFFOVQiaCULVF/wSzYW8zkIdkYNhJEFC/Wcl
         uS54iwYbziUR7XwYouQWq5Z15TF45LGnZdOdCJgIpGjcYtWMmhDZrIJGoG1dBBKGYiNA
         aF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V2qiF7m8aSYTil3cDpJgcVX4oQxYDeEfetoj3qel4cE=;
        b=LN6mggnQK3iOCOP3I686DkQfKGKtmu+CJbxWEB/pVMb0auF8CFPeI/kNBcZOJmmtE/
         PLmuG5iiUpVBPJkLy7iJ3NiC+HeY953MH14wEldU5BDjHKHidK28aVWtQm+Bipy97UzN
         wz3U7TWFLCKB9pwj3T8B9k3wRE34UmrIkth4trkgb5YUfT8/W1EJbViwwng42AdGHinT
         SOIesddLp3lskcxxbkSEojqduOtsAzBtkHZPRCp3znhen50wXuqkykGLwD/5zp2PQ76q
         avExuX81vxEs5EPC5ml+WiSOtqsun2DfB7O/qbTuLv6VD7TteAwxc6FmGMxwXPjXHVH/
         tPuw==
X-Gm-Message-State: AOAM530iockJaMOLeUtISjKIe3RwCt5ZeGkk0twpgHUzijVSmx7B1yS4
        8IInHZ7fQhjjIP1m1MqCSELYPl0yLkA=
X-Google-Smtp-Source: ABdhPJw/lgBDkOSWeJodVlxnQU3WqWOCz60dY6ZYNRR3NWrJ0/0dVnL7R+RAuFFIQbKEMla7xnttDw==
X-Received: by 2002:a5d:4c42:0:b0:210:413:4ef6 with SMTP id n2-20020a5d4c42000000b0021004134ef6mr6549972wrt.10.1653601750046;
        Thu, 26 May 2022 14:49:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b0039750c39fc5sm10444790wmr.3.2022.05.26.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:09 -0700 (PDT)
Message-Id: <0b182569e1135265fb54d2592fa2bc0db2c1312b.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:46:59 +0000
Subject: [PATCH v9 05/30] fsmonitor-settings: stub in Win32-specific
 incompatibility checking
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

Extend generic incompatibility checkout with platform-specific
mechanism.  Stub in Win32 version.

In the existing fsmonitor-settings code we have a way to mark
types of repos as incompatible with fsmonitor (whether via the
hook and IPC APIs).  For example, we do this for bare repos,
since there are no files to watch.

Extend this exclusion mechanism for platform-specific reasons.
This commit just creates the framework and adds a stub for Win32.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                              | 13 +++++++++++++
 compat/fsmonitor/fsm-settings-win32.c |  9 +++++++++
 config.mak.uname                      |  4 ++++
 contrib/buildsystems/CMakeLists.txt   |  3 +++
 fsmonitor-settings.c                  | 10 ++++++++++
 fsmonitor-settings.h                  | 13 +++++++++++++
 6 files changed, 52 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c

diff --git a/Makefile b/Makefile
index daa21bed6c3..93604fe8ef7 100644
--- a/Makefile
+++ b/Makefile
@@ -475,6 +475,11 @@ all::
 # `compat/fsmonitor/fsm-listen-<name>.c` that implements the
 # `fsm_listen__*()` routines.
 #
+# If your platform has OS-specific ways to tell if a repo is incompatible with
+# fsmonitor (whether the hook or IPC daemon version), set FSMONITOR_OS_SETTINGS
+# to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
+# that implements the `fsm_os_settings__*()` routines.
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -1979,6 +1984,11 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
+ifdef FSMONITOR_OS_SETTINGS
+	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2901,6 +2911,9 @@ GIT-BUILD-OPTIONS: FORCE
 ifdef FSMONITOR_DAEMON_BACKEND
 	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
 endif
+ifdef FSMONITOR_OS_SETTINGS
+	@echo FSMONITOR_OS_SETTINGS=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_OS_SETTINGS)))'\' >>$@+
+endif
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
new file mode 100644
index 00000000000..7fce32a3c5b
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -0,0 +1,9 @@
+#include "cache.h"
+#include "config.h"
+#include "repository.h"
+#include "fsmonitor-settings.h"
+
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+{
+	return FSMONITOR_REASON_OK;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 501970902da..cf224768ad6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -450,6 +450,8 @@ ifeq ($(uname_S),Windows)
 	# These are always available, so we do not have to conditionally
 	# support it.
 	FSMONITOR_DAEMON_BACKEND = win32
+	FSMONITOR_OS_SETTINGS = win32
+
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
@@ -639,6 +641,8 @@ ifeq ($(uname_S),MINGW)
 	# These are always available, so we do not have to conditionally
 	# support it.
 	FSMONITOR_DAEMON_BACKEND = win32
+	FSMONITOR_OS_SETTINGS = win32
+
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index ee0d7257b77..16705da2000 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -289,6 +289,9 @@ if(SUPPORTS_SIMPLE_IPC)
 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 7d3177d441a..f67db913f57 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -23,6 +23,16 @@ static enum fsmonitor_reason check_for_incompatible(struct repository *r)
 		return FSMONITOR_REASON_BARE;
 	}
 
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+	{
+		enum fsmonitor_reason reason;
+
+		reason = fsm_os__incompatible(r);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+	}
+#endif
+
 	return FSMONITOR_REASON_OK;
 }
 
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 8d9331c0c0a..6cb0d8e7d9f 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -34,4 +34,17 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 
 struct fsmonitor_settings;
 
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+/*
+ * Ask platform-specific code whether the repository is incompatible
+ * with fsmonitor (both hook and ipc modes).  For example, if the working
+ * directory is on a remote volume and mounted via a technology that does
+ * not support notification events, then we should not pretend to watch it.
+ *
+ * fsm_os__* routines should considered private to fsm_settings__
+ * routines.
+ */
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r);
+#endif /* HAVE_FSMONITOR_OS_SETTINGS */
+
 #endif /* FSMONITOR_SETTINGS_H */
-- 
gitgitgadget

