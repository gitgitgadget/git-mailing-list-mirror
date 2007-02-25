From: Mark Levedahl <mlevedahl@verizon.net>
Subject: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 14:33:16 -0500
Message-ID: <45E1E47C.5090908@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 25 20:33:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLP7j-0006Se-Gj
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 20:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbXBYTd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 14:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbXBYTd2
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 14:33:28 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:55581 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbXBYTd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 14:33:27 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JE1005RTABAQUN0@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 25 Feb 2007 13:33:15 -0600 (CST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40570>

I am trying autoCRLF in git compiled from next (75415c455dd307), find 
some behavior that is probably different than desired dealing with a 
file where the only changes are to line endings:

create a text file (foo) with \n endings, check it in.
$ u2d foo
$ git diff foo
diff --git a/foo b/foo
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   foo
#
$ git ci -m 'x' foo
# On branch master
nothing to commit (working directory clean)

So, git commit will not check in the file, but git status shows an 
unclean file and git diff shows no actual differences.

Also, git-gui shows the file as modified, but clicking on that file 
gives a warning box saying "No differences detected...", does a rescan, 
and then shows the file as modified again.

I'm not sure of the correct fix:
1) Place the file in a separate category, perhaps "broken line-endings", 
and indicate that git will not check this in?
2) Overwrite the file with a fresh checkout (erasing the crlf differences)?
3) ?

Mark Levedahl
