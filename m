Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDA2E2F0E
	for <git@vger.kernel.org>; Fri, 22 May 2026 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415893; cv=none; b=kaLIfXEOkcSnmqJxkiLwOlJquAsBRMKVhJ+/Hf/a6SEZG2jM1MTesY5ou9CqjquDQojPOfmlcu9LOBq+r/vcQu0GqROkmkdFmpkVlBXCjWqxtN7DexliyN2JpLKn8LhfrBHRu/YcQY6Y5jj4kiiFDLkuLTxnmXg41zShBOUgo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415893; c=relaxed/simple;
	bh=oVYTHpl/NC4WOEN+NcoAGIfJU4Cpkptp6dIwV43PJPA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z4iHTLJPlGEREjgRveaj0P02AR0IFWi3D72AmOXaMQx4AtgFP+e2Ngp2I7i8lyzsOLvjkIew1HEFYof/6CmnOj+jykjlkTP+pcmofWaqiStbCMTQ1TF+gmSV5NVmIqpUrdKCGsbC1a5MbbvvtYnsLumyDcqryPEm20a+WFs0G+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzJD3MsC; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzJD3MsC"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b98482b253so108172616d6.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 19:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779415890; x=1780020690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIYTpX5B42iZ1C1WhRb3xZGyXz2Nl9FMMASxmv6XyUU=;
        b=qzJD3MsCY8A22EH8uGvXTHMOqyA4nnb5o5IYZ4yICFREROj1PWjOZa88u4F/fgm+ti
         6hMKCKhCjglM6PPFuHqBHDXBlu0SccnCTcUKvGZpW5gYcPJniM6Y6GV0kYoXkatOCzxN
         OZg3q0ovVtRcB/krOZWj1I305uib+JdOVhrq9l3biBxSv4fj7fpwLUdyHEnGw6vOqquI
         QTZb8qqREaifYN20yDjYgWS/oLkfcm/rU9ci8y1727nB0ri4slqmSrFMedBo6s7rExxT
         5+/yAn0xDc7e1GhBptCDkTzyh8ImzthN89j1VUSnRlROqI63sommKoOND0UqjMHbsVY2
         TUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779415890; x=1780020690;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIYTpX5B42iZ1C1WhRb3xZGyXz2Nl9FMMASxmv6XyUU=;
        b=XhH+VFAJmAei7D0VBAAqfuTyT7nA+rjveixLeB8lh5lH+SU0rzqH40VQxKeMBvLLEI
         YvOcWaiKchdCDoy931YTAajLlSd0tZtc2jRO/bdQarlBuIs3pWs+AI+ZIaihImN42kq+
         lXwY0Z4Iph4OuyCTlJLVycJ0oba4LyxzoZhRTuUNn2FMxLEQh0CrUtG9TDXoeuPJQk1o
         QXHjEjChkAxtXNuMOF2tsfjTqcjpydd+y2bK6XwjAAX1YnUr0+Fis5VIc0W7QgXi9oYA
         tCLQ6MCdYNXqjjzw7AjmsJrLc4PhDpr5s2pZjpUElWAodJZkRf9CYrO/KVTObcmH52BM
         B5tQ==
X-Gm-Message-State: AOJu0YwY94QimiHOAi8Vm4Y1vzt3n8sxl2no82wqJHK7TIvSZrBeG7ZD
	jl+Ce7MkLtz/NdvM1DPbLZQzXX1GGiVDxH0Fqw6oCzQMDbqD/sARw66cJ++xKg==
X-Gm-Gg: Acq92OG2maRjKlQJifCqGUTcsPL/WRDuOPm7Q7Dm12Cyt/zWpzJ9U4dUwlW+msCYaiV
	JseQVNTtUdwW1AlwsxdwnZWq415Wjy3XxgOraz6XLMinLqEbJ27VelKjHxBjJuLLrbw0o+VxECI
	apOuiiUW3HixzEdtHlfmy2rVz/EEJCs9kyS+CHV0JMbbF+xe33O2O2YnLSnNEM6oEYBufRjolCk
	wTa/hX2g0ObxmOemCiulvaNk5XySxdWbDpa+RC8FVdJNJy9SYAZNQPsLkmYfCjoznvPIRTcdzAu
	JckOZAPzQedTkFLVsVgCfaBIwfJEdU/7ULvHBfJRULLu2O5ynaJewZhAovGoFX9ZYsVDKMoU4GZ
	y3eXjR4y3N0PhzzSichkaILHKoOXUorS1v0u/bu3IXQZ6KO5i+LjCITF1jjsivJQmws8b8sCojX
	Txf56XJWK/tKzwRDazbjyB/cXA33jOkVe9r6Dnoui3cU8qPw==
X-Received: by 2002:a05:6214:3bc1:b0:8c9:bcd5:2856 with SMTP id 6a1803df08f44-8cc7b62eb7fmr30239456d6.46.1779415890479;
        Thu, 21 May 2026 19:11:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcec8esm5200606d6.7.2026.05.21.19.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:11:29 -0700 (PDT)
Message-Id: <4e6ea6d518aa209aee2db0447c17b81f1432b036.1779415884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 02:11:23 +0000
Subject: [PATCH 4/5] blame: consult diff process for zero-hunk detection
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
index cc724f8c63..7d66fa3aa1 100644
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
index 6f49f4e66b..5ed644b786 100755
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
+	grep "$BLAME_COMMIT" without &&
+
+	# With zero-hunk mode, the process considers the files equivalent
+	# and blame skips the reformat commit.
+	git -c diff.cdiff.process="$BACKEND --mode=zero-hunk" \
+		blame blame.c >with &&
+	! grep "$BLAME_COMMIT" with
+'
+
+
 test_done
-- 
gitgitgadget

