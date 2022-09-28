Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EFFC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 20:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiI1UMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiI1UMS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 16:12:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85EA2860
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:12:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h7so9041617wru.10
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=TC5TUVZ9ZyUHqSrZaXWnjyGI/Q9l9ViN7IDqVDy0sLo=;
        b=D6YPzvCNOaBHYX+zO+eZxxwk+gMdTNwTavgWk6gKMUFQwMbzeLsTRHR0sGOa1L5i9t
         5IQiE+aC0VaTHTFYjPP2mTy9UXP1IorbaREV7MxsGT73f/xWqijn72rRJcNVO+AD8Hy1
         +ZyeFbjFG90qz/pMH5vPBwx5q0hqsyPdYnC2Dg1TH1rXY4QxYb8u6uJVyeaZOVisZzJp
         xBn1DYgwm7Hb3zgh8JL5n+PwVyAzOjtDcHMKElmQXa7XKyoZF491H69PpHqFsTwCR1XV
         lLjbC+f/j+UHcSyc9Ab5em0QpMFUP/ANr7TJjriD3OAL7JW2Id6UpMbJtVAQaLlRlmxQ
         PKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TC5TUVZ9ZyUHqSrZaXWnjyGI/Q9l9ViN7IDqVDy0sLo=;
        b=I1+7hhJAIkaDPF4mwhhKPbkC0X0Tz1s0xhXWfoLbQ/4uh1AHDQFvRIKobSZwz/YxsD
         s+V7bKWzobZsxd/eM2eJTxWjof4uXuHevhxZI0IxuL3CCVfsz4jOu+JiSx11kk5kWBNO
         y4fdWhfRG13Sb5XmFDa8LZoymeVh3wm068nCbZzvyOFcAosNcoBzeAg2IKRaFD/Rm65T
         /PiUJOn0RdrLYPg0UleVIgG2T9UCK9VRe/IvYXMHBfBMfIjdB0rrTpFWZ7rE937KvCsn
         aQtAQoi9i4RtAujRmNtpnEb98VRUuexGRNUUpmatwRLYnoRIUAvCyhRw+wFBxrbA4Gps
         3M5A==
X-Gm-Message-State: ACrzQf2daiS1O1SVfEtncEcMeJ+C/76ID0D/Eo1ruzCUhHn6sWgsvxDy
        pgV+k3fMuGrjRXVqbJ/9yG13B09kZJo=
X-Google-Smtp-Source: AMsMyM4dRGxG+pgxnDuSz3Mqe8lZtkiixvkbDurXL0W1X1lQHzRs7gWmWD1II344VjaXjbXFo/quqA==
X-Received: by 2002:a5d:4f05:0:b0:22c:c90e:aae5 with SMTP id c5-20020a5d4f05000000b0022cc90eaae5mr3154935wru.224.1664395933462;
        Wed, 28 Sep 2022 13:12:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020adfd4c6000000b00223b8168b15sm4917278wrk.66.2022.09.28.13.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:12:12 -0700 (PDT)
Message-Id: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
References: <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 20:12:05 +0000
Subject: [PATCH v14 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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

v14 differs from v13:

 * code review feedback

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
 builtin/fsmonitor--daemon.c                |  11 +-
 compat/fsmonitor/fsm-ipc-darwin.c          |  52 ++++++
 compat/fsmonitor/fsm-ipc-win32.c           |   9 ++
 compat/fsmonitor/fsm-listen-darwin.c       |  14 +-
 compat/fsmonitor/fsm-path-utils-darwin.c   | 132 ++++++++++++++++
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
 20 files changed, 580 insertions(+), 246 deletions(-)
 create mode 100644 Documentation/config/fsmonitor--daemon.txt
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: 2a7d63a2453e2c30353342a2c9385fa22a846987
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v14
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v13:

 1:  0b9b64428c5 = 1:  0b9b64428c5 fsmonitor: refactor filesystem checks to common interface
 2:  680d4c83f99 = 2:  680d4c83f99 fsmonitor: relocate socket file if .git directory is remote
 3:  7987d0c1f33 = 3:  7987d0c1f33 fsmonitor: avoid socket location check if using hook
 4:  324eb5acd85 ! 4:  241043b7c15 fsmonitor: deal with synthetic firmlinks on macOS
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       
      +	strbuf_init(&state.alias.alias, 0);
      +	strbuf_init(&state.alias.points_to, 0);
     -+	if (fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)) {
     -+		err = error(_("could not get worktree alias"));
     ++	if ((err = fsmonitor__get_alias(state.path_worktree_watch.buf, &state.alias)))
      +		goto done;
     -+	}
      +
       	/*
       	 * We create and delete cookie files somewhere inside the .git
     @@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char
      +int fsmonitor__get_alias(const char *path, struct alias_info *info)
      +{
      +	DIR *dir;
     -+	int read;
      +	int retval = -1;
     ++	const char *const root = "/";
     ++	struct stat st;
      +	struct dirent *de;
      +	struct strbuf alias;
     -+	struct strbuf points_to;
     ++	struct strbuf points_to = STRBUF_INIT;
      +
     -+	dir = opendir("/");
     -+	if (!dir) {
     -+		error_errno("opendir('/') failed");
     -+		return -1;
     -+	}
     ++	dir = opendir(root);
     ++	if (!dir)
     ++		return error_errno(_("opendir('%s') failed"), root);
      +
      +	strbuf_init(&alias, 256);
      +
     -+	/* no way of knowing what the link will resolve to, so MAXPATHLEN */
     -+	strbuf_init(&points_to, MAXPATHLEN);
     -+
      +	while ((de = readdir(dir)) != NULL) {
      +		strbuf_reset(&alias);
     -+		strbuf_addch(&alias, '/');
     -+		strbuf_add(&alias, de->d_name, strlen(de->d_name));
     ++		strbuf_addf(&alias, "%s%s", root, de->d_name);
      +
     -+		read = readlink(alias.buf, points_to.buf, MAXPATHLEN);
     -+		if (read > 0) {
     -+			strbuf_setlen(&points_to, read);
     -+			if ((!strncmp(points_to.buf, path, points_to.len))
     -+				&& path[points_to.len] == '/') {
     -+				strbuf_addbuf(&info->alias, &alias);
     -+				strbuf_addbuf(&info->points_to, &points_to);
     -+				trace_printf_key(&trace_fsmonitor,
     -+					"Found alias for '%s' : '%s' -> '%s'",
     -+					path, info->alias.buf, info->points_to.buf);
     -+				retval = 0;
     -+				goto done;
     -+			}
     -+		} else if (!read) {
     -+			BUG("readlink returned 0");
     -+		} else if (errno != EINVAL) { /* Something other than not a link */
     -+			error_errno("readlink('%s') failed", alias.buf);
     ++		if (lstat(alias.buf, &st) < 0) {
     ++			error_errno(_("lstat('%s') failed"), alias.buf);
     ++			goto done;
     ++		}
     ++
     ++		if (!S_ISLNK(st.st_mode))
     ++			continue;
     ++
     ++		if (strbuf_readlink(&points_to, alias.buf, st.st_size) < 0) {
     ++			error_errno(_("strbuf_readlink('%s') failed"), alias.buf);
     ++			goto done;
     ++		}
     ++
     ++		if (!strncmp(points_to.buf, path, points_to.len) &&
     ++			(path[points_to.len] == '/')) {
     ++			strbuf_addbuf(&info->alias, &alias);
     ++			strbuf_addbuf(&info->points_to, &points_to);
     ++			trace_printf_key(&trace_fsmonitor,
     ++				"Found alias for '%s' : '%s' -> '%s'",
     ++				path, info->alias.buf, info->points_to.buf);
     ++			retval = 0;
      +			goto done;
      +		}
      +	}
      +	retval = 0; /* no alias */
      +
      +done:
     -+	if (closedir(dir) < 0)
     -+		warning_errno("closedir('/') failed");
      +	strbuf_release(&alias);
      +	strbuf_release(&points_to);
     ++	if (closedir(dir) < 0)
     ++		return error_errno(_("closedir('%s') failed"), root);
      +	return retval;
      +}
      +
 5:  b1ea378dff7 = 5:  d906debba5e fsmonitor: check for compatability before communicating with fsmonitor
 6:  04f607b1f21 = 6:  ed14fbd009e fsmonitor: add documentation for allowRemote and socketDir options

-- 
gitgitgadget
