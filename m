Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE83101CD
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381575; cv=none; b=eGfZ0o9Ru2WmIJhMv3G7/ZacaB1H3EpJxCvBD5a8ebqcs7zKx4x9G5NzJRwd7S2zuiTeyGho+INrKqRt7JhdfEoIr65PUILE5CVXhP89FdQbGPhQgaYz4EFbVcwDv3CmkQtlPS6wXdggKMLQRqHxFY23IHr5InQJNbel4OkHKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381575; c=relaxed/simple;
	bh=3pCKOrndKYcpKhXdmuFhzEhzeBpWS1JeYBdkf/0EjgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgqSL8pETTGSSgQpf8NSbtiQtpGidT8XnKPKRmRGkkHGSsW1P72N6D9yiYTs4+Rqd2uWJtzY4BiVmIieGEb0jNRAjT5Gp0RcUxKNfpt8vzZcTf+zOBmR5sdCaspcKAgRtmuLhgTT1K63LQBhHWEJc5WbD/DR7fD5bOTysqVIU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kczUV2wS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kczUV2wS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so28157265e9.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 14:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769381571; x=1769986371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+AjphCqtARZNmbi/9BZNLRp22WMU3kHV6Q4XQXfzZg=;
        b=kczUV2wSA7XZ5ZY4vlmeCQcUFwJImpfJ/PVqkHYkl7ZlSY556luIqsEkMzqwrw9jcC
         BheKklnP2JFFQ+GSRkuTmzypkx8R+ED/Pl62ZvAoqWX2f7EW1PsA8cVd/HTxs30ZOnVl
         jnUgbOR45bP7njoFxnHRF9yFeFEQFSUbLwR92fHFi584oDB8yBmCUeULTdCQtTxQbNbQ
         0VTa2MddanCtgBsy/IXvWgTtB543sZ8q7XRcLZga5ic2hoMoDEGR7oLrXXr9FqusT7Q1
         2OfcUAvioAUTQO6IhiKJISe3tIcDRQYwhMciXh+BpKi/p1NXtPteKRuqgd86AUtoyXa3
         PkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769381571; x=1769986371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p+AjphCqtARZNmbi/9BZNLRp22WMU3kHV6Q4XQXfzZg=;
        b=ieRBP+I6BjAr5oMPlxS5SXDU/NypvOce+Jmk1GD+tNP4vFC0F/sLd8RaSRJ2B7OfHo
         5KgFA+F+vexEZuZyxmlgBmoaZkZPaFnU1s3ThyUOEbuaZPFunm9L4bBhM0DXtXDbuvZU
         ZiAAX0DAmu/8WEsFQ+V0cLSgdSqOloPNVBF3xC/soWeHNL0qjCPSVmp2Q4pETiyHqBpG
         y9NlD2QZkvCHTHat/pAdumqX4Ib3TJm9z87FuGt3y8Yf9M/7OSPHjdw7jFi2doLCTr8R
         NCP/UTGyJpL8c8y8W7hZleh+xtiNv7Xc9m+gwABYL7FEO14CPdAEMc6ViVsJ629Gt7VX
         eKZA==
X-Gm-Message-State: AOJu0Yxbq8ngCX1mF4HUWizP/epow8c0mJeJZ5mPQwcViNc8UfcfpUh1
	e+sj6dzti47JZhWyZqO6sdUFIdV6AH+PKboq0RmLA9RaodhrKv2S4Wsxtud6Mw==
X-Gm-Gg: AZuq6aJyCprHPfhdHr/6Wo6j52yPor5EMel+wNKfso1AgL0FRB5hYB8Qz0AZWZ0W95k
	gBdVp7TazDC5ioXJKtKkeTPp+dHvPwCiDGMSG1iET8XotwIbQ1zv08q1o9nqWYaufIrq+S4cP+S
	YBtE7izZ5tDFOPmC70CQvaqVYLPQ6WTA+nFQPqS69fkl2W7dNmBUEK0nfkg7bhASfvcs4o6uNAA
	pTSVLY2WzSWBWYNtglDj7xIob2+P3nV2FNeeWUtmGJ5DLk7GMvEuazd+9R5S7AIpxHcWHXqdi1I
	x4JfywUF66iBV355P/kqg/n+Uq4q13BevltMsFs2+l+QEUxsVeyjNd9bP3f6xGHemmdtHA68swj
	mur5pR2y5lPNJCsb/zIZqgUqsVaFTn+qgmRXra6FA5IiheMt5I9VIZgPUqXUcH8JB6aaqR7twlB
	v/SD9tNq1LMOW4MljpBw==
X-Received: by 2002:a05:600c:4e56:b0:47b:deb9:15fb with SMTP id 5b1f17b1804b1-480628348c6mr4445885e9.33.1769381571179;
        Sun, 25 Jan 2026 14:52:51 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ba14:1b51:e353:2193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm425263545e9.2.2026.01.25.14.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:52:50 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 25 Jan 2026 23:52:41 +0100
Subject: [PATCH v5 6/6] fetch: delay user information post committing of
 transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-6-d58f3a9edf98@gmail.com>
References: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
In-Reply-To: <20260125-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v5-0-d58f3a9edf98@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net, newren@gmail.com, gitster@pobox.com, 
 phillip.wood123@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19159;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=3pCKOrndKYcpKhXdmuFhzEhzeBpWS1JeYBdkf/0EjgM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGl2nrn4/WbHbbF1SCaIz1E2SkDgo0t10cVph
 fD8jJXMLZ+PQIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpdp65AAoJED7VnySO
 Rox/G04MAIZCZjFfJb+MhqmZvyh41B4h9Z0mS0zM1Iv8gRuZcUj99DbUFynkw+X1LZT5a0+17K3
 wdb1XFDRZMMfB0KUiLR98HO+py8GUNUfeUPMJL+hVFymxdz37s4aBX54xX2ar1ICF1YtwWtXOek
 uibwZayAiIFWTKbCzGLW6p5vBpIDgWy7gIKdBCSqHQS/2Asa8Vt4tKTm4nomR57YNMm9Ojdna5g
 tWAnhv4DAnmLFzrEQD9FKypDJScn/PY9hA2CWU1rZtpNt0mIkGjMjh4OyYoVX6SuQL3q8Jr6H4Z
 KOfz9cGktdzs33Zft4P43YafoOuGVjtw2mYi8Fvkmeko5k4pmmFkjCIQx7xzdlOWeVB4Q25MNFE
 71qNS492sbddsoqJFyiQ7ZVXb1Pom0rsgyetfXvijGpj9/TASpgtjzN+ma2razj6iHwxNtAgh3a
 l9hlNyuqb91IsuiAPYfHBpmaRTC0USFG9tIE6c/vkwW3TCpVtgvi8JISVwtXOp9wV7Xlq7Rddy6
 ys=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In Git 2.50 and earlier, we would display failure codes and error
message as part of the status display:

  $ git fetch . v1.0.0:refs/heads/foo
    error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'
    From .
     ! [new tag]               v1.0.0     -> foo  (unable to update local ref)

With the addition of batched updates, this information is no longer
shown to the user:

  $ git fetch . v1.0.0:refs/heads/foo
    From .
     * [new tag]               v1.0.0     -> foo
    error: cannot update ref 'refs/heads/foo': trying to write non-commit object f665776185ad074b236c00751d666da7d1977dbe to branch 'refs/heads/foo'

Since reference updates are batched and processed together at the end,
information around the outcome is not available during individual
reference parsing.

To overcome this, collate and delay the output to the end. Introduce
`ref_update_display_info` which will hold individual update's
information and also whether the update failed or succeeded. This
finally allows us to iterate over all such updates and print them to the
user.

Using an dynamic array and strmap does add some overhead to
'git-fetch(1)', but from benchmarking this seems to be not too bad:

  Benchmark 1: fetch: many refs (refformat = files, refcount = 1000, revision = master)
    Time (mean ± σ):      42.6 ms ±   1.2 ms    [User: 13.1 ms, System: 29.8 ms]
    Range (min … max):    40.1 ms …  45.8 ms    47 runs

  Benchmark 2: fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)
    Time (mean ± σ):      43.1 ms ±   1.2 ms    [User: 12.7 ms, System: 30.7 ms]
    Range (min … max):    40.5 ms …  45.8 ms    48 runs

  Summary
    fetch: many refs (refformat = files, refcount = 1000, revision = master) ran
      1.01 ± 0.04 times faster than fetch: many refs (refformat = files, refcount = 1000, revision = HEAD)

Another approach would be to move the status printing logic to be
handled post the transaction being committed. That however would require
adding an iterator to the ref transaction that tracks both the outcome
(success/failure) and the original refspec information for each update,
which is more involved infrastructure work compared to the strmap
approach here.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c       | 246 +++++++++++++++++++++++++++++++++++++++-----------
 t/t5516-fetch-push.sh |   1 +
 2 files changed, 193 insertions(+), 54 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 49495be0b6..a3bc7e9380 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -861,12 +861,87 @@ static void display_ref_update(struct display_state *display_state, char code,
 	fputs(display_state->buf.buf, f);
 }
 
+struct ref_update_display_info {
+	bool failed;
+	char success_code;
+	char fail_code;
+	char *summary;
+	char *fail_detail;
+	char *success_detail;
+	char *ref;
+	char *remote;
+	struct object_id old_oid;
+	struct object_id new_oid;
+};
+
+struct ref_update_display_info_array {
+	struct ref_update_display_info *info;
+	size_t alloc, nr;
+};
+
+static struct ref_update_display_info *ref_update_display_info_append(
+					   struct ref_update_display_info_array *array,
+					   char success_code,
+					   char fail_code,
+					   const char *summary,
+					   const char *success_detail,
+					   const char *fail_detail,
+					   const char *ref,
+					   const char *remote,
+					   const struct object_id *old_oid,
+					   const struct object_id *new_oid)
+{
+	struct ref_update_display_info *info;
+
+	ALLOC_GROW(array->info, array->nr + 1, array->alloc);
+	info = &array->info[array->nr++];
+
+	info->failed = false;
+	info->success_code = success_code;
+	info->fail_code = fail_code;
+	info->summary = xstrdup(summary);
+	info->success_detail = xstrdup_or_null(success_detail);
+	info->fail_detail = xstrdup_or_null(fail_detail);
+	info->remote = xstrdup(remote);
+	info->ref = xstrdup(ref);
+
+	oidcpy(&info->old_oid, old_oid);
+	oidcpy(&info->new_oid, new_oid);
+
+	return info;
+}
+
+static void ref_update_display_info_set_failed(struct ref_update_display_info *info)
+{
+	info->failed = true;
+}
+
+static void ref_update_display_info_free(struct ref_update_display_info *info)
+{
+	free(info->summary);
+	free(info->success_detail);
+	free(info->fail_detail);
+	free(info->remote);
+	free(info->ref);
+}
+
+static void ref_update_display_info_display(struct ref_update_display_info *info,
+					    struct display_state *display_state,
+					    int summary_width)
+{
+	display_ref_update(display_state,
+			   info->failed ? info->fail_code : info->success_code,
+			   info->summary,
+			   info->failed ? info->fail_detail : info->success_detail,
+			   info->remote, info->ref, &info->old_oid,
+			   &info->new_oid, summary_width);
+}
+
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
-			    struct display_state *display_state,
 			    const struct ref *remote_ref,
-			    int summary_width,
-			    const struct fetch_config *config)
+			    const struct fetch_config *config,
+			    struct ref_update_display_info_array *display_array)
 {
 	struct commit *current = NULL, *updated;
 	int fast_forward = 0;
@@ -877,41 +952,56 @@ static int update_local_ref(struct ref *ref,
 
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			display_ref_update(display_state, '=', _("[up to date]"), NULL,
-					   remote_ref->name, ref->name,
-					   &ref->old_oid, &ref->new_oid, summary_width);
+			ref_update_display_info_append(display_array, '=', '=',
+						       _("[up to date]"), NULL,
+						       NULL, ref->name,
+						       remote_ref->name, &ref->old_oid,
+						       &ref->new_oid);
 		return 0;
 	}
 
 	if (!update_head_ok &&
 	    !is_null_oid(&ref->old_oid) &&
 	    branch_checked_out(ref->name)) {
+		struct ref_update_display_info *info;
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		display_ref_update(display_state, '!', _("[rejected]"),
-				   _("can't fetch into checked-out branch"),
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+		info = ref_update_display_info_append(display_array, '!', '!',
+						      _("[rejected]"), NULL,
+						      _("can't fetch into checked-out branch"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+		ref_update_display_info_set_failed(info);
 		return 1;
 	}
 
 	if (!is_null_oid(&ref->old_oid) &&
 	    starts_with(ref->name, "refs/tags/")) {
+		struct ref_update_display_info *info;
+
 		if (force || ref->force) {
 			int r;
+
 			r = s_update_ref("updating tag", ref, transaction, 0);
-			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
-					   r ? _("unable to update local ref") : NULL,
-					   remote_ref->name, ref->name,
-					   &ref->old_oid, &ref->new_oid, summary_width);
+
+			info = ref_update_display_info_append(display_array, 't', '!',
+							      _("[tag update]"), NULL,
+							      _("unable to update local ref"),
+							      ref->name, remote_ref->name,
+							      &ref->old_oid, &ref->new_oid);
+			if (r)
+				ref_update_display_info_set_failed(info);
+
 			return r;
 		} else {
-			display_ref_update(display_state, '!', _("[rejected]"),
-					   _("would clobber existing tag"),
-					   remote_ref->name, ref->name,
-					   &ref->old_oid, &ref->new_oid, summary_width);
+			info = ref_update_display_info_append(display_array, '!', '!',
+							      _("[rejected]"), NULL,
+							      _("would clobber existing tag"),
+							      ref->name, remote_ref->name,
+							      &ref->old_oid, &ref->new_oid);
+			ref_update_display_info_set_failed(info);
 			return 1;
 		}
 	}
@@ -921,6 +1011,7 @@ static int update_local_ref(struct ref *ref,
 	updated = lookup_commit_reference_gently(the_repository,
 						 &ref->new_oid, 1);
 	if (!current || !updated) {
+		struct ref_update_display_info *info;
 		const char *msg;
 		const char *what;
 		int r;
@@ -941,10 +1032,15 @@ static int update_local_ref(struct ref *ref,
 		}
 
 		r = s_update_ref(msg, ref, transaction, 0);
-		display_ref_update(display_state, r ? '!' : '*', what,
-				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_append(display_array, '*', '!',
+						      what, NULL,
+						      _("unable to update local ref"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+		if (r)
+			ref_update_display_info_set_failed(info);
+
 		return r;
 	}
 
@@ -960,6 +1056,7 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (fast_forward) {
+		struct ref_update_display_info *info;
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
 
@@ -967,29 +1064,46 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r = s_update_ref("fast-forward", ref, transaction, 1);
-		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
-				   r ? _("unable to update local ref") : NULL,
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_append(display_array, ' ', '!',
+						      quickref.buf, NULL,
+						      _("unable to update local ref"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+		if (r)
+			ref_update_display_info_set_failed(info);
+
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
+		struct ref_update_display_info *info;
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
+
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r = s_update_ref("forced-update", ref, transaction, 1);
-		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
-				   r ? _("unable to update local ref") : _("forced update"),
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+
+		info = ref_update_display_info_append(display_array, '+', '!',
+						      quickref.buf, _("forced update"),
+						      _("unable to update local ref"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+
+		if (r)
+			ref_update_display_info_set_failed(info);
+
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forward"),
-				   remote_ref->name, ref->name,
-				   &ref->old_oid, &ref->new_oid, summary_width);
+		struct ref_update_display_info *info;
+		info = ref_update_display_info_append(display_array, '!', '!',
+						      _("[rejected]"), NULL,
+						      _("non-fast-forward"),
+						      ref->name, remote_ref->name,
+						      &ref->old_oid, &ref->new_oid);
+		ref_update_display_info_set_failed(info);
 		return 1;
 	}
 }
@@ -1103,17 +1217,14 @@ static int store_updated_refs(struct display_state *display_state,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
 			      struct fetch_head *fetch_head,
-			      const struct fetch_config *config)
+			      const struct fetch_config *config,
+			      struct ref_update_display_info_array *display_array)
 {
 	int rc = 0;
 	struct strbuf note = STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
 	int want_status;
-	int summary_width = 0;
-
-	if (verbosity >= 0)
-		summary_width = transport_summary_width(ref_map);
 
 	if (!connectivity_checked) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
@@ -1218,8 +1329,8 @@ static int store_updated_refs(struct display_state *display_state,
 					  display_state->url_len);
 
 			if (ref) {
-				rc |= update_local_ref(ref, transaction, display_state,
-						       rm, summary_width, config);
+				rc |= update_local_ref(ref, transaction, rm,
+						       config, display_array);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1227,12 +1338,12 @@ static int store_updated_refs(struct display_state *display_state,
 				 * would be written to FETCH_HEAD, if --dry-run
 				 * is set).
 				 */
-				display_ref_update(display_state, '*',
-						   *kind ? kind : "branch", NULL,
-						   rm->name,
-						   "FETCH_HEAD",
-						   &rm->new_oid, &rm->old_oid,
-						   summary_width);
+
+				ref_update_display_info_append(display_array, '*', '*',
+							       *kind ? kind : "branch",
+							       NULL, NULL, "FETCH_HEAD",
+							       rm->name, &rm->new_oid,
+							       &rm->old_oid);
 			}
 		}
 	}
@@ -1300,7 +1411,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
 				  struct ref_transaction *transaction,
 				  struct ref *ref_map,
 				  struct fetch_head *fetch_head,
-				  const struct fetch_config *config)
+				  const struct fetch_config *config,
+				  struct ref_update_display_info_array *display_array)
 {
 	int connectivity_checked = 1;
 	int ret;
@@ -1322,7 +1434,8 @@ static int fetch_and_consume_refs(struct display_state *display_state,
 
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret = store_updated_refs(display_state, connectivity_checked,
-				 transaction, ref_map, fetch_head, config);
+				 transaction, ref_map, fetch_head, config,
+				 display_array);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
 
 out:
@@ -1493,7 +1606,8 @@ static int backfill_tags(struct display_state *display_state,
 			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head,
-			 const struct fetch_config *config)
+			 const struct fetch_config *config,
+			 struct ref_update_display_info_array *display_array)
 {
 	int retcode, cannot_reuse;
 
@@ -1515,7 +1629,7 @@ static int backfill_tags(struct display_state *display_state,
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
 	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
-					 fetch_head, config);
+					 fetch_head, config, display_array);
 
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1641,6 +1755,7 @@ struct ref_rejection_data {
 	bool conflict_msg_shown;
 	bool case_sensitive_msg_shown;
 	const char *remote_name;
+	struct strmap *rejected_refs;
 };
 
 static void ref_transaction_rejection_handler(const char *refname,
@@ -1681,6 +1796,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 			      refname, ref_transaction_error_msg(err));
 	}
 
+	strmap_put(data->rejected_refs, refname, NULL);
 	*data->retcode = 1;
 }
 
@@ -1690,6 +1806,7 @@ static void ref_transaction_rejection_handler(const char *refname,
  */
 static int commit_ref_transaction(struct ref_transaction **transaction,
 				  bool is_atomic, const char *remote_name,
+				  struct strmap *rejected_refs,
 				  struct strbuf *err)
 {
 	int retcode = ref_transaction_commit(*transaction, err);
@@ -1701,6 +1818,7 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
 			.conflict_msg_shown = 0,
 			.remote_name = remote_name,
 			.retcode = &retcode,
+			.rejected_refs = rejected_refs,
 		};
 
 		ref_transaction_for_each_rejected_update(*transaction,
@@ -1729,6 +1847,9 @@ static int do_fetch(struct transport *transport,
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
 	int do_set_head = 0;
+	struct ref_update_display_info_array display_array = { 0 };
+	struct strmap rejected_refs = STRMAP_INIT;
+	int summary_width = 0;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1853,7 +1974,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
-				   &fetch_head, config)) {
+				   &fetch_head, config, &display_array)) {
 		retcode = 1;
 		goto cleanup;
 	}
@@ -1876,7 +1997,7 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config))
+					  &fetch_head, config, &display_array))
 				retcode = 1;
 		}
 
@@ -1886,8 +2007,12 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
+	if (verbosity >= 0)
+		summary_width = transport_summary_width(ref_map);
+
 	retcode = commit_ref_transaction(&transaction, atomic_fetch,
-					 transport->remote->name, &err);
+					 transport->remote->name,
+					 &rejected_refs, &err);
 	/*
 	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
 	 * continue to fetch head and perform other post-fetch operations.
@@ -1965,7 +2090,17 @@ static int do_fetch(struct transport *transport,
 	 */
 	if (retcode && !atomic_fetch && transaction)
 		commit_ref_transaction(&transaction, false,
-				       transport->remote->name, &err);
+				       transport->remote->name,
+				       &rejected_refs, &err);
+
+	for (size_t i = 0; i < display_array.nr; i++) {
+		struct ref_update_display_info *info = &display_array.info[i];
+
+		if (!info->failed && strmap_contains(&rejected_refs, info->ref))
+			ref_update_display_info_set_failed(info);
+		ref_update_display_info_display(info, &display_state, summary_width);
+		ref_update_display_info_free(info);
+	}
 
 	if (retcode) {
 		if (err.len) {
@@ -1980,6 +2115,9 @@ static int do_fetch(struct transport *transport,
 
 	if (transaction)
 		ref_transaction_free(transaction);
+
+	free(display_array.info);
+	strmap_clear(&rejected_refs, 0);
 	display_state_release(&display_state);
 	close_fetch_head(&fetch_head);
 	strbuf_release(&err);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 45595991c8..29e2f17608 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1893,6 +1893,7 @@ test_expect_success 'pushing non-commit objects should report error' '
 
 		tagsha=$(git rev-parse test^{tag}) &&
 		test_must_fail git push ../dest "$tagsha:refs/heads/branch" 2>err &&
+		test_grep "! \[remote rejected\] $tagsha -> branch (invalid new value provided)" err &&
 		test_grep "trying to write non-commit object $tagsha to branch ${SQ}refs/heads/branch${SQ}" err
 	)
 '

-- 
2.52.0

