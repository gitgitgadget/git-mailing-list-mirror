Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 16928 invoked by uid 107); 21 Feb 2010 20:32:43 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 15:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0BUUcO (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 15:32:14 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:44162 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0BUUcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 15:32:13 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 9CF70822195; Sun, 21 Feb 2010 15:32:12 -0500 (EST)
Date:	Sun, 21 Feb 2010 15:32:12 -0500
From:	Larry D'Anna <larry@elder-gods.org>
To:	Andrew Benton <b3nton@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Configuring git to for forget removed files
Message-ID: <20100221203212.GA10876@cthulhu>
References: <4B7FBB73.70004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B7FBB73.70004@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

* Andrew Benton (b3nton@gmail.com) [100220 05:37]:
> Hello world
> I have a project that I store in a git repository. It's a bunch of source tarballs and
> some bash scripts to compile it all. Git makes it easy to distribute any changes I make
> across the computers I run. The problem I have is that over time the repository gets ever
> larger. When I update to a newer version of something I git rm the old tarball but git
> still keeps a copy and the folder grows ever larger. At the moment the only solution I
> have is to periodically rm -rf .git and start again. This works but is less than ideal
> because I lose all the history for my build scripts.
> What I would like is to be able to tell git to not keep a copy of anything that has been
> git rm. The build scripts never get removed, only altered so their history would be
> preserved. Is it possible to make git delete its backup copies of removed files?

This reminds me of a scenario I wish git had some way of supporting: I have a
large collection of mp3s that I have duplicated across several computers.  I
would love to be able to use git to sync changes between the copies, but there
are several problems: 

1) git is really slow when dealing with thousands of multi-megabyte blobs.

2) commiting it to git is going to double the size of the directory, and I don't
really have space for that on one of the computers that the directory lives on.

3) there's no way to discard old history without breaking push and pull.

I'm not sure exactly what it would take to address 1, but 2 could be addressed
pretty easily using btrfs file clones (once btrfs is stable), and 3 could be
dealt with by improving support for shallow clones.

     --larry

