Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4151C32771
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 19:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiIXTqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 15:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiIXTq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 15:46:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B204661D
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:46:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so4666726wrx.9
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=8mm3Ugi/AcDTBojYuWWaO9QmrcqWENqRs39NahC2Z2M=;
        b=V554as/k9fk633JvSi7cVdZrDOFXKo9Y+uauy+WetidWwT3Z3zGlMGIW0/VNF+rZHi
         2M6LAFv2R3S+7v9hUUf9IPWcixpSYJNjnpoYbJP+VCzrJGOiViFHdKHW6PFXOduIXoSL
         9zU/Psp0Z5xc0CAFlufXiRF/JCqYq08hK1/Ehu/79Pz5QtDVjVzT8WcRsDKBqdBzTkRp
         u8gWwZt+zIKK7uh1SZaQIiA+gjYeYpgJcXEALVb3aqJXXsI4E6fmj78rtyolWzMR7Ih6
         hJzUXP2gEKBwtdfUfsD4Ul/56vQpchjL2DcSrKgLCyNR59mu7tzTDtZg+/fHHfT1OS35
         ku8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8mm3Ugi/AcDTBojYuWWaO9QmrcqWENqRs39NahC2Z2M=;
        b=XiQvjP2NawjyX2VrRK6lehYGSC89dv15zUtPbrOFo2DdHs+WP/KDxOeX3yT/VQfL6G
         sGJl6iGUGhvIAyubSkv0rGemvS7JxTark6/SbSz6/sTsLwKHQKj82Fha+tDLMzPF0HF3
         D6B29aWsHcEunK6ArZE23ZKn1u2AfqY75Z0n7bQQqHR+SXeu54WHeIGs9s2G9R2vbOCG
         NX4FGftP0pVWaUwNpM/YQlIRRu23STbN/h5XsB2gn7QKE753+8idfW/kQa3OMSLNrotQ
         coa8SFFk5H9xu7q/qyfvkAtQcOTg6BQdBKnNyCQzHyqPp7BPhwfST+E0WCWJ4Uz7RCGt
         wCwA==
X-Gm-Message-State: ACrzQf3RFlmhmaxCaqnG3gd25fzhx1THYtcwofWIhU1l+lMMduWWkXNf
        frwkHPUgMDjBMtIz5BYEPCULt5Jomcs=
X-Google-Smtp-Source: AMsMyM4WvR2tq4SGp0wzKuH7QWfUiCOKwXVitdV5JMOJi+IdRHo10RWmmbsxFEtLFbM2i75Fk6iSgw==
X-Received: by 2002:a05:6000:1ac9:b0:22a:cc07:9cfe with SMTP id i9-20020a0560001ac900b0022acc079cfemr8789269wry.186.1664048784922;
        Sat, 24 Sep 2022 12:46:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c434100b003b3401f1e24sm5750200wme.28.2022.09.24.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 12:46:23 -0700 (PDT)
Message-Id: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Sep 2022 19:46:16 +0000
Subject: [PATCH v12 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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

 Documentation/git-fsmonitor--daemon.txt  |  48 ++++++-
 Makefile                                 |   2 +
 builtin/fsmonitor--daemon.c              |  11 +-
 compat/fsmonitor/fsm-ipc-darwin.c        |  52 +++++++
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
 fsmonitor.c                              |   7 +
 18 files changed, 580 insertions(+), 246 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: 4b79ee4b0cd1130ba8907029cdc5f6a1632aca26
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v12
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v11:

 1:  155a6890806 = 1:  5958dab0163 fsmonitor: refactor filesystem checks to common interface
 2:  dbe113abb87 ! 2:  20220b08edb fsmonitor: relocate socket file if .git directory is remote
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +
      +const char *fsmonitor_ipc__get_path(struct repository *r)
      +{
     -+	static const char *ipc_path;
     ++	static const char *ipc_path = NULL;
      +	SHA_CTX sha1ctx;
      +	char *sock_dir = NULL;
      +	struct strbuf ipc_file = STRBUF_INIT;
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +	if (ipc_path)
      +		return ipc_path;
      +
     -+	ipc_path = fsmonitor_ipc__get_default_path();
      +
      +	/* By default the socket file is created in the .git directory */
     -+	if (fsmonitor__is_fs_remote(ipc_path) < 1)
     ++	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
     ++		ipc_path = fsmonitor_ipc__get_default_path();
      +		return ipc_path;
     ++	}
      +
      +	SHA1_Init(&sha1ctx);
      +	SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
 3:  86c15299ae8 = 3:  e9921550a67 fsmonitor: avoid socket location check if using hook
 4:  1a516fd9214 = 4:  6efdc6ed74e fsmonitor: deal with synthetic firmlinks on macOS
 5:  e0fe05dabef ! 5:  421d77775dc fsmonitor: check for compatability before communicating with fsmonitor
     @@ fsmonitor-settings.h: enum fsmonitor_mode fsm_settings__get_mode(struct reposito
       struct fsmonitor_settings;
      
       ## fsmonitor.c ##
     +@@ fsmonitor.c: static int fsmonitor_force_update_threshold = 100;
     + 
     + void refresh_fsmonitor(struct index_state *istate)
     + {
     ++	static int warn_once = 0;
     + 	struct strbuf query_result = STRBUF_INIT;
     + 	int query_success = 0, hook_version = -1;
     + 	size_t bol = 0; /* beginning of line */
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
       	int is_trivial = 0;
       	struct repository *r = istate->repo ? istate->repo : the_repository;
       	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
      +	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
      +
     -+	if (reason > FSMONITOR_REASON_OK)
     ++	if (!warn_once && reason > FSMONITOR_REASON_OK) {
     ++		warn_once = 1;
      +		warning("%s", fsm_settings__get_incompatible_msg(r, reason));
     ++	}
       
       	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
       	    istate->fsmonitor_has_run_once)
 6:  3200b505988 = 6:  b375b0ac798 fsmonitor: add documentation for allowRemote and socketDir options

-- 
gitgitgadget
