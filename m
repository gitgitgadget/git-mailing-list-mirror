From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: Handle msysGit version during version comparisons
Date: 18 May 2009 22:46:01 +0100
Message-ID: <87hbzirso6.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 18 23:46:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Af0-0004tG-JU
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 23:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbZERVqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbZERVqG
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 17:46:06 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:50733 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753717AbZERVqF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 17:46:05 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1M6Aeq-00068s-85; Mon, 18 May 2009 22:46:04 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1M6Aep-0001Ga-O9; Mon, 18 May 2009 22:46:03 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 107CC5183F; Mon, 18 May 2009 22:46:02 +0100 (BST)
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119466>


  msysGit generates version strings with text appended which cannot
  be used with vcompare. Limit git_version to the first three digits
  which are the real git version.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 0804e6e..1855390 100755
--- a/gitk
+++ b/gitk
@@ -11152,7 +11152,7 @@ set nullid2 "0000000000000000000000000000000000000001"
 set nullfile "/dev/null"
 
 set have_tk85 [expr {[package vcompare $tk_version "8.5"] >= 0}]
-set git_version [lindex [exec git version] end]
+set git_version [join [lrange [split [lindex [exec git version] end] .] 0 2] .]
 
 set runq {}
 set history {}
-- 
1.6.3.msysgit.0
