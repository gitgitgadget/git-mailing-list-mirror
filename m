Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D28761F461
	for <e@80x24.org>; Tue, 23 Jul 2019 19:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfGWTbV (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 15:31:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:49562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726308AbfGWTbV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 15:31:21 -0400
Received: (qmail 9870 invoked by uid 109); 23 Jul 2019 19:31:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jul 2019 19:31:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12465 invoked by uid 111); 23 Jul 2019 19:32:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jul 2019 15:32:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jul 2019 15:31:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matt Turner <mattst88@gmail.com>, Rene Scharfe <l.s.r@web.de>,
        git@vger.kernel.org,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH] archive: Store checksum correctly
Message-ID: <20190723193119.GA3879@sigill.intra.peff.net>
References: <20190723025736.23036-1-mattst88@gmail.com>
 <xmqqd0i0u253.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0i0u253.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 23, 2019 at 09:49:44AM -0700, Junio C Hamano wrote:

> I think a change like this would impact kernel.org folks' tarball
> uploading tool, but that is not a reason not to apply this patch.

That was my thought, too. Distro projects like homebrew rely on
stable hashes of upstream tarballs, and they get cranky when those
tarballs change. Ideally the projects they package would provide
byte-stable tarballs, but many of them rely on on-the-fly tarball
generation by hosting sites like GitHub.

Which isn't to say we should never fix bugs in the tarballs that we
produce, but it's not entirely clear to me that this _is_ a bug, and not
just one tool being overly picky.

-Peff
