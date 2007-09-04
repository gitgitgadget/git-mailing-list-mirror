From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 4 Sep 2007 13:57:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041356070.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com>
 <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site>
 <46DD433A.5040604@eudaptics.com> <Pine.LNX.4.64.0709041324420.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 14:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISXyw-0007tX-KO
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 14:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbXIDM6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 08:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbXIDM6I
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 08:58:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:51514 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752267AbXIDM6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 08:58:07 -0400
Received: (qmail invoked by alias); 04 Sep 2007 12:58:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 04 Sep 2007 14:58:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VVCh0VUDVeCFvkNv+3OJZBRfb4crwHM8YZv6e1m
	f/zLUqp9SfsMtS
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709041324420.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57560>

Hi,

On Tue, 4 Sep 2007, Johannes Schindelin wrote:

> On Tue, 4 Sep 2007, Johannes Sixt wrote:
> 
> > Johannes Schindelin schrieb:
> > > On Tue, 4 Sep 2007, Johannes Sixt wrote:
> > > > Therefore, I've pushed out a fixup patch at the top of mingw.git's 
> > > > devel branch that converts mtime to local time
> > > 
> > > On Linux, we compare to UTC to begin with, right?  We should do that 
> > > here, too...  So if time(NULL) does not return UTC on MinGW, we have 
> > > to wrap that function, too.
> > 
> > According to MSDN, time(NULL) returns "the number of seconds elapsed 
> > since [epoch] according to the system clock". Please don't ask me what 
> > "the system clock" is.
> 
> I think I know.  From my QEmu adventures I know that DOS/Windows expects 
> the system clock to be set to local time, in contrast to _all_ other 
> operating systems.

Now I am utterly confused.  MSDN says

	FILETIME

	Contains a 64-bit value representing the number of 100-nanosecond 
	intervals since January 1, 1601 (UTC).

Hmm.

Ciao,
Dscho
