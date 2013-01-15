From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/14] imap-send.c: remove some unused fields from struct store
Date: Tue, 15 Jan 2013 09:06:24 +0100
Message-ID: <1358237193-8887-7-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:07:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1Yc-0002aH-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab3AOIHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:16 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:47403 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755800Ab3AOIHN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:13 -0500
X-AuditID: 1207440d-b7f306d0000008b7-8d-50f50e3027e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A1.BD.02231.03E05F05; Tue, 15 Jan 2013 03:07:12 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5S029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:12 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqGvA9zXAYNY3c4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M64OWENU8ES3op/qzeyNDCu
	4upi5OSQEDCRmN98nhHCFpO4cG89WxcjF4eQwGVGiR37LrFDOGeYJF6um88GUsUmoCuxqKeZ
	CcQWEVCTmNh2iAXEZhZwkNj8uRFskrBAkMSOnRdZQWwWAVWJVzv2gdm8As4ST4+8YoXYpiDx
	euclMJtTwEXi6s9jzCC2EFDNlw2nGScw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuk
	l5tZopeaUrqJERIsvDsY/6+TOcQowMGoxMN7W/dLgBBrYllxZe4hRkkOJiVR3g6urwFCfEn5
	KZUZicUZ8UWlOanFhxglOJiVRHh93gGV86YkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YW
	pBbBZGU4OJQkeBV4gYYKFqWmp1akZeaUIKSZODhBBBfIBh6gDa+4gQp5iwsSc4sz0yGKTjEq
	Sonz/uEBSgiAJDJK8+AGwOL6FaM40D/CvHdAqniAKQGu+xXQYCagwZv2fgYZXJKIkJJqYLR6
	tvVGi54NH/PblkUT/r/2MLVl32Bs5c8ZPLe4eNL06vjJhqoHXrAtOnxU09pJ2aLQxyI9LvfL
	bpHLP2LszWZu9n150Il5hZ7j28X7Cj1Du2/8rOt/+Lbzfm76bt2j+Y5+ORqxPL0cm6sfZZ+Y
	JGY3p9tevVHWWmni/ImOr9auK18XdGS9pRJLcUaioRZzUXEiAPrIwj/GAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213608>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9e181e0..f193211 100644
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
