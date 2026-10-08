Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9939E46A600
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452675; cv=none; b=DF2NufnRi4FuTO/AYUVkxvSLdILqr6GTp2aOGDjmkNHOZ7oGEe0i64XYqBIOo5T/jmRJdD5GjPn4NiAb/YapEABQ6r+7bdVAiFuIdvuh2ePKXv1gQcEW4FrZqauYYvqP9h545IgNaY8xznkNKKpiCFeQdNKtLxuYSBnxDaTfnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452675; c=relaxed/simple;
	bh=eftNqw5aZaZSkYFfcVpOOn5p05CiBscqsyvLsSwiBlc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc:
	 MIME-Version:Content-Type; b=F03gc7xPUouUKDGfaEMLCWBQ4QA/0EfQ8E0lLr8pn9231JYIZ5RpDg/RL3BuvFqTogvhlBu6n+NhraaAcCmzn/d6gQxjerUwUVnvYvAUuLvE5337nq/bEFGPjnOKPucL2W2kqKEkK1kUrdVf5KTWMvHKyNz+CRy/hc8y6OD+XsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFO2a7Kl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFO2a7Kl"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c31988fc977so36179766b.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452670; x=1792057470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZO9EdbPek8s6l2S00vxbj48U561DVYz4asJWsiW3XI=;
        b=qFO2a7Kl/SKGBbV4l/R3fC87D9yA9QGwDjAv3ad0VT2X0driITuyZCiPyRPMRf8dNw
         YtTP8a6d0NsnKpn2YPdwwFr7eAbaHo4RdsmDX0j7Gq9L/uUY5VDcLi/N3iKpYgctub8b
         fCL6rE69CMFrrMUfRuV7l4GfYTrblT9ucUB3L7BMXPlqEwhYpSODzf7ztJupdMfZOjdb
         e5LR2upZPDjtV/tw+4lIVsIjn1NJnWRHXkCkzouqQ746mN1DNWR8BOVl24CA+NYUj9r0
         EZWL1RehCqPFIoXsHK3LcCkfacPSPGzfKh0gBMAvoN8h8VSSu3x4B3SpjvP65LJwr4LL
         xu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452670; x=1792057470;
        h=content-transfer-encoding:content-type:mime-version:cc:to:subject
         :date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZO9EdbPek8s6l2S00vxbj48U561DVYz4asJWsiW3XI=;
        b=c0RufbgYNczVBt1is4+/hezD2rVAqOdYqhdDxPWhTv0lUhPK3fqjYiIDEGdoHWC9Pq
         8inHzjrj98CIZAvW8WKmvS3nTzFmYXKAsgcmlxzQxa5TfNAlXQ0EJn3nJBQNodqbQvEv
         UFoAvpg5s4AttjX9V5AHuIr+xZJNRtX1o4G/Wt0l7rRG+qcYWWu5X5N+Hc2ZwzbeSgTL
         NlzzSQLXEFmNA13jkNvYSNxcviGn7KUj4ez6cpigRIZsOBLL2oLzxdbVjfC7jxCU2pZX
         jfsgpDDWWd4t+2QknT+weFzJKHae9vbP+U0uQiw0PcIFOY0ms1vJRdQIc7RNCHfcRgof
         +sfQ==
X-Gm-Message-State: AFuF++lnPxHU51G5NqKmWw9YzLkZU10oWc2H3N3JzXifoTw+WuH74jc9
	XoRWs2nsfdKIsHRyQT04x5RxIA5YxhADvnBF4AzXwX6MEZhtczy/bCc+qxTpfA==
X-Gm-Gg: AYBFou0h3UYWQOqnXqsHelDjVHb0RyNQkkknxVcf8pmwXFCpLFiIpe7Tns8jbfHpQwE
	X5PmQP2KByjdgL9/dfikyKQdEYtMiFRgU/VfukdyBZjswF4io0ls11ccTmO0di+GCbq2iUGzjwQ
	/wIazhOQSziDQvUMzpP+iv5L65QuYvEV6oqyENl+jStKJBuTdilyazCcyK7qSKxHT/4eFsmgk/o
	JPyj4AOWSC9yCYdLQ2o8pPRZAi8QpCdaT2rExrbOIHhtoUHT93WMp2P1Bq1N4oUVyvUMUNVoags
	lQj0AzSKNi/YET64AWL00/PWoMKtynZLl+j38kXPIGl3asDTqM3jPdqvnVRdLCD0UWmVWVJhxRF
	W7feMJ7BeV7vGsLvDutfOrLm8MDrCMpOO0FmEBchTVxktSOtBw5pf2FAsrpgHNSLdIdoOHxldUJ
	xFOBLsRFWJgASzNYSL6xgw4ICNQkNjUW+I41VYX4GbdLK5wqQasP0yK0LZPnnCXdmWc9Q1WpRwD
	bOG7qutWlP/2pHEE3ho7tCn6zcLpRhPypLt3U78h4LdJyb5w06dhDStP8qfUFWKea5wpiPhj59+
	EwJtrPkopZNMcuHbDgBOoV6iJyVeR450T76fXMa7CYPY5KIPOMXWhh63VVXQEqBmE0ljanhCdKH
	U4xOnDOsiMkcoOtw28r1LiKAYP+5HrRoV9iulY+zbm8E=
X-Received: by 2002:a17:907:60cd:b0:c31:6ba6:3108 with SMTP id a640c23a62f3a-c317c2f3027mr459347566b.47.1791452669722;
        Thu, 08 Oct 2026 02:44:29 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([192.166.203.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c318ae45e19sm114188366b.61.2026.10.08.02.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:44:29 -0700 (PDT)
Message-Id: <f3f2c7ee11593be5e7f1f6668f4c601b6247c6e7.1791452597.git.maciej.ciemborowicz@gmail.com>
In-Reply-To: <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791452597.git.maciej.ciemborowicz@gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 08 Oct 2026 11:44:19 +0200
Subject: [PATCH v4 4/4] refs: remove backend-specific copy and rename
 callbacks
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Karthik Nayak <karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Copy and rename now use the transaction API for refs and reflogs. Remove
the unused callbacks, backend implementations, and their private
helpers. The files backend no longer needs a shared temporary reflog
name or rollback writes that reconstruct previously visible refs and
logs.

Signed-off-by: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
---
 refs/debug.c            |  24 ---
 refs/files-backend.c    | 334 ----------------------------------------
 refs/packed-backend.c   |   2 -
 refs/refs-internal.h    |   9 --
 refs/reftable-backend.c | 287 ----------------------------------
 5 files changed, 656 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 639db0f26e..b4991f71ae 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -143,28 +143,6 @@ static int debug_optimize_required(struct ref_store *ref_store,
 	return res;
 }
 
-static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
-			    const char *newref, const char *logmsg)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
-					      logmsg);
-	trace_printf_key(&trace_refs, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
-		logmsg, res);
-	return res;
-}
-
-static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
-			  const char *newref, const char *logmsg)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res =
-		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
-	trace_printf_key(&trace_refs, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
-		logmsg, res);
-	return res;
-}
-
 struct debug_ref_iterator {
 	struct ref_iterator base;
 	struct ref_iterator *iter;
@@ -453,8 +431,6 @@ struct ref_storage_be refs_be_debug = {
 	.optimize = debug_optimize,
 	.optimize_required = debug_optimize_required,
 
-	.rename_ref = debug_rename_ref,
-	.copy_ref = debug_copy_ref,
 
 	.iterator_begin = debug_ref_iterator_begin,
 	.read_raw_ref = debug_read_raw_ref,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ffdc112f9a..589e501050 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1623,273 +1623,6 @@ static int files_optimize_required(struct ref_store *ref_store,
 	return 0;
 }
 
-/*
- * People using contrib's git-new-workdir have .git/logs/refs ->
- * /some/other/path/.git/logs/refs, and that may live on another device.
- *
- * IOW, to avoid cross device rename errors, the temporary renamed log must
- * live into logs/refs.
- */
-#define TMP_RENAMED_LOG  "refs/.tmp-renamed-log"
-
-struct rename_cb {
-	const char *tmp_renamed_log;
-	int true_errno;
-};
-
-static int rename_tmp_log_callback(const char *path, void *cb_data)
-{
-	struct rename_cb *cb = cb_data;
-
-	if (rename(cb->tmp_renamed_log, path)) {
-		/*
-		 * rename(a, b) when b is an existing directory ought
-		 * to result in ISDIR, but Solaris 5.8 gives ENOTDIR.
-		 * Sheesh. Record the true errno for error reporting,
-		 * but report EISDIR to raceproof_create_file() so
-		 * that it knows to retry.
-		 */
-		cb->true_errno = errno;
-		if (errno == ENOTDIR)
-			errno = EISDIR;
-		return -1;
-	} else {
-		return 0;
-	}
-}
-
-static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
-{
-	struct strbuf path = STRBUF_INIT;
-	struct strbuf tmp = STRBUF_INIT;
-	struct rename_cb cb;
-	int ret;
-
-	files_reflog_path(refs, &path, newrefname);
-	files_reflog_path(refs, &tmp, TMP_RENAMED_LOG);
-	cb.tmp_renamed_log = tmp.buf;
-	ret = raceproof_create_file(refs, path.buf, rename_tmp_log_callback, &cb);
-	if (ret) {
-		if (errno == EISDIR)
-			error("directory not empty: %s", path.buf);
-		else
-			error("unable to move logfile %s to %s: %s",
-			      tmp.buf, path.buf,
-			      strerror(cb.true_errno));
-	}
-
-	strbuf_release(&path);
-	strbuf_release(&tmp);
-	return ret;
-}
-
-static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
-							struct ref_lock *lock,
-							const struct object_id *oid,
-							struct strbuf *err);
-static int commit_ref_update(struct files_ref_store *refs,
-			     struct ref_lock *lock,
-			     const struct object_id *oid, const char *logmsg,
-			     int flags,
-			     struct strbuf *err);
-
-/*
- * Emit a better error message than lockfile.c's
- * unable_to_lock_message() would in case there is a D/F conflict with
- * another existing reference. If there would be a conflict, emit an error
- * message and return false; otherwise, return true.
- *
- * Note that this function is not safe against all races with other
- * processes, and that's not its job. We'll emit a more verbose error on D/f
- * conflicts if we get past it into lock_ref_oid_basic().
- */
-static int refs_rename_ref_available(struct ref_store *refs,
-			      const char *old_refname,
-			      const char *new_refname)
-{
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct strbuf err = STRBUF_INIT;
-	int ok;
-
-	string_list_insert(&skip, old_refname);
-	ok = !refs_verify_refname_available(refs, new_refname,
-					    NULL, &skip, 0, &err);
-	if (!ok)
-		error("%s", err.buf);
-
-	string_list_clear(&skip, 0);
-	strbuf_release(&err);
-	return ok;
-}
-
-static int files_copy_or_rename_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg, int copy)
-{
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct object_id orig_oid;
-	int flag = 0, logmoved = 0;
-	struct ref_lock *lock;
-	struct stat loginfo;
-	struct strbuf sb_oldref = STRBUF_INIT;
-	struct strbuf sb_newref = STRBUF_INIT;
-	struct strbuf tmp_renamed_log = STRBUF_INIT;
-	int log, ret;
-	struct strbuf err = STRBUF_INIT;
-
-	files_reflog_path(refs, &sb_oldref, oldrefname);
-	files_reflog_path(refs, &sb_newref, newrefname);
-	files_reflog_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
-
-	log = !lstat(sb_oldref.buf, &loginfo);
-	if (log && S_ISLNK(loginfo.st_mode)) {
-		ret = error("reflog for %s is a symlink", oldrefname);
-		goto out;
-	}
-
-	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
-				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				     &orig_oid, &flag)) {
-		ret = error("refname %s not found", oldrefname);
-		goto out;
-	}
-
-	if (flag & REF_ISSYMREF) {
-		if (copy)
-			ret = error("refname %s is a symbolic ref, copying it is not supported",
-				    oldrefname);
-		else
-			ret = error("refname %s is a symbolic ref, renaming it is not supported",
-				    oldrefname);
-		goto out;
-	}
-	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
-		ret = 1;
-		goto out;
-	}
-
-	if (!copy && log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
-		ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
-			    oldrefname, strerror(errno));
-		goto out;
-	}
-
-	if (copy && log && copy_file(refs->base.repo, tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
-		ret = error("unable to copy logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
-			    oldrefname, strerror(errno));
-		goto out;
-	}
-
-	if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
-			    &orig_oid, REF_NO_DEREF)) {
-		error("unable to delete old %s", oldrefname);
-		goto rollback;
-	}
-
-	/*
-	 * Since we are doing a shallow lookup, oid is not the
-	 * correct value to pass to delete_ref as old_oid. But that
-	 * doesn't matter, because an old_oid check wouldn't add to
-	 * the safety anyway; we want to delete the reference whatever
-	 * its current value.
-	 */
-	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname,
-					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-					     NULL, NULL) &&
-	    refs_delete_ref(&refs->base, NULL, newrefname,
-			    NULL, REF_NO_DEREF)) {
-		if (errno == EISDIR) {
-			struct strbuf path = STRBUF_INIT;
-			int result;
-
-			files_ref_path(refs, &path, newrefname);
-			result = remove_empty_directories(&path);
-			strbuf_release(&path);
-
-			if (result) {
-				error("Directory not empty: %s", newrefname);
-				goto rollback;
-			}
-		} else {
-			error("unable to delete existing %s", newrefname);
-			goto rollback;
-		}
-	}
-
-	if (log && rename_tmp_log(refs, newrefname))
-		goto rollback;
-
-	logmoved = log;
-
-	lock = lock_ref_oid_basic(refs, newrefname, &err);
-	if (!lock) {
-		if (copy)
-			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
-		else
-			error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
-		strbuf_release(&err);
-		goto rollback;
-	}
-	oidcpy(&lock->old_oid, &orig_oid);
-
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
-		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
-		strbuf_release(&err);
-		goto rollback;
-	}
-
-	ret = 0;
-	goto out;
-
- rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, &err);
-	if (!lock) {
-		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
-		strbuf_release(&err);
-		goto rollbacklog;
-	}
-
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, NULL, REF_SKIP_CREATE_REFLOG, &err)) {
-		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
-		strbuf_release(&err);
-	}
-
- rollbacklog:
-	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
-		error("unable to restore logfile %s from %s: %s",
-			oldrefname, newrefname, strerror(errno));
-	if (!logmoved && log &&
-	    rename(tmp_renamed_log.buf, sb_oldref.buf))
-		error("unable to restore logfile %s from logs/"TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
-	ret = 1;
- out:
-	strbuf_release(&sb_newref);
-	strbuf_release(&sb_oldref);
-	strbuf_release(&tmp_renamed_log);
-
-	return ret;
-}
-
-static int files_rename_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
-{
-	return files_copy_or_rename_ref(ref_store, oldrefname,
-				 newrefname, logmsg, 0);
-}
-
-static int files_copy_ref(struct ref_store *ref_store,
-			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
-{
-	return files_copy_or_rename_ref(ref_store, oldrefname,
-				 newrefname, logmsg, 1);
-}
-
 static int close_ref_gently(struct ref_lock *lock)
 {
 	if (close_lock_file_gently(&lock->lk))
@@ -2121,71 +1854,6 @@ static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *
 	return 0;
 }
 
-/*
- * Commit a change to a loose reference that has already been written
- * to the loose reference lockfile. Also update the reflogs if
- * necessary, using the specified lockmsg (which can be NULL).
- */
-static int commit_ref_update(struct files_ref_store *refs,
-			     struct ref_lock *lock,
-			     const struct object_id *oid, const char *logmsg,
-			     int flags,
-			     struct strbuf *err)
-{
-	files_assert_main_repository(refs, "commit_ref_update");
-
-	clear_loose_ref_cache(refs);
-	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid, oid, NULL,
-				logmsg, flags, err)) {
-		char *old_msg = strbuf_detach(err, NULL);
-		strbuf_addf(err, "cannot update the ref '%s': %s",
-			    lock->ref_name, old_msg);
-		free(old_msg);
-		unlock_ref(lock);
-		return -1;
-	}
-
-	if (strcmp(lock->ref_name, "HEAD") != 0) {
-		/*
-		 * Special hack: If a branch is updated directly and HEAD
-		 * points to it (may happen on the remote side of a push
-		 * for example) then logically the HEAD reflog should be
-		 * updated too.
-		 * A generic solution implies reverse symref information,
-		 * but finding all symrefs pointing to the given branch
-		 * would be rather costly for this rare event (the direct
-		 * update of a branch) to be worth it.  So let's cheat and
-		 * check with HEAD only which should cover 99% of all usage
-		 * scenarios (even 100% of the default ones).
-		 */
-		int head_flag;
-		const char *head_ref;
-
-		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
-						   RESOLVE_REF_READING,
-						   NULL, &head_flag);
-		if (head_ref && (head_flag & REF_ISSYMREF) &&
-		    !strcmp(head_ref, lock->ref_name)) {
-			struct strbuf log_err = STRBUF_INIT;
-			if (files_log_ref_write(refs, "HEAD", &lock->old_oid,
-						oid, NULL, logmsg, flags,
-						&log_err)) {
-				error("%s", log_err.buf);
-				strbuf_release(&log_err);
-			}
-		}
-	}
-
-	if (commit_ref(lock)) {
-		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
-		unlock_ref(lock);
-		return -1;
-	}
-
-	unlock_ref(lock);
-	return 0;
-}
-
 #if defined(NO_SYMLINK_HEAD) || defined(WITH_BREAKING_CHANGES)
 #define create_ref_symlink(a, b) (-1)
 #else
@@ -4471,8 +4139,6 @@ struct ref_storage_be refs_be_files = {
 
 	.optimize = files_optimize,
 	.optimize_required = files_optimize_required,
-	.rename_ref = files_rename_ref,
-	.copy_ref = files_copy_ref,
 
 	.iterator_begin = files_ref_iterator_begin,
 	.read_raw_ref = files_read_raw_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a73fc6aca7..364a912912 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2164,8 +2164,6 @@ struct ref_storage_be refs_be_packed = {
 	.optimize = packed_optimize,
 	.optimize_required = packed_optimize_required,
 
-	.rename_ref = NULL,
-	.copy_ref = NULL,
 
 	.iterator_begin = packed_ref_iterator_begin,
 	.read_raw_ref = packed_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2746ce5b49..c415ba0a4e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -470,13 +470,6 @@ typedef int optimize_required_fn(struct ref_store *ref_store,
 				 struct refs_optimize_opts *opts,
 				 bool *required);
 
-typedef int rename_ref_fn(struct ref_store *ref_store,
-			  const char *oldref, const char *newref,
-			  const char *logmsg);
-typedef int copy_ref_fn(struct ref_store *ref_store,
-			  const char *oldref, const char *newref,
-			  const char *logmsg);
-
 /*
  * Iterate over the references in `ref_store` whose names start with
  * `prefix`. `prefix` is matched as a literal string, without regard
@@ -596,8 +589,6 @@ struct ref_storage_be {
 
 	optimize_fn *optimize;
 	optimize_required_fn *optimize_required;
-	rename_ref_fn *rename_ref;
-	copy_ref_fn *copy_ref;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 72c1596c11..ef3bab69ee 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1798,290 +1798,6 @@ struct write_create_symref_arg {
 	const char *logmsg;
 };
 
-struct write_copy_arg {
-	struct reftable_ref_store *refs;
-	struct reftable_backend *be;
-	const char *oldname;
-	const char *newname;
-	const char *logmsg;
-	int delete_old;
-};
-
-static int write_copy_table(struct reftable_writer *writer, void *cb_data)
-{
-	struct write_copy_arg *arg = cb_data;
-	uint64_t deletion_ts, creation_ts;
-	struct reftable_ref_record old_ref = {0}, refs[2] = {0};
-	struct reftable_log_record old_log = {0}, *logs = NULL;
-	struct reftable_iterator it = {0};
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct ident_split committer_ident = {0};
-	struct strbuf errbuf = STRBUF_INIT;
-	size_t logs_nr = 0, logs_alloc = 0, i;
-	const char *committer_info;
-	int ret;
-
-	committer_info = git_committer_info(0);
-	if (split_ident_line(&committer_ident, committer_info, strlen(committer_info)))
-		BUG("failed splitting committer info");
-
-	if (reftable_stack_read_ref(arg->be->stack, arg->oldname, &old_ref)) {
-		ret = error(_("refname %s not found"), arg->oldname);
-		goto done;
-	}
-	if (old_ref.value_type == REFTABLE_REF_SYMREF) {
-		ret = error(_("refname %s is a symbolic ref, copying it is not supported"),
-			    arg->oldname);
-		goto done;
-	}
-
-	/*
-	 * There's nothing to do in case the old and new name are the same, so
-	 * we exit early in that case.
-	 */
-	if (!strcmp(arg->oldname, arg->newname)) {
-		ret = 0;
-		goto done;
-	}
-
-	/*
-	 * Verify that the new refname is available.
-	 */
-	if (arg->delete_old)
-		string_list_insert(&skip, arg->oldname);
-	ret = refs_verify_refname_available(&arg->refs->base, arg->newname,
-					    NULL, &skip, 0, &errbuf);
-	if (ret < 0) {
-		error("%s", errbuf.buf);
-		goto done;
-	}
-
-	/*
-	 * When deleting the old reference we have to use two update indices:
-	 * once to delete the old ref and its reflog, and once to create the
-	 * new ref and its reflog. They need to be staged with two separate
-	 * indices because the new reflog needs to encode both the deletion of
-	 * the old branch and the creation of the new branch, and we cannot do
-	 * two changes to a reflog in a single update.
-	 */
-	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->be->stack);
-	if (arg->delete_old)
-		creation_ts++;
-	ret = reftable_writer_set_limits(writer, deletion_ts, creation_ts);
-	if (ret < 0)
-		goto done;
-
-	/*
-	 * Add the new reference. If this is a rename then we also delete the
-	 * old reference.
-	 */
-	refs[0] = old_ref;
-	refs[0].refname = xstrdup(arg->newname);
-	refs[0].update_index = creation_ts;
-	if (arg->delete_old) {
-		refs[1].refname = xstrdup(arg->oldname);
-		refs[1].value_type = REFTABLE_REF_DELETION;
-		refs[1].update_index = deletion_ts;
-	}
-	ret = reftable_writer_add_refs(writer, refs, arg->delete_old ? 2 : 1);
-	if (ret < 0)
-		goto done;
-
-	/*
-	 * When deleting the old branch we need to create a reflog entry on the
-	 * new branch name that indicates that the old branch has been deleted
-	 * and then recreated. This is a tad weird, but matches what the files
-	 * backend does.
-	 */
-	if (arg->delete_old) {
-		struct strbuf head_referent = STRBUF_INIT;
-		struct object_id head_oid;
-		int append_head_reflog;
-		unsigned head_type = 0;
-
-		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-		fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-		logs[logs_nr].refname = xstrdup(arg->newname);
-		logs[logs_nr].update_index = deletion_ts;
-		logs[logs_nr].value.update.message =
-			xstrndup(arg->logmsg, reftable_be_write_options(arg->refs)->opts.block_size / 2);
-		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
-		logs_nr++;
-
-		ret = reftable_backend_read_ref(arg->be, "HEAD", &head_oid,
-						&head_referent, &head_type);
-		if (ret < 0)
-			goto done;
-		append_head_reflog = (head_type & REF_ISSYMREF) && !strcmp(head_referent.buf, arg->oldname);
-		strbuf_release(&head_referent);
-
-		/*
-		 * The files backend uses `refs_delete_ref()` to delete the old
-		 * branch name, which will append a reflog entry for HEAD in
-		 * case it points to the old branch.
-		 */
-		if (append_head_reflog) {
-			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-			logs[logs_nr] = logs[logs_nr - 1];
-			logs[logs_nr].refname = xstrdup("HEAD");
-			logs[logs_nr].value.update.name =
-				xstrdup(logs[logs_nr].value.update.name);
-			logs[logs_nr].value.update.email =
-				xstrdup(logs[logs_nr].value.update.email);
-			logs[logs_nr].value.update.message =
-				xstrdup(logs[logs_nr].value.update.message);
-			logs_nr++;
-		}
-	}
-
-	/*
-	 * Create the reflog entry for the newly created branch.
-	 */
-	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-	fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-	logs[logs_nr].refname = xstrdup(arg->newname);
-	logs[logs_nr].update_index = creation_ts;
-	logs[logs_nr].value.update.message =
-		xstrndup(arg->logmsg, reftable_be_write_options(arg->refs)->opts.block_size / 2);
-	memcpy(logs[logs_nr].value.update.new_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
-	logs_nr++;
-
-	/*
-	 * In addition to writing the reflog entry for the new branch, we also
-	 * copy over all log entries from the old reflog. Last but not least,
-	 * when renaming we also have to delete all the old reflog entries.
-	 */
-	ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
-	if (ret < 0)
-		goto done;
-
-	ret = reftable_iterator_seek_log(&it, arg->oldname);
-	if (ret < 0)
-		goto done;
-
-	while (1) {
-		ret = reftable_iterator_next_log(&it, &old_log);
-		if (ret < 0)
-			goto done;
-		if (ret > 0 || strcmp(old_log.refname, arg->oldname)) {
-			ret = 0;
-			break;
-		}
-		if (reftable_log_record_is_deletion(&old_log))
-			continue;
-
-		free(old_log.refname);
-
-		/*
-		 * Copy over the old reflog entry with the new refname.
-		 */
-		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-		logs[logs_nr] = old_log;
-		logs[logs_nr].refname = xstrdup(arg->newname);
-		logs_nr++;
-
-		/*
-		 * Delete the old reflog entry in case we are renaming.
-		 */
-		if (arg->delete_old) {
-			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-			memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-			logs[logs_nr].refname = xstrdup(arg->oldname);
-			logs[logs_nr].value_type = REFTABLE_LOG_DELETION;
-			logs[logs_nr].update_index = old_log.update_index;
-			logs_nr++;
-		}
-
-		/*
-		 * Transfer ownership of the log record we're iterating over to
-		 * the array of log records. Otherwise, the pointers would get
-		 * free'd or reallocated by the iterator.
-		 */
-		memset(&old_log, 0, sizeof(old_log));
-	}
-
-	ret = reftable_writer_add_logs(writer, logs, logs_nr);
-	if (ret < 0)
-		goto done;
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	reftable_iterator_destroy(&it);
-	string_list_clear(&skip, 0);
-	strbuf_release(&errbuf);
-	for (i = 0; i < logs_nr; i++)
-		reftable_log_record_release(&logs[i]);
-	free(logs);
-	for (i = 0; i < ARRAY_SIZE(refs); i++)
-		reftable_ref_record_release(&refs[i]);
-	reftable_ref_record_release(&old_ref);
-	reftable_log_record_release(&old_log);
-	return ret;
-}
-
-static int reftable_be_rename_ref(struct ref_store *ref_store,
-				  const char *oldrefname,
-				  const char *newrefname,
-				  const char *logmsg)
-{
-	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct write_copy_arg arg = {
-		.refs = refs,
-		.oldname = oldrefname,
-		.newname = newrefname,
-		.logmsg = logmsg,
-		.delete_old = 1,
-	};
-	int ret;
-
-	ret = refs->err;
-	if (ret < 0)
-		goto done;
-
-	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
-	if (ret)
-		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &reftable_be_write_options(refs)->opts);
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	return ret;
-}
-
-static int reftable_be_copy_ref(struct ref_store *ref_store,
-				const char *oldrefname,
-				const char *newrefname,
-				const char *logmsg)
-{
-	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct write_copy_arg arg = {
-		.refs = refs,
-		.oldname = oldrefname,
-		.newname = newrefname,
-		.logmsg = logmsg,
-	};
-	int ret;
-
-	ret = refs->err;
-	if (ret < 0)
-		goto done;
-
-	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
-	if (ret)
-		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &reftable_be_write_options(refs)->opts);
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	return ret;
-}
-
 struct reftable_reflog_iterator {
 	struct ref_iterator base;
 	struct reftable_ref_store *refs;
@@ -2909,9 +2625,6 @@ struct ref_storage_be refs_be_reftable = {
 	.optimize = reftable_be_optimize,
 	.optimize_required = reftable_be_optimize_required,
 
-	.rename_ref = reftable_be_rename_ref,
-	.copy_ref = reftable_be_copy_ref,
-
 	.iterator_begin = reftable_be_iterator_begin,
 	.read_raw_ref = reftable_be_read_raw_ref,
 	.read_symbolic_ref = reftable_be_read_symbolic_ref,
-- 
2.39.3 (Apple Git-146)

