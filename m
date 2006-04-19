From: Zack Brown <zbrown@tumblerings.org>
Subject: cg-clone produces "___" file and no working tree
Date: Tue, 18 Apr 2006 22:36:40 -0700
Message-ID: <20060419053640.GA16334@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 19 07:36:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW5N0-0000qv-ME
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 07:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWDSFgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 01:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWDSFgv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 01:36:51 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:3536 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1750828AbWDSFgv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 01:36:51 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.60)
	(envelope-from <zbrown@tumblerings.org>)
	id 1FW5Mm-0004ZR-SJ
	for git@vger.kernel.org; Tue, 18 Apr 2006 22:36:40 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18910>

Hi folks,

I'm experiencing a problem that seems like it must be my fault, but I
can't figure it out. I'm using cogito-0.17.2-ga543f4f and git version
1.3.0.g2473-dirty.

When I do something like
cg-clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git

The first few lines of output are:

defaulting to local storage area
warning: templates not found /home/zbrown/share/git-core/templates/
/home/zbrown/git/cogito/cg-clone: line 137: .git/info/cg-fetch-earlydie: No such file or directory
/home/zbrown/git/cogito/cg-clone: line 148: .git/info/cg-fetch-initial: No such file or directory

The rest of the process seems to go without incident. However, when I look
at the repository I see:

$ ls -A
.git  ___
$

Then when I cat the "___" file, I see:

$ cat ___
This is a clone-in-progress GIT working tree containing a GIT repository
in the .git subdirectory. If you see this file and noone is fetching or
cloning in this repository, the clone has been interrupted; you can restart
it by issuing this command (it's enough as-is):

        cg-fetch
$


I give the "cg-fetch" command as instructed, but it seems to have no effect,
and the "___" file remains unchanged.

What is going on? I'm completely unable to clone a repository. If I try
"git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git",
I get this error: "git: 'clone' is not a git-command", and it prints a usage
page, but "clone" is listed on that usage page.

I don't know what to make of this, and I don't see any other discussion of this
problem, so I assume it's my own fault, but I don't see what I might have done
wrong.

Be well,
Zack


-- 
Zack Brown
