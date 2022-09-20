Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6260C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiITUdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiITUdL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:33:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10566386B0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:33:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x18so440415wrm.7
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=7np2k+40fvvzLOuMBeIzSnvgFiwHQJd3FCbcG1IZLRM=;
        b=cqcaHJ54GRllE/yC4jFuuWYwmBuwfUjeS2Kc0fLI+PQ8bmstek5549lXQtCqOlScPl
         BYG3drADVQKFNi5ErlNvpGv9mxpeAwtxyjzyVUV+BvHGzQHU0CdDa9yOtsbDHiOB/pMv
         79w+4Yh6+5H2t0ry8xx3YHUb/7BAtNulzUNtJ8X4CUes4PgoYu+AL6u95qkGkWiTzX7H
         m84Z4G9ecS/r2EScrJk5jTaxi9WxNH4x1hGhZ8lnAog4FG2HMEU3LCvSAW6A0lNApmMk
         BfpOtwxN9/fBk+RFkCWZJP7XBS7gKN+IuVzmg2EUw9JA4xobnD8WJiEOosXMwIicJbq7
         8Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7np2k+40fvvzLOuMBeIzSnvgFiwHQJd3FCbcG1IZLRM=;
        b=4gbhoYflxNHtkJnZ8k99rNYUZW5dCPgHk833WQp9wBW+iTzc6Hh4LJyzY0lrVIj77U
         Q2gGedlRSet4UwV2qoaFxQ5LOImANnkhPxOKehzr/JH6pUU7lebtx1tGNfeldKemfeXB
         6wvhaVUx0s86rfZJ3w80K9GU26XkA8FNraRchH8iBQJTFsJZP9NkhzblcuDITtPjPUfF
         AZUF/z0H1uux0yxAcFBWxEJISzLcDbSR5cJxw2c42OoV+MsTAzuY8p93W019oxEbbYbT
         p3Cqk3u6g0Un7oGP6THcMm6yUKhB808aARKk00c1+6NntF91ryWrD3INqeDiQPAf88cS
         rO3g==
X-Gm-Message-State: ACrzQf3QEjvy+tFOVwlajhVfMVL1K1QEf+QqT3Ipv+QcL6qz6kfEipdp
        /tRPE7Y7kPPPKc5U99dqxrmopPx6KKk=
X-Google-Smtp-Source: AMsMyM7IuZvNS9HblMNfVVOGG7FGK6OAnLR/Z5yeYn4oZ9oSb53OIMlQmBFG/0iImq2+QyLb+wAHLQ==
X-Received: by 2002:adf:f00b:0:b0:22a:906d:358d with SMTP id j11-20020adff00b000000b0022a906d358dmr15389920wro.464.1663705988182;
        Tue, 20 Sep 2022 13:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d4b84000000b0022b11a27e39sm773999wrt.1.2022.09.20.13.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:33:07 -0700 (PDT)
Message-Id: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
References: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 20:33:00 +0000
Subject: [PATCH v10 0/6] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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
 compat/fsmonitor/fsm-listen-darwin.c     |   6 +-
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
 18 files changed, 569 insertions(+), 245 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v9:

 1:  155a6890806 = 1:  155a6890806 fsmonitor: refactor filesystem checks to common interface
 2:  68709d788d5 ! 2:  dbe113abb87 fsmonitor: relocate socket file if .git directory is remote
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +{
      +	static const char *ipc_path;
      +	SHA_CTX sha1ctx;
     -+	char *sock_dir;
     ++	char *sock_dir = NULL;
      +	struct strbuf ipc_file = STRBUF_INIT;
      +	unsigned char hash[SHA_DIGEST_LENGTH];
      +
     ++	if (!r)
     ++		BUG("No repository passed into fsmonitor_ipc__get_path");
     ++
      +	if (ipc_path)
      +		return ipc_path;
      +
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +	if (sock_dir && *sock_dir) {
      +		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
      +					sock_dir, hash_to_hex(hash));
     -+		free(sock_dir);
      +	} else {
      +		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
      +	}
     ++	free(sock_dir);
      +
      +	ipc_path = interpolate_path(ipc_file.buf, 1);
      +	if (!ipc_path)
     @@ compat/fsmonitor/fsm-ipc-win32.c (new)
      +		ret = git_pathdup("fsmonitor--daemon.ipc");
      +	return ret;
      +}
     - \ No newline at end of file
      
       ## compat/fsmonitor/fsm-settings-darwin.c ##
      @@
 3:  6ddd922917a = 3:  86c15299ae8 fsmonitor: avoid socket location check if using hook
 4:  73afd9f3122 = 4:  4f6c98cf834 fsmonitor: deal with synthetic firmlinks on macOS
 5:  02afeaa01be ! 5:  8f6c1fbacbf fsmonitor: check for compatability before communicating with fsmonitor
     @@ Commit message
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
     + ## compat/fsmonitor/fsm-settings-darwin.c ##
     +@@ compat/fsmonitor/fsm-settings-darwin.c: static enum fsmonitor_reason check_uds_volume(struct repository *r)
     + 	strbuf_release(&path);
     + 
     + 	if (fs.is_remote)
     +-		return FSMONITOR_REASON_REMOTE;
     ++		return FSMONITOR_REASON_NOSOCKETS;
     + 
     + 	if (!strcmp(fs.typename, "msdos")) /* aka FAT32 */
     + 		return FSMONITOR_REASON_NOSOCKETS;
     +
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repository *r,
     +@@
     + #include "cache.h"
     + #include "config.h"
     + #include "repository.h"
     ++#include "fsmonitor-ipc.h"
     + #include "fsmonitor-settings.h"
     + #include "fsmonitor-path-utils.h"
     + 
     +@@ fsmonitor-settings.c: enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
     + 	return r->settings.fsmonitor->reason;
     + }
     + 
     +-char *fsm_settings__get_incompatible_msg(const struct repository *r,
     ++char *fsm_settings__get_incompatible_msg(struct repository *r,
     + 					 enum fsmonitor_reason reason)
       {
       	struct strbuf msg = STRBUF_INIT;
     ++	const char *socket_dir;
       
     -+	strbuf_add(&msg, "fsmonitor: ", strlen("fsmonitor: "));
     -+
       	switch (reason) {
       	case FSMONITOR_REASON_UNTESTED:
     - 	case FSMONITOR_REASON_OK:
     +@@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repository *r,
     + 		goto done;
     + 
     + 	case FSMONITOR_REASON_NOSOCKETS:
     ++		socket_dir = dirname((char *)fsmonitor_ipc__get_path(r));
     + 		strbuf_addf(&msg,
     +-			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
     +-			    r->worktree);
     ++			    _("socket directory '%s' is incompatible with fsmonitor due"),
     ++			    socket_dir);
     ++		strbuf_add(&msg, _(" to lack of Unix sockets support"), 32);
     + 		goto done;
     + 	}
     + 
     +
     + ## fsmonitor-settings.h ##
     +@@ fsmonitor-settings.h: enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
     + const char *fsm_settings__get_hook_path(struct repository *r);
     + 
     + enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
     +-char *fsm_settings__get_incompatible_msg(const struct repository *r,
     ++char *fsm_settings__get_incompatible_msg(struct repository *r,
     + 					 enum fsmonitor_reason reason);
     + 
     + struct fsmonitor_settings;
      
       ## fsmonitor.c ##
      @@ fsmonitor.c: void refresh_fsmonitor(struct index_state *istate)
 6:  0e8ea28acc1 = 6:  d7c25bf96c6 fsmonitor: add documentation for allowRemote and socketDir options

-- 
gitgitgadget
