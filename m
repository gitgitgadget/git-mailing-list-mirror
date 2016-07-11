Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D15D1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 16:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934211AbcGKQsi (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 12:48:38 -0400
Received: from imap.thunk.org ([74.207.234.97]:46242 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932265AbcGKQsg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 12:48:36 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=59zjz73SFplISOi6owZ6yIFCsY7PcE4Sm43rv7dgvrw=;
	b=dKtouZHHxvr9QC0f0g/wNIjpfZrsNhsj7++UMoYw/6nXKPXdcG5Nu9T3gAUQHEDTSCZSvLooA/MBtMkSPCUwBYeL9UaRLZlz8h4CvtzQbOcxBfIDPCR9FgcUKJg8CVIFGtI7w9W/Goe6NCtcihM0ODQR4kHo5i/J5bx7uLLf4ys=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bMeNn-0007Z3-2c; Mon, 11 Jul 2016 16:48:35 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 540D5828F74; Mon, 11 Jul 2016 12:48:34 -0400 (EDT)
Date:	Mon, 11 Jul 2016 12:48:34 -0400
From:	Theodore Ts'o <tytso@mit.edu>
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] doc/pretty-formats: describe index/time formats for
 %gd
Message-ID: <20160711164834.GC3890@thunk.org>
References: <20160711050201.GA18031@sigill.intra.peff.net>
 <20160711050513.GC32514@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160711050513.GC32514@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 01:05:13AM -0400, Jeff King wrote:
> The "reflog selector" format changes based on a series of
> heuristics, and that applies equally to both stock "log -g"
> output, as well as "--format=%gd". The documentation for
> "%gd" doesn't cover this. Let's mention the multiple formats
> and refer the user back to the "-g" section for the complete
> rules.

Is it worth mentioning that the shortening only happens if the user
specifies a selector with '/' in it in the first place?  I was
confused when I was first playing with these selectors because %gd and
%gD are identical if you run

	git reflog --format=%gd -3 master
	git reflog --format=%gD -3 master

and are only different if you run:

	git reflog --format=%gd -3 refs/heads/master
	git reflog --format=%gD -3 refs/heads/master

					- Ted
					
