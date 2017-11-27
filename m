Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C0D20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 05:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750773AbdK0FAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:00:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:41064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750726AbdK0FAd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:00:33 -0500
Received: (qmail 26325 invoked by uid 109); 27 Nov 2017 05:00:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 05:00:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32767 invoked by uid 111); 27 Nov 2017 05:00:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 00:00:51 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 00:00:31 -0500
Date:   Mon, 27 Nov 2017 00:00:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171127050031.GA6858@sigill>
References: <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
 <xmqq7eudidqb.fsf@gitster.mtv.corp.google.com>
 <20171127044314.GA6236@sigill>
 <xmqqd144e2uu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd144e2uu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 01:56:41PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I actually consider "--no-optional-locks" to be such an aspirational
> > feature. I didn't go digging for other cases (though I'm fairly certain
> > that "diff" has one), but hoped to leave it for further bug reports ("I
> > used the option, ran command X, and saw lock contention").
> 
> OK, then we are essentially on the same page.  I just was hoping
> that we can restrain ourselves from adding these "non essential"
> knobs at too fine granularity, ending up forcing end users to use
> all of them.

Yes, I agree we should try not to have too many knobs. That's actually
one of the reasons I avoided a status-only option in the first place.

In retrospect, I agree that the current option probably doesn't get the
granularity quite right. The idea of "totally read-only" just didn't
cross my mind at all when working on the earlier feature.

-Peff
