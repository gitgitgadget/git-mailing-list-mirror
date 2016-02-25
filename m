From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/20] try_remove_empty_parents(): rename parameter "name" -> "refname"
Date: Thu, 25 Feb 2016 14:16:12 +0100
Message-ID: <d6ab397f974f9b97e9ff99f3fd4fb67ee5e81ea7.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvmq-0003nQ-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760425AbcBYNQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:54 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64398 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760327AbcBYNQx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:53 -0500
X-AuditID: 1207440e-c03ff70000000398-80-56cefec316f7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id EF.6A.00920.3CEFEC65; Thu, 25 Feb 2016 08:16:51 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrr024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:50 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHvk37kwg76jTBbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8bK/yvZC2ZwVDSc3MrYwLibrYuRk0NCwESi4+Zz
	9i5GLg4hga2MEo0XnjFCOCeYJDa++sEIUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFngEaNE1/7t
	YEXCAlESN58tZAGxWQRUJRYu/cMKYvMCxT+sPssKsU5OouXHbjCbU8BC4uLJ6cwgtpCAucSq
	G3vYJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokREmR8Oxjb18sc
	YhTgYFTi4Y34fTZMiDWxrLgy9xCjJAeTkijvnufnwoT4kvJTKjMSizPii0pzUosPMUpwMCuJ
	8K74C5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwWoE0ChalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiIL4YGAcgKR6gvblge4sLEnOBohCtpxgVpcR5
	ZYDRLyQAksgozYMbC0sdrxjFgb4U5m0BaecBph247ldAg5mABs/cADa4JBEhJdXAGHP/nv9H
	i5TZ0z+xtH5baaCgcrWy+aiP6dwtUZJ7ZqoVJux5bcpiwn2gibvsX5yiY+7nWb8XtO2xdbw+
	6a1rlWiSLMsjaaHpTu+k70++9rt18dv6WaVpEyYe2Zd8Tbzk0rqlezY8m73TqLrl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287372>

This is the standard nomenclature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bd25ae2..543fd8e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2200,13 +2200,13 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 
 /*
  * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *name.
+ * Note: munges *refname.
  */
-static void try_remove_empty_parents(char *name)
+static void try_remove_empty_parents(char *refname)
 {
 	char *p, *q;
 	int i;
-	p = name;
+	p = refname;
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
@@ -2224,7 +2224,7 @@ static void try_remove_empty_parents(char *name)
 		if (q == p)
 			break;
 		*q = '\0';
-		if (rmdir(git_path("%s", name)))
+		if (rmdir(git_path("%s", refname)))
 			break;
 	}
 }
-- 
2.7.0
