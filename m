From: "David S. Miller" <davem@davemloft.net>
Subject: non-trivial merge failures
Date: Sun, 20 Nov 2005 13:49:45 -0800 (PST)
Message-ID: <20051120.134945.104623647.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Nov 20 22:50:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edx4F-00057r-Bu
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 22:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVKTVt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 16:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVKTVt3
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 16:49:29 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31662
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932090AbVKTVt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 16:49:28 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.54)
	id 1Edx4D-0005QO-FD
	for git@vger.kernel.org; Sun, 20 Nov 2005 13:49:45 -0800
To: git@vger.kernel.org
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12404>


Every time I try to do a non-trivial merge, I always
get this:

davem@sunset:~/src/GIT/net-2.6$ git pull git://git.skbuff.net/gitroot/yoshfuji/linux-2.6.14+advapi-fix/
Unpacking 21 objects
 100% (21/21) done
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Traceback (most recent call last):
  File "/home/davem/bin/git-merge-recursive", line 13, in ?
    from gitMergeCommon import *
  File "/home/davem/share/git-core/python/gitMergeCommon.py", line 18, in ?
    import subprocess
ImportError: No module named subprocess
Automatic merge failed/prevented; fix up by hand
davem@sunset:~/src/GIT/net-2.6$ 

(one can reproduce this exact tree state by cloning:
	master.kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6.git
 then executing the above pull command)

Maybe something is wrong with my python installation or
something like that?

It looks like it's failing to import some python module called
"subprocess", and I aparently don't have that installed.
/usr/bin/python on this Debian box is aparently python-2.3, do
I need to be using python-2.4 for this merge stuff to work?
