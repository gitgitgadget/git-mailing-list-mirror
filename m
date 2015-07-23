From: Adam Moss <admoss1980@btinternet.com>
Subject: Bash =?utf-8?b?X19naXRfcHMx?= line wrapping issue on OSX
Date: Thu, 23 Jul 2015 07:54:25 +0000 (UTC)
Message-ID: <loom.20150723T095031-240@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 10:00:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIBQK-0002bT-PX
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 10:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbbGWIAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 04:00:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:40844 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbbGWIAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 04:00:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZIBQB-0002WH-NX
	for git@vger.kernel.org; Thu, 23 Jul 2015 10:00:04 +0200
Received: from 80.229.98.147.plusnet.pte-ag2.dyn.plus.net ([80.229.98.147.plusnet.pte-ag2.dyn.plus.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:00:03 +0200
Received: from admoss1980 by 80.229.98.147.plusnet.pte-ag2.dyn.plus.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.229.98.147 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0) Gecko/20100101 Firefox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274488>

I have sourced git-prompt.sh (copied from
https://github.com/git/git/tree/master/contrib/completion) and included it
in my .bashrc as follows:

GIT_PS1_SHOWDIRTYSTATE=true;
GIT_PS1_SHOWUPSTREAM="verbose";
GIT_PS1_SHOWCOLORHINTS=true;

PROMPT_COMMAND='__git_ps1 "# \u@\h:\w" " \$ "';

Under CentOS etc. this works fine. On OSX however, when dealing with a
nested folder structure that causes line wrapping, the formatting of the bit
where you type goes do-lally-tap.  Character spacing is wrong (like each
character is tab separated) and once it hits the end of the line it starts
to overwrite itself (but only the last character).  There is a screen shot
of the issue on the StackOverflow question I've asked about this at
http://stackoverflow.com/questions/31561969/bash-git-ps1-line-wrapping-issue-on-osx.

The code that __git_ps1 has generated for PS1 is:

# \u@\h:\w (\[\e[32m\]${__git_ps1_branch_name}\[\e[0m\] \[\e[31m\]*\[\e[0m\]
u=) $

Has anyone experienced this and / or could suggest a solution?

If I comment out the GIT_PS1_SHOWCOLORHINTS directive it works, albeit
without the colour highlighting, so I'm guessing there is something amiss in
the control sequences somewhere.

Thanks,


Adam M.
