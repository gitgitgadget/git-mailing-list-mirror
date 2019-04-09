Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DF820248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDIPPO (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:15:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:52272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726494AbfDIPPO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:15:14 -0400
Received: (qmail 7459 invoked by uid 109); 9 Apr 2019 15:15:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Apr 2019 15:15:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30815 invoked by uid 111); 9 Apr 2019 15:15:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Apr 2019 11:15:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2019 11:15:07 -0400
Date:   Tue, 9 Apr 2019 11:15:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 01/13] packfile.h: drop extern from function
 declarations
Message-ID: <20190409151507.GA12627@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
 <20190405180340.GA32243@sigill.intra.peff.net>
 <c21b923f-54aa-defa-ecfd-11ecd6f8a664@ramsayjones.plus.com>
 <20190405192534.GA4496@sigill.intra.peff.net>
 <xmqqsgur43nm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgur43nm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 12:08:45AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Apr 05, 2019 at 08:19:30PM +0100, Ramsay Jones wrote:
> >
> >> >  /* global flag to enable extra checks when accessing packed objects */
> >> > -extern int do_check_packed_object_crc;
> >> > +int do_check_packed_object_crc;
> >> 
> >> ... removing this 'extern' on an int variable sends 'sparse'
> >> into a frenzy of warnings! :-D
> >> 
> >> [You didn't use a global s/extern// by any chance?]
> >
> > Oh my. I did look at each one, but probably via replace-and-confirm in
> > vim. I don't know how I managed to botch that one so badly.
> 
> In any case, I think I have a correct SQUASH??? immediately on top
> of this step queued.  If there is nothing else needed, I think we
> are ready to squash that in and merge the whole thing to 'next'.

Yes, your squash looks good, and I don't think there were any other
unaddressed comments. Thanks for fixing my bug.

-Peff
