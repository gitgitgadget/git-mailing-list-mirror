From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bootstraper for Git Dev Environment for Windows (Light version)
Date: Sun, 5 Aug 2007 14:51:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051444560.14781@racer.site>
References: <2B8D8540264E4205BD1E4605770422BF@ntdev.corp.microsoft.com>
 <Pine.LNX.4.64.0708051252130.14781@racer.site>
 <26F4E92272F14115959CFA0C23809617@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Pape <dotzenlabs@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <J.Sixt@eudaptics.com>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 15:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHgWP-0008KI-PZ
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbXHENvu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbXHENvu
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:51:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:51430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751595AbXHENvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:51:49 -0400
Received: (qmail invoked by alias); 05 Aug 2007 13:51:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 05 Aug 2007 15:51:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XNk4VY53XptvWlL1PLbNh6ALQafQVYTcUvOYeNe
	/0I8rlhIuby8Z1
X-X-Sender: gene099@racer.site
In-Reply-To: <26F4E92272F14115959CFA0C23809617@ntdev.corp.microsoft.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55018>

Hi,

On Sun, 5 Aug 2007, Dmitry Kakurin wrote:

> ----- Original Message ----- From: "Johannes Schindelin"
> <Johannes.Schindelin@gmx.de>
> 
> 
> > - How about calling your package msysGit-netInstall-<version>.exe?
> No problem. Feel free to reupload it with a different name.

I'll do so later... When it has to change.

> >   mingw.git as well...  Still, on dial-up, 40MB or 60MB makes a 
> > difference, no?
>
> Sorry, I didn't have dialup for years so I don't take it into 
> consideration. Still 60MB is not that dialup unfriendly.

Okay.

> > - There is one big caveat with your bootstrapper: things have been 
> > known to break, and I think msysgit.git is no exception.  So I'd like 
> > to have a fallback in case things go awry, also to have something that 
> > is tested (for example, Mike tested msysGit-0.4.exe before releasing 
> > it).  Of course, we could solve that issue by branching off of the 
> > last release tag.
>
> That, or better yet always maintain master branch in a working 
> condition. Seriously. If it (VERY rarely) breaks we'll just revert the 
> offending checkin to bring it back in shape. Where I come from, 'main' 
> or 'master' should ALWAYS be functional.

Okay, let's try to be anal then.

> > - AFAICT it is possible to make nicer installers with 7-Zip, and also
>
> I have no preference here. I just use what I know (WinRAR). If you feel 
> strongly about 7zip (which I can see you do for some reason :-) feel 
> free to repackage it.

Yeah ;-)  I like it because it is Open Source... and easily scriptable.  
Even if you want to make a graphical installer.

> > - I wanted to hold off a little, until Hannes can apply the fix-up 
> > patch we need in mingw.git.  Because when he does, your bootstrap will 
> > run into problems...
>
> Not sure why...

Neither am I anymore.

What would you say about this idea:

- upload a branch "mingw-devel" to msysgit.git, which is identical to 
  mingw.git's devel, plus our patches.

- convert /git to a submodule, fetching from msysgit.git's mingw-devel 
  branch.

- adjust /etc/profile for the changes.

- make a new net installer and upload it.

- But keep doing some full releases in the meantime, which do not clone 
  anything, but rather initialise /git/.git so that people can send in 
  patches?

> > It would be nice to have insight in how you went about to identify 
> > what is needed?
>
> Well, I've set path to a single directory (C:\GitMe\bin), copies over 
> bash and git-clone and started running it until it worked. Which 
> happened surprisingly fast.

Ah, thanks.  Valuable work, this.

Ciao,
Dscho
