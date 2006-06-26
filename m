From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH] "test" in Solaris' /bin/sh does not support -e
Date: Mon, 26 Jun 2006 11:42:12 +0200
Message-ID: <20060626094211.G3b49c5c3@leonov.stosberg.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net> <20060626082754.G6ec0a61e@leonov.stosberg.net> <7vwtb4i89d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 11:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Funbv-0006gs-B0
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 11:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWFZJmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 05:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWFZJmR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 05:42:17 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:29847 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751309AbWFZJmR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 05:42:17 -0400
Received: from leonov.stosberg.net (p213.54.83.220.tisdip.tiscali.de [213.54.83.220])
	by ncs.stosberg.net (Postfix) with ESMTP id C1A3FAEBA065;
	Mon, 26 Jun 2006 11:42:09 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 52B43110498; Mon, 26 Jun 2006 11:42:12 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtb4i89d.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22671>

Junio C Hamano wrote:

> Dennis Stosberg <dennis@stosberg.net> writes:
> 
> > Running "make clean" currently fails:
> >   [ ! -e perl/Makefile ] || make -C perl/ clean
> >   /bin/sh: test: argument expected
> >   make: *** [clean] Error 1
> 
> Ah, _BAD_.  We seem to have the same in git-branch, git-checkout,
> git-clone and git-tag.  You would probably need this on top of
> "master".

The SHELL_PATH in the Makefile is being set to "/bin/bash" on
Solaris, so there is currently no problem with those.

A lot of bashisms have been removed from the shell scripts since
that SHELL_PATH override was added in September 2005; I will have a
look whether it's still necessary.

Regards,
Dennis
