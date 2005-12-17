From: Junio C Hamano <junkio@cox.net>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 17:49:23 -0800
Message-ID: <7vy82kbiho.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
	<7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
	<7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
	<118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
	<7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
	<118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
	<Pine.LNX.4.64.0512161701400.3698@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 02:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnRCV-0005NM-RT
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 02:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVLQBt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 20:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVLQBt1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 20:49:27 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52402 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751356AbVLQBt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 20:49:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217014741.CTMB17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 20:47:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512161701400.3698@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 16 Dec 2005 17:05:41 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13767>

Linus Torvalds <torvalds@osdl.org> writes:

> Or maybe "git commit" should always _write_ ORIG_HEAD with the old head, 
> so that we can always do an "undo" by doing "git reset --hard ORIG_HEAD" 
> regardless of whether the last thing was a "git commit" or a "git pull".
>
> Hmm?

If we define "git undo" as "Revert the tree to the state one
before the last successfull commit/pull", then overwriting
ORIG_HEAD as you say at the commit time and always using "git
reset --hard ORIG_HEAD" would make sense.

I fail to see the merit of "git undo/unpull/unmerge/..."; mostly
because I have never seen BK and do not benefit from the
familiarity factor at all.  To people without BK experience,
having too many synonyms (e.g. "git undo" does something magical
by feeding "git reset --hard" with ORIG_HEAD) might be just more
noise and confusion.  I can see them asking "why are there two
ways to do identical things?".

However, the reason I am maintaining git is not to make it
useful for _me_, but to make it useful for the kernel people, so
if these BK-like synonyms help them, I'm all for it.  If we are
going to do that, somebody needs to describe what should each
command do in each case in detail, because I do not know BK at
all.

You guys were on BK for how many months, and have been on git
for how many months now?  Do BK-familiarity factor matter, and
will it continue to matter for how long?
