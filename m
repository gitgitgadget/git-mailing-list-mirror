From: Felipe Franciosi <felipe@paradoxo.org>
Subject: [PATCH] Initialise hash variable to prevent compiler warnings
Date: Mon, 13 Oct 2014 15:37:21 +0100
Message-ID: <1413211041-28732-1-git-send-email-felipe@paradoxo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Franciosi <felipe@paradoxo.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 16:37:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdgkQ-0000vN-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 16:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbaJMOhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 10:37:12 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:35050 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbaJMOhL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 10:37:11 -0400
X-IronPort-AV: E=Sophos;i="5.04,711,1406592000"; 
   d="scan'208";a="181984311"
Received: from ukmail1.uk.xensource.com (10.80.16.128) by smtprelay.citrix.com
 (10.13.107.78) with Microsoft SMTP Server id 14.3.181.6; Mon, 13 Oct 2014
 10:37:08 -0400
Received: from godfather.uk.xensource.com ([10.80.2.155]
 helo=godfather.uk.xensource.com.)	by ukmail1.uk.xensource.com with esmtp
 (Exim 4.69)	(envelope-from <felipe@paradoxo.org>)	id 1XdgkF-0007vL-T8; Mon,
 13 Oct 2014 15:37:07 +0100
X-Mailer: git-send-email 1.7.10.4
X-DLP: MIA2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'hash' variable in test-hashmap.c is not initialised properly
which causes some 'gcc' versions to complain during compilation.

Signed-off-by: Felipe Franciosi <felipe@paradoxo.org>
---
 test-hashmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-hashmap.c b/test-hashmap.c
index 07aa7ec..cc2891d 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -47,7 +47,7 @@ static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
 
 static unsigned int hash(unsigned int method, unsigned int i, const char *key)
 {
-	unsigned int hash;
+	unsigned int hash = 0;
 	switch (method & 3)
 	{
 	case HASH_METHOD_FNV:
-- 
1.7.10.4
