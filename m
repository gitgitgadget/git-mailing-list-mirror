Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79853B776A
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606129; cv=none; b=GH8XZtKh3wH1e9NZpaJzEIC4GSQE4Ku/ZS0g/w9osa7MkBxt+C1/SpiR6GCd7ue1yrS1+xILs2p+VsQx9Wf2+POZ67UlQ15KxNiTRShtBZdaaP7LZ/8WBMTxiB8CCV762bV9SW86pl8Cev9gHcq7yXXP0EVUQb2GevBFmAs+Rxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606129; c=relaxed/simple;
	bh=ylBGnHvjAknwOH3eDKjEbXi4MsrQT7TJjLcafMtCiaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRN0wG/5DgWoZrIHAFr1vAufyW6PvLa+npDP3bSClXlIv4AnAYbxhQ28r/E7MKIUVZCt34c58SfVFU7x+CtpC+rLjrw+qBFTv14MAqSwEINVOEgtDs6f94uXLQdclmDH3ouwO6eCKkYZDSc0866UqKQ7a43HWAu9si6DBQUc9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQwaEtE+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQwaEtE+"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so1663696a12.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606126; x=1786210926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJoxJA7wtIWPrShAfx9NmjhvsZJY/mMMlnUqmf7Sb/E=;
        b=ZQwaEtE+i8g+StS51xvWCJ5nK2v7UWNLYK6aMIgbgpv0gtzPq2cpA86RuL9rhgK2RP
         GQolEnC3Y0XL0LGYzfIVw+rBZ+q04VIscAWNtea43/Yzu2pQfm6Vb2WGUjW42KMo6T4J
         erC5/U6wVwYDNxx4LAgnhJIg7ZnVRRngFkDYpZK1b4odfhqyoDq1daUcMLY3GUHDB5u3
         265zbYqSAybpvTS1Umv/2P7PIKFCfOxQZRrNlSIXkJL+FwvFKYqRM+ej1hNyd0evp7jE
         DsO08hAYRDCVhHshgIGBk/9X0CXLPQ2746tnIdjUNAF0BQqCKyFTu37pFFSU88G3CrRF
         PH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606126; x=1786210926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJoxJA7wtIWPrShAfx9NmjhvsZJY/mMMlnUqmf7Sb/E=;
        b=W1rbCt2N6vO48YAMU3hmYUwV+ZgFW2rKLSmGSc4orB+7u7jPPd1GGbc2eW0Y+IsQJj
         4vFikx7Jll2wrIGWixWf4EK7QanLtELQqhO2qPJ4Xr8RwbQBOqPLek1SLOLERs/hfvgY
         ukXfUFr46V2ZCDJ6VMswU13/4Ym+SSbvdXYZONWfZykGnzhxjCHS9zc9qshtAgjsxVsS
         X30RZQ2ltktCvH6hg3qzSE6l0JNTKIuvytNyetnhsfVmnwHULo8dmmB8GESdGuvxgbQk
         Nm0+9Vqpd7fOtxJNSC2OHGPY2kY+O0Pm/sCfsWnoq4NzXSru5ZP6oAKc2xRT4xgYFx/n
         5DUQ==
X-Gm-Message-State: AOJu0Yy5IWd8jA02y73d9N+zLoDEQb/IYg96/v3QOlBpFR5v/3iOC6jH
	gbKw3rzTAPF/qj4iqYXMgkItYwXUkR3xkYYKVHpjiSH7Dwe38AYoHTSiC2eKYg==
X-Gm-Gg: AR+sD13ENXH0yMAwc9TOaLL1brXTIdSsgfOdIu4xLcBC/xc2yWxrNLpkSOKQMl3D5u2
	Pnl6QH+q4WZ7aoA8+0PuMWtBwMPrMxe+eVdCJIHBlgW9TbRdzSqKyqKDvCUw3whVEKWfae/SQwb
	+Se1N783Mx1YvLmQ9OsKRdpQ5xh58P6bM7cZ+o8J8K/cBOm2RfpcYRV/lALseiNPwvCut4CRvMi
	YH8zDTrjprKwZqc18WCu0bSt9QqOs1Nkko4xSF29XOq3pno92Ljr1ykcQQtjHUuXE5G4BnHpvnh
	QQxCVHK6nEQvYyLh7oVSG5uXxqcxMxWxPYsZ8uzoqPyY2OkUt45LsqowkFP7f+ZuwcS72CXaou2
	J1K8mag5YOQgihki5gnASL09GFFhoZ9vBB5UOSP8cy/05MHNV4iHsWsvBQK8AN9yvyeZCeGf9Ba
	/b3ddWEY9mWsqhgbfcz4FAAOWUBl+nGfxBWekq8yM4eEs6ii7mPgBBDUUbsvoeA5h1mW97nkK1Z
	lCMrtelTHWkXK5fi3GrRFUB8GrpHnzpw7cKxC6pBVK2aEo2vkZXdSLjpU0H4GBou2G+zEE4NgDS
	PQjS7BKH0LjhwAgBUkssrOk8y0e1PPBR3mrzW8wkSU7a4g==
X-Received: by 2002:a05:6a21:6f13:b0:3c4:2a97:fd2 with SMTP id adf61e73a8af0-3c92a8757b4mr4608577637.67.1785606125736;
        Sat, 01 Aug 2026 10:42:05 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153db2f911sm21489105eec.0.2026.08.01.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:42:05 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 06/10] blame: read precomputed hunks
Date: Sat,  1 Aug 2026 10:41:49 -0700
Message-ID: <20260801174156.2998808-7-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801174156.2998808-1-mmontalbo@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before diffing a target blob against a parent, offer the pair's identity
to the hunk provider interface.  Blame's requests have gone through
diff_provider_emit_hunks() since the interface arrived, but carried no
identity, so nothing could answer them.  Now blame fills in the pair's
blob object ids and its diff options, and the chain serves the pair from
the store, keyed by the ids and the request's xdiff flags, before the
terminal provider falls back to fill-and-compute.  Blame diffs at zero
context, which is not part of the key.  An answer replays the recorded
hunks through blame_chunk_cb without loading either blob; a request
carrying -I patterns or anchors is outside the key and always computes.

Blame withholds the identity where its diff is not the plain blob-pair
diff the key describes: reverse blame, ignored revisions, textconv
paths, and the working-tree or --contents pseudo-commit, whose blob is
not a stored object.  Those requests always compute.  Whitespace and
algorithm options such as -w instead change blame's xdl_opts, so the
consult keys a different entry and misses a store warmed without them.
Blame's default xdl_opts now come from DIFF_HUNKS_DEFAULT_XDL_OPTS, new
here, which records the key-relevant defaults a diff_options-based
consumer already carries (today the indent heuristic), so a default
blame run and a default "log --stat" warming run share keys by
construction.

"--show-stats" reports how many pairs the store served and how many
consultations it could not, read from diff_hunks_read_stats(); the store
counts its own consultations, so blame keeps no tally.

Extend t4220 with the blame side:

- parity for plain, --porcelain, and --incremental output, and hit and
  miss accounting across warming runs;
- the blame inputs that must bypass or miss the store: -w, indent
  heuristics, --reverse, textconv, -M/-C, and the --ignore-rev pass;
- rename and merge handling, and --contents;
- reading a truncated or corrupt store as absent, and a crafted
  zero-hunk record as a miss that verify flags.

Add p4218, measuring the cost of a warming run and the read speedups.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 blame.c                    |  39 ++++
 builtin/blame.c            |   8 +-
 diff.h                     |  11 ++
 t/meson.build              |   1 +
 t/perf/p4218-diff-hunks.sh |  48 +++++
 t/t4220-diff-hunks.sh      | 355 +++++++++++++++++++++++++++++++++++++
 6 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100755 t/perf/p4218-diff-hunks.sh

diff --git a/blame.c b/blame.c
index c3ef9c17f7..7d7671ef5d 100644
--- a/blame.c
+++ b/blame.c
@@ -24,6 +24,7 @@
 #include "bloom.h"
 #include "commit-graph.h"
 #include "diff-provider.h"
+#include "userdiff.h"
 
 define_commit_slab(blame_suspects, struct blame_origin *);
 static struct blame_suspects blame_suspects;
@@ -1937,6 +1938,24 @@ static int blame_chunk_cb(long start_a, long count_a,
 	return 0;
 }
 
+/*
+ * A hunk provider's key names the (old blob, new blob) pair and may only
+ * serve a diff whose result is determined by that pair and the xdiff
+ * settings. Textconv rewrites the buffers being diffed away from the
+ * blob contents the key names, so any origin whose path has a textconv
+ * driver must withhold the pair's identity.
+ */
+static int blame_textconv_active(struct blame_scoreboard *sb,
+				 const char *path)
+{
+	struct userdiff_driver *drv;
+
+	if (!sb->revs->diffopt.flags.allow_textconv)
+		return 0;
+	drv = userdiff_find_by_path(sb->repo->index, path);
+	return drv && drv->textconv;
+}
+
 struct blame_diff_fill_data {
 	struct blame_scoreboard *sb;
 	struct blame_origin *parent, *target;
@@ -1973,6 +1992,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	struct blame_diff_fill_data fill_data = { sb, parent, target, ignore_diffs };
 	xpparam_t xpp = { .flags = sb->xdl_opts };
 	struct diff_provider_request req = { .repo = sb->repo, .xpp = &xpp };
+	int provider_usable;
 
 	if (!target->suspects)
 		return; /* nothing remains for this target */
@@ -1983,6 +2003,25 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	d.ignore_diffs = ignore_diffs;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
+	/*
+	 * Offer the pair's identity only where blame's diff is the plain
+	 * blob-pair diff the recording key describes; reverse blame,
+	 * ignored revisions, and textconv paths withhold it and always
+	 * compute.  The working-tree/--contents pseudo-commit (marked by
+	 * its null commit id) holds a blob that is not a stored object,
+	 * so its pairs withhold identity too: no id may be sent that
+	 * names bytes a provider cannot look up.
+	 */
+	provider_usable = !sb->reverse && !ignore_diffs &&
+		!is_null_oid(&target->commit->object.oid) &&
+		!blame_textconv_active(sb, target->path) &&
+		!blame_textconv_active(sb, parent->path);
+
+	if (provider_usable) {
+		req.old_oid = &parent->blob_oid;
+		req.new_oid = &target->blob_oid;
+	}
+	req.diffopt = &sb->revs->diffopt;
 	if (diff_provider_emit_hunks(&req, blame_diff_fill, &fill_data,
 				     blame_chunk_cb, &d) == DIFF_PROVIDER_ERROR)
 		die("unable to generate diff (%s -> %s)",
diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..7891d82ae6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -15,6 +15,7 @@
 #include "hex.h"
 #include "commit.h"
 #include "diff.h"
+#include "diff-hunks.h"
 #include "revision.h"
 #include "quote.h"
 #include "string-list.h"
@@ -1060,7 +1061,7 @@ int cmd_blame(int argc,
 parse_done:
 	revision_opts_finish(&revs);
 	no_whole_file_rename = !revs.diffopt.flags.follow_renames;
-	xdl_opts |= revs.diffopt.xdl_opts & XDF_INDENT_HEURISTIC;
+	xdl_opts |= revs.diffopt.xdl_opts & DIFF_HUNKS_DEFAULT_XDL_OPTS;
 	revs.diffopt.flags.follow_renames = 0;
 	argc = parse_options_end(&ctx);
 
@@ -1315,9 +1316,14 @@ int cmd_blame(int argc,
 	output(&sb, output_option);
 
 	if (show_stats) {
+		unsigned long hunk_hits, hunk_misses;
+
+		diff_hunks_read_stats(sb.repo, &hunk_hits, &hunk_misses);
 		printf("num read blob: %d\n", sb.num_read_blob);
 		printf("num get patch: %d\n", sb.num_get_patch);
 		printf("num commits: %d\n", sb.num_commits);
+		printf("num precomputed hits: %lu\n", hunk_hits);
+		printf("num precomputed misses: %lu\n", hunk_misses);
 	}
 
 cleanup:
diff --git a/diff.h b/diff.h
index 6166598eea..380a258878 100644
--- a/diff.h
+++ b/diff.h
@@ -231,6 +231,17 @@ static inline void diff_flags_or(struct diff_flags *a,
 
 #define DIFF_WITH_ALG(opts, flag)   (((opts)->xdl_opts & ~XDF_DIFF_ALGORITHM_MASK) | XDF_##flag)
 
+/*
+ * The xdl_opts bits git turns on by default that a from-scratch xdl_opts
+ * (git blame's own option parsing) does not set, and so must OR in to match
+ * a store warmed at the default diff settings; a diff_options-based consumer
+ * (diffstat) already has them in o->xdl_opts. Today this is only the indent
+ * heuristic. It does NOT cover a non-default diff.algorithm: a repo that
+ * configures one records under that algorithm, and a consumer keying without
+ * it misses (a lost hit, not wrong output).
+ */
+#define DIFF_HUNKS_DEFAULT_XDL_OPTS XDF_INDENT_HEURISTIC
+
 enum diff_words_type {
 	DIFF_WORDS_NONE = 0,
 	DIFF_WORDS_PORCELAIN,
diff --git a/t/meson.build b/t/meson.build
index c63c30ba63..3f45b09dd6 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1158,6 +1158,7 @@ benchmarks = [
   'perf/p4205-log-pretty-formats.sh',
   'perf/p4209-pickaxe.sh',
   'perf/p4211-line-log.sh',
+  'perf/p4218-diff-hunks.sh',
   'perf/p4220-log-grep-engines.sh',
   'perf/p4221-log-grep-engines-fixed.sh',
   'perf/p5302-pack-index.sh',
diff --git a/t/perf/p4218-diff-hunks.sh b/t/perf/p4218-diff-hunks.sh
new file mode 100755
index 0000000000..f849e97832
--- /dev/null
+++ b/t/perf/p4218-diff-hunks.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='diff-hunks store performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# Pick a file to blame pseudo-randomly. The sort key is the blob
+# hash, so it is stable.
+test_expect_success 'select a file' '
+	git ls-tree -r HEAD | grep ^100644 |
+	sort -k 3 | head -n 1 | cut -f 2 >filelist
+'
+
+file=$(cat filelist)
+export file
+
+# Warm the store the way an owner would: a stat walk with writing on.
+test_perf 'warm the store' '
+	git diff-hunks clear &&
+	GIT_DIFF_HUNKS_WRITE=1 git log --all --stat >/dev/null
+'
+
+test_expect_success 'ensure the store is warm for the timed reads' '
+	GIT_DIFF_HUNKS_WRITE=1 git log --all --stat >/dev/null
+'
+
+test_perf 'log --stat -1000 (store)' '
+	git log --stat -1000 >/dev/null
+'
+
+test_perf 'log --stat -1000 (no store)' '
+	git -c core.diffhunks=false log --stat -1000 >/dev/null
+'
+
+test_perf 'blame $file (store)' '
+	git blame "$file" >/dev/null
+'
+
+test_perf 'blame $file (no store)' '
+	git -c core.diffhunks=false blame "$file" >/dev/null
+'
+
+test_expect_success 'clean up store' '
+	git diff-hunks clear
+'
+
+test_done
diff --git a/t/t4220-diff-hunks.sh b/t/t4220-diff-hunks.sh
index 62329e1070..086c53f651 100755
--- a/t/t4220-diff-hunks.sh
+++ b/t/t4220-diff-hunks.sh
@@ -81,6 +81,49 @@ test_expect_success 'a second warming run refreshes the store in place' '
 	test_cmp expect actual
 '
 
+test_expect_success 'core.diffhunks=false disables lookups' '
+	warm &&
+	git -c core.diffhunks=false blame --show-stats file.txt >out 2>&1 &&
+	test_grep "num precomputed hits: 0" out
+'
+
+# Writing seeds from the current store and merges into it, so a later
+# warming run keeps the entries an earlier one recorded rather than
+# rebuilding. Warm one pair, then a different pair, and confirm the first
+# is still served.
+test_expect_success 'a later warming run preserves earlier entries' '
+	git init incr &&
+	(
+		cd incr &&
+		test_commit a1 f.txt "1" &&
+		test_commit a2 f.txt "1
+2" &&
+		test_commit a3 f.txt "1
+2
+3" &&
+		GIT_DIFF_HUNKS_WRITE=1 git diff --stat a1 a2 >/dev/null &&
+		git diff-hunks verify &&
+		GIT_DIFF_HUNKS_WRITE=1 git diff --stat a2 a3 >/dev/null &&
+		git diff-hunks verify &&
+
+		# Blaming as of a2 diffs the a1..a2 pair. If seeding had
+		# dropped it when the a2..a3 pair was warmed, this would
+		# report zero precomputed hits.
+		git blame --show-stats a2 -- f.txt >out 2>&1 &&
+		test_grep "num precomputed hits: [1-9]" out &&
+
+		# The second warm ADDED the a2..a3 pair; blaming a3 diffs
+		# both a2..a3 and a1..a2, so a hit on each shows the store
+		# gained the new pair while keeping the earlier one.
+		git blame --show-stats a3 -- f.txt >out3 2>&1 &&
+		test_grep "num precomputed hits: 2" out3 &&
+
+		no_store log --stat >expect &&
+		git log --stat >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'log --stat matches with and without the store' '
 	no_store log --stat >expect &&
 	warm &&
@@ -211,6 +254,14 @@ test_expect_success 'log -R --stat matches (reversed pairs keyed apart)' '
 	test_cmp expect actual
 '
 
+# One warm serves both diffstat and blame: the blob pairs a blame
+# walks are the same parent-child pairs the diffstat warm recorded.
+test_expect_success 'a single warming run serves both blame and diffstat' '
+	warm &&
+	git blame --show-stats file.txt >out 2>&1 &&
+	test_grep "num precomputed hits: [1-9][0-9]*" out
+'
+
 # The diffstat read path produces identical output on a hit or a miss, so
 # it emits a trace2 "read-hits" count to prove it consulted the store.
 test_expect_success 'diffstat consults the store (trace shows read hits)' '
@@ -221,6 +272,23 @@ test_expect_success 'diffstat consults the store (trace shows read hits)' '
 	test_grep ! read-hits trace_off.json
 '
 
+test_expect_success 'blame matches with and without the store' '
+	no_store blame file.txt >expect &&
+	warm &&
+	git blame file.txt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame --porcelain and --incremental match' '
+	no_store blame --porcelain file.txt >expect_p &&
+	no_store blame --incremental file.txt >expect_i &&
+	warm &&
+	git blame --porcelain file.txt >got_p &&
+	git blame --incremental file.txt >got_i &&
+	test_cmp expect_p got_p &&
+	test_cmp expect_i got_i
+'
+
 # Diff settings that change hunks but are not part of the store key must
 # bypass it in both directions, so output stays byte-identical to a
 # store-less run.
@@ -357,6 +425,26 @@ test_expect_success 'a whitespace-ignoring diff is not served default entries' '
 	)
 '
 
+test_expect_success 'blame -w stays correct and does not hit default entries' '
+	(
+		cd ws-repo &&
+		no_store blame -w f >expect &&
+		git blame -w --show-stats f >out 2>&1 &&
+		test_grep "num precomputed hits: 0" out &&
+		git blame -w f >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'blame with indentHeuristic off stays correct and misses' '
+	warm &&
+	git -c diff.indentHeuristic=false blame --show-stats file.txt >out 2>&1 &&
+	test_grep "num precomputed hits: 0" out &&
+	no_store -c diff.indentHeuristic=false blame file.txt >expect &&
+	git -c diff.indentHeuristic=false blame file.txt >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'a driver algorithm override keeps output correct and keys apart' '
 	git init driver-algo &&
 	(
@@ -391,6 +479,94 @@ test_expect_success 'a driver algorithm override keeps output correct and keys a
 	)
 '
 
+test_expect_success 'blame --reverse never consults the store' '
+	warm &&
+	git blame --reverse HEAD~3..HEAD file.txt >actual 2>/dev/null &&
+	no_store blame --reverse HEAD~3..HEAD file.txt >expect 2>/dev/null &&
+	test_cmp expect actual &&
+	# Reverse blame withholds the pair identity. Zero hits alone
+	# cannot prove that: reverse pairs are never warmed, so a
+	# consulted pair would miss, not hit. Zero misses is what shows
+	# the store was never consulted.
+	git blame --reverse --show-stats HEAD~3..HEAD file.txt \
+		>stats 2>/dev/null &&
+	test_grep "num precomputed hits: 0" stats &&
+	test_grep "num precomputed misses: 0" stats
+'
+
+test_expect_success 'blame with a textconv driver bypasses the store' '
+	echo "tc.txt diff=tc" >>.gitattributes &&
+	git add .gitattributes &&
+	git commit -m tc-attr &&
+	git config diff.tc.textconv "sed -e s/1/one/" &&
+	test_commit tc1 tc.txt "line 1" &&
+	test_commit tc2 tc.txt "line 1
+line 2" &&
+	warm &&
+	git blame --show-stats tc.txt >out 2>&1 &&
+	test_grep "num precomputed hits: 0" out &&
+	no_store blame tc.txt >expect &&
+	git blame tc.txt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'a replaced blob makes the store step aside' '
+	git init replace-repo &&
+	(
+		cd replace-repo &&
+		test_commit r1 f.txt "a" &&
+		test_commit r2 f.txt "a
+b" &&
+		warm &&
+		# Control: without a replacement the pair is served.
+		GIT_TRACE2_EVENT="$PWD/trace_ctl.json" \
+			git log -1 --format= --numstat -- f.txt >/dev/null &&
+		test_grep read-hits trace_ctl.json &&
+		# Replace r2 blob: the diff now reads different content
+		# (through OBJECT_INFO_LOOKUP_REPLACE) under the id the store
+		# keyed, so a served answer would be the pre-replacement diff.
+		# Identity is withheld, the store steps aside, and the builtin
+		# computes from the replaced content.
+		new_blob=$(git rev-parse HEAD:f.txt) &&
+		repl=$(printf "a\nB\nC\nD\n" | git hash-object -w --stdin) &&
+		git replace "$new_blob" "$repl" &&
+		no_store log -1 --format= --numstat -- f.txt >expect &&
+		git log -1 --format= --numstat -- f.txt >actual &&
+		test_cmp expect actual &&
+		GIT_TRACE2_EVENT="$PWD/trace_repl.json" \
+			git log -1 --format= --numstat -- f.txt >/dev/null &&
+		test_grep ! read-hits trace_repl.json
+	)
+'
+
+test_expect_success 'blame -M and -C stay correct with the store' '
+	warm &&
+	no_store blame -M file.txt >expect_m &&
+	no_store blame -C file.txt >expect_c &&
+	git blame -M file.txt >got_m &&
+	git blame -C file.txt >got_c &&
+	test_cmp expect_m got_m &&
+	test_cmp expect_c got_c
+'
+
+# Copy-detecting (and reverse) blame still diff blob pairs through
+# pass_blame_to_parent, so they must use the real blame xdl_opts. A
+# whitespace-only change is invisible under -w; if -w were dropped on
+# these paths the -w and non-w results would coincide.
+test_expect_success 'blame -C honors -w' '
+	git init -q blame-cw &&
+	(
+		cd blame-cw &&
+		printf "one\ntwo\nthree\n" >f &&
+		git add f && git commit -q -m base &&
+		printf "one\n  two  \nthree\n" >f &&
+		git add f && git commit -q -m reindent &&
+		git blame -C -w f >with_w &&
+		git blame -C f >without_w &&
+		! test_cmp with_w without_w
+	)
+'
+
 # Cover the pair shapes an object walk encounters: binary and
 # mode-only changes produce no text hunks to record.
 test_expect_success 'binary and mode-only changes do not break the writer' '
@@ -411,6 +587,92 @@ test_expect_success 'binary and mode-only changes do not break the writer' '
 	test_cmp expect actual
 '
 
+test_expect_success 'blame across a rename matches' '
+	echo "original content" >rename-src.txt &&
+	git add rename-src.txt &&
+	git commit -m "add rename-src" &&
+	echo "more" >>rename-src.txt &&
+	git add rename-src.txt &&
+	git commit -m "modify rename-src" &&
+	git mv rename-src.txt rename-dst.txt &&
+	git commit -m "rename" &&
+	echo "post" >>rename-dst.txt &&
+	git add rename-dst.txt &&
+	git commit -m "modify after rename" &&
+	no_store blame rename-dst.txt >expect &&
+	warm &&
+	git blame rename-dst.txt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'blame handles merge commits' '
+	git checkout -b merge-side main~2 &&
+	test_commit merge-change merge-file.txt "side content" &&
+	git checkout main &&
+	git merge --no-edit merge-side &&
+	no_store blame merge-file.txt >expect &&
+	warm &&
+	git blame merge-file.txt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'distinct --contents against one revision do not collide' '
+	warm &&
+	test_write_lines "line 1" "appended line" >c1 &&
+	test_write_lines "rewritten line" >c2 &&
+	# Ground truth without the store.
+	no_store blame -s --contents=c2 file.txt initial >expect &&
+	# With the store, an intervening c1 run must not poison the c2 lookup.
+	git blame -s --contents=c1 file.txt initial >/dev/null &&
+	git blame -s --contents=c2 file.txt initial >actual &&
+	test_cmp expect actual &&
+	# The --contents side is a working-tree pseudo-commit (a null commit
+	# id), so its pairs withhold identity and never consult the store.
+	# Output parity alone cannot show that: a consulted unwarmed pair
+	# would miss, not hit, so zero misses is what proves the pair was
+	# never looked up.
+	git blame -s --show-stats --contents=c2 file.txt initial >stats 2>&1 &&
+	test_grep "num precomputed hits: 0" stats &&
+	test_grep "num precomputed misses: 0" stats
+'
+
+test_expect_success 'blame --ignore-rev bypasses the store for ignored pairs' '
+	git init ignore-rev-repo &&
+	(
+		cd ignore-rev-repo &&
+		test_commit ir1 f.txt "base" &&
+		test_commit ir2 f.txt "base
+more" &&
+		warm &&
+		# Control: the ordinary pass is served, nothing is computed.
+		git blame --show-stats f.txt >ctl 2>&1 &&
+		test_grep "num precomputed hits: 1" ctl &&
+		test_grep "num get patch: 0" ctl &&
+		no_store blame --ignore-rev ir2 f.txt >expect &&
+		git blame --ignore-rev ir2 f.txt >actual &&
+		test_cmp expect actual &&
+		# The ignored revision adds a pass that withholds identity:
+		# it computes its diff (get patch rises) instead of being
+		# served or even counted as a store consultation.
+		git blame --ignore-rev ir2 --show-stats f.txt >stats 2>&1 &&
+		test_grep "num precomputed hits: 1" stats &&
+		test_grep "num precomputed misses: 0" stats &&
+		test_grep "num get patch: 1" stats
+	)
+'
+
+test_expect_success 'blame counts misses for pairs the store does not hold' '
+	(
+		cd ignore-rev-repo &&
+		test_commit ir3 f.txt "base
+more
+third" &&
+		git blame --show-stats f.txt >stats 2>&1 &&
+		test_grep "num precomputed hits: 1" stats &&
+		test_grep "num precomputed misses: 1" stats
+	)
+'
+
 test_expect_success 'log -L --stat neither reads nor records' '
 	warm &&
 	GIT_TRACE2_EVENT="$PWD/trace_linelog.json" \
@@ -421,6 +683,67 @@ test_expect_success 'log -L --stat neither reads nor records' '
 	test_path_is_missing $STORE
 '
 
+# Integrity: a structurally broken header is read as absent (the reader
+# falls back to xdiff and stays correct); a checksum mismatch is caught
+# by verify, which is when integrity is checked.
+test_expect_success 'a truncated store is read as absent' '
+	warm &&
+	test_copy_bytes 20 <$STORE >truncated &&
+	mv truncated $STORE &&
+	no_store blame file.txt >expect &&
+	git blame file.txt >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'a corrupt signature is read as absent' '
+	warm &&
+	printf "XXXX" >corrupt &&
+	tail -c +5 <$STORE >>corrupt &&
+	mv corrupt $STORE &&
+	no_store blame file.txt >expect &&
+	git blame file.txt >actual &&
+	test_cmp expect actual
+'
+
+# Byte 6 of the header is the chunk count; a value larger than the file
+# can hold must be rejected before the chunk table is walked.
+test_expect_success 'an over-claimed chunk count is read as absent' '
+	warm &&
+	printf "\377" | dd of=$STORE bs=1 seek=6 count=1 conv=notrunc 2>/dev/null &&
+	no_store blame file.txt >expect &&
+	git blame file.txt >actual &&
+	test_cmp expect actual
+'
+
+# A record with no hunks would replay as an equivalence claim, which
+# the writer never records; the reader must treat such a record as a
+# miss and recompute, and verify must flag it.
+test_expect_success 'a zero-hunk record is read as a miss and fails verify' '
+	git init zero-hunk &&
+	(
+		cd zero-hunk &&
+		test_commit z1 f.txt "base" &&
+		test_commit z2 f.txt "base
+more" &&
+		warm &&
+		# The store holds one entry of one hunk: a 4-byte count and
+		# one 16-byte hunk record, just before the trailing
+		# checksum. Zero the count to craft the record the writer
+		# refuses to produce.
+		rawsz=$(test_oid rawsz) &&
+		fsize=$(test_file_size $STORE) &&
+		printf "\\0\\0\\0\\0" | dd of=$STORE bs=1 \
+			seek=$((fsize - rawsz - 20)) count=4 conv=notrunc \
+			2>/dev/null &&
+		no_store blame f.txt >expect &&
+		git blame --show-stats f.txt >stats 2>&1 &&
+		test_grep "num precomputed hits: 0" stats &&
+		git blame f.txt >actual &&
+		test_cmp expect actual &&
+		test_must_fail git diff-hunks verify
+	)
+'
+
 test_expect_success 'verify succeeds on a valid store and on an absent one' '
 	warm &&
 	git diff-hunks verify &&
@@ -454,6 +777,38 @@ test_expect_success 'a warm discards a corrupt store rather than seeding from it
 	test_cmp expect actual
 '
 
+# A generated patch must carry the builtin diffstat, not one served from
+# the sender's local store, so its counts do not depend on whether the
+# sender warmed the store. Poison the store so a served answer diverges
+# from the builtin, then confirm format-patch shows the builtin counts.
+test_expect_success 'format-patch keeps its diffstat off the store' '
+	git init fp-repo &&
+	(
+		cd fp-repo &&
+		test_commit p1 f.txt "a" &&
+		test_commit p2 f.txt "a
+b" &&
+		warm &&
+		# Bump the new-side count of the single recorded hunk. The
+		# record stays structurally valid, and a read skips the
+		# trailing checksum, so the store serves this poisoned count.
+		rawsz=$(test_oid rawsz) &&
+		fsize=$(test_file_size .git/objects/info/diff-hunks) &&
+		printf "\\0\\0\\0\\7" | dd of=.git/objects/info/diff-hunks bs=1 \
+			seek=$((fsize - rawsz - 4)) count=4 conv=notrunc 2>/dev/null &&
+		# The store now serves a divergent count, proving the poison
+		# is live and observable through a store consumer.
+		printf "7\t0\tf.txt\n" >poisoned &&
+		git log -1 --format= --numstat -- f.txt >served &&
+		test_cmp poisoned served &&
+		# format-patch does not consult the store, so its output is
+		# identical with the store poisoned and with it disabled.
+		no_store format-patch -1 --stdout --stat -- f.txt >expect &&
+		git format-patch -1 --stdout --stat -- f.txt >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'diff-hunks clear removes the store file' '
 	warm &&
 	test_path_is_file $STORE &&
-- 
2.54.0

