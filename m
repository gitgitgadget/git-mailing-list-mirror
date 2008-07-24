From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf
 has not been set
Date: Thu, 24 Jul 2008 17:45:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241742220.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de> <20080723114022.GP2925@dpotapov.dyndns.org>
 <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de> <20080724140959.GU2925@dpotapov.dyndns.org> <alpine.DEB.1.00.0807241537000.8986@racer> <465DE5CD-DA13-42B4-B0D8-961F3D118F59@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:46:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM3xA-0003CW-A8
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYGXQpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbYGXQpH
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:45:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:44570 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbYGXQpG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:45:06 -0400
Received: (qmail invoked by alias); 24 Jul 2008 16:45:04 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp040) with SMTP; 24 Jul 2008 18:45:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fdd9ar3JfBbUmj5UV8cEIFynPo1suwc8hHioteS
	o4zAYoOW6XUIzQ
X-X-Sender: gene099@racer
In-Reply-To: <465DE5CD-DA13-42B4-B0D8-961F3D118F59@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89905>

Hi,

On Thu, 24 Jul 2008, Steffen Prohaska wrote:

> On Jul 24, 2008, at 4:38 PM, Johannes Schindelin wrote:
> 
> >On Thu, 24 Jul 2008, Dmitry Potapov wrote:
> >
> > >On Thu, Jul 24, 2008 at 08:06:29AM +0200, Steffen Prohaska wrote:
> > > >
> > > > I am the maintainer of this project.  I know that this project 
> > > > needs crlf conversion, because it is a cross-platform project. 
> > > > Therefore, I want to force crlf conversion for this specific 
> > > > project, even if the user did not configure core.autocrlf=input on 
> > > > Unix.
> > >
> > >I suspect that most problems with crlf is caused by Windows users who 
> > >have core.autocrlf=false for whatever reason (I suspect without a 
> > >good reason in most cases).
> >
> >Almost correct.  It is _unset_!  And it should be perfectly valid for 
> >users not having to set anything there.
> 
> Why is it unset?  Since 1.5.5, our installer sets core.autocrlf=true
> on Windows.  So we *do* set a sane default for Windows users.

As I mentioned earlier, these users use Cygwin's Git.  And they do not 
update frequently.

> In the projects I am using git, the problematic platform is *Unix*. To 
> work around the default on Unix (core.autocrlf=false), I deliver a 
> custom script to our developers that verifies the setup on Unix and 
> complains if core.autocrlf is not set to "input".  Since I do this, I 
> haven't seen any further problems.

That is exactly the use case I had in mind for my patch.  If we already 
bother to mark the files with crlf=input in .gitattributes, then Git could 
be so nice to respect it.

However, I see Junio's point: on sane platforms you have to work hard to 
get CR-damaged files.  And the regular sane platform user should not be 
punished for the brain/CR damage a certain monopolist has brought over 
this planet.

Ciao,
Dscho
