From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/23] get_ref_map(): rename local variables
Date: Wed, 30 Oct 2013 06:32:54 +0100
Message-ID: <1383111192-23780-6-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:34:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOQ3-0005oe-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab3J3FeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:34:09 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60304 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752370Ab3J3FeD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:34:03 -0400
X-AuditID: 1207440f-b7f306d000006d99-b9-52709a4af0c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 2A.FF.28057.A4A90725; Wed, 30 Oct 2013 01:34:02 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIG014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:00 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqOs1qyDIYNJGfYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7493/OcwFTTwVt787NjDu5Oxi5OSQEDCRWDllLhOELSZx4d56ti5GLg4hgcuMEq3P/rND
	OFeYJP5MfsYIUsUmoCuxqKcZrENEQE1iYtshFpAiZoGJzBLHpy9iAUkIC9hLLHpxhRXEZhFQ
	lTj6/ByQzcHBK+Ai0XZMEWKbgsSN5qlgJZwCrhKfdt1kB7GFgEqa2j+zT2DkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJGj5dzB2rZc5xCjAwajEw2vwID9IiDWx
	rLgy9xCjJAeTkihv2pSCICG+pPyUyozE4oz4otKc1OJDjBIczEoivNOPA5XzpiRWVqUW5cOk
	pDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4lWcCDRUsSk1PrUjLzClBSDNxcIIILpAN
	PEAbeEAKeYsLEnOLM9Mhik4xKkqJ8yqAJARAEhmleXADYOnlFaM40D/CEO08wNQE1/0KaDAT
	0OA9LHkgg0sSEVJSDYwmprW/Wo8IvtY4HsauKeG1V32xlJRQrwM7L5usZ4byrALNBVOkRWbm
	shpxLtbp+f3Z+s/RV9pVAgdiSiw93TUV/HROSm6yu5X3Kb1ky9K/C9ZuiThk9Hkf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236960>

Rename "refs" -> "refspecs" and "ref_count" -> "refspec_count" to
reduce confusion, because they describe an array of "struct refspec",
as opposed to the "struct ref" objects that are also used in this
function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7a101..2248abf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -165,8 +165,8 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref ***tail);
 
 static struct ref *get_ref_map(struct transport *transport,
-			       struct refspec *refs, int ref_count, int tags,
-			       int *autotags)
+			       struct refspec *refspecs, int refspec_count,
+			       int tags, int *autotags)
 {
 	int i;
 	struct ref *rm;
@@ -175,12 +175,12 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
-	if (ref_count || tags == TAGS_SET) {
+	if (refspec_count || tags == TAGS_SET) {
 		struct ref **old_tail;
 
-		for (i = 0; i < ref_count; i++) {
-			get_fetch_map(remote_refs, &refs[i], &tail, 0);
-			if (refs[i].dst && refs[i].dst[0])
+		for (i = 0; i < refspec_count; i++) {
+			get_fetch_map(remote_refs, &refspecs[i], &tail, 0);
+			if (refspecs[i].dst && refspecs[i].dst[0])
 				*autotags = 1;
 		}
 		/* Merge everything on the command line, but not --tags */
-- 
1.8.4.1
