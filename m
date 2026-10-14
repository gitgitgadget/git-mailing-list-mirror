Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62E499F24
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992439; cv=none; b=bfr69aU3bg4mzPCCkRCIMRRGFRMLy/D+PUaYj9Z07rLo3oJ/D9i8Bs3Es8O23cl+gHwte5E9J1Fnja7EBMDcZuoXTDJjU92V1jSCYcDk5p+LLRSZqmdUuvApU4M25muX+XMa0nbuNWq6vW+Z2yg0gf45cVMtg7iAzNaquiMWFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992439; c=relaxed/simple;
	bh=ZGgCl/CRP449ppHyIqoo+Gh+Q+M127iGuWdTk5fiS04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vaa5CvAU8p2WOcc5nvI6OtSK02EZK3v1FNIGntqqWGGE0US5hcTjFyDiMETqPU67KNt2Y3YDAAgFMKCo58q//FgDqaXGp2PB60okZD2G8GdiT+dyvpFcf4+0dfEWNQV+NMdL3e2d1OrQjLxCacjK4P95cTnXX+07pMu+xtVgyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGfv0t3H; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGfv0t3H"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b060ec084so2828483f8f.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992434; x=1792597234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JgkTtrYPgcoDvRB7x1eCtbqluwwPk99e41S7ZikhXoo=;
        b=dGfv0t3Hy703Y4bnENjCRyTC5nRaGZ7bmO+xN77V24SjSdYGArZmZTkyhR8Vi0+3V8
         OsEYf7lh4pvMWt48yrq9oHNTvtLXvikaKjNytaUXS3qeIMg+pmevlVKsbX044eSL4U2b
         Tl7VmJcn/7GkjpplgMxWQJcc4b5uT1kYOtX95QWYBgIn0wiEbmId2/wTumW02vMk0CIU
         SlUxhzxjDo7PMeJ1J1MjvNUKnSxSur3rliAQL11P/Q7WMan7XDdfn01HxY8y7YDV2xeu
         VH2JZzuVTRoMmV4VsiXQc/+X/ZDT2vyEhAuTqrwFKuXOxj5Y8a1laBGcRLH7bvI6SyvS
         H4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992434; x=1792597234;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgkTtrYPgcoDvRB7x1eCtbqluwwPk99e41S7ZikhXoo=;
        b=foDP0D1vBacP8YckmE4SSJzc4HZQGThD3Of8z9nGkVmCBVVvkSo47wUHuJHc47saw0
         6Jk3qvf4oUm3G/P4AuVo5ox3Dn3YnqUdwNXnRuZZAXDrwoTkYK0JHF2tGc2zuam9DSV8
         b6xDjA+lhC7/EDjyLEtW/pyYvfGmNzunoWcNa+o3N5AlaaAsi6CCbuTCtyv1Ve30khx6
         ETBB1/6yqWdHD59x8P4UKPQQs2up5hOmQtnkb+oRSdUJB8vLJPH4xL4OZ+JTesDkoSzb
         HDDBupp2x0yqCdopzx7RZ4XWOrDuwe+KVFd2sMj47d87R9Tmm0r7p3h8hNEMsc0MlcUI
         HiRQ==
X-Gm-Message-State: AFq9FYLq/X9UViZzI/LWqVfci793OFGblIiEacK8JCK99n3xL2KTA0vB
	eQu3//vhvp9SDY20GrZinDQAdB35a1SHKe6AWbE/4SUtbni1JaKu/uqrP49SaQ==
X-Gm-Gg: AYBFou04S1mu5vPtNeipJlueitmz7Qo1CDSPc0zZ4J8zocjQUT0vbKgfEsvAMidecuU
	mevy69HT48S8Lw+SaV3Vno+Dkh9fKwD1FM1ZSRjXYiaIjM7X0F1Qecc0kHXDfGDlLpAahc64Dvn
	o8PIaGDKpfSxwiz+WOHy5PSvtZJzAa/PEM+hs+J71VFd3d2D+OhZmNtMBWSEBsXsyD83B+MSd4u
	/cKR8YboEBfC0WcId5NzmykwA/ZsiiQIeSyUFfHcNW1GWeFaGOdsxJME8Xu1e/KYxydiiCACpr5
	t5LqnYuIyQ5GsQ1zORYm1DL/QixQxHiOehYvn/xWihoDJCJKKQoU9qnF9XjwLephuOLVUWYaeqO
	TDX7811A3/7Cnon4UeiltuWwZ0aPwYF9hFNXqQ3Q85LN2TQiRgskXG76mb5ITeSr0NGF+4YTOga
	o769sFUX+AO5qhcVI3CQKmsU04eNCQOujdLdDStxY5raFBG92a/iSLCi0WmVo35L1SaSnV9mt/i
	A==
X-Received: by 2002:adf:e19a:0:b0:486:f6dc:52c8 with SMTP id ffacd0b85a97d-48dbace511cmr28791547f8f.37.1791992434007;
        Wed, 14 Oct 2026 08:40:34 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm10324829f8f.2.2026.10.14.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:40:33 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/7] stash: use an enum for create status
Date: Wed, 14 Oct 2026 16:40:13 +0100
Message-ID: <9e27bcd676ee763ed499fb337b1497f3fe2405b2.1791992404.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791992404.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1791992404.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
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

