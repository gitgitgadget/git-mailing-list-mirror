From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Re: Darcs-git pulling from the Linux repo: a Linux VM question
Date: Thu, 28 Apr 2005 07:39:52 -0400
Message-ID: <20050428113947.GC9422@abridgegame.org>
References: <7i7jionz5q.fsf@lanthane.pps.jussieu.fr> <Pine.LNX.4.58.0504270823480.18901@ppc970.osdl.org> <7iu0lskyfb.fsf@lanthane.pps.jussieu.fr> <Pine.LNX.4.58.0504270910510.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Thu Apr 28 13:40:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR7NJ-0006kN-6I
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 13:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVD1LpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 07:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVD1LpR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 07:45:17 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:34344 "EHLO
	localhost") by vger.kernel.org with ESMTP id S262081AbVD1LpA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 07:45:00 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DR7N2-0003Am-Mq; Thu, 28 Apr 2005 07:39:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504270910510.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2005 at 09:16:03AM -0700, Linus Torvalds wrote:
> On Wed, 27 Apr 2005, Juliusz Chroboczek wrote:
> > Here we're speaking about the initial import.  Committed on 17 April
> > 2005 by Linus Torvalds, with the comment ``Let it rip''.  220 MB of
> > changed files in a single commit.  2 minutes real time just to read
> > all the files, never mind doing anything useful with them.
> 
> I think you may well want to consider the initial commit special. In many 
> ways it is - it has no parents etc, so even apart from the fact that the 
> initial commit obviously tends to be a lot bigger than any other commit, 
> it actually fundamnetally is _technically_ different too.

This has been discussed, and while I'm not opposed to special-casing the
initial commit, mostly we've taken the stance so far of not special-casing.
It's much nicer if we can make darcs efficient enough to perform the
initial commit without a special case, which has the nice side-effect of
also improving other cases.

When we're desperate, we'll special-case the initial commit, but currently
I'm sure we can pretty easily adjust things by making the git-tree-reading
lazy, which should pretty well address both the memory and speed
concerns--and also improve performance of other commands.  Perhaps more to
the point, it will also ensure that the same optimizations that work for
working with darcs repos will help when dealing with git repos.
-- 
David Roundy
http://www.darcs.net
