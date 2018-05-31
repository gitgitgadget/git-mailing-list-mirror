Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CED2F1F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeEaFoy (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:44:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:57426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751037AbeEaFoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:44:54 -0400
Received: (qmail 12569 invoked by uid 109); 31 May 2018 05:44:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 05:44:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9394 invoked by uid 111); 31 May 2018 05:45:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 01:45:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 01:44:52 -0400
Date:   Thu, 31 May 2018 01:44:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
Message-ID: <20180531054451.GB17344@sigill.intra.peff.net>
References: <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
 <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
 <20180525024002.GA1998@sigill.intra.peff.net>
 <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com>
 <xmqq1sdzno3g.fsf@gitster-ct.c.googlers.com>
 <20180529212029.GB7964@sigill.intra.peff.net>
 <20180529212142.GA8767@sigill.intra.peff.net>
 <xmqq7enlg8ov.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7enlg8ov.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 11:48:32AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> -		if (list) {
> >> -			warning("the '-l' option is an alias for '--create-reflog' and");
> >> -			warning("has no effect in list mode. This option will soon be");
> >> -			warning("removed and you should omit it (or use '--list' instead).");
> >> -		} else {
> >> -			warning("the '-l' alias for '--create-reflog' is deprecated;");
> >> -			warning("it will be removed in a future version of Git");
> >> -		}
> >> -	}
> >> -
> >
> > Oh, and did we want to mark these for translation on the step 0 branch?
> > Obviously that would impact this hunk.
> 
> I was hoping that we can settle the "multi-line message translation
> that can potentially result in different number of lines" issue
> before we have to mark the above for translation ;-)

Yeah, right after saying that I realized it would create horrible
translation-lego. I agree we should punt for now.

-Peff
