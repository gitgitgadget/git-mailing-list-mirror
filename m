From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 30/56] show_head_ref(): convert local variable "unused" to object_id
Date: Mon, 25 May 2015 18:38:56 +0000
Message-ID: <1432579162-411464-31-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJC-0001F8-EA
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbbEYSkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:37 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50686 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282AbbEYSkV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C62192809B;
	Mon, 25 May 2015 18:40:19 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269868>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index a2d388d..55353ad 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -408,10 +408,10 @@ static int show_head_ref(const char *refname, const struct object_id *oid,
 	struct strbuf *buf = cb_data;
 
 	if (flag & REF_ISSYMREF) {
-		unsigned char unused[20];
+		struct object_id unused;
 		const char *target = resolve_ref_unsafe(refname,
 							RESOLVE_REF_READING,
-							unused, NULL);
+							unused.hash, NULL);
 		const char *target_nons = strip_namespace(target);
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
-- 
2.4.0
