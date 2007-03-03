From: Larry Streepy <larry@lightspeed.com>
Subject: git pull fails to exit with non-zero status after fatal error
Date: Sat, 03 Mar 2007 10:45:53 -0600
Message-ID: <45E9A641.8020002@lightspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 17:43:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNXKP-0002nJ-GI
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 17:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030679AbXCCQnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 11:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbXCCQnW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 11:43:22 -0500
Received: from mailhost.lightspeed.com ([12.44.179.187]:34026 "EHLO
	lightspeed.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030679AbXCCQnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 11:43:22 -0500
Received: from [72.177.124.81] (account larry HELO [127.0.0.1])
  by lightspeed.com (CommuniGate Pro SMTP 5.0.9)
  with ESMTPA id 3618117 for git@vger.kernel.org; Sat, 03 Mar 2007 08:41:32 -0800
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41304>

We have just upgraded to 1.5 (don't know if this is specific to 1.5, but 
just in case).  When I perform a git-pull on a working repo that has a 
modified file, git pull refuses to do the pull, as shown below:

$ git pull
Updating b5d9263..506b347
tools/Pvt/Pvt.py: needs update
fatal: Entry 'tools/Pvt/Pvt.py' not uptodate. Cannot merge.
$ echo $?
0

Notice the exit status of 0.  The driver scripts I use rely on a 
non-zero status to send me email when the git-pull fails, but this case 
eludes detection.

I'm assuming this is a bug, but if it's intended behavior I'd like to 
understand why it would use a 0 exit status after a issuing a fatal error.

Thanks,
Larry.
