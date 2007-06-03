From: Sergio <sergio.callegari@gmail.com>
Subject: Re: [RFC] =?utf-8?b?R0lUX1dPUktfVFJFRQ==?=
Date: Sun, 3 Jun 2007 16:02:29 +0000 (UTC)
Message-ID: <loom.20070603T175743-376@post.gmane.org>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 19:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hutfo-0006Vm-7s
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 19:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbXFCRPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 13:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbXFCRPR
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 13:15:17 -0400
Received: from main.gmane.org ([80.91.229.2]:36993 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbXFCRPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 13:15:16 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HutfR-0005V7-VK
	for git@vger.kernel.org; Sun, 03 Jun 2007 19:15:02 +0200
Received: from adsl-217-127.38-151.net24.it ([151.38.127.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 19:15:01 +0200
Received: from sergio.callegari by adsl-217-127.38-151.net24.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 19:15:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 151.38.127.217 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.4) Gecko/20061201 Firefox/2.0.0.4 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49013>

Matthias Lederhofer <matled <at> gmx.net> writes:
 
> This series introduces the GIT_WORK_TREE environment variable (and
> core.worktree config option) to specify the working tree that should
> be used with the repository (not for repositories found as .git
> directory).  This allows to separate the repository and working tree.

Hi,

a question regarding GIT_WORK_TREE and (possibly) a suggestion...

If I am not wrong, with this we detach the WT from the REPO by letting git know
our working tree if the working tree does not include a repo (.git) directory.
And this is done either:
- by setting the GIT_WORK_TREE environment variable whenever needed
- by passing the --work-tree parameter to git when needed
- by setting the core.worktree config option in the git repo, so that the
repository knows where its default work tree is...

Is this correct? or am I missing some other ways?

Would it make sense to make the _WT_ know where its repo is?

I.e. having something like a .git-repo file a the top dir of a WT, so that when
git is invoked within the WT it can scan up the WT until it finds the .git-repo
file and automatically decide that GIT_WORK_TREE is at the dir containing that
.git-repo file and that GIT_DIR is at the file pointed by that .git-repo?

Thanks,

Sergio
