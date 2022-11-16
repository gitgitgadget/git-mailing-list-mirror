Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3A5C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 23:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiKPXXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiKPXXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 18:23:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6891F617
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so32740927wrt.12
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 15:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbEPmyFY4uTb4T5WEDsOtQjGPbAHk7ZL8ajKB33oliE=;
        b=M1Ka0AmoyS/4F3lwElS+5c5nCf0fPeSSMX7lxlc3HvX+4hHMF5g8NqNwSF4OrASDtK
         INgTbbVyKt7NhpTaaWdSAV8jfgN9FqwLh4MNAWMrJPyjm0JGQxovZb5MTcirMTFxLxrc
         4y0NM0ijUzKymeNEI3tLvNbMpMqRMbuI3QJbKf3ZI5CeLMOvz0EnkYctkV7YSrVDdr/Z
         CAeqtPGzLmJs9t8BlFhg1ILxfaXpceDM3nYyjDH8370Ho9noyeigarRzB5WP/6GBm9h/
         xodsZZGa00uoOmS1br39MYC4QYoVND4DsWks+6QGU2g3enwtHz3Dsy0IPcE5GNurxcDP
         bAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbEPmyFY4uTb4T5WEDsOtQjGPbAHk7ZL8ajKB33oliE=;
        b=NED9OEuLuCeGQoakQyDqJINDqZOiavAwgTegBnHVR8kFeSlfDVJ3BK5ZpiBNFj+Eer
         Snn8Bk46SbNLIP/YE7cibptj0o31sJfZOrNio2+EJkZ6SirwvidURykDidnyADtkQkiH
         D5u4qmI4kIN7UpHRuUJBpRUnX07NDPxnvi+8Z062DyJBsSP5B2kn81E2kMIVVURF3Hxa
         +YG6Mc5O1ayBFx3e84fT/AisLPm4NWM/HRxrMVujIrzLGEk6Iv0ppp11/gX++qrJGAL7
         135uZi5zd79Zd9m7/9NHsyIwP6RXnozFlCutbk+1LEYOkonksU1GVoeMcwMYBPLh4LZ4
         Hyfg==
X-Gm-Message-State: ANoB5pkdZNliKZj/u5n0RP4ggFC88Jy0N4rNy1bTiOA6s14SqCVL09xS
        2k5TeEyKIQiI1v5cEdxYpSnYnyEYupc=
X-Google-Smtp-Source: AA0mqf46KEZ83M5gfmep97vrBAxDqPNBoAp9hkqJsYjx9YJ7qQUZ6V0JmRO98avKoeA6rpKaBB3pYw==
X-Received: by 2002:adf:dd82:0:b0:236:5d8c:97fd with SMTP id x2-20020adfdd82000000b002365d8c97fdmr15317467wrl.473.1668641021694;
        Wed, 16 Nov 2022 15:23:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d4fc5000000b0022cd96b3ba6sm18901525wrw.90.2022.11.16.15.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:23:41 -0800 (PST)
Message-Id: <pull.1352.v3.git.git.1668641019.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
References: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 23:23:33 +0000
Subject: [PATCH v3 0/6] fsmonitor: Implement fsmonitor for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
Windows and Mac OS.

This patch set builds upon previous work for done for Windows and Mac OS to
implement a fsmonitor back-end for Linux based on the Linux inotify API.
inotify differs significantly from the equivalent Windows and Mac OS APIs in
that a watch must be registered for every directory of interest (rather than
a singular watch at the root of the directory tree) and special care must be
taken to handle directory renames correctly.

More information about inotify:
https://man7.org/linux/man-pages/man7/inotify.7.html

v2 differs from v1:

 * Prior work for Windows and Mac OS has been merged to master, reducing the
   patch set from 12 to 6 patches
 * Code review feedback
 * Identified and resolved race condition revealed by CI test system, see
   "Limitations and caveats" regarding monitoring of directory trees from
   the man page, above
 * Apologies for being away from this for so long, but my attention was
   needed elsewhere

v1 differs from v0:

 * Code review feedback
 * Update how and which code can be shared between Mac OS and Linux
 * Increase polling frequency to every 1ms (matches Mac OS)
 * Updates to t7527 to improve test stability

Eric DeCosta (6):
  fsmonitor: prepare to share code between Mac OS and Linux
  fsmonitor: determine if filesystem is local or remote
  fsmonitor: implement filesystem change listener for Linux
  fsmonitor: enable fsmonitor for Linux
  fsmonitor: test updates
  fsmonitor: update doc for Linux

 Documentation/config/fsmonitor--daemon.txt |   4 +-
 Documentation/git-fsmonitor--daemon.txt    |  24 +-
 compat/fsmonitor/fsm-health-linux.c        |  24 +
 compat/fsmonitor/fsm-ipc-darwin.c          |  53 +-
 compat/fsmonitor/fsm-ipc-linux.c           |   1 +
 compat/fsmonitor/fsm-ipc-unix.c            |  52 ++
 compat/fsmonitor/fsm-listen-linux.c        | 676 +++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c    | 169 ++++++
 compat/fsmonitor/fsm-settings-darwin.c     |  63 +-
 compat/fsmonitor/fsm-settings-linux.c      |   1 +
 compat/fsmonitor/fsm-settings-unix.c       |  61 ++
 config.mak.uname                           |   8 +
 contrib/buildsystems/CMakeLists.txt        |  11 +-
 t/t7527-builtin-fsmonitor.sh               |  94 ++-
 14 files changed, 1102 insertions(+), 139 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c


base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1352%2Fedecosta-mw%2Ffsmonitor_linux-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1352/edecosta-mw/fsmonitor_linux-v3
Pull-Request: https://github.com/git/git/pull/1352

Range-diff vs v2:

  1:  cd46bed37c3 <  -:  ----------- fsmonitor: refactor filesystem checks to common interface
  2:  21d114bda4b <  -:  ----------- fsmonitor: relocate socket file if .git directory is remote
  3:  664259ed57a <  -:  ----------- fsmonitor: avoid socket location check if using hook
  4:  d8f20032d6b <  -:  ----------- fsmonitor: deal with synthetic firmlinks on macOS
  5:  ab1e0ab967c <  -:  ----------- fsmonitor: check for compatability before communicating with fsmonitor
  6:  9c552239b57 <  -:  ----------- fsmonitor: add documentation for allowRemote and socketDir options
  7:  295beb89ab1 !  1:  99d684c7bdf fsmonitor: prepare to share code between Mac OS and Linux
     @@ Commit message
      
          Linux and Mac OS can share some of the code originally developed for Mac OS.
      
     -    Minor update to compat/fsmonitor/fsm-ipc-unix.c to make it cross-platform.
     -    Mac OS and Linux can share fsm-ipc-unix.c
     -
     -    Both platforms can also share compat/fsmonitor/fsm-settings-unix.c but we
     -    will leave room for future, platform-specific checks by having the platform-
     -    specific implementations call into fsm-settings-unix.
     +    Mac OS and Linux can share fsm-ipc-unix.c and fsm-settings-unix.c
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
     - ## Makefile ##
     -@@ Makefile: endif
     - 
     - ifdef FSMONITOR_DAEMON_BACKEND
     - 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
     -+	ifdef FSMONITOR_DAEMON_COMMON
     -+		COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
     -+	else
     -+		COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
     -+	endif
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
     --	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
     - endif
     - 
     - ifdef FSMONITOR_OS_SETTINGS
     - 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
     -+	ifdef FSMONITOR_DAEMON_COMMON
     -+		COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o
     -+	endif
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
     - 	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
     - endif
     -
       ## compat/fsmonitor/fsm-health-linux.c (new) ##
      @@
      +#include "cache.h"
     @@ compat/fsmonitor/fsm-health-linux.c (new)
      +{
      +}
      
     - ## compat/fsmonitor/fsm-ipc-darwin.c => compat/fsmonitor/fsm-ipc-unix.c ##
     -@@ compat/fsmonitor/fsm-ipc-unix.c: static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
     - const char *fsmonitor_ipc__get_path(struct repository *r)
     - {
     - 	static const char *ipc_path = NULL;
     --	SHA_CTX sha1ctx;
     + ## compat/fsmonitor/fsm-ipc-darwin.c ##
     +@@
     +-#include "cache.h"
     +-#include "config.h"
     +-#include "strbuf.h"
     +-#include "fsmonitor.h"
     +-#include "fsmonitor-ipc.h"
     +-#include "fsmonitor-path-utils.h"
     +-
     +-static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
     +-
     +-const char *fsmonitor_ipc__get_path(struct repository *r)
     +-{
     +-	static const char *ipc_path = NULL;
     +-	git_SHA_CTX sha1ctx;
     +-	char *sock_dir = NULL;
     +-	struct strbuf ipc_file = STRBUF_INIT;
     +-	unsigned char hash[GIT_MAX_RAWSZ];
     +-
     +-	if (!r)
     +-		BUG("No repository passed into fsmonitor_ipc__get_path");
     +-
     +-	if (ipc_path)
     +-		return ipc_path;
     +-
     +-
     +-	/* By default the socket file is created in the .git directory */
     +-	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
     +-		ipc_path = fsmonitor_ipc__get_default_path();
     +-		return ipc_path;
     +-	}
     +-
     +-	git_SHA1_Init(&sha1ctx);
     +-	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
     +-	git_SHA1_Final(hash, &sha1ctx);
     +-
     +-	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
     +-
     +-	/* Create the socket file in either socketDir or $HOME */
     +-	if (sock_dir && *sock_dir) {
     +-		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
     +-					sock_dir, hash_to_hex(hash));
     +-	} else {
     +-		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
     +-	}
     +-	free(sock_dir);
     +-
     +-	ipc_path = interpolate_path(ipc_file.buf, 1);
     +-	if (!ipc_path)
     +-		die(_("Invalid path: %s"), ipc_file.buf);
     +-
     +-	strbuf_release(&ipc_file);
     +-	return ipc_path;
     +-}
     ++#include "fsm-ipc-unix.c"
     +
     + ## compat/fsmonitor/fsm-ipc-linux.c (new) ##
     +@@
     ++#include "fsm-ipc-unix.c"
     +
     + ## compat/fsmonitor/fsm-ipc-unix.c (new) ##
     +@@
     ++#include "cache.h"
     ++#include "config.h"
     ++#include "strbuf.h"
     ++#include "fsmonitor.h"
     ++#include "fsmonitor-ipc.h"
     ++#include "fsmonitor-path-utils.h"
     ++
     ++static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
     ++
     ++const char *fsmonitor_ipc__get_path(struct repository *r)
     ++{
     ++	static const char *ipc_path = NULL;
      +	git_SHA_CTX sha1ctx;
     - 	char *sock_dir = NULL;
     - 	struct strbuf ipc_file = STRBUF_INIT;
     - 	unsigned char hash[SHA_DIGEST_LENGTH];
     -@@ compat/fsmonitor/fsm-ipc-unix.c: const char *fsmonitor_ipc__get_path(struct repository *r)
     - 		return ipc_path;
     - 	}
     - 
     --	SHA1_Init(&sha1ctx);
     --	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
     --	SHA1_Final(hash, &sha1ctx);
     ++	char *sock_dir = NULL;
     ++	struct strbuf ipc_file = STRBUF_INIT;
     ++	unsigned char hash[GIT_MAX_RAWSZ];
     ++
     ++	if (!r)
     ++		BUG("No repository passed into fsmonitor_ipc__get_path");
     ++
     ++	if (ipc_path)
     ++		return ipc_path;
     ++
     ++
     ++	/* By default the socket file is created in the .git directory */
     ++	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
     ++		ipc_path = fsmonitor_ipc__get_default_path();
     ++		return ipc_path;
     ++	}
     ++
      +	git_SHA1_Init(&sha1ctx);
      +	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
      +	git_SHA1_Final(hash, &sha1ctx);
     - 
     - 	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
     - 
     ++
     ++	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
     ++
     ++	/* Create the socket file in either socketDir or $HOME */
     ++	if (sock_dir && *sock_dir) {
     ++		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
     ++					sock_dir, hash_to_hex(hash));
     ++	} else {
     ++		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
     ++	}
     ++	free(sock_dir);
     ++
     ++	ipc_path = interpolate_path(ipc_file.buf, 1);
     ++	if (!ipc_path)
     ++		die(_("Invalid path: %s"), ipc_file.buf);
     ++
     ++	strbuf_release(&ipc_file);
     ++	return ipc_path;
     ++}
      
       ## compat/fsmonitor/fsm-settings-darwin.c ##
      @@
     - #include "config.h"
     - #include "fsmonitor.h"
     - #include "fsmonitor-ipc.h"
     +-#include "config.h"
     +-#include "fsmonitor.h"
     +-#include "fsmonitor-ipc.h"
      -#include "fsmonitor-settings.h"
     - #include "fsmonitor-path-utils.h"
     +-#include "fsmonitor-path-utils.h"
      -
      - /*
      - * For the builtin FSMonitor, we create the Unix domain socket for the
     @@ compat/fsmonitor/fsm-settings-darwin.c
      -	free(fs.typename);
      -	return FSMONITOR_REASON_OK;
      -}
     -+#include "fsmonitor-settings.h"
     -+#include "fsm-settings-unix.h"
     - 
     - enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
     - {
     +-
     +-enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
     +-{
      -	enum fsmonitor_reason reason;
      -
      -	if (ipc) {
     @@ compat/fsmonitor/fsm-settings-darwin.c
      -	}
      -
      -	return FSMONITOR_REASON_OK;
     -+    return fsm_os__incompatible_unix(r, ipc);
     - }
     +-}
     ++#include "fsm-settings-unix.c"
      
       ## compat/fsmonitor/fsm-settings-linux.c (new) ##
      @@
     -+#include "config.h"
     -+#include "fsmonitor.h"
     -+#include "fsmonitor-ipc.h"
     -+#include "fsmonitor-path-utils.h"
     -+#include "fsmonitor-settings.h"
     -+#include "fsm-settings-unix.h"
     -+
     -+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
     -+{
     -+    return fsm_os__incompatible_unix(r, ipc);
     -+}
     ++#include "fsm-settings-unix.c"
      
       ## compat/fsmonitor/fsm-settings-unix.c (new) ##
      @@
     @@ compat/fsmonitor/fsm-settings-unix.c (new)
      +#include "fsmonitor.h"
      +#include "fsmonitor-ipc.h"
      +#include "fsmonitor-path-utils.h"
     -+#include "fsm-settings-unix.h"
      +
      + /*
      + * For the builtin FSMonitor, we create the Unix domain socket for the
     @@ compat/fsmonitor/fsm-settings-unix.c (new)
      +	struct fs_info fs;
      +	const char *ipc_path = fsmonitor_ipc__get_path(r);
      +	struct strbuf path = STRBUF_INIT;
     -+	strbuf_add(&path, ipc_path, strlen(ipc_path));
     ++	strbuf_addstr(&path, ipc_path);
      +
      +	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
      +		strbuf_release(&path);
     @@ compat/fsmonitor/fsm-settings-unix.c (new)
      +	return FSMONITOR_REASON_OK;
      +}
      +
     -+enum fsmonitor_reason fsm_os__incompatible_unix(struct repository *r, int ipc)
     ++enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
      +{
      +	enum fsmonitor_reason reason;
      +
     @@ compat/fsmonitor/fsm-settings-unix.c (new)
      +
      +	return FSMONITOR_REASON_OK;
      +}
     -
     - ## compat/fsmonitor/fsm-settings-unix.h (new) ##
     -@@
     -+#ifndef FSM_SETTINGS_UNIX_H
     -+#define FSM_SETTINGS_UNIX_H
     -+
     -+#ifdef HAVE_FSMONITOR_OS_SETTINGS
     -+/*
     -+ * Check for compatibility on unix-like systems (e.g. Darwin and Linux)
     -+ */
     -+enum fsmonitor_reason fsm_os__incompatible_unix(struct repository *r, int ipc);
     -+#endif /* HAVE_FSMONITOR_OS_SETTINGS */
     -+
     -+#endif /* FSM_SETTINGS_UNIX_H */
     -
     - ## config.mak.uname ##
     -@@ config.mak.uname: ifeq ($(uname_S),Darwin)
     - 	ifndef NO_UNIX_SOCKETS
     - 	FSMONITOR_DAEMON_BACKEND = darwin
     - 	FSMONITOR_OS_SETTINGS = darwin
     -+	FSMONITOR_DAEMON_COMMON = unix
     - 	endif
     - 	endif
     - 
     -
     - ## contrib/buildsystems/CMakeLists.txt ##
     -@@ contrib/buildsystems/CMakeLists.txt: else()
     - endif()
     - 
     - if(SUPPORTS_SIMPLE_IPC)
     --	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     -+	if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
     -+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
     -+
     -+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-linux.c)
     -+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     - 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
     -@@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
     - 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
     - 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
     --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
     - 
     - 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
     - 	endif()
     - endif()
  8:  7d7ef78728f =  2:  aa405379891 fsmonitor: determine if filesystem is local or remote
  9:  4f9c5358475 !  3:  c2e5a7201aa fsmonitor: implement filesystem change listener for Linux
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +/*
      + * Recursively add watches to every directory under path
      + */
     -+static int register_inotify(const char *path, struct fsm_listen_data *data)
     ++static int register_inotify(const char *path,
     ++	struct fsmonitor_daemon_state *state,
     ++	struct fsmonitor_batch *batch)
      +{
      +	DIR *dir;
     ++	const char *rel;
      +	struct strbuf current = STRBUF_INIT;
      +	struct dirent *de;
      +	struct stat fs;
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +
      +		/* recurse into directory */
      +		if (S_ISDIR(fs.st_mode)) {
     -+			if (add_watch(current.buf, data))
     ++			if (add_watch(current.buf, state->listen_data))
      +				goto failed;
     -+			if (register_inotify(current.buf, data))
     ++			if (register_inotify(current.buf, state, batch))
      +				goto failed;
     ++		} else if (batch) {
     ++			rel = current.buf + state->path_worktree_watch.len + 1;
     ++			trace_printf_key(&trace_fsmonitor, "explicitly adding '%s'", rel);
     ++			fsmonitor_batch__add_path(batch, rel);
      +		}
      +	}
      +	ret = 0;
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +
      +	if (add_watch(state->path_worktree_watch.buf, data))
      +		ret = -1;
     -+	else if (register_inotify(state->path_worktree_watch.buf, data))
     ++	else if (register_inotify(state->path_worktree_watch.buf, state, NULL))
      +		ret = -1;
      +	else if (state->nr_paths_watching > 1) {
      +		if (add_watch(state->path_gitdir_watch.buf, data))
      +			ret = -1;
     -+		else if (register_inotify(state->path_gitdir_watch.buf, data))
     ++		else if (register_inotify(state->path_gitdir_watch.buf, state, NULL))
      +			ret = -1;
      +	}
      +
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +				add_dir_rename(event->cookie, path, state->listen_data);
      +
      +			/* received IN_MOVE_TO, update watch to reflect new path */
     -+			if (em_rename_dir_to(event->mask))
     ++			if (em_rename_dir_to(event->mask)) {
      +				rename_dir(event->cookie, path, state->listen_data);
     ++				if (register_inotify(path, state, batch)) {
     ++					state->listen_data->shutdown = SHUTDOWN_ERROR;
     ++					goto done;
     ++				}
     ++			}
      +
      +			if (em_dir_created(event->mask)) {
      +				if (add_watch(path, state->listen_data)) {
      +					state->listen_data->shutdown = SHUTDOWN_ERROR;
      +					goto done;
      +				}
     -+				if (register_inotify(path, state->listen_data)) {
     ++				if (register_inotify(path, state, batch)) {
      +					state->listen_data->shutdown = SHUTDOWN_ERROR;
      +					goto done;
      +				}
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +			strbuf_reset(&path);
      +			strbuf_add(&path, w->dir, strlen(w->dir));
      +			strbuf_addch(&path, '/');
     -+			strbuf_add(&path, event->name,  strlen(event->name));
     ++			strbuf_addstr(&path, event->name);
      +
      +			p = fsmonitor__resolve_alias(path.buf, &state->alias);
      +			if (!p)
 10:  07650ecd27b !  4:  05f5b2dd4fb fsmonitor: enable fsmonitor for Linux
     @@ config.mak.uname: ifeq ($(uname_S),Linux)
      +	ifndef NO_UNIX_SOCKETS
      +	FSMONITOR_DAEMON_BACKEND = linux
      +	FSMONITOR_OS_SETTINGS = linux
     -+	FSMONITOR_DAEMON_COMMON = unix
      +	endif
      +	endif
       endif
       ifeq ($(uname_S),GNU/kFreeBSD)
       	HAVE_ALLOCA_H = YesPlease
     +
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: else()
     + endif()
     + 
     + if(SUPPORTS_SIMPLE_IPC)
     +-	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     ++	if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
     ++		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-linux.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
     ++
     ++		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-linux.c)
     ++	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     + 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
 11:  6682938fff8 !  5:  754355ca44f fsmonitor: test updates
     @@ t/t7527-builtin-fsmonitor.sh: start_daemon () {
      +		then
      +			if test "$last" -eq "$nsz"
      +			then
     ++				cat "$file" &&
      +				return 0
      +			fi
      +			last=$nsz
     @@ t/t7527-builtin-fsmonitor.sh: start_daemon () {
      +		sleep 1
      +		k=$(( $k + 1 ))
      +	done &&
     ++	cat "$file" &&
      +	return 0
      +}
      +
     @@ t/t7527-builtin-fsmonitor.sh: create_files () {
      +rename_directory () {
      +	mv dirtorename dirrenamed
      +}
     ++
     ++rename_directory_file () {
     ++	mv dirtorename dirrenamed &&
     ++	echo 1 > dirrenamed/new
     ++}
      +
       rename_files () {
       	mv rename renamed &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename directory' '
       	grep "^event: dirtorename/*$" .git/trace &&
       	grep "^event: dirrenamed/*$"  .git/trace
       '
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'file changes to directory' '
     + 
     ++test_expect_success 'rename directory file' '
     ++	test_when_finished clean_up_repo_and_stop_daemon &&
     ++
     ++	start_daemon --tf "$PWD/.git/trace" &&
     ++
     ++	wait_for_update rename_directory_file "$PWD/.git/trace" &&
     ++
     ++	test-tool fsmonitor-client query --token 0 &&
     ++
     ++	test_might_fail git fsmonitor--daemon stop &&
     ++
     ++	grep "^event: dirtorename/*$" .git/trace &&
     ++	grep "^event: dirrenamed/*$"  .git/trace &&
     ++	grep "^event: dirrenamed/new$"  .git/trace
     ++'
     + test_expect_success 'file changes to directory' '
     + 	test_when_finished clean_up_repo_and_stop_daemon &&
       
       	start_daemon --tf "$PWD/.git/trace" &&
       
     @@ t/t7527-builtin-fsmonitor.sh: u_values="$u1 $u2"
       
       		git init "$u" &&
       		echo 1 >"$u"/file1 &&
     -@@ t/t7527-builtin-fsmonitor.sh: my_match_and_clean () {
     - }
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule setup' '
     + '
       
       test_expect_success 'submodule always visited' '
      -	test_when_finished "git -C super fsmonitor--daemon stop; \
 12:  dd73e126810 =  6:  f56175e097a fsmonitor: update doc for Linux

-- 
gitgitgadget
