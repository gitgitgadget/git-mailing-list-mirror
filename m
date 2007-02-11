From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Clean up geometry save code in gitk.
Date: Sun, 11 Feb 2007 09:27:20 -0500
Message-ID: <1171204040779-git-send-email-mdl123@verizon.net>
References: <11712040401127-git-send-email-mdl123@verizon.net>
 <11712040403973-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 11 15:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGFg1-0000It-Aq
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 15:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXBKO11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 09:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbXBKO11
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 09:27:27 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:57671 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXBKO10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 09:27:26 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms040.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDA003YTYTH4EKF@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Feb 2007 08:27:18 -0600 (CST)
In-reply-to: <11712040403973-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc3.24.g0c5e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39283>

Leftover code was subtracting zero from several items before storing, an
obvious noop now deleted.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 23bf567..df1ce8c 100755
--- a/gitk
+++ b/gitk
@@ -832,9 +832,9 @@ proc savestuff {w} {
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
-	puts $f "set geometry(canv) [expr {[winfo width $canv]-0}]"
-	puts $f "set geometry(canv2) [expr {[winfo width $canv2]-0}]"
-	puts $f "set geometry(canv3) [expr {[winfo width $canv3]-0}]"
+	puts $f "set geometry(canv) [winfo width $canv]"
+	puts $f "set geometry(canv2) [winfo width $canv2]"
+	puts $f "set geometry(canv3) [winfo width $canv3]"
 	puts $f "set geometry(botwidth) [winfo width .bleft]"
 	puts $f "set geometry(botheight) [winfo height .bleft]"
 
-- 
1.5.0.rc3.24.g0c5e
