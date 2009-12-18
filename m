From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Thu, 17 Dec 2009 22:57:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912172255500.23173@xanadu.home>
References: <1260822484.9379.53.camel@localhost>
 <alpine.LFD.2.00.0912142245240.23173@xanadu.home>
 <1260851180.9379.88.camel@localhost>
 <alpine.LFD.2.00.0912152201300.23173@xanadu.home>
 <1260970885.2788.87.camel@localhost>
 <alpine.LFD.2.00.0912161526080.23173@xanadu.home>
 <1261003041.2788.142.camel@localhost>
 <alpine.LFD.2.00.0912161841210.23173@xanadu.home>
 <1261067369.2868.10.camel@localhost>
 <alpine.LFD.2.00.0912172149020.23173@xanadu.home>
 <f488382f0912171944m6c7d7fdas8fe2b12755358b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_xqfy62irJKz2w+0ga77mtg)"
Cc: Eric Paris <eparis@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLTyq-0006ao-U5
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 04:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbZLRD6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 22:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbZLRD57
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 22:57:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13998 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZLRD56 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 22:57:58 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KUT007DRXOLJME0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Dec 2009 22:57:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <f488382f0912171944m6c7d7fdas8fe2b12755358b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135400>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_xqfy62irJKz2w+0ga77mtg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 17 Dec 2009, Steven Noonan wrote:

> On Thu, Dec 17, 2009 at 7:33 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Thu, 17 Dec 2009, Eric Paris wrote:
> >
> >> This alone almost certainly tells me how I broke it.
> >>
> >> For quite some time (a period of months) linux-next was broken and I had
> >> to carry a patch to ACPI to make it boot.  I dropped that patch at the
> >> head of my stgit trees in all of my repositories.  So I wouldn't be at
> >> all surprised to learn that eventually kernel-2 found that object in
> >> kernel-1.  Sometime when I dropped that patch from kernel-1 (because it
> >> finally got fixed upstream) I can see how it broke.
> >>
> >> But now that patch shouldn't be needed by any tree since I have long
> >> since dropped it from the stgit stack.  So if we cleaned up all of the
> >> useless objects in this tree I bet this object wouldn't be needed.  Not
> >> exactly a situation that I'd expect git to be able to dig out of itself
> >> thought.
> >
> > I let the script I provided previously ran for a while.  And the commit
> > I found to contain the missing object belongs to
> > refs/patches/fsnotify/fsnotify-group-priorities.log.  So I simply
> > deleted that branch entirely and now the repack can proceed.  And with a
> > 'git gc --aggressive' the 1.2GB repository shrank to a mere 5.2 MB.  :-)
> > Of course I didn't bring back all the reflogs though.  But I would
> > have expected a repository reduction of the same magnitude even with
> > them.
> >
> 
> Are we talking about the same Linux kernel repository as before?

As before in this thread.

> Because if so, that reduction in size doesn't make any sense to me.

Sure it does.

> The smallest size I've seen for the Linux kernel repository (in the
> past year) is 250MB.

Depends if you have an alternate repository from which you may borrow 
objects from, which was the case here.  In that context, 1.2 GB of disk 
space was completely insane.


Nicolas

--Boundary_(ID_xqfy62irJKz2w+0ga77mtg)--
