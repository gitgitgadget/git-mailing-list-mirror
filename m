From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-rev-list: add "--dense" flag
Date: Sat, 22 Oct 2005 04:56:38 +0200
Message-ID: <20051022025638.GQ30889@pasky.or.cz>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org> <20051022003733.GA8351@pasky.or.cz> <Pine.LNX.4.64.0510211814050.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 04:57:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET9Yo-0003US-UW
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 04:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVJVC4l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 22:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVJVC4l
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 22:56:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5536 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932572AbVJVC4k (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 22:56:40 -0400
Received: (qmail 19529 invoked by uid 2001); 22 Oct 2005 04:56:38 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510211814050.10477@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10464>

Dear diary, on Sat, Oct 22, 2005 at 03:26:27AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Sat, 22 Oct 2005, Petr Baudis wrote:
> > There is no documentation for the --dense flag and it is even missing
> > from the usage string.
> 
> I'm not much for docs ;)
> 
> The whole path argument also isn't even there (and without paths, --dense 
> doesn't matter)

Then it should be added to the docs as well. ;-)

Oh well, I guess I can always send a patch when yours will get applied. :-)

> > But my main concern is - will it be possible to do the rename detection
> > here as well?
> 
> Yes. Note that git-rev-list doesn't actually _do_ the diff, it only checks 
> whether the tree is changed. You still just get a list of commits out of 
> it, and it is up to you to decide what to do with it.

Ok, fair enough.

> If you're just going to feed them to diff-tree _anyway_, then you might as 
> well not even do the dense thing, because quite frankly, you're just doing 
> extra work.

fork() is awfully expensive for me. fork()ing something (supposedly)
trivial (it was stat) slowed my (non-trivial) loop about 4 times. So I
think it will still pay off hugely if I will be able do the diff-tree
only on the interesting commits.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
