From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH v2] bundle: Add colons to list headings in "verify"
Date: Fri,  8 Mar 2013 19:01:26 +0100
Message-ID: <1362765686-18396-1-git-send-email-git@cryptocrack.de>
References: <1362617796-4120-1-git-send-email-git@cryptocrack.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Lukas Fleischer <git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 19:02:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE1cS-0003r0-M0
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 19:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934543Ab3CHSBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 13:01:32 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:3874 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933657Ab3CHSBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 13:01:31 -0500
Received: from localhost (p57B4299B.dip.t-dialin.net [87.180.41.155])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id c2d673f3
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Fri, 8 Mar 2013 19:01:27 +0100 (CET)
X-Mailer: git-send-email 1.8.2.rc2.352.g908df73
In-Reply-To: <1362617796-4120-1-git-send-email-git@cryptocrack.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217675>

These slightly improve the reading flow by making it obvious that a list
follows.

Also, make the wording of both headings consistent by changing "contains
%d ref(s)" to "contains this ref"/"contains these %d refs".

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 bundle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bundle.c b/bundle.c
index 65db53b..6210a6b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -183,8 +183,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
 		struct ref_list *r;
 
 		r = &header->references;
-		printf_ln(Q_("The bundle contains %d ref",
-			     "The bundle contains %d refs",
+		printf_ln(Q_("The bundle contains this ref:",
+			     "The bundle contains these %d refs:",
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
@@ -192,8 +192,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
 		} else {
-			printf_ln(Q_("The bundle requires this ref",
-				     "The bundle requires these %d refs",
+			printf_ln(Q_("The bundle requires this ref:",
+				     "The bundle requires these %d refs:",
 				     r->nr),
 				  r->nr);
 			list_refs(r, 0, NULL);
-- 
1.8.2.rc2.352.g908df73
