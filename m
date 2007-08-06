From: Brian Gernhardt <benji@silverinsanity.com>
Subject: core.pager handling broken
Date: Mon, 6 Aug 2007 11:56:43 -0400
Message-ID: <2BA49414-54E0-4353-B237-7799B675FAE8@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 17:56:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II4wt-0003Sd-FL
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 17:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbXHFP4r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 11:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbXHFP4r
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 11:56:47 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37667 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbXHFP4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 11:56:46 -0400
Received: from [192.168.0.3] (cpe-69-204-218-82.stny.res.rr.com [69.204.218.82])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 0FADE1FFC22C
	for <git@vger.kernel.org>; Mon,  6 Aug 2007 15:56:44 +0000 (UTC)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55156>

I don't have time to look into it, but something broke the core.pager  
variable.  I've bisected it down to  
"e90fdc39b6903502192b2dd11e5503cea721a1ad: Clean up work-tree  
handling".  With this commit:

$ git config core.pager
tig
$ git log
# Uses less
$ GIT_PAGER=tig git log
# Uses tig

I don't have time to track it down right now (I'm off visiting  
family), but will look into it tomorrow unless someone thinks it's  
obvious and points it out before then.

~~ Brian
