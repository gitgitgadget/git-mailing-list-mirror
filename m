From: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
Subject: Help understanding "rebase"
Date: Tue, 10 Mar 2009 16:07:27 -0500
Message-ID: <gp6kqj$tkb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 22:21:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh9OT-0003Ut-CY
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 22:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbZCJVUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 17:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbZCJVUH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 17:20:07 -0400
Received: from main.gmane.org ([80.91.229.2]:54192 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbZCJVUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 17:20:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Lh9Mo-0007E0-J5
	for git@vger.kernel.org; Tue, 10 Mar 2009 21:20:02 +0000
Received: from 76-204-212-71.lightspeed.allntx.sbcglobal.net ([76.204.212.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 21:20:02 +0000
Received: from ngnr63q02 by 76-204-212-71.lightspeed.allntx.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 21:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 76-204-212-71.lightspeed.allntx.sbcglobal.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112849>

Here is the situation:  An old topic branch containing 3 commits.  A dev branch that has 
recently been merged.  To catch up the topic's work before adding it to dev, I expected 
that rebase would do what I ended up doing manually, detailed below.

Instead, it crunched away for a long time and gave errors applying patches.

So I did it manually by checking out dev, then cherry-picking each of the three commits. 
Actually, this left it on top of dev, but suppose I had created a new branch at dev, 
cherry-picked the stuff from the old topic branch, and then deleted the old topic branch. 
  Now I have a new topic branch with the rebased changes, albeit with a different branch 
name.  Point is, there were no conflicts and the changes were simple, so cherry-picking 
each node was clean.

So, what did the rebase command try to do?  I think it may have something to do with 
finding a common root between the topic and dev, which, due to the merge, was a long way 
back.  Something like this:

	  o--o--   ...  --o
	 /                 \
	A--...--B--   ... --C--D <== dev
	         \
                   q--r--s  <== topic


I was able to cherry-pick q,r,s on top of D without any issues.  So why did rebase get in 
such a tizzy?

--John
