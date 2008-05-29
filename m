From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Thu, 29 May 2008 14:58:08 -0400
Message-ID: <20080529185808.GA2140@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 29 20:59:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1nL6-00045m-Av
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 20:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbYE2S6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 14:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYE2S6L
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 14:58:11 -0400
Received: from peff.net ([208.65.91.99]:4906 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbYE2S6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 14:58:10 -0400
Received: (qmail 23175 invoked by uid 111); 29 May 2008 18:58:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 29 May 2008 14:58:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2008 14:58:08 -0400
Content-Disposition: inline
In-Reply-To: <200805291737.53291.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83237>

On Thu, May 29, 2008 at 05:37:51PM +0200, Thomas Rast wrote:

> You wrote:
> > Adds a new option 'e' to the 'add -p' command loop that lets you
> > discard or keep one hunk line at a time.  This is useful if there are
> > no unchanged lines in the middle of the hunk, so 's' will not work,
> > but you would still like to split it.
> 
> Any news on this?  I would greatly appreciate criticism if something
> is wrong or inadequate :-)

[please just repost the patch when issuing such gentle reminders -- it
saves the rest of us from digging it out of the archive]

I have often wanted to perform this operation, and your implementation
seems to work from my minimal testing (though I haven't looked closely
at the colorization implications).

But I find the interface a bit clunky. I would much rather get dumped in
my favorite editor, which happens to be quite fast at removing a subset
of lines. After editing, any lines remaining would be staged.

We would have to figure out what happens if lines are added or edited,
of course. It may be right to signal an error, or maybe there is some
other useful functionality that can come of that. I think other systems
have some diff-editing functionality (IIRC, cogito did). It is probably
worth looking at that for ideas.

-Peff
