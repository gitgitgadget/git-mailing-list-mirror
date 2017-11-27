Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EEE20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdK0EnR (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:43:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:41002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdK0EnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:43:16 -0500
Received: (qmail 25475 invoked by uid 109); 27 Nov 2017 04:43:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 04:43:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32362 invoked by uid 111); 27 Nov 2017 04:43:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 26 Nov 2017 23:43:33 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Nov 2017 23:43:14 -0500
Date:   Sun, 26 Nov 2017 23:43:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171127044314.GA6236@sigill>
References: <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
 <xmqq7eudidqb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7eudidqb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 06:35:56PM +0900, Junio C Hamano wrote:

> Having a large picture option like "--read-only" instead of ending
> up with dozens of "we implemented a knob to tweak only this little
> piece, and here is an option to trigger it" would help users in the
> long run, but we traditionally did not do so because we tend to
> avoid shipping "incomplete" features, but being perfectionist with
> such a large undertaking can stall topics with feature bloat.  In a
> case like this, however, I suspect that an aspirational feature that
> starts small, promises little and can be extended over time may be a
> good way to move forward.

I actually consider "--no-optional-locks" to be such an aspirational
feature. I didn't go digging for other cases (though I'm fairly certain
that "diff" has one), but hoped to leave it for further bug reports ("I
used the option, ran command X, and saw lock contention").

I would be fine with having a further aspirational "read only" mode. As
I said before, that's not quite the same thing as no-optional-locks, but
I think they're close enough that I'd be fine having only one of them.
But now that we've shipped a version with the locking one, we're stuck
with at least for the duration of a deprecation cycle.

-Peff
