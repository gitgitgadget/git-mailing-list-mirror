From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a
 foreign vcs
Date: Wed, 12 Aug 2009 03:45:21 -0400
Message-ID: <20090812074521.GD15152@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
 <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
 <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
 <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
 <20090811214849.GA3868@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908120128120.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 12 09:45:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb8WZ-00040w-Dy
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 09:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZHLHpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 03:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbZHLHpV
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 03:45:21 -0400
Received: from peff.net ([208.65.91.99]:53412 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbZHLHpV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 03:45:21 -0400
Received: (qmail 9674 invoked by uid 107); 12 Aug 2009 07:45:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 Aug 2009 03:45:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Aug 2009 03:45:21 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908120128120.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125678>

On Wed, Aug 12, 2009 at 01:53:38AM +0200, Johannes Schindelin wrote:

> > It is not actually that unreasonable. I have remotes which point to:
> > 
> >   vcs:git/foo.git
> 
> That is still not "svn".

No, but you snipped the part where I explain how that leads me to
believe "svn" is plausible. Remember that you and I are just a
representative sample of a much larger userbase.

There is also a related question: should the the meaning of the URL rely
purely on _syntax_, or must we understand the _semantics_ of the
individual tokens? That is, given $X:$Y, does that syntactically mean
that $X _must_ be a remote helper, or must I understand what helpers git
knows about to know what it is?

I tend to think purely syntactic systems are more robust and easier to
understand. The downside is that it's less DWIM, which can often mean
more typing.

> If _I_ were to judge whether to make it convenient for computer-savvy 
> people like you who would have _no_ problem diagnosing the problem (_if_ 
> they have the problem, having edited .ssh/config themselves!), who would 
> curse briefly, and then go on fixing the problem, or in the alternative 
> make it convenient for people who do not know their way around .ssh/config 
> as well as you (and who happen to make up the _vast_ majority of Git users 
> by now [*1*]), and who would really prefer to have an easy way to clone 
> "foreign" repositories, I have _no_ problem deciding which way to go.
> 
> So I'm a bastard.  Big news.  But I'm a pragmatic one.

You didn't quote the part of my email about how ssh:// sucks. It is not
just about having my config break, figuring it out, and fixing it. You
are losing a useful construct that I might be using on the command line.

That being said, I am not 100% opposed to the proposal. I just think it
is worth considering this breakage as a downside, and considering

  1. Is there some other syntax that _doesn't_ have this breakage
     but that similarly helps the "vast majority of Git users".

  2. Should such a breakage follow a deprecation schedule, and if so,
     what schedule?

-Peff
