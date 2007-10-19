From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:11:26 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182306300.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182238470.19446@xanadu.home>
 <20071019025913.GA9227@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiGx-0006cH-A0
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbXJSDL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbXJSDL2
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:11:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38129 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbXJSDL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:11:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ5004DY2727180@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 23:11:26 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019025913.GA9227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61624>

On Thu, 18 Oct 2007, Jeff King wrote:

> On Thu, Oct 18, 2007 at 10:45:31PM -0400, Nicolas Pitre wrote:
> 
> > Yet that progress display isn't solely about "delta compressing".  It 
> > also includes the search for best object match in order to keep the 
> > smallest delta possible.
> 
> In fact, isn't that progress meter _solely_ about finding the best
> matches? The actual deltification (that is, the creation of the deltas
> and writing of them to the packfile happens during the writing phase --
> unless, of course, we've cached the deltas during the search phase).

Well, to find which combination is the smallest you actually have to 
create deltas.

> Perhaps one of:
> 
>   Finding deltas
>   Finding delta candidates
>   Matching objects
> 
> or something similar (though I don't especially like any of them, I
> think you get the idea).

I think we might sidestep the issue entirely by remaining somewhat vague 
and simply saying "compressing objects" for that phase.  This is the 
part responsible for the reduction of a Git repository from 3GB down to 
200MB anyway.


Nicolas
