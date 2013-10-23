From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/15] get_ref_map(): rename local variables
Date: Wed, 23 Oct 2013 17:50:38 +0200
Message-ID: <1382543448-2586-6-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0qb-0007Hr-P9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab3JWP7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:59:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62815 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408Ab3JWP7o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:59:44 -0400
X-AuditID: 1207440e-b7fbc6d000004ad9-44-5267f09f6ee7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 36.86.19161.F90F7625; Wed, 23 Oct 2013 11:51:59 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLsw009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:51:57 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqDv/Q3qQwex7chbTu1azWHRd6Way
	aOi9wmwx7+4uJotVt5YxW6yccYPR4vaK+cwWTzsrLea9eMFm8aOlh9mBy+Pv+w9MHpfWvWTy
	OPRnCrvHsxPtbB6XXn5n83jWu4fR4+IlZY8ZLa9ZPD5vkvM4cPkxWwBXFLdNUmJJWXBmep6+
	XQJ3xoYTixkLGngqrhx9z9jAuJ2zi5GTQ0LAROLF7w9MELaYxIV769m6GLk4hAQuM0r8nf2T
	CcK5wiRxYv1MZpAqNgFdiUU9zWAdIgJqEhPbDrGAFDELTGSWOD59EQtIQljARuLu/s+sIDaL
	gKrEr0MdjCA2r4CzxLlFv9m7GDmA1slJPPwWCxLmFHCRuHB8Oli5EFDJhIVT2Scw8i5gZFjF
	KJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopeaUrqJERK2fDsY29fLHGIU4GBU4uG1aE8L
	EmJNLCuuzD3EKMnBpCTKO+ddepAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4dd4FyvCmJlVWp
	RfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3qb3QI2CRanpqRVpmTklCGkmDk4Q
	wQWygQdowyyQQt7igsTc4sx0iKJTjIpS4rwNIAkBkERGaR7cAFiCecUoDvSPMO9skCoeYHKC
	634FNJgJaPCUJWkgg0sSEVJSDYyT9mwq35V276z/iaK8X18OONockNZtSbyr7tC28bJH44Og
	/uszn5f7a8rNf/V4//ekzEbmrRmsr74Z89zTtvi+sevwYoVgc/5zj7U1c44a6S6b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236530>

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
1.8.4
