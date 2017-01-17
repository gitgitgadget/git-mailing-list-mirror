Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7E620756
	for <e@80x24.org>; Tue, 17 Jan 2017 19:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbdAQTgn (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 14:36:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:40393 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdAQTgm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 14:36:42 -0500
Received: (qmail 20848 invoked by uid 109); 17 Jan 2017 19:36:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 19:36:42 +0000
Received: (qmail 20640 invoked by uid 111); 17 Jan 2017 19:37:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 14:37:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 14:36:39 -0500
Date:   Tue, 17 Jan 2017 14:36:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
Message-ID: <20170117193639.mt3x3md3nbh2qgws@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
 <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox>
 <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701161746200.3469@virtualbox>
 <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
 <xmqqk29tfq79.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk29tfq79.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 11:20:58AM -0800, Junio C Hamano wrote:

> > Documentation/CodingGuidelines says:
> >
> >  - We avoid using braces unnecessarily.  I.e.
> >
> >         if (bla) {
> >                 x = 1;
> >         }
> >
> >    is frowned upon.  A gray area is when the statement extends
> >    over a few lines, and/or you have a lengthy comment atop of
> >    it.  Also, like in the Linux kernel, if there is a long list
> >    of "else if" statements, it can make sense to add braces to
> >    single line blocks.
> >
> > I think this is pretty clearly the "gray area" mentioned there. Which
> > yes, does not say "definitely do it this way", but I hope makes it clear
> > that you're supposed to use judgement about readability.
> 
> I always took "gray area" to mean "we do not have strong preference
> either way, i.e.
> 
>  * It is OK for you to write your new code in either style (the
>    usual "match existing style in surrounding code" applies,
>    obviously);
> 
>  * It is not OK for you to churn the codebase with a patch that only
>    changes existing code to flip between the two styles.

That was my general impression, too. But I seem to recall it was you in
a nearby thread saying that:

  if (foo)
	bar();
  else {
        one();
	two();
  }

was wrong. Maybe I misunderstood.

-Peff
