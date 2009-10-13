From: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH v2] git-gui: Fixed diff pane height for shorter screen height
Date: Tue, 13 Oct 2009 10:28:41 +0800
Message-ID: <1255400921-4177-1-git-send-email-vietor@vxwo.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDD-0004cs-Bi
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbZJMC0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbZJMC0p
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:45 -0400
Received: from mail-pz0-f105.google.com ([209.85.222.105]:54535 "EHLO
	mail-pz0-f105.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758833AbZJMC0k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:40 -0400
Received: by pzk3 with SMTP id 3so354398pzk.21
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 19:26:04 -0700 (PDT)
Received: by 10.114.253.14 with SMTP id a14mr11291087wai.160.1255400764332;
        Mon, 12 Oct 2009 19:26:04 -0700 (PDT)
Received: from localhost.localdomain ([123.113.93.118])
        by mx.google.com with ESMTPS id 20sm995577pxi.12.2009.10.12.19.26.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 19:26:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130113>

When the screen height is short(e.g. Asus EeePC 1024x600), the partial commit
pane will hide. This patch adjust the minimum height of the diff pane, allowing
the overall window to be shorter and still display the entire commit pane.

Signed-off-by: Vietor Liu <vietor@vxwo.org>
---
 git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 09b2720..037a1f2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3083,7 +3083,7 @@ frame .vpane.lower.diff.body
 set ui_diff .vpane.lower.diff.body.t
 text $ui_diff -background white -foreground black \
 	-borderwidth 0 \
-	-width 80 -height 15 -wrap none \
+	-width 80 -height 5 -wrap none \
 	-font font_diff \
 	-xscrollcommand {.vpane.lower.diff.body.sbx set} \
 	-yscrollcommand {.vpane.lower.diff.body.sby set} \
-- 
1.6.5
