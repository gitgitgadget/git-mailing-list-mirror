From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning speed comparison
Date: Mon, 15 Aug 2005 13:46:41 -0700
Message-ID: <7vacjjx70u.fsf@assigned-by-dhcp.cox.net>
References: <20050813015402.GC20812@pasky.ji.cz>
	<Pine.LNX.4.63.0508151321270.12816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 22:47:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4lr4-0004oJ-Az
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 22:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVHOUqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 16:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVHOUqn
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 16:46:43 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:17380 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964949AbVHOUqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 16:46:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815204641.KQLP16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 16:46:41 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508151321270.12816@iabervon.org> (Daniel
	Barkalow's message of "Mon, 15 Aug 2005 13:50:31 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> I should be able to get http-pull down to the neighborhood of 
> (current) ssh-pull; http-pull is that slow (when the source repository 
> isn't packed) because it's entirely sequential, rather than overlapping 
> requests like ssh-pull now does.

I like those prefetch() and process() code in pull.c very much.

I have been wondering if increasing parallelism more by
prefetching beyond the immediate parents of the current commit,
in "if (get_history)" part of process_commit().  Maybe it is not
worth it because doing a commit, its associated tree(s) and its
parents would already give us enough parallelism already.

> (I've written an untested patch for local-pull, which I'll be testing, 
> cleaning, and submitting tonight, assuming my newly-arrived monitor 
> actually works)

That is a great news.  Thank you for doing this; looking forward
to see it, but no rush.  Enjoy your new monitor.
