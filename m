Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC4C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 17:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJDRcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJDRcg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 13:32:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1985410A8
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 10:32:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b7so14789519wrq.9
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=M9bx46j6CfOTcfvc5kc0QcTprR089i+TADJNvEQi9nQ=;
        b=VDrCdL5sRTw2nn5qYQhMFF4Hise3D5lZG4WFryADYajQTJC/iWvZA+0fa94hd+L0Hc
         lGYGDcVfjauGe1Uly+rA96TWQChCtSL88zVaHerWKaaS1N3bGvjemXtCkudos0qtUtMM
         iSyhHHitVIaPoCo1eviFmeJc7vw16udgtedqhRk0H3sh4fTarTk5Jj/PNfFepMdCTHgS
         oZ7iEnf1aJCe1/pUbP8478H+vgkG6GK7iJx6qCCJpEYN+CYqfbovMyXszhefjG3ccFEc
         IFp+DPcj4pndunrxMPz8CkDiuACWLLTnVPAruQLP4EOR46BQNQrTJfz5pwQHvIUl6myB
         Rn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M9bx46j6CfOTcfvc5kc0QcTprR089i+TADJNvEQi9nQ=;
        b=tnVGaD5LXVa2fGVwDY6M2l7hhMWcgpOAC9933fPGLmBE8/Iuxh8k/7aqdwvc9oLd0+
         wwLdLX/6xtw72OGtcp0sArIU74U/Y0ygkXqIwSV3/DwOpZURSWiRtt4XC7sWqtVZilkd
         Km26j0tsAJmoasOhu2GqUGJpnzpGn22v7TE/47/UfV3nBagC/ZpE1GEgHW56lwDYU627
         TEKVeMgQShgjXY7BXlZh2hJ/3sBbQQ9bNuMMflLZkyATVs5lq2cMOB5Vlv7t9WA1RuhJ
         SHka5SQnh3PzB5/nvySMYq5wtTxFHKt6tJmEmQIcI3h4BF1RNFHx5otBSKmGZ+SLprCq
         vEaQ==
X-Gm-Message-State: ACrzQf3DJffhycAw4Kkr+uHAu3SX/NhYIG1nxVLlU2XHlOeTjq25AygK
        vOdTv6/cyaSXKL0lkbLd5q45yMqqXXQ=
X-Google-Smtp-Source: AMsMyM7V2OPoUmM78g5g5+UkB3h+Gkd4gqS1LuVCX/tbupLpguXkt5C2Nea9o4QbYwRvSEg827DZIw==
X-Received: by 2002:a5d:4f8b:0:b0:22e:40fc:bd1b with SMTP id d11-20020a5d4f8b000000b0022e40fcbd1bmr5827450wru.717.1664904753301;
        Tue, 04 Oct 2022 10:32:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c2cd200b003a63a3b55c3sm21513598wmc.14.2022.10.04.10.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:32:32 -0700 (PDT)
Message-Id: <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 17:32:25 +0000
Subject: [PATCH v15 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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

v15 differs from v14:

 * fix memory leak

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
 compat/fsmonitor/fsm-path-utils-darwin.c   | 135 ++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c    | 145 +++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c     |  77 +++------
 compat/fsmonitor/fsm-settings-win32.c      | 174 +--------------------
 contrib/buildsystems/CMakeLists.txt        |   4 +
 fsmonitor--daemon.h                        |   3 +
 fsmonitor-ipc.c                            |  18 +--
 fsmonitor-ipc.h                            |   4 +-
 fsmonitor-path-utils.h                     |  60 +++++++
 fsmonitor-settings.c                       |  68 +++++++-
 fsmonitor-settings.h                       |   4 +-
 fsmonitor.c                                |   7 +
 20 files changed, 588 insertions(+), 249 deletions(-)
 create mode 100644 Documentation/config/fsmonitor--daemon.txt
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v15
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v14:

 1:  0b9b64428c5 ! 1:  ec49a74086d fsmonitor: refactor filesystem checks to common interface
     @@ compat/fsmonitor/fsm-path-utils-darwin.c (new)
      +	else
      +		fs_info->is_remote = 0;
      +
     -+	fs_info->typename = fs.f_fstypename;
     ++	fs_info->typename = xstrdup(fs.f_fstypename);
      +
      +	trace_printf_key(&trace_fsmonitor,
      +				"'%s' is_remote: %d",
     @@ compat/fsmonitor/fsm-path-utils-darwin.c (new)
      +	struct fs_info fs;
      +	if (fsmonitor__get_fs_info(path, &fs))
      +		return -1;
     ++
     ++	free(fs.typename);
     ++
      +	return fs.is_remote;
      +}
      
     @@ compat/fsmonitor/fsm-settings-darwin.c
      -	trace_printf_key(&trace_fsmonitor,
      -			 "statfs('%s') [type 0x%08x][flags 0x%08x] '%s'",
      -			 r->worktree, fs.f_type, fs.f_flags, fs.f_fstypename);
     -+	strbuf_release(&path);
     - 
     +-
      -	if (!(fs.f_flags & MNT_LOCAL))
     -+	if (fs.is_remote)
     - 		return FSMONITOR_REASON_REMOTE;
     +-		return FSMONITOR_REASON_REMOTE;
     ++	strbuf_release(&path);
       
      -	if (!strcmp(fs.f_fstypename, "msdos")) /* aka FAT32 */
     -+	if (!strcmp(fs.typename, "msdos")) /* aka FAT32 */
     - 		return FSMONITOR_REASON_NOSOCKETS;
     - 
     +-		return FSMONITOR_REASON_NOSOCKETS;
     +-
      -	if (!strcmp(fs.f_fstypename, "ntfs"))
     -+	if (!strcmp(fs.typename, "ntfs"))
     ++	if (fs.is_remote ||
     ++		!strcmp(fs.typename, "msdos") ||
     ++		!strcmp(fs.typename, "ntfs")) {
     ++		free(fs.typename);
       		return FSMONITOR_REASON_NOSOCKETS;
     ++	}
       
     ++	free(fs.typename);
       	return FSMONITOR_REASON_OK;
     + }
     + 
      @@ compat/fsmonitor/fsm-settings-darwin.c: enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
       {
       	enum fsmonitor_reason reason;
     @@ fsmonitor-path-utils.h (new)
      +/*
      + * Get some basic filesystem informtion for the given path
      + *
     ++ * The caller owns the storage that is occupied by fs_info and
     ++ * is responsible for releasing it.
     ++ *
      + * Returns -1 on error, zero otherwise.
      + */
      +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info);
 2:  680d4c83f99 = 2:  7bf1cdfe3b2 fsmonitor: relocate socket file if .git directory is remote
 3:  7987d0c1f33 = 3:  c5e8b6cfe5d fsmonitor: avoid socket location check if using hook
 4:  241043b7c15 ! 4:  863063aefee fsmonitor: deal with synthetic firmlinks on macOS
     @@ compat/fsmonitor/fsm-path-utils-darwin.c
       #include <sys/mount.h>
       
      @@ compat/fsmonitor/fsm-path-utils-darwin.c: int fsmonitor__is_fs_remote(const char *path)
     - 		return -1;
     + 
       	return fs.is_remote;
       }
      +
     @@ fsmonitor-path-utils.h
      - * Get some basic filesystem informtion for the given path
      + * Get some basic filesystem information for the given path
        *
     -  * Returns -1 on error, zero otherwise.
     -  */
     +  * The caller owns the storage that is occupied by fs_info and
     +  * is responsible for releasing it.
      @@ fsmonitor-path-utils.h: int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info);
        */
       int fsmonitor__is_fs_remote(const char *path);
 5:  d906debba5e ! 5:  fa974bfd5ef fsmonitor: check for compatability before communicating with fsmonitor
     @@ Commit message
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
     - ## compat/fsmonitor/fsm-settings-darwin.c ##
     -@@ compat/fsmonitor/fsm-settings-darwin.c: static enum fsmonitor_reason check_uds_volume(struct repository *r)
     - 	strbuf_release(&path);
     - 
     - 	if (fs.is_remote)
     --		return FSMONITOR_REASON_REMOTE;
     -+		return FSMONITOR_REASON_NOSOCKETS;
     - 
     - 	if (!strcmp(fs.typename, "msdos")) /* aka FAT32 */
     - 		return FSMONITOR_REASON_NOSOCKETS;
     -
       ## fsmonitor-settings.c ##
      @@
       #include "cache.h"
 6:  ed14fbd009e = 6:  af7309745f7 fsmonitor: add documentation for allowRemote and socketDir options

-- 
gitgitgadget
