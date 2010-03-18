From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 15:12:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003181454160.31128@xanadu.home>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
 <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
 <4ba27424.9804cc0a.4b1f.11b1@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:12:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsL8i-0008GE-U2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab0CRTMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:12:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12882 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0CRTML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:12:11 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZH00EE0S0APXU0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Mar 2010 15:12:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4ba27424.9804cc0a.4b1f.11b1@mx.google.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142497>

On Thu, 18 Mar 2010, Michael Witten wrote:

> So, forget the original generality and let's
> define the uuid as a SHA-1 of some EASILY
> REMEMBERED, already reasonably unique piece of
> information such as an old (name,email) pair.

Even with _that_, I bet many people will simply no bother.  You may as 
well just use your current name and email address.  Oh wait, Git is 
using just that already.

> To make life easier on people, git tools could automate
> that process; to Junio, his just uuid is an old,
> unchanging (name,email) pair:
> 
>     $ git config --global user.name  "Junio C Hamano"
>     $ git config --global user.email "gitster@pobox.com"
>     $ git config --global --uuid "Junio C Hamano <junkio@cox.net>"
> 
> which produces something like:
> 
>     [user]
>         name  = Junio C Hamano
>         email = gitster@pobox.com
>         uuid  = 6e99d26860f0b87ef4843fa838df2a918b85d1f7

Even then, some people _will_ manage to screw up some of their UUID 
configs.  And you'll inevitably end up in the same situation that we 
have today i.e. different identification credentials that have to be 
mapped to the same individual.

> Could people still bungle the uuid or enter trash?
> Sure, but that's essentially no different than the
> current situation.

Exact.  So why bother?

> This would be an improvement, because at least some people would take 
> advantage of it; in fact, I bet most people would use it properly 
> because:
[...]

Most people _already_ use their name/email configuration properly.  And 
those who really care are managing a stable email address already.  so 
this is not an improvement at all but only some added complexity.

> Moreover, storing and using the SHA-1 uuid would be
> very efficient and allow for saner .mailmap hacks.

I don't buy that either.  If anything, it is way better to fix the 
current .mailmap mechanism to catter for changing email addresses.  
That's what people use to contact people anyway as I doubt you could 
send any congratulations or job offers solely by using the Git's UUID.  
So you must link back to some form of email address in the end, and 
preferably the current one, otherwise the UUID is useless.  In that case 
then why not simply using that email address in the first place?

The real solution is actually to improve the .mailmap so that any 
individual could decide that for this or that name/email pair to be 
found in the repository then here's the current email that should be 
displayed instead.  Currently this applies partially and only to 
git-shortlog.


Nicolas
