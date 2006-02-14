From: Petr Baudis <pasky@suse.cz>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 22:41:24 +0100
Message-ID: <20060214214123.GI31278@pasky.or.cz>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org> <87fymlvgzv.wl%cworth@cworth.org> <200602142230.11442.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:40:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97ua-0006tT-CY
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 22:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWBNVki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 16:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWBNVkh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 16:40:37 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5349 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422810AbWBNVkh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 16:40:37 -0500
Received: (qmail 14911 invoked by uid 2001); 14 Feb 2006 22:41:24 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200602142230.11442.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16181>

Dear diary, on Tue, Feb 14, 2006 at 10:30:11PM CET, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> Why not allow something like
> 
> 	git-checkout master~5
> 
> which implicitly does create a read-only branch "seek-point"?
> I do not think that it is important to remember the branch name you seek
> from.
> 
> A branch could be marked readonly by above command with
> 
> 	chmod a-w .git/refs/heads/seek
> 
> And git-commit should refuse to commit on a readonly ref, telling
> the user to create a writable branch before with "git-branch new".

We just abolished symlinks. Can we afford doing this, from the
portability standpoint?

> This would also help "cg-seek" to prohibit the user to commit on
> "cg-seek-point" via "git-commit" (by setting cg-seek-point read-only).

For now, this is accomplished (in Cogito, but we just introduced this to
git-bisect as well) by creating .git/head-name. This has the advantage
that you know to which branch to return after the seeking is over, and
it also marks the current head "read-only" (in the commit sense) for
Cogito (and git-bisect start).

It is obviously less flexible since it lets you mark only the current
head read-only, but noone asked for more before. ;)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
