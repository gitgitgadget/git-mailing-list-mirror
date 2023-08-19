Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F7EE49AB
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjHTAfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Aug 2023 20:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHTAeh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2023 20:34:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C07BAAB1D
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 16:51:30 -0700 (PDT)
Received: (qmail 26311 invoked by uid 109); 19 Aug 2023 23:51:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Aug 2023 23:51:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22891 invoked by uid 111); 19 Aug 2023 23:51:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Aug 2023 19:51:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 19 Aug 2023 19:51:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] fixing a few function pointer mismatches
Message-ID: <20230819235123.GA600613@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I saw that clang-18 hit Debian unstable, so I did my usual "build and
see if it finds anything new to complain about". Here's the result. :)

Note that that first one is a regression in the upcoming v2.42, though I
suspect the fallout would not be very widespread (see comments in the
commit message).

  [1/2]: fsck: use enum object_type for fsck_walk callback
  [2/2]: hashmap: use expected signatures for comparison functions

 builtin/fsck.c    |  2 +-
 compat/terminal.c | 10 ++++++----
 range-diff.c      | 11 +++++++----
 3 files changed, 14 insertions(+), 9 deletions(-)

-Peff
