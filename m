From: Petr Baudis <pasky@ucw.cz>
Subject: Re: rev-list/tree committer/author information.
Date: Tue, 17 May 2005 00:19:57 +0200
Message-ID: <20050516221957.GD8609@pasky.ji.cz>
References: <7vzmuy13od.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505160837080.28162@ppc970.osdl.org> <7vekc6onzc.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 17 00:23:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXnyu-0005Xr-9t
	for gcvg-git@gmane.org; Tue, 17 May 2005 00:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVEPWV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 18:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVEPWV7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 18:21:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4816 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261967AbVEPWT6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 18:19:58 -0400
Received: (qmail 21611 invoked by uid 2001); 16 May 2005 22:19:57 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vekc6onzc.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 16, 2005 at 11:33:11PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> Anyway, everything I've read so far makes sense, and it
> LT> might make sense to continue git development using just
> LT> git-pb. The only thing I personally think sucks is the
> LT> author/committer matching of git-rev-list/tree, since it
> LT> would seem like somebody might well like to match on an
> LT> arbitrary part of a commit, and special-casing
> LT> author/committer seems somewhat broken.
> 
> Well, that author/committer thing is not in git-pb yet, if I am
> not mistaken [*1].
> 
> The only reason why I did it that way was because the strategy
> taken by "struct object" derivatives seemed to pick up bare
> absolute minimum to support actual callers that have immediate
> need for information stored in structural fields, as opposed to
> designing for helping yet to be written callers by adding fields
> to hold information of "having this might also help somebody in
> the future" type.  And the author and committer names are in the
> structured fields while signed-off-by and others are not.  Also
> when author / committer name strings are intern'ed like the way
> I did, the memory consumption even for a long sequence of
> commits are kept reasonably low.  However,...

I like Linus' suggestion. At the very least, what about making the
matching generic for the header? Something like --match-header or
whatever.

> *1* Petr has been applying quite good judgements. I would have
> polluted git-jc with that patch already if I were still running
> it.  So far, I have been generally happy with his acceptance
> criteria for external patches.  Anything he places on hold or
> just outright returns to me, I later find rooms for improvements
> myself, and the later rounds that eventually get accepted always
> turn out to be far cleaner, thanks to his comments.

Thanks for the praise :-), but I'm actually quite unhappy with putting
patches "on hold" and it's not intentional. It's just that I don't feel
right about the patch enough to apply it immediately, and I either don't
have time to voice my concerns if they are non-trivial, or I just want
some time to think about it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
