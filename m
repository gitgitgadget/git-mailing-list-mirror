Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472391F731
	for <e@80x24.org>; Mon,  5 Aug 2019 21:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfHEVPU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 17:15:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:34612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729383AbfHEVPT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 17:15:19 -0400
Received: (qmail 9386 invoked by uid 109); 5 Aug 2019 21:15:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Aug 2019 21:15:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28945 invoked by uid 111); 5 Aug 2019 21:17:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Aug 2019 17:17:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Aug 2019 17:15:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2] l10n: reformat some localized strings for v2.23.0
Message-ID: <20190805211517.GA359@sigill.intra.peff.net>
References: <20190730033512.7226-1-worldhello.net@gmail.com>
 <20190803195907.3124-1-jn.avila@free.fr>
 <20190803234522.GA5417@sigill.intra.peff.net>
 <xmqqv9vbmoqd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9vbmoqd.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 05, 2019 at 11:49:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>  		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
> >> -			   N_("where the checkout from")),
> >> +			   N_("where the checkout is from")),
> >
> > I think your original "where to checkout from" is better.
> 
> Would we even want to do s/where/which tree-ish/?

Yeah, I think that is even better.

> > prefix. For advise() we nicely pick out the newlines and prefix each
> > line individually, but warning(), error(), etc, don't do that. Maybe
> > they should.
> 
> Yeah, I'd be surprised that nobody thought of doing that, so perhaps
> somebody tried and failed with a possible fallout.  I do not offhand
> see any downside of teaching them to do the prefixing.

I know we've discussed it before, but a quick search of the archive only
came up with instances of me suggesting we should do it. ;)

Besides the obvious fallout you mentioned where callers might need to
drop their own custom indenting, it's possible people might be less
happy for output like:

  warning: a thing happened to these paths:
          foo
	  bar

where people might prefer not having a prefix on the subsequent lines,
because it makes it easier to cut-and-paste.

Anyway, that is all out of scope for this patch.

-Peff
