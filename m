Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ECE01F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI1ApC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:45:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:33858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727622AbeI1ApC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:45:02 -0400
Received: (qmail 7116 invoked by uid 109); 27 Sep 2018 18:25:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 18:25:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3457 invoked by uid 111); 27 Sep 2018 18:25:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 14:25:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 14:25:29 -0400
Date:   Thu, 27 Sep 2018 14:25:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: On shipping more of our technical docs as manpages
Message-ID: <20180927182528.GB2468@sigill.intra.peff.net>
References: <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net>
 <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com>
 <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com>
 <20180926185812.GD30680@sigill.intra.peff.net>
 <878t3oj8em.fsf@evledraar.gmail.com>
 <20180927062011.GA1318@sigill.intra.peff.net>
 <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 10:36:11AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If you're interested in pulling documentation out of the header files
> > and generating asciidoc from it, I'm happy to at least try keeping it up
> > to date. When we started putting this information into header files, we
> > used "/**" to start the comment, as a special marker to indicate it was
> > worth pulling out. I don't know how well we've maintained that
> > convention, but it's a starting point.
> 
> I noticed some people add these extra asterisk at the beginning of
> comment, but I do not recall that we declared it is a convention we
> adopt, so I'd rather be surprised if we've "maintained" it.

True. _I_ declared it as a convention and used it when I migrated some
of the initial api-* documents, but I don't know if anybody else
followed that lead.

FWIW, it is not my own convention, but one used by other tools like
doxygen (which in turn got it from javadoc, I think).

> Please have it in CodingGuidelines or somewhere once this thread
> settles and we decide to keep that convention (I have no problem
> with the convention; it is just I personally didn't think it was
> worth doing myself at least until now that we might have found
> somebody who wants to make use of the markings).

Yeah, this is basically why I hadn't pushed harder for it. If nobody is
actually extracting based on the convention, there is not much point. So
I was waiting for somebody to show up with an interest in using an
extraction tool.

-Peff
