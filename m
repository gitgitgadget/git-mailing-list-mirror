Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CE242D72
	for <git@vger.kernel.org>; Mon, 25 May 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733812; cv=none; b=Dx5Y/zjgWZQUlz7kz3KutbF0WPrcUusQ2nD3G/kBrUPPCTg7jXTGjDefIdegefePH3JKoo1X/MGFXfLBG1OdqdGSexbVBFgBSQiHzOntwfBVke0ybVPFI8+ESoHsp7qFDBrJbgPhUZIU2fy+vnAQLj+yMjtFf1QZ1PFBUNVl5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733812; c=relaxed/simple;
	bh=kWaJOTvimQ5ZEvJ4h0TWdslW2/zXs3mMDFfhcaXTNJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mb5djPkAWMntgrugpT5dA8DjeSmbBS4cd+mtOgL9vI65jPvfvULE8prI6DfzHb3m59svyGVAyP7l5U2i7wl3kQv7mROabs15zL0CCHTqHyT8pL+WyzHpjP0BMsL7j28/PZtp9c/PCJlwckK972J5XGVVeZ8+wJD1N+mPNs56yWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+kSSkWQ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+kSSkWQ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51306c36c3eso109141771cf.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779733805; x=1780338605; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB07fQkuRKw4aac6k+H7jHPTiMWYG+CEX3HMnp9ROUo=;
        b=Q+kSSkWQsRiWPEmSnEBP5JNVK1f8vzdtLbKxO2QJeLQmdZKjBEYAD9xSW8NS37U1Qz
         2GgEeiRQ/grlxHZKNB1fr6PoO2z2Tk9HXitHLEWNotAuLCKOp/EVstzD4+/Dk8B3NMXd
         UQhfby0TMjYnsQ412sTJo37iPajP+BA/BY0wIDu5weYYLfF7a5n0PjE985iMqkecNJCX
         TrxtedAv5DgZLokmyHawi6pYd8CEiTqUUOFLQWC8UWWEnXZfE2UUhpX2LB6pQtgaEYwO
         V6zyZmbtH+N4T04WuNBxio1tVGDyLdoaRDDd77NRIhL84T16jt3ooi56GsxiVtWyu39K
         IocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779733805; x=1780338605;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fB07fQkuRKw4aac6k+H7jHPTiMWYG+CEX3HMnp9ROUo=;
        b=nfEEVxfh6QF7wurjJmDNV7obFa4pv79XUN8UaxjvpuWcaV48Jo0ezhB6fCJbQiL+tG
         uTSHeMe5Xy51i3ydRC2aVYxw3Qsm/BkrC2UqDkKiuQpPlPkwf2unGF+z7NOE/ZZJdxW3
         TCA5LT/ayDnp/Lwsp8wnoO0wh/ukKx6bJx9QaeVYDlhYi+F9UjQkKJAUTq+5ZNu4TNQq
         SgXqBHjoKapU8XiiMcUucX2fYdcDMNCiia0t8heXLWJ7Lyqs7R2hMM5OrvRyspFneODh
         1lp/DKV0WgLiUfp40BJ66PNjMk16dco1naYkdLIa7uS5r0NlZsCrzlsoqUtv8YlwZVsC
         myIg==
X-Gm-Message-State: AOJu0Yxp5WGm2G8o331DiBt4/OImqLdcefhIm68lw5Yki99jRHsKoh++
	pFJk7ZwN/LObxzj77EvuRgv8jk/SGqHu+HktY6bMJWS5JKgvdKwGZF8mHpD0Ukje
X-Gm-Gg: Acq92OGHkBVY3fzZ5T7ukTs4S2dSIJ7iJwFOn9D4tXxSa7ufreU0U4qpqr9H8nh2oHt
	vRDN8TNib1R0c0/8JlHRk2NS56hlnHgnu2yXTI1J/c7fTlpreJuYtnjxlQgvcAnttenntdidYLc
	kjBdNrXgqMcYW2GyBqxSR9sqz4e1r4xmTDc5cUesCB0Y9/dKHXgazHUGDS5wPjTF2hvij/OUvn+
	QBsi/oGzolmRqIgWxDBrmBet4pXYX4Z1ojsnWEYBe47zZGc4QYabZ3xefGxZ8BjibeJR4iH3yAb
	9Q5jP24c79D4DnGtxhQBkZrKHhM1tfQ0DHpaMPUgqEj1CbtHHQOBYYixC+tbzfBFbMxFBiPAy8Q
	Vhg/Ns5GH4R2bXQLX90eyRU3ImoXPnZmAttU6VGmrmprclNJJx9olJt2hzpWVtNTgklxT8zYZZq
	F3lYl1aSo5XOt9W5gTjBYaYj7ho/A=
X-Received: by 2002:a05:622a:90:b0:516:e236:1d3e with SMTP id d75a77b69052e-516e236221dmr137638001cf.6.1779733804736;
        Mon, 25 May 2026 11:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.180.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e0413sm127339046d6.31.2026.05.25.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:30:04 -0700 (PDT)
Message-Id: <39ff53acefb2844b0f4e88825d29b9d57bed66f2.1779733799.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
	<pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 18:29:58 +0000
Subject: [PATCH v2 4/4] blame: consult diff process for zero-hunk detection
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

When a diff process is configured via diff.<driver>.process,
consult it during blame's per-commit diffing.  If the process
returns zero hunks for a commit's changes to a file, treat the
commit as having no changes, causing blame to attribute lines
to earlier commits.

The subprocess is long-running (one startup cost amortized
across the blame traversal), but each commit in the file's
history incurs a round-trip to the tool.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/gitattributes.adoc |  3 +++
 blame.c                          | 43 +++++++++++++++++++++++++++++---
 t/t4080-diff-process.sh          | 32 ++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index 962896a0b4..c087b4b265 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -857,6 +857,9 @@ The tool responds with lines of the form
 
 If the tool returns zero hunks with `status=success`, Git treats
 the file as having no changes and produces no diff output.
+`git blame` also consults the diff process and skips commits
+where it reports zero hunks, attributing lines to earlier commits
+instead.
 
 Tools should ignore unknown keys in the per-file request to
 remain forward-compatible.
diff --git a/blame.c b/blame.c
index a3c49d132e..8a5f14db7a 100644
--- a/blame.c
+++ b/blame.c
@@ -19,6 +19,8 @@
 #include "tag.h"
 #include "trace2.h"
 #include "blame.h"
+#include "diff-process.h"
+#include "userdiff.h"
 #include "alloc.h"
 #include "commit-slab.h"
 #include "bloom.h"
@@ -315,16 +317,47 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 
 
 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
-		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data,
+		      int xdl_opts, struct index_state *istate,
+		      const char *path)
 {
 	xpparam_t xpp = {0};
 	xdemitconf_t xecfg = {0};
 	xdemitcb_t ecb = {NULL};
+	struct xdl_hunk *ext_hunks = NULL;
+	int ret;
 
 	xpp.flags = xdl_opts;
 	xecfg.hunk_func = hunk_func;
 	ecb.priv = cb_data;
-	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
+
+	if (path && istate) {
+		struct userdiff_driver *drv;
+		drv = userdiff_find_by_path(istate, path);
+		if (drv && drv->process) {
+			size_t nr = 0;
+			if (!diff_process_get_hunks(drv, path,
+						    file_a->ptr, file_a->size,
+						    file_b->ptr, file_b->size,
+						    &ext_hunks, &nr)) {
+				if (!nr) {
+					/*
+					 * Zero hunks: the diff process
+					 * considers these files equivalent.
+					 * Skip so blame looks past this
+					 * commit.
+					 */
+					return 0;
+				}
+				xpp.external_hunks = ext_hunks;
+				xpp.external_hunks_nr = nr;
+			}
+		}
+	}
+
+	ret = xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
+	free(ext_hunks);
+	return ret;
 }
 
 static const char *get_next_line(const char *start, const char *end)
@@ -1961,7 +1994,8 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 			 &sb->num_read_blob, ignore_diffs);
 	sb->num_get_patch++;
 
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
+	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts,
+		       sb->revs->diffopt.repo->index, target->path))
 		die("unable to generate diff (%s -> %s)",
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
@@ -2114,7 +2148,8 @@ static void find_copy_in_blob(struct blame_scoreboard *sb,
 	 * file_p partially may match that image.
 	 */
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts))
+	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts,
+		       NULL, NULL))
 		die("unable to generate diff (%s)",
 		    oid_to_hex(&parent->commit->object.oid));
 	/* remainder, if any, all match the preimage */
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index 083e48e872..50f49a9b02 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -335,4 +335,36 @@ test_expect_success PYTHON 'diff process zero hunks suppresses diff output' '
 	test_must_be_empty actual
 '
 
+test_expect_success PYTHON 'blame skips commits with zero hunks from diff process' '
+	cat >blame.c <<-\EOF &&
+	int main(void)
+	{
+	    return 0;
+	}
+	EOF
+	git add blame.c &&
+	git commit -m "add blame.c" &&
+
+	cat >blame.c <<-\EOF &&
+	int main(void)
+	{
+	        return 0;
+	}
+	EOF
+	git add blame.c &&
+	git commit -m "reformat blame.c" &&
+	BLAME_COMMIT=$(git rev-parse --short HEAD) &&
+
+	# Without zero-hunk mode, blame attributes the change.
+	git blame blame.c >without &&
+	test_grep "$BLAME_COMMIT" without &&
+
+	# With zero-hunk mode, the process considers the files equivalent
+	# and blame skips the reformat commit.
+	git -c diff.cdiff.process="$BACKEND --mode=zero-hunk" \
+		blame blame.c >with &&
+	! test_grep "$BLAME_COMMIT" with
+'
+
+
 test_done
-- 
gitgitgadget
