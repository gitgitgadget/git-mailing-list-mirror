From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 22:06:27 -0700
Message-ID: <7vodz3l964.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
	<7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141748070.3701@g5.osdl.org>
	<7vacanmxhe.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604142104140.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 07:06:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUczT-0005j4-HN
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 07:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWDOFGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 01:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWDOFGa
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 01:06:30 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24271 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030243AbWDOFG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 01:06:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415050628.SFFM24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 01:06:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604142104140.3701@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 14 Apr 2006 21:09:31 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18726>

Linus Torvalds <torvalds@osdl.org> writes:

> Well, it's easy enough to do something like
>
> 	if (rev->diff)
> 		usage(no_diff_cmd_usage);
>
> for something like that.

You're right.  I've swallowed all four patches with a fixlet on
top; thanks.

> Although, the thing is, once we have a built-in "git diff", there's 
> actually little enough reason to ever use the old "git-diff-tree" vs 
> "git-diff-index" vs "git-diff-files" at all. 

True, unless you are writing a Porcelain, that is.

> It might actually be nice to prune some of the tons of git commands. At 
> some point, the fact that
>
> 	echo bin/git-* | wc -w
>
> returns 122 just makes you go "Hmm..".

Yes, but I thought the plan to deal with that was to set gitexecdir
somewhere other than $(prefix)/bin; removing git-diff-* siblings
would be unfriendly to Porcelains.
