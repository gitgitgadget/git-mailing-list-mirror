From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH 0/3] cogito spec file updates
Date: Tue, 3 May 2005 14:32:16 -0700
Message-ID: <20050503213216.GF5324@shell0.pdx.osdl.net>
References: <20050503182850.GL18917@shell0.pdx.osdl.net> <20050503193536.GE5324@shell0.pdx.osdl.net> <20050503212142.GB15995@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:27:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4uD-0003xg-LV
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVECVcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVECVcb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:32:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:26022 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261777AbVECVcW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 17:32:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43LWGs4021704
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 14:32:16 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43LWG8A017587;
	Tue, 3 May 2005 14:32:16 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j43LWG4R017586;
	Tue, 3 May 2005 14:32:16 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050503212142.GB15995@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Petr Baudis (pasky@ucw.cz) wrote:
> Dear diary, on Tue, May 03, 2005 at 09:35:36PM CEST, I got a letter
> where Chris Wright <chrisw@osdl.org> told me that...
> > * Chris Wright (chrisw@osdl.org) wrote:
> > > Here's the outstanding updates for the spec file, up to 0.8-2 which is
> > > the latest on kernel.org.
> > > 
> > > 	http://www.kernel.org/pub/software/scm/cogito/RPMS/
> > 
> > What's your method for creating a release tarball?  If it were formalized
> > (i.e. Makefile rule), then it'd be simple to use VERSION to drive the
> > spec file, and it'd only need updating for real content changes (similar
> > to what Kay did).
> 
> For now, I do it so seldom that I just manually do
> 
> 	cg-log >Changelog
> 	cg-export ~/cogito-0.9
> 	cp Changelog ~/cogito-0.9
> 	cd ~
> 	tar cvvfz cogito-0.9.tar.gz cogito-0.9
> 
> OTOH, I'd like to change this all to just
> 
> 	cg-export ~/cogito-0.9.tar.gz
> 
> when I get to merge the relevant patches; I'm not sure there is so much
> of a value to bundle the Changelog; just get the git tree and do cg-log
> on your own, or use the web interface.
> 
> I might however have some private mkrelease.sh script which would do
> 
> 	echo "$1" >VERSION
> 	update-spec-file
> 	echo "$1" | cg-commit
> 	cg-tag "$1"
> 
> or something.

If you had a Makefile target like the one Mark Allen just posted, would
you use that?  I'd simply add a git.spec: rule, and have git.spec built
as a dependency for tarball.

> BTW, did you have a particular reason to split the .spec file updates to
> three parts? I think it doesn't make much sense and it'd be probably
> enough to update it at once, when we are not doing it at the right time
> anyway.

Just because that's how I had them locally, and it keeps the file
revision history intact (I don't mind how you prefer to pull them in).

thanks,
-chris
