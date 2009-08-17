From: Mike Galbraith <efault@gmx.de>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 04:21:22 +0200
Message-ID: <1250475682.7155.16.camel@marge.simson.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
	 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
	 <20090816122842.GA942@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
	 <20090816135703.GA31638@coredump.intra.peff.net>
	 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 04:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McrrS-0006Fx-1k
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 04:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623AbZHQCV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 22:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756612AbZHQCV0
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 22:21:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:39184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756479AbZHQCVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 22:21:25 -0400
Received: (qmail invoked by alias); 17 Aug 2009 02:21:25 -0000
Received: from p4FE1A217.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [79.225.162.23]
  by mail.gmx.net (mp006) with SMTP; 17 Aug 2009 04:21:25 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX19FLNxuiB5FXEci9XyP9By7UcZoUHj/i01xyyk6D4
	5I2jr//d530kCr
In-Reply-To: <7vmy5z603d.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.24.1.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126108>

On Sun, 2009-08-16 at 12:16 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Subject: [PATCH] docs: mention how to break alternates dependency
> >
> > A user who has created a repository dependency by using "git
> > clone -s" does not necessarily know where to look to find
> > out how to break that dependency. Let's mention it right
> > under "-s", where they are most likely to find it.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  Documentation/git-clone.txt |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> > index b14de6c..87fa687 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -72,6 +72,11 @@ These objects may be removed by normal git operations (such as 'git-commit')
> >  which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
> >  If these objects are removed and were referenced by the cloned repository,
> >  then the cloned repository will become corrupt.
> > ++
> > +To break the dependency of the cloned repository to the source
> > +repository, run `git repack -a` in the cloned repository, which will
> > +create a new pack in that repository with all referenced objects,
> > +including those in the source repository.
> 
> After reading this, two points come to my mind.  They may or may not be
> issues.
> 
>  (1) Such a user does not necessarily know a casual "git repack -a" breaks
>      the dependency, defeating the -s option s/he deliberately used in
>      order to save disk space in the first place.  Perhaps we can reword
>      this further to kill two penguins with a single stone?

Perhaps a runtime warning that you're about to break it?  This user may
not even be the one who set the thing up, no?

	-T. Peanut Gallery
