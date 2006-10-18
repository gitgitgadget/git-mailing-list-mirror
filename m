From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 03:46:24 +0200
Message-ID: <20061018014624.GO20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 03:47:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0Vq-00034D-PO
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWJRBq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWJRBq0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:46:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43910 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751117AbWJRBq0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 21:46:26 -0400
Received: (qmail 23134 invoked by uid 2001); 18 Oct 2006 03:46:24 +0200
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Disposition: inline
In-Reply-To: <vpqejt76vgz.fsf@ecrins.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29174>

Dear diary, on Tue, Oct 17, 2006 at 01:19:08PM CEST, I got a letter
where Matthieu Moy <Matthieu.Moy@imag.fr> said that...
> 2) a bound branch. It's not _very_ different from a normal branch, but
>    mostly "commit" behaves differently:
>    - it commits both on the local and the remote branch (equivalent to
>      "commit" + "push", but in a transactional way).
>    - it refuses to commit if you're out of date with the branch you're
>      bound to.
>    (this is "heavy checkout")

It isn't very nice because it enforces the update-before-commit
workflow, which was complaint of many CVS users and I can remember it
being one of the selling points of the distributed VCSes in 2001 or so,
although it is not so emphasized lately. (I understand that this is
something optional in Bazaar.)

BTW, merge commits aren't bad. They reflect what really happenned,
explicitly record the merge resolution taken, if there was any, and
protect you from accidentally losing or damaging [any portion of] your
changes. And they aren't cluttery either since we hide them from
non-graphical history listings by default.

Still, I can recognize that in some scenarios, people might find it
useful, and I can remember some people asking for it in the past. So I
couldn't resist and implemented it in Cogito as cg-commit --push. Pushed
out now. Took me about 5 minutes implementing it and 10 minutes documenting
it.  ;-)


P.S.: A general note for bleeding-edge Cogito users, I've rewritten the
local changes handling so that we always do three-way merge now instead
of that braindead patches diffing/applying, but it's not completely
stable yet, some testcases still fail. So be a bit careful when
updating/uncommitting/switching/... with uncommitted changes in the
working tree.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
