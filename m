Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48190C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE4B6120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJUO1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUO12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD221C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so1156678wro.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=okpTBUwww5ZI2hT66PrQkk2GzEGEyquEamrg67XKNNY=;
        b=deOkhP4xK4IY9QqAKXAsr3IZIL6ZPMqJC8C5Tu5RnIDc7LpNFiyiK0jl5yMW3ts7kY
         pAD32TrBedyHJylxlcJZb51X1eDQDXsoLc9BLDccEtTKZ75eF9KFabY3R8CuAgspDOVC
         orfsWYBLHXXzGP3udCF603ANrp+Z6pLT73s3szbq8EASBSddHJVEYImAxsmrq5cGQGv+
         pMOEjbDo+9a6TY/D5DOLQ1Qiyblor99T67qTt97f73WItvnj0AoYlPQcynMf73Bb64xp
         TOPNqagwwAE6SOUKLv25OZ4betMoh9YCwNBFcHIWVyUKoAZ/1Wg75IEs8YwkA+u+JVkG
         G7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=okpTBUwww5ZI2hT66PrQkk2GzEGEyquEamrg67XKNNY=;
        b=elFgbhKHP+SN1SdIg0Jwubl+zMcUQTv7NpGnH2ihegy0/Di9UWnh2owZcy/gBGPxP1
         N8QJ6oX4WkW1FzWUCIV94j5pWyzmrWrWvtgHR4GcLIxGeLttWNNC7qg3+5cid/wwZrb2
         af5otAjlEq9RE9UOo4jliKDoq/HhBNKor3IXFpvepeEJE1Coyi0VWbApeJFK5HtDcXgm
         AkIzeInVUSStjANnTZNCIYXZyYDIejY/ZBV56jIpmKI1ZWa/ZdA2N/ACC/Ysi7kl0KJe
         dbXqH3GVv0bkfTCKhY6slx2Z21wBnwepLpeTgRHxpWH/aKnAf6jPPOMpX5VEd4FsO7ub
         kDiA==
X-Gm-Message-State: AOAM531SV7PuHw/enI2741jzOH+dViGilHH3GvPqSiYtqu7p5lWEm2ZJ
        8O+cQKxyBoAPbSKIg7ysiap5NI3XMfg=
X-Google-Smtp-Source: ABdhPJyjpM9wGCSes3UvxUDzsbaO9jadnvF048koAU108S5loUkX8TZ0A3sAVDKbvx9aUWRCF1/ysQ==
X-Received: by 2002:a5d:6c69:: with SMTP id r9mr7686931wrz.280.1634826311280;
        Thu, 21 Oct 2021 07:25:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17sm5580152wru.18.2021.10.21.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:10 -0700 (PDT)
Message-Id: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:24:40 +0000
Subject: [PATCH v4 00/29] Builtin FSMonitor Part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V4 of Part 2 of my Builtin FSMonitor series. I have rebased it onto
the current "master" branch to address conflicts and errors with recent
changes already in master.

In response to comments on V3, I have pulled in more commits from complete
series. Part 2 now includes both the client-side code to talk to via a
daemon via IPC and an MVP implementation of the fsmonitor--daemon itself.

This version of the daemon is functional and can be tested using t/t7527 and
t/perf/p7519.

A followup Part 3 will contain additional refinements to the daemon and
additional tests. I drew the line here between Part 2 and 3 to make it
easier to review.

cc: Bagas Sanjaya bagasdotme@gmail.com cc: Ævar Arnfjörð Bjarmason
avarab@gmail.com cc: Jeff Hostetler git@jeffhostetler.com

Jeff Hostetler (29):
  fsmonitor: enhance existing comments
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  fsmonitor: config settings are repository-specific
  fsmonitor: use IPC to query the builtin FSMonitor daemon
  fsmonitor: document builtin fsmonitor
  fsmonitor--daemon: add a built-in fsmonitor daemon
  fsmonitor--daemon: implement 'stop' and 'status' commands
  compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
  compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
  fsmonitor--daemon: implement 'run' command
  fsmonitor--daemon: implement 'start' command
  fsmonitor--daemon: add pathname classification
  fsmonitor--daemon: define token-ids
  fsmonitor--daemon: create token-based changed path cache
  compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on
    Windows
  compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
  compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on
    MacOS
  fsmonitor--daemon: implement handle_client callback
  help: include fsmonitor--daemon feature flag in version info
  t/helper/fsmonitor-client: create IPC client to talk to FSMonitor
    Daemon
  t7527: create test for fsmonitor--daemon
  t/perf: avoid copying builtin fsmonitor files into test repo
  t/helper/test-chmtime: skip directories on Windows
  t/perf/p7519: speed up test on Windows
  t/perf/p7519: add fsmonitor--daemon test cases
  fsmonitor--daemon: periodically truncate list of modified files
  fsmonitor--daemon: use a cookie file to sync with file system
  fsmonitor: force update index after large responses
  t7527: test status with untracked-cache and fsmonitor--daemon

 .gitignore                              |    1 +
 Documentation/config/core.txt           |   56 +-
 Documentation/git-fsmonitor--daemon.txt |   75 ++
 Documentation/git-update-index.txt      |   27 +-
 Documentation/githooks.txt              |    3 +-
 Makefile                                |   17 +
 builtin.h                               |    1 +
 builtin/fsmonitor--daemon.c             | 1454 +++++++++++++++++++++++
 builtin/update-index.c                  |   19 +-
 cache.h                                 |    1 -
 compat/fsmonitor/fsm-listen-darwin.c    |  496 ++++++++
 compat/fsmonitor/fsm-listen-win32.c     |  586 +++++++++
 compat/fsmonitor/fsm-listen.h           |   49 +
 config.c                                |   14 -
 config.h                                |    1 -
 config.mak.uname                        |   20 +
 contrib/buildsystems/CMakeLists.txt     |   10 +
 environment.c                           |    1 -
 fsmonitor--daemon.h                     |  140 +++
 fsmonitor-ipc.c                         |  176 +++
 fsmonitor-ipc.h                         |   48 +
 fsmonitor-settings.c                    |   97 ++
 fsmonitor-settings.h                    |   21 +
 fsmonitor.c                             |  187 ++-
 fsmonitor.h                             |   18 +-
 git.c                                   |    1 +
 help.c                                  |    4 +
 repo-settings.c                         |    1 +
 repository.h                            |    3 +
 t/README                                |    4 +-
 t/helper/test-chmtime.c                 |   15 +
 t/helper/test-fsmonitor-client.c        |  121 ++
 t/helper/test-tool.c                    |    1 +
 t/helper/test-tool.h                    |    1 +
 t/perf/p7519-fsmonitor.sh               |   61 +-
 t/perf/perf-lib.sh                      |    2 +-
 t/t7527-builtin-fsmonitor.sh            |  607 ++++++++++
 t/test-lib.sh                           |    6 +
 38 files changed, 4247 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt
 create mode 100644 builtin/fsmonitor--daemon.c
 create mode 100644 compat/fsmonitor/fsm-listen-darwin.c
 create mode 100644 compat/fsmonitor/fsm-listen-win32.c
 create mode 100644 compat/fsmonitor/fsm-listen.h
 create mode 100644 fsmonitor--daemon.h
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h
 create mode 100644 t/helper/test-fsmonitor-client.c
 create mode 100755 t/t7527-builtin-fsmonitor.sh


base-commit: 9d530dc0024503ab4218fe6c4395b8a0aa245478
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1041/jeffhostetler/builtin-fsmonitor-part2-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1041

Range-diff vs v3:

  1:  cb25eeaf72d =  1:  ecc40795fa2 fsmonitor: enhance existing comments
  2:  df81a63acee =  2:  82f17692128 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  3:  a1d606aa622 =  3:  882789b4dfe fsmonitor: config settings are repository-specific
  4:  4d8d812be08 =  4:  de82c726182 fsmonitor: use IPC to query the builtin FSMonitor daemon
  5:  45a86cef8d7 !  5:  d365704d551 fsmonitor: update fsmonitor config documentation
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor: update fsmonitor config documentation
     +    fsmonitor: document builtin fsmonitor
     +
     +    Document the new `core.useBuiltinFSMonitor` config value.
      
          Update references to `core.fsmonitor` and `core.fsmonitorHookVersion` and
     -    pointers to `Watchman` to mention the new `core.useBuiltinFSMonitor`
     -    value.
     +    pointers to `Watchman` to refer to it.
     +
     +    Create `git-fsmonitor--daemon` manual page and describe its features.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ Documentation/config/core.txt: core.protectNTFS::
       core.trustctime::
       	If false, the ctime differences between the index and the
      
     + ## Documentation/git-fsmonitor--daemon.txt (new) ##
     +@@
     ++git-fsmonitor--daemon(1)
     ++========================
     ++
     ++NAME
     ++----
     ++git-fsmonitor--daemon - A Built-in File System Monitor
     ++
     ++SYNOPSIS
     ++--------
     ++[verse]
     ++'git fsmonitor--daemon' start
     ++'git fsmonitor--daemon' run
     ++'git fsmonitor--daemon' stop
     ++'git fsmonitor--daemon' status
     ++
     ++DESCRIPTION
     ++-----------
     ++
     ++A daemon to watch the working directory for file and directory
     ++changes using platform-specific file system notification facilities.
     ++
     ++This daemon communicates directly with commands like `git status`
     ++using the link:technical/api-simple-ipc.html[simple IPC] interface
     ++instead of the slower linkgit:githooks[5] interface.
     ++
     ++This daemon is built into Git so that no third-party tools are
     ++required.
     ++
     ++OPTIONS
     ++-------
     ++
     ++start::
     ++	Starts a daemon in the background.
     ++
     ++run::
     ++	Runs a daemon in the foreground.
     ++
     ++stop::
     ++	Stops the daemon running in the current working
     ++	directory, if present.
     ++
     ++status::
     ++	Exits with zero status if a daemon is watching the
     ++	current working directory.
     ++
     ++REMARKS
     ++-------
     ++
     ++This daemon is a long running process used to watch a single working
     ++directory and maintain a list of the recently changed files and
     ++directories.  Performance of commands such as `git status` can be
     ++increased if they just ask for a summary of changes to the working
     ++directory and can avoid scanning the disk.
     ++
     ++When `core.useBuiltinFSMonitor` is set to `true` (see
     ++linkgit:git-config[1]) commands, such as `git status`, will ask the
     ++daemon for changes and automatically start it (if necessary).
     ++
     ++For more information see the "File System Monitor" section in
     ++linkgit:git-update-index[1].
     ++
     ++CAVEATS
     ++-------
     ++
     ++The fsmonitor daemon does not currently know about submodules and does
     ++not know to filter out file system events that happen within a
     ++submodule.  If fsmonitor daemon is watching a super repo and a file is
     ++modified within the working directory of a submodule, it will report
     ++the change (as happening against the super repo).  However, the client
     ++will properly ignore these extra events, so performance may be affected
     ++but it will not cause an incorrect result.
     ++
     ++GIT
     ++---
     ++Part of the linkgit:git[1] suite
     +
       ## Documentation/git-update-index.txt ##
      @@ Documentation/git-update-index.txt: FILE SYSTEM MONITOR
       This feature is intended to speed up git operations for repos that have
  -:  ----------- >  6:  78e682fc530 fsmonitor--daemon: add a built-in fsmonitor daemon
  -:  ----------- >  7:  ea64b5c9753 fsmonitor--daemon: implement 'stop' and 'status' commands
  -:  ----------- >  8:  5a40b33a00c compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
  -:  ----------- >  9:  ed5819e29f8 compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
  -:  ----------- > 10:  d3ac973a5f1 fsmonitor--daemon: implement 'run' command
  -:  ----------- > 11:  d08c28b549c fsmonitor--daemon: implement 'start' command
  -:  ----------- > 12:  6fa71fdc825 fsmonitor--daemon: add pathname classification
  -:  ----------- > 13:  65821da5b03 fsmonitor--daemon: define token-ids
  -:  ----------- > 14:  429c48a5bad fsmonitor--daemon: create token-based changed path cache
  -:  ----------- > 15:  b04c460c619 compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
  -:  ----------- > 16:  862bbfcc32e compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
  -:  ----------- > 17:  40d9a816b52 compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
  -:  ----------- > 18:  241962894f1 fsmonitor--daemon: implement handle_client callback
  -:  ----------- > 19:  704d37d2033 help: include fsmonitor--daemon feature flag in version info
  -:  ----------- > 20:  de6c72a9ce0 t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
  -:  ----------- > 21:  eedaa787c2e t7527: create test for fsmonitor--daemon
  -:  ----------- > 22:  4e96e0667ba t/perf: avoid copying builtin fsmonitor files into test repo
  -:  ----------- > 23:  de9c015d78c t/helper/test-chmtime: skip directories on Windows
  -:  ----------- > 24:  1c2eccacff6 t/perf/p7519: speed up test on Windows
  -:  ----------- > 25:  236b5966257 t/perf/p7519: add fsmonitor--daemon test cases
  -:  ----------- > 26:  54710a4830d fsmonitor--daemon: periodically truncate list of modified files
  -:  ----------- > 27:  1e2bd77fcea fsmonitor--daemon: use a cookie file to sync with file system
  -:  ----------- > 28:  30e61b6d1ad fsmonitor: force update index after large responses
  -:  ----------- > 29:  507020bbef0 t7527: test status with untracked-cache and fsmonitor--daemon

-- 
gitgitgadget
