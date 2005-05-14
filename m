From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add --author match to git-rev-list and git-rev-tree.
Date: Sat, 14 May 2005 17:52:57 +0200
Message-ID: <20050514155257.GR3905@pasky.ji.cz>
References: <20050514061914.GB14353@tumblerings.org> <7vu0l62l27.fsf@assigned-by-dhcp.cox.net> <20050514150607.GA14184@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 17:53:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWywn-0007DJ-5G
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVENPxB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVENPxB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:53:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64922 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261437AbVENPw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 11:52:58 -0400
Received: (qmail 17359 invoked by uid 2001); 14 May 2005 15:52:57 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050514150607.GA14184@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 05:06:07PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> On Sat, May 14, 2005 at 02:50:24AM -0700, Junio C Hamano wrote:
> > Zack Brown wondered if handling author match at core GIT level
> > would make cg-log -u go faster (JIT also can use this in jit-log
> > --author).  Here is a patch to implement it.
> > 
> > I considered adding author and committer strings to commit
> > objects for general use as commit objects are parsed, but I was
> > unsure about the lifetime rules of the commit objects (nobody
> > seems to free them in the current code), so refrained from doing
> > so for the time being.  The code instead re-reads the commit
> > object when it needs to filter them by the author.
> 
> I applied this, but can't figure out the change to make to cg-log in order to
> actually test it.
> 
> - git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
> + git-cat-file --author $user commit $commit || continue
> 
> sure didn't work.

You throw that whole thing away and pass the --author parameter directly
to git-rev-(list|tree).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
