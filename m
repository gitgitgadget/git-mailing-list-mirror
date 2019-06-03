Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D5E1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFCUSV (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38899 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFCUSV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id g13so28599951edu.5
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8HA7/ccEbrror/n7f33x59i4qteQiHPsHEqwJJx/skk=;
        b=Oery7FcN1VQKBUqW36Hxz4WVeA4zybG2/c5pzIfDr2S//am+4HIN4ZTX8QxJambgq6
         k5Mc6MLYI4ECwretmmA1PSUqtbNZkn9HZ53uI5ufjSboQQO5yvme2pyOJ3SQOMrTJ2ef
         KvBSUrDnMxK/dDgw2m5q+qO1+GVLAQoeQUcb/k0O6CfkeMDJvTc6oehqIPbMGU8uPh5h
         q+6vbwKnJBZP4DvEXug41KzawKk4nVY+zL9mR9jazbTFKotAAQqL5Ed+H3y+l08bspLU
         NxanbrNzRRCJxbwB7KICaiXVPovgNjDTMe2q7G8DhIj6dRPBqDJfhrxMg/l03qrMFTwY
         FssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8HA7/ccEbrror/n7f33x59i4qteQiHPsHEqwJJx/skk=;
        b=aCF/1Gs1wxwphONgzyX5Ao/WNtizX0wYlMDQHsZM2L5170WFFH7OtAL0mVXJRNUUX8
         FHF4zwRUa1fftAWjIE+F9P2Kc0JQegTHa0Qmg2SHdFVapA7aEahqcWp9+T5pReU5vuXO
         gQ40FW9/RGV6b0uNA6AKsC5fxSsQlxPFoLSAQkyA7iCy1PYordGybiAfyE+8GnlcH2iZ
         /UiCeZaz6QSqsiooDTppBGxUupyNbp/Ba5NiR4QSBo6s+X7VoDZR9mC4w01xE3m4r/Ko
         ljVYkQaskf7TDB0+xxm43C+LbKiHuyxZplQrwyfaQ3q80oHQ21xcESuMctvlIq6/nJCC
         xdXA==
X-Gm-Message-State: APjAAAWH7SeGxkxrJ+q4fXF0bheA/oJN+Fhytn16wLOOgRRRKs06IEHf
        spkM2gTxjUkALnEQ/WKs7lDHjiWF
X-Google-Smtp-Source: APXvYqzI/0UP0abJdz8eudzup/7tR2RkMnuE2NLnxhP84RbJKYzUaK7m7EtpQniOdwUxgXTm4Tcjyw==
X-Received: by 2002:a50:be42:: with SMTP id b2mr30558614edi.228.1559593098889;
        Mon, 03 Jun 2019 13:18:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm394695ejk.73.2019.06.03.13.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:18 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:18 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:06 GMT
Message-Id: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/11] [RFC] Create 'core.size=large' setting to update config defaults
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series includes a few new config options we created to speed up
certain critical commands in VFS for Git. On their own, they would
contribute little value as it is hard to discover new config variables.
Instead, I've created this RFC as a goal for probably three sequential patch
series:

 1. (Patches 1-3) Introduce a new 'core.size' config setting that takes
    'large' as a value. This enables several config values that are
    beneficial for large repos. We use a certain set in VFS for Git (see
    [1]), and most of those are applicable to any repo. This 'core.size'
    setting is intended for users to automatically receive performance
    updates as soon as they are stable, but they must opt-in to the setting
    and can always explicitly set their own config values. The settings to
    include here are core.commitGraph=true, gc.writeCommitGraph=true,
    index.version=4, pack.useSparse=true.
    
    
 2. (Patches 4-8) Introduce 'status.aheadBehind' to dictate if we use
    '--[no-]ahead-behind' during 'git status' calls. Also do some cleanup on
    the feature around porcelain formats. I adapted Jeff Hostetler's commits
    from microsoft/git for this section.
    
    
 3. (Patches 9-12) Introduce 'fetch.showForcedUpdates' and the associated
    '--[no-]show-forced-updates' option for 'git fetch' and 'git pull'
    calls. When fetching from a remote with many branches that move quickly,
    the check for forced updates can be expensive. Further, the only effects
    are a "(forced update)" indicator to stdout and a single bit in the
    reflog. The reflog bit is unfortunate to lose, but it is never trusted
    for important actions. These changes are likely to be more controversial
    than the others.
    
    

Hopefully this direction is amenable to allow "early adopters" gain access
to new performance features even if they are not necessary reading every
line of the release notes.

Thanks, -Stolee

[1] 
https://github.com/microsoft/VFSForGit/blob/6a7fd2ff50056b73b347b882d2b8d52939bd6419/GVFS/GVFS/CommandLine/GVFSVerb.cs#L122-L152
This code includes the settings we enable by default in VFS for Git
enlistments.

Derrick Stolee (8):
  repo-settings: create repo.size=large setting
  repo-settings: use index.version=4 by default
  repo-settings: pack.useSparse=true
  repo-settings: status.aheadBehind=false
  fetch: add --[no-]show-forced-updates argument
  fetch: warn about forced updates after branch list
  pull: add --[no-]show-forced-updates passthrough to fetch
  repo-settings: fetch.showForcedUpdates=false

Jeff Hostetler (3):
  status: add status.aheadbehind setting
  status: add warning when a/b calculation takes too long for
    long/normal format
  status: ignore status.aheadbehind in porcelain formats

 Documentation/config/core.txt   | 31 ++++++++++++++-
 Documentation/config/fetch.txt  |  5 +++
 Documentation/config/gc.txt     |  4 +-
 Documentation/config/index.txt  |  1 +
 Documentation/config/pack.txt   |  3 +-
 Documentation/config/status.txt |  6 +++
 Documentation/fetch-options.txt | 13 +++++++
 Makefile                        |  1 +
 advice.c                        |  2 +
 advice.h                        |  1 +
 builtin/commit.c                | 19 ++++++++-
 builtin/fetch.c                 | 34 ++++++++++++++++-
 builtin/gc.c                    |  6 +--
 builtin/pack-objects.c          |  9 +++--
 builtin/pull.c                  |  7 ++++
 commit-graph.c                  |  7 ++--
 read-cache.c                    | 12 +++---
 repo-settings.c                 | 68 +++++++++++++++++++++++++++++++++
 repo-settings.h                 | 17 +++++++++
 repository.h                    |  3 ++
 t/t6040-tracking-info.sh        | 31 +++++++++++++++
 t/t7064-wtstatus-pv2.sh         |  8 ++++
 wt-status.c                     | 17 +++++++++
 23 files changed, 283 insertions(+), 22 deletions(-)
 create mode 100644 repo-settings.c
 create mode 100644 repo-settings.h


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-254%2Fderrickstolee%2Fconfig-large%2Fupstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-254/derrickstolee/config-large/upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/254
-- 
gitgitgadget
