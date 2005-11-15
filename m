From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 12:21:35 -0500
Message-ID: <1132075295.25640.59.camel@dv>
References: <1132034390.22207.18.camel@dv>
	 <7vveyuqto5.fsf@assigned-by-dhcp.cox.net> <1132042427.3512.50.camel@dv>
	 <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051115121854.GV30496@pasky.or.cz>
	 <7v8xvpn8ne.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 18:26:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec4W7-0004Th-P7
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 18:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVKORWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 12:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVKORWp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 12:22:45 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:11160 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751448AbVKORWo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 12:22:44 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ec4W3-0002bQ-K3
	for git@vger.kernel.org; Tue, 15 Nov 2005 12:22:43 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Ec4Ux-00072z-QF; Tue, 15 Nov 2005 12:21:35 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xvpn8ne.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11922>

On Tue, 2005-11-15 at 09:05 -0800, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Yes, I would very much like to have this. I still want to go
> > symrefs-only for public repositories created for cg-admin-setuprepo, so
> > that fetching over HTTP works properly.
> 
> Sorry, I must have missed that part.  How does fetch-over-HTTP
> break with symlinked HEAD?

With symlinks, cogito doesn't know which branch it is fetching if the
branch is not explicitly specified.

The old behavior was to fetch the "master" branch by default.
Currently, cogito uses HEAD, but it cannot read the symlink, it can only
read the SHA1.  So, if somebody decides to use "cg-switch" on the public
repository (admittedly not a very good idea), all the clients that are
not using an explicit branch will unknowingly switch to another branch
upon update.

It also could be useful for users to know the branch name.  I, for one,
would like to know if HEAD links to "stable" or "sandbox4crazyhacks",
even if both have the same SHA1 at the moment.

-- 
Regards,
Pavel Roskin
