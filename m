From: Jon Loeliger <jdl@freescale.com>
Subject: unexpected EOF?
Date: Thu, 01 Dec 2005 07:42:02 -0600
Message-ID: <E1EhohG-0001iZ-IB@jdl.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 14:45:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehohk-0007uG-QK
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 14:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVLANmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 08:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVLANmN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 08:42:13 -0500
Received: from mail.jdl.com ([66.118.10.122]:25034 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932213AbVLANmM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 08:42:12 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EhohG-0001iZ-IB
	for git@vger.kernel.org; Thu, 01 Dec 2005 07:42:03 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13056>


I thought I had imagined this last time, but now 
that it has happened twice, I'm not so sure what
is going on.  First pull attempt garners an
unexpected EOF message; immediately pull again
seems to work.

Some state:

jdl@ubuntu:/usr/src/git-core$ git --version
git version 0.99.9j

jdl@ubuntu:/usr/src/git-core$ cat .git/remotes/origin
URL: git://git.kernel.org/pub/scm/git/git.git/
Pull: master:origin
Pull: todo:todo
Pull: maint:maint
Pull: pu:pu

And the error capture:

jdl@ubuntu:/usr/src/git-core$ git pull origin
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/git/git.git/
jdl@ubuntu:/usr/src/git-core$ git pull origin
Unpacking 17 objects
 100% (17/17) done
* committish: d175455acaaba6bd39dd2d5ec71961bf238f06d4
  branch 'todo' of git://git.kernel.org/pub/scm/git/git
* refs/heads/todo: same as branch 'todo' of git://git.kernel.org/pub/scm/git/git* committish: 93dcab2937624ebb97f91807576cddb242a55a46
  branch 'maint' of git://git.kernel.org/pub/scm/git/git
* refs/heads/maint: same as branch 'maint' of git://git.kernel.org/pub/scm/git/git
* committish: b34403aa97047f90c0cdd5177e63a8e7530e3388
  branch 'master' of git://git.kernel.org/pub/scm/git/git
* refs/heads/origin: same as branch 'master' of git://git.kernel.org/pub/scm/git/git
* committish: 6e35634a4d595d554423b04438bfa8b523414c54
  branch 'pu' of git://git.kernel.org/pub/scm/git/git
* refs/heads/pu: does not fast forward to branch 'pu' of git://git.kernel.org/pub/scm/git/git;
  not updating.
Already up-to-date.
