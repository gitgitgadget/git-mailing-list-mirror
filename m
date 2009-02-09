From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Mon, 09 Feb 2009 20:52:30 +0100
Message-ID: <gmq1hu$ccn$1@ger.gmane.org>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 20:54:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWcCp-00044K-9e
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbZBITwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbZBITwm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:52:42 -0500
Received: from main.gmane.org ([80.91.229.2]:53248 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbZBITwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:52:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWcBL-0002Fk-9H
	for git@vger.kernel.org; Mon, 09 Feb 2009 19:52:39 +0000
Received: from host-78-15-9-200.cust-adsl.tiscali.it ([78.15.9.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 19:52:39 +0000
Received: from giuseppe.bilotta by host-78-15-9-200.cust-adsl.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 19:52:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host-78-15-9-200.cust-adsl.tiscali.it
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109115>

On Monday 09 February 2009 19:54, Fabio Augusto Dal Castel wrote:

> Q. What are the differences between 'git stash' and 'git snapshot'?
> 
> A.
> 
> git stash                         git snapshot
> 
> temporary/short-term              permanent/long-term
> reflog-based                      branch-based
> applies a "git reset --hard"      leaves working dir / index untouched
> does not stash untracked files    snapshots ALL files (except ignored)

I like this snapshot idea, and I clearly see the difference
between this and stash.

For example, I use stash when I want to move away from the current
hacking because a new, more urgent change must be done somewhere
else.

Instead, I see a usecase for git snapshot for progressive
temporary snapshot while working towards a more complex feature
while needing temporary intermediate checkpoints: an effect
similar to what I currently achieve using git commit (a first
time) and git commit --amend as my work progresses.

In this respect, I wouldn't agree with the first difference you
remarked, but that's just the usecase I have in mind.

> Q. How it works?
> 
> A.[What follows is a textual description of my current implementation.
> Of course, there is nothing carved in stone: suggestions and comments
> are MORE than welcome.]
> 
> All snapshots are stored in a special branch ("<branch>_snapshots").
> So, if you are on 'master' branch, a 'git snapshot' will create/use a
> 'master_snapshots' branch.

I'm not sure I like the idea of creating these branches with these
branchnames. What about using another refs/ subtree? So
refs/snapshots/somebranchname would contain the snapshot paired
with refs/heads/somebranchname.

-- 
Giuseppe "Oblomov" Bilotta
