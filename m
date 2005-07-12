From: Marc Singer <elf@buici.com>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 19:10:04 -0700
Message-ID: <20050712021004.GA27576@buici.com>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org> <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 04:10:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsAE8-0004vf-JP
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 04:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVGLCKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 22:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVGLCKH
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 22:10:07 -0400
Received: from florence.buici.com ([206.124.142.26]:14745 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261693AbVGLCKG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 22:10:06 -0400
Received: (qmail 27807 invoked by uid 1000); 12 Jul 2005 02:10:04 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2005 at 06:43:23PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Jul 2005, Linus Torvalds wrote:
> >
> > No, git-checkout-script _shouldn't_ have done that. It will do the 
> > read-tree on the tag (which will do the right thing), but it won't change 
> > the HEAD itself.
> 
> In preparation of actually updating the HEAD, I just made "git checkout" 
> verify that it only checks out a commit, not a tree tag or something like 
> that. Too late for Marc, but next time around a "git checkout v2.6.11" 

:-) 

> will result in
> 
> 	[torvalds@g5 linux]$ git checkout v2.6.11
> 	error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
> 	Needed a single revision
> 
> On the other hand, creating a new branch might be a but surprising to 
> people: "But I just wanted to check it out". But as far as I can see, it's 
> the only safe thing to do, and it has the advantage that you can then go 
> back to the old state with a simple "git checkout master".
> 
> But what about the branch name? Should we just ask the user? Together with 
> a flag, like
> 
> 	git checkout -b new-branch v2.6.12
> 
> for somebody who wants to specify the branch name? Or should we pick a 
> random name and add a helper function to rename a branch later?
> 
> Opinions?

>From my POV, what I want is a branch with the tag v2.6.12 as the basis
of the branch.  I'm guessing that -b means "make me a branch and call
it this".

 # git checkout -b BRANCH_NAME [TAG]

If the TAG is omitted, the branch is made from the current HEAD or
some other reasonable point defined by the current working directory.

Are uncommitted changes present in the working directory maintained?
Discarded?  I wont't care since I'll never be doing that.  At least,
not on purpose.
