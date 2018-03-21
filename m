Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6C71F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 06:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeCUGuI (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 02:50:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:37094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751317AbeCUGuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 02:50:07 -0400
Received: (qmail 31952 invoked by uid 109); 21 Mar 2018 06:50:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 06:50:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7522 invoked by uid 111); 21 Mar 2018 06:51:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 02:51:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 02:50:05 -0400
Date:   Wed, 21 Mar 2018 02:50:05 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH] doc/gitattributes: mention non-recursive behavior
Message-ID: <20180321065005.GB16784@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net>
 <20180320041454.GA15213@sigill.intra.peff.net>
 <CACsJy8CpwtNfp9oQGvECBuWGcwLEKK609iPJVEiXH4cDD6mpEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CpwtNfp9oQGvECBuWGcwLEKK609iPJVEiXH4cDD6mpEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 05:41:52PM +0100, Duy Nguyen wrote:

> > +The rules by which the pattern matches paths are the same as in
> > +`.gitignore` files (see linkgit:gitignore[5]), with a few exceptions:
> > +
> > +  - negative patterns are forbidden
> 
> After 8b1bd02415 (Make !pattern in .gitattributes non-fatal -
> 2013-03-01) maybe we could use the verb "ignored" too instead of
> "forbidden"

Makes sense. The original is already in 'next', so do you want to send
an incremental patch?

> > +    pointless in an attributes file; use `path/**` instead)
> 
> We probably could do this internally too (converting "path/" to
> "path/**") but we need to deal with corner cases (e.g. "path" without
> the trailing slash, but is a directory). So yes, suggesting the user
> to do it instead may be easier.

Yeah, I almost suggested that, but I worried about those corner cases.
It seems like documenting the current behavior is the right first step
in any case.

One other maybe-difference I came across coincidentally today: you have
to quote the pattern in .gitattributes if it contains spaces, but not in
.gitignore. But that's more an artifact of the rest of the file syntax
than the pattern syntax (.gitignore has no other fields to confuse it
with).

-Peff
