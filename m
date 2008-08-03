From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Mon, 4 Aug 2008 01:24:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808040113150.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080729000103.GH32184@machine.or.cz> <m3myk1t54c.fsf@localhost.localdomain> <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness> <20080803224852.GC3006@untitled>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 01:21:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmtU-0004uc-3f
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370AbYHCXUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758236AbYHCXUF
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:20:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:45100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758104AbYHCXUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:20:04 -0400
Received: (qmail invoked by alias); 03 Aug 2008 23:20:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 04 Aug 2008 01:20:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8F0cO6Vi8J6RzL6yHJ19swFL/fpnC9GngERSxy+
	7wV2keQUZTY7Bm
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080803224852.GC3006@untitled>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91291>

Hi,

On Sun, 3 Aug 2008, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > The main concern I have is to get the semantics right: AFAICT 
> > svn:externals has _no notion_ of "what is current".  It just _always_ 
> > fetches the HEAD.  Even if you check out an ancient revision in the 
> > "superproject".
> 
> Based on my limited understanding, peg revisions are only needed in SVN 
> because of the cost of traversing history to DTRT.  git-svn should be 
> able to just use the -r<rev> syntax that has always been supported 
> without needing peg revisions.

I was talking about the svn -> git direction.

And Git does not peg revisions because of the cost of traversing history 
to DTRT.

Git pegs revisions of submodules, because it is the right thing to do.  
Subversion just got it wrong to begin with.  After all, we are going 
through a lot to make defined revisions, and we do not want to throw that 
out by allowing an unversioned submodule.

So, importing a svn:external with git-svn has to undo that error somehow 
(which might be helped by the linearity of subversion, but might be tricky 
because of possible clock skews between the two subversion repositories).

Ciao,
Dscho
