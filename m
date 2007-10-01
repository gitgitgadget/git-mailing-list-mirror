From: Barry Fishman <barry_fishman@acm.org>
Subject: Problems setting up bare repository (git 1.5.3.3)
Date: Mon, 01 Oct 2007 17:46:36 -0400
Message-ID: <m3fy0u7bk3.fsf@barry_fishman.acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 23:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcTEp-00059Y-0M
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 23:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbXJAVza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 17:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbXJAVza
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 17:55:30 -0400
Received: from main.gmane.org ([80.91.229.2]:38841 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbXJAVz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 17:55:29 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IcTEF-0000iK-Vt
	for git@vger.kernel.org; Mon, 01 Oct 2007 21:55:04 +0000
Received: from fl-69-69-5-167.dhcp.embarqhsd.net ([69.69.5.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 21:55:03 +0000
Received: from barry_fishman by fl-69-69-5-167.dhcp.embarqhsd.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 21:55:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: fl-69-69-5-167.dhcp.embarqhsd.net
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:ueaG/v31obEEz6U3WOi093anZvA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59636>

Using the 1.5.3.3 release:

$ cd /pub/git
$ mkdir foo.git
$ cd foo.git
$ git --bare init
Initialized empty Git repository in /pub/git/foo.git/
$ git --bare branch

Note that there is no master branch.

$ cd /some/git/workdir
$ git push /pub/git/foo.git master:master
error: dst refspec master does not match any existing ref on the remote and does not start with refs/.
fatal: The remote end hung up unexpectedly
error: failed to push to '/pub/git/foo.git'

$ git push --force /pub/git/foo.git master:master
error: dst refspec master does not match any existing ref on the remote and does not start with refs/.
fatal: The remote end hung up unexpectedly
error: failed to push to '/pub/git/foo.git'

$ git push --all /pub/git/foo.git
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   e623fb5ba6fac345eb6af552b40412acdc447b31
Generating pack...
Done counting 61 objects.
Deltifying 61 objects...
 100% (61/61) done
Writing 61 objects...
Unpacking 61 objects...
 100% (61/61) done
Total 61 (delta 31), reused 50 (delta 25)
 100% (61/61) done
refs/heads/master: 0000000000000000000000000000000000000000 -> e623fb5ba6fac345eb6af552b40412acdc447b31

But what if I have more branches and want to just push the master
branch?  This worked when I tried it last (probably 1.5.2.2).  This time
I had to "git push --all" and then delete all the unwanted branches.

-- 
Barry Fishman
