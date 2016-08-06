Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC97A1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbcHFUW2 (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:22:28 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:56811 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbcHFUW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:22:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 5A8CB462F96;
	Sat,  6 Aug 2016 17:46:15 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N23JGXslUocr; Sat,  6 Aug 2016 17:46:13 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id BE61F462F49;
	Sat,  6 Aug 2016 17:46:12 +0100 (BST)
Date:	Sat, 6 Aug 2016 17:45:54 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	dborowitz@google.com, Michael Haggerty <mhagger@alum.mit.edu>,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160806164554.GA24211@salo>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
 <20160805115911.GA4787@salo>
 <alpine.DEB.2.20.1608051714110.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608051714110.5786@virtualbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 05, 2016 at 05:24:14PM +0200, Johannes Schindelin wrote:
[snip]
> > 
> > This "unified review storage format" really does seem to be the missing
> > piece.
> 
> FWIW I do not think so. The real trick will be to come up with an
> improvement to the process that lets Junio and Peff continue to work as
> before, because It Works For Them, while at the same time letting other
> people (such as myself) use easy-to-configure tools that add substantial
> convenience.
> 
> Which, to me, means that the missing piece is a clever idea how to
> integrate with the mail-based process, without requiring everybody and her
> dog to switch to a specific mail client.

Fair enough, yes it seems to me that git's own review process
is probably a separate discussion.

As far as review tools such as git-appraise, git-series and git-candidate
are concerned, the review storage format really is the missing piece though,
in my opinion,
at least if we want to live in a world with compatible review tooling.

> 
> > The tool I've been working on for the past year (git-candidate) was
> > initially aimed at contrib[1], and was written in perl solely to satisfy
> > contrib rules. It would have been python otherwise.
> 
> Oh...?
> 
> $ git ls-files contrib/\*.py | wc -l
> 4
> 
> And for that matter:
> 
> $ git ls-files contrib/\*.go | wc -l
> 4

I read this guide[1] before I started, and wanted to be on the safe side.
Maybe that was a mistake... :/

> 
> In fact, there are even PHP scripts:
> 
> $ git ls-files contrib | sed -n 's/.*\.//p' | sort | grep -v '.....' |
> 	uniq | tr '\n' ' '
> bash c el Git go perl php pl pm py rst sh tcsh txt zsh
> 
> But again, I do not think that it makes sense to focus too much on a
> language, or on a file format, before we came up with a strategy how to
> *not* require everybody to change their current ways.

Fair enough. :)

Thanks,
Richard Ipsum

[1]: https://www.kernel.org/pub/software/scm/git/docs/howto/new-command.html
