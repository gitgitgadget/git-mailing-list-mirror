From: Matt Kern <matt.kern@undue.org>
Subject: Git SVN Rebranching Issue
Date: Mon, 3 Nov 2008 14:07:47 +0000
Message-ID: <20081103140746.GA5969@mars.cyantechnology.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 15:43:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx0eP-00081N-IP
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 15:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbYKCOmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 09:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531AbYKCOmL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 09:42:11 -0500
Received: from ceres.undue.org ([93.93.129.86]:58856 "EHLO ceres.undue.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbYKCOmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 09:42:10 -0500
X-Greylist: delayed 2054 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Nov 2008 09:42:10 EST
Received: from cpc1-cmbg12-0-0-cust1.cmbg.cable.ntl.com ([86.9.116.2] helo=mars.cyantechnology.local)
	by ceres.undue.org with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <mwk@ceres.undue.org>)
	id 1Kx05t-0000Y3-UD
	for git@vger.kernel.org; Mon, 03 Nov 2008 14:07:53 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Score: -4.1
X-Spam-Score-Int: -40
X-Spam-Bar: ----
X-Spam-Report: Spam detection software, running on the system "ceres.undue.org", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  I have a git-svn issue which keeps biting me. My company uses
	svn as its primary version control system. We frequently create branches,
	e.g. /branches/somebranch, by forking the trunk to ensure stability over
	the "somebranch" code. The problem is that we also frequently blow away /branches/somebranch
	and refork it from the trunk. [...] 
	Content analysis details:   (-4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.3 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99947>

I have a git-svn issue which keeps biting me.

My company uses svn as its primary version control system.  We
frequently create branches, e.g. /branches/somebranch, by forking the
trunk to ensure stability over the "somebranch" code.  The problem is
that we also frequently blow away /branches/somebranch and refork it
from the trunk.

git-svn does a good job for most work, but I notice that if you delete
the "somebranch" branch in svn and then refork it, also in svn, then
when you git-svn fetch, the git commit at the head of remotes/somebranch
will have two parents: the first is the previous head of
remotes/somebranch, and the second is the head of remotes/trunk.  Surely
only the remotes/trunk parent should be listed?  Any connection with the
previous remotes/somebranch is an accident of naming.  The real problem
then comes when you come to look at the history in gitk.  If
"somebranch" is rebranched many times, the git history starts looking
pretty complicated, when in fact it should simply be the linear history
of remotes/trunk up to the branch point followed by a few,
branch-specific commits.  Is there any way to prevent (or modify) the
git history to remove the errant parent?

In the ideal world, we wouldn't reuse branch names in svn, but it is
convenient and doesn't cause problems for svn users.  I can't force the
rest of the company to change to accommodate my use of git...

I am using git (svn) version 1.5.6.5 (svn 1.4.6) from Debian/Lenny and
can provide a trivial repository demonstrating the problem if anyone is
interested.

Matt

-- 
Matt Kern
http://www.undue.org/
