From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Tue, 8 Nov 2005 00:21:22 +0100
Message-ID: <20051107232122.GZ1431@pasky.or.cz>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de> <7vvez8wbpz.fsf@assigned-by-dhcp.cox.net> <20051104210820.GM1431@pasky.or.cz> <7voe50rskh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511041359050.28804@g5.osdl.org> <7v8xw216q9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 00:23:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZGIt-00079C-QI
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 00:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965596AbVKGXV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 18:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965600AbVKGXV0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 18:21:26 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23211 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965599AbVKGXVZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 18:21:25 -0500
Received: (qmail 6517 invoked by uid 2001); 8 Nov 2005 00:21:22 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xw216q9.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11291>

Dear diary, on Sun, Nov 06, 2005 at 10:11:10AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Just for discussion, I'd suggest a less structured approach as
> an alternative, and making it just a convention.

The problem is that at least Cogito defaults to the 'origin' branch when
pulling/merging, so if you'll have 'origin/master' instead of 'origin',
I will have to hack that around. So it's not _just_ a convention but
something reflected in some code as well.

>  - clone by default [*1*] creates .git/refs/heads/origin/*
>    heads; your "master" becomes my "origin/master".
>    Interestingly but logically, if your repository was cloned
>    from somewhere else, you would have "origin/master", which
>    would become my "origin/origin/master".

This loses the pretty nice property that 'origin' refers to the HEAD
branch of the remote repository, no matter how is it called (well, it is
nice as long as the remote repository doesn't _switch_ the HEAD to some
non-superset branch; but repositories you're cloning from shouldn't do
that). So you should either have origin/HEAD locally, or make the
'master' branch more "socially canonical".

> *1* I say "by default" here; I think there should be an
> operating mode for git clone that acts as a straight copy, not
> even the current "HEAD" -> "origin" renaming.  In fact that is
> what you do with low-level git-clone-pack.

What would it be useful for?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
