From: Jingzhao Ou <jingzhao.ou@gmail.com>
Subject: Unable to delete remote branch with a strange name
Date: Tue, 28 Dec 2010 07:06:10 +0000 (UTC)
Message-ID: <loom.20101228T080344-503@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 08:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXThV-0000ax-La
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 08:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab0L1HKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 02:10:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:48608 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab0L1HKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 02:10:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PXTh8-0000SH-B8
	for git@vger.kernel.org; Tue, 28 Dec 2010 08:10:06 +0100
Received: from adsl-99-60-231-4.dsl.pltn13.sbcglobal.net ([99.60.231.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 08:10:06 +0100
Received: from jingzhao.ou by adsl-99-60-231-4.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 08:10:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.60.231.4 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.224 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164232>

Hi, all,

When I checked out a git repository, it has the following remote branches:

$ git br -r
 origin/HEAD -> origin/master
 origin/master
 origin/dev/main
 origin/remotes/origin/dev/main

I tried to delete the last branch with a strange long name. Using "git push" to 
delete it would fail.

$ git push origin :remotes/origin/dev/main
Pushing to jou@xx.xx.xx.xx:gsfw/omu_fw
error: dst refspec remotes/origin/dev/main matches more than one.
error: failed to push some refs to 'jou@xx.xx.xx.xx:gsfw/omu_fw'

However, I can create a new branch from it:

$ git co -b jou.temp origin/remotes/origin/dev/main
Branch jou.temp3 set up to track remote branch remotes/origin/dev/main
from origin.
Switched to a new branch 'jou.temp3'

But again, I cannot push any changes in "jou.temp3" branch to that weird branch:

$ git push origin HEAD:remotes/origin/dev/main
error: dst refspec remotes/origin/dev/main matches more than one.
error: failed to push some refs to 'jou@xx.xx.xx.xx:gsfw/omu_fw'

I guess somehow, git is confused by "origin/dev/main" and 
"origin/remotes/origin/dev/main". Especially, it cannot identify the latter
properly.

I wonder if any one can give me some suggestions on how to deal with this 
situation.

Thanks a lot!
Jingzhao
