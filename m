Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234D2E7377
	for <git@vger.kernel.org>; Fri, 29 May 2026 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087714; cv=none; b=QUgk78EvcKRTCHAGyTZBDMHQFpg1MXrhMR0xPfzA2UuYsVVjAswvDmVYRPs90Qc/jSUT5jMPUW4QNBLdrFfBVq4gPIkk/WNhuful9NUEkYb0TeXUIed9WkvxEYA/dINJSBr7bfflCrjNXjL9IKg8qxJctBJuEC0BanuEldy/Ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087714; c=relaxed/simple;
	bh=xOgKWwpB98MuEFXFXs+m/Hhi9yrrBTqf4m9kZflDuJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dyv1zK0lSOBOIEjUhky9s+P2W83pfPWkU6eebmMI81Cnk+4vGXizapiANgXVsCsfUY2enh6Q0pPbje/2nNAFvnlzsJu0mjoOhBNlpWNQq2B0YHyqgSKe7KGx3SuN0a6jwhcDBvyESvijKfMRXeZLQQuSatxauab7VbSYHexgYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUTBSaNF; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUTBSaNF"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137c928ec7bso1849991c88.1
        for <git@vger.kernel.org>; Fri, 29 May 2026 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780087713; x=1780692513; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL6WgUrVyHZm/4fSX8vqys8FR5aIhHLrgUghGg6M5mo=;
        b=CUTBSaNFUl0+3B/ryLf30ATz8VHVkoNYWfFdHrwrsXIGkIs13M9G4woZxc/Kw2tfh5
         TlHywNGfclAOSohM+oQYxtisqb+GUKWmD57kNMtv7aRZFsSZI4KM1z8g8qA1l3IZ6HzS
         cKw6wRlsv8wZ6iwVJ1eGLT/hibusUVmcjm/Jduqr+juTBr1B858geWio+Bmk6+qDEB5s
         Koq8TpIDfQyOgLRWq2eM+pdVNPHt8207NWL9njYgniCOd6WysAJB7yN/Gnpmaz44aMDa
         sK83lS/xOwJ+VtiEUqbEmBIbzq3nV/ZL/983XGocw45N1dlcVaj+VPlfazXwPxP5I9wd
         +OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087713; x=1780692513;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pL6WgUrVyHZm/4fSX8vqys8FR5aIhHLrgUghGg6M5mo=;
        b=V/1XYy2LzAUA5r8PCcYhp8XixwXBmgs9oHVUkdJyq5QDWSGSNvaUA/Mn8dMBAatMXA
         xAOaPmDVVf+YFG7taerxhepA/GUsg/bvwBPFMY9GxmEryJJV39IwX3IdNZUP2Vkmgm/f
         utEIdYsMXwLlrH8sFF/4+NQiDrLmMtEZ/RJZon0ZKclDsw+Ow5RUIikrTpPGCr6SwpUi
         68+dbHNHI5/hiNkAS37yWilBIqE3whMqVFK6JHDumbRT5SM2H+zN7V+75HPUa7VkYlFj
         HC61bBRt6JYPpjx233ILNU2KUifxWqZ8PuWDBaqCrZ9HP9+794hfw/GvIpucDLhKIm9N
         bLNQ==
X-Gm-Message-State: AOJu0Yy0fFHt8lKddIxf2iVamOOMbgFTFV1gMdERCzwcZuchv6ASHXJN
	1cy3y3dDMzFpJAt542uAP7faJb0GszGnnsg58DyonXUYrwh1XnOE9sYKXkofNA==
X-Gm-Gg: Acq92OHbjeEf+w5kvORfR3Gr47Uu7IlkWmpWT4S/rmgMUB4pCOWeU0Syd6M3IthNRTh
	mY33Va+qU/jTPCsqUmfiyscyywrtPygIfn8ZLc7uYxB3QbgtS30f1ls/I8KjxLkL/2AUcPjSBd4
	+64QaH0NABQiP7tH1NJWA7pcLA1Wi4b+gigvGjAA05F7jx4WAk2FoooCsM8D8b6Y15ogXbIpvh3
	05q3gPVscrIdKXHH935HEBhDHThBRd9PrBY2EaQ62RJ6I+AVptdBEqSHSkyPGtoqCqTkMDgHG/5
	v+GJ6xB1UCAn/VkZxxYsVHPC0tVcQsjBpBETops4RjHsHeITlEYLqZb3+DnAbk0qZ9pBslKIknO
	6SSpjRKiF8PA3YbSBWmBzW05CXxZ7TqndyjXlcKpmUrWF4bPfpQOdzF+Lkmvib5YSN45fqFDzzF
	0YIcCASDWlwvagapXgLRhLulzoH6BfccK75Y2pRA==
X-Received: by 2002:a05:7022:f418:b0:12d:ff1b:92f5 with SMTP id a92af1059eb24-137d4283a00mr549627c88.28.1780087712470;
        Fri, 29 May 2026 13:48:32 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.227.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69c0asm1984248c88.11.2026.05.29.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:48:31 -0700 (PDT)
Message-Id: <370e766978717e7185d7949632ed4126daf9f331.1780087700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 20:48:19 +0000
Subject: [PATCH v3 6/6] blame: consult diff process for no-hunk detection
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
returns no hunks for a commit's changes to a file, treat the
commit as having no changes, causing blame to attribute lines
to earlier commits.

The consultation happens at the pass_blame_to_parent() callsite
using diff_process_fill_hunks(), matching how builtin_diff() in
diff.c uses the same function.  A new diff_hunks_xpp() variant
accepts a pre-populated xpparam_t for this callsite, while the
existing diff_hunks() retains its original signature and behavior.
The copy-detection callsite is unaffected since it does not use
the diff process.

The subprocess is long-running (one startup cost amortized
across the blame traversal), but each commit in the file's
history incurs a round-trip to the tool.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 blame.c                 |  40 +++++++++++----
 t/t4080-diff-process.sh | 106 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 9 deletions(-)

diff --git a/blame.c b/blame.c
index a3c49d132e..79f02735a4 100644
--- a/blame.c
+++ b/blame.c
@@ -19,6 +19,8 @@
 #include "tag.h"
 #include "trace2.h"
 #include "blame.h"
+#include "diff-process.h"
+#include "xdiff-interface.h"
 #include "alloc.h"
 #include "commit-slab.h"
 #include "bloom.h"
@@ -314,17 +316,25 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 
 
 
-static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
-		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
+static int diff_hunks_xpp(mmfile_t *file_a, mmfile_t *file_b,
+			  xdl_emit_hunk_consume_func_t hunk_func,
+			  void *cb_data, xpparam_t *xpp)
 {
-	xpparam_t xpp = {0};
 	xdemitconf_t xecfg = {0};
 	xdemitcb_t ecb = {NULL};
 
-	xpp.flags = xdl_opts;
 	xecfg.hunk_func = hunk_func;
 	ecb.priv = cb_data;
-	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
+	return xdi_diff(file_a, file_b, xpp, &xecfg, &ecb);
+}
+
+static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
+{
+	xpparam_t xpp = {0};
+
+	xpp.flags = xdl_opts;
+	return diff_hunks_xpp(file_a, file_b, hunk_func, cb_data, &xpp);
 }
 
 static const char *get_next_line(const char *start, const char *end)
@@ -1943,6 +1953,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *parent, int ignore_diffs)
 {
 	mmfile_t file_p, file_o;
+	xpparam_t xpp = {0};
 	struct blame_chunk_cb_data d;
 	struct blame_entry *newdest = NULL;
 
@@ -1961,10 +1972,21 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 			 &sb->num_read_blob, ignore_diffs);
 	sb->num_get_patch++;
 
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
-		die("unable to generate diff (%s -> %s)",
-		    oid_to_hex(&parent->commit->object.oid),
-		    oid_to_hex(&target->commit->object.oid));
+	xpp.flags = sb->xdl_opts;
+	/*
+	 * If the diff process considers the files equivalent,
+	 * skip the diff so blame looks past this commit.
+	 */
+	if (diff_process_fill_hunks(&sb->revs->diffopt, target->path,
+				    &file_p, &file_o, &xpp)
+	    != DIFF_PROCESS_EQUIVALENT) {
+		if (diff_hunks_xpp(&file_p, &file_o, blame_chunk_cb,
+				   &d, &xpp))
+			die("unable to generate diff (%s -> %s)",
+			    oid_to_hex(&parent->commit->object.oid),
+			    oid_to_hex(&target->commit->object.oid));
+	}
+	free(xpp.external_hunks);
 	/* The rest are the same as the parent */
 	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, 0,
 		    parent, target, 0);
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index ee0c306abd..fdf6da1c34 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -551,4 +551,110 @@ test_expect_success PYTHON 'diff process fallback on overlapping hunks' '
 	test_grep "NEW5" actual
 '
 
+#
+# Blame integration.
+#
+
+test_expect_success PYTHON 'blame uses tool-provided hunks' '
+	cat >blame-hunk.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	original5
+	original6
+	line7
+	line8
+	line9
+	line10
+	EOF
+	git add blame-hunk.c &&
+	git commit -m "add blame-hunk.c" &&
+	ORIG=$(git rev-parse --short HEAD) &&
+
+	cat >blame-hunk.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	changed5
+	changed6
+	line7
+	line8
+	changed9
+	changed10
+	EOF
+	git add blame-hunk.c &&
+	git commit -m "change blame-hunk.c" &&
+	CHANGE=$(git rev-parse --short HEAD) &&
+
+	# With fixed-hunk mode the tool reports only lines 5-6 as changed,
+	# so blame should attribute lines 9-10 to the original commit
+	# even though the builtin diff would show them as changed.
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk" \
+		blame blame-hunk.c >actual &&
+	sed -n "9p" actual >line9 &&
+	sed -n "10p" actual >line10 &&
+	test_grep "$ORIG" line9 &&
+	test_grep "$ORIG" line10 &&
+	sed -n "5p" actual >line5 &&
+	sed -n "6p" actual >line6 &&
+	test_grep "$CHANGE" line5 &&
+	test_grep "$CHANGE" line6
+'
+
+test_expect_success PYTHON 'blame skips commits with no hunks from diff process' '
+	cat >blame.c <<-\EOF &&
+	int main(void)
+	{
+	    return 0;
+	}
+	EOF
+	git add blame.c &&
+	git commit -m "add blame.c" &&
+	ORIG_COMMIT=$(git rev-parse --short HEAD) &&
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
+	# Without no-hunks mode, blame attributes the change.
+	git blame blame.c >without &&
+	test_grep "$BLAME_COMMIT" without &&
+
+	# With no-hunks mode, the process considers the files equivalent
+	# and blame skips the reformat commit, attributing to the original.
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
+		blame blame.c >with &&
+	test_grep ! "$BLAME_COMMIT" with &&
+	test_grep "$ORIG_COMMIT" with
+'
+
+test_expect_success PYTHON 'blame --no-ext-diff bypasses diff process' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		blame --no-ext-diff blame.c >actual &&
+	# Without the process, blame attributes the reformat commit normally.
+	test_grep "$BLAME_COMMIT" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success PYTHON 'blame --no-ext-diff uses builtin hunks' '
+	# fixed-hunk mode would narrow blame to lines 5-6, but
+	# --no-ext-diff should bypass it and use the builtin diff.
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk --log=backend.log" \
+		blame --no-ext-diff blame-hunk.c >actual &&
+	# Builtin diff attributes lines 9-10 to the change commit.
+	sed -n "9p" actual >line9 &&
+	test_grep "$CHANGE" line9 &&
+	test_path_is_missing backend.log
+'
+
 test_done
-- 
gitgitgadget
