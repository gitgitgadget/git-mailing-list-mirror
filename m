From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 17:29:52 -0700
Message-ID: <BLU0-SMTP889B2109047E949E039EFDAEBF0@phx.gbl>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
	<BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
	<alpine.LNX.2.00.0910202001050.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 02:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0P5V-0001oy-GA
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 02:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbZJUA3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 20:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbZJUA3v
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 20:29:51 -0400
Received: from blu0-omc1-s14.blu0.hotmail.com ([65.55.116.25]:33992 "EHLO
	blu0-omc1-s14.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640AbZJUA3v (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 20:29:51 -0400
Received: from BLU0-SMTP88 ([65.55.116.7]) by blu0-omc1-s14.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 17:29:55 -0700
X-Originating-IP: [66.183.8.119]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from lex.hookers.net ([66.183.8.119]) by BLU0-SMTP88.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Oct 2009 17:29:55 -0700
In-Reply-To: <alpine.LNX.2.00.0910202001050.14365@iabervon.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.6; x86_64-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2009 00:29:55.0128 (UTC) FILETIME=[9CAACB80:01CA51E5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130874>

On Tue, 20 Oct 2009 20:15:23 -0400 (EDT)
Daniel Barkalow <barkalow@iabervon.org> wrote:

Hi Daniel,

> Surely, "where you want the head stored locally" is somewhere that's 
> information about a remote repository, and therefore under "refs/remotes/" 
> (or "refs/tags/" or something) and therefore not possible to be checked 
> out (in the "HEAD is a symref to it" sense).

Maybe, but it could also just be to create a temp local branch for
merging into additional branches afterward with "checkout other;
merge temp".   This is especially helpful when pulling from an
annoyingly long URL instead of from a configured remote.
 
> I don't think it should be possible to fast-forward or create a local 
> branch from a remote branch while simultaneously merging it into the 
> currently-checked-out local branch.

What is the harm?   Nobody is forced to use the facility and it does
have some marginal utility.   I'd not fight for it, but i don't yet
understand the argument to prohibit it.

> Actually, I think it would be good to prohibit fetching into a new or 
> existing local branch, whether or not it is checked out. We'd probably 
> need to provide a plumbing method of doing a fetch, though, for script 
> environments that aren't using the normal porcelain meanings of refs/ 
> subdirectories. (Defining a bare repo with --mirror as not having local 
> branches, of course)

I'm hoping you don't mean that all fetching to a new local branch should
be prohibited and you're only talking about the current issue of full
refspecs on and the pull command.   Otherwise i'd say it seems
unnecessarily restrictive.

Cheers,
Sean
