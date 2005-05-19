From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Thu, 19 May 2005 13:35:29 -0700
Message-ID: <7v7jhvymwe.fsf@assigned-by-dhcp.cox.net>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
	<20050517190355.GA7136@pasky.ji.cz>
	<7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
	<20050517203500.GH7136@pasky.ji.cz>
	<7v4qd1tuud.fsf@assigned-by-dhcp.cox.net>
	<20050517213752.GO7136@pasky.ji.cz>
	<7vzmutqz5f.fsf@assigned-by-dhcp.cox.net>
	<20050518213309.GD10358@pasky.ji.cz>
	<7vekc4nom5.fsf@assigned-by-dhcp.cox.net>
	<20050518232408.GA18281@pasky.ji.cz>
	<7v64xgnl55.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505181731450.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 22:35:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYrjI-00084d-52
	for gcvg-git@gmane.org; Thu, 19 May 2005 22:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVESUfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVESUfh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 16:35:37 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:22977 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261246AbVESUfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 16:35:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519203529.MGSO550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 16:35:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> ... I do believe that git-run-with-user-path _could_ be a
LT> good way to abstract out the "where the heck in the tree am
LT> I?" issues.

Yes, I am still in search of a good way to abstract that issue
out and I myself is not yet convinced that the command in its
current form _is_ a good enough way yet.

What I am most unhappy about with it lies elsewhere, though.
There needs to be a better way to tell it how the underlying
command handles non-paths arguments, so that I can just say

    git-run-with-user-path <some option spec for the command> \
        command arg1 arg2 arg3 ...

and if arg1 through argO is non-path options then have it
canonicalize and filter only starting from argO+1.  That would
alleviate one issue I have with the current implementation.

