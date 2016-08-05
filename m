Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB21B2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2998800AbcHEVBf (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:01:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59116 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2999216AbcHEVBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:01:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C047D2018E;
	Fri,  5 Aug 2016 21:01:29 +0000 (UTC)
Date:	Fri, 5 Aug 2016 21:01:29 +0000
From:	Eric Wong <e@80x24.org>
To:	Stefan Beller <sbeller@google.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160805210129.GA11991@starla>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
 <alpine.DEB.2.20.1608050925240.5786@virtualbox>
 <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> On Fri, Aug 5, 2016 at 1:20 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Yet another option would be to have a tool that integrates with the Git
> > repository of the Git mailing list represented by public-inbox.
> 
> So my first reaction to that would be: you could push you patches to
> that public inbox and it is translated to emails sent on your behalf.
> 
> Which is reinventing submitGit just in a more accessible language?

Maybe vger.kernel.org could open its submission (587) port like
Debian does.   Unfortunately, this hurts the ability to Cc:
folks directly and makes vger even more of an SPOF
(I guess submitGit also has this problem)

Fwiw, I have a public-inbox for my miscellaneous patch barf at
spew@80x24.org - https://80x24.org/spew/
http://ou63pmih66umazou.onion/spew/

I will throw up my untested/half-tested patches for various
projects so I can still access it across various NATs and
firewalls.

Using Tor for send-email often works (depending on which
blacklists the exit node is on), but is totally optional
(you'd expose your IP).

==> ~/bin/spew <==
#!/bin/sh
exec torsocks git send-email \
	--smtp-domain=80x24.org \
	--smtp-debug=1 \
	--smtp-server-port=submission \
	--smtp-server=80x24.org \
	--to ${DEST-spew@80x24.org} \
	--suppress-cc=all \
	"$@"


All: Feel free to use it for any Free Software projects, too;
or better yet, host your own :)
