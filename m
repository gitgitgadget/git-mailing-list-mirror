From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/7] clear_cached_refs(): rename parameter
Date: Mon, 10 Oct 2011 10:24:21 +0200
Message-ID: <1318235064-25915-5-git-send-email-mhagger@alum.mit.edu>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
 <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 10:24:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDBAG-0004kw-19
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 10:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab1JJIYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 04:24:44 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57850 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1JJIYm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 04:24:42 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RDB4g-0004Bi-8r; Mon, 10 Oct 2011 10:19:02 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183231>

...for consistency with the rest of this module.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index fb46cf5..9f004ce 100644
--- a/refs.c
+++ b/refs.c
@@ -175,14 +175,14 @@ static void free_ref_list(struct ref_list *list)
 	}
 }
 
-static void clear_cached_refs(struct cached_refs *ca)
+static void clear_cached_refs(struct cached_refs *refs)
 {
-	if (ca->did_loose && ca->loose)
-		free_ref_list(ca->loose);
-	if (ca->did_packed && ca->packed)
-		free_ref_list(ca->packed);
-	ca->loose = ca->packed = NULL;
-	ca->did_loose = ca->did_packed = 0;
+	if (refs->did_loose && refs->loose)
+		free_ref_list(refs->loose);
+	if (refs->did_packed && refs->packed)
+		free_ref_list(refs->packed);
+	refs->loose = refs->packed = NULL;
+	refs->did_loose = refs->did_packed = 0;
 }
 
 static struct cached_refs *create_cached_refs(const char *submodule)
-- 
1.7.7.rc2
