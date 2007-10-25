From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/6] Do linear-time/space rename logic for exact renames
Date: Thu, 25 Oct 2007 17:37:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710251722290.7345@iabervon.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0710251120590.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710251522190.7345@iabervon.org>
 <alpine.LFD.0.999.0710251317020.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 23:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlAOS-0004mS-3d
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 23:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbXJYVhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 17:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbXJYVhO
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 17:37:14 -0400
Received: from iabervon.org ([66.92.72.58]:45616 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbXJYVhN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 17:37:13 -0400
Received: (qmail 5715 invoked by uid 1000); 25 Oct 2007 21:37:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Oct 2007 21:37:07 -0000
In-Reply-To: <alpine.LFD.0.999.0710251317020.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62378>

On Thu, 25 Oct 2007, Linus Torvalds wrote:

> On Thu, 25 Oct 2007, Daniel Barkalow wrote:
> > 
> > Creating a list of the pointers doesn't work correctly with the grow 
> > implementation, because growing the hash may turn a collision into a 
> > non-collision, at which point items other than the first cannot be found 
> > (since they're listed inside a bucket that's now wrong for them). AFAIK, 
> > resizing a hash table requires being able to figure out what happened with 
> > collisions.
> 
> Nope. 
> 
> The hash algorithm is much smarter than that.

Ah, yes. I was just confused by the comment suggesting the possibility of 
a collision when the only way to have two calls get the same bucket is 
when the key that the library gets is actually identical.

	-Daniel
*This .sig left intentionally blank*
