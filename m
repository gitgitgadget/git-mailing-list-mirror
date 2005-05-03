From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: cogito "origin" vs. HEAD
Date: Tue, 3 May 2005 13:06:51 +0400
Message-ID: <200505031306.51520.snake@penza-gsm.ru>
References: <1115090660.6156.56.camel@gaston> <20050503064943.GB10244@pasky.ji.cz> <1115104408.6156.100.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-From: git-owner@vger.kernel.org Tue May 03 11:01:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DStGt-0008Av-U4
	for gcvg-git@gmane.org; Tue, 03 May 2005 11:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVECJG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 05:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVECJG6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 05:06:58 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:49861
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261434AbVECJG4
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 05:06:56 -0400
Received: (qmail 25011 invoked from network); 3 May 2005 09:06:52 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 3 May 2005 09:06:51 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <1115104408.6156.100.camel@gaston>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

At Tuesday, 03 May 2005 11:13 Benjamin Herrenschmidt wrote:
> > when accessing the remote repository, Cogito always looks for remote
> > refs/heads/master first - if that one isn't there, it takes HEAD, but
> > there is no correlation between the local and remote branch name. If you
> > want to fetch a different branch from the remote repository, use the
> > fragment identifier (see cg-help cg-branch-add).
>
> Ok, that I'm getting. So then, what happen of my local
> refs/heads/<branchname> and refs/heads/master/ ? I'm still a bit
> confused by the whole branch mecanism... It's my understanding than when
> I cg-init, it creates both "master" (a head without matching branch)
> and "origin" (a branch  + a head) both having the same sha1. It also
> checks out the tree.
>
> Now, when I cg-update origin, what happens exactly ? I mean, I know it's
> pulls all objects, then get the master from the remote pointed by the
> origin branch, but then, I suppose it updates both my local "origin" and
> my local "master" pointer, right ? I mean, they are always in sync ? Or
> is this related to what branch my current checkout is tracking ?
If I understand this mechanics correctly then "master head" always track your 
local tree (i.e. with all remote and local patches applied) and "origin head" 
always tracking head of the remote branch from where you are getting objects.

I.e. it is really a tree, not source of objects. The tree can be strored on 
many different hosts but it is the same across them. But the master tree have 
no source to sync from - you are creating it yourself locally so there is no 
"master branch" - only head.

So if you are just tracking some other tree and do not do any merges/patches 
yourself then your master head will always match your remote source head 
("origin" in most cases).

-- 
Respectfully
Alexey Nezhdanov

