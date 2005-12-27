From: Jon Nelson <jnelson-git@jamponi.net>
Subject: Re: cannot handle more than 29 refs
Date: Tue, 27 Dec 2005 14:49:34 -0600 (CST)
Message-ID: <Pine.LNX.4.63.0512271448130.6812@gheavc.wnzcbav.cig>
References: <Pine.LNX.4.63.0512270840410.6812@gheavc.wnzcbav.cig>
 <Pine.LNX.4.64.0512271113290.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 21:49:40 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErLlL-0000hH-SQ
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 21:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVL0Uth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 15:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVL0Uth
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 15:49:37 -0500
Received: from mxsf35.cluster1.charter.net ([209.225.28.160]:42194 "EHLO
	mxsf35.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751142AbVL0Utg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 15:49:36 -0500
Received: from mxip27a.cluster1.charter.net (mxip27a.cluster1.charter.net [209.225.28.184])
	by mxsf35.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jBRKnZVr023368
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 15:49:35 -0500
Received: from 24-183-46-83.dhcp.mdsn.wi.charter.com (HELO turnip.jamponi.pvt) ([24.183.46.83])
  by mxip27a.cluster1.charter.net with ESMTP; 27 Dec 2005 15:49:35 -0500
X-IronPort-AV: i="3.99,297,1131339600"; 
   d="scan'208"; a="574665662:sNHT20265208"
Received: by turnip.jamponi.pvt (Postfix, from userid 1000)
	id 75FA5C09F; Tue, 27 Dec 2005 14:49:34 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by turnip.jamponi.pvt (Postfix) with ESMTP id 5E5B6C09E
	for <git@vger.kernel.org>; Tue, 27 Dec 2005 14:49:34 -0600 (CST)
In-Reply-To: <Pine.LNX.4.64.0512271113290.14098@g5.osdl.org>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14083>

On Tue, 27 Dec 2005, Linus Torvalds wrote:

> 
> 
> On Tue, 27 Dec 2005, Jon Nelson wrote:
> > 
> > I get this message whenever I use --tags with git-pull with certain 
> > repositories.
> 
> You shouldn't "pull" tags. You should just "fetch" them.
> 
> The error message comes from the fact that the pull is a "fetch + merge", 
> and the merge logic tries to figure out what the common parent is with 
> "git-show-branch". And the common parent finding is limited to 29 commits.
> 
> (Which is a very reasonable limit: the normal case is 2, and doing an 
> octopus-merge with more than four or five parents is already insane. Much 
> less 30 parents).

^^^ Aha! I think I understand what's going on here - and you are right, 
I *don't* want to merge from all of those tags, I just want the content, 
so fetch is what I should be doing.  Thanks!

--
Jon Nelson <jnelson-git@jamponi.net>
