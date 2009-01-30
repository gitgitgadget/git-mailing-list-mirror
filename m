From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Status of my valgrind branch
Date: Fri, 30 Jan 2009 02:19:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901300213590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 02:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSi3P-0007CU-1y
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 02:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbZA3BSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 20:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbZA3BSx
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 20:18:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:40220 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750988AbZA3BSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 20:18:53 -0500
Received: (qmail invoked by alias); 30 Jan 2009 01:18:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 30 Jan 2009 02:18:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EN/lxbHIEk7wricPe9jcmmKiiBFv8JReqN/j+WH
	mp//Lk0zDpzXsd
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107760>

Hi,

the valgrind branch is not ready yet.  And it grew to 8 patches in the 
meantime:

http://repo.or.cz/w/git/dscho.git?a=log;h=c9486d38d070fefe39f90512e2e12d3a64eba1b3

There is one big problem I only realized today, when trying to catch that 
valgrind bug [*1*]: in the suppression file, I introduced the "..." 
notation, which is only available with valgrind 3.4.0.  Which was 
published this month.

So I have to think about the issue a bit more, and maybe just claim that 
valgrind 3.4.0 is required.  But maybe there are people who disagree with 
me saying that older valgrind should be supported.

Ciao,
Dscho

[*1*] Turns out that the issue I was reporting happens with Ubuntu's zlib, 
which I erroneously thought would be pretty vanilla.  It is not: it was 
compiled with "-O3 -DUNALIGNED_OK", both of which are required to hit the 
bug.

Still, it is a bug in valgrind, I am pretty sure by now, as the byte is 
not uninitialized as valgrind claims.

Oh, and I wasted a _lot_ of time on this today.
