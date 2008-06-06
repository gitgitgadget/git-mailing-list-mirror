From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Fri, 6 Jun 2008 01:10:26 -0400
Message-ID: <20080606051026.GA18257@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net> <200806010241.51464.trast@student.ethz.ch> <20080605014618.GA27381@sigill.intra.peff.net> <7vprqw2t64.fsf@gitster.siamese.dyndns.org> <20080605085605.GA16624@sigill.intra.peff.net> <alpine.DEB.1.00.0806051126060.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 07:11:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4UEW-0003y7-0o
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 07:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbYFFFKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 01:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbYFFFKa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 01:10:30 -0400
Received: from peff.net ([208.65.91.99]:4823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbYFFFK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 01:10:29 -0400
Received: (qmail 30498 invoked by uid 111); 6 Jun 2008 05:10:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 06 Jun 2008 01:10:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jun 2008 01:10:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806051126060.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84021>

On Thu, Jun 05, 2008 at 11:28:53AM +0100, Johannes Schindelin wrote:

> We have a tradition of giving the users plenty of rope.
> 
> And I actually like having the power at my finger tips.  You would not 
> believe how I enjoyed using "git add -e" to commit the final version of 
> that very patch.

I looked at your patch, and here are my complaints (versus what Thomas
has been working on):

  1. You edit the whole diff, not just a hunk. Actually, I think this is
     probably not a big deal, as any decent editor lets you find the
     spot you're looking for pretty trivially.

  2. It's not integrated into the git-add--interactive loop at all. That
     is, I don't start out saying "I want to edit this diff." I look at
     the diff while staging with "git add -p" and say "Oops, I need to
     edit this hunk." So I think it is better implemented as an "e"
     option in the hunk adding loop, with "git add -e" as a shortcut.
     Or maybe there is simply room for both (and "git add -e", rather
     than being a shortcut, just means "do this on the _whole_ file").

-Peff
