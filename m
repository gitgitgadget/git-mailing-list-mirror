Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E1C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJNVqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNVpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:45:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C204052083
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t4so3985083wmj.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWDUvuTX3TMrTnhpzPQHMDXSk6J3QieNPeRzcjYerEg=;
        b=of0Sy63++qv3xSy5SB6wNBwhenCr/TmYWAkJj0Mi8SC99GNo01LoieTU+7DFE4QzL3
         8yIU+lH62BDu5AgrpdDdI6zwfZD6MrLhH5ozvO+tWJY/zUotUfQOkZtp8k4jQ1WA+W+E
         pVfG+jgVCokHEXO2/dDsndSFFf3wHkMnZiaTAHYYRy0fjedM57+bhBIgPfM/GKWUISIZ
         YEqkvNKIUK8hiZuYKw7jQCO336up2S8fSPkrTwaWBAMTWISsDWzHrQbsQJeSyvD9q9bp
         NStR3OawaHiksg6h8YjNakI2Tly1HYNuNgZ8t6tZ6tpzfonJIz9oj0le19pW9wXwjw20
         jepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWDUvuTX3TMrTnhpzPQHMDXSk6J3QieNPeRzcjYerEg=;
        b=VEjPSwwD7hibtdEXvcabE1+XVP3ugNnwg7pjo1tiMUK5mAiriRe3ClVk827O/1C8iT
         W8QSTSVqbKJZC6kBCRJBHois8tnoYwZZCuzA4qfrUS1PqssN7gm2pCxzQhTzxRkRchaO
         AHDnGAHxgJAVuwwzd2IXFenK6MkwIlr5xJvYONem167GYzw4TnEOuSfQSW6ocBKDMONq
         HBSwPJwf8pUVq/c2OLI77GjcZqMteognNoKRgCFrPbWaN3AAedPIfTcoEx9iUNHPyJvt
         gnViSpw7HVsfTMyKSNAsiUrHa+4t3jFC44WRkZ+oTXEy1GmynlVW+vcKTaK7OoqvJlvD
         AFZg==
X-Gm-Message-State: ACrzQf0TcjZe47MZc+4oo5tv/ecJdLztIMLPBTFzHD7LPWTZaS5/MbYq
        s2bbc8enkW5ZxKuIZII94XabZoqdG7Y=
X-Google-Smtp-Source: AMsMyM6pqFt2gyfqxaMyewAxR7maZhIqIuDfeA8srrk2YdQ1fanAtWkPx/zMzA9e4LGcFoX+2lIDDg==
X-Received: by 2002:a05:600c:474c:b0:3c6:c790:1f95 with SMTP id w12-20020a05600c474c00b003c6c7901f95mr11781995wmo.18.1665783946399;
        Fri, 14 Oct 2022 14:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003a84375d0d1sm8808115wmq.44.2022.10.14.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:45:45 -0700 (PDT)
Message-Id: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 21:45:32 +0000
Subject: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
Windows and Mac OS.

This patch set builds upon previous work for done for Windows and Mac OS
(first 6 patches) to implement a fsmonitor back-end for Linux based on the
Linux inotify API. inotify differs significantly from the equivalent Windows
and Mac OS APIs in that a watch must be registered for every directory of
interest (rather than a singular watch at the root of the directory tree)
and special care must be taken to handle directory renames correctly.

More information about inotify:
https://man7.org/linux/man-pages/man7/inotify.7.html

v1 differs from v0:

 * Code review feedback
 * Update how and which code can be shared between Mac OS and Linux
 * Increase polling frequency to every 1ms (matches Mac OS)
 * Updates to t7527 to improve test stability

Eric DeCosta (12):
  fsmonitor: refactor filesystem checks to common interface
  fsmonitor: relocate socket file if .git directory is remote
  fsmonitor: avoid socket location check if using hook
  fsmonitor: deal with synthetic firmlinks on macOS
  fsmonitor: check for compatability before communicating with fsmonitor
  fsmonitor: add documentation for allowRemote and socketDir options
  fsmonitor: prepare to share code between Mac OS and Linux
  fsmonitor: determine if filesystem is local or remote
  fsmonitor: implement filesystem change listener for Linux
  fsmonitor: enable fsmonitor for Linux
  fsmonitor: test updates
  fsmonitor: update doc for Linux

 Documentation/config.txt                   |   2 +
 Documentation/config/fsmonitor--daemon.txt |  11 +
 Documentation/git-fsmonitor--daemon.txt    |  45 +-
 Makefile                                   |   9 +
 builtin/fsmonitor--daemon.c                |  11 +-
 compat/fsmonitor/fsm-health-linux.c        |  24 +
 compat/fsmonitor/fsm-ipc-unix.c            |  52 ++
 compat/fsmonitor/fsm-ipc-win32.c           |   9 +
 compat/fsmonitor/fsm-listen-darwin.c       |  14 +-
 compat/fsmonitor/fsm-listen-linux.c        | 664 +++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-darwin.c   | 135 +++++
 compat/fsmonitor/fsm-path-utils-linux.c    | 169 ++++++
 compat/fsmonitor/fsm-path-utils-win32.c    | 145 +++++
 compat/fsmonitor/fsm-settings-darwin.c     |  90 +--
 compat/fsmonitor/fsm-settings-linux.c      |  11 +
 compat/fsmonitor/fsm-settings-unix.c       |  62 ++
 compat/fsmonitor/fsm-settings-unix.h       |  11 +
 compat/fsmonitor/fsm-settings-win32.c      | 174 +-----
 config.mak.uname                           |  10 +
 contrib/buildsystems/CMakeLists.txt        |  19 +-
 fsmonitor--daemon.h                        |   3 +
 fsmonitor-ipc.c                            |  18 +-
 fsmonitor-ipc.h                            |   4 +-
 fsmonitor-path-utils.h                     |  60 ++
 fsmonitor-settings.c                       |  68 ++-
 fsmonitor-settings.h                       |   4 +-
 fsmonitor.c                                |   7 +
 t/t7527-builtin-fsmonitor.sh               |  72 ++-
 28 files changed, 1606 insertions(+), 297 deletions(-)
 create mode 100644 Documentation/config/fsmonitor--daemon.txt
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 compat/fsmonitor/fsm-settings-linux.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.c
 create mode 100644 compat/fsmonitor/fsm-settings-unix.h
 create mode 100644 fsmonitor-path-utils.h


base-commit: d420dda0576340909c3faff364cfbd1485f70376
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1352%2Fedecosta-mw%2Ffsmonitor_linux-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1352/edecosta-mw/fsmonitor_linux-v2
Pull-Request: https://github.com/git/git/pull/1352

Range-diff vs v1:

  1:  ec49a74086d =  1:  cd46bed37c3 fsmonitor: refactor filesystem checks to common interface
  2:  7bf1cdfe3b2 =  2:  21d114bda4b fsmonitor: relocate socket file if .git directory is remote
  3:  c5e8b6cfe5d =  3:  664259ed57a fsmonitor: avoid socket location check if using hook
  4:  863063aefee =  4:  d8f20032d6b fsmonitor: deal with synthetic firmlinks on macOS
  5:  fa974bfd5ef =  5:  ab1e0ab967c fsmonitor: check for compatability before communicating with fsmonitor
  6:  af7309745f7 =  6:  9c552239b57 fsmonitor: add documentation for allowRemote and socketDir options
  7:  c085fc15b31 !  7:  295beb89ab1 fsmonitor: prepare to share code between Mac OS and Linux
     @@ Commit message
          fsmonitor: prepare to share code between Mac OS and Linux
      
          Linux and Mac OS can share some of the code originally developed for Mac OS.
     -    Rename the shared code from compat/fsmonitor/fsm-*-dawrin.c to
     -    compat/fsmonitor/fsm-*-unix.c
     -
     -    Update the build to enable sharing of the fsm-*-unix.c files.
      
          Minor update to compat/fsmonitor/fsm-ipc-unix.c to make it cross-platform.
     +    Mac OS and Linux can share fsm-ipc-unix.c
     +
     +    Both platforms can also share compat/fsmonitor/fsm-settings-unix.c but we
     +    will leave room for future, platform-specific checks by having the platform-
     +    specific implementations call into fsm-settings-unix.
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
       ## Makefile ##
      @@ Makefile: endif
     + 
       ifdef FSMONITOR_DAEMON_BACKEND
       	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
     ++	ifdef FSMONITOR_DAEMON_COMMON
     ++		COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
     ++	else
     ++		COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
     ++	endif
       	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
     --	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
     + 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
      -	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
     -+	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_COMMON).o
     -+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
       endif
       
       ifdef FSMONITOR_OS_SETTINGS
       	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
     --	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
     -+	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o
     ++	ifdef FSMONITOR_DAEMON_COMMON
     ++		COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o
     ++	endif
     + 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
       	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
       endif
     - 
      
     - ## compat/fsmonitor/fsm-health-darwin.c => compat/fsmonitor/fsm-health-unix.c ##
     + ## compat/fsmonitor/fsm-health-linux.c (new) ##
     +@@
     ++#include "cache.h"
     ++#include "config.h"
     ++#include "fsmonitor.h"
     ++#include "fsm-health.h"
     ++#include "fsmonitor--daemon.h"
     ++
     ++int fsm_health__ctor(struct fsmonitor_daemon_state *state)
     ++{
     ++	return 0;
     ++}
     ++
     ++void fsm_health__dtor(struct fsmonitor_daemon_state *state)
     ++{
     ++	return;
     ++}
     ++
     ++void fsm_health__loop(struct fsmonitor_daemon_state *state)
     ++{
     ++	return;
     ++}
     ++
     ++void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
     ++{
     ++}
      
       ## compat/fsmonitor/fsm-ipc-darwin.c => compat/fsmonitor/fsm-ipc-unix.c ##
      @@ compat/fsmonitor/fsm-ipc-unix.c: static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
     @@ compat/fsmonitor/fsm-ipc-unix.c: const char *fsmonitor_ipc__get_path(struct repo
       	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
       
      
     - ## compat/fsmonitor/fsm-settings-darwin.c => compat/fsmonitor/fsm-settings-unix.c ##
     + ## compat/fsmonitor/fsm-settings-darwin.c ##
     +@@
     + #include "config.h"
     + #include "fsmonitor.h"
     + #include "fsmonitor-ipc.h"
     +-#include "fsmonitor-settings.h"
     + #include "fsmonitor-path-utils.h"
     +-
     +- /*
     +- * For the builtin FSMonitor, we create the Unix domain socket for the
     +- * IPC in the .git directory.  If the working directory is remote,
     +- * then the socket will be created on the remote file system.  This
     +- * can fail if the remote file system does not support UDS file types
     +- * (e.g. smbfs to a Windows server) or if the remote kernel does not
     +- * allow a non-local process to bind() the socket.  (These problems
     +- * could be fixed by moving the UDS out of the .git directory and to a
     +- * well-known local directory on the client machine, but care should
     +- * be taken to ensure that $HOME is actually local and not a managed
     +- * file share.)
     +- *
     +- * FAT32 and NTFS working directories are problematic too.
     +- *
     +- * The builtin FSMonitor uses a Unix domain socket in the .git
     +- * directory for IPC.  These Windows drive formats do not support
     +- * Unix domain sockets, so mark them as incompatible for the daemon.
     +- *
     +- */
     +-static enum fsmonitor_reason check_uds_volume(struct repository *r)
     +-{
     +-	struct fs_info fs;
     +-	const char *ipc_path = fsmonitor_ipc__get_path(r);
     +-	struct strbuf path = STRBUF_INIT;
     +-	strbuf_add(&path, ipc_path, strlen(ipc_path));
     +-
     +-	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
     +-		strbuf_release(&path);
     +-		return FSMONITOR_REASON_ERROR;
     +-	}
     +-
     +-	strbuf_release(&path);
     +-
     +-	if (fs.is_remote ||
     +-		!strcmp(fs.typename, "msdos") ||
     +-		!strcmp(fs.typename, "ntfs")) {
     +-		free(fs.typename);
     +-		return FSMONITOR_REASON_NOSOCKETS;
     +-	}
     +-
     +-	free(fs.typename);
     +-	return FSMONITOR_REASON_OK;
     +-}
     ++#include "fsmonitor-settings.h"
     ++#include "fsm-settings-unix.h"
     + 
     + enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
     + {
     +-	enum fsmonitor_reason reason;
     +-
     +-	if (ipc) {
     +-		reason = check_uds_volume(r);
     +-		if (reason != FSMONITOR_REASON_OK)
     +-			return reason;
     +-	}
     +-
     +-	return FSMONITOR_REASON_OK;
     ++    return fsm_os__incompatible_unix(r, ipc);
     + }
     +
     + ## compat/fsmonitor/fsm-settings-linux.c (new) ##
     +@@
     ++#include "config.h"
     ++#include "fsmonitor.h"
     ++#include "fsmonitor-ipc.h"
     ++#include "fsmonitor-path-utils.h"
     ++#include "fsmonitor-settings.h"
     ++#include "fsm-settings-unix.h"
     ++
     ++enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
     ++{
     ++    return fsm_os__incompatible_unix(r, ipc);
     ++}
      
     - ## config.mak.uname ##
     -@@ config.mak.uname: ifeq ($(uname_S),Linux)
     - 	ifneq ($(findstring .el7.,$(uname_R)),)
     - 		BASIC_CFLAGS += -std=c99
     - 	endif
     + ## compat/fsmonitor/fsm-settings-unix.c (new) ##
     +@@
     ++#include "config.h"
     ++#include "fsmonitor.h"
     ++#include "fsmonitor-ipc.h"
     ++#include "fsmonitor-path-utils.h"
     ++#include "fsm-settings-unix.h"
      +
     - endif
     - ifeq ($(uname_S),GNU/kFreeBSD)
     - 	HAVE_ALLOCA_H = YesPlease
     ++ /*
     ++ * For the builtin FSMonitor, we create the Unix domain socket for the
     ++ * IPC in the .git directory.  If the working directory is remote,
     ++ * then the socket will be created on the remote file system.  This
     ++ * can fail if the remote file system does not support UDS file types
     ++ * (e.g. smbfs to a Windows server) or if the remote kernel does not
     ++ * allow a non-local process to bind() the socket.  (These problems
     ++ * could be fixed by moving the UDS out of the .git directory and to a
     ++ * well-known local directory on the client machine, but care should
     ++ * be taken to ensure that $HOME is actually local and not a managed
     ++ * file share.)
     ++ *
     ++ * FAT32 and NTFS working directories are problematic too.
     ++ *
     ++ * The builtin FSMonitor uses a Unix domain socket in the .git
     ++ * directory for IPC.  These Windows drive formats do not support
     ++ * Unix domain sockets, so mark them as incompatible for the daemon.
     ++ *
     ++ */
     ++static enum fsmonitor_reason check_uds_volume(struct repository *r)
     ++{
     ++	struct fs_info fs;
     ++	const char *ipc_path = fsmonitor_ipc__get_path(r);
     ++	struct strbuf path = STRBUF_INIT;
     ++	strbuf_add(&path, ipc_path, strlen(ipc_path));
     ++
     ++	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) == -1) {
     ++		strbuf_release(&path);
     ++		return FSMONITOR_REASON_ERROR;
     ++	}
     ++
     ++	strbuf_release(&path);
     ++
     ++	if (fs.is_remote ||
     ++		!strcmp(fs.typename, "msdos") ||
     ++		!strcmp(fs.typename, "ntfs")) {
     ++		free(fs.typename);
     ++		return FSMONITOR_REASON_NOSOCKETS;
     ++	}
     ++
     ++	free(fs.typename);
     ++	return FSMONITOR_REASON_OK;
     ++}
     ++
     ++enum fsmonitor_reason fsm_os__incompatible_unix(struct repository *r, int ipc)
     ++{
     ++	enum fsmonitor_reason reason;
     ++
     ++	if (ipc) {
     ++		reason = check_uds_volume(r);
     ++		if (reason != FSMONITOR_REASON_OK)
     ++			return reason;
     ++	}
     ++
     ++	return FSMONITOR_REASON_OK;
     ++}
     +
     + ## compat/fsmonitor/fsm-settings-unix.h (new) ##
     +@@
     ++#ifndef FSM_SETTINGS_UNIX_H
     ++#define FSM_SETTINGS_UNIX_H
     ++
     ++#ifdef HAVE_FSMONITOR_OS_SETTINGS
     ++/*
     ++ * Check for compatibility on unix-like systems (e.g. Darwin and Linux)
     ++ */
     ++enum fsmonitor_reason fsm_os__incompatible_unix(struct repository *r, int ipc);
     ++#endif /* HAVE_FSMONITOR_OS_SETTINGS */
     ++
     ++#endif /* FSM_SETTINGS_UNIX_H */
     +
     + ## config.mak.uname ##
      @@ config.mak.uname: ifeq ($(uname_S),Darwin)
       	ifndef NO_UNIX_SOCKETS
       	FSMONITOR_DAEMON_BACKEND = darwin
     @@ config.mak.uname: ifeq ($(uname_S),Darwin)
       	endif
       	endif
       
     -@@ config.mak.uname: ifeq ($(uname_S),Windows)
     - 	# support it.
     - 	FSMONITOR_DAEMON_BACKEND = win32
     - 	FSMONITOR_OS_SETTINGS = win32
     -+	FSMONITOR_DAEMON_COMMON = win32
     - 
     - 	NO_SVN_TESTS = YesPlease
     - 	RUNTIME_PREFIX = YesPlease
     -@@ config.mak.uname: ifeq ($(uname_S),MINGW)
     - 	# support it.
     - 	FSMONITOR_DAEMON_BACKEND = win32
     - 	FSMONITOR_OS_SETTINGS = win32
     -+	FSMONITOR_DAEMON_COMMON = win32
     - 
     - 	RUNTIME_PREFIX = YesPlease
     - 	HAVE_WPGMPTR = YesWeDo
      
       ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: else()
     + endif()
     + 
     + if(SUPPORTS_SIMPLE_IPC)
     +-	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     ++	if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
     ++		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-linux.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
     ++
     ++		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-linux.c)
     ++	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     + 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
      @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
       		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
       	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
       		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
      +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-unix.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-unix.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
     --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
      -		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
     ++		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
       		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
       
       		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
      +		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
     + 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
       	endif()
       endif()
     - 
  8:  5ecbb3082f1 !  8:  7d7ef78728f fsmonitor: determine if filesystem is local or remote
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +	 || strcmp ("-hosts", Fs_name) == 0)
      +#endif
      +
     -+static struct mntent *find_mount(const char *path, const struct statvfs *fs)
     ++static int find_mount(const char *path, const struct statvfs *fs,
     ++	struct mntent *ent)
      +{
      +	const char *const mounts = "/proc/mounts";
      +	const char *rp = real_pathdup(path, 1);
      +	struct mntent *ment = NULL;
     -+	struct mntent *found = NULL;
      +	struct statvfs mntfs;
      +	FILE *fp;
     ++	int found = 0;
      +	int dlen, plen, flen = 0;
      +
     ++	ent->mnt_fsname = NULL;
     ++	ent->mnt_dir = NULL;
     ++	ent->mnt_type = NULL;
     ++
      +	fp = setmntent(mounts, "r");
      +	if (!fp) {
      +		error_errno(_("setmntent('%s') failed"), mounts);
     -+		return NULL;
     ++		return -1;
      +	}
      +
      +	plen = strlen(rp);
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +			default:
      +				error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
      +				endmntent(fp);
     -+				return NULL;
     ++				return -1;
      +			}
      +		}
      +
     @@ compat/fsmonitor/fsm-path-utils-linux.c (new)
      +				 * The pointer points to a static area of memory which is
      +				 * overwritten by subsequent calls to getmntent().
      +				 */
     -+				if (!found)
     -+					CALLOC_ARRAY(found, 1);
     -+				free(found->mnt_dir);
     -+				free(found->mnt_type);
     -+				free(found->mnt_fsname);
     -+				found->mnt_dir = xmemdupz(ment->mnt_dir, strlen(ment->mnt_dir));
     -+				found->mnt_type = xmemdupz(ment->mnt_type, strlen(ment->mnt_type));
     -+				found->mnt_fsname = xmemdupz(ment->mnt_fsname, strlen(ment->mnt_fsname));
     ++				found = 1;
     ++				free(ent->mnt_fsname);
     ++				free(ent->mnt_dir);
     ++				free(ent->mnt_type);
     ++				ent->mnt_fsname = xstrdup(ment->mnt_fsname);
     ++				ent->mnt_dir = xstrdup(ment->mnt_dir);
     ++				ent->mnt_type = xstrdup(ment->mnt_type);
      +			}
      +		}
      +	}
      +	endmntent(fp);
      +
     -+	return found;
     ++	if (!found)
     ++		return -1;
     ++
     ++	return 0;
      +}
      +
      +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
      +{
     -+	struct mntent *ment;
     ++	struct mntent ment;
      +	struct statvfs fs;
      +
      +	if (statvfs(path, &fs))
      +		return error_errno(_("statvfs('%s') failed"), path);
      +
     -+	ment = find_mount(path, &fs);
     -+	if (!ment)
     ++
     ++	if (find_mount(path, &fs, &ment) < 0) {
     ++		free(ment.mnt_fsname);
     ++		free(ment.mnt_dir);
     ++		free(ment.mnt_type);
      +		return -1;
     ++	}
      +
      +	trace_printf_key(&trace_fsmonitor,
      +			 "statvfs('%s') [flags 0x%08lx] '%s' '%s'",
     -+			 path, fs.f_flag, ment->mnt_type, ment->mnt_fsname);
     -+
     -+	if (ME_REMOTE(ment->mnt_fsname, ment->mnt_type))
     -+		fs_info->is_remote = 1;
     -+	else
     -+		fs_info->is_remote = 0;
     ++			 path, fs.f_flag, ment.mnt_type, ment.mnt_fsname);
      +
     -+	fs_info->typename = ment->mnt_fsname;
     -+	free(ment->mnt_dir);
     -+	free(ment->mnt_type);
     -+	free(ment);
     ++	fs_info->is_remote = ME_REMOTE(ment.mnt_fsname, ment.mnt_type);
     ++	fs_info->typename = ment.mnt_fsname;
     ++	free(ment.mnt_dir);
     ++	free(ment.mnt_type);
      +
      +	trace_printf_key(&trace_fsmonitor,
      +				"'%s' is_remote: %d",
  9:  7465fe7a8b4 !  9:  4f9c5358475 fsmonitor: implement filesystem change listener for Linux
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +
      +/*
      + * Non-blocking read of the inotify events stream. The inotify fd is polled
     -+ * every few millisec to help minimize the number of queue overflows.
     ++ * frequently to help minimize the number of queue overflows.
      + */
      +void fsm_listen__loop(struct fsmonitor_daemon_state *state)
      +{
     @@ compat/fsmonitor/fsm-listen-linux.c (new)
      +	for(;;) {
      +		switch (state->listen_data->shutdown) {
      +			case SHUTDOWN_CONTINUE:
     -+				poll_num = poll(fds, 1, 10);
     ++				poll_num = poll(fds, 1, 1);
      +				if (poll_num == -1) {
      +					if (errno == EINTR)
      +						continue;
 10:  3a2db9aa076 ! 10:  07650ecd27b fsmonitor: enable fsmonitor for Linux
     @@ Metadata
       ## Commit message ##
          fsmonitor: enable fsmonitor for Linux
      
     -    Uodate build to enable fsmonitor for Linux.
     +    Update build to enable fsmonitor for Linux.
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
       ## config.mak.uname ##
      @@ config.mak.uname: ifeq ($(uname_S),Linux)
     + 	ifneq ($(findstring .el7.,$(uname_R)),)
       		BASIC_CFLAGS += -std=c99
       	endif
     - 
      +	# The builtin FSMonitor on Linux builds upon Simple-IPC.  Both require
      +	# Unix domain sockets and PThreads.
      +	ifndef NO_PTHREADS
     @@ config.mak.uname: ifeq ($(uname_S),Linux)
       endif
       ifeq ($(uname_S),GNU/kFreeBSD)
       	HAVE_ALLOCA_H = YesPlease
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
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-unix.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-linux.c)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-linux.c)
     -+
     -+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
     -+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-unix.c)
     -+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     - 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
     - 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
 11:  743bdacded5 ! 11:  6682938fff8 fsmonitor: test updates
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'edit some files' '
       
       	test-tool fsmonitor-client query --token 0 &&
       
     ++	test_might_fail git fsmonitor--daemon stop &&
     ++
     + 	grep "^event: dir1/modified$"  .git/trace &&
     + 	grep "^event: dir2/modified$"  .git/trace &&
     + 	grep "^event: modified$"       .git/trace &&
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'create some files' '
       
       	start_daemon --tf "$PWD/.git/trace" &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'create some files' '
       
       	test-tool fsmonitor-client query --token 0 &&
       
     ++	test_might_fail git fsmonitor--daemon stop &&
     ++
     + 	grep "^event: dir1/new$" .git/trace &&
     + 	grep "^event: dir2/new$" .git/trace &&
     + 	grep "^event: new$"      .git/trace
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'delete some files' '
       
       	start_daemon --tf "$PWD/.git/trace" &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'delete some files' '
       
       	test-tool fsmonitor-client query --token 0 &&
       
     ++	test_might_fail git fsmonitor--daemon stop &&
     ++
     + 	grep "^event: dir1/delete$" .git/trace &&
     + 	grep "^event: dir2/delete$" .git/trace &&
     + 	grep "^event: delete$"      .git/trace
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename some files' '
       
       	start_daemon --tf "$PWD/.git/trace" &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename some files' '
       
       	test-tool fsmonitor-client query --token 0 &&
       
     ++	test_might_fail git fsmonitor--daemon stop &&
     ++
     + 	grep "^event: dir1/rename$"  .git/trace &&
     + 	grep "^event: dir2/rename$"  .git/trace &&
     + 	grep "^event: rename$"       .git/trace &&
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename directory' '
       
       	start_daemon --tf "$PWD/.git/trace" &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'rename directory' '
       
       	test-tool fsmonitor-client query --token 0 &&
       
     ++	test_might_fail git fsmonitor--daemon stop &&
     ++
     + 	grep "^event: dirtorename/*$" .git/trace &&
     + 	grep "^event: dirrenamed/*$"  .git/trace
     + '
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'file changes to directory' '
       
       	start_daemon --tf "$PWD/.git/trace" &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'file changes to directory' '
       
       	test-tool fsmonitor-client query --token 0 &&
       
     ++	test_might_fail git fsmonitor--daemon stop &&
     ++
     + 	grep "^event: delete$"     .git/trace &&
     + 	grep "^event: delete/new$" .git/trace
     + '
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'directory changes to a file' '
       
       	start_daemon --tf "$PWD/.git/trace" &&
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'directory changes to a file'
       
       	test-tool fsmonitor-client query --token 0 &&
       
     ++	test_might_fail git fsmonitor--daemon stop &&
     ++
     + 	grep "^event: dir1$" .git/trace
     + '
     + 
      @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'flush cached data' '
       	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
       	nul_to_q <actual_2 >actual_q2 &&
 12:  77ed35b3b80 = 12:  dd73e126810 fsmonitor: update doc for Linux

-- 
gitgitgadget
