Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41D8ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIPTxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 15:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIPTxj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 15:53:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B98B6D79
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:53:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v185-20020a1cacc2000000b003b42e4f278cso479124wme.5
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=iYGz0lPQuivWEdn6vTVmkIqVL/VYINzDQ0IEceItPLQ=;
        b=MTRvMctHFAgby1cPFTd4uVpj1x0KXkM1CYD2Ey6XUWXkg2e3wUp14uC8WGlw56qniR
         mRYzo4zmtgOQMxKya8PbTyQVUNsmNjyQC5QhpDVZbgaPs68ea/xk3qaIHgrFEFK6LZ2H
         wfh8CMSYPmT/Z+NceASf2d9R5qvSgLpueYgjB7u7WH0SXVYr9+ZRy9DHDRnwpTScz0C4
         6O6R0/njHjuJl7r69MUa5b8pZrzW34NpTjyrIRbzeiS95CAPjMFzgkq4SLo4WBre8NM/
         hyA5nsg5Mu3btmkeUOamQapVpT7OpQpvXyZEcf2rWpilr8kcExEBuIAiENdv63jGRPlr
         imUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iYGz0lPQuivWEdn6vTVmkIqVL/VYINzDQ0IEceItPLQ=;
        b=EJNQbpiEqxvEZg5Esfm08R7hnG2tcoWES4xYKb106FellWqWjA/w7+1HMTQpcVQ7SH
         hqqoeLZPUV6Tj077r0uaarSj6TshtFU0+lQblAdoApO5kn9XGGSgODaYdLV4a9EJqmmz
         h5CPWiMFdJerL0DpSch1pILjw5gXsUlWnammRRIyc+1KQkSP6HoMuyQcQNAO3SSuk8UW
         yUD6kfqVdz29FR8/mPz6+tv/ECm5iWLiBo6aZlB7BMi7U9DlomuqWuHUI0fEvDU9g8aD
         TXUnokBgOFkZLLbf3qiNNzMCsC+rwBMt6wJpIf9L1eMc2qgZ9SlkdQNAmnT5varXR0vo
         uZKQ==
X-Gm-Message-State: ACrzQf0P8QuI483YrjGN9fXilZoQxux4YsEL4pfzOPAjWs0+WVYPGvbz
        O1oJXhJAxkmME7CPJDJUuIEioMLvu4o=
X-Google-Smtp-Source: AMsMyM77mmKzRFvNR/Q4iByaQPV6nPe/VHAN1T6mgNiPViHIQN6gAAfhdZcbzV8IIZr0PScdY0PKxQ==
X-Received: by 2002:a7b:cb56:0:b0:3b3:4ad8:9e31 with SMTP id v22-20020a7bcb56000000b003b34ad89e31mr4489981wmj.87.1663358016203;
        Fri, 16 Sep 2022 12:53:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d4c8d000000b0021f131de6aesm5590770wrs.34.2022.09.16.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:53:35 -0700 (PDT)
Message-Id: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 19:53:28 +0000
Subject: [PATCH v7 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-on to the work done to allow Windows to work against network-mounted
repos for macOS.

Have macOS take advantage of the same configuration option,
'fsmonitor.allowRemote' that was introduced for Windows. Setting this option
to true will override the default behavior (erroring-out) when a
network-mounted repo is detected by fsmonitor.

The added wrinkle being that the Unix domain socket (UDS) file used for IPC
cannot be created in a network location; instead $HOME is used if the
default location is on the network. The user may, optionally, set the
'fsmonitor.socketDir' configuration option to a valid, local directory if
$HOME itself is on the network or is simply not the desired location for the
UDS file.

An additional issue is that for mount points in the root directory, FSEvents
does not report a path that matches the worktree directory due to the
introduction of 'synthetic firmlinks'. fsmonitor must map the FSEvents paths
to the worktree directory by interrogating the root filesystem for synthetic
firmlinks and using that information to translate the path.

v7 differs from v6:

 * incorporates code review feedback

v6 differs from v5:

 * incorporates earlier, Windows-specific changes that have not made it back
   yet to the master branch
 * incorporates code review feedback
 * adds documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'

v5 differs significantly from earlier versions:

 * redesign of handling 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'
   such that these options are no longer added to the settings data
   structure but are rather read from config at point of use
 * refactoring of code for handling platform-specific file system checks via
   a common interface to avoid platform #ifdef in IPC code and be in-model
   with other platform-specific fsmonitor code
 * dealing with 'synthetic firmlinks' on macOS

Eric DeCosta (6):
  fsmonitor: refactor filesystem checks to common interface
  fsmonitor: relocate socket file if .git directory is remote
  fsmonitor: avoid socket location check if using hook
  fsmonitor: deal with synthetic firmlinks on macOS
  fsmonitor: deal with synthetic firmlinks on macOS
  fsmonitor: add documentation for allowRemote and socketDir options

 Documentation/git-fsmonitor--daemon.txt  |  35 +++++
 Makefile                                 |   2 +
 builtin/fsmonitor--daemon.c              |  11 +-
 compat/fsmonitor/fsm-ipc-darwin.c        |  49 +++++++
 compat/fsmonitor/fsm-ipc-win32.c         |   9 ++
 compat/fsmonitor/fsm-listen-darwin.c     |   6 +-
 compat/fsmonitor/fsm-path-utils-darwin.c | 132 +++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 145 +++++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c   |  70 +++------
 compat/fsmonitor/fsm-settings-win32.c    | 174 +----------------------
 contrib/buildsystems/CMakeLists.txt      |   4 +
 fsmonitor--daemon.h                      |   6 +
 fsmonitor-ipc.c                          |  18 ++-
 fsmonitor-ipc.h                          |   4 +-
 fsmonitor-path-utils.h                   |  59 ++++++++
 fsmonitor-settings.c                     |  58 +++++++-
 fsmonitor-settings.h                     |   2 +-
 17 files changed, 547 insertions(+), 237 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v6:

 1:  3233c908c4a < -:  ----------- fsmonitor: option to allow fsmonitor to run against network-mounted repos
 2:  d2a8fc6b707 = 1:  155a6890806 fsmonitor: refactor filesystem checks to common interface
 3:  edef029a298 ! 2:  075340bd2a7 fsmonitor: relocate socket file if .git directory is remote
     @@ Makefile: ifdef FSMONITOR_DAEMON_BACKEND
       
       ifdef FSMONITOR_OS_SETTINGS
      
     + ## builtin/fsmonitor--daemon.c ##
     +@@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
     + 	 * directory.)
     + 	 */
     + 	strbuf_init(&state.path_ipc, 0);
     +-	strbuf_addstr(&state.path_ipc, absolute_path(fsmonitor_ipc__get_path()));
     ++	strbuf_addstr(&state.path_ipc,
     ++		absolute_path(fsmonitor_ipc__get_path(the_repository)));
     + 
     + 	/*
     + 	 * Confirm that we can create platform-specific resources for the
     +
       ## compat/fsmonitor/fsm-ipc-darwin.c (new) ##
      @@
      +#include "cache.h"
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +
      +static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon.ipc")
      +
     -+const char *fsmonitor_ipc__get_path(void)
     ++const char *fsmonitor_ipc__get_path(struct repository *r)
      +{
      +	static const char *ipc_path;
      +	SHA_CTX sha1ctx;
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +	if (ipc_path)
      +		return ipc_path;
      +
     ++	if (!r)
     ++		r = the_repository;
     ++
      +	ipc_path = fsmonitor_ipc__get_default_path();
      +
      +	/* By default the socket file is created in the .git directory */
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +		return ipc_path;
      +
      +	SHA1_Init(&sha1ctx);
     -+	SHA1_Update(&sha1ctx, the_repository->worktree, strlen(the_repository->worktree));
     ++	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
      +	SHA1_Final(hash, &sha1ctx);
      +
     -+	repo_config_get_string(the_repository, "fsmonitor.socketdir", &sock_dir);
     ++	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
      +
      +	/* Create the socket file in either socketDir or $HOME */
      +	if (sock_dir && *sock_dir)
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      
       ## compat/fsmonitor/fsm-ipc-win32.c (new) ##
      @@
     -+#include "cache.h"
     ++#include "config.h"
      +#include "fsmonitor-ipc.h"
      +
     -+GIT_PATH_FUNC(fsmonitor_ipc__get_path, "fsmonitor--daemon.ipc")
     ++const char *fsmonitor_ipc__get_path(struct repository *r) {
     ++	static char *ret;
     ++	if (!ret)
     ++		ret = git_pathdup("fsmonitor--daemon.ipc");
     ++	return ret;
     ++}
     + \ No newline at end of file
     +
     + ## compat/fsmonitor/fsm-settings-darwin.c ##
     +@@
     + static enum fsmonitor_reason check_uds_volume(struct repository *r)
     + {
     + 	struct fs_info fs;
     +-	const char *ipc_path = fsmonitor_ipc__get_path();
     ++	const char *ipc_path = fsmonitor_ipc__get_path(r);
     + 	struct strbuf path = STRBUF_INIT;
     + 	strbuf_add(&path, ipc_path, strlen(ipc_path));
     + 
      
       ## contrib/buildsystems/CMakeLists.txt ##
      @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
     @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
       		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
      
       ## fsmonitor-ipc.c ##
     +@@ fsmonitor-ipc.c: int fsmonitor_ipc__is_supported(void)
     + 	return 0;
     + }
     + 
     +-const char *fsmonitor_ipc__get_path(void)
     ++const char *fsmonitor_ipc__get_path(struct repository *r)
     + {
     + 	return NULL;
     + }
      @@ fsmonitor-ipc.c: int fsmonitor_ipc__is_supported(void)
       	return 1;
       }
     @@ fsmonitor-ipc.c: int fsmonitor_ipc__is_supported(void)
      -
       enum ipc_active_state fsmonitor_ipc__get_state(void)
       {
     - 	return ipc_get_active_state(fsmonitor_ipc__get_path());
     +-	return ipc_get_active_state(fsmonitor_ipc__get_path());
     ++	return ipc_get_active_state(fsmonitor_ipc__get_path(the_repository));
     + }
     + 
     + static int spawn_daemon(void)
     +@@ fsmonitor-ipc.c: int fsmonitor_ipc__send_query(const char *since_token,
     + 	trace2_data_string("fsm_client", NULL, "query/command", tok);
     + 
     + try_again:
     +-	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
     +-				       &connection);
     ++	state = ipc_client_try_connect(fsmonitor_ipc__get_path(the_repository),
     ++						&options, &connection);
     + 
     + 	switch (state) {
     + 	case IPC_STATE__LISTENING:
     +@@ fsmonitor-ipc.c: try_again:
     + 
     + 	case IPC_STATE__INVALID_PATH:
     + 		ret = error(_("fsmonitor_ipc__send_query: invalid path '%s'"),
     +-			    fsmonitor_ipc__get_path());
     ++			    fsmonitor_ipc__get_path(the_repository));
     + 		goto done;
     + 
     + 	case IPC_STATE__OTHER_ERROR:
     + 	default:
     + 		ret = error(_("fsmonitor_ipc__send_query: unspecified error on '%s'"),
     +-			    fsmonitor_ipc__get_path());
     ++			    fsmonitor_ipc__get_path(the_repository));
     + 		goto done;
     + 	}
     + 
     +@@ fsmonitor-ipc.c: int fsmonitor_ipc__send_command(const char *command,
     + 	options.wait_if_busy = 1;
     + 	options.wait_if_not_found = 0;
     + 
     +-	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
     +-				       &connection);
     ++	state = ipc_client_try_connect(fsmonitor_ipc__get_path(the_repository),
     ++						&options, &connection);
     + 	if (state != IPC_STATE__LISTENING) {
     + 		die(_("fsmonitor--daemon is not running"));
     + 		return -1;
     +
     + ## fsmonitor-ipc.h ##
     +@@
     + 
     + #include "simple-ipc.h"
     + 
     ++struct repository;
     ++
     + /*
     +  * Returns true if built-in file system monitor daemon is defined
     +  * for this platform.
     +@@ fsmonitor-ipc.h: int fsmonitor_ipc__is_supported(void);
     +  *
     +  * Returns NULL if the daemon is not supported on this platform.
     +  */
     +-const char *fsmonitor_ipc__get_path(void);
     ++const char *fsmonitor_ipc__get_path(struct repository *r);
     + 
     + /*
     +  * Try to determine whether there is a `git-fsmonitor--daemon` process
 4:  3428bcf8763 = 3:  5518d2f3e03 fsmonitor: avoid socket location check if using hook
 5:  9c1f408ae6d ! 4:  3a9fe473cf4 fsmonitor: deal with synthetic firmlinks on macOS
     @@ fsmonitor--daemon.h: struct fsmonitor_daemon_state {
       };
       
       /*
     -@@ fsmonitor--daemon.h: void fsmonitor_publish(struct fsmonitor_daemon_state *state,
     -  */
     - void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
     - 
     -+char *fsmonitor_resolve_alias(const char *path,
     -+	struct alias_info *alias);
     -+
     - #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
     - #endif /* FSMONITOR_DAEMON_H */
      
       ## fsmonitor-path-utils.h ##
      @@
 -:  ----------- > 5:  4d00adb1deb fsmonitor: deal with synthetic firmlinks on macOS
 6:  d2c95e34d3a = 6:  260591f5820 fsmonitor: add documentation for allowRemote and socketDir options

-- 
gitgitgadget
