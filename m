From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-filter-branch
Date: Mon, 4 Jun 2007 18:55:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706041850350.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
 <Pine.LNX.4.64.0706041711500.4046@racer.site> <46643F2D.7C896CBC@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:57:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvGoH-0002rX-9J
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 19:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704AbXFDR5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 13:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757606AbXFDR5h
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 13:57:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:50268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756070AbXFDR5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 13:57:36 -0400
Received: (qmail invoked by alias); 04 Jun 2007 17:57:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 04 Jun 2007 19:57:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mpIQ3+opm6F8YV4t/gpFjKn7Q2hWFvxYb3QF1LM
	yOmvBXGASjcOsP
X-X-Sender: gene099@racer.site
In-Reply-To: <46643F2D.7C896CBC@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49119>

Hi,

On Mon, 4 Jun 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > 
> > Hi,
> > 
> > On Mon, 4 Jun 2007, Johannes Sixt wrote:
> > > I propose that you just get rid of the "seed" stance and don't fail if a
> > > commit cannot be mapped - just use it unchanged (don't forget to adjust
> > > the map() function, too).
> > 
> > It is as much for debug reasons as for consistency, so I'd rather keep it.
> > One more safety valve for catching bugs.
> > 
> > > Then you can get rid of -r and use -k to specify everything you want
> > > under "--not" in the rev-list.
> > 
> > Actually, -r is quite useful. It means "start rewriting with this commit",
> > and saying "--not <commit>^" is _not_ the same when <commit> is a merge.
> 
> But this makes only sense if you have a linear history. Consider this
> history, where you want to rewrite the commits that are only on branch
> 'next':
> 
> --A--B--C--D--E--F--G--H       <- master
>    \  \  \  \  \  \  \  \
>     X--o--o--o--o--o--o--o--o  <- next
> 
> How would you go about with the current calling convention?

Are you actually sure that this scenario makes sense? When is the last 
time you wanted to filter a branch?

In any case, for such a degenerated test case I would rather try to limit 
filtering in the filter expression. Remember: you don't have to change 
_every_ commit.

Of course, if I am the only one defending this behaviour, I'll change it.

Ciao,
Dscho
