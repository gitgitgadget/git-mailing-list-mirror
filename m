From: Petr Baudis <pasky@suse.cz>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 23:41:23 +0100
Message-ID: <20060320224123.GP18185@pasky.or.cz>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us> <7vu09um3ae.fsf@assigned-by-dhcp.cox.net> <m3wteqj6qx.fsf@lugabout.cloos.reno.nv.us> <7vbqw1nakz.fsf@assigned-by-dhcp.cox.net> <7vu09tjy38.fsf@assigned-by-dhcp.cox.net> <20060320151833.GN18185@pasky.or.cz> <7vk6aokd7m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 23:41:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLT3t-0004eg-Ew
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 23:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbWCTWlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 17:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbWCTWlM
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 17:41:12 -0500
Received: from w241.dkm.cz ([62.24.88.241]:25560 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030585AbWCTWlL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 17:41:11 -0500
Received: (qmail 13083 invoked by uid 2001); 20 Mar 2006 23:41:23 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6aokd7m.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17768>

Dear diary, on Mon, Mar 20, 2006 at 10:39:41PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> You are commenting on the initial 'git-clone' and specifically
> on one of its optional feature.  What multiple upstreams?
> 
> The whole point of what git-clone does on top of making a
> straight clone of the remote is to give you a reasonable
> starting point.  The traditional "master" -> "origin" mapping is
> good for cloning a typical single-head repository.  If your
> upsteram has more branches, --use-separate-remote would help you
> to start your branch namespace uncluttered.

Yes, but I just see no connecting with a "starting point" whatsoever -
why should this be inherent to initial clone? I can see no greater
chance that I will want all the branches than when I want to fetch from
another repository later (especially in a truly distributed
environment).

So, it doesn't make sense to me to limit this feature only to the
initial clone case - I want to be able to reasonably "fetch all
branches" of any repository I wish. Without massive namespace clashes,
the reasonable way is to just have a separate directory in
.git/refs/remotes/ for each repository (and it's my understanding that
this was the original proposal as well).

Then you can make a simple change that if a refname matches a directory
in refs/remotes/, you rewrite it as refs/remotes/<refname>/master. This
makes 'origin' work seamlessly in a natural way and a lot more elegantly
than if you make up an artifical rule like "if the remote's branch is
master, save it as origin, but save all the other branches verbatim".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
