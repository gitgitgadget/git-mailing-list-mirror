From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 4/4] git gui: allow for a long recentrepo list
Date: Wed, 16 Dec 2015 23:58:07 +0000
Message-ID: <1450310287-4936-5-git-send-email-philipoakley@iee.org>
References: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:58:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Lxr-0003VL-41
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 00:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934584AbbLPX6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 18:58:22 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:37301 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751906AbbLPX6V (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 18:58:21 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BDCADm+XFWPMm3YwJeGQEBAQEPAQEBAYI5UYE/hmC0cIQJhgcEAgKBKE0BAQEBAQEHAQEBAUE/hDUBAQRWIxBROQoUBhOIM7IejBABAQgjhlaJJQ2FCwWWfKpjhGg+NIMjAR+BKwEBAQ
X-IPAS-Result: A2BDCADm+XFWPMm3YwJeGQEBAQEPAQEBAYI5UYE/hmC0cIQJhgcEAgKBKE0BAQEBAQEHAQEBAUE/hDUBAQRWIxBROQoUBhOIM7IejBABAQgjhlaJJQ2FCwWWfKpjhGg+NIMjAR+BKwEBAQ
X-IronPort-AV: E=Sophos;i="5.20,438,1444690800"; 
   d="scan'208";a="571788360"
Received: from host-2-99-183-201.as13285.net (HELO localhost.localdomain) ([2.99.183.201])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 17 Dec 2015 00:21:56 +0000
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282624>

The gui.recentrepo list may be longer than the maxrecent setting.
Allow extra space to show any extra entries.

In an ideal world, the git gui would limit the number of entries
to the maxrecent setting, however the recentrepo config list may
have been extended outside of the gui, or the maxrecent setting changed
to a reduced value. Further, when testing the gui's recentrepo
logic it is useful to show these extra, but valid, entries.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
word usage corrected.
Eric's comments $gmane/282432
---
 git-gui/lib/choose_repository.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index ad7a888..a08ed4f 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -153,7 +153,7 @@ constructor pick {} {
 			-background [get_bg_color $w_body.recentlabel] \
 			-wrap none \
 			-width 50 \
-			-height $maxrecent
+			-height [expr {$maxrecent + 5}]
 		$w_recentlist tag conf link \
 			-foreground blue \
 			-underline 1
-- 
2.6.4.windows.1
