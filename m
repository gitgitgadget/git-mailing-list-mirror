From: Myxz Ptlk <Adrian.Klingel@illumaware.com>
Subject: Git rebase aggravation
Date: Sun, 22 Feb 2009 20:20:10 -0800 (PST)
Message-ID: <22155203.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 05:21:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbSK5-0001TO-W9
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 05:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbZBWEUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 23:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZBWEUM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 23:20:12 -0500
Received: from kuber.nabble.com ([216.139.236.158]:43890 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbZBWEUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 23:20:11 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LbSIc-0004J4-KS
	for git@vger.kernel.org; Sun, 22 Feb 2009 20:20:10 -0800
X-Nabble-From: Adrian.Klingel@illumaware.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111077>


I have two branches that diverged a long time ago, master and zoo.  I work
locally and check changes into a remote repository.  The remote repository
is also set up the same, and the local branches are set up to track the
remote branches.  Major development has gone on in both sides unfortunately. 
"master" is the production version.  My strategy to get the two together
was:

1)  Rebase master into zoo.

2) Merge zoo into master.

But here is what happens.  I spend 3 hours inside "zoo" doing "git rebase
master".  I go through all the hell of reconciling 6 months of development. 
Then at the end, it just says that the commits now differ between local
"zoo" and "origin/zoo".

So I figure, I will pull from "origin/zoo".  Naturally, that results in a
conflicted merge, which I then clear up.  I commit the merge, then push
everything back to the remote branch.

Now I would guess that my "zoo" branch has everything in it from "master",
and it is also in sync with the  "origin/zoo" branch.  I push and pull and
verify that this is so.

My thinking is that if I were to attempt a new rebase of master, the
beginning of what would be rebased would start from RIGHT NOW, instead of
all the commits over the past 6 months.  To check this, I type:

git rebase master

from "zoo".  Lo and behold, it starts the whole process over again.  I "git
rebase --abort", but I am very, very confused.

Why does the rebase not remember all the freaking work I just did?  Why
would I have to rebase the same commits all over again?  How do people keep
downstream branches up to date if this doesn't work?  What am I missing
here?  I will be extremely grateful for any help and understanding anybody
can offer.
-- 
View this message in context: http://www.nabble.com/Git-rebase-aggravation-tp22155203p22155203.html
Sent from the git mailing list archive at Nabble.com.
