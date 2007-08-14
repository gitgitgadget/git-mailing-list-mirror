From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Tue, 14 Aug 2007 10:52:35 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708141037020.5415@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070812103338.GA7763@auto.tuwien.ac.at>
 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:52:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKxlA-0001HM-MD
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 16:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbXHNOwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbXHNOwh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 10:52:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26208 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbXHNOwg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 10:52:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMR008C8QNN1VG0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 14 Aug 2007 10:52:35 -0400 (EDT)
In-reply-to: <20070814031236.GC27913@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55838>

On Mon, 13 Aug 2007, Shawn O. Pearce wrote:

> Jon Smirl <jonsmirl@gmail.com> wrote:
> > This solution was my first thought too. Use the main thread to get
> > everything needed for the object into RAM, then multi-thread the
> > compute bound, in-memory delta search operation. Shared CPU caches
> > might make this very fast.
> 
> I have been thinking about doing this, especially now that the
> default window size is much larger.  I think the default is up as
> high as 50, which means we'd keep that shiny new UltraSPARC T2 busy.
> Not that I have one...  so anyone from Sun is welcome to send me
> one if they want.  ;-)

Note that the default of 50 applies to the maximum delta depth, not the 
delta search window.  And the delta depth limit is costless on the 
packing side.  I, too, wouldn't mind the UltraSPARC T2 though.


Nicolas
