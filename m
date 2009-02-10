From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 08:48:09 -0800
Message-ID: <20090210164809.GO30949@spearce.org>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de> <7vprhqnv0c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvnm-0008IQ-82
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbZBJQsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbZBJQsL
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:48:11 -0500
Received: from george.spearce.org ([209.20.77.23]:54880 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbZBJQsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:48:10 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id CDE9F38210; Tue, 10 Feb 2009 16:48:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vprhqnv0c.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109273>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> I could do a revert on 'master' if it is really needed, but I found that
> the above reasoning is a bit troublesome.  The thing is, if a tree to hold
> the notes would be huge to be unmanageable, then it would still be huge to
> be unmanageable if you split it into 256 pieces.
> 
> I'd rather prefer to see us first try to find a way to optimze the tree
> parser.  Maybe packv4 or Linus's binary search (which IIRC you declared
> would not work --- I recall I once thought about it myself but I do not
> recall what my conclusions were) play a role in it.

packv4 as proposed wouldn't help a notes tree.  It relied on the fact
that we'd have no more than 64k unique file names in a repository,
and any name which overflowed that 64k limit would force its tree
to be a canonical format tree, which is what we are trying to
avoid here.

-- 
Shawn.
