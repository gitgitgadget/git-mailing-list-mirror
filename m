From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 15:06:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291502340.28586@racer.site>
References: <1188319608.6106.63.camel@beauty> <20070828172709.GB1219@pasky.or.cz>
 <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz>
 <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
 <Pine.LNX.4.64.0708291446011.28586@racer.site> <20070829135441.GI10749@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benjamin Collins <aggieben@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQOBf-00057d-Ob
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 16:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbXH2OGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 10:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbXH2OGV
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 10:06:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:54119 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751231AbXH2OGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 10:06:20 -0400
Received: (qmail invoked by alias); 29 Aug 2007 14:06:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 29 Aug 2007 16:06:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zraFHNp1zOZSuMsbc/E7M19DIdt1iDJvgl2OxDT
	wqwXsRLuKa+Q+I
X-X-Sender: gene099@racer.site
In-Reply-To: <20070829135441.GI10749@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56951>

Hi,

On Wed, 29 Aug 2007, Petr Baudis wrote:

> On Wed, Aug 29, 2007 at 03:49:45PM CEST, Johannes Schindelin wrote:
> > On Wed, 29 Aug 2007, Benjamin Collins wrote:
> > 
> > > Of course, I understand why it's not already like that, particularly 
> > > given the context of Linux development practices.
> > 
> > It has nothing to do with Linux development practices.  There are 
> > fundamental reasons why we don't fetch hooks:
> > 
> > - they are _not_ part of the repository; just look at the 
> >   .gitattributes-in-the-index-but-not-worktree issue to find out why,
> > 
> > - it is _private_ data, just like the config.  The client has _no 
> >   business_ to read them, let alone fetch them,
> > 
> > - if you have the hooks on different machines, chances are that you need a 
> >   mechanism to update the hooks... This naturally suggests putting the 
> >   hooks into their own branch.
> > 
> > Probably there are way more reasons not to allow such a thing as fetching 
> > hooks.
> 
>   these are all really just technical details - if we decided that it
> _is_ useful to have a mechanism to manage hooks, it really is no problem
> to introduce some easy-to-use automated way to keep .git/hooks/ updated
> based on some head, have .git-hooks/ as part of your current branch, or
> whatever. And of course, "fetching hooks" may not (and very frequently
> you wouldn't ever want it to) mean "grabbing the same hooks the server
> uses".

I think that they are way more than just technical issues: the 
chicken-and-egg problem is certainly _not_ a technical issue.

Besides, another very valid issue is that of portability.  Hooks can be 
_any_ executables.  Not just scripts.  Not just _bash_ scripts.

The other issue I raised, however, seemed to die away in the other noise:

_Why_ on earth do you want to put something into the SCM specific 
meta-data which should be part of the build process _to begin with_?

_All_ of the arguments I read are along the lines "we want to enforce some 
coding styles" or similar.  These issues are _orthogonal_ to the question 
which SCM is used.

Ciao,
Dscho
