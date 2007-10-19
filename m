From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Fri, 19 Oct 2007 00:02:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182354300.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org>
 <alpine.LFD.0.9999.0710182247130.19446@xanadu.home>
 <20071019031737.GD14735@spearce.org>
 <alpine.LFD.0.9999.0710182328580.19446@xanadu.home>
 <20071019034501.GG14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 06:02:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iij4L-00055M-C8
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 06:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbXJSEC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 00:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbXJSEC2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 00:02:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17291 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbXJSEC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 00:02:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ500I244JP1AD0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 00:02:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019034501.GG14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61644>

On Thu, 18 Oct 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > And imagine that you see the progress moving slowly because the remote 
> > server is a NSLU2, but it says 80%.  Then you go for a coffee and the 
> > progress says 20% when you return because it now has moved to a 
> > different phase.  Rather counter intuitive.
> 
> Yea, I didn't consider that.  That's where you need to show the
> number of steps and which one you are on, so the meter looks
> more like:
> 
> 	Step 1/3: Counting objects: .... \r
> 	Step 2/4: Compressing objects: ... \r
> 	Step 3/3: Writing objects: .... \r
> 
> only all smashed into one line of course, so only the most recent
> one is being displayed.

Yet you might not know in advance how many steps there'll be.  You might 
or might not have the deltification phase (I simply can't let that term 
go...), pack indexing also have 1 or 2 steps, and if objects are 
unpacked instead then you have only one step.

Given the asynchronous nature of the sideband messages, I think that 
could only create messed up displays.  Some messages are terminated with 
\n and others with \r.


Nicolas
