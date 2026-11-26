Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701454;
	b=qN76fSpui6uV6w26CxfV7yk3vdNMogoEFnrCAsFa0hPHuyVmQ96TGZYnhE908vyBzLwN
	 vFIqsrApt4mblYdKvEHQ76D7Q9OxsBT4dvqzwvRePrILclqF6pTXEcYVPdppR5YTDD+y1
	 iygI4tUmUf7l/h98o0fE0aa6D36UuRXND0HUTH2PnzNHNkzvm2oB1Ibl762S3i64IejXn
	 Xe3bWxQPCOwdZrO64/oQVJPUNLsvf9WzFvJOruJt/LAhCOlxX4G8ZSLhN/yEjtDEJRk1Y
	 Zejf4DMbHHI2w894hBvGUMwoIwIlrfyZgUAF4vj7yb2KZG+W0pa0BfY1TV/lrhgb1cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=afZ6jeIFQfoqUjdXfN8pL7WtgxACZsV7tlQqfXciprM=;
	b=cy15Wa8UrBvFkUEUiGcLwcHgWwF4XASt/lb7Tzf6FDUKcIJUS+IsjW5Dw4F1PrWt0aIH
	 Vf0fHfId2L47hD9k2X3fXuwUGaS5BAku5ySdlxnbSvLKmIDEaAO70CqObT2Zfyof4S1pr
	 ZOCT8ZfisTboO3hUYnAnnhqFy/Cb2fuh5m7t7WaJ8BxeoqXz0P4z9hT8BlwmY+vIjfTxV
	 X5j7ColImre23AoVgV+uFw2evVkVnp3Zvu913HXv/ogHzpc1LEhM1c7/GDEyr6Mptp8NH
	 hnAO4SQLH2Hkag+XRGTHDrP7aMSz1Mhs4hbX9xUYM5XpnBZhu8Jha7nbYrvd6kBBBdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWbF0HY4;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CB606A329
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D0CB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWbF0HY4
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f269e335eso812715585a.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 05:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795701452; x=1796306252; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=afZ6jeIFQfoqUjdXfN8pL7WtgxACZsV7tlQqfXciprM=;
        b=hWbF0HY4WStWnCTZXJuM3kNIOgZtf1tsRMqKOEGWWbEEJ14z13RfYJdnuwmkfRb0oQ
         kYJvKnOs0RkwVs/QGODN2BDq3SD6EpEYt+iBeohaAePmsIopIP8Tiak0UylR50hR24lE
         /wHK7YDoVcn3lyH7rwZFSKOGuVd2jt57ZyTExPSV6v+iAzm9Fw5WlGm5gxGUKaf2UCZF
         uVtyqFt93OACOMvwNSshV+sAboQA+v7BbSBh9rQOSwOeOXycyTsAr6JpBngK48icdjlE
         O6NknSMyXSfSa4DhkpXAJiA973qkTOGo0L/WmoEU1tF1/5APfRqGo/rxl+vOdVoiaoe7
         0KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795701452; x=1796306252;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=afZ6jeIFQfoqUjdXfN8pL7WtgxACZsV7tlQqfXciprM=;
        b=AfdSKK4I3B5aX2q613L7N/OesQ8aCX5E5UNsAdE/UNmdsTxap+CymrfwuKnXaDJQGv
         11lh9jxI1HMhw2fhpDipuZVf6PMCG7cGtkVNgOhx/qjhXi2dkRTE2g1AHLAiACkdpH4Q
         /aQwVDPmWzHdSPxzJThM/1EXqpK54YE5YNUb9TDCWCU5212MEO+W5gPda7gdEJYB4MqR
         A+zc7TydA96BXLhRcdXWP40fpl/EyuAZNc00npRhJTEh54XFbDDx5I1E3gYeMfKYbxdY
         3+MJ4We1WbYh24dZ1lKdTf2Olf3Bx+F6MhqoanuV8ByN/zd3zudwxy8yEFNe48O8Cb4T
         4GRw==
X-Gm-Message-State: APuU4Z+E/ORxTTDy0iWS/Va1R6S/6S/aEJsP4xQmqbt1f5X21av14Tzz
	LQhYzcBbpkyLwALO0Ki02sXyWhPL4KmznzxMtRTCinDUhPO+Pck6GxSHBwgzcw==
X-Gm-Gg: AZFdTZdbQNjKNMQAG3YLUjm9mvPXVCGwAFxjeIl+fZKLr4vHOV38YKKU8LCPgboK1P9
	5X/y52Gnk/ffqRgFHQ2B+xqljivFbwJOOxf4aDwuRTzy3VovCX5r6Ky521f15AC54cPj7Lxl/nj
	mQqOzPbNNZ2Ea9oJ0a59UiesWXObhC/Q3PTGLddRV3ED5komTLsuyZLm21M4NNbtl/u7j55AI9C
	9Z4mcWQCMP+3QDE6v2iNcPfQqAv0ShG5Lec5rJ47iHwBww1+a0VeWO5P8PJnU1Hiea5e1D9b3li
	6iqWM+D5WEFZMShN8gUpiFF2MJMBQkhgCsb2S5Fhn5vcDmNumOIPUaoQiWO5QWjpputqH00zsXC
	cxU0q9yPXxlq1ItsHgf5+B9O2SoNQONet4Yg11nV4snuxfE+xksnVQbVEV50ubxZcPMmyqI52UJ
	ABbojnZ0lgHdcoYz56+rjtWrxBnTEZigCpmsm0BjYvR2b5UWVjFwfrEMp8lU9Uhs1lH9NmRFFSz
	ooeeFIAZe7XhTTOJsoeKG/QImG/G6WSy5CaaaOGSMdPw2MDa1jNnUtuKYQEyNerqbjV2Ds00YTg
	xuwSwYmzEzAk5nIlZBAUp8rtS15tjVeN5jgLmnrOqf2nZwsVS4Lccg==
X-Received: by 2002:a05:620a:6607:b0:93f:2ab9:7294 with SMTP id af79cd13be357-949ba99c4f3mr3750122485a.29.1795701452290;
        Thu, 26 Nov 2026 05:57:32 -0800 (PST)
Received: from [127.0.0.1] ([20.231.101.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ac11sm1583716785a.14.2026.11.26.05.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:57:31 -0800 (PST)
Message-Id: <pull.2337.git.1795701443098.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Nov 2026 13:57:23 +0000
Subject: [PATCH] read-cache: hash the shared index even with index.skipHash
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

The shared index of a split index is named after its trailing hash,
which the split index records in its "link" extension to find it.
Since ee1f0c242e (read-cache: add index.skipHash config option,
2023-01-06), do_write_index() skips that hash for the shared index
too, so with index.skipHash and core.splitIndex both set, the shared
index is written as "sharedindex.<null OID>" and the split index
records a null OID as its base. Reading the index back, a null base
means there is no shared index: the entries that were moved there are
lost, "git ls-files" no longer shows them and "git status" reports
them as deleted and untracked. With fsmonitor, it hits a BUG() in
fsmonitor.c instead, as the fsmonitor bitmap refers to more entries
than the index has.

Scalar sets index.skipHash since 05f28e4b3c (scalar: use
index.skipHash=true for performance, 2025-12-12), and feature.manyFiles
implies it. The tests that ran into this under GIT_TEST_SPLIT_INDEX
unset that variable instead, in 05f28e4b3c, in 7cce609e08 (t9210,
t9211: disable GIT_TEST_SPLIT_INDEX for scalar clone tests,
2026-04-15) and in a644ad5f34 (status: lock the index only to write
it, 2026-10-22).

Let the callers of do_write_index() decide whether to skip the hash,
and always compute it for the shared index. This keeps most of the
benefit: the shared index is rewritten only now and then (see
splitIndex.maxPercentChange), while the split index, written on every
index update, still skips it.

Add a test, and drop the workarounds, as those tests now pass with
GIT_TEST_SPLIT_INDEX.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    read-cache: hash the shared index even with index.skipHash

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2337%2Fblanet%2Fxx%2Fsplit-index-skip-hash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2337/blanet/xx/split-index-skip-hash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2337

 Documentation/config/index.adoc |  4 +++-
 read-cache.c                    | 18 ++++++++++++------
 t/t1700-split-index.sh          | 23 +++++++++++++++++++++++
 t/t7508-status.sh               | 10 ----------
 t/t9210-scalar.sh               | 10 ----------
 t/t9211-scalar-clone.sh         |  5 -----
 6 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/Documentation/config/index.adoc b/Documentation/config/index.adoc
index a23be914e3..e878145158 100644
--- a/Documentation/config/index.adoc
+++ b/Documentation/config/index.adoc
@@ -41,7 +41,9 @@ index.skipHash::
 	This accelerates Git commands that manipulate the index, such as
 	`git add`, `git commit`, or `git status`. Instead of storing the
 	checksum, write a trailing set of bytes with value zero, indicating
-	that the computation was skipped.
+	that the computation was skipped. The shared index of a split index
+	(see `core.splitIndex`) is still hashed, as it is named after its
+	hash.
 +
 If you enable `index.skipHash`, then Git clients older than 2.13.0 will
 refuse to parse the index and Git clients older than 2.40.0 will report an
diff --git a/read-cache.c b/read-cache.c
index 595497d14c..a734943c97 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2878,7 +2878,8 @@ enum write_extensions {
  * rely on it.
  */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-			  enum write_extensions write_extensions, unsigned flags)
+			  enum write_extensions write_extensions, unsigned flags,
+			  int skip_hash)
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
@@ -2900,9 +2901,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int nr, nr_threads, ret;
 
 	f = hashfd(the_repository->hash_algo, tempfile->fd, tempfile->filename.buf);
-
-	prepare_repo_settings(r);
-	f->skip_hash = r->settings.index_skip_hash;
+	f->skip_hash = skip_hash;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -3224,9 +3223,11 @@ static int do_write_locked_index(struct index_state *istate,
 		return ret;
 	}
 
+	prepare_repo_settings(istate->repo);
 	trace2_region_enter_printf("index", "do_write_index", istate->repo,
 				   "%s", get_lock_file_path(lock));
-	ret = do_write_index(istate, lock->tempfile, write_extensions, flags);
+	ret = do_write_index(istate, lock->tempfile, write_extensions, flags,
+			     istate->repo->settings.index_skip_hash);
 	trace2_region_leave_printf("index", "do_write_index", istate->repo,
 				   "%s", get_lock_file_path(lock));
 
@@ -3339,9 +3340,14 @@ static int write_shared_index(struct index_state *istate,
 	move_cache_to_base_index(istate);
 	convert_to_sparse(istate, 0);
 
+	/*
+	 * The shared index is named after its trailing hash, which the
+	 * split index records to find it: compute it even with
+	 * index.skipHash.
+	 */
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
-	ret = do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
+	ret = do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags, 0);
 	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 887e72a5fa..86eae9eb1d 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -544,4 +544,27 @@ test_expect_success 'GIT_TEST_SPLIT_INDEX works' '
 	)
 '
 
+test_expect_success 'shared index is hashed even with index.skipHash' '
+	git init skip-hash &&
+	(
+		cd skip-hash &&
+		git config core.splitIndex true &&
+		git config index.skipHash true &&
+		test_commit one &&
+		test_commit two &&
+
+		test-tool dump-split-index .git/index >dump &&
+		echo "own $ZERO_OID" >expect &&
+		grep "^own " dump >actual &&
+		test_cmp expect actual &&
+		base=$(sed -n "s/^base //p" dump) &&
+		test "$base" != "$ZERO_OID" &&
+		test_path_is_file .git/sharedindex.$base &&
+
+		git ls-files >actual &&
+		test_write_lines one.t two.t >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e10c961268..dde5dd1020 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1691,11 +1691,6 @@ do
 		git init update-after-read &&
 		(
 			cd update-after-read &&
-			if test $skip_hash = true
-			then
-				# index.skipHash does not work with a split index.
-				sane_unset GIT_TEST_SPLIT_INDEX
-			fi &&
 			git config index.skipHash $skip_hash &&
 			test_commit base &&
 			write_script .git/fsmonitor-hook <<-\EOF &&
@@ -1769,11 +1764,6 @@ do
 	test_expect_success "status refresh does not overwrite an index update made while collecting (index.skipHash=$skip_hash)" '
 		test_when_finished "rm -rf refresh-while-collecting" &&
 		(
-			if test $skip_hash = true
-			then
-				# index.skipHash does not work with a split index.
-				sane_unset GIT_TEST_SPLIT_INDEX
-			fi &&
 			setup_index_update_during_collection refresh-while-collecting &&
 			cd refresh-while-collecting &&
 			git config index.skipHash $skip_hash &&
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 137765d3b8..32ad85c577 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -152,10 +152,6 @@ test_expect_success 'set up repository to clone' '
 '
 
 test_expect_success 'scalar clone' '
-	# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
-	# incompatible: the shared index gets a null OID and fails to
-	# load on re-read.
-	sane_unset GIT_TEST_SPLIT_INDEX &&
 	second=$(git rev-parse --verify second:second.t) &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
@@ -186,7 +182,6 @@ test_expect_success 'scalar clone' '
 '
 
 test_expect_success 'scalar clone --no-... opts' '
-	sane_unset GIT_TEST_SPLIT_INDEX &&
 	# Note: redirect stderr always to avoid having a verbose test
 	# run result in a difference in the --[no-]progress option.
 	GIT_TRACE2_EVENT="$(pwd)/no-opt-trace" scalar clone \
@@ -251,10 +246,6 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 '
 
 test_expect_success 'scalar reconfigure --all with detached HEADs' '
-	# This test demonstrates an issue with index.skipHash=true and
-	# this test variable for the split index. Disable the test variable.
-	sane_unset GIT_TEST_SPLIT_INDEX &&
-
 	repos="two three four" &&
 	for num in $repos
 	do
@@ -317,7 +308,6 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 
 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
-	sane_unset GIT_TEST_SPLIT_INDEX &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index 002d6ecdc1..110985f58d 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -8,11 +8,6 @@ test_description='test the `scalar clone` subcommand'
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
 export GIT_TEST_MAINT_SCHEDULER
 
-# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
-# incompatible: the shared index gets a null OID and fails to
-# load on re-read.  Every test here uses scalar clone.
-sane_unset GIT_TEST_SPLIT_INDEX
-
 test_expect_success 'set up repository to clone' '
 	rm -rf .git &&
 	git init to-clone &&

base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
-- 
gitgitgadget
