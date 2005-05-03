From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Tue, 3 May 2005 23:21:43 +0200
Message-ID: <20050503212142.GB15995@pasky.ji.cz>
References: <20050503182850.GL18917@shell0.pdx.osdl.net> <20050503193536.GE5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:16:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4js-0000bW-CZ
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVECVVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVECVVw
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:21:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56011 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261717AbVECVVt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 17:21:49 -0400
Received: (qmail 10261 invoked by uid 2001); 3 May 2005 21:21:43 -0000
To: Chris Wright <chrisw@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050503193536.GE5324@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 03, 2005 at 09:35:36PM CEST, I got a letter
where Chris Wright <chrisw@osdl.org> told me that...
> * Chris Wright (chrisw@osdl.org) wrote:
> > Here's the outstanding updates for the spec file, up to 0.8-2 which is
> > the latest on kernel.org.
> > 
> > 	http://www.kernel.org/pub/software/scm/cogito/RPMS/
> 
> What's your method for creating a release tarball?  If it were formalized
> (i.e. Makefile rule), then it'd be simple to use VERSION to drive the
> spec file, and it'd only need updating for real content changes (similar
> to what Kay did).

For now, I do it so seldom that I just manually do

	cg-log >Changelog
	cg-export ~/cogito-0.9
	cp Changelog ~/cogito-0.9
	cd ~
	tar cvvfz cogito-0.9.tar.gz cogito-0.9

OTOH, I'd like to change this all to just

	cg-export ~/cogito-0.9.tar.gz

when I get to merge the relevant patches; I'm not sure there is so much
of a value to bundle the Changelog; just get the git tree and do cg-log
on your own, or use the web interface.

I might however have some private mkrelease.sh script which would do

	echo "$1" >VERSION
	update-spec-file
	echo "$1" | cg-commit
	cg-tag "$1"

or something.


BTW, did you have a particular reason to split the .spec file updates to
three parts? I think it doesn't make much sense and it'd be probably
enough to update it at once, when we are not doing it at the right time
anyway.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
