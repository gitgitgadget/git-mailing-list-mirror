Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494D01F453
	for <e@80x24.org>; Wed, 26 Sep 2018 20:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeI0DGg (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:06:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:60736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726453AbeI0DGg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:06:36 -0400
Received: (qmail 23275 invoked by uid 109); 26 Sep 2018 20:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 20:51:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22510 invoked by uid 111); 26 Sep 2018 20:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Sep 2018 16:51:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2018 16:51:48 -0400
Date:   Wed, 26 Sep 2018 16:51:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
Message-ID: <20180926205148.GA12340@sigill.intra.peff.net>
References: <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net>
 <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com>
 <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com>
 <20180926185812.GD30680@sigill.intra.peff.net>
 <xmqqtvmcjaxx.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbeQvLuH1nGPkf8hHbs49SmuPeme_XBdz7ek5fU5AZ9Zg@mail.gmail.com>
 <xmqqpnx0j9kn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnx0j9kn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 01:19:20PM -0700, Junio C Hamano wrote:

> >     /**
> >     Would we be open to consider another commenting style?
> 
> No.  You still cannot write */ in that comment section, for example,
> so you cannot do "plain text" still---that is not a great trade off
> to deviate from the common comment style used for other stuff.

We can do:

#if HEADER_DOC

Write anything here except #endif!

#endif /* HEADER_DOC */

But I actually think that is more jarring than a big comment (when I am
reading C code, I expect to see C-like things mostly.

I do agree with you that a true plain text file is nicer in terms of
freedom to format, etc. But IMHO the tradeoff is easily worth it to keep
the related content (function declarations and their documentation)
close together.

-Peff
