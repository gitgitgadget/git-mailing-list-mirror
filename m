From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/11] Provide API access to init_db()
Date: Sun, 9 Mar 2008 21:43:46 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803092143370.3975@racer.site>
References: <alpine.LNX.1.00.0803081804200.19665@iabervon.org> <alpine.LSU.1.00.0803090026170.3975@racer.site> <alpine.LNX.1.00.0803081840070.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 21:44:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYSNd-0001K1-JC
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 21:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbYCIUnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbYCIUnp
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 16:43:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:56959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751313AbYCIUnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 16:43:45 -0400
Received: (qmail invoked by alias); 09 Mar 2008 20:43:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp012) with SMTP; 09 Mar 2008 21:43:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yivkPdWrycr1VV70IDvPrP/udF6cjhrG6PbO5FE
	ehdTVGd4LcvrT9
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803081840070.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76666>

Hi,

On Sat, 8 Mar 2008, Daniel Barkalow wrote:

> On Sun, 9 Mar 2008, Johannes Schindelin wrote:
> 
> > On Sat, 8 Mar 2008, Daniel Barkalow wrote:
> > 
> > > The caller first calls set_git_dir() to specify the GIT_DIR, and then 
> > > calls init_db() to initialize it. This also cleans up various parts of 
> > > the code to account for the fact that everything is done with GIT_DIR 
> > > set, so it's unnecessary to pass the specified directory around.
> > 
> > I think the most controversial part is that you change the way it is 
> > determined if the repository is a bare one.  It might have the same 
> > result (I do not have time to check it...), but the computation is 
> > performed differently.
> 
> It's actually doing the same computation; the difference is how the result 
> is reported. Mine commits to the repo being non-bare if it doesn't think 
> it's bare, which the current code leaves as "we don't know, assume 
> non-bare". But since we actually create a work tree if we guess it's 
> non-bare, it really is non-bare. So then the later code can assume it's 
> either 0 or 1, and not worry about -1 being equivalent to 0.

Okay.

Thanks,
Dscho
