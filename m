From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix for a merge where a branch has an F->D transition
Date: Wed, 13 May 2009 11:59:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905131159180.5046@intel-tinevez-2-302>
References: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com>  <20090511192536.GA1485@blimp.localdomain>  <7v63g57ce4.fsf@alter.siamese.dyndns.org> <81b0412b0905122338q774454cj65edfde3d73948e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1101699742-1242208771=:5046"
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4BFU-0004ce-PT
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914AbZEMJ7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 05:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbZEMJ7c
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 05:59:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:52295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755382AbZEMJ7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 05:59:31 -0400
Received: (qmail invoked by alias); 13 May 2009 09:59:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 13 May 2009 11:59:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UBSss/j8UfU0s5NZFOM8P28BI+oftQD4u7kTIan
	VVEdIrH5WlBnIk
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <81b0412b0905122338q774454cj65edfde3d73948e3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119019>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1101699742-1242208771=:5046
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 13 May 2009, Alex Riesen wrote:

> 2009/5/13 Junio C Hamano <gitster@pobox.com>:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> >> Frankly, I'm not really sure. The solution came largely ... empirical
> >> way. IOW, I tried more or less random things which looked like they
> >> should fix the problem. So a review is very much appreciated. Please.
> >
> > I've always thought that D/F conflict logic in merge-recursive is placed
> > at the wrong processing phase.  IIRC, it enumerates potential D/F
> > conflicting paths before even attempting to process renames, and it is
> > easy to miss a path that was previously file going away as the result of a
> > clean merge (in which case it is ok to have a directory there as the
> > result of a merge for other paths).  This breakage could be a small
> > example of it.
> >
> > Regardless, I think your patch is a reasonable fix to go to the
> > maintenance track.  Thanks for looking into it.
> 
> I'm afraid the fix is not that simple: the "if" branch where the change
> is placed supposed to prevent updating files in the working tree
> which already have the same content as the merge's output.
> My change may force them to be updated regardless. I think...
> Johannes, you know this area the best, could you please have
> a look?

Sorry, no time at the moment...

Ciao,
Dscho

--8323329-1101699742-1242208771=:5046--
