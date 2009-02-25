From: "Lasse Kliemann" <lasse-gmane-git-2009@mail.plastictree.net>
Subject: gitosis: how to create absolutely empty repos
Date: Wed, 25 Feb 2009 19:54:50 +0000 (UTC)
Message-ID: <go47ma$5n8$1@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 21:03:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcPyG-00075O-Fw
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292AbZBYUAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 15:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756733AbZBYUAI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:00:08 -0500
Received: from main.gmane.org ([80.91.229.2]:49025 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756673AbZBYUAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:00:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LcPvG-0006El-No
	for git@vger.kernel.org; Wed, 25 Feb 2009 20:00:02 +0000
Received: from h1283867.stratoserver.net ([85.214.127.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 20:00:02 +0000
Received: from lasse-gmane-git-2009 by h1283867.stratoserver.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 20:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: h1283867.stratoserver.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111485>

$ mkdir test
$ cd test
$ git init
Initialized empty Git repository in /home/foo/new-repos/test/.git/
$ git remote add origin ext:test.git

('ext' is configured in ~/.ssh/config to be my git user and host.)

Here the docs say to add some files and to do a commit. However, 
I want an absolutely empty repos created, so I skip this step.

$ git push origin master:refs/heads/master
Initialized empty Git repository in /home/git/repositories/test.git/
error: src refspec master does not match any.
fatal: The remote end hung up unexpectedly
error: failed to push some refs to 'ext:test.git'

So, this did not work. It will work, however, if I do at least 
one commit. A way to do this without adding files is the 
following:

$ git commit --allow-empty

Then the push will work:

$ git push origin master:refs/heads/master
Counting objects: 2, done.
Writing objects: 100% (2/2), 168 bytes, done.
Total 2 (delta 0), reused 0 (delta 0)
To ext:test.git
 * [new branch]      master -> master

Is there a better way to do it?
