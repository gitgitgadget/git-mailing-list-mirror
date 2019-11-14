Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91B31F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 07:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfKNHhX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 02:37:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:47194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725965AbfKNHhX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 02:37:23 -0500
Received: (qmail 22685 invoked by uid 109); 14 Nov 2019 07:37:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Nov 2019 07:37:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1723 invoked by uid 111); 14 Nov 2019 07:40:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 02:40:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 02:37:21 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] builtin/config: canonicalize "value_regex" with
 `--type=bool[-or-int]`
Message-ID: <20191114073721.GA17186@sigill.intra.peff.net>
References: <cover.1573670565.git.martin.agren@gmail.com>
 <20191114062900.GD10643@sigill.intra.peff.net>
 <CAN0heSrtwi9V607vBX9PMSfNLQ8iGcno6_iGuR4Fs8ndGxqh8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrtwi9V607vBX9PMSfNLQ8iGcno6_iGuR4Fs8ndGxqh8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 07:54:35AM +0100, Martin Ågren wrote:

> > > The last patch is not meant for immediate inclusion, but I post it
> > > anyway. I can re-submit it at an appropriate time, or maybe it could
> > > slumber on pu until the time is ripe for completing the switch.
> >
> > I think bailing on values that can't be converted is normal for other
> > code paths. E.g., just trying to print:
> >
> >   $ git -c foo.bar=abc config --type=bool foo.abr
> >   fatal: bad numeric config value 'abc' for 'foo.bar': invalid unit
> 
> I'm not sure if you mean "... so we could be a lot more aggressive
> here"?

Yeah, I think it's OK to be aggressive with bailing when the user gave
us a --type, but the value doesn't match it.

> I'm running now and I feel like I'll need to read your mail again
> tonight and get back to you in more detail.

Sure, no rush and thanks for working on it. :)

-Peff
