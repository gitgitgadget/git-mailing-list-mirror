From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 20:13:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701272004250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BB5888.9020608@fs.ei.tum.de> <Pine.LNX.4.63.0701271728020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BB87EB.7010200@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAszW-0004p8-2s
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbXA0TNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbXA0TNb
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:13:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:36737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752350AbXA0TNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:13:30 -0500
Received: (qmail invoked by alias); 27 Jan 2007 19:13:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 27 Jan 2007 20:13:29 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45BB87EB.7010200@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37985>

Hi,

On Sat, 27 Jan 2007, Simon 'corecode' Schubert wrote:

> Johannes Schindelin wrote:
> 
> > Many people don't use or even need blame. And what you want to 
> > introduce would affect them, too.
> 
> Many people do not use colored diffs.  Introducing colored diff support 
> affects them, too.  In which way?  Additional command line switches, for 
> example.  I don't think that's a big deal, and neither is a reverse map 
> to create object-level DAGs.

Do colored diffs need additional data?

No.

There's the principal difference between rev-pathspec-speed-up and 
colored-diffs.

> Please don't take the mentioning of hg as an attack on git.  You don't 
> have to shoot back.

I did not take it as an attack on git! If it sounded like that, sorry.

(Side note: If there is _any_ feature in other versioning systems I would 
like to have in git, I'll try to implement it. If there is a VCS that is 
better than git, and which is free, I'll use it. Sorry, but that's the 
way it is.)

I only tried to make it clear why we do not do things as Mercurial does it 
(in this particular case at least), and why I think that git's way is 
better.

> > Rather, calculate the information you need from the existing data, and 
> > if you can reuse it, store it locally. _That_ is flexibility.
> 
> Of course this is flexibility.  But this also means that every consumer 
> has to do this for every repo.  Wouldn't it be nice to have it done one 
> time and then stored in a pack?

So you want to store it in a pack, fetchable?

> > It also gives me a warm fuzzy feeling that no bogus "auxillary 
> > information" can be introduced by fetching from somewhere else. (It 
> > does not matter if intended or unintended.)
> 
> I agree on that.

So you agree we should _not_ store it in a pack, fetchable?

> > And if something is wrong with that "auxillary information", it can be 
> > regenerated correctly, without touching the real data -- the commit 
> > ancestry.
> 
> Yes, it always can be regenerated.  I never said it should be made part 
> of the core structure.

So, if you _do_ have it in a pack, fetchable, what happens if you 
regenerated it locally, fixing a flaw, but then fetch it from somewhere 
else, where the flaw possibly still exists, what do you do?

Ciao,
Dscho
