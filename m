From: Mike Galbraith <efault@gmx.de>
Subject: pulling Already up-to-date linux-2.6 repo takes ~8 minutes?
Date: Thu, 18 Oct 2007 05:41:05 +0200
Message-ID: <1192678865.20353.14.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 05:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiMG9-00083p-QH
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 05:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbXJRDlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 23:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbXJRDlK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 23:41:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755274AbXJRDlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 23:41:09 -0400
Received: (qmail invoked by alias); 18 Oct 2007 03:41:06 -0000
Received: from p54B5BA2B.dip0.t-ipconnect.de (EHLO [192.168.178.23]) [84.181.186.43]
  by mail.gmx.net (mp021) with SMTP; 18 Oct 2007 05:41:06 +0200
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1+5+r5EWY25FoTfeYm4Npa5e10dh2lJk+hSuM+eJO
	r/xdWOJWbi0wKA
X-Mailer: Evolution 2.8.2 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61460>

Greetings git gods,

I'm wondering if I'm not doing something wrong, and thereby putting
unneeded stress on kernel.org when I pull latest kernel tree.

git_pull_linus scriptlet:

#!/bin/sh
(cd linux-2.6; git pull
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
(cd linux-2.6; git pull -t
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)

root@Homer: time ./git_pull_linus
remote: Generating pack...
remote: Counting objects: 17746
remote: Done counting 55975 objects.
remote: Result has 48507 objects.
remote: Deltifying 48507 objects...
remote:  100% (48507/48507) done
Indexing 48507 objects...
remote: Total 48507 (delta 38878), reused 44654 (delta 35166)
 100% (48507/48507) done
Resolving 38878 deltas...
 100% (38878/38878) done
3419 objects were added to complete this thin pack.
Already up-to-date.
You are not currently on a branch; you must explicitly
specify which branch you wish to merge:
  git pull <remote> <branch>

real    7m57.429s
user    0m13.517s
sys     0m0.859s

8 minutes, truckloads of network traffic, and lord knows what all going
on at the other end just doesn't seem right.  /me == dummy?

	-Mike
