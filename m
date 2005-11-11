From: Paul Mackerras <paulus@samba.org>
Subject: tracking a tree that doesn't progress linearly
Date: Fri, 11 Nov 2005 14:18:31 +1100
Message-ID: <17268.3463.252020.591687@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 04:18:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaPR5-0007Gl-Al
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 04:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVKKDSk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 22:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVKKDSk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 22:18:40 -0500
Received: from ozlabs.org ([203.10.76.45]:28872 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932294AbVKKDSk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 22:18:40 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 201466871D; Fri, 11 Nov 2005 14:18:39 +1100 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11553>

I want to be able to publish a git tree for others to follow but I
also want to be retain the freedom to remove commits and/or rebase
commits in the tree.  For example, if someone sends me a patch and I
put it in the tree, then they send me a revised version, I want to be
able to roll back to just before I applied the older patch and start
again from there.

What this means, AFAICS, is that the head of the published tree won't
always be a descendent of all previous values of the head.  If
somebody is following the state of the tree by doing a git pull every
so often, and I have rolled back the tree and applied some new
patches, then the git pull will try to merge the old and new state,
which is not what we want.  What we want is something that just gets
the local tree to the same state as the remote tree.

Is there a git command which does the equivalent of a git fetch,
followed by setting the head and checking it out?

Or is this an incredibly stupid idea for some reason that hasn't
occurred to me yet? :)

Thanks,
Paul.
