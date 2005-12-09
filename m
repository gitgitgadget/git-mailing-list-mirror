From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Fri, 9 Dec 2005 10:30:24 +0100
Message-ID: <20051209093024.GR22159@pasky.or.cz>
References: <20051208202555.GA3046@steel.home> <7vu0dje2oi.fsf@assigned-by-dhcp.cox.net> <20051208210251.GB19423@steel.home> <7v7jafcmev.fsf@assigned-by-dhcp.cox.net> <81b0412b0512082336i674932bapd631d559e80cad79@mail.gmail.com> <7vlkyu7l05.fsf@assigned-by-dhcp.cox.net> <7vvexy4ppw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 10:31:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkeaG-00038s-SJ
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 10:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVLIJaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 04:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVLIJaL
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 04:30:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:469 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750829AbVLIJaK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 04:30:10 -0500
Received: (qmail 23455 invoked by uid 2001); 9 Dec 2005 10:30:24 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvexy4ppw.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13420>

Dear diary, on Fri, Dec 09, 2005 at 09:52:27AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Linkage error of git-init-db (or git wrapper) may leave the file
> > created but leave that in unexecutable form, which could be a
> > valid concern, but that would signal an error to the make during
> > the build stage, and "test" target depends on "all" target.
> 
> BTW, I sometimes wished if it were easier to disable that "test:
> all" dependency and run tests without building things first,
> i.e. deliberately using the already installed binaries, so that
> I can make sure that updated or new tests reproduce and catch
> problems with the existing code first and then make sure the
> binaries built from the updated sources fix the problem.
> 
> Of course that is a very specialized application so a makefile
> variable "make NO_BUILD_BEFORE_TEST=YesPlease test" would not
> make much sense, but I could have done something like this:

I think having "test-standalone" or "test-nobuild" or whatever rule and

	test: all test-nobuild

	test-nobuild:
		...

would be much more elegant.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
