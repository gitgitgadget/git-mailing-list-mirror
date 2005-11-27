From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC 1/2] Use remote information in .git/config
Date: Sun, 27 Nov 2005 13:52:56 +0100
Message-ID: <20051127125256.GC22159@pasky.or.cz>
References: <Pine.LNX.4.63.0511211452470.13775@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q65sst3.fsf@assigned-by-dhcp.cox.net> <41D1FCC0-E031-48FB-82A2-6CFDA2E03AC0@hawaga.org.uk> <Pine.LNX.4.63.0511250208110.28437@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Clifford <benc@hawaga.org.uk>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 13:53:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgM1w-0000HR-6d
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 13:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVK0Mwm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 07:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVK0Mwm
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 07:52:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35013 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751027AbVK0Mwl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 07:52:41 -0500
Received: (qmail 27158 invoked by uid 2001); 27 Nov 2005 13:52:56 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511250208110.28437@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12803>

Dear diary, on Fri, Nov 25, 2005 at 02:08:46AM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Fri, 25 Nov 2005, Ben Clifford wrote:
> 
> > On 22 Nov 2005, at 05:29, Junio C Hamano wrote:
> > 
> > > Personally I do not mind moving remotes/branches information
> > > there, except that I suspect the git-config-set interface makes
> > > it cumbersome to (1) find out what remotes I defined (i.e. an
> > > equivalent of "ls .git/remotes")
> > 
> > (1) is useful to be able to do in a very lightweight way when doing tab
> > completion on remotes. Having heads, tags, remotes in nicely named separate
> > files makes that pretty straightforward; I don't know if using a git-config-
> > accessor would make this noticeably worse, though, as I haven't tried anything
> > out there yet.
> 
> 	 git-var -l | sed -n "s/^remote\.\([A-Za-z0-9]*\)\.url=.*$/\1/p"

All right, I've asked about this functionality in the other thread, and
something like this seems to cut it (although I would just /\([^.=]*\)/
instead of restricting the remote name).

However, it's a nice example of horrible interface. And confusing one
at it, too.

Why git-var -l?! That makes no sense to me. git-var's function is to
"print the git users identity" (no matter that it is grammatically
wrong, that's what the synopsis says). This is something totally else,
and I can't see what bussiness does this have in the git-var command.
This should belong into git-repo-config, which manages the rest of the
config-related stuff.

C'mon people, git's interface is inconsistent enough as it is now,
no need to make it even worse. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
