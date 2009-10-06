From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Tue, 6 Oct 2009 14:10:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910061409440.4686@intel-tinevez-2-302>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
 <7vr5thacb4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de> <4ACB22E9.3010001@web.de> <7vocok21pw.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910061344070.4686@intel-tinevez-2-302> <4ACB2F2D.8010503@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 14:14:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv8vV-0002QS-Lj
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 14:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbZJFMLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 08:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbZJFMLg
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 08:11:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:40599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932217AbZJFMLg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 08:11:36 -0400
Received: (qmail invoked by alias); 06 Oct 2009 12:10:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp009) with SMTP; 06 Oct 2009 14:10:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gIlFTkufgijuMmrTKj3ADqbQfzx5KyQkCvKxjBT
	1lfmkBfNXytMzw
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4ACB2F2D.8010503@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129627>

Hi,

On Tue, 6 Oct 2009, Jens Lehmann wrote:

> Johannes Schindelin schrieb:
> > Hi,
> > 
> > On Tue, 6 Oct 2009, Junio C Hamano wrote:
> > 
> >> Jens Lehmann <Jens.Lehmann@web.de> writes:
> >>
> >>>> But I really, really, really want to avoid a fork() in the common case.  I 
> >>>> do have some users on Windows, and I do have a few submodules in that 
> >>>> project.  Having too many fork() calls there would just give Git a bad 
> >>>> reputation.  And it has enough of that, it does not need more.
> >>> Me too thinks performance matters here. We do have a repo at my dayjob
> >>> with more than a handful of submodules and its main target platform is
> >>> windows ... so having that perform nicely is a win for us.
> >> Numbers?
> >>
> >> I'd prefer to avoid kludges that favors unsubstantiated performance
> >> argument over correctness.
> > 
> > Well, having worked with msysGit for such a long time, I just _know_ that 
> > a subprocess costs a substantial amount of time.
> > 
> > But as you don't trust my words, maybe Jens could be so kind as to perform 
> > some benchmarks?  I am short on Git time budget, but I will make a commit 
> > on my submodule-summary branch that allows to start a subprocess always.
> 
> Sure, will do.

Okay, it is there.  It is quick and dirty, so you don't even want to look 
at the commit message.

Could you please run something like "time git diff --submodule-summary 
--all" with and without this patch?

Thanks,
Dscho
