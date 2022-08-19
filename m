Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE8C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 08:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347792AbiHSIsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347783AbiHSIsu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 04:48:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AECC7A527
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 01:48:45 -0700 (PDT)
Received: (qmail 17522 invoked by uid 109); 19 Aug 2022 08:48:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 08:48:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 366 invoked by uid 111); 19 Aug 2022 08:48:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 04:48:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 04:48:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] unused function parameter potpourri
Message-ID: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few small cleanups of unused function parameters. The first
five just drop the unused parameters. These are all trivially correct,
since otherwise the compiler would complain. But I tried to make sure
that dropping was the right thing in each (rather than it being a bug
where the parameter should have been used).

The final one just uses the parameters for an assertion, following a
pattern we've used before.

I'll try to cc the individual authors for each patch.

  [1/6]: xdiff: drop unused mmfile parameters from xdl_do_histogram_diff()
  [2/6]: log-tree: drop unused commit param in remerge_diff()
  [3/6]: match_pathname(): drop unused "flags" parameter
  [4/6]: verify_one_sparse(): drop unused repository parameter
  [5/6]: reftable: drop unused parameter from reader_seek_linear()
  [6/6]: reflog: assert PARSE_OPT_NONEG in parse-options callbacks

 attr.c             | 2 +-
 builtin/reflog.c   | 4 ++++
 cache-tree.c       | 6 ++----
 dir.c              | 6 ++----
 dir.h              | 2 +-
 log-tree.c         | 5 ++---
 reftable/reader.c  | 6 +++---
 xdiff/xdiffi.c     | 2 +-
 xdiff/xdiffi.h     | 3 +--
 xdiff/xhistogram.c | 3 +--
 10 files changed, 18 insertions(+), 21 deletions(-)

-Peff
