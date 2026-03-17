Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E321D5B0
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707370; cv=none; b=lDWqmGwVKCCwHXxOhzybcVVFI/ND/jS/AJFtOQPMwLtOz2lJ1geCEtJtF/4wZ/8YsusoD5WzHRTCWj8HFe4eaJXe3ZpK5QxFr40APwHNuPCCU1mNqKUfbIoFzZ71KPMlJypHAonmKNt8owZke/+p+JuQ7s1HBlDkJ0n/TbwESmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707370; c=relaxed/simple;
	bh=A5f8q21+VktceoF5lv9FFZLH2U7A2V7xMp+Xmd/BAbQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OA5WCZruoLqcUvSQkNqCg46k5Li7x0Bn9690ij58wfNJN2LUaFMoBD1sOd6PHlEdKhlTQLP8KfF1fmYWtJXTpYGLY+8pdz8qZUjZTVoUF8v8u6j6q5zuZww+fH7uHgpc2DSkU17fWGXPaA5EAfzUfaMOjBKCweJ7d2VLQ7Q17ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNEHGiCq; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNEHGiCq"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732e6a123so699730c88.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707367; x=1774312167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg5EZqqFeKnHu34BEJRIMCaLyDej6VWKxi619BVhKbw=;
        b=VNEHGiCqhjQxKby6nuLdE8j7gKO40RrpbW4lcYR9EXP5Lya7tpdzr3+l6lb+ZWrjWz
         CTS+Mg01tocui270Wxfjo5JbFbNVvlTIhwkGSacnmwY0Q7LuIU3rhuG+X4c3x85wBgfD
         vBGTalNgWEnGi1IbN6yB+VdsqpNgUApwsmolFXUbaVLpor89cZZtWeGb+Q1eruwvKixT
         WNPxxEXpLehyEuITxrBHY03Baw3q9rYXnwZfkGrigKd/MkQUNFkNWrzyJyg9egQ1AW8L
         H8CYi7HEr+s9OSFu6XpY+s2/PjW70t8L7wIis743pk2tGUoo9PKzfQQMH9BM8Z9LP9re
         yJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707367; x=1774312167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wg5EZqqFeKnHu34BEJRIMCaLyDej6VWKxi619BVhKbw=;
        b=V231Miax/ri9h4loXTUuxJ4bcx20TeUOd0ayb5t5vNID1rjNxbcwgz75QBRtmeEwVB
         YmSI6kZ7oSfVMqnmQSXTX1wRyCeClyPoWjwpBsrnE88+zVJF/GMpx73Bvw5tDdeq9sEx
         q+O5TtTtChLf0Xrn0l5Rugjh6d0WGp6Mfyv7jt/YfkbImnS+yTRX4ZIHJwOBYeISweCh
         ahEtPKxMkz0NIojLnTaBWR7FZxSHZJ4xk4UkxCe6hG41F/gTFVWDf3RLoaxSXEMQcp7n
         QEf+0TEjXlMUAA5mADfIX3JMOSNMVVhe1Q0Td5av+79QZeS3OQ9DX62VOWxvXkQJWv08
         rbqQ==
X-Gm-Message-State: AOJu0Yy4qgwhMX//trSaF34p5ZRZq2eQHTgnaeg1vfptka5AU20CN8LR
	JHq9oh0BdpymB1zuOrMmvQ4h/w/Eyv4r4DuDyFCCLHUi9MB5WM5WBDsxsq0azA==
X-Gm-Gg: ATEYQzwAmhItNpmDgU1ztmH812+J59f8g+jRCvnd8iahHMapwl0x56RQ2Bd0MuHkqVY
	tAKeTElKgaMck+p1lcCk+p+TU+EKtqIZPMuJ9YwgfZ3/LGNOr9bygklxQF5Z6BaJEmyQx4SRI40
	wXP/gvXXXG8T9kBr8jguhOBU4vqc6Z+pNgQyZWsxNf9hehxY38C1oFSPz4fxeGcj08o7BNY19DA
	Z5nKW7+U+lZTAmjrcJ7YqhG+AOP0NQRNfbyIIYV5PUYvC0L4tvYLOOdjPGgscYggQi3nU7kZdAB
	rq4DpLpfiYxe+FOHCzv3fZvg5U81XHiZtdpejs0EMUVHeOMAx2x+aWCGuYY4RMzWczNY0K6hpp4
	pxnV+5iM/drh8IprDwXf0mnQTF8q3k90o8J75ZBTzbJ31HrdLcpmbIWfWjajT+LQ75FEFp5DPcD
	XpVEPdG6CbZoAn4wIvVvDRvtmCeQ==
X-Received: by 2002:a05:7300:fb86:b0:2ba:931e:7021 with SMTP id 5a478bee46e88-2bea5720289mr6743417eec.34.1773707367100;
        Mon, 16 Mar 2026 17:29:27 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.136.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0b86f9e7esm9895683eec.30.2026.03.16.17.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:29:26 -0700 (PDT)
Message-Id: <dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 00:29:19 +0000
Subject: [PATCH 3/5] backfill: accept revision arguments
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

The existing implementation of 'git backfill' only includes downloading
missing blobs reachable from HEAD. Advanced uses may desire more general
commit limiting options, such as '--all' for all references, specifying a
commit range via negative references, or specifying a recency of use such as
with '--since=<date>'.

All of these options are available if we use setup_revisions() to parse the
unknown arguments with the revision machinery. This opens up a large number
of possibilities, only a small set of which are tested here.

For documentation, we avoid duplicating the option documentation and instead
link to the documentation of 'git rev-list'.

Note that these arguments currently allow specifying a pathspec, which
modifies the commit history checks but does not limit the paths used in the
backfill logic. This will be updated in a future change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.adoc |   3 +
 builtin/backfill.c              |  19 ++--
 t/t5620-backfill.sh             | 156 ++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index b8394dcf22..fdfe22d623 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -63,9 +63,12 @@ OPTIONS
 	current sparse-checkout. If the sparse-checkout feature is enabled,
 	then `--sparse` is assumed and can be disabled with `--no-sparse`.
 
+You may also specify the commit limiting options from linkgit:git-rev-list[1].
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
+linkgit:git-rev-list[1].
 
 GIT
 ---
diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..1b5595b27c 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -35,6 +35,7 @@ struct backfill_context {
 	struct oid_array current_batch;
 	size_t min_batch_size;
 	int sparse;
+	struct rev_info revs;
 };
 
 static void backfill_context_clear(struct backfill_context *ctx)
@@ -80,7 +81,6 @@ static int fill_missing_blobs(const char *path UNUSED,
 
 static int do_backfill(struct backfill_context *ctx)
 {
-	struct rev_info revs;
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	int ret;
 
@@ -92,13 +92,14 @@ static int do_backfill(struct backfill_context *ctx)
 		}
 	}
 
-	repo_init_revisions(ctx->repo, &revs, "");
-	handle_revision_arg("HEAD", &revs, 0, 0);
+	/* Walk from HEAD if otherwise unspecified. */
+	if (!ctx->revs.pending.nr)
+		handle_revision_arg("HEAD", &ctx->revs, 0, 0);
 
 	info.blobs = 1;
 	info.tags = info.commits = info.trees = 0;
 
-	info.revs = &revs;
+	info.revs = &ctx->revs;
 	info.path_fn = fill_missing_blobs;
 	info.path_fn_data = ctx;
 
@@ -109,7 +110,6 @@ static int do_backfill(struct backfill_context *ctx)
 		download_batch(ctx);
 
 	path_walk_info_clear(&info);
-	release_revisions(&revs);
 	return ret;
 }
 
@@ -121,6 +121,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.current_batch = OID_ARRAY_INIT,
 		.min_batch_size = 50000,
 		.sparse = 0,
+		.revs = REV_INFO_INIT,
 	};
 	struct option options[] = {
 		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
@@ -134,7 +135,12 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 					 builtin_backfill_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
-			     0);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	repo_init_revisions(repo, &ctx.revs, prefix);
+	argc = setup_revisions(argc, argv, &ctx.revs, NULL);
 
 	repo_config(repo, git_default_config, NULL);
 
@@ -143,5 +149,6 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
+	release_revisions(&ctx.revs);
 	return result;
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 1331949be4..db66d8b614 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -224,6 +224,162 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
 	test_line_count = 12 missing
 '
 
+test_expect_success 'backfill with revision range' '
+	test_when_finished rm -rf backfill-revs &&
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-revs &&
+
+	# No blobs yet
+	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	git -C backfill-revs backfill HEAD~2..HEAD &&
+
+	# 30 objects downloaded.
+	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 18 missing
+'
+
+test_expect_success 'backfill with revisions over stdin' '
+	test_when_finished rm -rf backfill-revs &&
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-revs &&
+
+	# No blobs yet
+	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	cat >in <<-EOF &&
+	HEAD
+	^HEAD~2
+	EOF
+
+	git -C backfill-revs backfill --stdin <in &&
+
+	# 30 objects downloaded.
+	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 18 missing
+'
+
+test_expect_success 'backfill with prefix pathspec' '
+	test_when_finished rm -rf backfill-path &&
+	git clone --bare --filter=blob:none		        \
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-path &&
+
+	# No blobs yet
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	# TODO: The pathspec should limit the downloaded blobs to
+	# only those matching the prefix "d/f", but currently all
+	# blobs are downloaded.
+	git -C backfill-path backfill HEAD -- d/f &&
+
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 0 missing
+'
+
+test_expect_success 'backfill with multiple pathspecs' '
+	test_when_finished rm -rf backfill-path &&
+	git clone --bare --filter=blob:none		        \
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-path &&
+
+	# No blobs yet
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	# TODO: The pathspecs should limit the downloaded blobs to
+	# only those matching "d/f" or "a", but currently all blobs
+	# are downloaded.
+	git -C backfill-path backfill HEAD -- d/f a &&
+
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 0 missing
+'
+
+test_expect_success 'backfill with wildcard pathspec' '
+	test_when_finished rm -rf backfill-path &&
+	git clone --bare --filter=blob:none		        \
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-path &&
+
+	# No blobs yet
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	# TODO: The wildcard pathspec should limit downloaded blobs,
+	# but currently all blobs are downloaded.
+	git -C backfill-path backfill HEAD -- "d/file.*.txt" &&
+
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 0 missing
+'
+
+test_expect_success 'backfill with --all' '
+	test_when_finished rm -rf backfill-all &&
+	git clone --no-checkout --filter=blob:none		\
+		"file://$(pwd)/srv-revs.bare" backfill-all &&
+
+	# All blobs from all refs are missing
+	git -C backfill-all rev-list --quiet --objects --all --missing=print >missing &&
+	test_line_count = 54 missing &&
+
+	# Backfill from HEAD gets main blobs only
+	git -C backfill-all backfill HEAD &&
+
+	# Other branch blobs still missing
+	git -C backfill-all rev-list --quiet --objects --all --missing=print >missing &&
+	test_line_count = 2 missing &&
+
+	# Backfill with --all gets everything
+	git -C backfill-all backfill --all &&
+
+	git -C backfill-all rev-list --quiet --objects --all --missing=print >missing &&
+	test_line_count = 0 missing
+'
+
+test_expect_success 'backfill with --first-parent' '
+	test_when_finished rm -rf backfill-fp &&
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main			\
+		"file://$(pwd)/srv-revs.bare" backfill-fp &&
+
+	git -C backfill-fp rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 52 missing &&
+
+	# --first-parent skips the side branch commits, so
+	# s/file.{1,2}.txt v1 blobs (only in side commit 1) are missed.
+	git -C backfill-fp backfill --first-parent HEAD &&
+
+	git -C backfill-fp rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 2 missing
+'
+
+test_expect_success 'backfill with --since' '
+	test_when_finished rm -rf backfill-since &&
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main			\
+		"file://$(pwd)/srv-revs.bare" backfill-since &&
+
+	git -C backfill-since rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 52 missing &&
+
+	# Use a cutoff between commits 4 and 5 (between v1 and v2
+	# iterations). Commits 5-8 still carry v1 of files 2-4 in
+	# their trees, but v1 of file.1.txt is only in commits 1-4.
+	SINCE=$(git -C backfill-since log --first-parent --reverse \
+		--format=%ct HEAD~1 | sed -n 5p) &&
+	git -C backfill-since backfill --since="@$((SINCE - 1))" HEAD &&
+
+	# 6 missing: v1 of file.1.txt in all 6 directories
+	git -C backfill-since rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 6 missing
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

