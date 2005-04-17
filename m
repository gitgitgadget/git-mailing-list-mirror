From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 20:14:46 +0200
Message-ID: <20050417181446.GC1461@pasky.ji.cz>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417170539.B13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170937020.7211@ppc970.osdl.org> <4262A767.4040300@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:11:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEEW-0003Xk-Ez
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVDQSOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDQSOu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:14:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44180 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261388AbVDQSOs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:14:48 -0400
Received: (qmail 4645 invoked by uid 2001); 17 Apr 2005 18:14:46 -0000
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Content-Disposition: inline
In-Reply-To: <4262A767.4040300@dwheeler.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 08:13:59PM CEST, I got a letter
where "David A. Wheeler" <dwheeler@dwheeler.com> told me that...
> On Sun, 17 Apr 2005, Russell King wrote:
> >>BTW, there appears to be "errors" in the history committed thus far.
> >>I'm not sure where this came from though.  Some of them could be
> >>UTF8 vs ASCII issues, ....> 
> ...
> >>One thing which definitely needs to be considered is - what character
> >>encoding are the comments to be stored as?
> 
> Linus Torvalds replied:
> >To git, it's just a byte stream, and you can have binary comments if you
> >want to. I personally would prefer to move towards UTF eventually, but I
> >really don't think it matters a whole lot as long as 99.9% of everything
> >we'd see there is still 7-bit ascii.
> 
> I would _heartily_ recommend moving towards UTF-8 as the
> internal charset for all comments.  Alternatives are possible
> (e.g., recording the charset in the header), but they're
> incredibly messy.  Even if you don't normally work in UTF-8,
> it's pretty easy to set most editors up to read & write UTF-8.
> Having the data stored as a constant charset eliminates
> a raft of error-prone code.

I tend to agree here. My toilet stuff is what can handle various
locale-based conversions at the commit-tree / cat-file tree sides etc,
but UTF-8 should be certainly the way to go internally.

Not that the plumbing should actually _care_ at all; anyone who uses it
should take the care, so this is more of a "social" thing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
