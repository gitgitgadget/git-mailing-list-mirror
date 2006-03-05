From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] gitk: Fix size saving for diff and file list panes
Date: Sun, 5 Mar 2006 20:09:14 +0300
Message-ID: <20060305170914.GB9871@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 18:09:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFwjw-0000Vn-Rt
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 18:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWCERJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 12:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWCERJo
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 12:09:44 -0500
Received: from master.altlinux.org ([62.118.250.235]:7436 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932206AbWCERJo
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 12:09:44 -0500
Received: from procyon.home (localhost.localdomain [127.0.0.1])
	by master.altlinux.org (Postfix) with ESMTP
	id 486ACE39A3; Sun,  5 Mar 2006 20:09:37 +0300 (MSK)
Received: by procyon.home (Postfix, from userid 500)
	id 6E9E3E3668C; Sun,  5 Mar 2006 20:09:14 +0300 (MSK)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17233>

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

The splitter between diff and file list panes was moving to the left
after every restart of gitk.

---

This patch applies both to the stable and new gitk versions.

 gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

1e43530dc79f176507e5ad2fd57f4c9ba6cea46a
diff --git a/gitk b/gitk
index f4c6624..a5331f1 100755
--- a/gitk
+++ b/gitk
@@ -676,10 +676,10 @@ proc savestuff {w} {
 	puts $f "set geometry(canv2) [expr {[winfo width $canv2]-2}]"
 	puts $f "set geometry(canv3) [expr {[winfo width $canv3]-2}]"
 	puts $f "set geometry(canvh) [expr {[winfo height $canv]-2}]"
-	set wid [expr {([winfo width $ctext] - 8) \
+	set wid [expr {([winfo width $ctext]) \
 			   / [font measure $textfont "0"]}]
 	puts $f "set geometry(ctextw) $wid"
-	set wid [expr {([winfo width $cflist] - 11) \
+	set wid [expr {([winfo width $cflist]) \
 			   / [font measure [$cflist cget -font] "0"]}]
 	puts $f "set geometry(cflistw) $wid"
 	close $f
-- 
1.2.GIT
