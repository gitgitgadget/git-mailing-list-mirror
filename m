From: Petr Baudis <pasky@ucw.cz>
Subject: Re: I'm missing isofs.h
Date: Thu, 28 Apr 2005 02:32:47 +0200
Message-ID: <20050428003246.GV22956@pasky.ji.cz>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz> <Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:27:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwsG-0008D5-Di
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVD1Acu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVD1Acu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:32:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:24750 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262122AbVD1Acs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:32:48 -0400
Received: (qmail 1891 invoked by uid 2001); 28 Apr 2005 00:32:47 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 02:19:07AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> And to get the difference between an old tree and the current working 
> tree, you should just need to do
> 
> 	diff-cache -r -z $tree
> 
> and you're done.
> 
> In other words, that temporary index file really isn't needed in the 
> "diff-cache" world. It can diff the current index against _any_ old tree.

Oops, you are of course right. This was a stupid leftover from the
pre-diff-cache days, and since then I never looked at this code from
sufficient distance to see it. ;-)

> And together with Junio's stuff from today, you can literally just do
> 
> 	diff-cache -p $tree
> 
> and you're done - it diffs any release "$tree" against the current state.

Actually, I can't; the patch generator is not on par with mine yet.
It does not show modes and does not indicate file adds/removals by
/dev/null - basically, I need something cg-patch can eat (and it should
be backwards compatible). I think throwing the sha1 hashes away will not
harm; I got used to the Index: field and === marker, but I don't care if
I loose it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
