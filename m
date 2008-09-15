From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to replace a single corrupt, packed object?
Date: Mon, 15 Sep 2008 16:05:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809151603390.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.1.10.0808102139050.22892@xanadu.home>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1946912584-1221487557=:13830"
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 16:01:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfEdl-0004Ml-Gi
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 16:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbYIOOAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 10:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbYIOOAL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 10:00:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:40471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752864AbYIOOAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 10:00:10 -0400
Received: (qmail invoked by alias); 15 Sep 2008 14:00:07 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 15 Sep 2008 16:00:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19k145vsgZkK1EQuyxArcrxFMfqYvmV6JaTrd5N9o
	BGLoT55h/SWlMz
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LFD.1.10.0808102139050.22892@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95908>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1946912584-1221487557=:13830
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 10 Aug 2008, Nicolas Pitre wrote:

> [ sorry for the delay -- I just returned from vacation ]

No need to be sorry; my delay is even worse...

> On Fri, 8 Aug 2008, Johannes Schindelin wrote:
> 
> > my auto gc kicked in, and shows this:
> > 
> > fatal: corrupt packed object for 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> > error: failed to run repack
> > 
> > Fortunately, I have the uncorrupted object somewhere else.  So I copy the 
> > single object as a loose one, and all is fine.  Right?
> > 
> > Wrong.
> 
> Well, to be sure things are then right or wrong, just do a 
> 
> 	git show 2c1e128aa51e3a64bd61556c0cd488628b423ccf
> 
> If you can't see the object before, and are able to see it once it has 
> been copied over, then things are "right".
> 
> > Repack still picks up the corrupt object instead of the good one.  
> > What's the best way out?
> 
> How do you repack?  The only way to get rid of a corrupted object in 
> that case is to 'git repack -a -f'.

Turns out I am a complete, utter moron.  And I am sure René will quote me 
on that.

Git would probably have taken the copied-over object, and now took the 
copied-over pack (finally!).

My mistake was to keep the .keep file.  And the corrupt object was -- you 
guessed it -- in the corresponding .pack file.

Aaaaargh,
Dscho

--8323329-1946912584-1221487557=:13830--
