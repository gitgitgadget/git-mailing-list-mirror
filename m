From: Tim Olsen <tim@brooklynpenguin.com>
Subject: git-submodule add -b
Date: Fri, 01 Aug 2008 16:27:05 -0400
Message-ID: <g6vrip$2pu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 22:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1HH-00038Z-U1
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbYHAUaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755884AbYHAUaG
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:30:06 -0400
Received: from main.gmane.org ([80.91.229.2]:35401 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755AbYHAUaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 16:30:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KP1GE-0001D2-PQ
	for git@vger.kernel.org; Fri, 01 Aug 2008 20:30:02 +0000
Received: from cyrus.limewire.com ([76.8.67.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 20:30:02 +0000
Received: from tim by cyrus.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 20:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cyrus.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91092>

The git-submodule man page says that the -b option to "git-submodule
add" is the "Branch of repository to add as submodule."

I get the error "fatal: A branch named '1.x' already exists." when I try
to use "git submodule add -b".  A sample session is below.  What am I
doing wrong?

tolsen@neurofunk:~/git$ mkdir submodule-branch
tolsen@neurofunk:~/git$ cd submodule-branch
tolsen@neurofunk:~/git/submodule-branch$ mkdir sub
tolsen@neurofunk:~/git/submodule-branch$ cd sub
tolsen@neurofunk:~/git/submodule-branch/sub$ git init
Initialized empty Git repository in
/home/tolsen/git/submodule-branch/sub/.git/
tolsen@neurofunk:~/git/submodule-branch/sub$ echo 1 > file
tolsen@neurofunk:~/git/submodule-branch/sub$ git add file
tolsen@neurofunk:~/git/submodule-branch/sub$ git commit -m v1
Created initial commit d5c185a: v1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
tolsen@neurofunk:~/git/submodule-branch/sub$ echo 2 > file
tolsen@neurofunk:~/git/submodule-branch/sub$ git add file
tolsen@neurofunk:~/git/submodule-branch/sub$ git commit -m v2
Created commit fb864b2: v2
 1 files changed, 1 insertions(+), 1 deletions(-)
tolsen@neurofunk:~/git/submodule-branch/sub$ git log
commit fb864b2d4d9dacd87e55d0be970baa5fc6a0972c
Author: Tim Olsen <tolsen@limespot.com>
Date:   Fri Aug 1 16:21:09 2008 -0400

    v2

commit d5c185a7ea91b66b5df524b21bbe0daf40a456f4
Author: Tim Olsen <tolsen@limespot.com>
Date:   Fri Aug 1 16:21:03 2008 -0400

    v1
tolsen@neurofunk:~/git/submodule-branch/sub$ git checkout -b 1.x d5c185a7
Switched to a new branch "1.x"
tolsen@neurofunk:~/git/submodule-branch/sub$ echo 1.1 > file
tolsen@neurofunk:~/git/submodule-branch/sub$ git add file
tolsen@neurofunk:~/git/submodule-branch/sub$ git commit -m v1.1
Created commit d9868c5: v1.1
 1 files changed, 1 insertions(+), 1 deletions(-)
tolsen@neurofunk:~/git/submodule-branch/sub$ git log
commit d9868c5dc837404834b44eca6d21930c4f352127
Author: Tim Olsen <tolsen@limespot.com>
Date:   Fri Aug 1 16:21:58 2008 -0400

    v1.1

commit d5c185a7ea91b66b5df524b21bbe0daf40a456f4
Author: Tim Olsen <tolsen@limespot.com>
Date:   Fri Aug 1 16:21:03 2008 -0400

    v1
tolsen@neurofunk:~/git/submodule-branch/sub$ cd ..
tolsen@neurofunk:~/git/submodule-branch$ mkdir super
tolsen@neurofunk:~/git/submodule-branch$ cd super
tolsen@neurofunk:~/git/submodule-branch/super$ git init
Initialized empty Git repository in
/home/tolsen/git/submodule-branch/super/.git/
tolsen@neurofunk:~/git/submodule-branch/super$ echo dummy > dummy
tolsen@neurofunk:~/git/submodule-branch/super$ git add dummy
tolsen@neurofunk:~/git/submodule-branch/super$ git commit -m dummy
Created initial commit f1c41b6: dummy
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 dummy
tolsen@neurofunk:~/git/submodule-branch/super$ cd ..
tolsen@neurofunk:~/git/submodule-branch$ git clone super super2
Initialized empty Git repository in
/home/tolsen/git/submodule-branch/super2/.git/
tolsen@neurofunk:~/git/submodule-branch$ cd super2
tolsen@neurofunk:~/git/submodule-branch/super2$ git submodule add -b 1.x
~/git/submodule-branch/sub
Initialized empty Git repository in
/home/tolsen/git/submodule-branch/super2/sub/.git/
fatal: A branch named '1.x' already exists.
Unable to checkout submodule 'sub'
tolsen@neurofunk:~/git/submodule-branch/super2$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       sub/
nothing added to commit but untracked files present (use "git add" to track)
tolsen@neurofunk:~/git/submodule-branch/super2$

Thanks,
Tim
