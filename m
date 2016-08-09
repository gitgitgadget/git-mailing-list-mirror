Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200131FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 10:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbcHIKfA (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 06:35:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:51860 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751020AbcHIKe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 06:34:59 -0400
Received: (qmail 18678 invoked by uid 109); 9 Aug 2016 10:34:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 10:34:58 +0000
Received: (qmail 19283 invoked by uid 111); 9 Aug 2016 10:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 06:34:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 06:34:55 -0400
Date:	Tue, 9 Aug 2016 06:34:55 -0400
From:	Jeff King <peff@peff.net>
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160809103455.kf5qk7ignqbgbvbu@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <CACsJy8DeSv_ALHR+HrViEptgYCYhXu2ZczMmhzZfHGAwZumnzg@mail.gmail.com>
 <20160809091722.GA1983@salo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160809091722.GA1983@salo>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 10:17:22AM +0100, Richard Ipsum wrote:

> > In the very unlikely event that github is shut down, how do we get all
> > review comments out of it, assuming that we will use pull requests for
> > review?
> 
> For what it's worth this is exactly why I think it would be worthwhile for git
> to establish a common review format, services like Github/Gitlab could then
> start storing reviews and comments in the git repo rather than in a separate
> sql database.

I doubt that the "rather than" part will ever happen. Git does not make
a very good database, and certainly not when you want to do things that
cut across repositories (like, say, efficiently get all review comments
made by one user).

It would be nice to have a common interchange format, though. In theory
that could feed into (and out of) a more efficient representation on the
backend of the site. It doesn't _have_ to be git-based, but it would be
nice if it was.

Somebody asked elsewhere "what happens if GitHub goes away?". And the
answer is that you can already get all of that data out in a
programmatic way, via the API. But since there's no common interchange
format, you'd be stuck writing a conversion to whatever format your new
destination uses.

-Peff
