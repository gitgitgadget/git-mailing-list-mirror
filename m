Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9461F454
	for <e@80x24.org>; Wed, 17 Oct 2018 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeJREag (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 00:30:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44358 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 00:30:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so13058231pgu.11
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yswzimhShzvFAFcrB741vPH/zExrO3EgFGo6H3J0LMk=;
        b=icI4JV0wa5yslaICUD+Wjx6iY5CHtkgRi4pkbDijken1Hw8s+CCfnqTdyEYEDN0xgE
         LbTo6zYK/XK4NgERn10hx+Wtr7EbnhMf9vEPn3JOEO7/EkSWUts24u9IyhZfShC7/qg8
         w/1z/kCurmqhgUatKhG1Q79fwJ3vcZR7IinLWB8eWWzKpmKcJfj1UV46IWe/ceODVPvT
         1OkbRSC3nKy/eM27Td3rXpMLW5i2+YQzE7hx8va+oiwWGlfBFB2Me3xjJgvvd7Io0quW
         AjaAXw+YczI5ThPn7jYaWD+CM0jkMOnJoDV1NpOlmaZhLh5vWMoBa5yuBcifm0i45Wkw
         OZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yswzimhShzvFAFcrB741vPH/zExrO3EgFGo6H3J0LMk=;
        b=LeyayFMdbrzfwA9fqswCy7XlFTNyfvAWzqBILtoc1vbzYUr9PyfGlwgAWGHH7MJbKd
         mOsUACeORdF8Ff71f6mj+dwJ8kf75YI3Ftp2oj4Hktg/ZHPkNbPtkvuosuUJQuizmcfg
         VmPMsF+xU+tZ2gvzCGK2RSCcowcYMjPZPpzcIAvykfdmaHXLuwIq0UYrHkpcJGlOTS1f
         RGYCUkhjiI8w7gTSy3EQsgQxJEp4u7FZz+/8vK2dgvjsJfIczLV6YqkH0PaPo23omdqs
         OzpsxKEhAMOXjFjlnkxNguVDm/iy2bTgE2o4k9kAGWT2IO8nvBltZzQdkBHRS4M+M7Y7
         V8wg==
X-Gm-Message-State: ABuFfogFvqlVX1rVL/fC85vaEYzpm3+pi5A0j08AnFW5hPby9MupVjLE
        lDIjt93WY9JmaUFC1tjb2CvrNcrn
X-Google-Smtp-Source: ACcGV632ix/TI8qGU7pmrBTUEHyBwAAA8C3BTnkYMyQmoKiu2Qq7LMHwldBtMRlKBMjgmRYZYQ7RVQ==
X-Received: by 2002:aa7:8305:: with SMTP id t5-v6mr27555284pfm.81.1539808391842;
        Wed, 17 Oct 2018 13:33:11 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l83-v6sm37283215pfi.172.2018.10.17.13.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 13:33:10 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:33:10 -0700 (PDT)
X-Google-Original-Date: Wed, 17 Oct 2018 20:33:05 GMT
Message-Id: <pull.50.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Use commit-graph by default
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

The commit-graph feature is starting to stabilize. Based on what is in
master right now, we have:

Git 2.18:

 * Ability to write commit-graph (requires user interaction).
   
   
 * Commit parsing is faster when commit-graph exists.
   
   
 * Must have core.commitGraph true to use.
   
   

Git 2.19:

 * Ability to write commit-graph on GC with gc.writeCommitGraph.
   
   
 * Generation numbers written in commit-graph
   
   
 * A few reachability algorithms make use of generation numbers.
   
   

(queued for) master:

 * The test suite passes with GIT_TEST_COMMIT_GRAPH=1
   
   
 * 'git commit-graph write' has progress indicators.
   
   
 * The commit-graph is automatically disabled when grafts or replace-objects
   exist.
   
   

There are some other things coming that are in review (like 'git log
--graph' speedups), but it is probably time to consider enabling the
commit-graph by default. This series does that.

For timing, I'm happy to leave this queued for a merge after the Git 2.20
release. There are enough things in master to justify not enabling this by
default until that goes out and more people use it.

PATCH 3/3 is rather simple, and is the obvious thing to do to achieve
enabling these config values by default.

PATCH 1/3 is a required change to make the test suite work with this change.
This change isn't needed with GIT_TEST_COMMIT_GRAPH=1 because the
commit-graph is up-to-date for these 'git gc' calls, so no progress is
output.

PATCH 2/3 is also a necessary evil, since we already had to disable
GIT_TEST_COMMIT_GRAPH for some tests, we now also need to turn off
core.commitGraph.

Thanks, -Stolee

Derrick Stolee (3):
  t6501: use --quiet when testing gc stderr
  t: explicitly turn off core.commitGraph as needed
  commit-graph: Use commit-graph by default

 Documentation/config.txt            | 4 ++--
 builtin/gc.c                        | 2 +-
 commit-graph.c                      | 6 +++---
 t/t0410-partial-clone.sh            | 3 ++-
 t/t5307-pack-missing-commit.sh      | 3 ++-
 t/t6011-rev-list-with-bad-commit.sh | 3 ++-
 t/t6024-recursive-merge.sh          | 3 ++-
 t/t6501-freshen-objects.sh          | 6 +++---
 8 files changed, 17 insertions(+), 13 deletions(-)


base-commit: a4b8ab5363a32f283a61ef3a962853556d136c0e
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-50%2Fderrickstolee%2Fcommit-graph-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-50/derrickstolee/commit-graph-default-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/50
-- 
gitgitgadget
