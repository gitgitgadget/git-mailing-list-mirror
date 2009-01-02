From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 19:17:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021914420.30769@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <alpine.LFD.2.00.0901011151440.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIobR-0005Qj-UU
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683AbZABSRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbZABSRJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:17:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:59004 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753400AbZABSRI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:17:08 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:17:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 02 Jan 2009 19:17:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EL+1O6dmE07XT+pPb7Iwi+22/YzT/0D1BqqYsbS
	ZNQQKSgxdwzPNH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0901011151440.5086@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104397>

Hi,

On Thu, 1 Jan 2009, Linus Torvalds wrote:

> On Thu, 1 Jan 2009, Linus Torvalds wrote:
> > 
> > So could we have some actual real data on it?
> 
> .. and some testing. I tried to get some limited data for the kernel 
> myself, by doing
> 
> 	git log --patience -p v2.6.28.. > ~/patience
> 
> but I just got a core-dump instead.
> 
> Pinpointing it to a specific commit shows a smaller failure case:
> 
> 	git show -p --patience 05d564fe00c05bf8ff93948057ca1acb5bc68e10
> 
> which might help you debug this.

Thanks.  I am on it.  valgrind finds an earlier place in 
xdl_change_compact() which I think is rather more sensible, but at the 
same time a bit worrisome, too, as I did not expect any errors _that_ 
late in the game (I did not touch that code).

BTW the "-p" is not necessary with "show", indeed, you cannot even switch 
it off.

Ciao,
Dscho
