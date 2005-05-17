From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Tue, 17 May 2005 23:37:52 +0200
Message-ID: <20050517213752.GO7136@pasky.ji.cz>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net> <20050517190355.GA7136@pasky.ji.cz> <7vk6lxfybc.fsf@assigned-by-dhcp.cox.net> <20050517203500.GH7136@pasky.ji.cz> <7v4qd1tuud.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 23:39:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9lk-0003OL-PS
	for gcvg-git@gmane.org; Tue, 17 May 2005 23:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVEQViS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 17:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVEQViS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 17:38:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43492 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261985AbVEQVh5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 17:37:57 -0400
Received: (qmail 27764 invoked by uid 2001); 17 May 2005 21:37:52 -0000
To: Junio C Hamano <junio@siamese.dyndns.org>
Content-Disposition: inline
In-Reply-To: <7v4qd1tuud.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 17, 2005 at 11:18:18PM CEST, I got a letter
where Junio C Hamano <junio@siamese.dyndns.org> told me that...
> If your plan is to make Cogito take filesystem paths, then you

Yes, that's my plan.

> can move bulk of the code currently in cg-blah, except the part
> that picks up non-path parameters, to cg-Xblah, and reduce
> cg-blah implementation down to just:
> 
>     ... parse options by shifting "$@" out.
>     ... then
>     git-run-with-user-path cg-Xblah $non-path-opts -- "$@"
> 
> and you can rip "the code to figure out .git" out from cg-Xblah.
> There is nothing to figure out at that point; it always is
> ${GIT_DIR-.git}/.

But that won't work good enough for me. E.g. when committing in a
subdirectory, I want to commit only changes made in the subdirectory,
etc.

Not even talking about much uglier implementation (that could be
remedied by calling myself recursively with some special argument).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
