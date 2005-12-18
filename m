From: Petr Baudis <pasky@suse.cz>
Subject: Re: How to clone-pack the HEAD?
Date: Sun, 18 Dec 2005 01:53:06 +0100
Message-ID: <20051218005306.GU22159@pasky.or.cz>
References: <20051215004440.GM22159@pasky.or.cz> <7vfyovtaub.fsf@assigned-by-dhcp.cox.net> <20051215013201.GD10680@pasky.or.cz> <7vpsnzrv43.fsf@assigned-by-dhcp.cox.net> <7vlkynrurh.fsf@assigned-by-dhcp.cox.net> <7vpsnzq66x.fsf@assigned-by-dhcp.cox.net> <7vfyouricc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 01:55:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Enmno-0004ji-4E
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 01:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVLRAxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 19:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVLRAxO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 19:53:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9931 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932552AbVLRAxN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Dec 2005 19:53:13 -0500
Received: (qmail 12648 invoked by uid 2001); 18 Dec 2005 01:53:06 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyouricc.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13784>

Dear diary, on Thu, Dec 15, 2005 at 07:21:23AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Also I might want to give --keep option to fetch-pack as well;
> > clone-pack has some static functions that we can extract out to
> > a common file to link to both.
> 
> And this is the second installment, on top of the previous one.
> I am a bit reluctant about this one only because of its size,
> but I suspect it may be much easier to use for your purpose.
> 
> I'll keep this in the proposed updates branch for now (the other
> one goes to master tonight), so if you like this one, please
> holler, test out and ack.

Well, I like this one, but you don't need to put this to master just for
me, I'm perfectly fine with the git-clone-pack fix - both commands are
now equally simple for me to use in Cogito. (And both seem to work fine
after some basic testing.)

But you are right that git-clone-pack is basically made obsolete by this
patch, and I tend to like that fact - that's why I have slight
preference to this patch anyway, despite its size (and it's mostly
common code being moved around anyway). It's probably too late to remove
git-clone-pack altogether, but you might at least deprecate it and print
a warning when it's being ran (or at least please print a warning when
it's being ran in a repository which is already populated, which is very
likely a driver error, and I've actually made it just a minute ago ;).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
