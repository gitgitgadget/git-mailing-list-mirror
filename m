From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] builtin-commit.c: Remove a redundant assignment.
Date: Thu, 10 Apr 2008 13:33:08 +0200
Message-ID: <1207827189-7509-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 13:34:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjv2a-000151-UO
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 13:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbYDJLdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 07:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbYDJLdQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 07:33:16 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43262 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbYDJLdP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 07:33:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1Jjv1h-0003ML-UZ; Thu, 10 Apr 2008 13:33:10 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 965B56C4; Thu, 10 Apr 2008 13:33:09 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 2E031FA48; Thu, 10 Apr 2008 13:33:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.33.g376d1
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79209>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	I noticed this while looking how --only is implemented.

	-- Hannes

 builtin-commit.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 660a345..e3adfdf 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -745,10 +745,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die("No paths with --include/--only does not make sense.");
 	if (argc == 0 && only && amend)
 		only_include_assumed = "Clever... amending the last one with dirty index.";
-	if (argc > 0 && !also && !only) {
+	if (argc > 0 && !also && !only)
 		only_include_assumed = "Explicit paths specified without -i nor -o; assuming --only paths...";
-		also = 0;
-	}
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
-- 
1.5.5.33.g376d1
