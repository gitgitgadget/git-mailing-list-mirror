From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: The criss-cross merge case
Date: Wed, 27 Apr 2005 22:19:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504272209390.30848-100000@iabervon.org>
References: <87d5sf7il2.fsf@rzstud4.rz.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:14:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyXV-00017F-Vo
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVD1CTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVD1CTU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:19:20 -0400
Received: from iabervon.org ([66.92.72.58]:23559 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261663AbVD1CTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 22:19:16 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQycX-0003eg-00; Wed, 27 Apr 2005 22:19:17 -0400
To: Benedikt Schmidt <ry102@rz.uni-karlsruhe.de>
In-Reply-To: <87d5sf7il2.fsf@rzstud4.rz.uni-karlsruhe.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Apr 2005, Benedikt Schmidt wrote:

> AFAIK the paper mentioned in the GNU diff sources [1] is an improvement
> to an earlier paper by the same author titled
> "A File Comparison Program" - Miller, Myers - 1985.

GNU diff is based on a better algorithm than traditional diff, reportly,
but there are better algorithms still, developed since, at least according
to a brief literature search on Google Scholar. (bdiff and vdelta, for
example, which can identify block moves as well.)

> Can you be more specific why the algorithm is a bad choice (performance,
> quality of diff output)?

I suspect that the speed is suboptimal (for the cases under which it is
actually used). The quality of the output is about ideal, lacking a
representation for block moves, but I'm hoping to have a diff/merge set
that handles block moves effectively, even if it can't report them in diff
format. I'm also hoping for an annotate function that could use block
moves.

> Ok, darcs doesn't handle block moves, so there is no need for an algorithm that
> supports them (yet). Is there any free SCM that has support for block moves at
> the moment? It seems like clearcase detects them, but I don't know where it
> takes advantage of it.

I would think that darcs would be able to do neat things in its merger if
it knew about block moves. Obviously, it only makes sense to add support
for identifying them and using them at the same time.

	-Daniel
*This .sig left intentionally blank*

