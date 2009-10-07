From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Thu, 8 Oct 2009 00:28:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910080027270.4985@pacific.mpi-cbg.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
 <7vr5thacb4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de> <4ACB22E9.3010001@web.de> <7vocok21pw.fsf@alter.siamese.dyndns.org> <4ACCECE6.1030508@web.de> <7vd44zt1nf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 00:34:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvf55-00011l-KF
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 00:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZJGW0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 18:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbZJGW0e
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 18:26:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:56257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753552AbZJGW0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 18:26:33 -0400
Received: (qmail invoked by alias); 07 Oct 2009 22:25:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 08 Oct 2009 00:25:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Avkd90SOAmrPKWBx92zx9G7oMY9FzDJr+bC8OHJ
	fYriezeFHF2YuT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vd44zt1nf.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129662>

Hi,

On Wed, 7 Oct 2009, Junio C Hamano wrote:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> > So i took a live repo from my dayjob containing 8 submodules. In each
> > submodule i did a "git checkout HEAD^" to simulate one change.
> 
> It appears that your "simulation" is to have changes in all submodules 
> and nowhere else in the tree.  I have to wonder how common would that 
> be.  If I have been working in the subprojects without changing the 
> superproject at all, I would likely to be in one of the subproject 
> directories and my "git diff" would not even have to trigger this 
> codepath.  If we have on the other hand changes in the superproject, 
> showing them would cost us equally in both approaches.
> 
> > then i got:
> >
> >   without fork : real	0m0.203s
> >   with fork    : real	0m0.453s
> >
> > This is a degradation of more than 120% because of the fork()s. And
> > just for fun i ran the scripted submodule summary too:
> >
> >   scripted     : real	0m3.437s
> >
> > So the forked version outperforms the scripted version by a factor of
> > 7, while the speedup from Dscho's original proposal is almost 17fold.
> 
> Thanks.  I was worried if the forking to ensure correctness may sactifice
> performance so much to be unusable, but it does not seem to be the case,
> given the above comparision.
> 
> I didn't look at the code but presumably it uses the run_command()
> interface and cleanly written?

You seem to be rather unconvinced by rather convincing numbers.

Therefore, I will continue working on the --submodule-summary stuff in 
4msysgit.git.

Ciao,
Dscho
