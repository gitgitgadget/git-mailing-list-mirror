Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894181F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404894AbfBNFrj (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:47:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:43704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726129AbfBNFrj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:47:39 -0500
Received: (qmail 719 invoked by uid 109); 14 Feb 2019 05:47:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:47:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6781 invoked by uid 111); 14 Feb 2019 05:47:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:47:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:47:37 -0500
Date:   Thu, 14 Feb 2019 00:47:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/10] dropping more unused function parameters
Message-ID: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are ten more patches from my exploration of -Wunused-parameters.
Most of these are quite old and not urgent, but things seem relatively
quiet now, and they all merge cleanly with "pu".

In a sense they should all be trivial to review, as they only remove
unused parameters. But the thing to consider is whether that parameter's
lack of use is actually a bug, or if it's simply cruft (and I argue in
each case in favor of cruft).

  [01/10]: diff: drop options parameter from diffcore_fix_diff_index()
  [02/10]: diff: drop unused color reset parameters
  [03/10]: diff: drop unused emit data parameter from sane_truncate_line()
  [04/10]: diff: drop complete_rewrite parameter from run_external_diff()
  [05/10]: merge-recursive: drop several unused parameters
  [06/10]: pack-objects: drop unused parameter from oe_map_new_pack()
  [07/10]: files-backend: drop refs parameter from split_symref_update()
  [08/10]: ref-filter: drop unused buf/sz pairs
  [09/10]: ref-filter: drop unused "obj" parameters
  [10/10]: ref-filter: drop unused "sz" parameters

 diff-lib.c           |  2 +-
 diff.c               | 31 ++++++++++++-------------------
 diff.h               |  2 +-
 merge-recursive.c    | 19 +++++++------------
 pack-objects.c       |  3 +--
 pack-objects.h       |  6 +++---
 ref-filter.c         | 36 ++++++++++++++++++------------------
 refs/files-backend.c |  5 ++---
 8 files changed, 45 insertions(+), 59 deletions(-)

-Peff
