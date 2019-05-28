Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1000B1F462
	for <e@80x24.org>; Tue, 28 May 2019 06:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfE1GNU (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 02:13:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:39416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726693AbfE1GNU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 02:13:20 -0400
Received: (qmail 27307 invoked by uid 109); 28 May 2019 06:13:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 06:13:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10375 invoked by uid 111); 28 May 2019 06:14:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 02:14:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 02:13:18 -0400
Date:   Tue, 28 May 2019 02:13:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
Message-ID: <20190528061317.GD7946@sigill.intra.peff.net>
References: <20190524120318.4851-1-chriscool@tuxfamily.org>
 <87ef4of3g6.fsf@evledraar.gmail.com>
 <CAP8UFD2HJ2D9Sndud5Wu7Vyz9Jj-mVkpE4oowd3VaXoV3nugcw@mail.gmail.com>
 <83f6b1f6-2aba-f81c-03d2-69815e8e6cfb@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83f6b1f6-2aba-f81c-03d2-69815e8e6cfb@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 02:46:06PM -0400, Jeff Hostetler wrote:

> My original thoughts were that we could limit the sparse:path to
> local use and disallow it over the wire to the server, but that
> distinction is probably not worth the bother.  Removing it completely
> is fine.

Yeah, it had been my plan to limit it only via upload-pack, under the
assumption that somebody probably wanted it on the local side. If you,
who added it, are OK with removing it completely, that gives me more
confidence that nobody is using it (coupled with the general
experimental nature of partial clones at this point). But I'm still a
little worried somebody may have found a use for it in the meantime.

-Peff
