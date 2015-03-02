From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/7] struct ref_lock: delete the force_write member
Date: Mon,  2 Mar 2015 10:29:54 +0100
Message-ID: <1425288597-20547-5-git-send-email-mhagger@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:30:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMgX-0007Nu-SH
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbbCBJaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:30:35 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50608 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753857AbbCBJab (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 04:30:31 -0500
X-AuditID: 12074412-f79e46d0000036b4-ec-54f42dab6eca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 62.32.14004.BAD24F45; Mon,  2 Mar 2015 04:30:19 -0500 (EST)
Received: from michael.fritz.box (p5DDB2321.dip0.t-ipconnect.de [93.219.35.33])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t229U5HX008921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Mar 2015 04:30:17 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqLta90uIwbdPchZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3Bk/7/ewFJzmqWj+N5WpgbGXq4uR
	k0NCwETiR/M3VghbTOLCvfVsXYxcHEIClxklNr6cywKSEBI4xiSxeaMAiM0moCuxqKeZCcQW
	EVCTmNh2CKyGWeAHk8ShFbUgtrCAm0Tzu49gQ1kEVCVOflvNDmLzCrhI7D11jg1imZzE+eM/
	mUFsTgFXiZ+/GtkhdrlIzLq+mnkCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZ
	JXqpKaWbGCGhKLSDcf1JuUOMAhyMSjy8K5Z+DhFiTSwrrsw9xCjJwaQkyjtH/UuIEF9Sfkpl
	RmJxRnxRaU5q8SFGCQ5mJRHe1/JAOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalF
	MFkZDg4lCd5gHaBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBkxBcDYwMkxQO0
	NxWknbe4IDEXKArReopRUUqc1wkkIQCSyCjNgxsLSzCvGMWBvhTm3QJSxQNMTnDdr4AGMwEN
	vqUINrgkESEl1cCYXHi5QL3lVsf2vlov3b3euxzniV2MaF+orilZeDTDwbqnvt181gb3Z5Of
	ve74VLdL9ZjVUbYjx2ZuTms4LmUSdFRPe4P1g4NHT9fYv3h8eN+Ud7um1dw+/uvz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264584>

From: Stefan Beller <sbeller@google.com>

Instead, compute the value when it is needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
Edited-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 3ed9ea6..f2e9883 100644
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
@@ -3787,8 +3784,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			if (!update->lock->force_write &&
-			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
+			if (!((update->type & REF_ISSYMREF)
+			      && (update->flags & REF_NODEREF))
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
