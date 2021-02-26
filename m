Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCE4C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAE264EDC
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBZHK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:10:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:45586 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhBZHKX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 02:10:23 -0500
Received: (qmail 12210 invoked by uid 109); 26 Feb 2021 07:09:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 07:09:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16795 invoked by uid 111); 26 Feb 2021 07:09:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 02:09:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 02:09:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] t/perf worktree improvements
Message-ID: <YDiesofYW18Mzd9Q@coredump.intra.peff.net>
References: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't think v1 of this patch got picked up at all, so here it is
again. There was a question of whether we could do the much simpler
solution discussed in:

  https://lore.kernel.org/git/22378ce3-6845-1cd9-996a-8bdc3a8b65d7@gmail.com/

But I think it would be confusing. So patch 1 is unchanged here from v1.

Johannes suggested we could add some extra protections to avoid
accidentally modifying the original repo. Patch 2 does that.

  [1/2]: t/perf: handle worktrees as test repos
  [2/2]: t/perf: avoid copying worktree files from test repo

 t/perf/perf-lib.sh | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

-Peff
