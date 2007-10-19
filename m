From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Fri, 19 Oct 2007 01:09:40 -0400
Message-ID: <20071019050940.GH14735@spearce.org>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182251110.19446@xanadu.home> <20071019030749.GA9274@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182312160.19446@xanadu.home> <20071019033228.GA10697@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 07:10:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iik7c-0005IX-NC
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 07:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbXJSFJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 01:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbXJSFJ5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 01:09:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47213 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbXJSFJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 01:09:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iik7B-00028r-Vi; Fri, 19 Oct 2007 01:09:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 99A0B20FBAE; Fri, 19 Oct 2007 01:09:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61651>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 18 Oct 2007, Jeff King wrote:
> > Also, why do we abbreviate "refs/heads/master" from the remote, but we
> > don't abbreviate refs/heads/origin for the local? Maybe something like:
> > 
> >   * local heads/origin -> remote heads/master (fast forward)
> > 
> > or for separate remote
> > 
> >   * local remotes/origin/master -> remote heads/master (fast forward)
> 
> That looks fine for a push.  I'd say "remote foo -> local bar" for a 
> fetch.

The fetch side is easy to change on top of the db/fetch-pack series
that is currently in next.

What's hard is the remote side.  receive-pack on the remote side
doesn't have the local's refname but it prints its own message upon
a successful update.

-- 
Shawn.
