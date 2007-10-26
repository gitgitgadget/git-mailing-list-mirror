From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git pull' the '--rebase' option
Date: Fri, 26 Oct 2007 10:52:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710261047450.4362@racer.site>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 11:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlLsS-0003Aq-A5
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 11:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbXJZJxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 05:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbXJZJxC
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 05:53:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:50313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751331AbXJZJxA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 05:53:00 -0400
Received: (qmail invoked by alias); 26 Oct 2007 09:52:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 26 Oct 2007 11:52:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Fr0AxoYjFB+7PLAYB6u6vd5ko7pySg+0JrSKwFL
	O6D4FN74TpYiDP
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3avy21il.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62405>

Hi,

On Thu, 25 Oct 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 25 Oct 2007, Linus Torvalds wrote:
> >
> >> On Thu, 25 Oct 2007, Johannes Schindelin wrote:
> >> > 
> >> > This behavior is more desirable than fetch + pull when a topic 
> >> > branch is ready to be submitted.
> >> 
> >> I'd like there to be some *big*warning* about how this destroys 
> >> history and how you must not do this if you expose your history 
> >> anywhere else.
> >> 
> >> I think it's a perfectly fine history, but if you have already pushed 
> >> out your history somewhere else, you're now really screwed. In ways 
> >> that a *real* merge will never screw you.
> >> 
> >> So the "--rebase" option really is only good for the lowest-level 
> >> developers. And that should be documented.
> >
> > Fair enough.
> >
> > How about this in the man page:
> >
> > \--rebase::
> > 	Instead of a merge, perform a rebase after fetching.
> > 	*NOTE:* Never do this on branches you plan to publish!  This
> > 	command will _destroy_ history, and is thus only suitable for
> > 	topic branches to be submitted to another committer.
> 
> Nits.
> 
> (1) This "operation" will "rewrite"  history.

Okay.

> (2) This is not suitable for people who publish their trees and
>     let others fetch and work off of them.
> 
>     Rebase is fine for e-mail submitting contributors as your
>     description above suggests, but as your proposed commit log
>     message said, it is also perfectly appropriate if your
>     interaction with the outside world is "fetch + rebase +
>     push".  You are not limited to "submitted to another
>     committer".

Well, originally I did not want to document it at all.  But I already 
heard the complaints about that in my inner ear.  So I documented it, 
sparsely, in the hope that those who do not know the implications will not 
dare to use it.  After Linus' complaint, I tried to make this shooing away 
more explicit.

I do not want to go into _that_ many details here, since the place to look 
for it is git-rebase.txt.  Probably I should have done that in the first 
place.

So how about this instead:

\--rebase::
        Instead of a merge, perform a rebase after fetching.
        *NOTE:* This is a potentially _dangerous_ mode of operation.  
	It rewrites history, which does not bode well when you
	published that history already.  Do _not_ use this option
	unless you have	read gitlink:git-rebase[1] carefully.

Hmm?

Ciao,
Dscho
