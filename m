Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4381F991
	for <e@80x24.org>; Fri,  4 Aug 2017 04:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdHDE7T (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 00:59:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:57656 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750899AbdHDE7T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 00:59:19 -0400
Received: (qmail 7190 invoked by uid 109); 4 Aug 2017 04:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Aug 2017 04:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24483 invoked by uid 111); 4 Aug 2017 04:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Aug 2017 00:59:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Aug 2017 00:59:11 -0400
Date:   Fri, 4 Aug 2017 00:59:11 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] tag: only respect `pager.tag` in list-mode
Message-ID: <20170804045911.rffpmrfqmy36r5l5@sigill.intra.peff.net>
References: <cover.1500321657.git.martin.agren@gmail.com>
 <cover.1501701128.git.martin.agren@gmail.com>
 <20170803192947.7x5tadwb7lxermdk@sigill.intra.peff.net>
 <CAN0heSpzg4jCMetyhdpQn2Zz7nDhv1X14SLQ26WvnRDe9NYCCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpzg4jCMetyhdpQn2Zz7nDhv1X14SLQ26WvnRDe9NYCCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 04, 2017 at 06:21:47AM +0200, Martin Ågren wrote:

> On 3 August 2017 at 21:29, Jeff King <peff@peff.net> wrote:
> > On Wed, Aug 02, 2017 at 09:40:48PM +0200, Martin Ågren wrote:
> >
> >> This is the third version of my attempt to make `pager tag` useful (v1
> >> at [1], v2 at [2]). Thanks to Junio and Peff for comments on v2.
> >
> > This looks good to me overall. One minor question from the interdiff:
> >
> >> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> >> index 8b2ffb1aa..9128ec5ac 100755
> >> --- a/t/t7006-pager.sh
> >> +++ b/t/t7006-pager.sh
> >> @@ -162,7 +162,7 @@ test_expect_success TTY 'git tag with no args defaults to paging' '
> >>  test_expect_success TTY 'git tag with no args respects pager.tag' '
> >>       # no args implies -l so this should page like -l
> >>       rm -f paginated.out &&
> >> -     test_terminal git -c pager.tag=no tag &&
> >> +     test_terminal git -c pager.tag=false tag &&
> >>       ! test -e paginated.out
> >>  '
> >
> > These should behave the same, right? So this is just a style/consistency
> > fix, not a bugfix?
> 
> Right. I realized I was using "false" everywhere else.  It wouldn't have hurt
> to exercise the config-parsing a tiny bit differently, but I assume that's
> already being done explicitly in some other test, so I went for consistency.

Right, that makes perfect sense. Thanks for confirming.

> Thanks for all the feedback and thoughts throughout the different versions
> of this series. It changed quite a bit since v1, so thanks a lot.

You're very welcome. I hope we see more patches from you in the future.
:)

-Peff
