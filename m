From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck: do not crash on tag objects which do not contain
 an empty line
Date: Fri, 8 Jun 2007 00:38:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080034510.4046@racer.site>
References: <Pine.LNX.4.64.0706072338260.4046@racer.site>
 <200706080108.50042.johan@herland.net> <Pine.LNX.4.64.0706080011430.4046@racer.site>
 <200706080128.48637.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 01:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRar-0000QG-Td
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967114AbXFGXkd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763659AbXFGXkd
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:40:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:35662 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S967114AbXFGXkc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:40:32 -0400
Received: (qmail invoked by alias); 07 Jun 2007 23:40:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 08 Jun 2007 01:40:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i2g1cpQDiLtIdhmvpz/7ZraiygY11E0IYQhnWDB
	VZ/H8sKpq122sl
X-X-Sender: gene099@racer.site
In-Reply-To: <200706080128.48637.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49412>

Hi,

On Fri, 8 Jun 2007, Johan Herland wrote:

> On Friday 08 June 2007, Johannes Schindelin wrote:
> > 
> > On Fri, 8 Jun 2007, Johan Herland wrote:
> > 
> > > On Friday 08 June 2007, Johannes Schindelin wrote:
> > > > 
> > > > The first empty line in a tag object separates the header from the 
> > > > message. If the tag object has no empty line, do not crash, but 
> > > > complain loudly instead.
> > > 
> > > Aren't tag objects _required_ to have an empty line separating the 
> > > headers from the body? At least I wrote the new tag code with that 
> > > assumption in mind.
> > 
> > Yes, evidently you did.
> > 
> > But even then, isn't it always better to not rely on such assumptions, but 
> > fail gracefully? The rest of Git's source code seems to be nicer to 
> > failures as this one, IMHO.
> 
> I agree that we should fail gracefully, and my code is clearly not doing 
> that in this case. My bad.
> 
> But the code should also detect invalid tag objects, and in this case I'm 
> not yet convinced that the tag object causing the failure is in fact valid. 

IT BROKE GIT IN A REPO THAT WAS PERFECTLY VALID BEFORE, AND I COULD NOT DO 
ANYTHING AFTER THAT CHANGE.

Thank you very much again.

> If someone can convince me that the blank line after headers is optional, 
> then I'll gladly fix the code.

Convincing enough?

> > > Could this be related to the "error: char103: premature end of data" 
> > > you're seeing?
> > 
> > Definitely. It breaks even _fetching_.
> 
> Sorry again. Still, if I could get a look at the object that'd help me alot 
> in debugging.

object f90084c7b53b1c2fb4606acafd84ef8a748a7d78
type commit
tag start
tagger me <me>

But I have to say that I am unlikely to review any fix you make, if that 
fix is as unreadable as those mega long lines with funny spaces in the 
middle of the line in that mega patch that unfortunately was already 
applied in next.

I need a beer,
Dscho
