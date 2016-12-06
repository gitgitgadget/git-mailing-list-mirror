Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522971FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 20:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbcLFU05 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 15:26:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:52723 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbcLFU04 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 15:26:56 -0500
Received: (qmail 12409 invoked by uid 109); 6 Dec 2016 20:26:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 20:26:51 +0000
Received: (qmail 17275 invoked by uid 111); 6 Dec 2016 20:27:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 15:27:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 15:26:50 -0500
Date:   Tue, 6 Dec 2016 15:26:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Patey <matthew.patey2167@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] stash: disable renames when calling git-diff
Message-ID: <20161206202649.kqpm3daiucs7zcdr@sigill.intra.peff.net>
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
 <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
 <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
 <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
 <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net>
 <xmqqh96g27bh.fsf@gitster.mtv.corp.google.com>
 <20161206193154.vf7cd7lk5gyxrra5@sigill.intra.peff.net>
 <xmqqd1h425vv.fsf@gitster.mtv.corp.google.com>
 <20161206201130.azfmqvtk3iettlx7@sigill.intra.peff.net>
 <xmqq37i024fy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37i024fy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 12:22:25PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think you are right that diff-index could work, though. I always
> > forget that without "--cached", diff-index looks at the working tree
> > files.
> 
> I'll reword the log message while queuing.  It was super surprising
> to me to hear that there was something "git diff" did that three
> "git diff-*" plumbing brothers couldn't do at the basic "what to
> compare with what" level, as I wrote all four ;-)

Oops, our emails just crossed; I just sent a revised patch.

I know there are a few cases that git-diff can handle that the others
can't, but I think they are all direct blob-to-blob comparisons.

-Peff
