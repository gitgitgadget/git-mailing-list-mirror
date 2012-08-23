From: mhagger@alum.mit.edu
Subject: [PATCH 04/17] Name local variables more consistently
Date: Thu, 23 Aug 2012 10:10:29 +0200
Message-ID: <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Sd4-0000fx-01
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933718Ab2HWISz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:18:55 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:52683 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933655Ab2HWISo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:44 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:18:44 EDT
X-AuditID: 1207440f-b7fde6d00000095c-08-5035e59f8842
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D8.11.02396.F95E5305; Thu, 23 Aug 2012 04:11:11 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV4030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:09 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqDv/qWmAwa3bshZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujHuf1zMV
	zJOuaGo+yt7AuFe0i5GTQ0LAROJq0xZWCFtM4sK99WxdjFwcQgKXGSVe3fjNBOGcZZL4saWB
	DaSKTUBK4mVjDzuILSKgJjGx7RALiM0skCLR8bybEcQWFrCVuDz5MdhUFgFViX9bloPZvAIu
	Epf27mWE2KYo8eP7GmYQm1PAVWLB901gcSGgmo+NN5knMPIuYGRYxSiXmFOaq5ubmJlTnJqs
	W5ycmJeXWqRropebWaKXmlK6iRESQPw7GLvWyxxiFOBgVOLhfWFuGiDEmlhWXJl7iFGSg0lJ
	lPffI6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd7weUA53pTEyqrUonyYlDQHi5I4r/oSdT8h
	gfTEktTs1NSC1CKYrAwHh5IE750nQI2CRanpqRVpmTklCGkmDk4QwQWygQdow1OQQt7igsTc
	4sx0iKJTjIpS4rwnQRICIImM0jy4AbBYf8UoDvSPMO85kCoeYJqA634FNJgJaLDaVWOQwSWJ
	CCmpBkbO9A0XlW95x29jzZD4etIg/XTbiVNMp0ULJpiejpY9KuG1+VTDg/Cr3n//T+VZ/vLd
	GkeGap++46aHoydFC/nZ7rI6WHdXpIvtyZbEzf8+HAz6Uylbo5T4OGjid0llf6kSkW1aXKzM
	Uisj9yrWe1r+iXgSPlfulMR5rdaSawUTqx1OPV6/+qgSS3FGoqEWc1FxIgD/5AiZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204124>

From: Michael Haggerty <mhagger@alum.mit.edu>

Use the names (nr_heads, heads) consistently across functions, instead
of sometimes naming the same values (nr_match, match).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cc21047..f11545e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -521,7 +521,7 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 	}
 }
 
-static void filter_refs(struct ref **refs, int nr_match, char **match)
+static void filter_refs(struct ref **refs, int nr_heads, char **heads)
 {
 	struct ref **return_refs;
 	struct ref *newlist = NULL;
@@ -530,12 +530,12 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	struct ref *fastarray[32];
 	int match_pos;
 
-	if (nr_match && !args.fetch_all) {
-		if (ARRAY_SIZE(fastarray) < nr_match)
-			return_refs = xcalloc(nr_match, sizeof(struct ref *));
+	if (nr_heads && !args.fetch_all) {
+		if (ARRAY_SIZE(fastarray) < nr_heads)
+			return_refs = xcalloc(nr_heads, sizeof(struct ref *));
 		else {
 			return_refs = fastarray;
-			memset(return_refs, 0, sizeof(struct ref *) * nr_match);
+			memset(return_refs, 0, sizeof(struct ref *) * nr_heads);
 		}
 	}
 	else
@@ -556,12 +556,12 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 		}
 		else {
 			int cmp = -1;
-			while (match_pos < nr_match) {
-				cmp = strcmp(ref->name, match[match_pos]);
+			while (match_pos < nr_heads) {
+				cmp = strcmp(ref->name, heads[match_pos]);
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					match[match_pos][0] = '\0';
+					heads[match_pos][0] = '\0';
 					return_refs[match_pos] = ref;
 					break;
 				}
@@ -576,7 +576,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 
 	if (!args.fetch_all) {
 		int i;
-		for (i = 0; i < nr_match; i++) {
+		for (i = 0; i < nr_heads; i++) {
 			ref = return_refs[i];
 			if (ref) {
 				*newtail = ref;
@@ -595,7 +595,7 @@ static void mark_alternate_complete(const struct ref *ref, void *unused)
 	mark_complete(NULL, ref->old_sha1, 0, NULL);
 }
 
-static int everything_local(struct ref **refs, int nr_match, char **match)
+static int everything_local(struct ref **refs, int nr_heads, char **heads)
 {
 	struct ref *ref;
 	int retval;
@@ -646,7 +646,7 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 		}
 	}
 
-	filter_refs(refs, nr_match, match);
+	filter_refs(refs, nr_heads, heads);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
@@ -777,8 +777,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 
 static struct ref *do_fetch_pack(int fd[2],
 		const struct ref *orig_ref,
-		int nr_match,
-		char **match,
+		int nr_heads, char **heads,
 		char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
@@ -819,7 +818,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (everything_local(&ref, nr_match, match)) {
+	if (everything_local(&ref, nr_heads, heads)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-- 
1.7.11.3
