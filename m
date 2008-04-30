From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Wed, 30 Apr 2008 12:56:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804301253520.2136@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness>
 <7vk5ig745b.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness> <7v1w4o3zle.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness> <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 13:57:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrAw9-000211-W2
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 13:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937AbYD3L4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 07:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757930AbYD3L4i
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 07:56:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:43376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756526AbYD3L4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 07:56:37 -0400
Received: (qmail invoked by alias); 30 Apr 2008 11:56:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 30 Apr 2008 13:56:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Cy5VxLmPCI7EU+Xrn8LBl5suppDCOCCe4mlca44
	YA69mH/KkTr6gn
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80829>

Hi,

On Wed, 30 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> But instead you are thinking of letting me just say "X", and somehow 
> >> make the machinery guess by noticing "Ah, original X is a merge between 
> >> original A and B, and we have a merge between rewritten A and rewritten 
> >> B, so we will treat that merge as rewritten "X"?
> >> 
> >> I actually was hoping we could avoid that, which feels messy.
> > ...
> > But this got me thinking, and I think that to leave out the first parent 
> > was another mistake I made, so I really would like to have this syntax:
> >
> > 	merge <orig-commit> <parent1> <parent2>... <message>
> >
> > This would allow to change the parents in the interactive rebase, and if 
> > <parent1> is not the current commit at that point, it would implicitly 
> > call "reset".
> >
> > What appeals to me is the simplicity of this approach: you refer to the 
> > commits by calling them by their (original) name.
> 
> Ok, that clears my confusion, but it raises another issue.
> 
> In the context of "rebase -i", this may not be a problem, but by forcing
> us to name commits always with original commits, we cannot build (instead
> of rebuild) a history that does not yet exist using the sequencer
> machinery, can we?

The idea I hinted at was to refer to them by another name than the short 
name.  Then we can use the sequencer machinery.

I still maintain that it is such a rare need (even if you are a power user 
of it) that it makes sense to cater for other, simpler uses.

Ciao,
Dscho
