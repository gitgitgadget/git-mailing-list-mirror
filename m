From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Mon, 26 Feb 2007 23:56:23 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702262333240.29426@xanadu.home>
References: <200702261540.27080.ttelford.groups@gmail.com>
 <20070226235510.GF1639@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 05:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLuO4-0007QG-HJ
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 05:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbXB0E4Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 23:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbXB0E4Z
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 23:56:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9000 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbXB0E4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 23:56:24 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE3002AEV1ZQJT1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Feb 2007 23:56:23 -0500 (EST)
In-reply-to: <20070226235510.GF1639@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40694>

On Mon, 26 Feb 2007, Shawn O. Pearce wrote:

> Nico and I are neck deep in our pack version 4 topic.  That topic
> hits all of the same code you touched with your patch.

Although a good deal of code has been written already, we're still 
throwing completely crazy ideas back and forth which, if they survive 
the reality test, might change things quite a lot for the index.

> Our topic also requires us to change the index file format, and
> in doing so we have decided to extend the index records to look
> something like the following[*1*]:

[ delete new index format layout description ]

Although I suggested that format... like... yesterday, I'm already 
dismissing it now.  I'd go with what I just posted instead.

But yet this depends on whether or not we consider this latest idea of 
ours a good thing or not, which require some math to be done to prove 
its usefulness.

Maybe we should post our notes here in order to gather extra comments 
from people or to debunk some of our insane ideas faster.

> I want to say your patch shouldn't be merged without even bothering
> to review it.  The last time I was in this part of the git code
> (implementing sliding mmap window) Nico and Junio also both went in
> here and rewrote huge chunks.  Their changes prevented sliding mmap
> window from applying.  It was 6 months before I got back around to
> rewriting the patch.

The thing is, regardless of the pack v4 work, I think the approach used 
is not the best one.  And because of the pack v4 work, we'll have to 
settle on something before too long anyway.

> So would you mind waiting a couple of weeks for 64 bit indexes?

Of course Troy's patch might be used by those who need it now.  I think 
Junio might even park it in pu for reference.  The pack index is not a 
precious piece of information and it can be thrown away and recreated 
with git-index-pack whenever there is an officially supported new index 
format.

> *1*: This was Nico's idea; I'm in agreement with him about it.

As mentioned above I'm not in agreement with myself anymore about it.  
;-)


Nicolas
