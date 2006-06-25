From: Petr Baudis <pasky@suse.cz>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sun, 25 Jun 2006 11:34:44 +0200
Message-ID: <20060625093444.GD21864@pasky.or.cz>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net> <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net> <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org> <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <20060625012435.GZ21864@pasky.or.cz> <7vfyhtopjm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 11:34:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuR10-0000IM-4w
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 11:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWFYJer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 05:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWFYJer
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 05:34:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20434 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932181AbWFYJeq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 05:34:46 -0400
Received: (qmail 22395 invoked by uid 2001); 25 Jun 2006 11:34:44 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyhtopjm.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22598>

Dear diary, on Sun, Jun 25, 2006 at 05:57:33AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> >>  - RPM target -- we probably acquired a new build-dependency in
> >>    which case the .spec file needs to be updated;
> >
> > Well, perl is currently not listed even as a runtime dependency,
> > so does it really need to be listed as a build dependency?
> 
> Really?  I think rpmbuild is getting anything that matches "^use "
> and listing the perl modules as dependencies.

I had on my mind to depend only on modules that are part of the default
Perl distribution, since installing them from CPAN is a bother if you
are installing Git to your home directory. That is why we bundle Error.

All the modules we depend on should come bundled with Perl since 5.8.1.
Now, I'm not sure what our "cutoff" point is, and even if it is
something like 5.6.0 whether we can just require users of Perl older
than 5.8.1 (which should be only some rare and obscure systems anyway)
to install the modules from CPAN.

If not, we can just get rid of Scalar::Util and XSLoader and we should
be clean; XSLoader should be easy, Scalar::Util somewhat more messy
since we will have to get Error.pm own .xs as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
