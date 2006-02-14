From: Petr Baudis <pasky@suse.cz>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 22:19:35 +0100
Message-ID: <20060214211935.GG31278@pasky.or.cz>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org> <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org> <87fymlvgzv.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141224110.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Nicolas Vilz 'niv' <niv@iaglans.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:19:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97Zl-0001tC-ET
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 22:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWBNVSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 16:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWBNVSt
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 16:18:49 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58754 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422784AbWBNVSs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 16:18:48 -0500
Received: (qmail 11168 invoked by uid 2001); 14 Feb 2006 22:19:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602141224110.3691@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16175>

Dear diary, on Tue, Feb 14, 2006 at 09:40:24PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Tue, 14 Feb 2006, Carl Worth wrote:
> > But I'd still like to be able to do this without having to invent a
> > fake branch name, without the ability to accidentally commit on the
> > fake branch, and without the possibility of accidentally leaving those
> > commits dangling the next time I seek somewhere else.
> 
> Pasky did this before the "multi-branch" thing was common, and calls it 
> "cg-seek". 
> 
> I think that does exactly what you ask for, I just don't really see the 
> point. The downside of cg-seek is that you're really really limited to 
> what you can do with it.
> 
> For example, it may be "overhead" to have a dummy branch for bisection, 
> but it means (for example) that you can actually do real work on the point 
> that "git bisect" points you to.
> 
> For example, if you hit a compile error, you can _literally_ fix that 
> compile error AND COMMIT that state, and when you then mark that commit 
> "good" or "bad" when you continue to bisect, bisection will actually do 
> the right thing. Something that would be impossible in a "seek" 
> environment, where you don't have a branch that you can do development on.

That's a neat idea - I like this. I just tweaked cg-commit -f so that it
will now override the cg-seek block, with a warning that you should be
content about your commit being thrown away.

Really, except this blocking restriction (which is really a check for a
non-empty .git/blocked file), cg-seek does exactly the fake branch
thing, as you actually persuaded me to do. So you are on a dedicated
seeking branch and theoretically you can do development on it - it's
only too easy to lose the commits.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
