From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 2/2] apply: hide unused options from short help
Date: Wed, 18 Mar 2009 19:05:40 +0100
Message-ID: <1237399540-27258-2-git-send-email-barra_cuda@katamail.com>
References: <1237399540-27258-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 18:59:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk02T-0000Uu-FE
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbZCRR5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbZCRR5Q
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:57:16 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53094 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752614AbZCRR5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:57:14 -0400
Received: (qmail 21792 invoked by uid 89); 18 Mar 2009 17:57:06 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.57.140)
  by smtp2-pc with SMTP; 18 Mar 2009 17:57:06 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
In-Reply-To: <1237399540-27258-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113637>

The options "--binary" and "--allow-binary-replacement" of
git-apply are no-op and maintained for backward compatibility,
so avoid to show them in the short help screen.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-apply.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index a664338..0e8e5ae 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3224,10 +3224,10 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			"ignore additions made by the patch"),
 		OPT_BOOLEAN(0, "stat", &diffstat,
 			"instead of applying the patch, output diffstat for the input"),
-		OPT_BOOLEAN(0, "allow-binary-replacement", &binary,
-			"now no-op"),
-		OPT_BOOLEAN(0, "binary", &binary,
-			"now no-op"),
+		{ OPTION_BOOLEAN, 0, "allow-binary-replacement", &binary,
+		  NULL, "old option, now no-op", PARSE_OPT_HIDDEN },
+		{ OPTION_BOOLEAN, 0, "binary", &binary,
+		  NULL, "old option, now no-op", PARSE_OPT_HIDDEN },
 		OPT_BOOLEAN(0, "numstat", &numstat,
 			"shows number of added and deleted lines in decimal notation"),
 		OPT_BOOLEAN(0, "summary", &summary,
-- 
1.6.2.22.gc2ac
