Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55016C433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiFSDxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiFSDw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:52:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B5B11A2F
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:52:27 -0700 (PDT)
Received: (qmail 23634 invoked by uid 109); 19 Jun 2022 03:52:26 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jun 2022 03:52:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Sat, 18 Jun 2022 23:52:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 0/2] extra cleanups on top of ds/branch-checked-out
Message-ID: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few extra cleanups on top of ds/branch-checked-out; that
topic made some local "worktrees" variables obsolete, but didn't get rid
of them.

The first was detected by my local -Wunused-parameter topic. The second
is a similar case that the compiler doesn't happen to notice, but which
I went digging for after seeing the first. I think that should be the
extent of it. There's a third caller in validate_new_branchname(), but
the series already got rid of its worktrees variable.

  [1/2]: fetch: stop passing around unused worktrees variable
  [2/2]: branch: drop unused worktrees variable

 builtin/branch.c |  4 ----
 builtin/fetch.c  | 24 +++++++++---------------
 2 files changed, 9 insertions(+), 19 deletions(-)

-Peff
