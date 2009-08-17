From: Mike Galbraith <efault@gmx.de>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 09:12:53 +0200
Message-ID: <1250493173.9178.8.camel@marge.simson.net>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
	 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
	 <20090816122842.GA942@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
	 <20090816135703.GA31638@coredump.intra.peff.net>
	 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
	 <1250475682.7155.16.camel@marge.simson.net>
	 <20090817064801.GA31543@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 09:13:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McwOu-0001Q6-Ec
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 09:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbZHQHM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 03:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbZHQHMz
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 03:12:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:41348 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750831AbZHQHMz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 03:12:55 -0400
Received: (qmail invoked by alias); 17 Aug 2009 07:12:55 -0000
Received: from p4FE1A217.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [79.225.162.23]
  by mail.gmx.net (mp030) with SMTP; 17 Aug 2009 09:12:55 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1+rknBUgqSr6rVQhfBJCr89yiD+FCJJ+wYBQimPWw
	smLWmFWm4vGa3c
In-Reply-To: <20090817064801.GA31543@coredump.intra.peff.net>
X-Mailer: Evolution 2.24.1.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126129>

On Mon, 2009-08-17 at 02:48 -0400, Jeff King wrote:
> On Mon, Aug 17, 2009 at 04:21:22AM +0200, Mike Galbraith wrote:
> 
> > >  (1) Such a user does not necessarily know a casual "git repack -a" breaks
> > >      the dependency, defeating the -s option s/he deliberately used in
> > >      order to save disk space in the first place.  Perhaps we can reword
> > >      this further to kill two penguins with a single stone?
> > 
> > Perhaps a runtime warning that you're about to break it?  This user may
> > not even be the one who set the thing up, no?
> 
> I'm not really sure what such a setup would look like. If it is a big
> hosting site like kernel.org or repo.or.cz, then probably it wouldn't
> matter much. The admins there should probably be running "git repack -l
> -d -A" periodically to consolidate the object stores (which can happen
> from this sort of repacking, or from people just pushing the same
> commits to their repos).
> 
> That being said, I can see there being setups where such a warning might
> be useful. However, we don't really know if the user _wants_ that
> effect, or if it is an accident. So people following the recommnded
> "here is how you break the dependency" advice will also get the warning.
> 
> I'm torn on whether this is actually a good idea.

Yeah.  There are any number of ways to shoot oneself in the foot, and
while on the one hand idiot proofing can be nice if you were about to
screw up, "really really?" messages are most frequently annoying noise.

	-Mike
