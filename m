From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 18:31:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101810410.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
 <7vprhqnv0c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de> <20090210165610.GP30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 18:32:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWwT5-00017Q-UR
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZBJRax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZBJRaw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:30:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:57452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752776AbZBJRaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:30:52 -0500
Received: (qmail invoked by alias); 10 Feb 2009 17:30:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 10 Feb 2009 18:30:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e4zBesdseZ9t8eoZBZ+BpzzXWblCjUN/8RxiJ33
	iEMxOTcWv+PCWM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090210165610.GP30949@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109281>

Hi,

On Tue, 10 Feb 2009, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 10 Feb 2009, Junio C Hamano wrote:
> > > 
> > > I could do a revert on 'master' if it is really needed, but I found that
> > > the above reasoning is a bit troublesome.  The thing is, if a tree to hold
> > > the notes would be huge to be unmanageable, then it would still be huge to
> > > be unmanageable if you split it into 256 pieces.
> > 
> > The thing is, a tree object of 17 megabyte is unmanagably large if you 
> > have to read it whenever you access even a single node.  Having 256 trees 
> > instead, each of which is about 68 kilobyte is much nicer.
> 
> See my other email on this thread; we'd probably need to unpack
> all 256 subtrees *anyway* due to the distribution of SHA-1 names
> for commits.

No, that is not true.  It is only true if you show more than 94180 
commit, actually, as only then the probability that you hit all 256 
buckets is larger than 50 percent.

In general, you will look at only a few commits, though.

Ciao,
Dscho
