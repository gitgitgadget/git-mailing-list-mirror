From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 23:31:01 -0500
Message-ID: <20070111043101.GB29214@fieldses.org>
References: <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <7vy7obj07k.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org> <20070110140432.GA20868@coredump.intra.peff.net> <7vslei764u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 05:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4rav-0008JQ-EV
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 05:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbXAKEbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 23:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbXAKEbF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 23:31:05 -0500
Received: from mail.fieldses.org ([66.93.2.214]:57250 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965119AbXAKEbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 23:31:04 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H4raf-0008HA-4E; Wed, 10 Jan 2007 23:31:01 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslei764u.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36547>

On Wed, Jan 10, 2007 at 04:34:57PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jan 09, 2007 at 03:46:32PM -0800, Linus Torvalds wrote:
> >
> >> I would suggest a solution:
> >> 
> >>  - git checkout will refuse to switch AWAY from a detached head unless the 
> >>    SHA1 of the detached head exactly matches some other branch.
> >
> > What about
> >
> >   git checkout HEAD~20
> >
> > I agree that checking out tags will be more common, but it feels like we
> > are discouraging this usage by presenting spurious warning messages.
> 
> Once the user knows what HEAD~20 means, I think it is safe to
> assume that the user knows what the branches are.

I'm interested of course in making life easy for project admins when
they need to tell testers how to get code to test out of git.  It'll be
nice to able to say:

	"Install git, then run
	git clone git://ourproject.com/ourproject.git
	cd ourproject
	git checkout <version you want>
	"

Instead of having to say

	"Install git, then run
	git clone git://ourproject.com/ourproject.git
	cd ourproject
	git checkout -b FOO <version you want>

	Then if you later need to check out another version, run
	git reset --hard <other version>
	"

I suppose <version you want> will typically be either some tagged
release or the latest head.  But it's not that farfetched to imagine
asking someone to test version 01997b4....

> "git checkout master" will barf and suggests the user possible
> common exits; "checkout -f" if there is nothing of value,
> "checkout -b <branch>" or if they want to build on the current
> state.

That should make it easy enough, though, I guess.

--b.
