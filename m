From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Make git-update-cache --force-remove regular
Date: Tue, 31 May 2005 22:41:55 +0200
Message-ID: <20050531204155.GH7013@pasky.ji.cz>
References: <20050531165243.GD7013@pasky.ji.cz> <7vpsv7xjf2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 22:44:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdDZB-0008An-Sq
	for gcvg-git@gmane.org; Tue, 31 May 2005 22:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVEaUoO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVEaUoO
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 16:44:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44461 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261456AbVEaUmA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 16:42:00 -0400
Received: (qmail 8079 invoked by uid 2001); 31 May 2005 20:41:55 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsv7xjf2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 31, 2005 at 09:52:17PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> Make the --force-remove flag behave same as --add, --remove and
> PB> --replace. This means I can do
> 
> PB> 	git-update-cache --force-remove -- file1.c file2.c
> 
> PB> which is probably saner and also makes it easier to use in cg-rm.
> 
> I am ambivalent about this.  Although I like the semantic
> clean-up your proposed change makes, at the same time: 
> 
>   $ git-update-cache --force-remove one --add two
> 
> used to remove "one" and add "two", which has to be now written
> as two separate calls, which is a slight a performance hit of
> having to read the 1.6MB cache twice.  Maybe it does not matter,
> or the new usage's convenience outweighs it; I cannot tell
> offhand.

Sort all the forced removals to the end. I think it's still better than

  git-update-cache --force-remove one --force-remove two \
	--force-remove three ...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
