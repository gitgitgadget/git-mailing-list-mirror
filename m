Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F7C1F859
	for <e@80x24.org>; Wed, 10 Aug 2016 00:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcHJAqN (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 20:46:13 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43121 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbcHJAqM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 20:46:12 -0400
Received: from x (unknown [IPv6:2605:e000:d5ce:1e00:c5f5:b7bf:c731:5d3f])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 6C747172095;
	Wed, 10 Aug 2016 02:46:03 +0200 (CEST)
Date:	Tue, 9 Aug 2016 14:46:01 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160810004601.galhjhge3kld6ebe@x>
References: <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
 <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
 <6adc480d-15e3-c0ac-0e05-eb10c767a8ab@drmicha.warpmail.net>
 <20160809105705.pyzr7be3gvzw2pid@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160809105705.pyzr7be3gvzw2pid@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 06:57:05AM -0400, Jeff King wrote:
> On Tue, Aug 09, 2016 at 10:11:30AM +0200, Michael J Gruber wrote:
> 
> > Maybe two more points of input for the discussion:
> > 
> > off-line capabilities
> > =====================
> > 
> > The current workflow here seems to work best when you are subscribed to
> > the git-ml and have your own (local, maybe selective) copy of git-ml in
> > your (text-based) MUA (mutt, (al)pine, emacs, ...) that can jump right
> > into git-am and such directly. I'm not sure how important the "off-line"
> > aspect of that is for some of us, and how that could be replicated on
> > GitHub - while PRs and such may be Git based behind the scenes there
> > seems to be no way to clone that info and work from a local clone.
> > (Don't know if GitLab is more open.)
> 
> You can pull it all out via GitHub's HTTP API, but the question is what
> format you would use to store it locally (and which tools you would then
> use to play with it).
> 
> I haven't really tried this lately, though, so I don't know if there is
> information that the API would be missing.
> 
> I do have a dream of writing a tool that sucks in GitHub PRs to a fake
> email thread, lets me make my responses inline in an editor, and then
> pushes it back up as PR comments (finding the right positions based on
> the quoted context).

You might try https://github.com/joeyh/github-backup
