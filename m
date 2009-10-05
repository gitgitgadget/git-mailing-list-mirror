From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 5 Oct 2009 23:26:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910052318230.4985@pacific.mpi-cbg.de>
References: <4AC8F22F.5070101@gmail.com> <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de> <6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com> <alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de> <fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com>
 <6672d0160910050910x3a9aa6a3w742c09e7f2f42187@mail.gmail.com> <87ab05r5hg.fsf@dylle.kalibalik.dk> <alpine.DEB.1.00.0910052248500.4985@pacific.mpi-cbg.de> <7vbpkl8s8x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anders Melchiorsen <mail@spoon.kalibalik.dk>,
	=?ISO-8859-15?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:32:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muv9s-0000SI-Fl
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbZJEVY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 17:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbZJEVY2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:24:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:48870 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754086AbZJEVY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 17:24:27 -0400
Received: (qmail invoked by alias); 05 Oct 2009 21:23:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 05 Oct 2009 23:23:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/epxgsa1Le6zlSiWf0Gvs3cTO96uyXsXI5BxylJc
	Q6Edsd/1Aqz9zY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vbpkl8s8x.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129595>

Hi,

On Mon, 5 Oct 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Being in an editor but still not able to fix typos is a nuisance.
> >
> > NAK.
> >
> > Supporting that would be totally out of line with the way rebase -i is 
> > supposed to work.
> 
> If the rebase insn sheet were richer, and had a way to show the full
> message, like this:
> 
> pick 4973aa2 git-pull: dead code removal
>     Back when a74b170 (git-pull: disallow implicit merging to detached HEAD,
>     2007-01-15) added this check, $? referred to the error status of reading
>     HEAD as a symbolic-ref; but cd67e4d (Teach 'git pull' about --rebase,
>     2007-11-28) moved the command away from where the check is, and nobody
>     noticed the breakage.  Ever since, $? has always been 0 (tr at the end of
>     the pipe to find merge_head never fails) and other case arms were never
>     reached.
>     
>     These days, error_on_no_merge_candidates function is prepared to handle a
>     detached HEAD case, which was what the code this patch removes used to
>     handle.
>     
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> I do not see why we shouldn't allow people to edit any part of the above
> to reword.
> 
> I would even understand (but not necessarily agree) if somebody wants to
> give the patch text and let users edit to reapply.
> 
> So I do not agree with your "totally out of line" at all.

Are you serious?  "rebase -i" was _always_ about showing an edit script, 
i.e. to tell Git _what_ you want to do with _which_ commits, identified by 
short commit names.

The oneline was _always_ meant as a pure convenience for the user.

This paradigm has been true even to back when "rebase -i" was still called 
"edit-patch-series", and that is the reason I claimed that it is totally 
out of line.  Because it is.

> > Besides, if you already have typos in the commit subject, you _better_ 
> > check the whole commit message, so: double NAK.
> 
> That sounds a bit too dogmatic.
> 
> But I tend to agree with you that we would be better off not accepting
> such a "retitle" patch, as it strongly encourages single-liner commit log
> messages.

Now, that is at least as dogmatic as what I proposed.

> Oh, there was no patch?  Then nevermind...

Sorry, but I changed my mind on this attitude.  Earlier, you would find me 
valuing arguments only when backed up by code.  But since the GitTogether 
in Berlin I know of at least one discussion where somebody simply had not 
enough time to back up a (submodule-related) argument, the validity of the 
argument notwithstanding.

So not always is a "no patch? Nevermind" the correct thing to do.

In this particular case, however, I agree.  Just touching up the first 
line of commit messages is such a special case, and so removed from what a 
"rebase" is about that I would claim that this case would be better 
handled by a really trivial shell script that launches an editor and then 
drives filter-branch based on what the user said.

Ciao,
Dscho
