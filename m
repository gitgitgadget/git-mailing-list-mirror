Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905221F463
	for <e@80x24.org>; Sun, 15 Sep 2019 01:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfIOBJo (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 21:09:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:50504 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726791AbfIOBJo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 21:09:44 -0400
Received: (qmail 23178 invoked by uid 109); 15 Sep 2019 01:09:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 15 Sep 2019 01:09:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28836 invoked by uid 111); 15 Sep 2019 01:11:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Sep 2019 21:11:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Sep 2019 21:09:43 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: [PATCH 0/3] clone --filter=sparse:oid bugs
Message-ID: <20190915010942.GA19787@sigill.intra.peff.net>
References: <20190829231925.15223-1-jon@jonsimons.org>
 <20190829231925.15223-2-jon@jonsimons.org>
 <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
 <20190904045424.GA6488@sigill.intra.peff.net>
 <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
 <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com>
 <20190909170823.GA30470@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190909170823.GA30470@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 09, 2019 at 01:08:24PM -0400, Jeff King wrote:

> I'll work up what I sent earlier into a real patch, and include some of
> this discussion.

Here it is. I pulled Jon's tests out into their own patch (mostly
because it makes it easier to give credit). Then patch 2 is my fix, and
patch 3 is the message fixups he had done.

This replaces what's queued in js/partial-clone-sparse-blob.

  [1/3]: t5616: test cloning/fetching with sparse:oid=<oid> filter
  [2/3]: list-objects-filter: delay parsing of sparse oid
  [3/3]: list-objects-filter: give a more specific error sparse parsing error

 builtin/rev-list.c            |  4 ----
 list-objects-filter-options.c | 14 ++------------
 list-objects-filter-options.h |  2 +-
 list-objects-filter.c         | 14 +++++++++++---
 t/t5616-partial-clone.sh      | 36 +++++++++++++++++++++++++++++++++++
 5 files changed, 50 insertions(+), 20 deletions(-)

