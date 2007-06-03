From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 22:17:23 +0200
Message-ID: <20070603201723.GG6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070603114843.GA14336@artemis> <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 22:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuwW2-0004H5-Eo
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 22:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbXFCURY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 16:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbXFCURY
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 16:17:24 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33785 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbXFCURX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 16:17:23 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 84E7F5A28F;
	Sun,  3 Jun 2007 22:17:22 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 558011F01B; Sun,  3 Jun 2007 22:17:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706031216560.23741@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49030>

On Sun, Jun 03, 2007 at 12:22:20PM -0700, Linus Torvalds wrote:
> On Sun, 3 Jun 2007, Pierre Habouzit wrote:
> >   Though there is a few design issues I have, that block me from doing
> > first decisions about how to implement some kind of Proof of Concept. My
> > main problem is: should I put this bug tracking system in the repository
> > it tracks bugs for, or not.
> 
> Make it a separate (and independent) branch of the repository you track, 
> and then you can do it - or not do it - as you want later.

And since we have cheep branches, we can even have one BTS branch for
each project branch.

But then, since we probably want git-merge to merge the BTS branch
when present in the local repo, that would mean adding some support in
the core porcelain - eg. a config option declaring some coupling
between a branch and its bug-tracking pal, so git-merge can be taught
to merge it too.


> >   I mean, the immediate idea is to have some .bugs/ directories (or
> > alike). This has many good properties, e.g. for projects like the linux
> > kernel with its many subsystems or driver, it would make sense to have
> > per driver/subsystems/... bug packs, and move bugs from one pack to
> > another would be the way of assigning bugs to different modules.
> 
> I would suggest _not_ doing this kind of mixing. I think it might be 
> appropriate for some cases, but I don't think it's appropriate in general. 
> Partly because I don't think the people who change the bugs are at all 
> necessarily at all the same people who actually do development.

The same functionality could probably be obtained through more
annotations (ie. record which subsystem the bug relates to, just like
any other property of the bug).

Best regards,
-- 
Yann.
