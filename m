Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96041F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeCTEkj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:40:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750768AbeCTEki (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:40:38 -0400
Received: (qmail 30737 invoked by uid 109); 20 Mar 2018 04:40:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 04:40:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29096 invoked by uid 111); 20 Mar 2018 04:41:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 00:41:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 00:40:36 -0400
Date:   Tue, 20 Mar 2018 00:40:36 -0400
From:   Jeff King <peff@peff.net>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation
 bug)
Message-ID: <20180320044036.GD13302@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net>
 <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 12:25:27AM -0400, Dakota Hawkins wrote:

> > Right. The technical reason is mostly "that is not how it was designed,
> > and it would possibly break some corner cases if we switched it now".
> 
> I'm just spitballing here, but do you guys think there's any subset of
> the combined .gitignore and .gitattributes matching functionality that
> could at least serve as a good "best-practices, going forward"
> (because of consistency) for both? I will say every time I do this for
> a new repo and have to do something even slightly complicated or
> different from what I've done before with .gitattributes/.gitignore
> that it takes me a long-ish time to figure it out. It's like I'm
> vaguely aware of pitfalls I've encountered in the past in certain
> areas but don't remember exactly what they are, so I consult the docs,
> which are (in sum) confusing and lead to more time spent
> trying/failing/trying/works/fails-later/etc.
> 
> One "this subset of rules will work for both this way" would be
> awesome even if the matching capabilities are technically divergent,
> but on the other hand that might paint both into a corner in terms of
> functionality.

As far as I know, they should be the same with the exception of this
recursion, and the negative-pattern thing. But I'm cc-ing Duy, who is
the resident expert on ignore and attributes matching (whether he wants
to be or not ;) ). I wouldn't be surprised if there's something I don't
know about.

So I think the "recommended subset" is basically "everything but these
few constructs". We just need to document them. ;)

I probably should cc'd Duy on the documentation patch, too:

  https://public-inbox.org/git/20180320041454.GA15213@sigill.intra.peff.net/

-Peff
