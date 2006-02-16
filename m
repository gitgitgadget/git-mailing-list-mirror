From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 15 Feb 2006 22:57:21 -0800
Message-ID: <7vk6bvhju6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 16 07:57:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9d4w-0004rd-L4
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 07:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWBPG5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 01:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWBPG5Y
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 01:57:24 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44257 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932485AbWBPG5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 01:57:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216065728.OMET25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 01:57:28 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16274>

* Master branch has these since 1.2.1 maintenance release.

  - documentation fixes:
    git-commit: Now --only semantics is the default.

  - usability:
    - rebase aquired a hook to refuse rebasing.
    - commit and add detects misspelled pathspec while making a partial commit.
    - git-svnimport: -r adds svn revision number to commit messages
    - properly git-bisect reset after bisecting from non-master head
    - send-email: Add some options for controlling how addresses
      are automatically added to the cc: list.
    - send-email: Add --cc

* Next branch has these, that are not in master.  If you feel
  you would benefit from these, testing and feedback is greatly
  appreciated.

 - "Assume unchanged git" series (7 commits):

   This was done in response to people on filesystems with slow
   lstat(2).  I do not have such an environment, so I cannot say
   I tested it that much.

 - "Rebase to different branch" (1 commit):

   This was previously discussed on the list.  With this command
   line:

    	$ git rebase --onto master~1 master topic
    
   would rebase this ancestry graph to:
    
              A---B---C topic
             /
        D---E---F---G master
    
    
   another graph that looks like this:
    
                  A'--B'--C' topic
                 /
        D---E---F---G master

   Earlier, you couldn't rebase to anywhere other than on top of
   "the other branch".


* Proposed updates "pu" branch has these, not in "next".  Some
  of them are of iffy nature, and without further work will not
  go anywhere.

 - "merge-tree" series by Linus (2 commits).

   I haven't spent enough time looking at and thinking about
   this yet.

 - "reuse pack data" (1 commit).

   I still haven't seen data corruption with this one, which is
   a good sign, but would like to keep beating it privately for
   a while.  Perhaps will graduate to "next" by next week.

 - "bind commit" series (6 commits).

   I think the core-side is more or less done with this one.
   Anybody interested in doing Porcelain side?

 - "shallow clone" series (1 commit).

   I should drop this one for now and perhaps when enough people
   are interested reopen the issue.
