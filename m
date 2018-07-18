Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222C11F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeGRPx5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:53:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36693 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeGRPx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:53:57 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so2184082plb.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=m3dd5VtgULJcH/ovdjPZhi763qqODJGDAsewjvsV3VI=;
        b=FYktK2bV9Qe4FdzYmdONiwFqUWXeyWoAZeXVhYEITSUCoryw0CwDSocljuaXJzofcE
         6ayT7JOS1djWOpriuN5FpXSouzzoOIzbrGekV3tY2eL+WmqDtQCVBb1I4M1hdjNyZl3h
         hrG31UK9bRh2B++gqGislqh0+YVE1NvAH4XoQ6lRmElBpvF/NxQYNv44qBAqQgQs7cCJ
         BEpNqiFU+x6jkFdKOWJhNlwL2a07Ogc468RPfIDUGjtFtX63UQOfHCLwyV+zasApt3AN
         ropDTwJGAVKbIuqiOOIEtX7BEMDm3OhG7YC6vVZ3709GzeWKl5izaeY2cVkCGZ2d1VSy
         BDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3dd5VtgULJcH/ovdjPZhi763qqODJGDAsewjvsV3VI=;
        b=ckELeqovTnk1LbQI4ETWWkQITVunXT7LbqMWLOg2hq+g137Aj0i0eZM6cvsNTaj3Xc
         ErqabQSt/0Ia4LIKMRiGpuh1MAP+G3IHFlt6BVQ8iN9f842hFOWbs3gbTLdCNDcFFSjU
         RamkVxNIqH0eRnaLfH6kCVn0O55oLDXxaLww4+i87altw04+2OVU8c6fWVTRoRiz6ItU
         nNKdt4KOxICWTmjWDsgJdn/SNgKVC+5/MapHSdBQ5ZyHF6fGr0/vpoVenvNzUIeI++Xm
         WMYS8TTMJhDrnYk12MwBmgeJAR7Thh3D3jNVNbPNUdLKQbIw5LeEvOK/OldKKjVuzQgc
         Qw0Q==
X-Gm-Message-State: AOUpUlExQryOpG0FL4Fjl5ecEA6XMp9ltsU7N4+NUOzRvoyq4oSKhbwO
        BbyDd6FC4d/5lg51y3m8ZqEqaw==
X-Google-Smtp-Source: AAOMgpeQKLrGXs8fUALvmwCTednCs6YQgA6niGqXEhRAbeCQiZzC4w5QtTP5V3xFYT2ZkSDsYgu2oA==
X-Received: by 2002:a17:902:28e4:: with SMTP id f91-v6mr6417284plb.146.1531926935273;
        Wed, 18 Jul 2018 08:15:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id d23-v6sm6088248pfe.2.2018.07.18.08.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:34 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:34 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:23 GMT
Message-Id: <pull.11.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/8] Clarify commit-graph and grafts/replace/shallow incompatibilities
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One unresolved issue with the commit-graph feature is that it can cause issues when combined with replace objects, commit grafts, or shallow clones. These are not 100% incompatible, as one could be reasonably successful writing a commit-graph after replacing some objects and not have issues. The problems happen when commits that are already in the commit-graph file are replaced, or when git is run with the `--no-replace-objects` option; this can cause incorrect parents or incorrect generation numbers. Similar things occur with commit grafts and shallow clones, especially when running `git fetch --unshallow` in a shallow repo.

Instead of trying (and probably failing) to make these features work together, default to making the commit-graph feature unavailable in these situations. Create a new method 'commit_graph_compatible(r)' that checks if the repository 'r' has any of these features enabled.

I will send a follow-up patch that shows how I tested these interactions by computing the commit-graph on every 'git commit'.

This approach works for most cases, but I found one nagging test case that was causing problems. This led to the commit "commit-graph: close_commit_graph before shallow walk" and is the patch I am least confident about. Please take a close look at that one and suggest alternatives.

This approach is very different from the previous RFC on the subject [1].

While building this series, I got some test failures in the non-the_repository tests. These issues are related to missing references to an arbitrary repository (instead of the_repository) and some uninitialized values in the tests. Stefan already sent a patch to address this [2], and I've included those commits (along with a small tweak [3]). These are only included for convenience.

Thanks,
-Stolee

[1] https://public-inbox.org/git/20180531174024.124488-1-dstolee@microsoft.com/
     [RFC PATCH 0/6] Fix commit-graph/graft/replace/shallow combo

[2] https://public-inbox.org/git/20180717224935.96397-1-sbeller@google.com/T/#t
    [PATCH 0/2] RFC ref store to repository migration

[3] https://public-inbox.org/git/20180717224935.96397-1-sbeller@google.com/T/#m966eac85fd58c66523654ddaf0bec72877d3295a
    [PATCH] TO-SQUASH: replace the_repository with arbitrary r

Based-On: jt/commit-graph-per-object-store
Cc: jonathantanmy@google.com
Cc: sbeller@google.com

Derrick Stolee (6):
  commit-graph: update design document
  test-repository: properly init repo
  commit-graph: not compatible with replace objects
  commit-graph: not compatible with grafts
  commit-graph: not compatible with uninitialized repo
  commit-graph: close_commit_graph before shallow walk

Stefan Beller (2):
  refs.c: migrate internal ref iteration to pass thru repository
    argument
  refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback

 Documentation/technical/commit-graph.txt | 18 ++++++--
 builtin/replace.c                        |  8 ++--
 commit-graph.c                           | 34 ++++++++++++--
 commit-graph.h                           |  1 +
 commit.c                                 |  2 +-
 commit.h                                 |  1 +
 refs.c                                   | 48 +++++++++++++++++---
 refs.h                                   | 12 ++++-
 refs/iterator.c                          |  6 +--
 refs/refs-internal.h                     |  5 +-
 replace-object.c                         |  7 +--
 replace-object.h                         |  2 +
 t/helper/test-repository.c               | 10 +++-
 t/t5318-commit-graph.sh                  | 58 ++++++++++++++++++++++++
 upload-pack.c                            |  2 +
 15 files changed, 184 insertions(+), 30 deletions(-)


base-commit: dade47c06cf849b0ca180a8e6383b55ea6f75812
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-11%2Fderrickstolee%2Fshallow%2Fupstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-11/derrickstolee/shallow/upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/11
-- 
gitgitgadget
