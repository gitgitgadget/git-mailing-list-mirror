From: "Neal Kreitzinger" <neal@rsss.com>
Subject: rebase -i reword converts to pick on pre-commit non-zero exit
Date: Wed, 1 Feb 2012 15:27:44 -0600
Message-ID: <jgcaoh$d9q$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 22:28:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rshiv-0000CI-OB
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 22:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757480Ab2BAV2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 16:28:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:44930 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755301Ab2BAV2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 16:28:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rshig-00005h-Nf
	for git@vger.kernel.org; Wed, 01 Feb 2012 22:27:58 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 22:27:58 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 22:27:58 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189539>

When interactive rebase does the reword command it runs the pre-commit hook 
for that commit (a).  If the pre-commit hook gives a non-zero exit then 
interactive rebase picks commit (a) and continues to the next commit (b) in 
the rebase-to-do-list.  Instead of picking commit (a) when the pre-commit 
hook exits non-zero on the reword command, shouldn't interactive rebase 
learn to edit commit (a) and tell the user that because the pre-commit hook 
exited non-zero they need to either remedy the pre-commit hook violations 
and run git commit --amend or run git commit --amend --no-verify to bypass 
the pre-commit hook?  Otherwise, you have to run another rebase after the 
rejected rewords and edit those commits to accomplish the rewords.

v/r,
neal 
