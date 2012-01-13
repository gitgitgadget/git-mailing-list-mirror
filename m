From: Yves Goergen <nospam.list@unclassified.de>
Subject: Bug! Git merge also fails with a wrong error message
Date: Fri, 13 Jan 2012 17:37:38 +0000 (UTC)
Message-ID: <loom.20120113T181805-423@post.gmane.org>
References: <loom.20120112T193624-86@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 18:37:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rll4e-0006E3-Ht
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 18:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758577Ab2AMRhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 12:37:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:34854 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758527Ab2AMRhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 12:37:51 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rll4Y-0006Bg-7F
	for git@vger.kernel.org; Fri, 13 Jan 2012 18:37:50 +0100
Received: from DSL01.83.171.159.183.ip-pool.NEFkom.net ([83.171.159.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 18:37:50 +0100
Received: from nospam.list by DSL01.83.171.159.183.ip-pool.NEFkom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 18:37:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.171.159.183 (Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188520>

I have updates to this issue.

After asking several people who didn't believe me,
after all I could pass all checks to ensure that
the file in question really is tracked, despite the error
message telling it is not. (The file has a history, it is
part of the branch,
git status behaves as expected when I rename it, and so on.)

I had found a workaround hack to access my
data again: I have cloned the repo
into another directory, then switched to
the branch in there (it actually
worked) and used BeyondCompare to manually(!)
switch my original repo and
working directory by copying some (not all) files
in .git and all differences in
the working directory.

That worked fine at first, I could commit to that branch.

Today I wanted to merge that branch into master again.
Switching to master was
fine, but merging from the form-refactoring branch
now fails for the very same
"reason":

-----
git.exe merge    --no-commit form-refactoring

error: The following untracked working tree files
would be overwritten by merge:
Form1.Designer.cs
Please move or remove them before you can merge.
Aborting
-----

Again, that file is NOT untracked. Git just fails
processing its own data. I
cannot move that file because it is part of the
other branch and must be merged now.

Am I now supposed to checkout both branches and
do the merge somehow on my own?

Maybe it's not a good idea to use branching and
then rename, create and delete
files on that branch, as switching and merging
fail completely afterwards. And
in the end, maybe Git isn't all that good and
some of the alternatives with real
file tracking should be preferred.

I, for one, have lost a great amount of trust
in Git in the last two days.

(Sorry for the formatting mess, but the stupid Gmane
post editor forced me to do that or it wouldn't
accept my message... Don't you have a real mailing
list, if there's no web forum??)
