Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D858D20954
	for <e@80x24.org>; Thu, 23 Nov 2017 05:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750751AbdKWFCR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 00:02:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:38400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750707AbdKWFCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 00:02:17 -0500
Received: (qmail 20039 invoked by uid 109); 23 Nov 2017 05:02:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Nov 2017 05:02:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6972 invoked by uid 111); 23 Nov 2017 05:02:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 23 Nov 2017 00:02:33 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Nov 2017 00:02:15 -0500
Date:   Thu, 23 Nov 2017 00:02:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] p5550: factor our nonsense-pack creation
Message-ID: <20171123050214.GB22218@sigill>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
 <20171120202643.s2cywlqykayq5qdb@sigill.intra.peff.net>
 <CAPig+cRDNmjmM2Ed+mwqf7JZ76CxA3Eh7-UV6k=LFngZ3YE_sQ@mail.gmail.com>
 <20171121155815.46ih4ld4cp7n544l@sigill.intra.peff.net>
 <CAGZ79kbNQCzmkQDFY+gxEuZDPziehZdhgReCzpk3oxn=fpv=UQ@mail.gmail.com>
 <20171122223817.GB1405@sigill>
 <xmqqlgixra22.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgixra22.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 11:41:25AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Right, I came to the same conclusion (we may even have discussed this on
> > the list, I don't remember). The current "todo" format says that only
> > the command and sha1 matter, and we'd be changing that. Maybe that's not
> > so bad if the user has to enable the feature themselves (and clearly it
> > would be incompatible with a custom format option).
> 
> If you are in the habit of always writing 4 or more lines, the
> chance that you would make a typo on the line you can correct in the
> "todo" list with such a feature is at most 25% ;-).

You'd think, but the distribution of typos doesn't seem to be uniform.
:)

I think what actually happens is that I quite often do my final
proofread in my MUA, where the subject is displayed apart from the rest
of the message. So I tend to gloss over it, and any errors there are
more likely to make it to the list.

> I think one downside is that a mere presence of such an option hints
> that we somehow encourage people to commit with a title-only message.

Yeah, though it might be handy for me I think it just opens up too many
funny questions like this.

-Peff
