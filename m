From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 14:33:49 +0200
Message-ID: <20061019123349.GE20017@pasky.or.cz>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org> <20061019091045.GV75501@over-yonder.net> <45375E56.4090106@op5.se> <vpqirigqzpd.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 14:34:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaX5v-0002kS-QB
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 14:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWJSMdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 08:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWJSMdv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 08:33:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51080 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751408AbWJSMdu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 08:33:50 -0400
Received: (qmail 30920 invoked by uid 2001); 19 Oct 2006 14:33:49 +0200
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Disposition: inline
In-Reply-To: <vpqirigqzpd.fsf@ecrins.imag.fr>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29346>

Dear diary, on Thu, Oct 19, 2006 at 02:04:14PM CEST, I got a letter
where Matthieu Moy <Matthieu.Moy@imag.fr> said that...
> What people call "leftmost ancestor" is the revision which used to be
> the tip at the time you commited. For example, if you do "bzr diff;
> bzr commit" the diff shown before is the same as the one got with
> "bzr diff -r last:1" right after the commit.

The lack of parents ordering in Git is directly connected with
fast-forwarding.

Consider

 repo1   repo2

   a       a
  /       /
 b       c

Now repo2 merges with repo1:

 repo1   repo2

   a       a
  /       / \
 b       c   b
          \ /
           m

repo1 tip ('b') is not ancestor of repo2 tip ('c') so a three-way merge
is done and a new 'm' merge commit is created.

And now repo1 merges with repo2:

 repo1   repo2

   a       a
  / \     / \
 c   b   c   b
  \ /     \ /
   m       m

Because previous repo1 tip ('b') was ancestor of repo2 tip ('m'), a
fast-forward happenned and repo1 tip simply moved to 'm'. But this
"flipped" the development from repo1 POV - you cannot assume anymore
that the first ("leftmost") parent is special.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
