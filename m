From: Petr Baudis <pasky@suse.cz>
Subject: Re: Use a *real* built-in diff generator
Date: Sun, 26 Mar 2006 20:20:28 +0200
Message-ID: <20060326182028.GP18185@pasky.or.cz>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org> <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com> <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org> <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0603251030340.15714@g5.osdl.org> <20060326110934.GA3774@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 26 20:20:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNZqe-0003db-S6
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 20:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWCZSUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 13:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWCZSUR
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 13:20:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43925 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932103AbWCZSUQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 13:20:16 -0500
Received: (qmail 17116 invoked by uid 2001); 26 Mar 2006 20:20:28 +0200
To: Ralf Baechle <ralf@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20060326110934.GA3774@linux-mips.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18053>

Dear diary, on Sun, Mar 26, 2006 at 01:09:35PM CEST, I got a letter
where Ralf Baechle <ralf@linux-mips.org> said that...
> On Sat, Mar 25, 2006 at 10:39:03AM -0800, Linus Torvalds wrote:
> 
> > Besides, I hate how GNU patch bends over backwards in applying crap that 
> > isn't a proper patch at all (whitespace-corruption, you name it: GNU patch 
> > will accept it). Also, I made "git-apply" be all-or-nothing: either it 
> > applies the _whole_ patch (across many different files) or it applies none 
> > of it. With GNU patch, if you get an error on the fifth file, the four 
> > first files have been modified already - aarrgghhh..
> 
> Which is apply's greatest strength - and weakness.  GNU diff doesn't
> understand the file renamings bits of git diffs, so they they need to be
> used with apply.  So if a patch doesn't apply?  Apply doesn't even have
> an option to apply things as good as it can and leave the rest in
> reject files.  Yuck.

I've just updated cg-patch on the master branch today to understand file
renames, so it should be possible to use it for applying fuzzy patches.
(OTOH, cg-patch has grown way too complex and ugly for my taste. It'd be
nice if git-apply could take over the ugly part of the task.)

No dice with patches containing copy information, though. We would need
to perform the copy _before_ applying the patch itself and we have no
infrastructure for that (so far it has been enough to do the
git-specific stuff after applying the patch itself).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
