From: Richard Lee <richard@webdezign.co.uk>
Subject: Preserving branches after merging on ancestor
Date: Thu, 5 Nov 2009 10:30:24 -0800 (PST)
Message-ID: <26217077.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 19:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N676N-0001an-9S
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 19:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214AbZKESaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 13:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758009AbZKESaU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 13:30:20 -0500
Received: from kuber.nabble.com ([216.139.236.158]:38579 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675AbZKESaT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 13:30:19 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N676G-0007wu-EQ
	for git@vger.kernel.org; Thu, 05 Nov 2009 10:30:24 -0800
X-Nabble-From: richard@webdezign.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132231>


Hello gits,

I've been using various version control systems for several years now before
coming to git two months ago. So far I've been just doing linear commits
without any branches on my source code so that I end up with a linear
history. This makes it very hard to see where you started and stopped
working on something on the git graph.

So I tried using branches for features today. Most of the time I'm the only
person working on a project. So when I've finished working on a feature
branch and ready to merge it back into the master branch, the master head IS
the common ancestor of the two branches. As shown below

* b6d75f1 [feature] stuff on feature branch
* 43dba08 stuff on feature branch
* ab7efdd [master] init

When I merge the graph looks likes this:

* b6d75f1 [master] [feature] stuff on feature branch
* 43dba08 stuff on feature branch
* ab7efdd init

Now I lose the start point of where I satrted on the feature branch. And if
I decided to reuse the name of the branch 'feature' to work on it again by
resetting it to somewhere else, I loose to finish point. (Should I be using
git-reset like this?)

One way of getting round this problem is to use empty commits on the master
branch, as shown below.

*   6fc04b5 Merge branch 'feature2'
|\
| * 07a117b stuff on feature2
* | 52f5ba1 Empty commit
|/
*   5deaa93 Merge branch 'feature1'
|\
| * b163b17 stuff on feature1
| * 53bb820 stuff on feature1
| * c9ef14c stuff on feature1
* | 34227a3 Empty commit
|/
* e88d332 Init

But is this correct? It seems rather hackish to create empty commits on the
master branch just to historically preserve commits on a seperate branch.
Should I be using feature branches in git like this or another way? For
example more informative commit messages. 

I cannot imagine using this empty commits fix in other VCS if they don't
allow empty commits like svn or hg.


Cheers,

Richard
-- 
View this message in context: http://old.nabble.com/Preserving-branches-after-merging-on-ancestor-tp26217077p26217077.html
Sent from the git mailing list archive at Nabble.com.
