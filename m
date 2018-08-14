Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765211F404
	for <e@80x24.org>; Tue, 14 Aug 2018 14:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbeHNRem (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:34:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:54594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728978AbeHNRem (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:34:42 -0400
Received: (qmail 24312 invoked by uid 109); 14 Aug 2018 14:47:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 14:47:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22792 invoked by uid 111); 14 Aug 2018 14:47:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 10:47:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 10:47:12 -0400
Date:   Tue, 14 Aug 2018 10:47:12 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Contributor Summit planning
Message-ID: <20180814144711.GB3441@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net>
 <CACsJy8Dbf6+ZjLk0vgYvzhwweOdp+5QTno+ejoA-r2YYsdpzrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Dbf6+ZjLk0vgYvzhwweOdp+5QTno+ejoA-r2YYsdpzrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 04:30:09PM +0200, Duy Nguyen wrote:

> > I frequently using "git shortlog -ns" to see who is active (especially
> > coupled with "--since=".
> >
> > I also use "--no-merges", because it makes me look a lot better when
> > compared relatively to Junio. :)
> 
> --no-merges makes me number one. Not sure if I should laugh or cry :D

Since when? Junio still has everyone beat for all time, though of course
he cheats with easy ones like "update version field to v2.17.1". :)

I also sometimes look at "shortlog -ns --no-merges v2.17.0..v2.18.0" and
so on (i.e., each major release). I had a good run from about v2.10 to
v2.15, but I've been slipping since then.

> Going off topic a bit, can we count the number of topics of each
> contributor? I could do it by decorating git log with remote refs from
> Junio's repo and counting based on the two-letter prefix in the
> topic/ref name but that's too hacky. fyi Jeff you're up to  second
> position now with 34 topics (I'm unfortunately still the first with
> 38).

One problem there is that the prefixes are ambiguous (e.g., Jacob Keller
shares with me, and I think at least one other over the years). You
could look at the author of the tip commit, but that's not always right
(and in fact, counting just merged topics misses bug-fixes that get
applied directly on top of other people's topics). And of course there's
the notion that "topic" might be a documentation typo fix, or it might
be the entire range-diff program.

I think "surviving lines" is another interesting metric, though it also
has flaws (if I s/sha1/oid/ on your line, it becomes my line; even
though my change is useful and should be counted, it's probably not as
important as whatever the code was doing in the first place).

-Peff
