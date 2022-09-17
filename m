Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C31ECAAD8
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 01:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIQBM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 21:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQBM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 21:12:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBB122BDF
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 18:12:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b5so38527889wrr.5
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 18:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=xb2jKm8wmY2Relp9vnbxS4QIGtZgYjTMStzBv9h0dOM=;
        b=Rvwrc5+owPcDHHhWQGJRNjzCYhv3J1rJUgtLqfgm3PeRKbfBsoSQsUcODqwXx0Ik2f
         8qYvVk1dbJo0+wkjo/ONZbyuX6nWug5QyCkmzHooCvoeZdjf+hakSmJRnMe9ZhQROGrC
         GfYn1dcQjH9XCpaeeRk5ymvgvwr3lY19uDGPr5wj3UhSEPss0sAyUIdYECXj9GmlQES6
         PIMIfnDD0HJgE3oobXBfQGCOeqT6t1NwSWkVu8iSfsGlSmbHxYMq74vtIR5Y4Wqbitx3
         jok7/GI6qhGfs25u24kaHrS0Fq6enZ7Qw0eT4UPuzNB8Wo5BSKhObuBVXE11d0m5v2XK
         nDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xb2jKm8wmY2Relp9vnbxS4QIGtZgYjTMStzBv9h0dOM=;
        b=w7TccPBwQGA+cBQnI0hDzjMvBjxsbikSpic2ci72NS9UDyTnPAPBL9z/ABXWm7sWRL
         YUwZIDML0aKXGAoly0om1fTntVp+Qk70nke/WrhIdPLwCR/kcYXjYMcyPGaLdb9uXyL6
         BRJLsFjsidxC01CwgQMWd1sK+nVGs7HAXr22V+lYqrJOjK7uhSIK4fjsgHLs7ERkhjJ6
         aQExsJeyCydUzkl5wBnGnhRlIWMb+Vdg3AfuocnhSUWmNE1aCHNlN4GYGnp871Z5hv3c
         p2TvIoA2icvJQeuOAR1bnC+kplh2rMEZwNxAoEQuYuorGG4qzO+CNI4dyw3Rt5X3Z6VB
         4cYg==
X-Gm-Message-State: ACrzQf0NRQHLEkraLKYO8HFpQ8blHY28SgRi8iNRNNUZFMSyZxTLkJnK
        6+jstaxoGakEvdSr3jv/Cm1p572/2qM=
X-Google-Smtp-Source: AMsMyM4MiAooh8uXIDK9BSfkk1LQ2tyUAr8/lvXCCpjmK/pd1P+so7yGKYtXkFSZYwfInczBEbCv3g==
X-Received: by 2002:a05:6000:178c:b0:222:f8ec:9977 with SMTP id e12-20020a056000178c00b00222f8ec9977mr4185570wrg.509.1663377142973;
        Fri, 16 Sep 2022 18:12:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4642896wmq.23.2022.09.16.18.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:12:22 -0700 (PDT)
Message-Id: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Sep 2022 01:12:16 +0000
Subject: [PATCH v8 0/5] fsmonitor: option to allow fsmonitor to run against network-mounted repos
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

Eric DeCosta (5):
  fsmonitor: refactor filesystem checks to common interface
  fsmonitor: relocate socket file if .git directory is remote
  fsmonitor: avoid socket location check if using hook
  fsmonitor: deal with synthetic firmlinks on macOS
  fsmonitor: add documentation for allowRemote and socketDir options

 Documentation/git-fsmonitor--daemon.txt  |  35 +++++
 Makefile                                 |   2 +
 builtin/fsmonitor--daemon.c              |  11 +-
 compat/fsmonitor/fsm-ipc-darwin.c        |  46 ++++++
 compat/fsmonitor/fsm-ipc-win32.c         |   9 ++
 compat/fsmonitor/fsm-listen-darwin.c     |   6 +-
 compat/fsmonitor/fsm-path-utils-darwin.c | 132 +++++++++++++++++
 compat/fsmonitor/fsm-path-utils-win32.c  | 145 +++++++++++++++++++
 compat/fsmonitor/fsm-settings-darwin.c   |  70 +++------
 compat/fsmonitor/fsm-settings-win32.c    | 174 +----------------------
 contrib/buildsystems/CMakeLists.txt      |   4 +
 fsmonitor--daemon.h                      |   3 +
 fsmonitor-ipc.c                          |  18 ++-
 fsmonitor-ipc.h                          |   4 +-
 fsmonitor-path-utils.h                   |  59 ++++++++
 fsmonitor-settings.c                     |  58 +++++++-
 fsmonitor-settings.h                     |   2 +-
 17 files changed, 541 insertions(+), 237 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-ipc-darwin.c
 create mode 100644 compat/fsmonitor/fsm-ipc-win32.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-darwin.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
 create mode 100644 fsmonitor-path-utils.h


base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1326%2Fedecosta-mw%2Ffsmonitor_macos-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1326/edecosta-mw/fsmonitor_macos-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1326

Range-diff vs v7:

 1:  155a6890806 = 1:  155a6890806 fsmonitor: refactor filesystem checks to common interface
 2:  075340bd2a7 ! 2:  b5356497228 fsmonitor: relocate socket file if .git directory is remote
     @@ compat/fsmonitor/fsm-ipc-darwin.c (new)
      +	if (ipc_path)
      +		return ipc_path;
      +
     -+	if (!r)
     -+		r = the_repository;
     -+
      +	ipc_path = fsmonitor_ipc__get_default_path();
      +
      +	/* By default the socket file is created in the .git directory */
 3:  5518d2f3e03 = 3:  6719ca2b24d fsmonitor: avoid socket location check if using hook
 4:  3a9fe473cf4 ! 4:  d736cb8fa90 fsmonitor: deal with synthetic firmlinks on macOS
     @@ Commit message
      
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
     +    fsmonitor: deal with synthetic firmlinks on macOS
     +
     +    Starting with macOS 10.15 (Catalina), Apple introduced a new feature
     +    called 'firmlinks' in order to separate the boot volume into two
     +    volumes, one read-only and one writable but still present them to the
     +    user as a single volume. Along with this change, Apple removed the
     +    ability to create symlinks in the root directory and replaced them with
     +    'synthetic firmlinks'. See 'man synthetic.conf'
     +
     +    When FSEevents reports the path of changed files, if the path involves
     +    a synthetic firmlink, the path is reported from the point of the
     +    synthetic firmlink and not the real path. For example:
     +
     +    Real path:
     +    /System/Volumes/Data/network/working/directory/foo.txt
     +
     +    Synthetic firmlink:
     +    /network -> /System/Volumes/Data/network
     +
     +    FSEvents path:
     +    /network/working/directory/foo.txt
     +
     +    This causes the FSEvents path to not match against the worktree
     +    directory.
     +
     +    There are several ways in which synthetic firmlinks can be created:
     +    they can be defined in /etc/synthetic.conf, the automounter can create
     +    them, and there may be other means. Simply reading /etc/synthetic.conf
     +    is insufficient. No matter what process creates synthetic firmlinks,
     +    they all get created in the root directory.
     +
     +    Therefore, in order to deal with synthetic firmlinks, the root directory
     +    is scanned and the first possible synthetic firmink that, when resolved,
     +    is a prefix of the worktree is used to map FSEvents paths to worktree
     +    paths.
     +
     +    Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
     +
     +    fsmonitor: deal with synthetic firmlinks on macOS
     +
     +    Starting with macOS 10.15 (Catalina), Apple introduced a new feature
     +    called 'firmlinks' in order to separate the boot volume into two
     +    volumes, one read-only and one writable but still present them to the
     +    user as a single volume. Along with this change, Apple removed the
     +    ability to create symlinks in the root directory and replaced them with
     +    'synthetic firmlinks'. See 'man synthetic.conf'
     +
     +    When FSEevents reports the path of changed files, if the path involves
     +    a synthetic firmlink, the path is reported from the point of the
     +    synthetic firmlink and not the real path. For example:
     +
     +    Real path:
     +    /System/Volumes/Data/network/working/directory/foo.txt
     +
     +    Synthetic firmlink:
     +    /network -> /System/Volumes/Data/network
     +
     +    FSEvents path:
     +    /network/working/directory/foo.txt
     +
     +    This causes the FSEvents path to not match against the worktree
     +    directory.
     +
     +    There are several ways in which synthetic firmlinks can be created:
     +    they can be defined in /etc/synthetic.conf, the automounter can create
     +    them, and there may be other means. Simply reading /etc/synthetic.conf
     +    is insufficient. No matter what process creates synthetic firmlinks,
     +    they all get created in the root directory.
     +
     +    Therefore, in order to deal with synthetic firmlinks, the root directory
     +    is scanned and the first possible synthetic firmink that, when resolved,
     +    is a prefix of the worktree is used to map FSEvents paths to worktree
     +    paths.
     +
     +    Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
     +
       ## builtin/fsmonitor--daemon.c ##
      @@
       #include "parse-options.h"
 5:  4d00adb1deb < -:  ----------- fsmonitor: deal with synthetic firmlinks on macOS
 6:  260591f5820 = 5:  ddf4e3e6442 fsmonitor: add documentation for allowRemote and socketDir options

-- 
gitgitgadget
