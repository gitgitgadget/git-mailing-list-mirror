From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 08:56:10 -0800
Message-ID: <20090210165610.GP30949@spearce.org>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de> <7vprhqnv0c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvvY-0003Bf-9Q
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbZBJQ4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbZBJQ4M
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:56:12 -0500
Received: from george.spearce.org ([209.20.77.23]:46171 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZBJQ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:56:11 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id EDCBF38210; Tue, 10 Feb 2009 16:56:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109274>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 10 Feb 2009, Junio C Hamano wrote:
> > 
> > I could do a revert on 'master' if it is really needed, but I found that
> > the above reasoning is a bit troublesome.  The thing is, if a tree to hold
> > the notes would be huge to be unmanageable, then it would still be huge to
> > be unmanageable if you split it into 256 pieces.
> 
> The thing is, a tree object of 17 megabyte is unmanagably large if you 
> have to read it whenever you access even a single node.  Having 256 trees 
> instead, each of which is about 68 kilobyte is much nicer.

See my other email on this thread; we'd probably need to unpack
all 256 subtrees *anyway* due to the distribution of SHA-1 names
for commits.

-- 
Shawn.
