From: Tom Lambda <tom.lambda@gmail.com>
Subject: Question regarding git fetch
Date: Thu, 27 Aug 2009 10:30:45 -0500 (CDT)
Message-ID: <1251387045053-3527289.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 17:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MggwB-0006jF-Mw
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 17:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbZH0Pao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZH0Pao
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 11:30:44 -0400
Received: from 216-139-236-80.aus.us.siteprotect.com ([216.139.236.80]:2910
	"EHLO jim.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbZH0Pan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 11:30:43 -0400
Received: from jim ([127.0.0.1]) by jim.nabble.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 27 Aug 2009 10:30:45 -0500
X-Nabble-From: tom.lambda@gmail.com
X-OriginalArrivalTime: 27 Aug 2009 15:30:45.0053 (UTC) FILETIME=[583696D0:01CA272B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127163>


I noticed that git-fetch seems smarter when it is run without a <refspec>
argument than when one specifies a branch name. I use a simple setup where a
remote central repository is defined when it is cloned the first time (clone
-o central ...). This leads to these default parameters:

remote.central.fetch=+refs/heads/*:refs/remotes/central/*
branch.master.remote=central
branch.master.merge=refs/heads/master

When I use "git fetch central" each branch in central's refs/heads/ is
automatically fetched to my refs/remotes/central/ as expected.

What was a little bit surprising to me is that running "git fetch central
master" does not update refs/remotes/central/master but simply updates
FETCH_HEAD.

I read the manual and I know that updating FETCH_HEAD is the expected
default behavior for git-fetch. However, I really like the fact that git
fetch (without <refspec>) knows that ANY branch in refs/heads/ corresponds
to refs/remotes/central/. Is there a way to change the configuration to have
"git fetch central branch" always updating refs/remotes/central/branch
whatever the specified branch.

I would prefer not to have to specify the <dst> each time:
git fetch central branch:remotes/central/branch

Thank you,
Tom

-- 
View this message in context: http://n2.nabble.com/Question-regarding-git-fetch-tp3527289p3527289.html
Sent from the git mailing list archive at Nabble.com.
