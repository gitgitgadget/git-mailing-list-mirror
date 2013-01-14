From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/14] imap-send.c: remove some unused fields from struct store
Date: Mon, 14 Jan 2013 06:32:38 +0100
Message-ID: <1358141566-26081-7-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucgV-0007IG-AP
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab3ANFdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:33:44 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47739 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040Ab3ANFdn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:33:43 -0500
X-AuditID: 1207440e-b7f116d0000008ae-a2-50f398b6a709
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 93.9C.02222.6B893F05; Mon, 14 Jan 2013 00:33:42 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2n026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:41 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqLttxucAg6+TDS26rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGa+mP2Au
	WMJbMWPBVsYGxlVcXYycHBICJhLzFl1ig7DFJC7cWw9kc3EICVxmlGg+vJoZwjnLJLGxZSUr
	SBWbgK7Eop5mJhBbREBNYmLbIRYQm1kgRaLjeTcjiC0s4C9x5OhaMJtFQFVi8tP7YL28Ai4S
	B0+1sUBsU5B4vfMSWJxTwFXi+8dTzCC2EFDNw1PNbBMYeRcwMqxilEvMKc3VzU3MzClOTdYt
	Tk7My0st0jXWy80s0UtNKd3ECAkgvh2M7etlDjEKcDAq8fBuKfkcIMSaWFZcmXuIUZKDSUmU
	N7wfKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN7QOKMebklhZlVqUD5OS5mBREudVW6LuJySQ
	nliSmp2aWpBaBJOV4eBQkuDtnw7UKFiUmp5akZaZU4KQZuLgBBFcIBt4gDZ8BinkLS5IzC3O
	TIcoOsWoKCXOuxokIQCSyCjNgxsAi/VXjOJA/wjz7gep4gGmCbjuV0CDmYAGn73wHmRwSSJC
	SqqBsWnyDmM1o5PsuSlZrIGhLUYc8z5H1+37a5XZfNp4+h2hRGansKTVeoqSMhVfLfZuPC+3
	lrnE88VioZAT076+eu20o7LLr6F5tSpn90FJhkMb/66xSA93q192f/vfLIHrDl/XTElX31D0
	XvKD/rqzJ7+KJO9L+XPNSjyC4UBccc21THWHW862SizFGYmGWsxFxYkAofz7vNAC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213437>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a47008b..fe2bfab 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -36,12 +36,7 @@ typedef void *SSL;
 struct store {
 	/* currently open mailbox */
 	const char *name; /* foreign! maybe preset? */
-	char *path; /* own */
 	int uidvalidity;
-	unsigned char opts; /* maybe preset? */
-	/* note that the following do _not_ reflect stats from msgs, but mailbox totals */
-	int count; /* # of messages */
-	int recent; /* # of recent messages - don't trust this beyond the initial read */
 };
 
 static const char imap_send_usage[] = "git imap-send < <mbox>";
@@ -772,13 +767,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 				   !strcmp("NO", arg) || !strcmp("BYE", arg)) {
 				if ((resp = parse_response_code(ctx, NULL, cmd)) != RESP_OK)
 					return resp;
-			} else if (!strcmp("CAPABILITY", arg))
+			} else if (!strcmp("CAPABILITY", arg)) {
 				parse_capability(imap, cmd);
-			else if ((arg1 = next_arg(&cmd))) {
-				if (!strcmp("EXISTS", arg1))
-					ctx->gen.count = atoi(arg);
-				else if (!strcmp("RECENT", arg1))
-					ctx->gen.recent = atoi(arg);
+			} else if ((arg1 = next_arg(&cmd))) {
+				/* unused */
 			} else {
 				fprintf(stderr, "IMAP error: unable to parse untagged response\n");
 				return RESP_BAD;
@@ -1254,7 +1246,6 @@ static int imap_store_msg(struct store *gctx, struct strbuf *msg)
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
-	gctx->count++;
 
 	return DRV_OK;
 }
-- 
1.8.0.3
