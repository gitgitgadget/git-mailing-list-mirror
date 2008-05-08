From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: gitk and git-gui with --git-dir and GIT_DIR
Date: Thu, 08 May 2008 16:41:06 +0200
Message-ID: <fvv3e4$i00$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 16:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju7K4-0001md-4e
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 16:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbYEHOl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 10:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755606AbYEHOl0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 10:41:26 -0400
Received: from main.gmane.org ([80.91.229.2]:38737 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbYEHOlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 10:41:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ju7J9-00074k-UL
	for git@vger.kernel.org; Thu, 08 May 2008 14:41:19 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 May 2008 14:41:19 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 May 2008 14:41:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81532>

I want to track a tree where I should not store a ".git" dir. (You may 
as well assume I don't have direct write access.) So, the ".git" dir is 
somewhere else in the filesystem, actually named something like "repo.git".

I know how to make most of git happy with that structure (even diff). 
Notable exceptions are gitk and git-gui:

gitk::
It requires GIT_DIR to be set and is happy. Only downside is that gitk 
does not fit inside the git-command scheme. Therefore, any aliasing I do 
for git commands does not apply to gitk. Having gitk as git-view or such 
would help.

git-gui::
For non-bare repos it expects git-dirs of the form "path/.git" and bails 
out otherwise. Even when I rename my git dir to such a path things do 
not work: all tracked files are reported missing. This happens even when 
I call git-gui from the actual work tree, i.e. when git diff would work!
It seems as if git-gui is CDing to "path" when git-dir is "path/.git", 
no matter what $PWD, core.worktree or GIT_WORK_TREE say. I don't see why 
this should be desired behaviour.

Michael
