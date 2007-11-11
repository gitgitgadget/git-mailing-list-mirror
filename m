From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Installing without rebuilding
Date: Sun, 11 Nov 2007 11:49:19 -0500
Message-ID: <8B92E213-17DB-4E83-B045-01CE0E7D26CB@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrG0B-0008Kt-1K
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 17:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbXKKQtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 11:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbXKKQtX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 11:49:23 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:57180 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbXKKQtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 11:49:22 -0500
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 761061FFC10F
	for <git@vger.kernel.org>; Sun, 11 Nov 2007 16:49:21 +0000 (UTC)
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64474>

Git has a very clever Makefile.  Sometimes its a little overly clever.

1) I use stow to manage my /usr/local directory.  With many other  
programs I am able to build with a prefix of /usr/local and install  
with a prefix of /usr/local/stow/$program.  Git detects a change in  
the build variables and recompiles pretty much everything.

2) If I remove the old copy of git before installing the new, git will  
notice this and again start a (smaller) recompile because the GIT- 
VERSION-FILE file changes from something detailed like  
"1.5.3.5.622.g6fd7a" to "1.5.3.GIT".

Is there a way to tell git to be a bit less clever and just install  
the already compiled program?  If not, would changing the Makefile to  
read something like the following be accepted?

----- 8< -----

install: all install-dumb

install-dumb: # No rebuild!
   # Current install process

----- 8< -----

~~ Brian
