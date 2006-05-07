From: Pavel Roskin <proski@gnu.org>
Subject: Locking a branch
Date: Sat, 06 May 2006 22:50:43 -0400
Message-ID: <1146970243.24434.77.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 07 04:51:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcZMK-0001B7-BR
	for gcvg-git@gmane.org; Sun, 07 May 2006 04:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWEGCuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 22:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWEGCuq
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 22:50:46 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:34227 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750907AbWEGCup
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 6 May 2006 22:50:45 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FcZM4-0007PC-L8
	for git@vger.kernel.org; Sat, 06 May 2006 22:50:44 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FcZM3-0006dh-K6
	for git@vger.kernel.org; Sat, 06 May 2006 22:50:43 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19689>

Hello!

I see there is an active discussion about branch attributes.  It would
be nice to have an attribute to prevent git from changing the branch
head in any way.  The reason is that it interferes with StGIT on StGIT
managed branches.  If StGIT is fine with the change, it would remove or
override the lock temporarily.  StGIT could also unlock the branch
permanently if there are no applied patches.

Another use of the branch lock would be to prevent damage to remote
branches, such as "origin".  Committing anything to "origin" would break
fetching.  In this case, git-fetch should be allowed to override the
lock after checking .git/remotes, but other git commands should respect
the lock.

It should be possible to break locks, but the users would at least think
before doing so.

-- 
Regards,
Pavel Roskin
