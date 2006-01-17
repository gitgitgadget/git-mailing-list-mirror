From: Mike McCormack <mike@codeweavers.com>
Subject: git rebase behaviour changed?
Date: Tue, 17 Jan 2006 12:49:50 +0900
Organization: CodeWeavers
Message-ID: <43CC695E.2020506@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 17 04:53:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyhul-0007Vh-RB
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 04:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWAQDxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 22:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWAQDxj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 22:53:39 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:33246 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751302AbWAQDxi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 22:53:38 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1Eyhua-0008IO-1A
	for git@vger.kernel.org; Mon, 16 Jan 2006 21:53:37 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14774>


Hi,

git-rebase was a very useful tool for me to help organize my patches.

Recently, it seems the behaviour of git-rebase changed.  It used to take 
the commits I'd made to my "master" branch and reapply them to a new 
"master" branch on top of "origin".  Where rebase from git-0.99.x used 
to work, git-1.1.3 now does nothing and gives me the following message:

git-rebase origin
-> Current branch refs/heads/master is up to date.

However, I can do the "rebase" manually with:

git branch master-20060117
git reset --hard origin
git-format-patch -k --stdout --full-index origin master-20060117 | \
	git am --binary -3 -k

Is this broken, or am I meant to be doing something different now?

thanks,

Mike
