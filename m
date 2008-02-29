From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: '.git file' alternative, native (cross-platform) workdir
 support.
Date: Fri, 29 Feb 2008 14:25:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802291333310.22527@racer.site>
References: <47C7FA49.9010001@trolltech.com> <alpine.LSU.1.00.0802291248510.22527@racer.site> <47C80786.4070701@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 15:26:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV6By-0001gf-PJ
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 15:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611AbYB2OZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 09:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758287AbYB2OZx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 09:25:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:58391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758560AbYB2OZx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 09:25:53 -0500
Received: (qmail invoked by alias); 29 Feb 2008 14:25:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 29 Feb 2008 15:25:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KcaVL2i1KjTRnT1q8AFHIdamCn2RvgXlHNS/APf
	waTEBKCYhs/iaw
X-X-Sender: gene099@racer.site
In-Reply-To: <47C80786.4070701@trolltech.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75538>

Hi,

On Fri, 29 Feb 2008, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 29.02.2008 13:54:
> > On Fri, 29 Feb 2008, Marius Storm-Olsen wrote:
> > > However, wouldn't simply redirecting everything into a real repo 
> > > then create problems with shared index file and more? A problem 
> > > which could be tacled by file suffixes or other methods, I'm sure, 
> > > but which would require even more patches to achieve the goal.
> > 
> > Not only would it requre these patches, but it would actually make a 
> > _safe_ multiple-workdirs feature possible.
> 
> Sure, I'm aware of that. The initial goal was to make something which 
> works as the current contrib/workdir/git-new-workdir, just 
> cross-platform. Then we can take it from there, step by step, until we 
> have something which works safely; instead of taking a single big leap.

That's what I am saying: there is no way to make it safe.

> I'm actually not sure that it's impossible to make it safe. My 
> implementation works by redirecting files into the real repo. However, 
> we can also detect when redirection is in effect, and do extra 
> 'maintainance' things then, to avoid the bad effects.

>From the perspective of Windows, I guess it is easy to overlook the fact 
that permissions can break your idea.

Even after creating a second working tree for an existing repository, the 
permissions of the original repository can change.

The only way to be on the safe side is to use _the repository_ twice.  IOW 
not having a second .git/ directory.

Also, having a single .git is just a very simple, and thus preferable 
concept, to having part of this, and part of that repository.

Ciao,
Dscho
