From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] builtin-clone: Use is_dir_sep() instead of '/'
Date: Fri, 18 Jul 2008 09:34:43 +0200
Message-ID: <1216366485-12201-3-git-send-email-johannes.sixt@telecom.at>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-2-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 09:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJkVV-0003a0-HM
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 09:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbYGRHez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 03:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbYGRHey
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 03:34:54 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4675 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbYGRHet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 03:34:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KJkUI-0002lb-FJ; Fri, 18 Jul 2008 09:34:46 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 232B1FF0C; Fri, 18 Jul 2008 09:34:46 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id E7623FA46; Fri, 18 Jul 2008 09:34:45 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.275.g0a3e0f
In-Reply-To: <1216366485-12201-2-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88998>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 643c7d4..fddf47f 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -115,7 +115,7 @@ static char *guess_dir_name(const char *repo, int is_bundle)
 			if (!after_slash_or_colon)
 				end = p;
 			p += 7;
-		} else if (*p == '/' || *p == ':') {
+		} else if (is_dir_sep(*p) || *p == ':') {
 			if (end == limit)
 				end = p;
 			after_slash_or_colon = 1;
-- 
1.5.6.1.275.g0a3e0f
