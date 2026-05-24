Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137ED13B7AE
	for <git@vger.kernel.org>; Sun, 24 May 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779644422; cv=none; b=baAFtTX/LixNLOmDsGpx0rL7/JzC9FIzEniYS7IszxiPk/eYUgxLWqnAAg94O+UKPXLs0vSWKr/i06xfP4dpjYMFP50AbyiM3wFBbLmf/qtSEICDSQRA+qN6m5n2amolC1MPz24KzLX55qzZI3kzZA/VQSLFtD7gt8WlD32GVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779644422; c=relaxed/simple;
	bh=RPf0EdqQozY95WFpYXjn/elQR87Gx41GRI+jc/RriLs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i45bxNlef1OcVviPOOBJKY5wWc2dv1/1ksi+Ibl1DpwjjIO1P70IrKLFVcf4crN09WbKDRW5uVgJHa6VAQvjZtGiEl+ZuKxU+9mFtsKmzM+xJ4Z0HruZpoT7Hruwh2H+/w5cEp6h8pmRfJqP+8olg/mzPNh3nmK9AmZMZN/wrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ihv0lTY/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihv0lTY/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e63771d91so86179431cf.0
        for <git@vger.kernel.org>; Sun, 24 May 2026 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779644420; x=1780249220; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci9b31Gy8cacGxUm0cUrKxyzn/+zqa8PyufDrdqX5Ps=;
        b=Ihv0lTY/5As8C4QPjXRcokkDDEpbIG734ilJNxyNPOeh+JToWL4oVHtokZzpV+H6nF
         kAXM54VHBPUk/otuOi590p1cqWD8mFxAqcWp1v8Pq73wl1/STCSDNBG8VtSStU3nx+xr
         7LjtKSwS4YHnGDoBcOXe3PMyqWbJam9MiFLGbk2HbiDEK8uEiLs4nVG0XNCh9qTMByYj
         IdXBmBtkTAQR8D2VuXw01wj3xVtTOoNTFm2vpx9QL+SVXH+Z/rc3UMywf1yJOYfyHEW7
         7oYG/0E3KTquXFi1RuE0yw56weiMkm/q1+mtWYvN+rrnCwF126zrPcWIvu+dK8PAACkQ
         /myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779644420; x=1780249220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ci9b31Gy8cacGxUm0cUrKxyzn/+zqa8PyufDrdqX5Ps=;
        b=tLGjyF9Q0vBdNmsIVGTlt0euYlsIqWiq4H7W0LpPBrNHxE1w11GwsJ0FjNnpBbVcyf
         HNZhBp1mInQoHzPu3YdNaagnoZlOPav/GIRrk7je3IpxOPTA2moa5F0+o6H3J8HavKlu
         T5lBvotclkGffQqiTww7FNydvnBofAJu4DHjAtRJX563/qo65z75aQr7aU5EtGnDL+Sn
         RtCSr15ZBnTzi2NOFuew9UVyqf+TDtPR43ozJcbIneyf3d6VqqyQvcY+hRgh4gyxA6pQ
         8Py77aeNz8dSk+qUXrC2l9qdL5mzMP3PvEaDM+K1AY4DjVuyqZIOQqIwsEMIHvsU+V2F
         6vbw==
X-Gm-Message-State: AOJu0YzzkA0Pg8jHHNKnFr9/OZvcKyoZySVMlDDHobs+3cN6vpJkwdY5
	4UwuHRmgDNYKx4312063YqlrSuEkdSvRYSujSuNdLpM+b2OCf6bd+Kzk31CqDQ==
X-Gm-Gg: Acq92OGPWoGWTW7CdzIirq0/+a00FBa/wJ/xaw4tJvJt9rwlsBnCNysQHTbK+2hKVMW
	Xpij8pVjOITAsOFXjbHAy4U8zshxrjX3QnCUALA7mfDZG/cn86L7nw+HVDr86K1eX+iaF0CobZl
	LOZf2VOAGkCXVPxKpzpzryk6FVQkufmqiwIyTJdvLAXj59tdUmH3i6HN/OsZcMx5ESP2xsVM12W
	tQPx9NU2f7LW+dY/gVn5VlJdzQ2J35xMO0MSOxYMBnbgi0k6TkkNXQp7vq+DfvYaUb9h6w1vLJt
	Im6Oy1xAahmWGQDBqNiHgZLlGBOP5sVVuJ77+UxC/qUDx7aWJ6QfoPZu7iSQ1JjbUhZDi8Pv8eS
	YDTAjLIOmK9+cDjxvBJbvtovsXxnGgorl1wxHqpcF+jKLQJrYUj81UZWO9LrGG/FXnHoiKk07ZS
	pRvbQKel1zNa7MBPcGgN8Kgsyx
X-Received: by 2002:a05:622a:1348:b0:516:d570:82a9 with SMTP id d75a77b69052e-516d57095bemr168619571cf.56.1779644418996;
        Sun, 24 May 2026 10:40:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8131fc67sm89167426d6.45.2026.05.24.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 10:40:18 -0700 (PDT)
Message-Id: <47542cbd42eb13b63d0d852fb2f5bf967952b318.1779644412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
References: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 17:40:12 +0000
Subject: [PATCH 2/2] restore: avoid sparse index expansion
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Teach update_some() to handle sparse directory entries at the tree
level rather than expanding the entire sparse index. When iterating a
source tree during checkout/restore operations:

 - If a directory matches a sparse directory entry with the same OID,
   skip it entirely (no change needed).

 - If the OID differs and we are in non-overlay mode (e.g., restore
   --staged), update the sparse directory entry's OID in place. This
   is semantically correct because non-overlay mode removes paths not
   in the source tree anyway.

 - In overlay mode (e.g., checkout <tree> -- .), fall through to
   recursive descent so individual file entries are preserved
   correctly.

Also switch from index_name_pos() to index_name_pos_sparse() for
individual file lookups to avoid triggering ensure_full_index() when
the file is already individually tracked in the index.

Update the test expectation in t1092 to assert that 'restore --staged'
no longer expands the sparse index.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/checkout.c                       | 57 +++++++++++++++++++++---
 t/t1092-sparse-checkout-compatibility.sh |  8 ++--
 2 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1345e8574a..67f03dea10 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -31,6 +31,7 @@
 #include "revision.h"
 #include "sequencer.h"
 #include "setup.h"
+#include "sparse-index.h"
 #include "strvec.h"
 #include "submodule.h"
 #include "symlinks.h"
@@ -142,14 +143,56 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
-		       const char *pathname, unsigned mode, void *context UNUSED)
+		       const char *pathname, unsigned mode, void *context)
 {
 	int len;
 	struct cache_entry *ce;
 	int pos;
+	int overlay_mode = context ? *((int *)context) : 1;
 
-	if (S_ISDIR(mode))
+	if (S_ISDIR(mode)) {
+		/*
+		 * If this directory exists as a sparse directory entry in
+		 * the index, we can handle it at the tree level without
+		 * descending into individual files.
+		 */
+		if (the_repository->index->sparse_index) {
+			struct strbuf dirpath = STRBUF_INIT;
+
+			strbuf_addbuf(&dirpath, base);
+			strbuf_addstr(&dirpath, pathname);
+			strbuf_addch(&dirpath, '/');
+
+			pos = index_name_pos_sparse(the_repository->index,
+						    dirpath.buf, dirpath.len);
+			if (pos >= 0) {
+				struct cache_entry *old =
+					the_repository->index->cache[pos];
+				if (S_ISSPARSEDIR(old->ce_mode)) {
+					if (oideq(oid, &old->oid)) {
+						strbuf_release(&dirpath);
+						return 0;
+					}
+					if (!overlay_mode) {
+						/*
+						 * In non-overlay mode (e.g.,
+						 * restore --staged), we can
+						 * replace the sparse dir OID
+						 * directly since files not in
+						 * the source tree should be
+						 * removed anyway.
+						 */
+						oidcpy(&old->oid, oid);
+						old->ce_flags |= CE_UPDATE;
+						strbuf_release(&dirpath);
+						return 0;
+					}
+				}
+			}
+			strbuf_release(&dirpath);
+		}
 		return READ_TREE_RECURSIVE;
+	}
 
 	len = base->len + strlen(pathname);
 	ce = make_empty_cache_entry(the_repository->index, len);
@@ -165,7 +208,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
 	 * do the right thing.
 	 */
-	pos = index_name_pos(the_repository->index, ce->name, ce->ce_namelen);
+	pos = index_name_pos_sparse(the_repository->index, ce->name, ce->ce_namelen);
 	if (pos >= 0) {
 		struct cache_entry *old = the_repository->index->cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
@@ -182,10 +225,11 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	return 0;
 }
 
-static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
+static int read_tree_some(struct tree *tree, const struct pathspec *pathspec,
+			  int overlay_mode)
 {
 	read_tree(the_repository, tree,
-		  pathspec, update_some, NULL);
+		  pathspec, update_some, &overlay_mode);
 
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
@@ -580,7 +624,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return error(_("index file corrupt"));
 
 	if (opts->source_tree)
-		read_tree_some(opts->source_tree, &opts->pathspec);
+		read_tree_some(opts->source_tree, &opts->pathspec,
+			       opts->overlay_mode);
 	if (opts->merge)
 		unmerge_index(the_repository->index, &opts->pathspec, CE_MATCHED);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d69434e7ab..8186da5c88 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2608,19 +2608,19 @@ test_expect_success 'restore --staged with wildcards' '
 	test_all_match git diff --cached
 '
 
-test_expect_success 'sparse-index is expanded: restore --staged' '
+test_expect_success 'sparse-index is not expanded: restore --staged' '
 	init_repos &&
 
 	git -C sparse-index checkout -b restore-staged-exp base &&
 	git -C sparse-index reset --soft update-folder1 &&
-	ensure_expanded restore --staged .
+	ensure_not_expanded restore --staged .
 '
 
-test_expect_success 'sparse-index is expanded: restore --source --staged' '
+test_expect_success 'sparse-index is not expanded: restore --source --staged' '
 	init_repos &&
 
 	git -C sparse-index checkout -b restore-source-staged base &&
-	ensure_expanded restore --source update-folder1 --staged .
+	ensure_not_expanded restore --source update-folder1 --staged .
 '
 
 test_done
-- 
gitgitgadget
