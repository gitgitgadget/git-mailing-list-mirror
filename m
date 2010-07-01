From: Eric Raible <raible@gmail.com>
Subject: Poor status output during conflicted merge
Date: Thu, 1 Jul 2010 18:16:29 +0000 (UTC)
Message-ID: <loom.20100701T195742-266@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 20:16:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUOJg-0002Ql-4R
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 20:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab0GASQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 14:16:44 -0400
Received: from lo.gmane.org ([80.91.229.12]:50915 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab0GASQn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 14:16:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OUOJT-0002IG-Bn
	for git@vger.kernel.org; Thu, 01 Jul 2010 20:16:39 +0200
Received: from mobile-166-187-086-018.mycingular.net ([mobile-166-187-086-018.mycingular.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 20:16:39 +0200
Received: from raible by mobile-166-187-086-018.mycingular.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 20:16:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 166.187.86.18 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.70 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150061>

Let's create a merge conflict and then partially resolve it:

git init bad-status
cd bad-status/
echo 1 > file
git add file
git commit -a -m1
echo 2 > file
git commit -a -m2
git checkout -b topic HEAD^
echo 3 > file
git commit -a -m3
git merge master
git checkout --ours file
git add file

A 'git status' at this point gives the following output:

# On branch topic
nothing to commit (working directory clean)

Which is wrong, since the merge still needs to be committed.

- Eric
