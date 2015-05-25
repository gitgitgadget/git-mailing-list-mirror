From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 21/56] append_one_rev(): rewrite to work with object_id
Date: Mon, 25 May 2015 18:38:47 +0000
Message-ID: <1432579162-411464-22-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKX-0001xX-CW
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbbEYSmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:21 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50652 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386AbbEYSkP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1EC732809E;
	Mon, 25 May 2015 18:40:14 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269897>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 7e00657..b861e41 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -536,9 +536,9 @@ static int show_independent(struct commit **rev,
 
 static void append_one_rev(const char *av)
 {
-	unsigned char revkey[20];
-	if (!get_sha1(av, revkey)) {
-		append_ref(av, revkey, 0);
+	struct object_id revkey;
+	if (!get_sha1(av, revkey.hash)) {
+		append_ref(av, revkey.hash, 0);
 		return;
 	}
 	if (strchr(av, '*') || strchr(av, '?') || strchr(av, '[')) {
-- 
2.4.0
