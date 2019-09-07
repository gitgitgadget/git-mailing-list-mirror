Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C001F461
	for <e@80x24.org>; Sat,  7 Sep 2019 06:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404318AbfIGGpK (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 02:45:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:42824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392638AbfIGGpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 02:45:10 -0400
Received: (qmail 28418 invoked by uid 109); 7 Sep 2019 06:45:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 06:45:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9898 invoked by uid 111); 7 Sep 2019 06:46:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 02:46:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 02:45:08 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190907064508.GC28860@sigill.intra.peff.net>
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
 <cover.1567534373.git.martin.agren@gmail.com>
 <20190904032609.GD28836@sigill.intra.peff.net>
 <CAN0heSpbRvNG9okz5pqkHqDMB2BM5T+FzAbaK3sVwzGC6fjpPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpbRvNG9okz5pqkHqDMB2BM5T+FzAbaK3sVwzGC6fjpPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 09:35:10PM +0200, Martin Ågren wrote:

> > > do also think it makes sense to first make the "softer" switch to
> > > Asciidoctor-by-default and get that particular hurdle behind us. Then,
> > > once we're ok with dropping AsciiDoc entirely, we can do the switch to
> > > an Asciidoctor-only toolchain.
> >
> > Yeah, I do still like that as an endgame, but I like what you have here
> > as an intermediate step in the right direction.
> 
> Hmm, so this sounds like once I am happy with replacing AsciiDoc with
> Asciidoctor 1(.5.5), I should rather not propose a series "let's default
> to Asciidoctor!!!" but instead a slightly more careful "go with
> Asciidoctor, but document that we work badly with v2 and that the 2nd
> choice after Asciidoctor 1 should be AsciiDoc". Or do you see it
> differently? (I wonder which Asciidoctor-version Junio would be on..)

Yeah, that seems reasonable.

TBH, if making things in the middle step work turns out to be too hard,
I'm not entirely opposed to a hard switch.

The "does not work with 2.0" thing has to be a temporary step, though, I
think, since using the older versions will get harder and harder as time
goes on. I think it's OK to take such a temporary step as long as we
understand where it leads (and presumably its to directly generating the
roff with asciidoctor). The middle step of having asciidoctor+xmlto
helps us understand and isolate which changes are responsible for which
parts of the output.

-Peff
