From: Wincent Colaiuta <win@wincent.com>
Subject: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 10:02:38 +0100
Message-ID: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 10:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZrp-0002h4-Ux
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 10:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbXKZJCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 04:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXKZJCm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 04:02:42 -0500
Received: from wincent.com ([72.3.236.74]:38041 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbXKZJCm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 04:02:42 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAQ92dLm000696
	for <git@vger.kernel.org>; Mon, 26 Nov 2007 03:02:41 -0600
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66058>

In using "git-rebase --interactive" to re-order commits you  
occasionally get conflicts and will see a message like this:

	When commiting, use the option '-c %s' to retain authorship and message

I was thinking that it might be nice to stash away this commit id  
somewhere in GIT_DIR so that the user didn't have to explicitly  
remember it, and add a new switch to git-commit that could be used to  
automatically use that stashed commit id, something like:

	git commit --retain

Although I most often see this kind of message in interactive  
rebasing, the message is generated in builtin-revert.c when cherry- 
picking, so you can also see it in any other situation where you're  
cherry picking and there's a conflict.

What do people think? Would this be a nice usability improvement? Or  
is it adding clutter?

Cheers,
Wincent
