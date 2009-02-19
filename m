From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Thu, 19 Feb 2009 01:46:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902190142440.10279@pacific.mpi-cbg.de>
References: <200902151711.45099.trast@student.ethz.ch> <20090215181818.GA2291@coredump.intra.peff.net> <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com> <20090217163413.GB31297@sigill.intra.peff.net> <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com>
 <20090217202731.GA16586@coredump.intra.peff.net> <20090218064121.GA16611@coredump.intra.peff.net> <alpine.DEB.1.00.0902181113210.6274@intel-tinevez-2-302> <20090218101615.GA23035@coredump.intra.peff.net> <alpine.DEB.1.00.0902181251160.6274@intel-tinevez-2-302>
 <20090219003727.GA25808@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZx47-00021G-Ld
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 01:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbZBSAp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 19:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZBSAp2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 19:45:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:53893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751816AbZBSAp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 19:45:27 -0500
Received: (qmail invoked by alias); 19 Feb 2009 00:45:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 19 Feb 2009 01:45:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nJPMpiK9nEM++vpQcJLdK5L3ei0e+hLaCz8MsCJ
	HpJAyfA4gCsc61
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090219003727.GA25808@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110598>

Hi,

On Wed, 18 Feb 2009, Jeff King wrote:

> On Wed, Feb 18, 2009 at 12:53:37PM +0100, Johannes Schindelin wrote:
> 
> > > Really? Are they not easily replaced with
> > > 
> > > -test cond1 -a cond2 -o cond3
> > > +test cond1 && test cond2 || test cond3
> > 
> > ...which is substantially harder to read.
> 
> I don't agree that it is harder to read, but that is beside the point.
> What is important is whether or not the construct is portable enough to
> meet git's standards.
> 
> "-a" and "-o" are XSI extensions to POSIX, which is usually a sign that
> there may be problems. However, besides posh (which at this point I
> think can be considered a compliance-testing shell and not an actual
> shell in use), I haven't heard of problems in practice. Even FreeBSD's
> ash derivative supports it (along with parentheses).
> 
> So I don't think it needs to be changed (which is what I said in my
> original message). But I also think saying "-a and -o are necessary" is
> not true; they can be replaced if it turns out to be a problem.

Even if they were in POSIX, I'd suggest not to change the constructs.  
rebase is _bound_ to be built in.

Even if Stephan is not a fan of my recent changes to rebase -i -p (which I 
will present on this list once they all work as I want them to), I think I 
can talk him into continuing the sequencer effort: he was not discussing 
the design in the open, so he should have expected the process to be 
dragged out.

Therefore, any changes to git-rebase--interactive (or for that matter, 
git-rebase) before the sequencer would be wasted work.

Ciao,
Dscho
