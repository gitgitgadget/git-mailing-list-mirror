Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB0AC04FDE
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiLMLLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMLLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:11:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A731CB1A
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:10:55 -0800 (PST)
Received: (qmail 14455 invoked by uid 109); 13 Dec 2022 11:10:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:10:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4276 invoked by uid 111); 13 Dec 2022 11:10:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:10:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:10:54 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/9] more -Wunused-parameter fixes/annotations
Message-ID: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was supposed to just be annotations, but after staring at a few of
the cases, I think we're better off removing the unused parameters. I've
floated those ones up to the top of the series.

  [1/9]: ls-refs: use repository parameter to iterate refs
  [2/9]: blob: drop unused parts of parse_blob_buffer()
  [3/9]: list-objects: drop process_gitlink() function
  [4/9]: ws: drop unused parameter from ws_blank_line()
  [5/9]: xdiff: drop unused parameter in def_ff()
  [6/9]: xdiff: mark unused parameter in xdl_call_hunk_func()
  [7/9]: diff: mark unused parameters in callbacks
  [8/9]: list-objects-filter: mark unused parameters in virtual functions
  [9/9]: userdiff: mark unused parameter in internal callback

 add-interactive.c           |  2 +-
 apply.c                     |  4 ++--
 blob.c                      |  3 +--
 blob.h                      |  3 +--
 builtin/add.c               |  2 +-
 builtin/fast-export.c       |  2 +-
 builtin/merge-tree.c        |  2 +-
 builtin/merge.c             |  2 +-
 builtin/rerere.c            |  2 +-
 builtin/reset.c             |  3 ++-
 builtin/submodule--helper.c |  2 +-
 cache.h                     |  2 +-
 combine-diff.c              |  2 +-
 diff-lib.c                  |  2 +-
 diff.c                      | 18 +++++++++---------
 list-objects-filter.c       | 30 +++++++++++++++---------------
 list-objects.c              | 33 +--------------------------------
 ls-refs.c                   |  5 +++--
 object.c                    |  5 ++---
 range-diff.c                | 12 ++++++++----
 ref-filter.c                |  5 +++--
 refs.c                      |  9 +++++----
 refs.h                      |  6 ++++--
 revision.c                  | 25 +++++++++++++++----------
 submodule.c                 |  2 +-
 userdiff.c                  |  3 ++-
 ws.c                        |  2 +-
 wt-status.c                 |  4 ++--
 xdiff/xdiffi.c              |  2 +-
 xdiff/xemit.c               |  4 ++--
 30 files changed, 90 insertions(+), 108 deletions(-)

-Peff
