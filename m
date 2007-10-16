From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] gitk: disable colours when calling git log
Date: Wed, 17 Oct 2007 11:33:04 +1300
Message-ID: <1192573984-26725-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 00:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihuyl-00048H-19
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965366AbXJPWdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbXJPWdK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:33:10 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:58773 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964959AbXJPWdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 18:33:09 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IhuyH-0001ZB-SG; Wed, 17 Oct 2007 11:33:05 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 7AB2F2C747; Wed, 17 Oct 2007 11:33:04 +1300 (NZDT)
X-Mailer: git-send-email 1.5.3.2.3.g2f2dcc-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61269>

If the user specifies 'diff.color = 1' in their configuration file,
then gitk will not start.  Disable colours when calling git log.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..999e3c2 100755
--- a/gitk
+++ b/gitk
@@ -92,7 +92,7 @@ proc start_rev_list {view} {
 	set order "--date-order"
     }
     if {[catch {
-	set fd [open [concat | git log -z --pretty=raw $order --parents \
+	set fd [open [concat | git log --no-color -z --pretty=raw $order --parents \
 			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
     } err]} {
 	error_popup "Error executing git rev-list: $err"
-- 
1.5.3.2.3.g2f2dcc-dirty
