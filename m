From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 12 Feb 2009 12:04:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902121200420.10279@pacific.mpi-cbg.de>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
 <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com> <20090129115026.GB10792@coredump.intra.peff.net> <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com> <20090130045131.GB18655@coredump.intra.peff.net> <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
 <7vr62j0wpc.fsf@gitster.siamese.dyndns.org> <7v3aekqhpo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZOD-0003MZ-Ql
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 12:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621AbZBLLDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 06:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757534AbZBLLDs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 06:03:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:58657 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757115AbZBLLDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 06:03:47 -0500
Received: (qmail invoked by alias); 12 Feb 2009 11:03:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 12 Feb 2009 12:03:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197RM5s5Bl74MbLTjxHJB/6gEWZsDRCLb7fZiBITL
	PkIqLtjnoa/Oq0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v3aekqhpo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109601>

Hi,

On Wed, 11 Feb 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> How about installing
> >>
> >> 	[branch "master"]
> >> 		remote = origin
> >> 		merge = refs/heads/master
> >>
> >> by default?  It is a safe bet that this will be the case for 99% of all 
> >> users that want to clone an empty repository (especially if they are 
> >> putting their public repositories on something like repo.or.cz, where you 
> >> cannot change the default branch from "master" to something else).
> >
> > I think this is a reasonable thing to do.
> 
> So I've been sort of waiting for a trivial patch to materialize, and then
> almost forgot about it like everybody else did.  Before all of us forget,
> here is my attempt to do the above.

Thanks.

> We seem to have acquired a bad habit of discussing and agreeing on a 
> potential improvement and then not following through, forgetting it 
> altogether.

Yeah, I am pretty excited at my rebase -i -p branch at the moment, so I am 
prone to forget other things (push --track included).

> And no, a bug tracker is not the answer, even though it could be a 
> (small) part of the solution.

If you really want to know how much a bug tracker is not the solution, 
because it is a fire-and-forget (as in post, and never come back, 
even with a small little message that the fix actually worked) place for 
many bug reporters, just look at msysGit's bug tracker and weep.

> diff --git a/builtin-clone.c b/builtin-clone.c
> index f73029e..431c136 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -350,6 +350,18 @@ static struct ref *write_remote_refs(const struct ref *refs,
>  	return local_refs;
>  }
>  
> +static void install_branch_config(const char *origin, const char *local,
> +				  const char *remote)

I would have used a different order (local, origin, remote), but that's 
okay, I guess.

Ciao,
Dscho
