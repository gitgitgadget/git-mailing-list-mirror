From: Michael Gorbach <michael@mgorbach.name>
Subject: git submodules and custom work tree / git dir
Date: Fri, 9 Dec 2011 16:48:22 +0000 (UTC)
Message-ID: <loom.20111209T173452-58@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 17:50:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ3eN-0005hJ-W8
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 17:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab1LIQuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 11:50:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:53090 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab1LIQuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 11:50:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZ3eE-0005cE-Ix
	for git@vger.kernel.org; Fri, 09 Dec 2011 17:50:10 +0100
Received: from pool-108-20-201-143.bstnma.fios.verizon.net ([108.20.201.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 17:50:10 +0100
Received: from michael by pool-108-20-201-143.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 17:50:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 108.20.201.143 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/534.51.22 (KHTML, like Gecko) Version/5.1.1 Safari/534.51.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186650>

I am working on a setup for managing my personal config files 
(shell settings and vim settings and such) using git. 

I have a git repository which ignores all files by default, so they don't 
cloud status. I have the following aliases:
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'
alias config-add='git --git-dir=$HOME/.config.git --work-tree=$HOME add -f'

This works pretty well. It means that the config repo is separate from other 
git repos, and I won't accidentally touch it by just typing "git."
What I'm trying to do now is to track vim (bundle) modules inside this git 
repo, which requires the use of git submodules.
It appears that submodules don't work with this weird configuration.

By calling git as in the "config" alias above, except removing the --work-tree 
argument, I was able to add submodules successfully with git submodule add. The
submodule info is written into .gitmodules and .config.git/config as expected. 
However,  the submodule doesn't seem to "stick." It displays when I type  
"config status" as "untracked content" no matter what I do, even though 
there is no untracked content and no change in the submodule.

Is there a way to make submodules work reasonably with git when using the 
--work-tree and --git-dir arguments?
