From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] make shallow repository deepening more network
 efficient
Date: Sat, 26 Sep 2009 15:26:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909261524490.4985@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0909031847520.6044@xanadu.home> <7vmy58r72b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 15:29:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrXL1-0007hj-JQ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 15:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbZIZNYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 09:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbZIZNYH
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 09:24:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:52589 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752175AbZIZNYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 09:24:06 -0400
Received: (qmail invoked by alias); 26 Sep 2009 13:24:09 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 26 Sep 2009 15:24:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hcnpT7IwhUs/l+8e4Tjm9bouLsRMgxkG9VHcT0l
	bejC/RGLpDnwVY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vmy58r72b.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129152>

Hi,

On Sat, 5 Sep 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > First of all, I can't find any reason why thin pack generation is 
> > explicitly disabled when dealing with a shallow repository.  The 
> > possible delta base objects are collected from the edge commits which 
> > are always obtained through history walking with the same shallow refs 
> > as the client, Therefore the client is always going to have those base 
> > objects available. So let's remove that restriction.
> >
> > Then we can make shallow repository deepening much more efficient by 
> > using the remote's unshallowed commits as edge commits to get preferred 
> > base objects for thin pack generation.  On git.git, this makes the data 
> > transfer for the deepening of a shallow repository from depth 1 to depth 2
> > around 134 KB instead of 3.68 MB.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
> Dscho, this is your code from around ed09aef (support fetching into a
> shallow repository, 2006-10-30) and f53514b (allow deepening of a shallow
> repository, 2006-10-30).  The latter disables thin pack transfer but the
> log does not attempt to justify the change.
> 
> Have any comments?

Unfortunately, I do not have any.  I tried to remember, then I tried to 
find some documentation, but stopped when I found out that I developed 
the code on an iBook which died early Nov 2006.

So no, I do not remember why the change.

Sorry,
Dscho
