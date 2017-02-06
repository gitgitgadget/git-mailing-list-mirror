Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531B41FC47
	for <e@80x24.org>; Mon,  6 Feb 2017 15:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbdBFPUS (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 10:20:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:49765 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbdBFPUR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 10:20:17 -0500
Received: (qmail 8973 invoked by uid 109); 6 Feb 2017 15:20:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 15:20:16 +0000
Received: (qmail 13769 invoked by uid 111); 6 Feb 2017 15:20:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 10:20:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 16:20:13 +0100
Date:   Mon, 6 Feb 2017 16:20:13 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 5/5] stash: teach 'push' (and 'create') to honor
 pathspec
Message-ID: <20170206152013.4qv6734jcdnuvekt@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-6-t.gummerer@gmail.com>
 <xmqqmvdz3ied.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvdz3ied.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2017 at 11:09:14PM -0800, Junio C Hamano wrote:

> > @@ -99,6 +104,10 @@ create_stash () {
> >  	if test -z "$new_style"
> >  	then
> >  		stash_msg="$*"
> > +		while test $# != 0
> > +		do
> > +			shift
> > +		done
> >  	fi
> 
> The intent is correct, but I would probaly empty the "$@" not with
> an iteration of shifts but with a single
> 
> 	set x && shift
> 
> ;-)

Perhaps it is not portable, but I think "set --" does the same thing and
is perhaps less obscure.

-Peff
