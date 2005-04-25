From: Paul Dickson <paul@permanentmail.com>
Subject: Re: [PATCH] git-pasky spec file
Date: Mon, 25 Apr 2005 14:24:11 -0700
Message-ID: <20050425142411.1849a5db.paul@permanentmail.com>
References: <20050422015521.GK493@shell0.pdx.osdl.net>
	<20050422024010.GE7443@pasky.ji.cz>
	<20050422024834.GM493@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 23:21:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQB11-0001SY-P9
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 23:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVDYVZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 17:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDYVZz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 17:25:55 -0400
Received: from orb.pobox.com ([207.8.226.5]:62366 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261221AbVDYVYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 17:24:25 -0400
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP
	id C7EB87D7; Mon, 25 Apr 2005 17:24:21 -0400 (EDT)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A2EE87;
	Mon, 25 Apr 2005 17:24:19 -0400 (EDT)
Received: from violet.pwd.internal (violet [192.168.1.4])
	by red.pwd.internal (8.12.8/8.12.8) with SMTP id j3PLOCT3031241;
	Mon, 25 Apr 2005 14:24:15 -0700
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050422024834.GM493@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 1.9.7 (GTK+ 2.4.14; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Apr 2005 19:48:34 -0700, Chris Wright wrote:

> * Petr Baudis (pasky@ucw.cz) wrote:
> > Dear diary, on Fri, Apr 22, 2005 at 03:55:21AM CEST, I got a letter
> > where Chris Wright <chrisw@osdl.org> told me that...
> > > Here's a simple spec file to do rpm builds.  It's against the
> > > latest Makefile (which has the s/BINDIR/bindir/ change).  I've used
> > > DESTDIR, although it's not clear it's meant to stay in the Makefile.
> > > For now, there's no dynamic (git.spec.in, for example) update to the
> > > Version, so it's set against 0.6.3 (expecting it to be forthcoming
> > > shortly).  It installs to /usr/local/bin, and expects the tarball to be
> > > named git-pasky-0.6.3.tar.bz2.  Creates a package named git, which seems
> > > fine since Linus' isn't likely to be packaged directly.  Enjoy.
> > 
> > Thanks, applied. I'll gladly yet you maintain this file, but...
> 
> No problem...
> 
> > > --- /dev/null	1969-12-31 16:00:00.000000000 -0800
> > > +++ git-pasky-0.6.3/git.spec	2005-04-21 18:42:18.000000000 -0700
> > > @@ -0,0 +1,43 @@
> > > +%install
> > > +rm -rf $RPM_BUILD_ROOT
> > > +make DESTDIR=$RPM_BUILD_ROOT/usr/local/ bindir=bin/ install
> > 
> > I doubt this is actually what you want. I suppose you want
> > 
> > make DESTDIR=$RPM_BUILD_ROOT prefix=/usr/local install
> 
> Yup, that makes more sense.  Feel free to update if you're so inclined.

If you're building an RPM, it should go in /usr not /usr/local.  /usr/local
is for unmanaged (non-RPM) installs.

	-Paul

