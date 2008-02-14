From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 15:08:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141505440.30505@racer.site>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com> <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com> <18355.42595.377377.433309@lisa.zopyra.com> <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com>
 <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org> <20080214140152.GT27535@lavos.net> <alpine.LFD.1.00.0802140945520.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 16:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPfi8-0006NU-0I
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 16:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785AbYBNPIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 10:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756658AbYBNPIl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 10:08:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:33937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755898AbYBNPIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 10:08:39 -0500
Received: (qmail invoked by alias); 14 Feb 2008 15:08:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 14 Feb 2008 16:08:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19avZIImFNa+X4/vtJLtAkPeVnlvxpkZfB9T2z+O0
	OD77lstXxcsnPE
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802140945520.2732@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73880>

Hi,

On Thu, 14 Feb 2008, Nicolas Pitre wrote:

> On Thu, 14 Feb 2008, Brian Downing wrote:
> 
> > When deleting a branch, is there any reason we can't add a deletion 
> > entry into the reflog and keep the reflog around?  This would seem to 
> > be a lot safer; I know I've been burned by expecting the reflog safety 
> > net to be there, and surprised that it's not when I've deleted a 
> > branch.
> 
> No.  That would only accumulate dead reflog files in the repository.
> 
> And as Junio said above, the "HEAD" reflog contains everything you moved 
> to, including detached heads, and of course branch heads that might now 
> be deleted.  You can easily retrieve a deleted branch head from there.

Note that you do not necessarily update branches while they are HEAD:

	$ git push . to-fast-forward:HEAD

But that's too fabricated an example, I guess.

So I agree that HEAD reflog is enough.

Ciao,
Dscho
