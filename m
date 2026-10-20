Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509660;
	b=Rvsmz8EsN2iP7WIj9pCCIOce+UMOuE4gnBo2gliGMhLVunvgh49azySw9PWTJnihHM67
	 gFhraWOw/mdblVKD7LPNJL7yjZ0jl9I/UlaNb/p8TSixDjbROnHXC1ZPO7JziJlpJ9KCm
	 ewSnuH1M60oL6GZSZRMhk5JVLEPW6bggcAGGYRkEigCmmgSxy/h7mLEFifUdVAG6mVu2b
	 5APgZRs4+JN1n1Du8KjkYLUAfuJxhP9BRLMjgRCry9D7XhFyJqXNtNSziWnqY03TA5V5T
	 rEhQBw05B3EXgRdEyCDARRebkKpQ2+IPeG6mmPmtRcLTsmct0HA+h6VTPdCD/tul/VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JgkTtrYPgcoDvRB7x1eCtbqluwwPk99e41S7ZikhXoo=;
	b=MXFDVb9UCc79OcZZ5WOuUcyUOTpDyy48lvgKI95zaGWPpaBzpra0kzMlYIIIQhaUas8l
	 dSDi4iVN4yQyrcXcIaVeapxMM25O69yMX57+b1ex/4hWSdFDz8XXhl8uFVcEgav+fTifK
	 rpZbibwqtCbagaHstMVm9HOx+mPovKzAzGDYMVfSJ2ODSG5+MT0t2fyajtkFfv5vUyTmC
	 vyYV4JdOoRgyfFUYcgUgrhp0BWCYnmrSkfB6Ge7m/PQeJpPL23CXtaK1+LsBC0ts3em0p
	 7XO7Av9rjMpYcRVxbr5WSYCZ9eYqTMduKbBcI+BU18Aq/v/r1eme//MU2O6yVRoXr+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PY2QHYKi;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDE606A31E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECDE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PY2QHYKi
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so760065f8f.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509658; x=1793114458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JgkTtrYPgcoDvRB7x1eCtbqluwwPk99e41S7ZikhXoo=;
        b=PY2QHYKiomIDcOQiyYEDrQw0rSqH9NOmoDf1DpMXwSEHBShvWdyRbQW/3jktIgyp1m
         9ChtYGqDQOcoHKv21+ineKMXqfxw2OjE7h+OA0IBx9waX9CSj6/WuiFiz8OFNbZJ9ylr
         hwUUZvLUCzJZCQm+YK6fZ9hY0fn+W1LcRuPpIHp9w6KLTkyq6msBBe27piOw37E093G7
         eeyzMhkVMO/T54uUfuNRrBG4sjaOsGcX3NDf8eiPgxpLYPpOjUq4lAjC/dmLYSVLUe68
         a0+nbOA/sLAdbH+knrhzBAHxW7FlQeHhug0jVJVYaDDnxE2lGOPCZsVEyGA/fr3w14ff
         4IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509658; x=1793114458;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgkTtrYPgcoDvRB7x1eCtbqluwwPk99e41S7ZikhXoo=;
        b=sMcwxv3GkZPl2MUSMPzlspBjv3BJqxiEwRmPz2lvQXezADJyxyJasRs5UeCz0ftynJ
         yl7QqcobVr4Hi++E6sF6JoBbH+NGZjpU7jjD6H2g4+yHV88CgbijKbkIPleNOyPJhY3O
         bEGwiRaPLJSHKLGl3F4zDJLQVEuuHPUjgXAtSqEDM5COpJ1ynvwsTm0BtVkUenXa+H8a
         q2BV1KM9LnoAyS0/p445jLvHzparl0N8jL9Qz2D6GYYa79CAvHcB2P5YQcLqFPWzA2Cm
         iE5NVvNS4FxJcIV36JgOwyG3+0Z4CoF12hd6p5aEvp7+esmhru50tNfim7gQacd4xTin
         jrDA==
X-Gm-Message-State: AFq9FYKBZFo5ibagRN95yS5XqcnZAEp4hntcvXY7TIohr7s3ouH2yGgu
	KRCDChvy3pXvDBQEWBZpcaDgpX48P+68AtgLzCvd4y0tKA9I7i6SKJQ2ZM6zVg==
X-Gm-Gg: AYBFou0lp1mBslzCc9G0OvnxmFbCLiklF1hwZgHJe2JyvPwxddWblY00/ctxOOAOsmL
	y4KEpv7bJsBA/cMbIitB0fBqdw+6DT/X/XQdyEMCixEEwdtEE2V4xzpbp9Tz1RJjTGHpy/dugoy
	2BNx2VBPurf3pYBG30AyTJhJOxqeEUDFQMdIbub6S1L6A5JYf4p+L9NQykpgWC3tdttjunw1sOf
	xLNVKUvPTdBMdZBDYFAGJHZyP6jVOLJF71VLHC5muyFDXzluSfAZXk1l+3SbwkIGibzGZS/BHh4
	i73XFuYlMClBVpjXnPJEqQvVgL24maKXxYFSoTPiRv20yoRN0KAmDdZafT+JEQDQFnbdxeUByjt
	9HyIp4iBA7QjG7EJVtfre95TSWYTJRPTce4rVd2rwQPYo6ydYFXbf98M/K1+ZIZQxowFguuirVM
	LI33mWv2a3QMCdLo9czxAdkPM6CXOm2urVFZ65YxAztTLv8nzdcQnSacFm8rka7FQAch5YStAga
	xGL8I5bNyN6
X-Received: by 2002:a05:6000:4106:b0:48e:6f:19b2 with SMTP id ffacd0b85a97d-48e1e7f3aa7mr5177115f8f.25.1792509657451;
        Tue, 20 Oct 2026 08:20:57 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm6307355f8f.38.2026.10.20.08.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:20:56 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/7] stash: use an enum for create status
Date: Tue, 20 Oct 2026 16:20:36 +0100
Message-ID: <9e27bcd676ee763ed499fb337b1497f3fe2405b2.1792509606.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792509606.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792509606.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Change the return type of do_create_stash() to an enum in preparation
for adding a separate value for "there are no changes to stash" in a
future commit. There is a small change to behavior here which fixes
an anomaly with the exit status of create_stash(). That function calls
check_changes() without refreshing the index and exits 0 if there are
no changes. However, because it does not refresh the index, that check
is unreliable which means do_create_stash() can return 1 when there
aren't any changes, and then create_stash() exits 1 rather than 0.
This commit fixes that anomaly.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 83 ++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b..3e50ccfb40 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1336,16 +1336,23 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	return ret;
 }
 
-static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
-			int quiet)
+enum create_result {
+	CREATE_ERROR = -1,
+	CREATE_SUCCESS,
+	/* No changes were stashed */
+	CREATE_EMPTY,
+};
+
+static enum create_result stash_staged(struct stash_info *info,
+				  struct strbuf *out_patch, int quiet)
 {
-	int ret = 0;
+	enum create_result ret = 0;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 
 	if (write_index_as_tree(&info->w_tree, &istate, the_repository->index_file,
 				0, NULL)) {
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
@@ -1354,26 +1361,26 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
 		     "--no-color",
 		     "-U1", "HEAD", oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
 	if (!out_patch->len) {
 		if (!quiet)
 			fprintf_ln(stderr, _("No staged changes"));
-		ret = 1;
+		ret = CREATE_EMPTY;
 	}
 
 done:
 	release_index(&istate);
 	return ret;
 }
 
-static int stash_patch(struct stash_info *info, const struct pathspec *ps,
-		       struct strbuf *out_patch, int quiet,
-		       struct interactive_options *interactive_opts)
+static enum create_result stash_patch(struct stash_info *info,
+		const struct pathspec *ps, struct strbuf *out_patch, int quiet,
+		struct interactive_options *interactive_opts)
 {
-	int ret = 0;
+	enum create_result ret = 0;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
 	struct commit *head_commit;
 	const struct object_id *head_tree;
@@ -1384,17 +1391,17 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 
 	head_commit = lookup_commit(the_repository, &info->b_commit);
 	if (!head_commit || repo_parse_commit(the_repository, head_commit)) {
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 	head_tree = get_commit_tree_oid(head_commit);
 	if (!head_tree) {
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
 	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
@@ -1416,7 +1423,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	/* State of the working tree. */
 	if (write_index_as_tree(&info->w_tree, &istate, stash_index_path.buf, 0,
 				NULL)) {
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
@@ -1425,14 +1432,14 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 		     "--no-color",
 		     oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
 	if (!out_patch->len) {
 		if (!quiet)
 			fprintf_ln(stderr, _("No changes selected"));
-		ret = 1;
+		ret = CREATE_EMPTY;
 	}
 
 done:
@@ -1499,13 +1506,13 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	return ret;
 }
 
-static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
-			   int include_untracked, int patch_mode,
-			   struct interactive_options *interactive_opts,
-			   int only_staged, struct stash_info *info, struct strbuf *patch,
-			   int quiet)
+static enum create_result do_create_stash(const struct pathspec *ps,
+		struct strbuf *stash_msg_buf, int include_untracked,
+		int patch_mode, struct interactive_options *interactive_opts,
+		int only_staged, struct stash_info *info, struct strbuf *patch,
+		int quiet)
 {
-	int ret = 0;
+	enum create_result ret = 0;
 	int flags = 0;
 	int untracked_commit_option = 0;
 	const char *head_short_sha1 = NULL;
@@ -1531,14 +1538,14 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		if (!quiet)
 			fprintf_ln(stderr, _("You do not have "
 					     "the initial commit yet"));
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	} else {
 		head_commit = lookup_commit(the_repository, &info->b_commit);
 	}
 
 	if (!check_changes(ps, include_untracked, &untracked_files)) {
-		ret = 1;
+		ret = CREATE_EMPTY;
 		goto done;
 	}
 
@@ -1565,7 +1572,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot save the current "
 					     "index state"));
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
@@ -1577,37 +1584,37 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save "
 						     "the untracked files"));
-			ret = -1;
+			ret = CREATE_ERROR;
 			goto done;
 		}
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
 		ret = stash_patch(info, ps, patch, quiet, interactive_opts);
-		if (ret < 0) {
+		if (ret == CREATE_ERROR) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
 						     "worktree state"));
 			goto done;
-		} else if (ret > 0) {
+		} else if (ret != CREATE_SUCCESS) {
 			goto done;
 		}
 	} else if (only_staged) {
 		ret = stash_staged(info, patch, quiet);
-		if (ret < 0) {
+		if (ret == CREATE_ERROR) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
 						     "staged state"));
 			goto done;
-		} else if (ret > 0) {
+		} else if (ret != CREATE_SUCCESS) {
 			goto done;
 		}
 	} else {
 		if (stash_working_tree(info, ps)) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
 						     "worktree state"));
-			ret = -1;
+			ret = CREATE_ERROR;
 			goto done;
 		}
 	}
@@ -1630,7 +1637,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot record "
 					     "working tree state"));
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
@@ -1660,12 +1667,13 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 
 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 			      NULL, 0);
-	if (!ret)
+	if (ret == CREATE_SUCCESS)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
-	return ret;
+	/* Do not return an error if there are no changes */
+	return ret == CREATE_ERROR ? -1 : 0;
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
@@ -1674,6 +1682,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			 int include_untracked, int only_staged)
 {
 	int ret = 0;
+	enum create_result create_res;
 	struct stash_info info = STASH_INFO_INIT;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
@@ -1741,8 +1750,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
-			    interactive_opts, only_staged, &info, &patch, quiet)) {
+	create_res =  do_create_stash(ps, &stash_msg_buf, include_untracked,
+				      patch_mode, interactive_opts, only_staged,
+				      &info, &patch, quiet);
+	if (create_res != CREATE_SUCCESS) {
 		ret = -1;
 		goto done;
 	}
-- 
2.56.0.134.g299a3c16181

