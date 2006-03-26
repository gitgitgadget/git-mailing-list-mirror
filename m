From: Petr Baudis <pasky@suse.cz>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 12:07:17 +0200
Message-ID: <20060326100717.GD18185@pasky.or.cz>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 12:07:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNS9m-0007uw-TE
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 12:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWCZKHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 05:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWCZKHJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 05:07:09 -0500
Received: from w241.dkm.cz ([62.24.88.241]:25255 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751204AbWCZKHH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 05:07:07 -0500
Received: (qmail 6884 invoked by uid 2001); 26 Mar 2006 12:07:17 +0200
To: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <44264426.8010608@michonline.com> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18031>

Dear diary, on Sun, Mar 26, 2006 at 05:19:50AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Sun, 26 Mar 2006, Petr Baudis wrote:
> > 
> >   In [1], Linus suggests a non-core solution. Unfortunately, it doesn't
> > fly - it requires at least two git-ls-tree calls per revision which
> > would bog things down awfully (to roughly half of the original speed).
> 
> No it doesn't. It requires one git-ls-tree WHEN SOMETHING IS RENAMED.
> 
> In other words, basically never.

Huh? I don't see that now (and caps don't help me see it better). That's
certainly not what is in [1], and I don't see _how_ to detect the
renames in this case, and what would I be actually doing git-ls-tree for
when I've already detected the rename. Based on [1], I'd be doing
git-ls-tree merely to detect that a file _disappeared_ in the first
place, I have to do other stuff to detect the renames themselves.

Dear diary, on Sun, Mar 26, 2006 at 09:35:02AM CEST, I got a letter
where Ryan Anderson <ryan@michonline.com> said that...
> A simple example is the first loop in git-annotate.perl.  (Which was
> basically written by Linus, I just translated it from a
> shell/pseudo-code example into Perl)

Thanks for the hint. Unfortunately, this is precisely the thing I want
to avoid, that is essentially reimplementing part of git-rev-list - to
do something good, I would have to do my own toposort and merge by date
between parallel lines. OTOH, I might just construct a large revlist
commandline specifying all the segments I'm interested in and see what
happens when I run that.

Besides, doing it in shell would be pretty ugly job (forcing me to
finally rewrite it in perl is not a bad thing but that'd be a somewhat
larger project since I share various common routines with other cg
tools, etc).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
