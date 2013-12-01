From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] environment: normalize use of prefixcmp() by removing "
 != 0"
Date: Sun, 01 Dec 2013 08:49:14 +0100
Message-ID: <20131201074919.3042.88989.chriscool@tuxfamily.org>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 08:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn1np-0004Pp-Fd
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 08:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004Ab3LAHua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 02:50:30 -0500
Received: from [194.158.98.45] ([194.158.98.45]:35534 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750895Ab3LAHu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 02:50:27 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id BABFF2AD;
	Sun,  1 Dec 2013 08:50:05 +0100 (CET)
X-git-sha1: 443a9452713a39f6f6c2891caafdb69ea19fcde4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238580>

To be able to automatically convert prefixcmp() to starts_with()
we need first to make sure that prefixcmp() is always used in
the same way.

So let's remove " != 0" after prefixcmp().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 environment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 0a15349..cd2b068 100644
--- a/environment.c
+++ b/environment.c
@@ -171,7 +171,7 @@ const char *get_git_namespace(void)
 
 const char *strip_namespace(const char *namespaced_ref)
 {
-	if (prefixcmp(namespaced_ref, get_git_namespace()) != 0)
+	if (prefixcmp(namespaced_ref, get_git_namespace()))
 		return NULL;
 	return namespaced_ref + namespace_len;
 }
-- 
1.8.4.1.561.g12affca
