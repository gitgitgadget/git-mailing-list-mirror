Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A77420195
	for <e@80x24.org>; Sat, 16 Jul 2016 01:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbcGPBYg (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 21:24:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:45785 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751080AbcGPBYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 21:24:35 -0400
Received: (qmail 23720 invoked by uid 102); 16 Jul 2016 01:24:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 21:24:35 -0400
Received: (qmail 20926 invoked by uid 107); 16 Jul 2016 01:24:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 21:24:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 21:24:31 -0400
Date:	Fri, 15 Jul 2016 21:24:31 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 04/12] check_everything_connected: use a struct with
 named options
Message-ID: <20160716012431.GB30820@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
 <20160715103039.GD19271@sigill.intra.peff.net>
 <xmqqfuran50r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuran50r.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 11:13:40AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The number of variants of check_everything_connected has
> > grown over the years, so that the "real" function takes
> > several possibly-zero, possibly-NULL arguments. We hid the
> > complexity behind some wrapper functions, but this doesn't
> > scale well when we want to add new options.
> 
> I was kind of embarrassed to admit that I wasn't even aware that
> things got this bad, so I took a look at the history to realize that
> "grown over the years" above is a bit misleading statement.  It is
> not like many people over the years were doing something like this.
> There are only two commits that brought in this pattern with poor
> design taste.

Heh. It is easy to lose sight of such things when it is not your primary
goal. You should see how horrible the code was that I wrote in my
original iteration, before I went back and did this refactoring. I am
embarrassed to have even written it in a rough draft. ;)

-Peff
