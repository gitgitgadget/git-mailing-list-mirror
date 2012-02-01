From: "Neal Kreitzinger" <neal@rsss.com>
Subject: rebase -i reword runs pre-commit hook with curious results
Date: Wed, 1 Feb 2012 15:50:49 -0600
Message-ID: <jgcc3q$mvl$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 22:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsi5D-0003Jr-QH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 22:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102Ab2BAVvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 16:51:05 -0500
Received: from plane.gmane.org ([80.91.229.3]:38910 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755332Ab2BAVvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 16:51:02 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rsi4y-0003Br-L0
	for git@vger.kernel.org; Wed, 01 Feb 2012 22:51:00 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 22:51:00 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 22:51:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189541>

I'm confused on why and/or how interactive rebase runs the pre-commit hook 
when doing the reword command for commit (a).  My pre-commit hook does 
keyword expansion on the worktree copy of the modified index files and then 
re-adds them to effect a user-date-stamp when committed.  However, the 
user-date-stamps don't get updated when reword runs the pre-commit hook. 
IOW, the pre-commit hook does not get the same results as if I were doing a 
commandline git-commit of a modified index.  I suppose reword is protecting 
the preservation of all the contents of commit (a) except the commit message 
which makes sense, but I don't understand how it goes about doing this while 
still attempting to somehow honor the pre-commit hook.  (git 1.7.1)

v/r,
neal 
