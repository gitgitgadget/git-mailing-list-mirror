From: Mike Galbraith <efault@gmx.de>
Subject: failure doing massive revert
Date: Thu, 18 Sep 2008 11:09:06 +0200
Message-ID: <1221728946.8516.14.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 11:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgFWj-00075h-O3
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 11:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbYIRJJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 05:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbYIRJJL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 05:09:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:48788 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752989AbYIRJJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 05:09:10 -0400
Received: (qmail invoked by alias); 18 Sep 2008 09:09:07 -0000
Received: from p54B5ABC3.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [84.181.171.195]
  by mail.gmx.net (mp064) with SMTP; 18 Sep 2008 11:09:07 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1+TeKVwbnyT+NLD/5tQY4plpogRseeA3+I44gvKy3
	ebAurzJwqukR/0
X-Mailer: Evolution 2.22.1.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96185>

Greetings,

For reasons I'd rather not go into, I decided to create a merge free
tree to try to bisect.  I did this yesterday for a smaller range, and it
worked fine, and I was able to revert the reverts to re-apply.  Trying
to revert everything from v2.6.26..today croaked.

for i in `git rev-list --no-merges v2.6.26..HEAD`; do git revert $i < /dev/null; done

Got this far...

Author: Mike Galbraith <efault@gmx.de>  2008-09-18 10:50:58
Committer: Mike Galbraith <efault@gmx.de>  2008-09-18 10:50:58
Parent: 6753354a5984745b0121f7853e4e7a392e25adc7 (Revert "[ARM] 5185/1: Fix spi num_chipselect for lubbock")
Child:  0000000000000000000000000000000000000000 (Local uncommitted changes, not checked in to index)
Branch: master
Follows: v2.6.27-rc6
Precedes: 

    Revert "pktgen: multiqueue etc."
    
    This reverts commit e6fce5b916cd7f7f79b2b3e53ba74bbfc1d7cf8b.

...then began spewing fatal: Dirty index: cannot revert.  Probably me
being git-ignorant, but figured I'd mention it just in case.  I started
by whacking all source, followed by checkout -f master, so have no idea
what git means by local changes.

	-Mike
