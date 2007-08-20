From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax
	mean.
Date: Mon, 20 Aug 2007 02:37:33 -0400
Message-ID: <20070820063733.GA31201@coredump.intra.peff.net>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com> <20070820055221.GA22993@coredump.intra.peff.net> <20070820060522.GA27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0td-0003sz-8c
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 08:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbXHTGhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 02:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbXHTGhj
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 02:37:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1897 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058AbXHTGhh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 02:37:37 -0400
Received: (qmail 17540 invoked by uid 111); 20 Aug 2007 06:37:47 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Aug 2007 02:37:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2007 02:37:33 -0400
Content-Disposition: inline
In-Reply-To: <20070820060522.GA27913@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56179>

On Mon, Aug 20, 2007 at 02:05:22AM -0400, Shawn O. Pearce wrote:

> Oh, like say git-rebase.  During a rebase "theirs" (stage 3) is
> your file and "ours" (stage 2) is the upstream.  Confusing now,
> ain't it?  Mine is theirs and ours is theirs?  Huh?  Yeeaaaah.

Ugh, I hadn't even thought of that. git-diff _does_ respect "--base",
"--ours", and "--theirs" to mean the same thing, but I am now wondering
if that is a bit of a mistake.

However, as the intent of my patch was to _increase_ usability, I think
a gotcha like that is probably counterproductive. OTOH, users of
git-rebase already have to make the switch mentally.

> confusing the stages and getting them inverted.  And this is exactly
> why git-merge.sh/git-rebase.sh/git-am.sh try to setup GITHEAD_* for

Yes, I agree that the GITHEAD markers are much more sensible.
Unfortunately, I'm not sure of the best way to translate them into
stage names. The MERGE_HEAD/HEAD suggestion you made is a nice way of
avoiding the whole issue, though it doesn't easily provide the "base"
version.

> At least document the new syntax in git-rev-parse documentation?

I was about to, but your message has convinced me that this is perhaps
not a very good idea.

-Peff
