Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CDA0203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 09:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbcLJJA6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 04:00:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:54582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751670AbcLJJA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 04:00:58 -0500
Received: (qmail 1772 invoked by uid 109); 10 Dec 2016 09:00:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 09:00:57 +0000
Received: (qmail 25196 invoked by uid 111); 10 Dec 2016 09:01:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 04:01:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2016 04:00:55 -0500
Date:   Sat, 10 Dec 2016 04:00:55 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
Subject: Re: Any interest in 'git merge --continue' as a command
Message-ID: <20161210090054.w6qhmszcjkatjhm5@sigill.intra.peff.net>
References: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
 <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net>
 <xmqqshpwrjyz.fsf@gitster.mtv.corp.google.com>
 <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 09:49:13PM +1300, Chris Packham wrote:

> > There is nothing to "continue" in a stopped merge where Git asked
> > for help from the user, and because of that, I view the final "git
> > commit" as "concluding the merge", not "continuing".  "continue"
> > makes quite a lot of sense with rebase and cherry-pick A..B that
> > stopped; it concludes the current step and let it continue to
> > process the remainder.  So from that point of view, it somewhat
> > feels strange to call it "merge --continue", but it probably is just
> > me.
> 
> Yeah I did think that --continue wasn't quite the right word. git
> merge --conclude would probably be the most accurate.

I'd be against giving it a subtly-different name. It's just going to
frustrate people who cannot remember when to use "--conclude" and when
it is "--continue". The strength of the proposal, IMHO, is that it
abstracts the idea of "go on to the next thing or finish" across many
commands.

-Peff
