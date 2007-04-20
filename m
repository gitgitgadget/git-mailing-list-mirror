From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Kill the useless progress meter in merge-recursive
Date: Fri, 20 Apr 2007 14:00:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704201339160.27922@iabervon.org>
References: <20070420063718.GA8424@spearce.org> <7vd51z317c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 20:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HexPs-0004lr-Um
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 20:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993299AbXDTSAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 14:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993301AbXDTSAI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 14:00:08 -0400
Received: from iabervon.org ([66.92.72.58]:4112 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993299AbXDTSAC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 14:00:02 -0400
Received: (qmail 28389 invoked by uid 1000); 20 Apr 2007 18:00:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Apr 2007 18:00:00 -0000
In-Reply-To: <7vd51z317c.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45119>

On Fri, 20 Apr 2007, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > The mess known as the progress meter in merge-recursive was my own
> > fault; I put it in thinking that we might be spending a lot of time
> > resolving unmerged entries in the index that were not handled by
> > the simple 3-way index merge code.
> >
> > Turns out we don't really spend that much time there, so the progress
> > meter was pretty much always jumping to "(n/n) 100%" as soon as
> > the program started.  That isn't a very good indication of progress.
> 
> I would propose removing the progress meter for "Checking out
> files" in unpack-trees, for the same reason.

Maybe it should instead be arranged to only show the progress meter when 
the timer expires the first time (or, maybe, if it expires a few times). 
Rather than deciding whether it's going to be slow based on the total 
number, decide based on whether it's taken long enough for the user to 
wonder what's going on yet.

	-Daniel
*This .sig left intentionally blank*
