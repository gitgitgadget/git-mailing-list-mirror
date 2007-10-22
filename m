From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-format-patch: Don't number patches when there's only
 one
Date: Mon, 22 Oct 2007 11:22:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221119300.25221@racer.site>
References: <20071021144637.762085BB92@nox.op5.se> <Pine.LNX.4.64.0710221044080.25221@racer.site>
 <471C77F0.5050701@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 12:24:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjuRR-0003kx-HL
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbXJVKXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 06:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXJVKXL
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:23:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:41745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750782AbXJVKXK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:23:10 -0400
Received: (qmail invoked by alias); 22 Oct 2007 10:23:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 22 Oct 2007 12:23:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jN35ZW0Kjb353ZHjKzdsA3sEXca7Q8lInzNATxl
	j5dq3pVly2LqQJ
X-X-Sender: gene099@racer.site
In-Reply-To: <471C77F0.5050701@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61979>

Hi,

On Mon, 22 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Sun, 21 Oct 2007, Andreas Ericsson wrote:
> > 
> > > [PATCH 1/1] looks a bit silly, and automagically handling this in 
> > > git-format-patch makes some scripting around it a lot more pleasant.
> > 
> > I think you should not use "-n" if you do not want to have the 
> > numbers.
> 
> This stems from creating scripts around it where I only want to see the 
> numbers if there is more than a single patch. Currently I can't do that 
> without running git-format-patch twice or re-implementing the revision 
> parsing machinery to count revisions prior to passing arguments to 
> format-patch.

Why not have something as simple as

	numbered=
	test $(git rev-list $options | wc -l) -gt 1 && numbered=-n

	[...]

	git format-patch $numbered $options

At the moment, the semantics of "--numbered" is really clear and precise.  
And I really like that.  It makes for less surprises.

Ciao,
Dscho
