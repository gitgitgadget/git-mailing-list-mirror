From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding Reviewed-by/Tested-by tags to other peoples commits
Date: Sat, 11 Oct 2008 15:06:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810111457300.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com> <alpine.DEB.1.00.0810111239590.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vfxn3jqt9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 15:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Koe69-00046g-4D
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 15:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYJKNAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 09:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbYJKNAQ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 09:00:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:39958 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752531AbYJKNAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 09:00:15 -0400
Received: (qmail invoked by alias); 11 Oct 2008 13:00:21 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 11 Oct 2008 15:00:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192DcNVSNp2OWkqr5tjKa0LnbWP8T137o18y//6Nk
	q4rcZD4gMxt7Ro
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vfxn3jqt9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97979>

Hi,

On Sat, 11 Oct 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 11 Oct 2008, Alex Bennee wrote:
> >
> >> I've just tested/reviewed a patch of someone elses and I want to 
> >> forward it on the appropriate mailing list. I gather for Linux you 
> >> just add the appropriate tags to the commit. Does git offer a 
> >> shortcut for doing this or do you have to do a reset HEAD^ and 
> >> re-commit with a copy&pasted and modified commit message?
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/75250/focus=76304
> >
> > In the end, nothing happened, but I could see that you might want to 
> > push for this patch.
> 
> The fact a particular change has been reviewed is an attribute of a 
> commit, and by recording the fact once (perhaps when you commit for the 
> first time, or if your workflow is "commit blindly, then review, and 
> then amend" then when you amend that commit), the commit object will 
> remember that fact.

If that was the goal, you would _have_ to add commit notes.  Because 
otherwise you would have to pretend to have changed the commit, which you 
did not at all.

> The patch you quoted adds Reviewed-by: at format-patch time, but I 
> suspect that is a wrong approach.

Color me puzzled.  You said in another mail that you think this is the 
task for the MUA.  When I send patches (even forwarded ones), I use 
format-patch just before pasting into the MUA (I do not trust send-email).  
And that's where Git can kick in: format-patch.  Not the MUA.

So technically, I understood that the format-patch approach is exactly the 
same as you were proposing, only that you do not ask the MUA to do Git's 
job.

Unless, of course, you are talking about the reviewing style where the 
patch does not leave the MUA until it is to be forwarded.

> You have to remember and recall which ones you reviewed (and which ones 
> you didn't) when you run format-patch.

Don't you have to do that anyway?  I do not see how giving format-patch a 
new option --reviewed-by would change the equation in any way.

> This is a bit tangent, but perhaps rebase needs a hook so that users can 
> strip certain tags automatically from the commit log messages (e.g. 
> things like Reviewd-by: and Tested-by: become less trustworthy when you 
> rebase; S-o-b: becomes somewhat less trustworthy when you "edit" in 
> rebase-i; etc).

Maybe.  I am not really convinced of the S-o-b.  You kept stressing that 
the SOB is not about validity, but a statement that the patch is 
intellectually proper or some such (IOW it means something like "Darl, 
forget it").  And the point of origin does not change, even if you rebase 
the commit.

Ciao,
Dscho
