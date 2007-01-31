From: Jeff King <peff@peff.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 17:53:52 -0500
Message-ID: <20070131225352.GA31145@coredump.intra.peff.net>
References: <87odognuhl.wl%cworth@cworth.org> <20070130231015.GB10075@coredump.intra.peff.net> <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net> <20070131032248.GA17504@coredump.intra.peff.net> <Pine.LNX.4.64.0701310932320.3021@xanadu.home> <20070131170752.GA19527@coredump.intra.peff.net> <Pine.LNX.4.64.0701311335150.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 23:54:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCOL5-0004dV-JP
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 23:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbXAaWx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 17:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932930AbXAaWx6
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 17:53:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1920 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932918AbXAaWx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 17:53:57 -0500
Received: (qmail 6416 invoked from network); 31 Jan 2007 17:53:51 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 31 Jan 2007 17:53:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jan 2007 17:53:52 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701311335150.3021@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38302>

On Wed, Jan 31, 2007 at 01:59:37PM -0500, Nicolas Pitre wrote:

> > I would also be happy with warning (and
> > probably blocking without -f) moving from 3 to 1, which is the actual
> > dangerous thing.
> And that is already what is happening.

Doh! I'm a complete moron. Sorry, but I thought we were _not_ warning
there in favor of the warning at time of detachment. I even did a test,
but I botched it.

So please, accept my apology and assume I have hit myself over the head
with the clue stick several times. Warning at commit time _is_ stupid,
since we can complain at the correct time.

> Let's fix the warning then.  But it must stay just because it is 
> important that the user know _why_ and _when_ the head became detached.  
> Realizing that head is detached later is far more confusing if the user 
> just don't know how that happened.

OK, I completely see your point now; it doesn't have to be a _warning_
per se, but rather to let the user know this is when the state changed
(so that later if they do get a warning, it makes more sense).

> > > But making a warning at commit time is wrong. It is completely 
> > > disconnected from the actual issue and I think it'd create more 
> > > confusion because there is in fact nothing to worry about at the moment 
> > > the commit is made.  The very fact that you think yourself that a 
> > > warning should be displayed at commit time indicates to me that you 
> > > might be a bit confused yourself and such warning if present at commit 
> > > time wouldn't help clearing that confusion at all.
> > 
> > I think you are proving my point here. If you think warning at commit
> > time is too early, then how is warning _before_ that (when we detach)
> > not too early?
> 
> Did I say anything about it being too early?
> 
> I say that it is unnecessary and redundent, and that it would create 
> more confusion than it clears.

You said "...there is in fact nothing to worry about at the moment the
commit is made." My point is that there is in fact nothing to worry
about at the moment that you detach, thus why should one get a warning
and not the other. But I agree that if you want the later warning to
make sense, it might be helpful to note that point (and I think it's
getting too fancy to tuck away that information and have the actual
warning say "When you moved your HEAD to foo~32, you were no longer on a
branch, therefore...")

So IOW, I think I agree with you now. :)

Again, sorry for the (my) confusion.

-Peff
