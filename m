From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:45:01 -0400
Message-ID: <20071019034501.GG14735@spearce.org>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <alpine.LFD.0.9999.0710182247130.19446@xanadu.home> <20071019031737.GD14735@spearce.org> <alpine.LFD.0.9999.0710182328580.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:45:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiina-0002Gm-SE
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758320AbXJSDpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758290AbXJSDpL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:45:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45262 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbXJSDpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:45:09 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iiin0-00032X-Se; Thu, 18 Oct 2007 23:44:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 55DC520FBAE; Thu, 18 Oct 2007 23:45:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182328580.19446@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61638>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 18 Oct 2007, Shawn O. Pearce wrote:
> > Yup.  Your patches were a big improvement.  But I'm now sitting here
> > wondering if we shouldn't just allow a progress meter to overwrite
> > the prior one.  Then you only see the current task and progress,
> > or the final output if we have nothing further to say about that.
> 
> And then you've lost some diagnostic clue (the absolute numbers) about 
> the actual number of objects that were listed for "deltification" for 
> example.

Leave the "Total" line.  Add to it the number of objects we had to
consider for deltification as part of the packing.
 
> And imagine that you see the progress moving slowly because the remote 
> server is a NSLU2, but it says 80%.  Then you go for a coffee and the 
> progress says 20% when you return because it now has moved to a 
> different phase.  Rather counter intuitive.

Yea, I didn't consider that.  That's where you need to show the
number of steps and which one you are on, so the meter looks
more like:

	Step 1/3: Counting objects: .... \r
	Step 2/4: Compressing objects: ... \r
	Step 3/3: Writing objects: .... \r

only all smashed into one line of course, so only the most recent
one is being displayed.

-- 
Shawn.
