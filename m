From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 22:54:50 -0500
Message-ID: <20070201035450.GA2862@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home> <20070201030030.GA1979@coredump.intra.peff.net> <7vd54ur26u.fsf@assigned-by-dhcp.cox.net> <20070201032925.GA2505@coredump.intra.peff.net> <Pine.LNX.4.64.0701312238420.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 04:55:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCT2I-0005a6-D7
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 04:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbXBADyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 22:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbXBADyw
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 22:54:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4570 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161134AbXBADyw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 22:54:52 -0500
Received: (qmail 4148 invoked from network); 31 Jan 2007 22:54:49 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 31 Jan 2007 22:54:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jan 2007 22:54:50 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701312238420.3021@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38326>

On Wed, Jan 31, 2007 at 10:47:31PM -0500, Nicolas Pitre wrote:

> But this language convey the truth and users will have to get used to it 
> at some point. We should not hide the fact that HEAD is really detached at
> that point, otherwise it could be presumed that a commit might update the
> checked out (tracking) branch which is obviously not the case.

OK, so let's not lie about it, then. But that doesn't mean we can't
explain further. What about:

$ git checkout origin/pu
Detached your HEAD (based on remote origin/pu) -- you are not on any branch
...

Except that I think the line is getting a bit long. But the point is to
explain _why_ we're detached (you could even put a different note for
tags). If a user already knows that 'git checkout v1.4.4.4' is going to
put him in a detached state, then he doesn't really care about the
message one way or the other. But if he doesn't know (and there is no
clue on the command line, except for the fact that we already know
v1.4.4.4 is a tag and origin/pu is a remote tracking branch), then it
might make it more why it happened.

-Peff
