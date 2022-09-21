Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7498EC32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIUWSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiIUWSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:18:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E1A7A92
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g3so12407983wrq.13
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=5WgwkH/8MXhU/EJepM5XMyxb/g0PvIq6IvNxrjtP6iU=;
        b=nNu51+ksj0wlNMTrgoNT8XvKAocswAQqVa+Wm5lIr2Qzhq71DpI76bMnz4rBMpENbS
         39HkvfhKOj5MlnFPxT62AEqs8CehNZy5YNiL9XfEwM5APivPmlN9v4kc5mdJ9rWqu5AJ
         7E/97l5SKDzGlT8Uew4i9TcONk5XQ9oO2Sj/B6jnFPY3M/UywkDHBlDxocQKA79PiUBL
         rhxuqx9LMDISHtl5sD3EBa2j0cqvuViRmktbY7Wb43RCcfRp8W+AAs9DCkCaADXu8Y7c
         JdGnJrXf2BXFdKklGiP9yQ35eKDuWKWKaPnvNMlnJnSiNwQUbQi5t8eJQ9VaQ7+MheZ/
         fZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5WgwkH/8MXhU/EJepM5XMyxb/g0PvIq6IvNxrjtP6iU=;
        b=RdHg3rQZYj12Pm2LtO4flFFs5GS1vgS/yoa1CZuFQ3Zb8qlfJ/KFG0KFoF/KysotEx
         yWHtAXpL1q8/Zjn2HlYPslyYr9TLBrNZXeoDQaNuO2bJcHCDh9brBAagtGX91m6gvYKb
         syrcZF9NNootYmZgKdYspOCRKmzrlU190OOAVp/ss9SHZ5Ek/V6i9GqIrlSLqA0fLgn3
         XFuBPPHNEF0pROgw6lNINotsPMPAc5KVA5leNiDUbG5fn0LohOX5KaRp+qqsroprTVCQ
         upQxyrbqK1awkQYzWcRUAvGjVV8lIgXqfwDdcIH3jYk8P+XDQc7tValn2A8J1Ja7RlOG
         XPcg==
X-Gm-Message-State: ACrzQf3cZjO2ZBMEbxJB7HTBmg7cflup+ND5laytQpL4u9n7CbIjlr+t
        rbD58pCGhh9o76TqwYQX4g4MHqAPxNA=
X-Google-Smtp-Source: AMsMyM5tRqIfKyIdWe4pxmZEB1OyeWBnz+vy2FrYZIc6TcmU06Ux36DNBHVxMaLZzTN/CoZle1/MRg==
X-Received: by 2002:adf:db44:0:b0:22a:d315:d6a9 with SMTP id f4-20020adfdb44000000b0022ad315d6a9mr177635wrj.358.1663798724160;
        Wed, 21 Sep 2022 15:18:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003b492338f45sm3722529wmk.39.2022.09.21.15.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:18:43 -0700 (PDT)
Message-Id: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
References: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 22:18:36 +0000
Subject: [PATCH v11 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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

 Documentation/git-fsmonitor--daemon.txt  |  48 ++++++-
 Makefile                                 |   2 +
 builtin/fsmonitor--daemon.c              |  11 +-
 compat/fsmonitor/fsm-ipc-darwin.c        |  51 +++++++
 compat/fsmonitor/fsm-ipc-win32.c         |   9 ++
 compat/fsmonitor/fsm-listen-darwin.c     |  14 +-
 compat/fsmonitor/fsm-path-utils-darwin.c | 132 +++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 145 +++++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c   |  72 +++-------
 compat/fsmonitor/fsm-settings-win32.c    | 174 +----------------------
 contrib/buildsystems/CMakeLists.txt      |   4 +
 fsmonitor--daemon.h                      |   3 +
 fsmonitor-ipc.c                          |  18 ++-
 fsmonitor-ipc.h                          |   4 +-
 fsmonitor-path-utils.h                   |  59 ++++++++
 fsmonitor-settings.c                     |  68 ++++++++-
 fsmonitor-settings.h                     |   4 +-
 fsmonitor.c                              |   4 +
 18 files changed, 576 insertions(+), 246 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v11
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v10:

 1:  155a6890806 = 1:  155a6890806 fsmonitor: refactor filesystem checks to common interface
 2:  dbe113abb87 = 2:  dbe113abb87 fsmonitor: relocate socket file if .git directory is remote
 3:  86c15299ae8 = 3:  86c15299ae8 fsmonitor: avoid socket location check if using hook
 4:  4f6c98cf834 ! 4:  1a516fd9214 fsmonitor: deal with synthetic firmlinks on macOS
     @@ compat/fsmonitor/fsm-listen-darwin.c
       
       struct fsm_listen_data
       {
     +@@ compat/fsmonitor/fsm-listen-darwin.c: static void fsevent_callback(ConstFSEventStreamRef streamRef,
     + 	struct string_list cookie_list = STRING_LIST_INIT_DUP;
     + 	const char *path_k;
     + 	const char *slash;
     +-	int k;
     ++	char *resolved = NULL;
     + 	struct strbuf tmp = STRBUF_INIT;
     ++	int k;
     + 
     + 	/*
     + 	 * Build a list of all filesystem changes into a private/local
      @@ compat/fsmonitor/fsm-listen-darwin.c: static void fsevent_callback(ConstFSEventStreamRef streamRef,
       		/*
       		 * On Mac, we receive an array of absolute paths.
       		 */
      -		path_k = paths[k];
     -+		path_k = fsmonitor__resolve_alias(paths[k], &state->alias);
     -+		if (!path_k)
     ++		free(resolved);
     ++		resolved = fsmonitor__resolve_alias(paths[k], &state->alias);
     ++		if (resolved)
     ++			path_k = resolved;
     ++		else
      +			path_k = paths[k];
       
       		/*
     @@ compat/fsmonitor/fsm-listen-darwin.c: static void fsevent_callback(ConstFSEventS
       
       			/*
       			 * We assume that any events that we received
     +@@ compat/fsmonitor/fsm-listen-darwin.c: static void fsevent_callback(ConstFSEventStreamRef streamRef,
     + 		}
     + 	}
     + 
     ++	free(resolved);
     + 	fsmonitor_publish(state, batch, &cookie_list);
     + 	string_list_clear(&cookie_list, 0);
     + 	strbuf_release(&tmp);
     + 	return;
     + 
     + force_shutdown:
     ++	free(resolved);
     + 	fsmonitor_batch__free_list(batch);
     + 	string_list_clear(&cookie_list, 0);
     + 
      
       ## compat/fsmonitor/fsm-path-utils-darwin.c ##
      @@
 5:  8f6c1fbacbf ! 5:  e0fe05dabef fsmonitor: check for compatability before communicating with fsmonitor
     @@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repo
       		strbuf_addf(&msg,
      -			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
      -			    r->worktree);
     -+			    _("socket directory '%s' is incompatible with fsmonitor due"),
     ++			    _("socket directory '%s' is incompatible with fsmonitor due"
     ++				  " to lack of Unix sockets support"),
      +			    socket_dir);
     -+		strbuf_add(&msg, _(" to lack of Unix sockets support"), 32);
       		goto done;
       	}
       
     @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
      +	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
      +
      +	if (reason > FSMONITOR_REASON_OK)
     -+		die("%s", fsm_settings__get_incompatible_msg(r, reason));
     ++		warning("%s", fsm_settings__get_incompatible_msg(r, reason));
       
       	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
       	    istate->fsmonitor_has_run_once)
 6:  d7c25bf96c6 = 6:  3200b505988 fsmonitor: add documentation for allowRemote and socketDir options

-- 
gitgitgadget
