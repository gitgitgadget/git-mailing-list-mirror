From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: trouble getting git cvsimport working
Date: Sat, 10 Jan 2009 15:55:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101553590.30769@pacific.mpi-cbg.de>
References: <81bfc67a0901100516w10ea77e8n8734713b071d69b9@mail.gmail.com>  <alpine.DEB.1.00.0901101524310.30769@pacific.mpi-cbg.de> <81bfc67a0901100635i4d33c294x393a8d2dfc2b0e0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:56:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLfGN-0000EY-6x
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 15:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbZAJOzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 09:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbZAJOzK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 09:55:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:58622 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753197AbZAJOzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 09:55:09 -0500
Received: (qmail invoked by alias); 10 Jan 2009 14:55:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 10 Jan 2009 15:55:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19p7ZBUZnlpNT5X1yhAYvzn9ZdDRjy2CZU3RMo8t6
	Ww130R5zFQpOBL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81bfc67a0901100635i4d33c294x393a8d2dfc2b0e0d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105118>

Hi,

On Sat, 10 Jan 2009, Caleb Cushing wrote:

> git cvsimport -a -v -d
> :pserver:anonymous@anoncvs.gentoo.org/var/cvsroot/ gentoo-x86 -C
> portage
> Initialized empty Git repository in /home/portdev/cvs/portage/.git/
> Running cvsps...
> parse error on third token
> WARNING: malformed CVS version str: Server: (unknown)
> WARNING: Your CVS client version:
> [Client: Concurrent Versions System (CVS) 1.12.12 (client)]
> and/or server version:
> [Server: (unknown)]
> are too old to properly support the rlog command.
> This command was introduced in 1.11.1.  Cvsps
> will use log instead, but PatchSet numbering
> may become unstable due to pruned empty
> directories.

This is the problem.

> cvs log: warning: failed to open /home/portdev/.cvspass for reading:
> No such file or directory
> cvs log: in directory .:
> cvs [log aborted]: there is no version here; run 'cvs checkout' first

And this is the solution: Just try

	$ cvs -d :pserver:anonymous@anoncvs.gentoo.org/var/cvsroot/ \
		co gentoo-x86
	$ cd gentoo-x86
	$ git cvsimport -v

(I assume it is a live repository, so -a is dangerous.)

Hth,
Dscho
