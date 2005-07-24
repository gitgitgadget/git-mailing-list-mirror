From: Petr Baudis <pasky@suse.cz>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Sun, 24 Jul 2005 10:57:57 +0200
Message-ID: <20050724085757.GB7601@pasky.ji.cz>
References: <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org> <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org> <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org> <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org> <20050712074801.GD6363@pasky.ji.cz> <7vy88c5r4w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Marc Singer <elf@buici.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 10:58:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwcJL-00039G-HD
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 10:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVGXI6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 04:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVGXI6A
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 04:58:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19727 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261944AbVGXI57 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2005 04:57:59 -0400
Received: (qmail 14600 invoked by uid 2001); 24 Jul 2005 08:57:57 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy88c5r4w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Jul 12, 2005 at 11:07:43AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> If you block certain operations while you have seeked to non-top
> anyway, wouldn't it be cleaner to have .git/seeked-to that
> records the commit ID you are at, which at the same time
> indicates that you are in a special situation, and not touching
> HEAD at all?  Then .git/HEAD will always have that line of
> development information.
> 
> Well, that was half tongue-in-cheek suggestion; I have a feeling
> that you may feel it is a bit too late to change this kind of
> thing easily.

The thing is, _everything_ assumes .git/HEAD is the current commit
checked out in the index. All the Cogito (that wouldn't be hard to
change at all), all the other Porcelains, the core GIT tools. So
changing that would be difficult and it's much easier this way.

> But if we are going to agree on using .git/head-name, I'd rather
> see it exist all times, so that cat "$GIT_DIR/head-name" would
> always tell us which branch we are working in.

After some thought, I like Linus' approach more now, having head-name
only when it's really necessary.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
