Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA8C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 20:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiI0U5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiI0U5i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 16:57:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE9B149D2F
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:57:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so16838836wrm.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=gCSMx7dgO1c1lzmdaHmMW8DgJLoTw9g69RBl0R7wA5I=;
        b=HncihXDjuqhclTSAzFJDDnTG00dvRrouNVgHgYShk57lym8/1iV/AtSvO7asZ8dYOz
         BuUuBmGW1hsI0PAxTi6s98Sf7peMwDbR0e4Raiwo+c+7Ip/B3BlBn6PhyOQcgksKyNTu
         uR7Db4cBhPMCTmfsjCGEvTN3v70l/ZlKnaK6bwSQLJrWikyov1pIkl9KuBcDIA7T6UfF
         wAqIpgh6CXL9R/gQlr6EZxlR3+kmottkU9zDBvCBtbAUcC2m2DQT6QmyjXLsAQc+ozFJ
         Evhpczflr1+EvVH3Ecsb6cSSHwyehoMHD+JURNNoWzfg0ff77QV6ELOTZsmeifTirNN1
         ighw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gCSMx7dgO1c1lzmdaHmMW8DgJLoTw9g69RBl0R7wA5I=;
        b=ezQ30dBAeo3FC0xVG6XofVUEoeSb3bBapphGYuFQKId/yrkUWzquMe5PJHRZxF48sV
         qMIdVGDG+HBatqMGhYzeLf5FdqBNj1+1JPHXOQqfnd185PTtf9teGmUZOolGRtcowPYM
         8b1y4Lbm7Nv06+2y3HSmekfAF5QyMlk5NFCQiVpuWOb60Vii6Qp67cvkHvuSw1lKmsOc
         suQvlvyPP7kVYmRfMFCHKPZQDxjGVM9ymJ0akPO24matGp80PKXARcC7+3E4Qxr5MKBa
         CE9DGXF/tFcpY8YAux53GMp8eEhJVBWcqx5Bj9Xbg49hK6kxdwhgh+1p2Z5Hi+YzHqjJ
         NrEw==
X-Gm-Message-State: ACrzQf0XRWDRvpp5CpxXWnvsHIgLqaHI2dwkNEZnx/L1A375xt9xzh8m
        /f2CCgNToYS7prAGwLIRxXGTnq4dmm4=
X-Google-Smtp-Source: AMsMyM5l1PiDxh1/eLOSg4WzgxCfE4VEvRev+TWYxYQzoKpwuIgTxr9ewBeXTDcLUx0DnQf+vkmuAg==
X-Received: by 2002:adf:d1e3:0:b0:22a:b9e2:8841 with SMTP id g3-20020adfd1e3000000b0022ab9e28841mr17939662wrd.184.1664312255412;
        Tue, 27 Sep 2022 13:57:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4ac8000000b0022a403954c3sm2551719wrs.42.2022.09.27.13.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:57:34 -0700 (PDT)
Message-Id: <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
References: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 20:57:27 +0000
Subject: [PATCH v13 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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

v13 differs from v12:

 * code review feedback

v12 differs from v11:

 * bug fixes

v11 differs from v10:

 * incorporates code review feedback
 * fix memory leak in fsm-listen-darwin.c

v10 differs from v9:

 * incorporates code review feedback
 * improves error messaging for incompatible socket directory

v9 differs from v8:

 * incorporates code review feedback
 * check for incompatibility before communicating with fsmonitor

v8 differs from v7:

 * incorporates code review feedback
 * gets the rebase right

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
  fsmonitor: check for compatability before communicating with fsmonitor
  fsmonitor: add documentation for allowRemote and socketDir options

 Documentation/config.txt                   |   2 +
 Documentation/config/fsmonitor--daemon.txt |  11 ++
 Documentation/git-fsmonitor--daemon.txt    |  37 ++++-
 Makefile                                   |   2 +
 builtin/fsmonitor--daemon.c                |  13 +-
 compat/fsmonitor/fsm-ipc-darwin.c          |  52 ++++++
 compat/fsmonitor/fsm-ipc-win32.c           |   9 ++
 compat/fsmonitor/fsm-listen-darwin.c       |  14 +-
 compat/fsmonitor/fsm-path-utils-darwin.c   | 133 ++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c    | 145 +++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c     |  72 +++------
 compat/fsmonitor/fsm-settings-win32.c      | 174 +--------------------
 contrib/buildsystems/CMakeLists.txt        |   4 +
 fsmonitor--daemon.h                        |   3 +
 fsmonitor-ipc.c                            |  18 +--
 fsmonitor-ipc.h                            |   4 +-
 fsmonitor-path-utils.h                     |  57 +++++++
 fsmonitor-settings.c                       |  68 +++++++-
 fsmonitor-settings.h                       |   4 +-
 fsmonitor.c                                |   7 +
 20 files changed, 583 insertions(+), 246 deletions(-)
 create mode 100644 Documentation/config/fsmonitor--daemon.txt
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: 2a7d63a2453e2c30353342a2c9385fa22a846987
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v13
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v12:

 1:  5958dab0163 = 1:  0b9b64428c5 fsmonitor: refactor filesystem checks to common interface
 2:  20220b08edb ! 2:  680d4c83f99 fsmonitor: relocate socket file if .git directory is remote
     @@ Metadata
       ## Commit message ##
          fsmonitor: relocate socket file if .git directory is remote
      
     -    If the .git directory is on a remote file system, create the socket
     +    If the .git directory is on a remote filesystem, create the socket
          file in 'fsmonitor.socketDir' if it is defined, else create it in $HOME.
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
 3:  e9921550a67 = 3:  7987d0c1f33 fsmonitor: avoid socket location check if using hook
 4:  6efdc6ed74e ! 4:  324eb5acd85 fsmonitor: deal with synthetic firmlinks on macOS
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
       	state.nr_paths_watching = 1;
       
     -+	state.alias.alias = NULL;
     -+	state.alias.points_to = NULL;
     ++	strbuf_init(&state.alias.alias, 0);
     ++	strbuf_init(&state.alias.points_to, 0);
      +	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
      +		err = error(_("could not get worktree alias"));
      +		goto done;
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       	/*
       	 * We create and delete cookie files somewhere inside the .git
       	 * directory to help us keep sync with the file system.  If
     +@@ builtin/fsmonitor--daemon.c: done:
     + 	strbuf_release(&state.path_gitdir_watch);
     + 	strbuf_release(&state.path_cookie_prefix);
     + 	strbuf_release(&state.path_ipc);
     ++	strbuf_release(&state.alias.alias);
     ++	strbuf_release(&state.alias.points_to);
     + 
     + 	return err;
     + }
      
       ## compat/fsmonitor/fsm-listen-darwin.c ##
      @@
     @@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char
      + */
      +int fsmonitor__get_alias(const char *path, struct alias_info *info)
      +{
     -+	DIR * dir;
     ++	DIR *dir;
      +	int read;
     -+	int retval;
     ++	int retval = -1;
      +	struct dirent *de;
      +	struct strbuf alias;
      +	struct strbuf points_to;
      +
     -+	retval = 0;
      +	dir = opendir("/");
     -+	if (!dir)
     ++	if (!dir) {
     ++		error_errno("opendir('/') failed");
      +		return -1;
     ++	}
      +
      +	strbuf_init(&alias, 256);
     ++
     ++	/* no way of knowing what the link will resolve to, so MAXPATHLEN */
      +	strbuf_init(&points_to, MAXPATHLEN);
      +
      +	while ((de = readdir(dir)) != NULL) {
     @@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char
      +		read = readlink(alias.buf, points_to.buf, MAXPATHLEN);
      +		if (read > 0) {
      +			strbuf_setlen(&points_to, read);
     -+			if ((strncmp(points_to.buf, path, points_to.len) == 0)
     ++			if ((!strncmp(points_to.buf, path, points_to.len))
      +				&& path[points_to.len] == '/') {
     -+				info->alias = strbuf_detach(&alias, NULL);
     -+				info->points_to = strbuf_detach(&points_to, NULL);
     ++				strbuf_addbuf(&info->alias, &alias);
     ++				strbuf_addbuf(&info->points_to, &points_to);
      +				trace_printf_key(&trace_fsmonitor,
      +					"Found alias for '%s' : '%s' -> '%s'",
     -+					path, info->alias, info->points_to);
     ++					path, info->alias.buf, info->points_to.buf);
      +				retval = 0;
      +				goto done;
      +			}
     ++		} else if (!read) {
     ++			BUG("readlink returned 0");
      +		} else if (errno != EINVAL) { /* Something other than not a link */
     -+			trace_printf_key(&trace_fsmonitor, "Error %s", strerror(errno));
     -+			retval = -1;
     ++			error_errno("readlink('%s') failed", alias.buf);
      +			goto done;
      +		}
      +	}
     ++	retval = 0; /* no alias */
      +
     -+	done:
     -+	closedir(dir);
     ++done:
     ++	if (closedir(dir) < 0)
     ++		warning_errno("closedir('/') failed");
      +	strbuf_release(&alias);
      +	strbuf_release(&points_to);
      +	return retval;
     @@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char
      +char *fsmonitor__resolve_alias(const char *path,
      +	const struct alias_info *info)
      +{
     -+	int len = info->alias ? strlen(info->alias) : 0;
     -+
     -+	if (!len)
     ++	if (!info->alias.len)
      +		return NULL;
      +
     -+	if ((strncmp(info->alias, path, len) == 0)
     -+		&& path[len] == '/') {
     -+		struct strbuf tmp;
     -+		const char *remainder = path + len;
     -+		int ptr_len = strlen(info->points_to);
     -+		int rem_len = strlen(remainder);
     ++	if ((!strncmp(info->alias.buf, path, info->alias.len))
     ++		&& path[info->alias.len] == '/') {
     ++		struct strbuf tmp = STRBUF_INIT;
     ++		const char *remainder = path + info->alias.len;
      +
     -+		strbuf_init(&tmp, ptr_len + rem_len);
     -+		strbuf_add(&tmp, info->points_to, ptr_len);
     -+		strbuf_add(&tmp, remainder, rem_len);
     ++		strbuf_addbuf(&tmp, &info->points_to);
     ++		strbuf_add(&tmp, remainder, strlen(remainder));
      +		return strbuf_detach(&tmp, NULL);
      +	}
      +
     @@ fsmonitor-path-utils.h
      +
      +struct alias_info
      +{
     -+	char *alias;
     -+	char *points_to;
     ++	struct strbuf alias;
     ++	struct strbuf points_to;
      +};
      +
       struct fs_info {
       	int is_remote;
       	char *typename;
     + };
     + 
     + /*
     +- * Get some basic filesystem informtion for the given path
     ++ * Get some basic filesystem information for the given path
     +  *
     +  * Returns -1 on error, zero otherwise.
     +  */
      @@ fsmonitor-path-utils.h: int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info);
        */
       int fsmonitor__is_fs_remote(const char *path);
     @@ fsmonitor-path-utils.h: int fsmonitor__get_fs_info(const char *path, struct fs_i
      + *
      + * Returns -1 on error, 0 otherwise.
      + *
     -+ * The caller owns the storage that is occupied by set info.alias and
     -+ * info.points_to and is responsible for releasing it with `free(3)`
     -+ * when done.
     ++ * The caller owns the storage that is occupied by info.alias and
     ++ * info.points_to and is responsible for releasing it.
      + */
      +int fsmonitor__get_alias(const char *path, struct alias_info *info);
      +
     @@ fsmonitor-path-utils.h: int fsmonitor__get_fs_info(const char *path, struct fs_i
      + * Returns the resolved path if there is one, NULL otherwise.
      + *
      + * The caller owns the storage that the returned string occupies and
     -+ * is responsible for releasing it with `free(3)` when done.
     ++ * is responsible for releasing it.
      + */
      +char *fsmonitor__resolve_alias(const char *path,
      +	const struct alias_info *info);
     -+
      +
       #endif
 5:  421d77775dc ! 5:  b1ea378dff7 fsmonitor: check for compatability before communicating with fsmonitor
     @@ Metadata
       ## Commit message ##
          fsmonitor: check for compatability before communicating with fsmonitor
      
     -    If fsmonitor is not in a compatible state, die with an appropriate error
     -    messge.
     +    If fsmonitor is not in a compatible state, warn with an appropriate message.
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
     @@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repo
      -			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
      -			    r->worktree);
      +			    _("socket directory '%s' is incompatible with fsmonitor due"
     -+				  " to lack of Unix sockets support"),
     ++			      " to lack of Unix sockets support"),
      +			    socket_dir);
       		goto done;
       	}
 6:  b375b0ac798 ! 6:  04f607b1f21 fsmonitor: add documentation for allowRemote and socketDir options
     @@ Commit message
          fsmonitor: add documentation for allowRemote and socketDir options
      
          Add documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'.
     -    Call-out experimental nature of 'fsmonitor.allowRemote' and limited file
     -    system support for 'fsmonitor.socketDir'.
     +    Call-out experimental nature of 'fsmonitor.allowRemote' and limited
     +    filesystem support for 'fsmonitor.socketDir'.
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
     + ## Documentation/config.txt ##
     +@@ Documentation/config.txt: include::config/filter.txt[]
     + 
     + include::config/fsck.txt[]
     + 
     ++include::config/fsmonitor--daemon.txt[]
     ++
     + include::config/gc.txt[]
     + 
     + include::config/gitcvs.txt[]
     +
     + ## Documentation/config/fsmonitor--daemon.txt (new) ##
     +@@
     ++fsmonitor.allowRemote::
     ++    By default, the fsmonitor daemon refuses to work against network-mounted
     ++    repositories. Setting `fsmonitor.allowRemote` to `true` overrides this
     ++    behavior.  Only respected when `core.fsmonitor` is set to `true`.
     ++
     ++fsmonitor.socketDir::
     ++    This Mac OS-specific option, if set, specifies the directory in
     ++    which to create the Unix domain socket used for communication
     ++    between the fsmonitor daemon and various Git commands. The directory must
     ++    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
     ++    is set to `true`.
     +
       ## Documentation/git-fsmonitor--daemon.txt ##
      @@ Documentation/git-fsmonitor--daemon.txt: git-fsmonitor{litdd}daemon(1)
       
     @@ Documentation/git-fsmonitor--daemon.txt: CAVEATS
      +CONFIGURATION
      +-------------
      +
     -+When `core.fsmonitor` is set to `true` (see linkgit:git-config[1])
     -+the fsmonitor daemon will pay attention to the following configuration
     -+variables:
     ++include::includes/cmd-config-section-all.txt[]
      +
     -+`fsmonitor.allowRemote`::
     -+	By default, the daemon refuses to work against network-mounted
     -+	repositories. Setting `fsmonitor.allowRemote` to `true` overrides
     -+	this behavior.
     -+
     -+`fsmonitor.socketDir`::
     -+    This Mac OS-specific option, if set, specifies the directory in
     -+    which to create the Unix domain socket used for communication
     -+    between fsmonitor and various Git commands. The directory must
     -+    reside on a native Mac OS filesystem as discussed above.
     ++include::config/fsmonitor--daemon.txt[]
      +
       GIT
       ---

-- 
gitgitgadget
