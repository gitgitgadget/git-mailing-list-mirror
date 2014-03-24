From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 26/27] struct ref_update: Add type field
Date: Mon, 24 Mar 2014 18:56:59 +0100
Message-ID: <1395683820-17304-27-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99C-0002Oo-4M
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbaCXR6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:58:05 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54330 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753862AbaCXR6D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:58:03 -0400
X-AuditID: 12074413-f79076d000002d17-45-5330722ac742
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 07.F5.11543.A2270335; Mon, 24 Mar 2014 13:58:02 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xw028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:58:00 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqKtVZBBssP69iMXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO2Nm9yq2gnV8FR/OXGNqYJzK3cXIySEhYCIxrW0P
	K4QtJnHh3nq2LkYuDiGBy4wSz5YvYANJCAmcYJL4tUcPxGYT0JVY1NPMBGKLCKhJTGw7xALS
	wCxwhVHiysftQA4Hh7CAtcSqzw4gNSwCqhL/d64Cq+cVcJV4c2wmI8QyOYkpvxewg9icQPGt
	7YeZIXa5SOz42Ms0gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQ
	wBPewbjrpNwhRgEORiUe3g2mBsFCrIllxZW5hxglOZiURHnZcoFCfEn5KZUZicUZ8UWlOanF
	hxglOJiVRHgtw4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3qwC
	oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGTEFwNjAyTFA7TXoRBkb3FBYi5Q
	FKL1FKOilDjvNZC5AiCJjNI8uLGwdPKKURzoS2FeNZB2HmAqgut+BTSYCWhweJMeyOCSRISU
	VAPjtMxvJ43WOyhs5T6qaVhhxdP5+IjY4ikqjC/jXfZmukYHiWSVvtuxn1m1//zqgHNz3nlc
	C1e83aBg5BH5fcEe5Q0BG7b8u3W0Kcpr56QD79YmL2sq0+LfEb5qQWAk35/pGRKd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244846>

This is temporary space for ref_transaction_commit().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index d1edd57..07f900a 100644
--- a/refs.c
+++ b/refs.c
@@ -3279,6 +3279,7 @@ struct ref_update {
 	int flags; /* REF_NODEREF? */
 	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
 	struct ref_lock *lock;
+	int type;
 	const char refname[FLEX_ARRAY];
 };
 
@@ -3410,7 +3411,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	int ret = 0, delnum = 0, i;
 	struct ref_update **updates;
-	int *types;
 	const char **delnames;
 	int n = transaction->nr;
 
@@ -3419,7 +3419,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Allocate work space */
 	updates = xmalloc(sizeof(*updates) * n);
-	types = xmalloc(sizeof(*types) * n);
 	delnames = xmalloc(sizeof(*delnames) * n);
 
 	/* Copy, sort, and reject duplicate refs */
@@ -3437,7 +3436,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &types[i], onerr);
+					       &update->type, onerr);
 		if (!update->lock) {
 			ret = 1;
 			goto cleanup;
@@ -3465,7 +3464,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (update->lock) {
 			delnames[delnum++] = update->lock->ref_name;
-			ret |= delete_ref_loose(update->lock, types[i]);
+			ret |= delete_ref_loose(update->lock, update->type);
 		}
 	}
 
@@ -3479,7 +3478,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(updates);
-	free(types);
 	free(delnames);
 	ref_transaction_free(transaction);
 	return ret;
-- 
1.9.0
