From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] TopGit - A different patch queue manager
Date: Sun, 3 Aug 2008 05:14:24 +0200
Message-ID: <20080803031424.GV32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 05:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPU4h-0003u1-RD
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 05:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYHCDO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 23:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYHCDO2
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 23:14:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57532 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbYHCDO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 23:14:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id DA2213939BDC; Sun,  3 Aug 2008 05:14:24 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91197>

  Hi,

  I'd like to announce TopGit v0.1, the first (while also the youngest)
project from my Rhine pipeline (sitting at the river shore, hacking
free of all online distractions; the only catch is that the offline
distractions can be plentiful as well - too many pretty girls tend
to cluster around the water in the hot summer days for some strange
reason.)

  TopGit is meant as a fresh start in the steps of StGIT, quilt-in-git
and others, of course in an attempt to Get It Right this time around.
TopGit is absolutely minimal porcelain layer that will manage your
patch queue for you using topic branches, one patch per branch.
And do _ONLY_ that. Unlike with StGIT, you can actually use the index.

  TopGit aims to scratch three of my long-term patch management itches:

	(i) Let you freely specify patch dependencies, instead of
	forcing you to linearize your patches into a series

	(ii) Keep your development history rigorously - it is to be
	cleaned up only once, and that is when submitted upstream

	(iii) Actually _WORK_ in the distributed environment;
	you can have several repositories and develop your patches
	in all of them

  You can get TopGit at

	http://repo.or.cz/w/topgit.git

and read up on its design, usage and implementation at:

	http://repo.or.cz/w/topgit.git?a=blob;f=README


  This is v0.1. I started working on it last evening (by spending over
two hours writing the README from scratch up to pretty much its current
state), got it feature complete few hours ago and testing it out the
rest of the evening. So yes, it probably still has some bugs, but it
should be ready for general practical usage, so please give it a try.
I just recreated

	http://repo.or.cz/w/git/gitweb.git

with it and plan to use it pretty much exclusively for all my Git
patches from now on (and it turns out there is quite a few, I just had
no good way to organize and submit them so far).


  Besides that, some utility commands are still missing, some of them
are TODO'd in the README. Most notably, the distributed workflow still
has no explicit support within TopGit which makes it a little awkward,
and there is actually no way to mail your patches yet ;-) - tg patch
will only dump a single one on stdout and you need to do the rest.


  TopGit is not very well optimized so far; I made little to no
benchmarks and I'm focused on getting things work right first. Still,
I believe that most operations should not take noticeably long until
you get into many tens of densely dependent patches. One exception
is 'tg summary', which is unfortunately dog-slow and I couldn't
figure out how to speed it up further so far.


  P.S.: git/gitweb.git is mentioned here just as an example of
real-world TopGit usage; ignore the contents. I actually do intend
to revive this repository, but there's still a lot of work to do.

  P.P.S.: Can I get trademark on the (ironically) /[^p]g/ porcelains
now? ;-)


  Have fun,

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
