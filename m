From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid unnecessary 'lstat()' calls in 'get_stat_data()'
Date: Sun, 10 May 2009 19:45:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905101942250.27348@pacific.mpi-cbg.de>
References: <alpine.LFD.2.01.0905091501460.3586@localhost.localdomain> <7v8wl5613c.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0905100943370.3586@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 10 19:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3DBQ-0008Lk-VO
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 19:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbZEJRpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 13:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZEJRpp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 13:45:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:39292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751480AbZEJRpo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 13:45:44 -0400
Received: (qmail invoked by alias); 10 May 2009 17:45:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 10 May 2009 19:45:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193f8I2R093W22A1gkYihjyZmgfP/og5LyP5dLhD5
	Vpx7FhAz84yVJd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0905100943370.3586@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118731>

Hi,

On Sun, 10 May 2009, Linus Torvalds wrote:

> Some of the SVN tests seem to sometimes randomly fail when done in 
> parallel

This is probably the problem that the SVN "server" is not set up 
per-testcase, but globally.  (I am speaking from memory here, it might be 
possible that this was fixed already.)

> [ Side note: the success output of "make test" makes it almost impossible 
>   to debug the error cases when you do that "make -j64" thing.

There are left-over trash directories.  (Another indicator are the files 
in t/test-results/.)

My common workflow is to "make -j50 && make -j50 -k test", and if it 
fails, run only those tests that have left-over trash directories.

Ciao,
Dscho
