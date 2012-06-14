From: lancelyons <llyons2@cox.net>
Subject: Re: Git rebase basics
Date: Wed, 13 Jun 2012 19:59:54 -0700 (PDT)
Message-ID: <1339642794317-7561489.post@n2.nabble.com>
References: <1339621152946-7561468.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 05:00:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf0Hx-00045N-0k
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 05:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab2FNC7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 22:59:55 -0400
Received: from sam.nabble.com ([216.139.236.26]:56792 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab2FNC7z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 22:59:55 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <llyons2@cox.net>)
	id 1Sf0Hq-0000wV-AY
	for git@vger.kernel.org; Wed, 13 Jun 2012 19:59:54 -0700
In-Reply-To: <1339621152946-7561468.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199965>

Sorry about that.. I thought I was being pretty descriptive but maybe I
missed something.

After we setup Git (msysgit) and set it up using Apache with active
directory authentication, I added a repository using git init --bare then I
copied my files I wanted to add to the repository and did a git add . and
git commit -a

So that all worked.   We have done several clones using git clone with this
remote repo.  We have also done  git push and git pull to verify everything
is working ok.   Everything was working fine.

So back to my original train of though.

I am trying to learn more about rebase so i have cloned the central repo two
times  (I call the central repo the origin) doing the following (to help you
understand)

git clone https://servername:port/repopath c:\clonedrepo1

git clone https://servername:port/repopath c:\clonedrepo2

and then made changes to this cloned copy (clonedrepo1) and pushed two
commits back to origin.
(git commit -a  two times)

so now I have the following in the remote repo (origin)   

origin -->  C1 --> C2

(Note to help you understand  C1 = commit 1 and c2 = commit 2, etc)

In the other cloned copy (clonedrepo2), which I consider a branch, I have
made two more commits  C3 and C4

clonedrepo2 --> C3 -->  C4

I am able to easily pull from origin to get my clonedrepo2 to look like 
clonerepo2 --> C3 --> C4 --> C1 --> C2 using git pull origin  or git pull
https://servername:port/repopath

however I was wanting to rebase the clonedrepo2 branch so that it shows   
clonerepo2 -> C1 --> C2 --> C3 --> C4

In other words I am wanting to rebase clonedrepo2 to the master of the
origin.


I thought the command to do this was   git rebase origin master but that
doesnt work and I get

C:\clonedrepo2>git rebase origin master
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 2 commits.
Current branch master is up to date.

I know my my branch is ahead by c3 and c4 but it does not have C1 and C2

Thoughts.

--
View this message in context: http://git.661346.n2.nabble.com/Git-rebase-basics-tp7561468p7561489.html
Sent from the git mailing list archive at Nabble.com.
