Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95594C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22E52086A
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgHDHlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:41:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:47358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgHDHlr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 03:41:47 -0400
Received: (qmail 561 invoked by uid 109); 4 Aug 2020 07:41:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 07:41:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9620 invoked by uid 111); 4 Aug 2020 07:41:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 03:41:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 03:41:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/3] some compiler/asan/ubsan fixes
Message-ID: <20200804074146.GA190027@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are fixes for a few problems I came across today while running
"make SANITIZE=address,undefined test" on the tip of master.

  [1/3]: config: work around gcc-10 -Wstringop-overflow warning
  [2/3]: revision: avoid out-of-bounds read/write on empty pathspec
  [3/3]: revision: avoid leak when preparing bloom filter for "/"

 config.c   | 2 +-
 revision.c | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

-Peff
