Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128E0C433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350664AbiCHWQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350646AbiCHWQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295154BCE
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so409070wmq.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5A+fsXXhpmpUKMBtcYUi70L1TOFe1J3MTYQocvv9ov0=;
        b=PKcTTn0Kn17HGDAXH94iuM07YJJtUT+5CjNToX/0VmSNPdUOswCR4+eudKzMe7B1wS
         fTXgopmobe09/t1HcF6QNTu2hymlG2PZS1lDN3X52qsjOuM6YOznlV/lWUosHcAMD+Ft
         22/6eX7T/4daYy+chuqZ4D0h09LPCnFZ3mdCtVIz6t08TSq/VZrE6H9H6EkiBloHek9V
         WiKDktj7qjzChw532Upeky8egjBlycoZD8/gaq9TjifUYsJoJ1vhI0GoSp8DcinDs92R
         mwMXOi3b9vH+gaxIrnn+BG1ARvquv1TVo8A8hdTV7t7UlWHDCqkGQ+h9CATC12dJloCw
         ZX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5A+fsXXhpmpUKMBtcYUi70L1TOFe1J3MTYQocvv9ov0=;
        b=TtGavN3nSy8rKT5AlrzaqkIAa5NuIVPZkMrmPx8BblZSdUJfuToqW3wgki9+INvUwY
         b/23eeSgbuF/VQNfAUm9SP5J4TfQLJhJqvOcpYFGAk/OMQqPiVYf7OwT1j4k6UrGHJxX
         95NHauSaPZYIAR8aevQjnUNtFqjLDb3PRhRLtr0RpLdALPmLiqX5Vb9ypuSGx5JPFJcm
         ghhOP4PZP8MvUCqzMPsOzN8yfmMm/oQJqrQAyONT+WZzMTFSvuEvzSgpBOjtypYM4vRN
         hAj8gDRg0d95F2X9h+w+cHzmt2UlnAY3nEd5utfP35HDM5um8YJTaTTL3Qisomev72bH
         KCnQ==
X-Gm-Message-State: AOAM530/PgOuhhE1+NNKPwIA0F35S/GMaHlkq3TNJ0wZlFr7fNw4z5Qz
        D6cnZ/gO1MGhTa4PzbNQ5fbCqTdFOHg=
X-Google-Smtp-Source: ABdhPJxxZg9ZyJ/9huhVaL10vjUewah1IFnyy3+8uiNjfF5yN0C9R4iAzju70CPLPTyD84pLaYSA3A==
X-Received: by 2002:a05:600c:1990:b0:381:1806:1d9 with SMTP id t16-20020a05600c199000b00381180601d9mr5238618wmq.93.1646777735821;
        Tue, 08 Mar 2022 14:15:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12-20020adff14c000000b001f04d1959easm101811wro.13.2022.03.08.14.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:35 -0800 (PST)
Message-Id: <6329328d1859bc360dc6305a1d7be6734c9c84ea.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:05 +0000
Subject: [PATCH v2 05/27] fsmonitor-settings: stub in platform-specific
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
 fsmonitor-settings.c                  | 12 ++++++++++++
 fsmonitor-settings.h                  | 13 +++++++++++++
 6 files changed, 54 insertions(+)
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
index 8410cc73404..1b16b551d87 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -33,6 +33,18 @@ static int check_for_incompatible(struct repository *r)
 		return 1;
 	}
 
+#ifdef HAVE_FSMONITOR_OS_SETTINGS
+	{
+		enum fsmonitor_reason reason;
+
+		reason = fsm_os__incompatible(r);
+		if (reason != FSMONITOR_REASON_OK) {
+			set_incompatible(r, reason);
+			return 1;
+		}
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index a1af058a287..be25272c012 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -30,4 +30,17 @@ const char *fsm_settings__get_reason_msg(struct repository *r);
 
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

