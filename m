From: Jon Nelson <jnelson-git@jamponi.net>
Subject: Branches and all commits
Date: Mon, 19 Dec 2005 09:15:31 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0512190908140.6812@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Dec 19 16:18:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoMjk-0005Ll-V7
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 16:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbVLSPPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 10:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVLSPPi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 10:15:38 -0500
Received: from mxsf03.cluster1.charter.net ([209.225.28.203]:60639 "EHLO
	mxsf03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932199AbVLSPPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 10:15:38 -0500
Received: from mxip28a.cluster1.charter.net (mxip28a.cluster1.charter.net [209.225.28.187])
	by mxsf03.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jBJFFbt8004485
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 10:15:37 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip28a.cluster1.charter.net with ESMTP; 19 Dec 2005 10:15:37 -0500
X-IronPort-AV: i="3.99,268,1131339600"; 
   d="scan'208"; a="585813613:sNHT18871942"
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 7C6BDC092; Mon, 19 Dec 2005 09:15:31 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id 6D726C091
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 09:15:31 -0600 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13823>


Should *all* commits be reachable via at least one branch? I ran into a 
situation this weekend that has me a little confused. I had performed a 
number of commits and such and I noticed that the author and committer 
info had suboptimal values. A bit of searching led me to a comment made 
by Linus that basically said "go hack git-convert-objects", which I did. 
After performing git-convert-objects on every commit object in 
.git/refs/heads and the requisite pruning, etc... just about everything 
looked fine. However, I still had a long series of commits that 
contained the wrong information. Further inspection makes it appear as 
though these commits are not reachable via any branch, although they are 
/all/ reachable via a series of tags. I worked around the problem by 
further modifying git-convert-objects to also understand tags (at least 
the basic ones I've got) and that's all taken care of, but the question 
remains: should *all* commit objects be reachable by at least one 
branch?

--
Jon Nelson <jnelson-git@jamponi.net>
