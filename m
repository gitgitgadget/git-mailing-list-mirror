From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/7] prune_remote(): rename local variable
Date: Tue, 25 Nov 2014 09:02:33 +0100
Message-ID: <1416902555-10748-6-git-send-email-mhagger@alum.mit.edu>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 09:03:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtB5g-00021r-T2
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 09:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbaKYIDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 03:03:08 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:48666 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752090AbaKYIDH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 03:03:07 -0500
X-AuditID: 1207440f-f792a6d000001284-65-547437ad11b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DC.C0.04740.DA734745; Tue, 25 Nov 2014 03:02:53 -0500 (EST)
Received: from michael.fritz.box (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP82i0o027888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 03:02:52 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvWvCTE4PkCVYuuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6M5/dPshbM4atYsWsJewPjK+4uRk4OCQETifePG9ghbDGJC/fWs3UxcnEICVxm
	lLjy/gkThHOcSWLCr81sIFVsAroSi3qamUBsEQE1iYlth1hAipgFDjNKvN65DGgUB4ewgK3E
	td0SICaLgKrE4rtqIOW8Ai4SS983MIOEJQTkJLau8wYJcwq4Sszce4gRxBYCKlm7r5V9AiPv
	AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxghYcW/g7FrvcwhRgEORiUe
	3oZjxSFCrIllxZW5hxglOZiURHlFDEtChPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwRs0DKudN
	SaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfDKmwENFSxKTU+tSMvMKUFI
	M3FwggznkhIpTs1LSS1KLC3JiAfFRXwxMDJAUjxAe4tA2nmLCxJzgaIQracYFaXEeSVBEgIg
	iYzSPLixsGTxilEc6Eth3uMgVTzARAPX/QpoMBPQ4LiZhSCDSxIRUlINjIL/eDZ7H9XmlZe3
	uJ3WFtf/ccYK1XSXd4ttfxtNXL5e5/ejqITvS0WOrVv1ct/XOzzH3JMm5U+4Ksk/1aJHc8XN
	PXeN7b0ulwWY2fZYTREuYLZcNL+dt5cvt3qqk2UPz+U9TeW/zsv/+rlzYfvSeU9n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260204>

Rename "delete_refs_list" to "refs_to_prune". The new name is more
self-explanatory.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
