From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What to expect after 0.99.8
Date: Mon, 3 Oct 2005 15:43:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510031522590.23242@iabervon.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 21:39:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMW8n-00008W-LY
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 21:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbVJCTiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 15:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVJCTiX
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 15:38:23 -0400
Received: from iabervon.org ([66.92.72.58]:22544 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932656AbVJCTiW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 15:38:22 -0400
Received: (qmail 29485 invoked by uid 1000); 3 Oct 2005 15:43:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2005 15:43:02 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9646>

On Sun, 2 Oct 2005, Junio C Hamano wrote:

> What to expect after 0.99.8
> ===========================
> 
> This is written in a form of to-do list for me, so if I say
> "accept patch", it means I do not currently plan to do that
> myself.  People interested in seeing it materialize please take
> a hint.

Are these all before 1.0, or are some of them supposed to happen 
eventually but later?

> Technical (heavier)
> -------------------
> 
> * Libification.  There are many places "run once" mentality is
>   ingrained in the management of basic data structures, which
>   need to be fixed.

I think this should be a post-1.0 thing; I think after 1.0, we should 
rearrange a lot of the code to make more sense from a programmer 
perspective.

> * 'git split-projects'?  This requires updated 'git-rev-list' to
>   skip irrelevant commits.
>   Message-ID: <Pine.LNX.4.63.0509221617300.23242@iabervon.org>

I thought about this some more, and realized that the operation to get 
additions to the gitk history out of a git repository is going to be slow, 
because you don't know the correct hashes for parents until you go all the 
way back. Still worth doing, but less exciting than I'd hoped.

> * Look at libified GNU diff CVS seems to use, or libxdiff.

I've almost got a suffix-tree-based diff that works reasonably well, 
that's built as a library, and outputs unified diff. I need to merge it 
with git, hook up input from trees and blobs, and test it on a wider set 
of data.

I'd also like to add:

 * Accept patches to fetch multiple objects by HTTP in parallel.

I think this may be necessary to get good performance without rsync for 
repositories hosted without specific git support.

	-Daniel
*This .sig left intentionally blank*
