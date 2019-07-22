Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B661F461
	for <e@80x24.org>; Mon, 22 Jul 2019 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfGVRyX (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 13:54:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40296 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfGVRyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 13:54:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so40334012wrl.7
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lZBozKiLsRSjgHURbRotE3npFGFpTBkGTxlMw/31/70=;
        b=P0JhqXfClI8oczDsMb/P3oj/Q7S+nL8Z9HL56lYmIe+iNDR9NHU3lbcs3RBKB/vSA1
         IB9c22YsWW71kj4y97B5PLOeKeh+jkGEqS9IseB/uHROVwKV7CeqRXMqxfuHYET8E8BE
         HoxoFS3QoTMEamdpfsbFVidxOUr2mDmq51VVYEOc/yKJUuvTON1AEMwI0K3sGzJLPc9I
         29sfDhK6iVOslcxgE/ZrMDTb3fg/nsFFDaPQKUCy9IzPFpqwuWQpEon3x8s/3LgPCWVa
         l8tlWzcaQiZo3XKP1VFBbrGDdG+9JTxc2hqwXpbNiZ/yPBIBqf2Usw2qiZ9X8KPL99b/
         7+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lZBozKiLsRSjgHURbRotE3npFGFpTBkGTxlMw/31/70=;
        b=OkjzDsUiVX4gjqdmZPQzFO5jamalkr/yOYd0QFYisFna4ATXFAtXw4H7Ikyzlg1Rli
         xQGuGpM3G90F7ssOMz+Bbge7wuUXb6ZTbwAI6amo1rgOlfFxfVTvz9nUFwDM3QUpBFic
         +U6iaQOcMXQvzarOvjoW2Afu3sKZ6we7vFs3V8QwiUdqZ5QVgyXlu3jaceQmPuAGFxM5
         iatcrs0xbJjqv3tfhOjnQFwBbItOKtPdA5iPknv464qwQ0jJKlmeRqdXFm92wMHTXvhk
         /U8N4fBWY4ap4GmQSaIqCNagsbMP0aDrncfxrURRBJivkfROBey6w8nxaA+HW76SwfK2
         NGKQ==
X-Gm-Message-State: APjAAAWs74LBu+iHuf7MjSUpDZStGI2Hd9JkwK4c8ygndHokwrrvLru4
        AMscf8kHQfZVUrXf831e1QBIgC6A
X-Google-Smtp-Source: APXvYqzL9iipanXm6KBJlnJTJJy/Xebz0CIPTk68E6snfzX7a8FCjnZVa3IxKPbtKAKCltlcVm4ZCQ==
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr46191783wrt.106.1563818061263;
        Mon, 22 Jul 2019 10:54:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm35670878wrx.57.2019.07.22.10.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:54:20 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:54:20 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Jul 2019 17:54:14 GMT
Message-Id: <pull.292.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/5] Create 'feature.*' config area and some centralized config parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a brand-new thread to replace ds/early-access. The discussion on
that thread was very helpful [1].

With this in mind, I propose instead a set of "feature.*" config settings
that form groups of "community recommended" settings (with some caveats). In
the space below, I'll list a set of possible feature names and the implied
config options.

First, the main two categories we've discussed so far: many commits and many
files. These two feature sets are for when your repo is large in one of
these dimensions. Perhaps there are other settings to include in these?

feature.manyFiles:
    index.version = 4
    core.untrackedCache = true

feature.manyCommits:
    core.commitGraph = true
    gc.writeCommitGraph = true
    (future: fetch.writeSplitCommitGraph = true)

Note: the fetch.writeSplitCommitGraph does not exist yet, but could be
introduced in a later release to write a new commit-graph (with --split) on
fetch.

The other category that has been discussed already is that of "experimental
features that we generally think are helpful but change behavior slightly in
some cases".

feature.experimental:
    pack.useSparse = true
    merge.directoryRenames = true
    fetch.negotiationAlgorithm = skipping

Specifically, this setting is for config values we are not sure will ever be
on by default, but additional testing is needed to be sure. This is
different than a possible 'feature.preview' setting that would include
config settings that we are committed to updating the defaults in a future
release. There are many ways we can take this idea in the future (including
more additions to these categories).

Thanks, -Stolee

[1] https://public-inbox.org/git/pull.254.git.gitgitgadget@gmail.com/

Derrick Stolee (5):
  repo-settings: consolidate some config settings
  repo-settings: add feature.manyCommits setting
  repo-settings: parse core.untrackedCache
  repo-settings: create feature.manyFiles setting
  repo-settings: create feature.experimental setting

 Documentation/config.txt             |   2 +
 Documentation/config/core.txt        |   7 +-
 Documentation/config/feature.txt     |  42 +++++++++++
 Documentation/config/fetch.txt       |   3 +-
 Documentation/config/gc.txt          |   4 +-
 Documentation/config/index.txt       |   1 +
 Documentation/config/merge.txt       |   3 +-
 Documentation/config/pack.txt        |   3 +-
 Makefile                             |   1 +
 builtin/am.c                         |   4 +-
 builtin/gc.c                         |  13 ++--
 builtin/pack-objects.c               |   9 ++-
 builtin/update-index.c               |   7 +-
 commit-graph.c                       |   7 +-
 config.c                             |  24 ------
 fetch-negotiator.c                   |  26 ++++---
 fetch-negotiator.h                   |   5 +-
 fetch-pack.c                         |  11 ++-
 merge-recursive.c                    |  32 ++++----
 merge-recursive.h                    |   1 -
 read-cache.c                         |  31 ++++----
 repo-settings.c                      | 108 +++++++++++++++++++++++++++
 repo-settings.h                      |  29 +++++++
 repository.h                         |   3 +
 t/t1600-index.sh                     |  31 ++++++--
 t/t5552-skipping-fetch-negotiator.sh |  23 ------
 26 files changed, 303 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/config/feature.txt
 create mode 100644 repo-settings.c
 create mode 100644 repo-settings.h


base-commit: 9c9b961d7eb15fb583a2a812088713a68a85f1c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-292%2Fderrickstolee%2Frepo-settings%2Fhead-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-292/derrickstolee/repo-settings/head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/292
-- 
gitgitgadget
