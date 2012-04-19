From: phantomjinx <p.g.richardson@phantomjinx.co.uk>
Subject: git svn dcommit --commit-url
Date: Thu, 19 Apr 2012 11:09:00 +0100
Message-ID: <4F8FE43C.2010004@phantomjinx.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 13:17:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKpMy-0007Em-MU
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 13:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab2DSLRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 07:17:44 -0400
Received: from vilya.visn.co.uk ([193.254.210.161]:55899 "EHLO
	vilya.visn.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab2DSLRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 07:17:43 -0400
X-Greylist: delayed 4116 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Apr 2012 07:17:43 EDT
Received: from [109.176.232.35] (port=50292 helo=falcon.BIRDS-OF-PREY)
	by vilya.visn.co.uk with esmtpa (Exim 4.69)
	(envelope-from <p.g.richardson@phantomjinx.co.uk>)
	id 1SKoIQ-0008Mu-KM
	for git@vger.kernel.org; Thu, 19 Apr 2012 11:09:02 +0100
Received: from [192.168.88.4] (goshawk.BIRDS-OF-PREY [192.168.88.4])
	by falcon.BIRDS-OF-PREY (Postfix) with ESMTP id E938F1AF
	for <git@vger.kernel.org>; Thu, 19 Apr 2012 11:09:00 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
X-Enigmail-Version: 1.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vilya.visn.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - phantomjinx.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195935>

Greetings,

I have git-svn cloned a repo from its anonymous http url using git2svn.

This worked fine but in order to commit back, I would need to use the
committer-only https url.

I googled and found the 'commiturl' config option, as well as the
--commit-url switch on dcommit. Thank goodness for these!!

I edit my git config to look like this

[svn-remote "svn"]
        url = http://anonymous.blah.com/myproject
        fetch = trunk:refs/remotes/svn/trunk
        branches = branches/*:refs/remotes/svn/*
        tags = tags/*:refs/remotes/svn/tags/*
        commiturl = https://svn.blah.com/myproject

and prepare to dcommit my commits from SomeBranch

git co SomeBranch
git svn dcommit

or

git svn dcommit --commit-url https://svn.blah.com/myproject

which results in the following:

Committing to https://svn.blah.com/myproject ...
        M       plugins/somefile.txt
Incomplete data: Delta source ended unexpectedly at
/usr/libexec/git-core/git-svn line 848

However, the following syntax works correctly:

git svn dcommit --commit-url
https://svn.blah.com/myproject/branches/SomeBranch

I cannot add the 'branches/SomeBranch' to my config and I thought
git-svn would have deduced them from the branch I am currently on? Is
this expected behaviour, a bug in my repo or a bug in git-svn's code?

I can commit so it is not a problem but I would appreciate any
information that anyone has on this.

Not subscribed.

Many Thanks

Paul

-- 
Paul Richardson
