From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Tue, 3 May 2005 23:44:01 +0200
Message-ID: <20050503214401.GE15995@pasky.ji.cz>
References: <20050503211527.42339.qmail@web41208.mail.yahoo.com> <20050503182850.GL18917@shell0.pdx.osdl.net> <20050503193536.GE5324@shell0.pdx.osdl.net> <20050503212142.GB15995@pasky.ji.cz> <20050503213216.GF5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:40:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT56S-0007FU-Ih
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVECVo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVECVo0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:44:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13260 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261813AbVECVoG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 17:44:06 -0400
Received: (qmail 12588 invoked by uid 2001); 3 May 2005 21:44:01 -0000
To: Chris Wright <chrisw@osdl.org>, Mark Allen <mrallen1@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20050503211527.42339.qmail@web41208.mail.yahoo.com> <20050503213216.GF5324@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 11:32:16PM CEST, I got a letter
where Chris Wright <chrisw@osdl.org> told me that...
> * Petr Baudis (pasky@ucw.cz) wrote:
> > I might however have some private mkrelease.sh script which would do
> > 
> > 	echo "$1" >VERSION
> > 	update-spec-file
> > 	echo "$1" | cg-commit
> > 	cg-tag "$1"
> > 
> > or something.
> 
> If you had a Makefile target like the one Mark Allen just posted, would
> you use that?

No, I definitively won't use that:

(i)  The created tarball is Evil. It does not contain everything in a
subdirectory.

(ii) I don't want to have yet another place which I'm supposed to keep
up to date with regard to what should be packaged. That's one of the
things the SCM is for, and it already records precisely this
information, so I'd actually use it. cg-export foo.tar.gz is the perfect
tool for this.

> I'd simply add a git.spec: rule, and have git.spec built
> as a dependency for tarball.

I wouldn't accept this neither. If git.spec is already version
controlled, it should be up-to-date in the version control. Therefore,
you need to update it at the time of release, not at the time of
generating the tarball.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
