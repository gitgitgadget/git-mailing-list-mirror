From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/6] prune_remote(): rename local variable
Date: Fri, 21 Nov 2014 15:09:09 +0100
Message-ID: <1416578950-23210-6-git-send-email-mhagger@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:09:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrotw-0000Ji-BM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 15:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295AbaKUOJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 09:09:26 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58165 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757904AbaKUOJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 09:09:25 -0500
X-AuditID: 12074411-f79fa6d000006b8a-02-546f47934440
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 51.8A.27530.3974F645; Fri, 21 Nov 2014 09:09:23 -0500 (EST)
Received: from michael.fritz.box (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sALE9EqT000733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 09:09:22 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqDvZPT/EoG+2sUXXlW4mi4beK8wW
	b28uYbS4vWI+s8W/CTUWmze3sziwefx9/4HJY+esu+weCzaVely8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfGzWdqBS95K2ZOaWNtYNzD3cXIySEhYCJxrXspO4QtJnHh3nq2LkYuDiGBy4wS
	q3vvMUE4x5kkXr+7zQZSxSagK7Gop5kJxBYR8JI4tW4GM0gRs8B8RonZ62YygiSEBawk3vft
	ALNZBFQlvvV8YQGxeQVcJFbc7gCKcwCtk5PYus4bJMwp4CrxdEUf2BVCAjUSV/q2s01g5F3A
	yLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIySwBHcwzjgpd4hRgINRiYd3
	xeK8ECHWxLLiytxDjJIcTEqivIZu+SFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjLhYFyvCmJ
	lVWpRfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJXn+QoYJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgyIgvBsYGSIoHaK8tSDtvcUFiLlAUovUUo6KUOK8vSEIAJJFR
	mgc3FpYuXjGKA30pzPvNFaiKB5hq4LpfAQ1mAhr8d2kuyOCSRISUVAOjzuLlPukcitfDlTQW
	lm9L6p/H4rKVX+Kj2QWPD6cSg5JPbE2yPr278+z/784sRfclTxo4/5Cr5Gg/HN97gp1fTOCz
	ycxrfDe4NCr4tx39leT8Xkja+e/6U8vLnEo4n30RjVWe0m/6YG2lfrug/sU/z8T/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename "delete_refs_list" to "refs_to_prune". The new name is more
self-explanatory.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 63a6709..efbf5fb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1311,7 +1311,7 @@ static int prune_remote(const char *remote, int dry_run)
 {
 	int result = 0, i;
 	struct ref_states states;
-	struct string_list delete_refs_list = STRING_LIST_INIT_NODUP;
+	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1333,13 +1333,13 @@ static int prune_remote(const char *remote, int dry_run)
 	for (i = 0; i < states.stale.nr; i++) {
 		const char *refname = states.stale.items[i].util;
 
-		string_list_append(&delete_refs_list, refname);
+		string_list_append(&refs_to_prune, refname);
 	}
-	sort_string_list(&delete_refs_list);
+	sort_string_list(&refs_to_prune);
 
 	if (!dry_run) {
 		struct strbuf err = STRBUF_INIT;
-		if (repack_without_refs(&delete_refs_list, &err))
+		if (repack_without_refs(&refs_to_prune, &err))
 			result |= error("%s", err.buf);
 		strbuf_release(&err);
 	}
@@ -1358,9 +1358,9 @@ static int prune_remote(const char *remote, int dry_run)
 			       abbrev_ref(refname, "refs/remotes/"));
 	}
 
-	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
+	warn_dangling_symrefs(stdout, dangling_msg, &refs_to_prune);
 
-	string_list_clear(&delete_refs_list, 0);
+	string_list_clear(&refs_to_prune, 0);
 	free_remote_ref_states(&states);
 	return result;
 }
-- 
2.1.3
