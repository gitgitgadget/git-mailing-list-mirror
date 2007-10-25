From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 11:17:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251112390.25221@racer.site>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site>
 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org>
 <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
 <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx>
 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site>
 <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site>
 <47204297.5050109@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:18:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikzn2-0004ZX-GX
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbXJYKR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbXJYKR6
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:17:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:55100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752813AbXJYKR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:17:57 -0400
Received: (qmail invoked by alias); 25 Oct 2007 10:17:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 25 Oct 2007 12:17:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Bygk1jmfBomqUC2Rx+VcRmg6mlT1d/6fQ9WXTTF
	HiveC+Orm459cR
X-X-Sender: gene099@racer.site
In-Reply-To: <47204297.5050109@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62293>

Hi,

On Thu, 25 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Thu, 25 Oct 2007, Steffen Prohaska wrote:
> > 
> > > On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:
> > > 
> > > > But I think I have to drive my message home again: if what you 
> > > > desire becomes reality, you take away the clear distinction 
> > > > between local and remote branches.  In fact, those branches are 
> > > > neither local (because the next pull will automatically update 
> > > > them with remote changes, but _only_ if they fast-forward) nor 
> > > > remote (because you plan to work on them locally).
> > >
> > > Exactly, because I do not work on those branches alone. These are 
> > > _shared_ branches. I can work on such a branch with a group of 
> > > developers. I'm willing to accept this bit of chaos.
> > 
> > It is not just a chaos.  I see a serious problem here.  On _your_ 
> > computer, you do _not_ have a shared branch.  Which is visible _even_ 
> > in your modified work flow when you have unpushed changes.
> 
> Ofcourse it is. People might pull from it. That's the whole point of a 
> distributed model.

By that reasoning, left is right.  Because your "left" is my "right".

> > So your desired illusion that your local branches are anything but 
> > local branches will never be perfect enough.
> > 
> > > Your rebase workflow is not possible if more than one dev wants to 
> > > work on the topic branch together.
> > 
> > Why not?  I do it all the time.  CVS users do it all the time, for 
> > that matter.
> 
> For 200 branches at a time, where any of them might have changed?

I slowly start to understand why your users are confused.  _Nobody_ works 
on 200 branches at the same time.  (No, maintainers don't count: they do 
not work _on_ the branches, but _with_; they merge them.)

When you're done with a topic, why do you leave it around?  Cluttering up 
your "git branch" output?

> > The problem I see here: you know git quite well.  Others don't, and 
> > will be mightily confused why pull updates local branches sometimes, 
> > and sometimes not.
> 
> Do you know this, or are you just guessing? I'm getting the exact same
> confusion with the current behaviour. "Why the hell doesn't git update
> all the branches I told the damn stupid tool to auto-merge when I pull?"

That's easy.  A merge can have conflicts.  Conflicts need a working 
directory.  You cannot have multiple working directories.  (Actually, you 
can, with git-new-workdir, which would break down _horribly_ with your 
desired change.)

Oh?  You don't have local changes?  Then why _on earth_ do you have a 
local branch?

Ciao,
Dscho
