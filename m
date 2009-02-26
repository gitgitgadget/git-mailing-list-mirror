From: "Lasse Kliemann" <lasse-gmane-git-2009@mail.plastictree.net>
Subject: git-push: creating branch on remote, refspec format
Date: Thu, 26 Feb 2009 12:00:55 +0000 (UTC)
Message-ID: <go609m$3dj$2@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 13:02:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcewt-000293-Aq
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 13:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbZBZMBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 07:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbZBZMBL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 07:01:11 -0500
Received: from main.gmane.org ([80.91.229.2]:57612 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649AbZBZMBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 07:01:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LcevK-0003pa-8G
	for git@vger.kernel.org; Thu, 26 Feb 2009 12:01:06 +0000
Received: from h1283867.stratoserver.net ([85.214.127.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 12:01:06 +0000
Received: from lasse-gmane-git-2009 by h1283867.stratoserver.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 12:01:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: h1283867.stratoserver.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111556>

http://www.kernel.org/pub/software/scm/git/docs/git-push.html reads:

| git push origin master:refs/heads/experimental
| 
|   Create the branch experimental in the origin repository by copying the 
|   current master branch. This form is only needed to create a new branch or 
|   tag in the remote repository when the local name and the remote name are 
|   different; otherwise, the ref name on its own will work.

It appears to me that the ref name on its own will also work to create a new 
branch, at least with local repositories:

$ (mkdir a && cd a && git init)
Initialized empty Git repository in /tmp/a/.git/
$ mkdir b && cd b && git init
Initialized empty Git repository in /tmp/b/.git/
$ pwd
/tmp/b
$ touch x && git add x && git commit 
[master (root-commit)]: created 87a90f5: "NA"
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 x

Now the push from '/tmp/b' to '/tmp/a':

$ git push /tmp/a master:foo
Counting objects: 3, done.
Writing objects: 100% (3/3), 209 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/a
 * [new branch]      master -> foo

Am I missing something?
