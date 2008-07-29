From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom
 merge strategy
Date: Tue, 29 Jul 2008 13:05:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291301060.4631@eeepc-johanness>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer> <20080728192651.GA26677@sigill.intra.peff.net> <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness>
 <20080729043839.GC26997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 13:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNn0s-0006Vz-Fw
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 13:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbYG2LEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 07:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755559AbYG2LEF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 07:04:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:56966 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755002AbYG2LED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 07:04:03 -0400
Received: (qmail invoked by alias); 29 Jul 2008 11:04:01 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp026) with SMTP; 29 Jul 2008 13:04:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rAOVUNIgrGMP82Y7Mpclcm1q8Ey96vDEwgP/IRl
	Jhp0eJOOeOS90m
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080729043839.GC26997@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90613>

Hi,

On Tue, 29 Jul 2008, Jeff King wrote:

> On Tue, Jul 29, 2008 at 01:27:44AM +0200, Johannes Schindelin wrote:
> 
> > > So the logical sequence was:
> > > 
> > >   git checkout production
> > >   git merge -s theirs master
> > 
> > To me, this suggests that they were too married to 'production' being 
> > the "dominant" branch.
> 
> Perhaps. But I see this as an operation on the production branch: "pull
> in master's changes, forgetting ours".

First of all, I cannot say how wrong it is to forget any changes in a 
production branch without proper explanation.  I.e. without a commit 
message explaining _why_ the change was wrong to begin with.

It is messy at best, and I am happy that Git does not make that easy.

> In your workflow (git checkout master && git merge -s ours production && 
> git push origin master:production) we perform an operation on master, 
> which doesn't seem as intuitive to me.

But why?  Isn't the _content_ of "master" what we want?

> Not to mention that we might not _control_ master.

This is Git.  We control all local branches.

> What about (and I think Sverre mentioned something like this 
> previously):
> 
>  I forked the kernel and made some changes. Some of my changes got
>  applied upstream. The others are now obsolete. Now I want to bring
>  myself in sync with Linus, but I want to keep my history (either
>  because the history is interesting to me, or because others are basing
>  their work on it).
> 
> Then your workflow, while still possible within the local repository, 
> means you are munging the "linus" branch, which seems wrong. That branch 
> is probably even just a tracking branch, which you would not want to 
> build on, anyway.

No, this workflow almost _dictates_ a plain "pull" into your local branch.  
The fact that a few commits were applied to upstream usually only means 
that your merge succeeds trivially, since the merged branches contain the 
_same_ changes.

Ciao,
Dscho
