From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] builtin-rm: Add a --force flag
Date: Sat,  9 Aug 2008 00:37:02 +0200
Message-ID: <1218235022-33695-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 00:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRab4-00055H-Ic
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 00:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYHHWhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 18:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbYHHWhG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 18:37:06 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:31737 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbYHHWhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 18:37:05 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6204.online.nl (SMTP Server) with ESMTP id 286AE1C00086;
	Sat,  9 Aug 2008 00:37:03 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6204.online.nl (SMTP Server) with ESMTP id D21EF1C00081;
	Sat,  9 Aug 2008 00:37:02 +0200 (CEST)
X-ME-UUID: 20080808223702860.D21EF1C00081@mwinf6204.online.nl
X-Mailer: git-send-email 1.6.0.rc1.288.g5b89f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91721>

This adds a --force flag to git-rm, making it somewhat easier for
subversion people to switch.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

  I heard some people complain about how they try "svn rm -f" or "git rm
  --force", which both fail. We can help them a bit by supporting --force too.

 builtin-rm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index ee8247b..4c9f483 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -131,7 +131,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only),
 	OPT__QUIET(&quiet),
 	OPT_BOOLEAN( 0 , "cached",         &index_only, "only remove from the index"),
-	OPT_BOOLEAN('f', NULL,             &force,      "override the up-to-date check"),
+	OPT_BOOLEAN('f', "force",             &force,      "override the up-to-date check"),
 	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive removal"),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
 				"exit with a zero status even if nothing matched"),
-- 
1.6.0.rc1.288.g5b89f
