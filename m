From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 00:52:35 +0200
Message-ID: <20050510225235.GD26384@pasky.ji.cz>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 00:46:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVdTY-0000PH-Ud
	for gcvg-git@gmane.org; Wed, 11 May 2005 00:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEJWwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 18:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEJWwk
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 18:52:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54696 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261806AbVEJWwg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 18:52:36 -0400
Received: (qmail 6794 invoked by uid 2001); 10 May 2005 22:52:35 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <2cfc40320505100800426d38ca@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 10, 2005 at 05:00:33PM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> One thing I noticed when doing this is that the present index/cache
> structure is rather arbitrary and the optimum index structure is
> determined by the structure of the tools that use a GIT repository
> rather than the structure of the GIT repository itself.

Yes. And that's how it should be - the directory cache is just that - a
_cache_. It does not hold any permanent information, merely serves to
record git tools' working state relative to the given working tree. So
unlike the objects database which has well-defined format and is
supposed to be "public", you should view the directory cache as internal
git tools' structure. If you want to mess with it too, either use the
proper level of abstraction and call the git tools, or don't mess with
it at all. And you need to care about it only if you want the git tools
working on the same tree properly too - so in that case use the git
tools too.

 From your arguments, it's not clear to me what really is the big
problem with the git tools. They are _designed_ for automatic use
instead of human interaction - you can perceive them just as methods
with funny (but actually friendly to your programs) calling convention.

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
