From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/14] imap-send.c: remove struct store_conf
Date: Mon, 14 Jan 2013 06:32:36 +0100
Message-ID: <1358141566-26081-5-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucgJ-00077r-GA
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab3ANFdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:33:38 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:45228 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040Ab3ANFdh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:33:37 -0500
X-AuditID: 12074413-b7f786d0000008bb-b4-50f398b07338
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.EA.02235.0B893F05; Mon, 14 Jan 2013 00:33:36 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2l026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:35 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLthxucAgy+dphZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujFPHJ7MU
	PGGvmHjvCEsDYzdbFyMnh4SAicTyq4eZIWwxiQv31gPFuTiEBC4zSkzZ9JUFwjnLJHGm+wMT
	SBWbgK7Eop5mMFtEQE1iYtshFhCbWSBFouN5N2MXIweHsICNxNH7ASBhFgFViXUXJoEt4xVw
	kdh+eifUYgWJ1zsvsYLYnAKuEt8/ngI7Qgio5uGpZrYJjLwLGBlWMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuma6+VmluilppRuYoSEj/AOxl0n5Q4xCnAwKvHwbiz5HCDEmlhWXJl7iFGSg0lJ
	lDe8HyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDe0DijHm5JYWZValA+TkuZgURLnVVui7ick
	kJ5YkpqdmlqQWgSTleHgUJLg5QTGiZBgUWp6akVaZk4JQpqJgxNEcIFs4AHa8Hk6yIbigsTc
	4sx0iKJTjIpS4rxSIBMEQBIZpXlwA2CR/opRHOgfYd5/IO08wCQB1/0KaDAT0OCzF96DDC5J
	REhJNTDyzG4zuas6V22h/I2S49Yhmvdnmq231ytbUijfqahgtGX21GXrYlrDf3bNM2Pb6B76
	c//DdyXdz+6d26Gs2dl+XVnB92GNluNB/+melyfbbu/hWPLO98Pm3Vvk13NLZan7zu3kPPe6
	ocQsX3J9RGDBOT2D/2ItZ7acnzSr58pO33dLrWz8WrYpsRRnJBpqMRcVJwIAV/4W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213434>

It was never used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index d675e70..3177361 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -33,15 +33,6 @@ typedef void *SSL;
 #include <openssl/hmac.h>
 #endif
 
-struct store_conf {
-	char *name;
-	const char *path; /* should this be here? its interpretation is driver-specific */
-	char *map_inbox;
-	char *trash;
-	unsigned max_size; /* off_t is overkill */
-	unsigned trash_remote_new:1, trash_only_new:1;
-};
-
 /* For message->status */
 #define M_RECENT       (1<<0) /* unsyncable flag; maildir_* depend on this being 1<<0 */
 #define M_DEAD         (1<<1) /* expunged */
@@ -55,8 +46,6 @@ struct message {
 };
 
 struct store {
-	struct store_conf *conf; /* foreign */
-
 	/* currently open mailbox */
 	const char *name; /* foreign! maybe preset? */
 	char *path; /* own */
-- 
1.8.0.3
