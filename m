From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src)
  when that is unreliable
Date: Thu, 23 Apr 2009 23:59:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904232358520.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <81b0412b0904231239qf317c02xbfa548d0011a0302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-884190836-1240523985=:10279"
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 00:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx6yp-0004ue-3p
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 00:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbZDWV7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 17:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754186AbZDWV7k
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 17:59:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:35093 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752698AbZDWV7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 17:59:40 -0400
Received: (qmail invoked by alias); 23 Apr 2009 21:59:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 23 Apr 2009 23:59:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+8Mlb/IV+DNzOXL2mP+FviMutYszSsVtLCxuVpO
	xjAo6VvYlhSN3C
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0904231239qf317c02xbfa548d0011a0302@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117391>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-884190836-1240523985=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 23 Apr 2009, Alex Riesen wrote:

> 2009/4/23 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > -       if (link(tmpfile, filename))
> > +       if (unreliable_hardlinks)
> > +               ret = ~EEXIST;
> 
> It is more like "broken_hardlinks" or even "no_hardlinks"!

Wrong.  As I wrote, single-stepping (i.e. leaving enough time between 
link() and unlink()) works as expected.  So it is not even that the 
hardlinks are broken.  Just the serialization between the operations.

Ciao,
Dscho

--8323328-884190836-1240523985=:10279--
