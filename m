From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Wed, 29 Jun 2005 18:24:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506291806510.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506291435310.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 00:19:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnktb-00005x-By
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 00:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVF2W0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 18:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVF2W0U
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 18:26:20 -0400
Received: from iabervon.org ([66.92.72.58]:39172 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262671AbVF2W0S (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 18:26:18 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Dnkyu-0003Rk-00; Wed, 29 Jun 2005 18:24:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506291435310.14331@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 29 Jun 2005, Linus Torvalds wrote:

> On Wed, 29 Jun 2005, Daniel Barkalow wrote:
> > The one thing I can think of is whether things will blow up if the target
> > repository has heads that aren't in the source
> 
> Right. I think that's a "feature" of pushing: you cannot push to an 
> archive that has state that you don't know about. Ie you can only push to 
> something that is a proper subset of what you are (on a per-branch basis, 
> of course - not necessarily on a "global" stage - so you could push just 
> _one_ branch, even if another branch was ahead of where you are).

The issue is really distinguishing the "other" branches I don't care about
from the one that I do care about. With -w, I almost certainly care about
the ref I'm writing, but that doesn't help for refs that are new (new
branches or tags), for which I care about some other thing. Also, the
failure is a bit hard to detect, I think, in that I could find I do
recognize some ancient thing that's barely useful for exclusion, and miss
something that should exclude almost everything but it's been updated. In
any case, when things go wrong we simply send stuff the recipient already
has, so it's not the end of the world. (And there's probably some clever
way of dealing with it)

	-Daniel
*This .sig left intentionally blank*
