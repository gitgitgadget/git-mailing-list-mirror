From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Tue, 19 Feb 2008 15:49:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191547580.30505@racer.site>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org> <47BAF18F.5040709@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 16:50:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRUjq-0001gA-67
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 16:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYBSPt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 10:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbYBSPt5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 10:49:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:45660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752986AbYBSPt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 10:49:56 -0500
Received: (qmail invoked by alias); 19 Feb 2008 15:49:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 19 Feb 2008 16:49:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rpG5W4KTrjBfp6U9SdA+ZxLSEb1sliOuh2U6IlE
	Ciwp3WCfI/gY1p
X-X-Sender: gene099@racer.site
In-Reply-To: <47BAF18F.5040709@freescale.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74418>

Hi,

On Tue, 19 Feb 2008, Jon Loeliger wrote:

> Daniel Barkalow wrote:
>
> > For example, if you don't have a kernel.org account, you might want 
> > settings like:
> > 
> > [host "kernel.org"]
> >       base = git://git.kernel.org/pub/
> >       rewritebase = master.kernel.org:/pub
> > 
> > Then, if you give git a URL like:
> > 
> >   master.kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> > 
> > it will act like you gave it:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> > 
> > and you can cut-and-paste pull requests in email without fixing them 
> > by hand, for example.
> > 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> 
> So, I may be dense, but I'm having a hard time distinguishing the names 
> "base" and "rewritebase" just from a User Interface perspective.  It's 
> not clear to me which of those is the A and which is the B part in 
> s/A/B/.  "Rewritebase" might be the "from" basis, or it might be the 
> "to" basis.  Can we come up with more descriptive property names here?
> 
> Is the rewrite always just prefix substitution/replacement?
> What if there was some generic path rewrite needed? (KISS? :-))

I just tried this:

$ git config rewrite."master.kernel.org:/pub".url \
	git://git.kernel.org/pub/

and it worked.  IOW, the config will look like this:

[rewrite "master.kernel.org:/pub"]
        url = git://git.kernel.org/pub/

So maybe this is easier to grasp?

Ciao,
Dscho
