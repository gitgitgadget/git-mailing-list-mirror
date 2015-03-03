From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/7] struct ref_lock: delete the force_write member
Date: Tue,  3 Mar 2015 12:43:14 +0100
Message-ID: <1425382997-24984-5-git-send-email-mhagger@alum.mit.edu>
References: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:43:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSlEl-0003oy-HC
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbbCCLnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:43:37 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64644 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755934AbbCCLng (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:43:36 -0500
X-AuditID: 1207440d-f79976d000005643-e4-54f59e676e78
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 78.6B.22083.76E95F45; Tue,  3 Mar 2015 06:43:35 -0500 (EST)
Received: from michael.fritz.box (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BhJqH016748
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:43:33 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqJs+72uIwek9FhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3Bld094wFzTyVnzbPom1gXEXVxcj
	J4eEgIlE66aP7BC2mMSFe+vZuhi5OIQELjNKPPzQxQzhHGOSuH71HzNIFZuArsSinmYmEFtE
	QE1iYtshFhCbWeAHk8ShFbUgtrCAm8TTL11gNSwCqhKNLU1gG3gFXCT2nTjEDLFNTuL88Z9g
	NqeAq8TKtVtZuxg5gJa5SNz6UDGBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzM
	Er3UlNJNjJBQ5N3B+H+dzCFGAQ5GJR7eCexfQ4RYE8uKK3MPMUpyMCmJ8srPBgrxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4WWeC5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJ
	ynBwKEnwTgJpFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFRnwxMDZAUjxAe1+B
	7S0uSMwFikK0nmJUlBLnjQdJCIAkMkrz4MbCEswrRnGgL4V5n88BquIBJie47ldAg5mABt9S
	/AIyuCQRISXVwCjbZd4qdNzaN0drz8oDHytLZSsapX61b1rWwqVcbKCz+7T4eq2M38oHd3bn
	b147N69Pb3oIo85S9m9PrW+qRrKxaHFYan33WnlXODRiw+sOu1Ptd4OiYlozPaad 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264654>

From: Stefan Beller <sbeller@google.com>

Instead, compute the value when it is needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
Edited-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 3ed9ea6..7a2f53f 100644
--- a/refs.c
+++ b/refs.c
@@ -12,7 +12,6 @@ struct ref_lock {
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
 	int lock_fd;
-	int force_write;
 };
 
 /*
@@ -2318,8 +2317,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock->ref_name = xstrdup(refname);
 	lock->orig_ref_name = xstrdup(orig_refname);
 	ref_file = git_path("%s", refname);
-	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
-		lock->force_write = 1;
 
  retry:
 	switch (safe_create_leading_directories(ref_file)) {
@@ -3787,8 +3784,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			if (!update->lock->force_write &&
-			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
+			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
+						  (update->flags & REF_NODEREF));
+
+			if (!overwriting_symref
+			    && !hashcmp(update->lock->old_sha1, update->new_sha1)) {
+				/*
+				 * The reference already has the desired
+				 * value, so we don't need to write it.
+				 */
 				unlock_ref(update->lock);
 				update->lock = NULL;
 			} else if (write_ref_sha1(update->lock, update->new_sha1,
-- 
2.1.4
