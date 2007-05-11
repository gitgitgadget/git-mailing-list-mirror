From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Build Failure: GIT-GUI-VARS
Date: Thu, 10 May 2007 21:51:14 -0400
Message-ID: <FF405582-7769-4A08-87A0-680F8CD165DC@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 11 03:51:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmKI2-0005sP-KC
	for gcvg-git@gmane.org; Fri, 11 May 2007 03:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbXEKBvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 21:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756972AbXEKBvV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 21:51:21 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60275 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbXEKBvV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 21:51:21 -0400
Received: from [192.168.2.5] (cpe-66-67-139-52.rochester.res.rr.com [66.67.139.52])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 00C7E1FFC01F
	for <git@vger.kernel.org>; Fri, 11 May 2007 01:51:20 +0000 (UTC)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46929>

"make all" fails with "NO_TCLTK=y" because gitk-wish depends on GIT- 
GUI-VARS which is defined inside the ifndef block.

AFAICT, either gitk-wish should be moved inside a ifndef block or an  
else should be added with a phony GIT-GUI-VARS.  I don't know which  
is preferred.

Actually, I can't tell why make is trying to build it in the first  
place.  :-/  gitk-wish is added to OTHER_PROGRAMS inside a NO_TCLTK  
block. (Debian oldstable, GNU Make 3.80, git repo v1.5.2-rc3)

And, while I'm poking through here, there's a line labeled "Backward  
compatibility -- to be removed after 1.0".  Git IDs itself as  
1.5.2.rc3.  Isn't that after 1.0?  :-)

~~ Brian
