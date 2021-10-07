Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECA9C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E4E61077
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 13:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbhJGNyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhJGNyt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 09:54:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1BC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 06:52:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so19317949wrc.10
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MUMvjAYF5VI/diD0E32FvxslYXJJtVu+7xsdFZX3D3o=;
        b=RABZuvbLEn0tWZ5z9w8VFImTw/u4KHX4iBhyipOSdInhlwNfnZrTWIKQVWqEsIknlg
         GleDBuaaSacDU5DhofFI7JaSgieX10PIkqHPjGe+nZTVe8mFIlXdn/PED93hYl7kazmD
         d1J1W0k+xKPveilSz7YrpS11oS/bFDl+4l4awfdD/DmXqyVv1dEkzEg7OIGFrY8WyevL
         fKlhjIdX6kzQ9DMzuzLLmjzS6JI2AWbF4WSoUL3VtlF0pCF+FK3bUGT6k7yU/d0/diqn
         be4fplLMU8+6pk/HCBxDDPvvQTLpglzYGISfeIYwNqWDvgAGjBj+S3W95sys5y7mvNNM
         IC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MUMvjAYF5VI/diD0E32FvxslYXJJtVu+7xsdFZX3D3o=;
        b=oCr/QHvAZ5uBhKkdlqTlGpYqregX7BrgrHAsQXnzhh+6RSG4c+fiiLZ9rifc1XQHkC
         WjtxzXH75eSGaWAIuXscZXNBXRe1P6K3FmbrSTBHv0e7EBcC2HaDfaLSOddQ2ajqkvQj
         9exYwpoxt5Oo1mR3Hk9mzUVYfD92I5+69nDVik3SWk7XCb/Encu1QvZjFOukcvED0GIg
         H5PTZZaXFqkQStqjLfVD2uDJVFLiOglfHgFSgszDTYlEporIltftt4W3zpneuj9em0uS
         hWf7jKN5BKgazSmJFGtbsu+zBvljstLgcz1VXL0mIcHT8EOMGDJP2V0QuF4/Fgsm42RK
         +kWA==
X-Gm-Message-State: AOAM531XbqsWcBDy83764Sl/4j/jPPTziOalYSgtWMfIh76ehZTqz1lV
        F3UElf7ZFjNJRP7QVHhNV7ZDH3Mo3Bw=
X-Google-Smtp-Source: ABdhPJwwkTEP6REmU1wlh1ru7bXzZKVcLuPR9cUVZiYhUPj86Pc5XNQ9Ucs/DXO+p7aRUQ4dQGdiRQ==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr514570wrw.173.1633614774158;
        Thu, 07 Oct 2021 06:52:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v185sm4181129wme.35.2021.10.07.06.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:52:53 -0700 (PDT)
Message-Id: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 13:52:47 +0000
Subject: [PATCH v2 0/5] Builtin FSMonitor Part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V2 of Part 2 of my Builtin FSMonitor series.

This version has been rebased onto "next" because it collided with a change
"repo-settings.c" from "ab/repo-settings-cleanup". And the third commit was
updated to resolve those conflicts.

It also requires "jh/builtin-fsmonitor-part1" which is now in "next".

Part 2 contains:

Client-side code to connect to a (yet to be developed) FSMonitor daemon over
Simple IPC (using Named Pipes or Unix Domain Sockets).

Updated config settings to allow the client to decide whether to use Simple
IPC or the existing FSMonitor Hook API. This includes retiring the existing
"core_fsmonitor" global variable that had confusing double-duty.

Part 2 essentially enables client-side code to talk to different types of
providers of FS change data. Processing of that data is unchanged.

A builtin FSMonitor daemon will be added in a later patch series.

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
 repo-settings.c                    |   2 +
 repository.h                       |   3 +
 t/README                           |   4 +-
 18 files changed, 538 insertions(+), 85 deletions(-)
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h


base-commit: 6e70778dc91e2139466c15ff15a02a22a2ada2d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1041/jeffhostetler/builtin-fsmonitor-part2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1041

Range-diff vs v1:

 1:  6be687ba39d = 1:  cb25eeaf72d fsmonitor: enhance existing comments
 2:  b584f133d28 = 2:  df81a63acee fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 3:  f1266c99adf ! 3:  7d5a353e74d fsmonitor: config settings are repository-specific
     @@ config.c: int git_config_get_max_percent_split_change(void)
       	int is_bool, val;
      
       ## config.h ##
     -@@ config.h: int git_config_get_index_threads(int *dest);
     - int git_config_get_untracked_cache(void);
     +@@ config.h: int git_config_get_pathname(const char *key, const char **dest);
     + int git_config_get_index_threads(int *dest);
       int git_config_get_split_index(void);
       int git_config_get_max_percent_split_change(void);
      -int git_config_get_fsmonitor(void);
     @@ fsmonitor.h: static inline void mark_fsmonitor_valid(struct index_state *istate,
      
       ## repo-settings.c ##
      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     - 	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
     - 	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
     + 	if (r->settings.initialized++)
     + 		return;
       
      +	r->settings.fsmonitor = NULL; /* lazy loaded */
      +
     - 	if (!repo_config_get_int(r, "index.version", &value))
     - 		r->settings.index_version = value;
     - 	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
     + 	/* Defaults */
     + 	r->settings.index_version = -1;
     + 	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
      
       ## repository.h ##
      @@
     @@ repository.h
       struct index_state;
       struct lock_file;
      @@ repository.h: struct repo_settings {
     - 	int gc_write_commit_graph;
     - 	int fetch_write_commit_graph;
     + 	int command_requires_full_index;
     + 	int sparse_index;
       
      +	struct fsmonitor_settings *fsmonitor; /* lazy loaded */
      +
 4:  f2e5da9e5c6 = 4:  8608c8718d8 fsmonitor: use IPC to query the builtin FSMonitor daemon
 5:  fb5251e47ae = 5:  7c22ce53377 fsmonitor: update fsmonitor config documentation

-- 
gitgitgadget
