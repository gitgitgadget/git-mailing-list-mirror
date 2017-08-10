Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01151F667
	for <e@80x24.org>; Thu, 10 Aug 2017 23:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbdHJXKl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 19:10:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:35538 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752440AbdHJXKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 19:10:41 -0400
Received: (qmail 1774 invoked by uid 109); 10 Aug 2017 23:10:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 23:10:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11562 invoked by uid 111); 10 Aug 2017 23:11:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:11:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 19:10:39 -0400
Date:   Thu, 10 Aug 2017 19:10:39 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
Message-ID: <20170810231038.4s2btsotoq76atuu@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
 <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net>
 <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
 <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
 <CAP8UFD08oyY9eK-0Ydm2qh2etvc2_QGc0ujNswGUgUumwhy4+w@mail.gmail.com>
 <20170810211039.okpwglvcmkngzri2@sigill.intra.peff.net>
 <98b14604-33f1-6d91-8c9e-ddfa0c5cb0e7@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98b14604-33f1-6d91-8c9e-ddfa0c5cb0e7@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 12:02:49AM +0100, Ramsay Jones wrote:

> > But some of those things are not 1:1 mappings with normalization.  For
> > instance, --json presumably implies --only-trailers. Or are we proposing
> > to break the whole commit message down into components and output it all
> > as json?
> 
> Hmm, to me the operation wasn't so much a normalization, rather
> it was an --unfold (or maybe --un-fold ;-D). I suppose going in
> the other direction could be --fold=72, or some such.

But I really don't want callers to think of it as "unfold". I want it to
be "turn this into something I can parse simply". Hence if we were to
find another case where the output is irregular, I'd feel comfortable
calling that a bug and fixing it (one that I suspect but haven't tested
is that alternate separators probably should all be converted to
colons).

> [blue is my favourite colour ... :-P ]

Yes, I'm feeling that, too. :-/

-Peff
