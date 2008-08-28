From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 17:21:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808281719130.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <80myizelcw.fsf@tiny.isode.net> <20080826173512.GS10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bruce Stephens <bruce.stephens@isode.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Kristian H?gsberg <krh@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	users@kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjFV-0007nH-NS
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbYH1PQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbYH1PQV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:16:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:60920 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbYH1PQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:16:20 -0400
Received: (qmail invoked by alias); 28 Aug 2008 15:16:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 28 Aug 2008 17:16:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hX+t7iUNho5e2RIvQE3mwH6CS7EW1tOj8hQzGWY
	s9dIpYDNbEodd1
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080826173512.GS10544@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94067>

Hi,

On Tue, 26 Aug 2008, Petr Baudis wrote:

> On Tue, Aug 26, 2008 at 06:29:03PM +0100, Bruce Stephens wrote:
> >   - it means git on Windows has the same interface
> > 
> > (Arguably the latter point ought to be "forces Unix users to use the
> > same interface as on Windows", but the git-foo forms have been
> > deprecated on all platforms for a while.  Making Unix and Windows the
> > same seems a worthwhile goal, though presumably it's irrelevant for
> > linux kernel people.)
> 
> I actually checked, and my msysgit installation does hardlinking (or at
> least pretends to do, and ls -l shows high linkcounts). And somewhat
> amusingly, it doesn't appear that 1.6.0 will be released for Windows
> anytime soon, though that's of course not relevant from long term
> perspective.

That is correct.  Even more amusingly, it cannot be released ATM because 
of a breakage _caused_ by the move into libexec: on Windows, we _want_ to 
be as relocatable as possible, i.e. not having an _absolute_ exec path 
compiled in.  So we use a relative one.  And that's the rub: from bin/ 
(for "git") and from libexec/git/ (for almost all others), there is no 
single relative path to etc/.

Funny, eh?
Dscho
