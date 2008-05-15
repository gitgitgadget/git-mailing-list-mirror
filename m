From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
	whitespace.
Date: Thu, 15 May 2008 07:20:30 -0400
Message-ID: <20080515112030.GA12781@sigill.intra.peff.net>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com> <20080428094119.GA20499@sigill.intra.peff.net> <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com> <20080513091143.GA26248@sigill.intra.peff.net> <e2b179460805131110k3cf582fdn9b8bd31046b90ca7@mail.gmail.com> <e2b179460805150316n77513037y5409042b01170d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 13:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwbWW-0001vO-Kb
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 13:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbYEOLUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 07:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbYEOLUd
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 07:20:33 -0400
Received: from peff.net ([208.65.91.99]:2356 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974AbYEOLUd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 07:20:33 -0400
Received: (qmail 24760 invoked by uid 111); 15 May 2008 11:20:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 May 2008 07:20:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2008 07:20:30 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460805150316n77513037y5409042b01170d4e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82199>

On Thu, May 15, 2008 at 11:16:27AM +0100, Mike Ralphson wrote:

> Which branch(es) would it be most useful on which to have this
> automated build/test cycle?

I would think maint, master, and next, but with next as the least
important. I think Junio generally tests maint and master before
publishing, but presumably not always next (as there was test breakage
in next earlier today).

> Although the list of tags might get slightly unwieldy (i.e. the top
> commit will gain a lot of tags if all is well), with a sensible naming
> convention, these tags could be pushed to a central repo (a regularly
> updated clone of git.git) allowing easy visibility of the current
> state of the 'build collective'.
> 
> Something like {intials}_{uname info}_{branch}_KNOWN_{BUILDING|PASSING} ?

I have started tagging my auto-builds as you suggest. It should be easy
enough to push to a repo.or.cz repository. Although I'm not sure of the
utility of auto-publishing this information. Who is going to look at it?

I had assumed a workflow more like "it passes 99% of the time; in the
remaining 1%, the cron job kicks off a message to the owning user, who
then investigates and/or writes a bug report to the list."

That implies a little bit of expertise and work from the user owning the
build, but:

  - presumably it won't happen very frequently

  - they are probably the only person with the resources to diganose and
    fix, anyway, since they are the ones with access to the platform.

-Peff
