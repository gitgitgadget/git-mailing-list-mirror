From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [gitk] [PATCH] Fix selection of tags.
Date: Sat, 14 Nov 2009 13:21:09 +0000
Message-ID: <87r5s0vnas.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 14 21:58:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9PhS-0006xn-4R
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 21:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbZKNUzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 15:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbZKNUzj
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 15:55:39 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:50109 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751072AbZKNUzi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 15:55:38 -0500
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N9Pep-0005ZC-2u; Sat, 14 Nov 2009 20:55:43 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1N9Peo-0001o7-KM; Sat, 14 Nov 2009 20:55:42 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id A385613D84E; Sat, 14 Nov 2009 20:55:41 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132886>


When a tag is clicked an error is raised due to a missing parameter in
a function call.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 4e2be7f..364c7a8 100755
--- a/gitk
+++ b/gitk
@@ -10489,7 +10489,7 @@ proc showtag {tag isnew} {
 	set text "[mc "Tag"]: $tag\n[mc "Id"]:  $tagids($tag)"
     }
     appendwithlinks $text {}
-    maybe_scroll_ctext
+    maybe_scroll_ctext 1
     $ctext conf -state disabled
     init_flist {}
 }
-- 
1.6.5.1.1367.gcd48
