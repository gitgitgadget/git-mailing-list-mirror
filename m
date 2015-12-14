From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 4/4] git gui: allow for a long recentrepo list
Date: Mon, 14 Dec 2015 15:09:03 +0000
Message-ID: <1450105743-2432-5-git-send-email-philipoakley@iee.org>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
 <1450105743-2432-1-git-send-email-philipoakley@iee.org>
Cc: Alexey Astakhov <asstv7@gmail.com>, sender <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:09:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Uke-0003dW-D8
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbLNPJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:09:18 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:44189 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953AbbLNPJD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 10:09:03 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ADCwDp2m5WPCSzBlxeGQEBAQELAQIBAQEBAYI5UYFBgmKDfoFYsmKECoYIBAICgSJNAQEBAQEBBwEBAQFAAT+ENQEBBFYjEAhJOQoUBgESiDO9MgEBCCOGVoklDYULBZZ2qliEZz40gzsBH4ErAQEB
X-IPAS-Result: A2ADCwDp2m5WPCSzBlxeGQEBAQELAQIBAQEBAYI5UYFBgmKDfoFYsmKECoYIBAICgSJNAQEBAQEBBwEBAQFAAT+ENQEBBFYjEAhJOQoUBgESiDO9MgEBCCOGVoklDYULBZZ2qliEZz40gzsBH4ErAQEB
X-IronPort-AV: E=Sophos;i="5.20,427,1444690800"; 
   d="scan'208";a="621287622"
Received: from host-92-6-179-36.as43234.net (HELO localhost) ([92.6.179.36])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 14 Dec 2015 15:30:41 +0000
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1450105743-2432-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282363>

The gui.recentrepo list may be longer than the maxrecent setting.
Allow extra space to show any extra entries.

In an ideal world, the git gui would limit the number of entries
to the maxrecent setting, however the recentrepo config list may
have been extended outwith the gui, or the maxrecent setting changed
to a reduced value. Further, when testing the gui's recentrepo
logic it is useful to show these extra, but valid, entries.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
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
2.5.2.windows.2
