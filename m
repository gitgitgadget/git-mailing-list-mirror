From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: Can't import Xenomai svn repo
Date: Tue, 4 Jul 2006 12:17:04 +0200
Message-ID: <20060704101704.G3a844991@leonov.stosberg.net>
References: <44AA2B50.4060403@dave-tech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 12:17:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxhy7-00027l-7m
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 12:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWGDKRP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 06:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWGDKRP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 06:17:15 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:6272 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1750917AbWGDKRP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 06:17:15 -0400
Received: from leonov.stosberg.net (p213.54.90.18.tisdip.tiscali.de [213.54.90.18])
	by ncs.stosberg.net (Postfix) with ESMTP id 51F62AEBA004;
	Tue,  4 Jul 2006 12:17:07 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 76C78C5866; Tue,  4 Jul 2006 12:17:04 +0200 (CEST)
To: llandre <r&d2@dave-tech.it>
Content-Disposition: inline
In-Reply-To: <44AA2B50.4060403@dave-tech.it>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23277>

llandre wrote:

> I tried to import Xenomai svn repo but the script failed:
> 
> git-svnimport -v -C xenomai.git http://svn.gna.org/xenomai/trunk
> RA layer request failed: PROPFIND request failed on '/xenomai/trunk': 
> PROPFIND of '/xenomai/trunk': 405 Method Not Allowed (http://svn.gna.org) at 
> /usr/bin/git-svnimport line 135

Looks like the repository is simply not accessible by http.

    $ svn co http://svn.gna.org/xenomai/trunk
    svn: PROPFIND request failed on '/xenomai/trunk'
    svn: PROPFIND of '/xenomai/trunk': 405 Method Not Allowed (http://svn.gna.org)

git-svnimport imports a complete svn repository including its
branches and tags (as long as the svn repo follows the official
layout).  So you would run it against the repository's root:

    git svnimport svn://svn.gna.org/xenomai/

If you want to import/track the trunk only (and maybe commit to it),
git-svn from git's contrib is probably what you want.

Regards,
Dennis
