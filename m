From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: change filename/directory name of snapshots
Date: Fri, 8 Jun 2007 19:18:11 +0200
Message-ID: <20070608171811.GX4489@pasky.or.cz>
References: <20070607092708.GA25097@moooo.ath.cx> <7v4pliltuv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 19:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwi6O-0003Nm-GP
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 19:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbXFHRST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 13:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968625AbXFHRST
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 13:18:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41809 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967192AbXFHRSS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 13:18:18 -0400
Received: (qmail 17885 invoked by uid 2001); 8 Jun 2007 19:18:11 +0200
Content-Disposition: inline
In-Reply-To: <7v4pliltuv.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49487>

On Fri, Jun 08, 2007 at 10:43:04AM CEST, Junio C Hamano wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > /.git or .git is removed from the project name and the
> > basename of the remaining path is used as the beginning of
> > the filename and as the directory in the archive.
> >
> > The regexp will actually not strip off /.git or .git if there
> > wouldn't be anything left after removing it.
> >
> > Currently the full project name is used as directory in the
> > archive and the basename is used as filename.  For example a
> > repository named foo/bar/.git will have a archive named
> > .git-<version>.* and extract to foo/bar/.git.  With this patch
> > the file is named bar-<version>.* and extracts to bar.
> 
> Makes sense to me for "foo/bar/.git", but I am not sure if we
> would want to do this to "foo/bar.git".  Opinions?

I wouldn't personally really mind getting rid of the .git suffix in both
cases.  Yes, we are used to seeing the ".git" in the name, but I can't
think of any other reasons not to chop it off.

Having the .git in the archive name might be even more confusing since
there is a pseudo-convention (that I'm not sure anyone except me
follows, so maybe not :) that repositories have .git in the name while
working trees don't, and that tarball contains a working tree.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
