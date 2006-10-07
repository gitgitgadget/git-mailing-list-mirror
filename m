From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Support hiding of chosen repositories from project list
Date: Sat, 7 Oct 2006 14:32:00 +0200
Message-ID: <20061007123200.GY20017@pasky.or.cz>
References: <20061006182822.9194.78330.stgit@rover> <7vu02gtqqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 14:32:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWBLh-00006c-TA
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 14:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWJGMcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 08:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWJGMcF
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 08:32:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9630 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751038AbWJGMcC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 08:32:02 -0400
Received: (qmail 20778 invoked by uid 2001); 7 Oct 2006 14:32:00 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu02gtqqd.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28477>

Dear diary, on Sat, Oct 07, 2006 at 11:33:30AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > @@ -125,6 +125,7 @@ GITWEB_HOME_LINK_STR = projects
> >  GITWEB_SITENAME =
> >  GITWEB_PROJECTROOT = /srv/git
> 
> What code base are you working on?

Oops. This is the only custom Makefile change I use at repo.or.cz, it
kind of slipped through. Yes, I should throw it to Makefile.config or
something.

(BTW, I privately consider /pub/git as completely specific to kernel.org
setup and pure evil to have as default; I would much prefer to have the
default something more standard and LHS-compliant like /srv/git (almost)
is. Though I can see the possible pitfalls of changing the default at
this point (though Google says that only tipc.cslab.ericsson.net uses
the same path), this default leads to people inventing own random paths
and chaos reigns: /var/git in Gentoo, /srv/git in SUSE, abomination like
/var/cache/git (!) in Debian, others don't seem to bother with gitweb.)

> >  GITWEB_EXPORT_OK =
> > +GITWEB_HIDE_REPO = .hide
> >  GITWEB_STRICT_EXPORT =
> >  GITWEB_BASE_URL =
> >  GITWEB_LIST =
> 
> I see how this feature would be useful, but I am not happy to
> add random new files under $GIT_DIR/.

Ok, so it's another thing in the conffile-parser queue.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
