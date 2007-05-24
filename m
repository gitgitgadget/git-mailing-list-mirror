From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: gitk: clicking a branch line doesn't stop patch generator
Date: Thu, 24 May 2007 11:39:43 +0200
Organization: eudaptics software gmbh
Message-ID: <46555D5F.87A3CE93@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu May 24 11:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr9ml-0003N5-8k
	for gcvg-git@gmane.org; Thu, 24 May 2007 11:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbXEXJjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 05:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755679AbXEXJjG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 05:39:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:5102 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbXEXJjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 05:39:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1Hr9mc-0004AY-GM; Thu, 24 May 2007 11:39:00 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 519D74E9; Thu, 24 May 2007 11:38:58 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.038
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48240>

Hi!

When a commit is highlighted, git-show or equivalent is spawned to fill
the patch window. When a different commit is highlighted, appearently if
git-show is still running, it is killed and a new one is started.

However, if a branch line is clicked, a running git-show is not killed,
hence its output is appended below the "Parent" and "Child" sections.

To reproduce, fire up gitk without arguments on git.git. Go all the way
down to the initial commit and select "Diff this->selected" from the
context menu, then quickly click on a line between two commits.

Unless your machine is blazingly fast, you will see that patch text is
appended below the "Child" section. Try with linux-2.6.git if git.git is
too small a project.

-- Hannes
