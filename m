From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 6 Oct 2009 14:02:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910061359560.4686@intel-tinevez-2-302>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <20091005225611.GB29335@coredump.intra.peff.net> <200910060932.24377.trast@student.ethz.ch> <alpine.DEB.1.00.0910061112570.4985@pacific.mpi-cbg.de>
 <7vvdis21qk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 14:03:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv8lm-0005vX-Tc
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 14:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbZJFMDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 08:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756240AbZJFMDb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 08:03:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:54997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754886AbZJFMDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 08:03:30 -0400
Received: (qmail invoked by alias); 06 Oct 2009 12:02:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 06 Oct 2009 14:02:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q5DgIqWSqHDf0wcckURXUEQObuBcbssPIoCk+jC
	nz5QbhERXRZFUF
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vvdis21qk.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129626>

Hi,

On Tue, 6 Oct 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> 4. Are there any (scripted?) use-cases where git-checkout should fail
> >>    because it was given an invalid branch name?
> >> 
> >> The following gives a hint, though they could of course be fixed and
> >> the ^0 case doesn't really count:
> >> 
> >>   $ git grep 'git checkout .*||' -- "*.sh"
> >>   git-bisect.sh:        git checkout "$start_head" -- || exit
> >>   git-rebase--interactive.sh:  output git checkout $first_parent 2> /dev/null ||
> >>   git-rebase--interactive.sh:  output git checkout "$1" ||
> >>   git-rebase.sh:git checkout -q "$onto^0" || die "could not detach HEAD"
> >>   t/t2007-checkout-symlink.sh:git checkout -f master || exit
> >
> > Actually, in said cases (with exception of the test case, which should be 
> > fine, however, having no remote branches), I would expect the user to be 
> > grateful if the DWIMery would happen.
> 
> Did you check the context before making that assertion?

No, but I checked the _names_ of the scripts.

In case of bisect, if I know upstream is good, I might indeed say "git 
bisect good next", even if I haven't checked myself earlier.

In case of "rebase", about the same happens: if I say "git rebase next", 
and there is no "next", but an "origin/next", and no other remote branch 
"*/next", it is pretty clear what I mean, too.

In any case, it seems pretty clear to me that this DWIMery, while I am 
pretty certain would be useful for actual users without commits in 
git.git, will not make it into git.git.

So I'll stop wasting my time with this discussion.

Ciao,
Dscho
