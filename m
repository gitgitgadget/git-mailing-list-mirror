From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Merges without bases
Date: Fri, 26 Aug 2005 00:09:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508252333550.23242@iabervon.org>
References: <1125004228.4110.20.camel@localhost.localdomain>
 <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 09:43:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8VTa-0001bK-Q2
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 06:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVHZEF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 00:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbVHZEF2
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 00:05:28 -0400
Received: from iabervon.org ([66.92.72.58]:28685 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751434AbVHZEF2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 00:05:28 -0400
Received: (qmail 21494 invoked by uid 1000); 26 Aug 2005 00:09:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2005 00:09:04 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7770>

On Thu, 25 Aug 2005, Junio C Hamano wrote:

> One thing that makes me reluctant to recommend this "merging
> unrelated projects" business is that I suspect that it makes
> things _much_ harder for the upstream project that is being
> merged, and should not be done without prior arrangement; Linus
> merged gitk after talking with paulus, so that was OK.

I'd still like to revive my idea of having projects overlaid on each
other, where the commits in the project that absorbed the other project
say, essentially, "also include this other commit, but any changes to
those files belong to that branch, not this one". That way, Linus could
have included gitk in git, but changes to it, even when done in a git
working tree, would show up in commits that only include gitk. (git
actually can handle this with the alternative index file mechanism that
Linus mentioned in a different thread.)

Definitely post-1.0, of course.

> Suppose the above "My Project" is published, people send patches
> for core GIT part to it, and you as the maintainer of that "My
> Project" accept those patches.  The users of "My Project" would
> be happy with the new features and wouldn't care less where
> their core GIT tools come from.  But how would _I_ pull from
> that "My Project", if I did not want to pull unrelated stuff in?

With the right info, the tools could be made to automatically generate
suitable commits, because those files would be tracked by a separate index
file and committed into a separate branch, which would then be reincluded
(by reference) in the containing project.

	-Daniel
*This .sig left intentionally blank*
