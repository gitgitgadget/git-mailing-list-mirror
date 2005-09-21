From: Paul Mackerras <paulus@samba.org>
Subject: Re: Joining cg-*-id
Date: Thu, 22 Sep 2005 07:19:42 +1000
Message-ID: <17201.52846.627734.327798@cargo.ozlabs.ibm.com>
References: <1127166049.26772.26.camel@dv>
	<20050919215608.GA13845@pasky.or.cz>
	<Pine.LNX.4.58.0509191505470.2553@g5.osdl.org>
	<20050919225422.GG18320@pasky.or.cz>
	<Pine.LNX.4.58.0509191746130.2553@g5.osdl.org>
	<20050920135735.GC1884@pasky.or.cz>
	<Pine.LNX.4.58.0509200734440.2553@g5.osdl.org>
	<20050920150719.GB1836@pasky.or.cz>
	<Pine.LNX.4.58.0509200906120.2553@g5.osdl.org>
	<Pine.LNX.4.58.0509201224360.2553@g5.osdl.org>
	<17201.14169.150101.991868@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0509210750060.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Pavel Roskin <proski@gnu.org>, fonseca@diku.dk,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 23:21:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIC0N-00022Q-J4
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 23:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVIUVTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 17:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVIUVTs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 17:19:48 -0400
Received: from ozlabs.org ([203.10.76.45]:27091 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964912AbVIUVTr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 17:19:47 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B02EC682FA; Thu, 22 Sep 2005 07:19:46 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509210750060.2553@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9079>

Linus Torvalds writes:

> Oooh. I can't. Very strange. I definitely could yesterday:  
> "--since=yesterday" worked, but "--since='1 week ago'" didn't.

Ahhh... "--since='1 week ago'" doesn't work because of the extra set
of single quotes: we end up doing:

	git-rev-parse --default HEAD "--since='1 week ago'"

which gives this error:

	date: invalid date `'1 week ago''
	fatal: git-rev-list: bad date string

Gitk's error message is admittedly less than informative, but that's
the worst it's guilty of (this time :).

Paul.
