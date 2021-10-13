Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F48EC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55960610CE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhJMUd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJMUdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:33:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C8C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 13:31:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t2so12352572wrb.8
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UAwrqpsc+x+bS92RQVRE/bkozfFFKL4DMPco/JN0DV8=;
        b=FAKJxvYti4C/uCSgRSJOhKuGKbTcFITprviFEhEzMSwrFZpAcF2ngJiGclR6LNSDMy
         yEFXG1oib66zGlqH2898JSL7TDliDvrl3sQdaU6bYgHHdmBTAGvkzuTj97hp/HNV4U13
         pBO7t8Xj+FIBdL1t6ptIdM4rBBJFn+mYaAEcJOngNbVj1Knj7jX++Ea91/3nkgakeN8l
         wgFKRjp5FXgFPuEpnv41V6xIKyYHO5V2t/epPVmal1WJd6ZLcJtywV+tUBCUr4wJ5LDl
         du+XnZEtROomw8rFcvojqmW5cHlQMRQcW39KNfXoWMRiABmG4itqmK5Jk6oVf057svPy
         +vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UAwrqpsc+x+bS92RQVRE/bkozfFFKL4DMPco/JN0DV8=;
        b=mX9prYxRXYR/DLJ6WwzVXAxv3o/cDaKhqZQyMrAHER8+KnGwwHQWgoADb+IzvWKYwQ
         v7oHzF0psTlxg/7WLVPeXfSlzWgYVyKSPGqWY9wAUBidc8EvT1IuzqWVKtULHyaJ1WpX
         cohjSJ/yMBHLR9ESrKPvduCdwZf+ZVkGfqIK39cyoE12iMHVxoiq/stF3i1WyL5WKaHX
         2kSRr1LxMp7vLVYRMnwD5Fcsd9rUg5SGOkc2X5I43AVL2fAuv5HV+sesiSBeZCf6QSHY
         IvzOrW8KsHpDZeTdCqDfjHvk78NmnQBfJ5sKbgJynBUDUPFKH8cXaEyfT4zgE+AkIYlE
         9bzA==
X-Gm-Message-State: AOAM530+VP7h1eQPaSKjwAi6/7RCmtO0MQWciqjZn2bFDtPeRp0CVFqI
        TZMt77rnsiHgqoKhwicW/lgrc6C7Hgc=
X-Google-Smtp-Source: ABdhPJxOzp5sfGHZ/DEznvi9lgwnPHpTPr+ySEXWvquloX9UqLy3hKsPBHZVhm3TBhpk8M2O68uICA==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr1458282wme.41.1634157108802;
        Wed, 13 Oct 2021 13:31:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm6202877wmc.14.2021.10.13.13.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:31:48 -0700 (PDT)
Message-Id: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Oct 2021 20:31:42 +0000
Subject: [PATCH v3 0/5] Builtin FSMonitor Part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V3 of Part 2 of my Builtin FSMonitor series. Like V2, it is built
upon "next" because it requires "ab/repo-settings-cleanup" and
"jh/builtin-fsmonitor-part1" series.

V3 removes the explicit initialization of r->repo_settings->fsmonitor in
repo-settings.c as requested. It also includes a more detailed commit
message for the 3 commit to explain the rationale for putting fsmonitor
settings in its own source file rather than adding it repo-settings.c

There was a comment on the V2 series about integrating the fsmonitor hook
path with the on-going "hook config" effort that I did not address. I think
it would be best to do that in a follow-on if it makes sense to do so.

cc: Bagas Sanjaya bagasdotme@gmail.com cc: Jeff Hostetler
git@jeffhostetler.com

Jeff Hostetler (5):
  fsmonitor: enhance existing comments
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  fsmonitor: config settings are repository-specific
  fsmonitor: use IPC to query the builtin FSMonitor daemon
  fsmonitor: update fsmonitor config documentation

 Documentation/config/core.txt      |  56 ++++++---
 Documentation/git-update-index.txt |  27 +++--
 Documentation/githooks.txt         |   3 +-
 Makefile                           |   2 +
 builtin/update-index.c             |  19 +++-
 cache.h                            |   1 -
 config.c                           |  14 ---
 config.h                           |   1 -
 environment.c                      |   1 -
 fsmonitor-ipc.c                    | 176 +++++++++++++++++++++++++++++
 fsmonitor-ipc.h                    |  48 ++++++++
 fsmonitor-settings.c               |  97 ++++++++++++++++
 fsmonitor-settings.h               |  21 ++++
 fsmonitor.c                        | 130 +++++++++++++++------
 fsmonitor.h                        |  18 ++-
 repository.h                       |   3 +
 t/README                           |   4 +-
 17 files changed, 536 insertions(+), 85 deletions(-)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h


base-commit: 6e70778dc91e2139466c15ff15a02a22a2ada2d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1041/jeffhostetler/builtin-fsmonitor-part2-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1041

Range-diff vs v2:

 1:  cb25eeaf72d = 1:  cb25eeaf72d fsmonitor: enhance existing comments
 2:  df81a63acee = 2:  df81a63acee fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 3:  7d5a353e74d ! 3:  a1d606aa622 fsmonitor: config settings are repository-specific
     @@ Metadata
       ## Commit message ##
          fsmonitor: config settings are repository-specific
      
     -    Move FSMonitor config settings to a new `struct fsmonitor_settings`
     -    structure.  Add a lazily-loaded pointer to `struct repo_settings`.
     +    Move fsmonitor config settings to a new and opaque
     +    `struct fsmonitor_settings` structure.  Add a lazily-loaded pointer
     +    to this into `struct repo_settings`
     +
     +    Create an `enum fsmonitor_mode` type in `struct fsmonitor_settings` to
     +    represent the state of fsmonitor.  This lets us represent which, if
     +    any, fsmonitor provider (hook or IPC) is enabled.
     +
          Create `fsm_settings__get_*()` getters to lazily look up fsmonitor-
          related config settings.
      
     -    Get rid of the `core_fsmonitor` global variable, and add support for
     -    the new `core.useBuiltinFSMonitor` config setting.  Move config code
     -    to lookup the existing `core.fsmonitor` value to `fsmonitor-settings.[ch]`.
     +    Add support for the new `core.useBuiltinFSMonitor` config setting.
     +
     +    Get rid of the `core_fsmonitor` global variable.  Move the code to
     +    lookup the existing `core.fsmonitor` config value into the fsmonitor
     +    settings.
     +
     +    Create a hook pathname variable in `struct fsmonitor-settings` and
     +    only set it when in hook mode.
      
     -    The `core_fsmonitor` global variable was used to store the pathname to
     -    the FSMonitor hook and it was used as a boolean to see if FSMonitor
     -    was enabled.  This dual usage will lead to confusion when we add
     -    support for a builtin FSMonitor based on IPC, since the builtin
     -    FSMonitor doesn't need the hook pathname.
     +    The existing `core_fsmonitor` global variable was used to store the
     +    pathname to the fsmonitor hook *and* it was used as a boolean to see
     +    if fsmonitor was enabled.  This dual usage and global visibility leads
     +    to confusion when we add the IPC-based provider.  So lets hide the
     +    details in fsmonitor-settings.c and let it decide which provider to
     +    use in the case of multiple settings.  This avoids cluttering up
     +    repo-settings.c with these private details.
      
     -    Replace the boolean usage with an `enum fsmonitor_mode` to represent
     -    the state of FSMonitor.  And only set the pathname when in HOOK mode.
     +    A future commit in builtin-fsmonitor series will add the ability to
     +    disqualify worktrees for various reasons, such as being mounted from a
     +    remote volume, where fsmonitor should not be started.  Having the
     +    config settings hidden in fsmonitor-settings.c allows such worktree
     +    restrictions to override the config values used.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ fsmonitor.h: static inline void mark_fsmonitor_valid(struct index_state *istate,
       		untracked_cache_invalidate_path(istate, ce->name, 1);
       		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
      
     - ## repo-settings.c ##
     -@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     - 	if (r->settings.initialized++)
     - 		return;
     - 
     -+	r->settings.fsmonitor = NULL; /* lazy loaded */
     -+
     - 	/* Defaults */
     - 	r->settings.index_version = -1;
     - 	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
     -
       ## repository.h ##
      @@
       #include "path.h"
 4:  8608c8718d8 = 4:  4d8d812be08 fsmonitor: use IPC to query the builtin FSMonitor daemon
 5:  7c22ce53377 = 5:  45a86cef8d7 fsmonitor: update fsmonitor config documentation

-- 
gitgitgadget
