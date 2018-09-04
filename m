Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF3D1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeIEAaY (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:30:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:38836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726437AbeIEAaY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:30:24 -0400
Received: (qmail 27402 invoked by uid 109); 4 Sep 2018 20:03:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Sep 2018 20:03:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9602 invoked by uid 111); 4 Sep 2018 20:03:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Sep 2018 16:03:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Sep 2018 16:03:43 -0400
Date:   Tue, 4 Sep 2018 16:03:43 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] un-breaking pack-objects with bitmaps
Message-ID: <20180904200342.GC17481@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190701.GE30764@sigill.intra.peff.net>
 <8736uud0gq.fsf@evledraar.gmail.com>
 <20180831225558.GA22917@sigill.intra.peff.net>
 <20180901074145.GA24023@sigill.intra.peff.net>
 <CAGZ79kZtXOmKo-86x=x4Z+tA0uiSmy4ntX+U4aCUYSjy4_DVDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kZtXOmKo-86x=x4Z+tA0uiSmy4ntX+U4aCUYSjy4_DVDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 04, 2018 at 12:30:14PM -0700, Stefan Beller wrote:

> >   [1/4]: bitmap_has_sha1_in_uninteresting(): drop BUG check
> >
> >     The actual fix. This should get merged to next ASAP (or the original
> >     topic just reverted).
> >
> >   [2/4]: t5310: test delta reuse with bitmaps
> >
> >     I did this separately to give us flexibility to squash or merge
> >     quickly. But it does find Ævar's bug on a git without patch 1.
> >
> >   [3/4]: traverse_bitmap_commit_list(): don't free result
> >
> >     The original assert should have simply been useless, but it was the
> >     surprising behavior of this function that turned it into a bug.
> >
> >   [4/4]: pack-bitmap: drop "loaded" flag
> >
> >     And this is just an annoyance I ran into, which is a fallout from
> >     our conversion to using an allocated bitmap_index struct.
> 
> FWIW, the whole series is
> Reviewed-by: Stefan Beller <sbeller@google.com>
> I am sorry for suggesting the BUG() in the first place.

Heh. You only asked a question about the interface. I was the one who
was _supposed_ to be familiar with the code, and put in the actual
assertion. So if your suggestion was dumb, my response was doubly so. :)

-Peff
