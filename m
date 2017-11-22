Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D023220954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbdKVWiV (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:38:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:38102 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752191AbdKVWiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:38:19 -0500
Received: (qmail 5662 invoked by uid 109); 22 Nov 2017 22:38:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 22:38:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5283 invoked by uid 111); 22 Nov 2017 22:38:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 17:38:35 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 17:38:17 -0500
Date:   Wed, 22 Nov 2017 17:38:17 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] p5550: factor our nonsense-pack creation
Message-ID: <20171122223817.GB1405@sigill>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120202643.s2cywlqykayq5qdb@sigill.intra.peff.net>
 <CAPig+cRDNmjmM2Ed+mwqf7JZ76CxA3Eh7-UV6k=LFngZ3YE_sQ@mail.gmail.com>
 <20171121155815.46ih4ld4cp7n544l@sigill.intra.peff.net>
 <CAGZ79kbNQCzmkQDFY+gxEuZDPziehZdhgReCzpk3oxn=fpv=UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbNQCzmkQDFY+gxEuZDPziehZdhgReCzpk3oxn=fpv=UQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 04:32:42PM -0800, Stefan Beller wrote:

> > Heh, yes. I even fixed it once, but I have the funny habit of noticing
> > such typos while reading the "todo" list of "rebase -i" and fixing them
> > there. Which of course has no impact whatsoever on the commit. :-/
> 
> That happened to me a couple of times as well before.
> This sounds like a UX bug on first thought.
> 
> On second thought the text after the abbreviated hash can be
> user dependent IIRC, by setting some format option how to populate the
> rebase instruction sheet using log, so it would not be easy to take
> fixes from that line into the commit for a fixup.

Right, I came to the same conclusion (we may even have discussed this on
the list, I don't remember). The current "todo" format says that only
the command and sha1 matter, and we'd be changing that. Maybe that's not
so bad if the user has to enable the feature themselves (and clearly it
would be incompatible with a custom format option). But I think in the
end it probably just makes sense to retrain my expectation, and remember
to "reword" instead of "pick".

-Peff
