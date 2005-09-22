From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-export incompatible with older versions of GNU tar
Date: Thu, 22 Sep 2005 14:08:41 +0200
Message-ID: <20050922120841.GH21019@pasky.or.cz>
References: <20050922112331.75971353A0B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 14:10:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIPsl-0002iL-PI
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 14:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVIVMIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 08:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVIVMIn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 08:08:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57996 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030272AbVIVMIn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 08:08:43 -0400
Received: (qmail 4324 invoked by uid 2001); 22 Sep 2005 14:08:41 +0200
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050922112331.75971353A0B@atlas.denx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9111>

Dear diary, on Thu, Sep 22, 2005 at 01:23:31PM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> Minor compatibility issue:
> 
> The archives created by the "cg-export" command contain entries  that
> cause problems with older versions of GNU tar:
> 
> -> cg-export /tmp/foo.tar.bz2
> -> tar jtvf /tmp/foo.tar.bz2
> ?rw------- git/git          52 1970-01-01 01:00:00 pax_global_header unknown file type `g'
> drwxr-xr-x git/git           0 2005-09-22 09:46:19 foo/
> -rw-r--r-- git/git      134225 2005-09-22 09:46:19 foo/CHANGELOG
> -rw-r--r-- git/git       15701 2005-09-22 09:46:19 foo/COPYING
> -rw-r--r-- git/git        9960 2005-09-22 09:46:19 foo/CREDITS
> -rw-r--r-- git/git        9578 2005-09-22 09:46:19 foo/MAINTAINERS
> ...
> -> tar jxf foo.tar.bz2 
> tar: pax_global_header: Unknown file type 'g', extracted as normal file
> ...
> -> tar --version
> tar (GNU tar) 1.13.25
> ...
> -> rpm -q git-core cogito
> git-core-0.99.7-1
> cogito-0.15-1

This would be a problem with Core GIT's git-tar-tree. The pax headers
seem nice to have, though.

It is unclear if the tar actually extracts the archive or not, though.
Does it just complain with those warnings, or are they fatal errors?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
