Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767830;
	b=HUuE0eccWaIY63711kJsImp5JjW0tcPQI46NNxHjs2x0hlR/JpQjVaevHV2IsXf6QmFE
	 1E7wpjzAfD2WWbMk0bQVK5RjDhDakm06oXIp2wSLuYS5SShIziqgpdWKTsvn1gctLX/So
	 T+q8BoLmjKfsSAdeSLUsambazFNTRf+V5bcXXGR0zQFLImSNn2sO1H8sJi+f4eT2j/3+p
	 FT4ClOERxRGxQfynu4Do0FcD4e7WB5D0rNy63tXOxWGP1JuWQ1rwszDtlrqqmDoY2+8iW
	 lEBvz/EDJfamTkcn8D9lA+Hc0sJP4q7uJHDld6o9KVHt+cGBJDOkGTwc7eJOS+caSMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4/9XzoNxa23PYqy9ghjMVPDsYieMXanv/E11jjrgUTs=;
	b=hIL1h5O8GL0geuOXNDZpDiEAYg6oL18XkhTVVEoxh4mx/ZJ2hS8u9DsuW651ojiut1nc
	 9X4AoThlZ7YwcHebRElU+J6koMe85SW/f7oaA6Na8UpYQnpWapi67ELQAeDVUyh4GuHfq
	 w6/WhK8ZIhVuzoA+1OjL6IQNtLljzrmOqKzbXcxtHpX8XlqLpgHKwnDU0dRKjubyRiLhD
	 kNwc9gxUkxl1t2VosS6L+cMf8MMVHVb8xkdmnMPwAjFQkfM05Zxzk+FPP1flFCPnNRMrl
	 U6BzgdVbRMAW6jCPWWXL7YJxaoTYzV6Qc2nYXZCZ6tPAk54xsSUx+O4L88HLhhfSAog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HU0p0B2V;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880A606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E880A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HU0p0B2V
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso705778f8f.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767828; x=1793372628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4/9XzoNxa23PYqy9ghjMVPDsYieMXanv/E11jjrgUTs=;
        b=HU0p0B2VrR+p/aDFhiYfzOuAoCBDVQJJdFiIOKIOS/IQrF9Sm4cjFb44W2eJVkWdhT
         9NpJNk/plvBQiJjfEWA1UW0VMLyjk7DmNyqcW+FPVSbV59Vt+0phMcTMnh4Q8L6KK18S
         lrJhbK9S9IltBPxO2WwWGHj00ZosfpacdMKI2juTRujR6I/qhVTGxzYbkC0+Rg5xoelo
         mv4UrhpHIFLnjhpyI08Kn7DOTQmoZ8NNaPeDEGYzFH6pgUKc81ZMFC1QdmtRdQIIJdCI
         CvNbYCilbugBCO2rzFHWdjK9q3oSawER92P4Vi7yi34T1L3UCCEZX3MlAg82oHCsJJAl
         yJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767828; x=1793372628;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4/9XzoNxa23PYqy9ghjMVPDsYieMXanv/E11jjrgUTs=;
        b=NVCOjoqCevAoaLO9HJXf5eh7L07LqjI36SrsLWUXv2+nrgVSTduCPfaK4WGxv2TlPa
         Ffz7y++U7kTcaHMfjFXrWYchYD2+aWfsfIiIgu8Oi28xC3CdfuMiuOtjl+oiDKy2xjtM
         LqLv1GXMmRIym1pPwpOz/xZ6HKqr6YKgCGPQqhnnOmd73P96Ndxo1t3yu4mdM3kVRy+o
         1QzjvdbAOdr56MJGWJjfyks7MHofGHXnSi5cuyigzrxbEYrXyKLmd0SjFGcQcd3LTPii
         qIdMd/3mlHRE3koAvxt9V3w6uKEvHj5Ej0Mib69k8hTyUxA0xiDrEVeyqjYgiULLz1I9
         cf1Q==
X-Gm-Message-State: AFq9FYKM46KSvLxM47EALUQC2QmWPFF2PpDWgUmDXywG8hYD6U1n2LLm
	e+7SugO5ANPer6FEiAmFZ5Ir9WtTU0ep6fKkZX7sN72Xb0SgEDgYjrueIky3lg==
X-Gm-Gg: AYBFou1AbQKPnCBs2sk5zPeEwqOjF+lfEjaGkMp0sdfm+fYhq96hKpbSVJh6Ohe5756
	SxFFfFAJIJe8wcUHs7/WiokCH4hkAw2naddG6wLjyksQVYpNC80pJmojHxh477GQU4K7T/iOeBe
	A2rrmmwKE4T5Z10zMuWtiXqswobfSkhkJKSvQVM8TArMNdeDzwhsoE5lgQm5IHz/I2Tifq+AKxf
	hC9byn5v/0nQGKd3yVS/Ns4ZwOY4X2qmelFZGQSpg1tpt5G7m+Hw+HKv8u8Gee2gLuo0aLE0b0t
	phKG2jdNMa9SGI4CR/IxC0ipbuZtnIRq+F9scxXk/g+bu7j43CDTKVjivdU6u1oiQ9V8B1zi5E9
	gSenSx5X+VxSkoXOepiTMl6aRqL+sUj8oxleU4/ymAArPT9aM2sYmzXOQuL4n6BzbiHuIy4oO8o
	61QX8PHkbiQS9Ts/G6MaVvQC087sQGviv3uKee5V0bkojB/PVhUvcpcL8lTZw2YDrOhZs5foHL7
	G0ohX5T5FQG02wjf04uPIxpRLA6sjOFyO0+agZjbkc9NVC67abaK04pIqQ=
X-Received: by 2002:a05:600c:19ca:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4a211dd9804mr41973795e9.30.1792767828061;
        Fri, 23 Oct 2026 08:03:48 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d427e68sm296326f8f.52.2026.10.23.08.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:47 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 1/7] stash: use an enum for create status
Date: Fri, 23 Oct 2026 16:03:29 +0100
Message-ID: <685914011f9fc6c425e67fc4196b83af26249a66.1792767795.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792767794.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792767794.git.phillip.wood@dunelm.org.uk>
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
 builtin/stash.c | 110 +++++++++++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b1..53744d96e84 100644
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
+	enum create_result ret = CREATE_SUCCESS;
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
+	enum create_result ret = CREATE_SUCCESS;
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
+	enum create_result ret = CREATE_SUCCESS;
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
 
@@ -1577,37 +1584,45 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
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
+		switch (ret) {
+		case CREATE_ERROR:
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
 						     "worktree state"));
-			goto done;
-		} else if (ret > 0) {
-			goto done;
+			/* fallthrough */
+		case CREATE_EMPTY:
+			goto done;
+
+		case CREATE_SUCCESS:
+			break;
 		}
 	} else if (only_staged) {
 		ret = stash_staged(info, patch, quiet);
-		if (ret < 0) {
+		switch (ret) {
+			case CREATE_ERROR:
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
 						     "staged state"));
-			goto done;
-		} else if (ret > 0) {
-			goto done;
+			/* fallthrough */
+			case CREATE_EMPTY:
+				goto done;
+
+			case CREATE_SUCCESS:
+				break;
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
@@ -1630,7 +1645,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot record "
 					     "working tree state"));
-		ret = -1;
+		ret = CREATE_ERROR;
 		goto done;
 	}
 
@@ -1646,7 +1661,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 			struct repository *repo UNUSED)
 {
-	int ret;
+	enum create_result create_res;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
 	struct stash_info info = STASH_INFO_INIT;
 	struct pathspec ps;
@@ -1658,14 +1673,15 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 	if (!check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
-			      NULL, 0);
-	if (!ret)
+	create_res = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
+				     NULL, 0);
+	if (create_res == CREATE_SUCCESS)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
-	return ret;
+	/* Do not return an error if there are no changes */
+	return create_res == CREATE_ERROR ? -1 : 0;
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
@@ -1674,6 +1690,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			 int include_untracked, int only_staged)
 {
 	int ret = 0;
+	enum create_result create_res;
 	struct stash_info info = STASH_INFO_INIT;
 	struct strbuf patch = STRBUF_INIT;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
@@ -1741,10 +1758,17 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
-			    interactive_opts, only_staged, &info, &patch, quiet)) {
+	create_res =  do_create_stash(ps, &stash_msg_buf, include_untracked,
+				      patch_mode, interactive_opts, only_staged,
+				      &info, &patch, quiet);
+	switch (create_res) {
+	case CREATE_ERROR:
+	case CREATE_EMPTY:
 		ret = -1;
 		goto done;
+
+	case CREATE_SUCCESS:
+		break;
 	}
 
 	if (do_store_stash(&info.w_commit, stash_msg_buf.buf, 1)) {
-- 
2.56.0.134.g299a3c16181

