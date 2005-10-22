From: Petr Baudis <pasky@suse.cz>
Subject: Re: Handling renames.
Date: Sat, 22 Oct 2005 03:51:09 +0200
Message-ID: <20051022015109.GO30889@pasky.or.cz>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org> <20051022003733.GA8351@pasky.or.cz> <20051022004743.GN30889@pasky.or.cz> <Pine.LNX.4.64.0510211826350.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 03:52:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET8YC-0001rq-HW
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 03:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVJVBvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 21:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVJVBvN
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 21:51:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39652 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932117AbVJVBvM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 21:51:12 -0400
Received: (qmail 2823 invoked by uid 2001); 22 Oct 2005 03:51:09 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510211826350.10477@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10461>

> Every single thing that said that renames were a bad idea to track
> when git started is still equally true.

It'd be good to clarify whether we discuss whether the idea of tracking
renames is good or bad, or whether having the user explicitly specify
renames is better than figuring that out automagically. Your first
comment would indicate the former, but the rest of your reply the
latter.

> You can follow renames _afterwards_. 

I can - crudely, but what's the point, if the user is dying to give me
the information.

> Git tracks contents. And I think we've proven that figuring out renames 
> after-the-fact from those contents is not only doable, but very well 
> supported already.

It's unreliable and it's slow (well, perhaps I should get some numbers
to back that out, but given how it is done I take it for granted). Does
not sound too "very well" to me.

> I'm convinced that git handles renames better than any other SCM ever. 
> Exactly because we figure it out when it matters.

It matters at least every time you show per-file history and every time
you merge cross the rename. I think that can be both pretty common if
you ever do the rename. That means you can do an expensive guess
every time you hit that, and the guess can get it wrong, in which case
there is no way around that and you lose.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
