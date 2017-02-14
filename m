Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F121FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 00:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbdBNA15 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 19:27:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:54650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdBNA14 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 19:27:56 -0500
Received: (qmail 19756 invoked by uid 109); 14 Feb 2017 00:27:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 00:27:56 +0000
Received: (qmail 30177 invoked by uid 111); 14 Feb 2017 00:27:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 19:27:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 19:27:53 -0500
Date:   Mon, 13 Feb 2017 19:27:53 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/5] stash: support pathspec argument
Message-ID: <20170214002753.362zfb75xmvwvz6f@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net>
 <20170212193050.GA652@hank>
 <vpq7f4uxjmo.fsf@anie.imag.fr>
 <20170213200950.m3bcyp52wd25p737@sigill.intra.peff.net>
 <vpqo9y5lqos.fsf@anie.imag.fr>
 <20170213214521.pkjesijdlus36tnp@sigill.intra.peff.net>
 <20170213223346.GD652@hank>
 <xmqqwpctabvw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpctabvw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 03:50:43PM -0800, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >> My "-p" suggestion suffers from a similar problem if you treat it as
> >> "you can omit the 'push' if you say "-p", rather than "if -p is the
> >> first option, it is a synonym for 'push -p'".
> >
> > I'm almost convinced of special casing "-p".  (Maybe I'm easy to
> > convince as well, because it would be convenient ;) ) However it's a
> > bit weird that now "git stash -p file" would work, but "git stash -m
> > message" wouldn't.
> 
> I am not sure why this matters.  The original "git stash <msg>" was
> just "Are you being extremely busy and cannot even afford to type
> 'save'?  Ok, let me assume you meant that!".  Now we are talking
> about picking and choosing hunks carefully going through interactive
> process, I really do not think there is any justification to infer
> 'push' when 'push' was omitted in "git stash push -p" the user wants
> to do.

Maybe it is just me and my muscle memory, but "git stash -p" is quite a
common command for me[1]. And I have typed "git stash -p foo" many times
and been annoyed that it didn't work. I was hoping to end that
annoyance.

I guess I could make an alias and retrain my fingers.

-Peff

[1] I almost never run "reset --hard", preferring instead to stash away
    changes just in case I would change my mind later and want them. And
    I quite often use "stash -p" because I like to double check what I
    am throwing away.

    I also use "stash -p" heavily when picking apart changes from the
    working tree.
