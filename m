Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD1DF2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 09:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759606AbcHEJAy (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 05:00:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56562 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759464AbcHEJAs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 05:00:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C952018E;
	Fri,  5 Aug 2016 08:50:09 +0000 (UTC)
Date:	Fri, 5 Aug 2016 08:50:09 +0000
From:	Eric Wong <e@80x24.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160805085009.GA30906@starla>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
 <20160804201751.GA9592@starla>
 <alpine.DEB.2.20.1608051023560.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608051023560.5786@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

Agreed on all above points :>

> On Thu, 4 Aug 2016, Eric Wong wrote:
> > Of course, centralized systems are unacceptable to me;
> > and with that I'll never claim any network service I run
> > will be reliable :)
> 
> Hehehe. I guess that's why the public-inbox is backed by a Git
> repository... BTW is it auto-mirrored anywhere?

Yep, and the code is AGPL so others can always replicate it.

I just have the onions mentioned at the bottom of the HTML pages
running something like:

	torsocks git fetch && public-inbox-index && sleep 30

in a loop[1].

	http://hjrcffqmbrq6wope.onion/git
	http://czquwvybam4bgbro.onion/git

I do encourage anybody who is able to, to run their own mirrors
(off their existing email subscription) so my MX doesn't become
an SPOF, either.  I sorta documented it in my original announcement:

https://public-inbox.org/git/20160710004813.GA20210@dcvr.yhbt.net/
https://public-inbox.org/INSTALL

Feel free to ask me (+ meta@public-inbox.org) for
install/running questions related to public-inbox
(haven't gotten to making it work outside of Debian stable, though).

[1] one of my far-off goals for git be: "git fetch --wait-for-update"
    to avoid needless wakeups
