Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2952A20966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdCZCp3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:45:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33273 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdCZCp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:45:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id p189so4078029pfp.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/kM9RN+Um5acWcikslsb0PPVXTJak3x9GpM1DkyBuk=;
        b=TURxyM2etO9llUIZgvLghq9nEZxis0snKA4RHI/KXH0KsAt164bHqcKTowEkkSTWdz
         vKrnOAm2gVH2KWRqELp5nuEq+OMqVe2GufnZDKuIaSKy4EXLjVFRJfN/sAa5epSAniKC
         53AXRvOLmAYvg8K3q9TcFSe1YoOUseS6lVeX4ZI7yB/Z1udqcqNjnd8yGqvuRwWbBIWB
         TgY7kbEIQfEKU1rwdnP3egvVkPPbpGbx7bXtDFGPD2YcqLrsNwS+uEiNpQEiS0TkHQIa
         oszpXB9NhlklmcvUKlY8hm9nU52S5hMv/eUwWKhYJiHTmiZLrXbMObQsYS6KnWEvZ2w5
         4y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/kM9RN+Um5acWcikslsb0PPVXTJak3x9GpM1DkyBuk=;
        b=glaCZOaykh5wcw0wKR6A8hzomYxBlogz5dktxomal8ecIIbqKln27r6OD5B/78S4Qi
         xco6UkO/P+aBj3qmKVTtY58O4ZLX7pwKlaUdAM2NgPUAT/PAVoCmUoUj73IP7GdYRHVv
         37ZVfHhpv2EwlaZA24M556n3Z1+V/BJ3a1R0VAMG8h55TD+xzVvkpQ1sWchmy+MSjlCx
         6PZGteKSxro9XjC/Vlx63YwkaK1eJbi4sy/PldiKgHA8yzfCmBt+YAPXANiF/02QUw7U
         w5Ed4fKWrX415j10eWsnpZTFoTWXpxPCUyFed7pOgOj6nTYry2JhprIg3/b1KIAtE5bS
         5PyA==
X-Gm-Message-State: AFeK/H0CDzYNukesxZ91IMBNVE1f0QL/ScNoTg3t/0sIXAgalkI/AOHfjT0/7b8nSOGfqA==
X-Received: by 10.99.156.2 with SMTP id f2mr17511990pge.189.1490496317125;
        Sat, 25 Mar 2017 19:45:17 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id n185sm12729444pga.9.2017.03.25.19.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:45:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:45:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 23/28] files-backend: avoid ref api targetting main ref store
Date:   Sun, 26 Mar 2017 09:42:36 +0700
Message-Id: <20170326024241.31984-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small step towards making files-backend works as a non-main ref store
using the newly added store-aware API.

For the record, `join` and `nm` on refs.o and files-backend.o tell me
that files-backend no longer uses functions that defaults to
get_main_ref_store().

I'm not yet comfortable at the idea of removing
files_assert_main_repository() (or converting REF_STORE_MAIN to
REF_STORE_WRITE). More staring and testing is required before that can
happen. Well, except peel_ref(). I'm pretty sure that function is safe.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 84 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dec8540a0f..a5b405436f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1830,8 +1830,6 @@ static int files_peel_ref(struct ref_store *ref_store,
 	int flag;
 	unsigned char base[20];
 
-	files_assert_main_repository(refs, "peel_ref");
-
 	if (current_ref_iter && current_ref_iter->refname == refname) {
 		struct object_id peeled;
 
@@ -1841,7 +1839,8 @@ static int files_peel_ref(struct ref_store *ref_store,
 		return 0;
 	}
 
-	if (read_ref_full(refname, RESOLVE_REF_READING, base, &flag))
+	if (refs_read_ref_full(ref_store, refname,
+			       RESOLVE_REF_READING, base, &flag))
 		return -1;
 
 	/*
@@ -2009,15 +2008,15 @@ static struct ref_iterator *files_ref_iterator_begin(
  * on success. On error, write an error message to err, set errno, and
  * return a negative value.
  */
-static int verify_lock(struct ref_lock *lock,
+static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 		       const unsigned char *old_sha1, int mustexist,
 		       struct strbuf *err)
 {
 	assert(err);
 
-	if (read_ref_full(lock->ref_name,
-			  mustexist ? RESOLVE_REF_READING : 0,
-			  lock->old_oid.hash, NULL)) {
+	if (refs_read_ref_full(ref_store, lock->ref_name,
+			       mustexist ? RESOLVE_REF_READING : 0,
+			       lock->old_oid.hash, NULL)) {
 		if (old_sha1) {
 			int save_errno = errno;
 			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
@@ -2086,8 +2085,9 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
 	files_ref_path(refs, &ref_file, refname);
-	resolved = !!resolve_ref_unsafe(refname, resolve_flags,
-					lock->old_oid.hash, type);
+	resolved = !!refs_resolve_ref_unsafe(&refs->base,
+					     refname, resolve_flags,
+					     lock->old_oid.hash, type);
 	if (!resolved && errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
@@ -2104,8 +2104,9 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 					    refname);
 			goto error_return;
 		}
-		resolved = !!resolve_ref_unsafe(refname, resolve_flags,
-						lock->old_oid.hash, type);
+		resolved = !!refs_resolve_ref_unsafe(&refs->base,
+						     refname, resolve_flags,
+						     lock->old_oid.hash, type);
 	}
 	if (!resolved) {
 		last_errno = errno;
@@ -2143,7 +2144,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (verify_lock(lock, old_sha1, mustexist, err)) {
+	if (verify_lock(&refs->base, lock, old_sha1, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
 	}
@@ -2398,7 +2399,7 @@ static void try_remove_empty_parents(struct files_ref_store *refs,
 }
 
 /* make sure nobody touched the ref, and unlink */
-static void prune_ref(struct ref_to_prune *r)
+static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2406,7 +2407,7 @@ static void prune_ref(struct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
 
-	transaction = ref_transaction_begin(&err);
+	transaction = ref_store_transaction_begin(&refs->base, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
 				   REF_ISPRUNING | REF_NODEREF, NULL, &err) ||
@@ -2420,10 +2421,10 @@ static void prune_ref(struct ref_to_prune *r)
 	strbuf_release(&err);
 }
 
-static void prune_refs(struct ref_to_prune *r)
+static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	while (r) {
-		prune_ref(r);
+		prune_ref(refs, r);
 		r = r->next;
 	}
 }
@@ -2447,7 +2448,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	if (commit_packed_refs(refs))
 		die_errno("unable to overwrite old ref-pack file");
 
-	prune_refs(cbdata.ref_to_prune);
+	prune_refs(refs, cbdata.ref_to_prune);
 	return 0;
 }
 
@@ -2539,7 +2540,7 @@ static int files_delete_refs(struct ref_store *ref_store,
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
-		if (delete_ref(NULL, refname, NULL, flags))
+		if (refs_delete_ref(&refs->base, NULL, refname, NULL, flags))
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
@@ -2661,7 +2662,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (!resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
+				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 				orig_sha1, &flag)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
@@ -2683,7 +2685,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (delete_ref(logmsg, oldrefname, orig_sha1, REF_NODEREF)) {
+	if (refs_delete_ref(&refs->base, logmsg, oldrefname,
+			    orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
@@ -2695,9 +2698,11 @@ static int files_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-			   sha1, NULL) &&
-	    delete_ref(NULL, newrefname, NULL, REF_NODEREF)) {
+	if (!refs_read_ref_full(&refs->base, newrefname,
+				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+				sha1, NULL) &&
+	    refs_delete_ref(&refs->base, NULL, newrefname,
+			    NULL, REF_NODEREF)) {
 		if (errno == EISDIR) {
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -3053,8 +3058,9 @@ static int commit_ref_update(struct files_ref_store *refs,
 		int head_flag;
 		const char *head_ref;
 
-		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-					      head_sha1, &head_flag);
+		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
+						   RESOLVE_REF_READING,
+						   head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
@@ -3098,7 +3104,9 @@ static void update_symref_reflog(struct files_ref_store *refs,
 {
 	struct strbuf err = STRBUF_INIT;
 	unsigned char new_sha1[20];
-	if (logmsg && !read_ref(target, new_sha1) &&
+	if (logmsg &&
+	    !refs_read_ref_full(&refs->base, target,
+				RESOLVE_REF_READING, new_sha1, NULL) &&
 	    files_log_ref_write(refs, refname, lock->old_oid.hash,
 				new_sha1, logmsg, 0, &err)) {
 		error("%s", err.buf);
@@ -3403,6 +3411,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 struct files_reflog_iterator {
 	struct ref_iterator base;
 
+	struct ref_store *ref_store;
 	struct dir_iterator *dir_iterator;
 	struct object_id oid;
 };
@@ -3424,8 +3433,9 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (ends_with(diter->basename, ".lock"))
 			continue;
 
-		if (read_ref_full(diter->relative_path, 0,
-				  iter->oid.hash, &flags)) {
+		if (refs_read_ref_full(iter->ref_store,
+				       diter->relative_path, 0,
+				       iter->oid.hash, &flags)) {
 			error("bad ref for %s", diter->path.buf);
 			continue;
 		}
@@ -3479,6 +3489,7 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
 	files_reflog_path(refs, &sb, NULL);
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
+	iter->ref_store = ref_store;
 	strbuf_release(&sb);
 	return ref_iterator;
 }
@@ -3718,8 +3729,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * the transaction, so we have to read it here
 			 * to record and possibly check old_sha1:
 			 */
-			if (read_ref_full(referent.buf, 0,
-					  lock->old_oid.hash, NULL)) {
+			if (refs_read_ref_full(&refs->base,
+					       referent.buf, 0,
+					       lock->old_oid.hash, NULL)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
@@ -3873,8 +3885,9 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	 * head_ref within the transaction, then split_head_update()
 	 * arranges for the reflog of HEAD to be updated, too.
 	 */
-	head_ref = resolve_refdup("HEAD", RESOLVE_REF_NO_RECURSE,
-				  head_oid.hash, &head_type);
+	head_ref = refs_resolve_refdup(ref_store, "HEAD",
+				       RESOLVE_REF_NO_RECURSE,
+				       head_oid.hash, &head_type);
 
 	if (head_ref && !(head_type & REF_ISSYMREF)) {
 		free(head_ref);
@@ -4047,7 +4060,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	 * so here we really only check that none of the references
 	 * that we are creating already exists.
 	 */
-	if (for_each_rawref(ref_present, &affected_refnames))
+	if (refs_for_each_rawref(&refs->base, ref_present,
+				 &affected_refnames))
 		die("BUG: initial ref transaction called with existing refs");
 
 	for (i = 0; i < transaction->nr; i++) {
@@ -4166,7 +4180,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		strbuf_release(&err);
 		return -1;
 	}
-	if (!reflog_exists(refname)) {
+	if (!refs_reflog_exists(ref_store, refname)) {
 		unlock_ref(lock);
 		return 0;
 	}
@@ -4197,7 +4211,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	}
 
 	(*prepare_fn)(refname, sha1, cb.policy_cb);
-	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
+	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
-- 
2.11.0.157.gd943d85

