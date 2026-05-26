Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FF3B8409
	for <git@vger.kernel.org>; Tue, 26 May 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827204; cv=none; b=qVvNyzq6Z+fZm10voD5MxRXsqL+McGXOakCmYV1unygjQKYNokwM/lBL9Bq43xoousACUv+VfS7pZEiom6QX3L1hBUzVHDyyBJPdCNcuJekiCRnrGxBQM4FWQMCF03f/XvPLi2kje1K/Mo4m5+e6Y5nfVioowTDe9rIJ25wkAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827204; c=relaxed/simple;
	bh=WjY/ArmEr2pxT/ttWv5DfyEAhp6CvlNizJLbFMdpRh8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P14oLYtBI7DKFqXt5wikr3yq/9eOntzo8b/GSK9s9iqLe740gJUfpFZOR68/1GcYM6QauRiF8bU51tkVRbkR8zL5Ju2bGrZY+lQ+5lo255tiTtcGzbaSMLZdbsVGepypUz192BumI8lr4XiwcrIev3TE1p2CwjnsjJjVrviV9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+t0Vhmy; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+t0Vhmy"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f68f3b075fso2780024eec.0
        for <git@vger.kernel.org>; Tue, 26 May 2026 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779827200; x=1780432000; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNTksX0D+VWZzP+Mji84/1/lfbdhN5HzxrHRp5PfLiE=;
        b=A+t0VhmyvQ/fs9v9HA9vA/dORqahJl0sBYqr4z9jmRxPVKNEJ9M6cDVImf9+wc96jl
         udSBtal5+UVCgW7NDgnlGIJ4sZQwzLaXYhTDtU8utQyDEB/WVwWxAg00mfqK9Q5rMADc
         NOLjVJzvzTTdFrJJM3tCj17StCegqrpVgs5l4C7jF+REFkKVtCKG9GqW413vWIO0hG+l
         WFSXNc1oeukOxLVnokva+c++8YU6IWTEFm7fDiChexq9f6WbAZA/gitPp0gQiVWLtaXD
         D7adgwdExy7n1Aaqj8QgrAZSAshD0YzxxYeUeR9t0q0zDcjLJqyBtFeXxSAtg48aCkac
         wtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827200; x=1780432000;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BNTksX0D+VWZzP+Mji84/1/lfbdhN5HzxrHRp5PfLiE=;
        b=bVD/hUanjA+IjM+o/1ahwVKMfVF5Sc1XXGNenYol9Nu9fGJztCxoXBMnulBH4LSfEw
         2+4ZknA556nu2A0bu09jB/5HIN7F6R5RdhZYvH5lEVJMHhg6FMZt4i7BhRpkqGvPWFX9
         vdu9R2EX25C0A0nmdDleTxXTgjfPJiHn09oOG+t9oJmfFZ86BI0CJCM36ShT9UbGz7c1
         DGtAFAVvd8iiTSB00lHelZ7UdIk7Cu76ZHGXkbnqj5tcuKXIoh0GL84GbrL+aBmZps9z
         vylRc7kHt44TYXElx/pFv4Ksk375kiw/wNsSPm3Rr76WS3XIMS4kMuzYwGPdsVHN9I3L
         wDzg==
X-Gm-Message-State: AOJu0Yxaji2F3fN7SU6ziMoDdYucZGHh3AuFapepPSCls7m/hGzK++bL
	6yOsrTCx9ytZ/2HWkGd/5o108oHvoH8NFTcajuWo621gGS3+1tiTmNdPvWy/VQ==
X-Gm-Gg: Acq92OGcUvLnlukQeNjPjqNmHdPMywY1AczXGhapAJy8GnMC8d9jUWgiyKKjuUxZ9Yk
	S68Nn2gC04xQpBzGXAPSg72oKXe2cXgmTqhZcvVCsER/cVW83ljSISwbOcRSR8WCJjMClgxHXNX
	Y5fAmp5mRHuURDNFp4zFBHj1kFeB7WVNWeNwqVLegS7z+dMMDiy89Z6rLi+qnWSzM6+xuWCcnGx
	Hd5GhSnM48LuMd2gYTfVdVBF98qchsLMOyKAmaJIxPiSLa3EEytELOYbzwr5lD0NM7Uyw7C8o2x
	KROmjBy2b5lhNUAu11KlRLhdhmDO8BP/dS+cBgaEifNtZa1pWlpuF93Se1UZgdSZFVX78hQ6gsQ
	wqKvk6mrpaVvO4FjRcHCRQ7DNCEE1BUYMUbd+yXYgvRkLSGBroiz+SFO3NB3FOuuznqp6lezrlb
	Uiv9DJHcNiB/dNTGjZyYbFCeArXpeyOCH8fMY9eQ==
X-Received: by 2002:a05:7300:434a:b0:2c0:c5e4:605f with SMTP id 5a478bee46e88-30449186bb7mr9638597eec.24.1779827200182;
        Tue, 26 May 2026 13:26:40 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452259a18sm11987176eec.23.2026.05.26.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:26:39 -0700 (PDT)
Message-Id: <88f5d26a3345bf524bdef872027704c8fb955e74.1779827195.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v2.git.1779827195.gitgitgadget@gmail.com>
References: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
	<pull.2121.v2.git.1779827195.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 20:26:34 +0000
Subject: [PATCH v2 2/2] restore: avoid sparse index expansion
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
 builtin/checkout.c                       | 65 +++++++++++++++++++++---
 t/t1092-sparse-checkout-compatibility.sh |  8 +--
 2 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1345e8574a..86e23a07b1 100644
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
@@ -141,15 +142,65 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 	return run_hooks_opt(the_repository, "post-checkout", &opt);
 }
 
+/*
+ * Handle a tree object and determine if we need to recurse into the
+ * tree (READ_TREE_RECURSIVE) or skip it (0).
+ */
+static int try_update_sparse_directory(const struct object_id *oid,
+				       struct strbuf *base,
+				       const char *pathname,
+				       int overlay_mode)
+{
+	struct strbuf dirpath = STRBUF_INIT;
+	struct cache_entry *old;
+	int pos, result = READ_TREE_RECURSIVE;
+
+	if (!the_repository->index->sparse_index)
+		return result;
+
+	strbuf_addbuf(&dirpath, base);
+	strbuf_addstr(&dirpath, pathname);
+	strbuf_addch(&dirpath, '/');
+
+	pos = index_name_pos_sparse(the_repository->index,
+				    dirpath.buf, dirpath.len);
+	if (pos < 0)
+		goto cleanup;
+
+	old = the_repository->index->cache[pos];
+	if (!S_ISSPARSEDIR(old->ce_mode))
+		goto cleanup;
+
+	if (oideq(oid, &old->oid)) {
+		/* Tree content already matches; no need to descend. */
+		result = 0;
+	} else if (!overlay_mode) {
+		/*
+		 * In non-overlay mode (e.g., restore --staged), replace the
+		 * sparse directory OID directly since files not present in
+		 * the source tree should be removed anyway.
+		 */
+		oidcpy(&old->oid, oid);
+		old->ce_flags |= CE_UPDATE;
+		result = 0;
+	}
+
+cleanup:
+	strbuf_release(&dirpath);
+	return result;
+}
+
 static int update_some(const struct object_id *oid, struct strbuf *base,
-		       const char *pathname, unsigned mode, void *context UNUSED)
+		       const char *pathname, unsigned mode, void *context)
 {
 	int len;
 	struct cache_entry *ce;
 	int pos;
+	int overlay_mode = context ? *((int *)context) : 1;
 
 	if (S_ISDIR(mode))
-		return READ_TREE_RECURSIVE;
+		return try_update_sparse_directory(oid, base, pathname,
+						   overlay_mode);
 
 	len = base->len + strlen(pathname);
 	ce = make_empty_cache_entry(the_repository->index, len);
@@ -165,7 +216,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
 	 * do the right thing.
 	 */
-	pos = index_name_pos(the_repository->index, ce->name, ce->ce_namelen);
+	pos = index_name_pos_sparse(the_repository->index, ce->name, ce->ce_namelen);
 	if (pos >= 0) {
 		struct cache_entry *old = the_repository->index->cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
@@ -182,10 +233,11 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
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
@@ -580,7 +632,8 @@ static int checkout_paths(const struct checkout_opts *opts,
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
