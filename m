From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [ADDENDUM v4] Yet more preparation for reference backends
Date: Mon, 13 Jun 2016 11:55:57 +0200
Message-ID: <328d460b1730c0b192961234c06036514498c1b1.1465808670.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu> <575AB797.809@alum.mit.edu> <xmqq8tydgic2.fsf@gitster.mtv.corp.google.com>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <novalis@novalis.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 11:56:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCObe-0000SM-Hn
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 11:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbcFMJ40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 05:56:26 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53031 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030182AbcFMJ4Z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2016 05:56:25 -0400
X-AuditID: 12074411-e3fff70000000955-44-575e833976fc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 27.D4.02389.9338E575; Mon, 13 Jun 2016 05:56:09 -0400 (EDT)
Received: from michael.fritz.box (p548D6022.dip0.t-ipconnect.de [84.141.96.34])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5D9u55F004124
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 13 Jun 2016 05:56:06 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <xmqq8tydgic2.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqGvZHBducGKZkUXXlW4mi4beK8wW
	t1fMZ7ZY8vA1s0X3lLeMFj9aepgtZl61tujs+MrowOHx9/0HJo+ds+6ye3S1H2HzeNa7h9Hj
	4iVlj/1Lt7F5fN4k53H72TaWAI4obpukxJKy4Mz0PH27BO6M/af3sBX80a049cKtgfGsahcj
	B4eEgInE0YkGXYxcHEICWxklXszYzAbhHGeSmLP6PXsXIycHm4CuxKKeZiYQW0TAS+LXiR9g
	RcwCW5kkHjzpBysSFnCSaNu+mw3EZhFQlZgxez0jiM0rECXx9WsDmC0hICdxefoDqA1NjBIb
	T80Ba+AUsJbYce0d+wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcx
	QsJOcAfjjJNyhxgFOBiVeHg1VsWGC7EmlhVX5h5ilORgUhLllfCJCxfiS8pPqcxILM6ILyrN
	SS0+xCjBwawkwnusESjHm5JYWZValA+TkuZgURLn5Vui7ickkJ5YkpqdmlqQWgSTleHgUJLg
	vQTSKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KgfhiYBSApHiA9qo0gewtLkjM
	BYpCtJ5iVJQS51UFSQiAJDJK8+DGwpLJK0ZxoC+FeYtAqniAiQiu+xXQYCagwRz7okEGlyQi
	pKQaGHlqxWesLnLP971RNWF1wQT3v3+PWv/tTI772ryyY6ss95kPlvurprJsZeRd0+7+dq50
	xrsnUWpdWu7rnKT2vfrM97PCYqFYSkGOznJP5oikNQeTHOsqJnNdvmCQpbE7ZEHj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297174>

Below is the delta needed to fixed the bug in the mh/split-under-lock
patch series that I mentioned in an earlier email [1], plus a little
tweak to make the docstring for lock_ref_for_update() clearer.

I actually fixed the bug in preparatory commit

    ref_transaction_commit(): remove local variable n

, whose subject was accordingly changed to

    ref_transaction_commit(): remove local variables n and updates

[2]. See branch "split-under-lock" in my GitHub fork [3] for the full
revised patch series (including the changes to a later patch that are
necessary when it is rebased onto the fix). In the same repo I've also
rebased dependent branches update-ref-errors, ref-iterators, and
ref-store on top of this one; all of those rebases were trivial.

Here, for the convenience of reviewers, I present the delta between
the old and new end states of the split-under-lock patch series. (It
didn't seem justified to re-send the whole 33-patch series for this
logically small change.)

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/297002
[2] https://github.com/gitster/git/commit/efe472813d60befd72d6e2797934c90b22a26c93
[3] https://github.com/mhagger/git

---
 refs/files-backend.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1230dfb..bbf96ad 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3393,7 +3393,8 @@ static const char *original_update_refname(struct ref_update *update)
  * - Lock the reference referred to by update.
  * - Read the reference under lock.
  * - Check that its old SHA-1 value (if specified) is correct, and in
- *   any case record it for later use in the reflog.
+ *   any case record it in update->lock->old_oid for later use when
+ *   writing the reflog.
  * - If it is a symref update without REF_NODEREF, split it up into a
  *   REF_LOG_ONLY update of the symref and add a separate update for
  *   the referent to transaction.
@@ -3556,7 +3557,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	int ret = 0, i;
-	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
@@ -3582,7 +3582,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	 * same refname as any existing ones.)
 	 */
 	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = updates[i];
+		struct ref_update *update = transaction->updates[i];
 		struct string_list_item *item =
 			string_list_append(&affected_refnames, update->refname);
 
@@ -3632,7 +3632,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	 * open at a time to avoid running out of file descriptors.
 	 */
 	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = updates[i];
+		struct ref_update *update = transaction->updates[i];
 
 		ret = lock_ref_for_update(update, transaction, head_ref,
 					  &affected_refnames, err);
@@ -3642,7 +3642,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = updates[i];
+		struct ref_update *update = transaction->updates[i];
 		struct ref_lock *lock = update->lock;
 
 		if (update->flags & REF_NEEDS_COMMIT ||
@@ -3674,7 +3674,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = updates[i];
+		struct ref_update *update = transaction->updates[i];
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY)) {
@@ -3701,8 +3701,8 @@ cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < transaction->nr; i++)
-		if (updates[i]->lock)
-			unlock_ref(updates[i]->lock);
+		if (transaction->updates[i]->lock)
+			unlock_ref(transaction->updates[i]->lock);
 	string_list_clear(&refs_to_delete, 0);
 	free(head_ref);
 	string_list_clear(&affected_refnames, 0);
@@ -3722,7 +3722,6 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
 	int ret = 0, i;
-	struct ref_update **updates = transaction->updates;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
 	assert(err);
@@ -3732,7 +3731,8 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Fail if a refname appears more than once in the transaction: */
 	for (i = 0; i < transaction->nr; i++)
-		string_list_append(&affected_refnames, updates[i]->refname);
+		string_list_append(&affected_refnames,
+				   transaction->updates[i]->refname);
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
@@ -3755,7 +3755,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = updates[i];
+		struct ref_update *update = transaction->updates[i];
 
 		if ((update->flags & REF_HAVE_OLD) &&
 		    !is_null_sha1(update->old_sha1))
@@ -3776,7 +3776,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = updates[i];
+		struct ref_update *update = transaction->updates[i];
 
 		if ((update->flags & REF_HAVE_NEW) &&
 		    !is_null_sha1(update->new_sha1))
-- 
2.8.1
