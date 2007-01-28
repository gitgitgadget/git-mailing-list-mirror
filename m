From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] wt-status: Actually accept `color.status.BLAH' configuration variables.
Date: Sun, 28 Jan 2007 14:55:03 +0000
Organization: Straylight/Edgeware
Message-ID: <11699961031401-git-send-email-mdw@distorted.org.uk>
Cc: Mark Wooding <mdw@distorted.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 28 15:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBBR0-0003Ml-Cv
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 15:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbXA1OzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 09:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbXA1OzG
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 09:55:06 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:37100 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S932659AbXA1OzG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jan 2007 09:55:06 -0500
Received: (qmail 11723 invoked by uid 1000); 28 Jan 2007 14:55:03 -0000
X-Mailer: git-send-email 1.5.0.rc2.g4e206
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38034>

A stupid typo stopped this from working.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b7250e4..5567868 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -351,7 +351,7 @@ int git_status_config(const char *k, const char *v)
 		wt_status_use_color = git_config_colorbool(k, v);
 		return 0;
 	}
-	if (!strncmp(k, "status.color.", 13) || !strncmp(k, "color.status", 13)) {
+	if (!strncmp(k, "status.color.", 13) || !strncmp(k, "color.status.", 13)) {
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
-- 
1.5.0.rc2.g4e206
