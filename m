From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch.autosetupmerge: allow boolean values, or "all"
Date: Sun, 8 Jul 2007 20:15:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707082014140.4248@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 21:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7cLM-0007Xp-Ps
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 21:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbXGHTWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 15:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbXGHTWu
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 15:22:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:56154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755530AbXGHTWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 15:22:50 -0400
Received: (qmail invoked by alias); 08 Jul 2007 19:22:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 08 Jul 2007 21:22:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/b1G0MUvjbyDedhI6h5QgE6VbDi2DuaNx2m9mctW
	sZDqG7XgZeejsS
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm2620wp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51909>

Hi,

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	> Eh?  I did not want this to get applied for my local branches.
> >
> > 	That is certainly unexpected and unwelcomed.  Alas, I think it is 
> > 	one of the consequences of rarely executed (and thus, tested) 
> > 	code.
> > ...
> > +test_expect_success 'autosetupmerge = all' '
> > +	git config branch.autosetupmerge true &&
> > +	git branch all1 master &&
> > +	test -z "$(git config branch.all1.merge)" &&
> > +	git config branch.autosetupmerge all &&
> > +	git branch all2 master &&
> > +	test $(git config branch.all2.merge) = refs/heads/master
> > +'
> 
> Thanks.
> 
> Having prepared the patch below, I do not think if the original
> patch even wanted to have 'all' semantics.  The surrounding text
> only talks about "off a remote branch" and I strongly suspect
> that nobody wanted to do this for a local branch case at all.

I remember that the comment was correct for the first few versions.  
Somehow I missed that change in semantics.  Paolo, what was the rationale?

Ciao,
Dscho
