Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7641F403
	for <e@80x24.org>; Fri, 15 Jun 2018 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936336AbeFOUgC (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 16:36:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:46258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936295AbeFOUgB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 16:36:01 -0400
Received: (qmail 29383 invoked by uid 109); 15 Jun 2018 20:36:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 20:36:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24673 invoked by uid 111); 15 Jun 2018 20:36:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 16:36:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 16:35:59 -0400
Date:   Fri, 15 Jun 2018 16:35:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/7] Delete unused methods in EWAH bitmap
Message-ID: <20180615203559.GA26653@sigill.intra.peff.net>
References: <20180615143018.170686-1-dstolee@microsoft.com>
 <20180615182727.172075-1-dstolee@microsoft.com>
 <xmqq1sd7288z.fsf@gitster-ct.c.googlers.com>
 <ee8a1b8f-d14e-218c-3bdf-82908fefbec0@gmail.com>
 <xmqqo9gbzv8b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9gbzv8b.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 12:48:52PM -0700, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
> 
> >> ewah_clear() can become file-scope static, and
> >> rlwit_discharge_empty() can be eliminated.  I do not know if either
> >> is worth doing, though.
> >
> > With Peff's patches, this is true. When I applied your diff to my
> > patch alone we could not do that.
> 
> Yeah, as I organized the patches on two topics in this order:
> 
>   jk/ewah-bounds-check (build on 'maint')
>     Peff's 1/3
>     Peff's 4/3
> 
>   ds/ewah-cleanup (build on top of the above)
>     7 patches in this series
>     Peff's 2/3
>     Peff's 3/3

Thanks, I wasn't sure if I should resend mine on top, but it looks like
you've got it all organized already.

> at the end, these two changes become possible.  Again, I am not sure
> if these are worth doing, so I'll leave it out of these two series,
> at least for now.

IMHO the extra cleanups you showed are worth doing.

-Peff
