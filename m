Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8377F1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 12:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeKXWyd (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 17:54:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:49932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726160AbeKXWyd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 17:54:33 -0500
Received: (qmail 1705 invoked by uid 109); 24 Nov 2018 12:06:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Nov 2018 12:06:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1303 invoked by uid 111); 24 Nov 2018 12:05:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 24 Nov 2018 07:05:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Nov 2018 07:06:14 -0500
Date:   Sat, 24 Nov 2018 07:06:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
Message-ID: <20181124120614.GA19257@sigill.intra.peff.net>
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
 <87muq2zoy9.fsf@evledraar.gmail.com>
 <20181122175259.GC22123@sigill.intra.peff.net>
 <xmqqefbb442v.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqefbb442v.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 24, 2018 at 11:11:36AM +0900, Junio C Hamano wrote:

> > However, note that the cache-load for finding abbreviations _must_ have
> > the complete list. And has been loading it for some time. So if you run
> > "git-fetch", for example, you've already been running this code for
> > months (and using the cache in more places is now a free speedup).
> >
> > At the very least, we'd want this patch on top, too. I also think René's
> > suggestion use access() is worth pursuing (though to some degree is
> > orthogonal to the cache).
> 
> OK, will queue, but I wonder where 66f0 comes from before silently
> doing s/66f04152be/3a2e08245c/ myself.

Whoops, I thought I made double-sure to pull the commit id from
origin/jk/loose-object-cache instead of my original local commits, but
obviously I didn't. Thanks for catching it.

-Peff
