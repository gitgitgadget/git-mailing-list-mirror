From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote show: fix the -n option
Date: Mon, 9 Jun 2008 05:53:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806090551070.1783@racer>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <alpine.DEB.1.00.0806090212270.1783@racer> <484C901B.6000401@free.fr>
 <alpine.DEB.1.00.0806090330490.1783@racer> <484CAE95.3020008@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-494365117-1212987199=:1783"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 09 06:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5ZPi-0004iD-Kz
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 06:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbYFIEyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 00:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYFIEyd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 00:54:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:56711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751515AbYFIEyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 00:54:32 -0400
Received: (qmail invoked by alias); 09 Jun 2008 04:54:30 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 09 Jun 2008 06:54:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192FJIDnVF2uCx0i4BwMiPcIpUlV9Fp81+xNhymBd
	pDoZxDPrm673lG
X-X-Sender: gene099@racer
In-Reply-To: <484CAE95.3020008@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84361>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-494365117-1212987199=:1783
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 9 Jun 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> > 
> > No, I think that the information about stale branches and if the 
> > branches are up-to-date is missing.  In that sense, it is not like 
> > "route -n" at all, which just skips one convenience step, but really a 
> > dry run, because the result is different (as opposed to differently 
> > displayed).
> 
> Am I wrong if I say that dry run is for commands that modify something? 
> For example there is no "diff --dry-run" probably because diff does not 
> change anything. A dry run has no real meaning for diff.

For me, a dry run is something that avoids the high-cost operations.

Something like, uhm, a dry run of a ship.

> >> In fact, it seems that get_ref_states() always return 0 or just die 
> >> when an error occur. And that transport_get_remote_refs() never 
> >> return if something goes wrong.
> >>
> >> So, what about removing got_states and use !no_query instead ?
> > 
> > Hrmpf.  I did not mean to die() there...
> 
> I don't understand. Is it ok or not?

I would not like to remove the got_states.  I think this is the wrong 
direction.  Rather change the die() into a return error().

Ciao,
Dscho

--8323329-494365117-1212987199=:1783--
