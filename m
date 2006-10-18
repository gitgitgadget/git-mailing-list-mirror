From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:33:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610181525410.1971@xanadu.home>
References: <200610172351.17377.jnareb@gmail.com>
 <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com>
 <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
 <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
 <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
 <20061018191834.GA18829@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 21:33:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaHAc-0001GL-MD
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 21:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWJRTdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 15:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbWJRTdY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 15:33:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47912 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1161315AbWJRTdW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 15:33:22 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7C00L0FJNL7190@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Oct 2006 15:33:21 -0400 (EDT)
In-reply-to: <20061018191834.GA18829@spearce.org>
X-X-Sender: nico@xanadu.home
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29258>

On Wed, 18 Oct 2006, Shawn Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 18 Oct 2006, Junio C Hamano wrote:
> > 
> > > Petr Baudis <pasky@suse.cz> writes:
> > > 
> > > > By the way, originally I just wanted to index and save the pack, but
> > > > when trying to feed it to git-index-pack, I kept getting
> > > >
> > > > 	fatal: packfile '.git/objects/pack/pack-b2ab684daebea5b9c5a6492fa732e0d2e1799c8e.pack' has unresolved deltas
> > > >
> > > > while feeding it to git-unpack-objects works fine. Any idea what's wrong?
> > > 
> > > Yes.  You told the pipeline, with --objects-edge, to create a
> > > thin pack.  By definition that is _not_ indexable.
> > 
> > Ah true.  I missed the "thin" pack.
> > 
> > Any idea why we should still prevent this?  It is not like it was a 
> > technical limitation.
> 
> It still is in sha1-file.c; or at least the last time I looked at
> that code.  The base is always resolved from the same pack/index
> as the delta.  

Yep.  I mean this doesn't have to be like that fundamentally.

> If you fix sha1-file.c sure, I don't see why you
> can't allow indexing thin packs.

If there are advantages to do so then maybe. That would be for another 
day though, as I've been burned a bit with packs recently.


Nicolas
