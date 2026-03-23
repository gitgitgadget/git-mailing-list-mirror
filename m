Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14EC39526D
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266029; cv=none; b=aj5yS23ctgESA0AAhnlz/QlPw4yrDqmeiF+V+n6BAYCYLPavSqzQ618IMQtVSZ3QPCOnw8Qnsze1GNk75dTS68B8w6yTRtM2kXcSALiMx6AWWDN9j1kx3Lue5Jnj1C3EiCWAe23BN4X8V524K7AMsp1SjCt+7/wvQ9H38ucHCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266029; c=relaxed/simple;
	bh=Dc+gSb9kAZZCw2CM059JiNTiGboFvHrLIw8NEEfNafM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Fw0qbWoeReixZvVbOGBObRH6Jh6mNZ6cop2gSwE1h6WIUb1CZm5dyyEnYW6taxF46vhfOCbgiSCSpJn04cw/ybKrjeafUIeOKPnbm6o59xix4SY8uXM7fc3sQuoyizbiR8ISW7iuSl1J9ToFUOJr99o31xDYdJ4rCmJdBJoeLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNv/NROc; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNv/NROc"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4615855eec.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266027; x=1774870827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9WG22LNe/KuiLeUWF24h8T+ww3D4g9W8Uv/qreSLGc=;
        b=mNv/NROcJ7ZG8a2J1OgSgzh0x73bB+Czg7uQaK2uOGKPUuxtq+73pKpBOfbnxjo+4l
         oxqo8ucpxN3GI8c6ptDIfNwgDJpJZ0fuzX5Q4K8PTEe5QU6O+TFC40WFPDyRQWpgyKKK
         0IK+bPxA74MKIosH65mB9ihTr4La/zkOfq70El8uhO1t0XjZMpajfq4jnxoiX4kl4u/+
         9bn9J45qdk3RBRbkKmmIcjUSoJiLWuxaXOXCWOHo+VbKCG3Rj7zoXMniNatGLFbtgUdD
         mIqXBBvlhCdSG1wjhlKu2bFFJZaynF8lokFI6NDeApHZMlb2ZdaPoHXfQycELE6OKNzP
         aBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266027; x=1774870827;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9WG22LNe/KuiLeUWF24h8T+ww3D4g9W8Uv/qreSLGc=;
        b=sBgjLJsVJgOkiA0fEkgXWDXoDqYz+IAhgwq5XpCaZHLJTaZLmgPsYBh7Kaq4V9ybzW
         SLD53pZHhJNt/RzhZDHpt95BPwxDklgb/fxXeUSvS5H/q5Gv4NwLoY8eRTr05SABEs6c
         a1RFN0ShZkkk4pgAlDKFEvv4JxYQrtVqP5ASFd1oXPZVMWbEowdbnhTiQ2Pb7k66kuZU
         pjT4+Fz7PoI/a7vprC4J4CyIkdLBaxCjDaKaZoAOJYpPdIRpbXRgT4uXDUMDwWiPpB13
         GqxaZrwI2NqKAfPwNI1nJlzW6C7tYQRhrkyOKskFnFZj1u58YFizWvdBlXsBxAHKuLwF
         unAQ==
X-Gm-Message-State: AOJu0YyZ5Alk9RuySBiYqGh3wzW+nudd65/ASx8Hmk0/X8QI/g+S8qln
	7vMTORKQqi2cy3dmVREmgyM8JXKfzOgpOIo0pJajKsTFXL/BEbxWPG2KTjLNxA==
X-Gm-Gg: ATEYQzxwEvL0ypOix9R/wPDYxSNVaKNlShwQAp6df2S2zg0C3kXwplEDmt4LjXcehXi
	2AVMMtNLoFrjSQNHqBYQE/e4XFqkMilVNCb4X+tdPyQBQF6YFydqeg8DB10dtuON8HubGIYFZBa
	S15DB8YBjn8jkiWcx1gn5tR6kDRNIoy/AhlQju7l9AINTxQnB82V/UH+Io96cNay21Hg8XroIur
	eSVRu3kbDRP1eNply+JB08HJlo0jRGHIZTD5mUEE7gggN1nR7WV1AEnUEPN85bvB5WsUnIbl9CZ
	f5Aid6+6q44SzLFlVlWZJWriDGdopus2vqt4AW8mdaKT34Hhd9bRyBOOAx7YAQ/h/ANFELzmZVJ
	+0WoxpWil4SfiAmZvzFec8rVAcMo/LMdtgqEQ2vamvw1fRSZoOHZ4tQeGFtbWcIMnthAOueq8ne
	6As3D56dWXyTNn0acqovh6c2A0E0M=
X-Received: by 2002:a05:7300:dc96:b0:2c0:d67f:35f4 with SMTP id 5a478bee46e88-2c1093dbc99mr4170870eec.0.1774266026468;
        Mon, 23 Mar 2026 04:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29b447sm12508419eec.16.2026.03.23.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:40:25 -0700 (PDT)
Message-Id: <610a162973a7ad59eba4ef4d5a9288f1fea1d2e8.1774266019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Mar 2026 11:40:16 +0000
Subject: [PATCH v2 3/6] backfill: accept revision arguments
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
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
 Documentation/git-backfill.adoc |   5 +-
 builtin/backfill.c              |  19 ++--
 t/t5620-backfill.sh             | 156 ++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index b8394dcf22..246ab417c2 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -63,9 +63,12 @@ OPTIONS
 	current sparse-checkout. If the sparse-checkout feature is enabled,
 	then `--sparse` is assumed and can be disabled with `--no-sparse`.
 
+You may also specify the commit limiting options from linkgit:git-rev-list[1].
+
 SEE ALSO
 --------
-linkgit:git-clone[1].
+linkgit:git-clone[1],
+linkgit:git-rev-list[1]
 
 GIT
 ---
diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..90c9d84793 100644
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
+		add_head_to_pending(&ctx->revs);
 
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

