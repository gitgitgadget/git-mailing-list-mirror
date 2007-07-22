From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 22:59:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222255010.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:00:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjTP-0006hS-AE
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765131AbXGVWAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765141AbXGVWAL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:00:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:39614 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765131AbXGVWAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:00:08 -0400
Received: (qmail invoked by alias); 22 Jul 2007 22:00:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 23 Jul 2007 00:00:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lFONQ/YblIL5AeSuxaxZ9UPj3CfhPpVKjd8SkB5
	nHKXlEy+5+gfZw
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53332>

Hi,

On Sun, 22 Jul 2007, Julian Phillips wrote:

> On Sun, 22 Jul 2007, Johannes Schindelin wrote:
> 
> > On Sun, 22 Jul 2007, Julian Phillips wrote:
> > 
> > > On Sun, 22 Jul 2007, Johannes Schindelin wrote:
> > > 
> > > > 	IMHO this is a better syntax than what is in contrib/, and "git
> > > > 	branch" is probably the right place for such a thing, from a
> > > > 	user's perspective.
> > > 
> > > Surely checkout would make more sense than branch?  You are effectively
> > > checking out into a new directory ... also you may want to get an
> > > existing branch (certainly most of my usage of new-workdir is checking
> > > out existing branches, e.g. to look at - as in build and play with - an
> > > interesting branch that someone else has pushed out).
> > 
> > My rationale here was:
> > 
> > - to make sure that the user cannot check out the same branch as in the
> >  current repo, _or some other workdir of it_, and
> 
> Since you can checkout any branch you like once you have the workdir, 
> this is really an artificial limitation - you are protected when you 
> create the workdir, but not after.

Well, it is not really an artificial limitation.  IMHO it is much more 
likely that you keep in mind what you should not do, when you have to work 
around such a limitation if you really want to do.

> If you want to have a workdir for an exisiting branch then you have to create
> a new one, and then switch it over.  That seems like a really big usability
> wart to me ... certainly it would make the option pretty much useless to me.
> My original motivation for the new-workdir script was to give me the ability
> to flatten out branches from a single repo for when I'm working on multiple
> branches at the same time.

Nowadays, we have separate remotes layout by default.  (Indeed, you cannot 
even disable it, as I found out recently).  Which means that you already 
have to branch off your local branch.  So the consequences are lesser.

> > - to have finer grained lock control, as well as respecting has_symlinks.
> 
> Not really sure what this means, since I am too tired to have read the 
> actual patch - is it referring to the fact that checkout is shell rather 
> than C?  If so, surely that is not really a good justification for 
> putting the option in the "wrong" command?

Well, I am really not interested in shooting myself in the foot, and 
having that option in checkout would make that much more likely.  So I 
really, really want to have this in git-branch.

Once git-checkout is builtin, we can still come back and add this option 
to git-checkout (with a big fat red warning, to be sure); it is not like 
we have git-branch and git-checkout functionality well separated...

Ciao,
Dscho
