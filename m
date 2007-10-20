From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: [PATCH] Fix receive-pack error msg.
Date: Sat, 20 Oct 2007 21:31:46 +0200
Message-ID: <1192908706-13502-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 03:43:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjPr9-0008E4-Gk
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 03:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXJUBno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 21:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbXJUBno
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 21:43:44 -0400
Received: from mail.transmode.se ([83.241.175.147]:9829 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720AbXJUBnn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 21:43:43 -0400
Received: from gentoo-jocke ([192.168.1.15]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 20 Oct 2007 21:31:46 +0200
Received: by gentoo-jocke (sSMTP sendmail emulation); Sat, 20 Oct 2007 21:31:46 +0200
X-Mailer: git-send-email 1.5.3.4
X-OriginalArrivalTime: 20 Oct 2007 19:31:46.0701 (UTC) FILETIME=[DA5E33D0:01C8134F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61856>

receive-pack is only executed remotely so when
reporting errors, say so.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 receive-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index d3c422b..1521d0b 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -166,7 +166,7 @@ static const char *update(struct command *cmd)
 	struct ref_lock *lock;
 
 	if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
-		error("refusing to create funny ref '%s' locally", name);
+		error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
 
-- 
1.5.3.4
