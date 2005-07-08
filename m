From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Fri, 8 Jul 2005 10:14:58 +0200
Message-ID: <20050708081458.GA17022@pasky.ji.cz>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz> <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com> <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <Pine.LNX.4.58.0507071706090.25104@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Luck <tony.luck@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 10:15:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqo1E-0001lC-SM
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 10:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVGHIPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 04:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVGHIPJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 04:15:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7864 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262272AbVGHIPD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 04:15:03 -0400
Received: (qmail 21604 invoked by uid 2001); 8 Jul 2005 08:14:58 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507071706090.25104@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 08, 2005 at 02:09:48AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Thu, 7 Jul 2005, Linus Torvalds wrote:
> > > 
> > > cg-update from a local repo that contains packs is broken though :-(
> > 
> > Is this with cg-0.12? The most recent release should be happy with packs.
> 
> Ahh, I see it. It's because it uses "git-local-pull", and yes, 
> git-local-pull does the old filename assumption. Right?
> 
> Ho humm.. That's a bug in local-pull.c, although I'm not sure how to fix
> it best.

It seems like the whole pull family is totally borked now, and I'm
getting desperate. Looks like this evening will be *pull.c fixing for
me.

Jul 04 Daniel Barkalow  [PATCH 0/2] Support for transferring pack files in git-ssh-*

is what brings some hope to my life, though. Daniel? Any chance we could
get the similar fixes for local-pull? (I didn't actually look at the
patch but briefly.) I'll try to review the ssh patchset ASAP - I still
prefer it much to the fetch-pack things since its protocol is actually
extensible.

> The _simplest_ fix is to use git-fetch-pack. It doesn't give you the 
> convenient hard-linking, though.

Hard-linking is an absolute must for local repositories (well, either
that for people who want safety, or symlinking for the rest who want
speed - I want to make that one possible in Cogito ASAP but it requires
some non-trivial changes to some of its assumptions).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
