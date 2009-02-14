From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: filter-branch: Remove original/* (was Re: [RFC] What's the best
 UI  for 'git submodule split'?)
Date: Sat, 14 Feb 2009 22:25:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142219010.10279@pacific.mpi-cbg.de>
References: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYS1X-0006lJ-LB
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbZBNVYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbZBNVYk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:24:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:51349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752140AbZBNVYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:24:39 -0500
Received: (qmail invoked by alias); 14 Feb 2009 21:24:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 14 Feb 2009 22:24:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EBRhEOCvE4Y5drsWK1MGXeSFFJKqDo0zV5e5toW
	YCr9x4LGwA+xo2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109933>

Hi,

On Fri, 13 Feb 2009, Eric Kidd wrote:

> On Thu, Feb 12, 2009 at 4:59 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 12 Feb 2009, Eric Kidd wrote:
> >
> > >   rm .git/refs/original # or just use --force below
> >
> > BTW I wanted to get rid of this for a long time now, but I cannot seem 
> > to find the time to work on it.  The 'original' refs should not be 
> > needed, as that's a job for the reflogs (yeah, people tried to 
> > convince me back then, but I finally got it, okay?)
> 
> Removing the original/* directory would certainly make my life easier. 
> But the reflog only stores backups for branch heads, not tags, right? If 
> there's a good way to handle this, I'd be happy to send a patch.

Hmm.  Indeed, we ignore reflogs in log_ref_write() when the ref starts 
with refs/tags/ (implicitly, not explicitely).

Maybe it is time to change that.

Ciao,
Dscho
