Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548781F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeIQXuo (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 19:50:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:51144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727052AbeIQXun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 19:50:43 -0400
Received: (qmail 14951 invoked by uid 109); 17 Sep 2018 18:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Sep 2018 18:22:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14763 invoked by uid 111); 17 Sep 2018 18:22:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Sep 2018 14:22:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2018 14:22:11 -0400
Date:   Mon, 17 Sep 2018 14:22:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
Message-ID: <20180917182210.GB3894@sigill.intra.peff.net>
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DXT8rF_WYE3C0ak7E8_8j=kRS+Yhi1pZjKd5Rr4OsM_A@mail.gmail.com>
 <20180917023912.GC22024@sigill.intra.peff.net>
 <xmqqo9cw6mhk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo9cw6mhk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 10:51:35AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> >  What's the donness of this one?
> >> >  cf. <20180717201348.GD26218@sigill.intra.peff.net>
> >> 
> >> This topic has stayed in 'pu' for a long time. I thought it was
> >> concluded that this was a good change? Jeff, Jonathan?
> >
> > I read over the thread again. I don't think I actually have any
> > complaints about the patches as-is. There was some discussion from Junio
> > and Ævar about the third one. I don't have a strong opinion. My
> > experience has been that "gc --auto" is garbage anyway on the server
> > side, but I think Ævar's experience is that it's reasonable for small to
> > medium sites (which seems plausible to me).
> >
> > The message-id quoted there is my "this looks good". I mentioned a few
> > possible nits, but I think it would be OK with or without them
> > addressed.
> 
> That matches my reading of your position.  I tend to agree with
> Ævar's recommendation to postpone 3/3 and use 1 & 2 for now.

Let me inject some more uncertainty, then. ;)

If we are not going to do 3/3, then should 2/3 simply avoid passing "-1"
back via return from main? I guess I don't have a strong opinion, but
one of the things I noted was that we converted those die() calls
introduced in 2/3 back into returns in 3/3. Do we want to leave it in
the state where we are calling die() a lot more?

-Peff
