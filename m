From: greened@obbligato.org
Subject: New git-subtree almost ready
Date: Tue, 20 Mar 2012 22:36:25 -0500
Message-ID: <87limu7hhi.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 04:39:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SACOy-0004Bh-E1
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 04:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab2CUDju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 23:39:50 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:34537 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754289Ab2CUDjt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 23:39:49 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SA8fG-0002h8-QH
	for git@vger.kernel.org; Tue, 20 Mar 2012 18:40:31 -0500
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  I've got the git-subtree merge in pretty good shape now. After
    being taught about TEST_DIRECTORY, I've been able to get rid of all of the
    test system changes and can run the git-subtree tests using the stock test
    infrastructure. [...] 
 Content analysis details:   (1.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  2.4 DATE_IN_FUTURE_03_06   Date: is 3 to 6 hours  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193558>

I've got the git-subtree merge in pretty good shape now.  After being
taught about TEST_DIRECTORY, I've been able to get rid of all of the
test system changes and can run the git-subtree tests using the stock
test infrastructure.

Before I can put the new tree up I need a little help.  Since it's been
a while since I posted the last version of the tree, I tried to update
from upstream master.  git-subtree is in a separate branch (it wqas
applied as a subtree merge) so I did the usual switch-to-master-and-pull
thing.

However, now I don't know how to rebase from master to the subtree
branch.  If I do a "git rebase master" then the subtree merge gets
re-applied as if the files were placed in the root directory rather than
in the target directory of the original subtree merge.

The problem is described pretty well here and the issue has been covered
on the mailing list before:

http://groups.google.com/group/git-users/browse_thread/thread/d54bacd234d95639
http://comments.gmane.org/gmane.comp.version-control.git/191934

I can think of a few strategies to move forward.

1. Keep the git-subtree branch where it is.  Don't rebase and just push
   the branch to a public repository.  Make Junio do the hard work.  :)

2. Split the subtree merge, remove it from the git repository, rebase
   from master and then re-subtree-merge it.

3. Don't do a rebase, just do a regular merge from master.

Which of these would be best to integrate git-subtree into
Junio's repository?

git-web guys, how did you handle this situation?

Thanks!

                           -David
