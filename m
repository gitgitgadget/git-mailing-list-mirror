From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:18:35 -0400
Message-ID: <20061018191834.GA18829@spearce.org>
References: <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org> <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 21:19:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaGwI-0006OK-7S
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWJRTSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbWJRTSm
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:18:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56201 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161291AbWJRTSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:18:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaGw0-0004il-OI; Wed, 18 Oct 2006 15:18:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 73B4320E42A; Wed, 18 Oct 2006 15:18:35 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29256>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 18 Oct 2006, Junio C Hamano wrote:
> 
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > By the way, originally I just wanted to index and save the pack, but
> > > when trying to feed it to git-index-pack, I kept getting
> > >
> > > 	fatal: packfile '.git/objects/pack/pack-b2ab684daebea5b9c5a6492fa732e0d2e1799c8e.pack' has unresolved deltas
> > >
> > > while feeding it to git-unpack-objects works fine. Any idea what's wrong?
> > 
> > Yes.  You told the pipeline, with --objects-edge, to create a
> > thin pack.  By definition that is _not_ indexable.
> 
> Ah true.  I missed the "thin" pack.
> 
> Any idea why we should still prevent this?  It is not like it was a 
> technical limitation.

It still is in sha1-file.c; or at least the last time I looked at
that code.  The base is always resolved from the same pack/index
as the delta.  If you fix sha1-file.c sure, I don't see why you
can't allow indexing thin packs.

-- 
Shawn.
