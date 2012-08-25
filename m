From: mhagger@alum.mit.edu
Subject: [PATCH v2 04/17] Name local variables more consistently
Date: Sat, 25 Aug 2012 08:44:14 +0200
Message-ID: <1345877067-11841-5-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A7Q-0002Pu-Uq
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732Ab2HYGpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:10 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:45741 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484Ab2HYGpH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:07 -0400
X-AuditID: 12074414-b7f846d0000008b8-da-50387472bd0c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.16.02232.27478305; Sat, 25 Aug 2012 02:45:06 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSf011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:04 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqFtUYhFgcH6DgUXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M/qbr7IWfJetuNh+m62BcbF4FyMHh4SAicSGhRJdjJxAppjEhXvr2boYuTiEBC4zStx4
	P58FJCEkcJZJ4s6pWhCbTUBK4mVjDzuILSKgJjGx7RALSAOzQBejxPJ1v9hAEsICDhITWz+x
	gSxgEVCVWLZKBCTMK+AisfbmWXaIZYoSP76vYQaxOQVcJSb8usgOsctFounYFZYJjLwLGBlW
	Mcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoSEk8gOxiMn5Q4xCnAwKvHw3jhj
	HiDEmlhWXJl7iFGSg0lJlFes0CJAiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvdwagHG9KYmVV
	alE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBG9tMVCjYFFqempFWmZOCUKaiYMT
	RHCBbOAB2pAMUshbXJCYW5yZDlF0ilFRSpzXACQhAJLIKM2DGwCL/FeM4kD/CPPOLAKq4gEm
	DbjuV0CDmYAGl7uagwwuSURISTUwLtpw6K2O7P8v9wy2+WoIq+0KsV9exDLRasqL2fd4RGZM
	2TkvMmRO3Mudh0Ilz3BrLH0y5UVXrI5z8uGPR8ojrzrY8lck79vIKfhy4oVNS4R3ef3/ZlB2
	UHV5XihPp+oH9UCRT8YaybwvGEz3NZjdrpmj+pXNZ8e9DYq3t+ZIFUtNWWnDd+Zk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204251>

From: Michael Haggerty <mhagger@alum.mit.edu>

Use the names (nr_heads, heads) consistently across functions, instead
of sometimes naming the same values (nr_match, match).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index cc21047..76288a2 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -521,27 +521,27 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 	}
 }
 
-static void filter_refs(struct ref **refs, int nr_match, char **match)
+static void filter_refs(struct ref **refs, int nr_heads, char **heads)
 {
 	struct ref **return_refs;
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
 	struct ref *fastarray[32];
-	int match_pos;
+	int head_pos;
 
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
 		return_refs = NULL;
 
-	match_pos = 0;
+	head_pos = 0;
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
@@ -556,17 +556,17 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 		}
 		else {
 			int cmp = -1;
-			while (match_pos < nr_match) {
-				cmp = strcmp(ref->name, match[match_pos]);
+			while (head_pos < nr_heads) {
+				cmp = strcmp(ref->name, heads[head_pos]);
 				if (cmp < 0) /* definitely do not have it */
 					break;
 				else if (cmp == 0) { /* definitely have it */
-					match[match_pos][0] = '\0';
-					return_refs[match_pos] = ref;
+					heads[head_pos][0] = '\0';
+					return_refs[head_pos] = ref;
 					break;
 				}
 				else /* might have it; keep looking */
-					match_pos++;
+					head_pos++;
 			}
 			if (!cmp)
 				continue; /* we will link it later */
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
