From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should "pull --rebase" try to be a little cleverer?
Date: Mon, 21 Jan 2008 16:21:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211619530.5731@racer.site>
References: <alpine.LSU.1.00.0801211542150.5731@racer.site> <alpine.LFD.1.00.0801211054320.20753@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:21:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGzP9-000744-Bo
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 17:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYAUQVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 11:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYAUQVQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 11:21:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:35753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752407AbYAUQVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 11:21:16 -0500
Received: (qmail invoked by alias); 21 Jan 2008 16:21:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 21 Jan 2008 17:21:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+I6tEyIRSIbsdnPdnyOvGzxGX/Q/B2hYOFk3R1Az
	kwtXJgem1Lzra+
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801211054320.20753@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71290>

Hi,

On Mon, 21 Jan 2008, Nicolas Pitre wrote:

> On Mon, 21 Jan 2008, Johannes Schindelin wrote:
> 
> > last night an idea hit me: if I "git pull --rebase blabla master", it 
> > could be that "blabla" decided to rebase "master" already, and ATM 
> > this would lead to quite a few conflicts, since commits that were not 
> > mine were rewritten.
> 
> Indeed.
> 
> > However, if we already have refs/remotes/blabla/master, we could DWIM 
> > the --rebase call to
> > 
> > 	git rebase --onto FETCH_HEAD refs/remotes/blabla/master
> 
> I was believing this was already the case.  Mind you, I never verified 
> it.
> 
> I think the best is really to have the equivalent of:
> 
> 	git fetch blabla/master
> 	git rebase --onto blabla/master blabla/master@{1} HEAD

Not exactly... what would you do with this:

	git pull --rebase git://git.kernel.org/... master

Hm?

So I think that _only_ in the case that a remote ref is updated, _and_ 
that there is already one, can we do the DWIMery.

Ciao,
Dscho
