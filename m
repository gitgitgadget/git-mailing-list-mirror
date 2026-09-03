Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66850311977
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411931; cv=none; b=PyOLg7bW8abACBLpRv6G/8YEEn2tXseLILVLb/AVOdl5LRbp1mdsHENnWhKwDjuffbfaWHtvv6n1+B8BOmIGyO05M057mOswWJnOpuRPUdfjYR+eAT6qhtLfXfxWxEzXL26On9V9nMp9XpxLImH+it64zllQ/Fz5Vimu5tXxmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411931; c=relaxed/simple;
	bh=eFvTTdNqaXRpUXpOG3v7UWqLz3LO4r9MAOxg+G2GoKU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=StQ1cG7ZIFn5qIp/AzbrNvytojP4ITgPGBEWFE3f+4L/ip1hDn8c5UG+oN/XD3oq0QBT6/osH2pyEaQtz5nkqsN3EihfYILSNqgH6AKifLYp78N3rGwL6PAnz0yLo7YhQQHnwCrJyg7AM3F/z4rhZjWiXgLt6b/1bQ8gGWzyMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf41rgfe; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf41rgfe"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e50a650a0so188763985a.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411928; x=1789016728; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9stpeuZEyQ2kX9jXAJxsan16tlqvCBYXh/5BXZczwdE=;
        b=Sf41rgfe47HkZYRF7nM+MBMoc+6KhkPtXdwp/KwGN0724/UIrVvm/oMMfpS8kegL4A
         vQ/ThgtCcTh4Rp8LvUqG312F7YY386ZHHC6vxiS8hw+h2nC+Yaydc5epaWVOKIOLAs2M
         B/iSu2DNva0s17PefYrapqaIlWcUnWq7TbFxm0LW/PludIH70wMfjWkIo/k0mfzswgI7
         BZC8c0D31JDxn0XGTO+PjGrGhOz1lZZil89hguRLPt7kR+CdCL9rG7XakDGgUjbrxvYA
         901qQjT/szA7CrBuhZsstqpP8jzujl0D42JoXt/Q0JvY7nkq1vW0H4KQymlIF6tLRcqS
         cyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411928; x=1789016728;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9stpeuZEyQ2kX9jXAJxsan16tlqvCBYXh/5BXZczwdE=;
        b=hSexxCR4pGf0Ng/fGWZIm4WGb673hCNJuPvpVM+csIDNp5Ni/AQ4phmRk0fgfJmiEU
         xihq9wBwxbDkmjkO63z7FPMphY2Bvn3cGkHLQ5UYaWHgMG5EuAxQf8FiQdTPHVIefqYn
         ogsc0ojNPTImbOjraxPATvslIYk/ntTSS3ixbDWHdCqmEo9bz8uo2JR6cgAH3+ijU7Ay
         iMjssYQqm+f3iiTETb1nhp7I0tKLqQHIFZ4aJMHFg9rOOtSz62F27bcv996Tz7BXDLEJ
         ufR2CE3AtdQ1vXzbBc+kNH7bjKPlFD8aHlNTj7LI0PMxZNUlQ26DH/d/n3AHgfhxT/C0
         Kavw==
X-Gm-Message-State: AFuF++nvzPbUR0XHgOa7EBcE6XbgbLTQVpsEQt42ckbjzfLK8J2Tpjc7
	IzUhHCMuXMXjvb16PYo8/H6YmyWCGBcx063mNBUdTA7jsfaPjqNyMguFDfIrfH77
X-Gm-Gg: AYBFou2GD8B56UEJ7mIGLpp8aEMbJkrR1JbgjwAwEPJO7hfErV3y8noCh72BanklzhU
	8yKi6+0Ahv3FKFXjwsRgwlC2lJ5iel5ojAfOFpgdqBhYKy6GZ0n2MdS0nnVn0qftSdjmOZlQBaK
	CfT1rqeIaE/AY/yZm3oYlHL9QSFhJcMQUKUwPdJjb3V5cWnXP4cWQBMHxBrDwku3Ul/VjjdUeof
	E0Ph3Q3hRQyamdskqIbydZa/KSk0ImtttNoCqQ3K8vIm4VH/ll1bdLUKyrmfeJ0Faj/pksSkAfm
	HVeFqu2URJMWto8k312xijQNRddsmMPVJKpuOK2a5qPaZnJCj4YJcBbB4ixb63fDNukGDjM06dA
	ewbwVVSKDHV7f5zFn204CbMWGmCNVPutxU+Xy2BCCIMFd7K6a1dlIGfsShCibgZjHBiQDVkHrkY
	LZxKL0h+NNEt8uj75WurB5W9ypiJGo8w39oATUZ1eQsuyKeF5vIYO96wXe6EO887IEut2jMIkMk
	a4sKJggH8GGLac7
X-Received: by 2002:a05:620a:3196:b0:92e:71bb:d1c0 with SMTP id af79cd13be357-93960dea964mr1138940085a.15.1788411927834;
        Wed, 02 Sep 2026 22:05:27 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f3b28f7sm408665885a.39.2026.09.02.22.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:05:27 -0700 (PDT)
Message-Id: <f12b61b9a408d23b8d8741571a9e9e030a69b6e0.1788411919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 05:05:17 +0000
Subject: [PATCH v3 5/7] diff: support stat formats with -L
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

Reuse the line_range_filter in builtin_diffstat() so -L supports
the stat formats and add tests verifying the new behavior.

Ungate the newly enabled options and drop "yet" from the generic
-L rejection message ("does not yet support the requested diff
format"). Some rejected formats do not fit -L at all, so "yet"
wrongly implies they are all awaiting support.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc |  10 +-
 diff.c                                |  13 ++-
 revision.c                            |   6 +-
 t/t4211-line-log.sh                   | 130 ++++++++++++++++++++++----
 4 files changed, 133 insertions(+), 26 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index 72f639b5e7..b3e8b5c62c 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -9,10 +9,12 @@
 	_<start>_ and _<end>_ (or _<funcname>_) must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`.
-	Non-patch diff formats `--raw`, `--name-only`, `--name-status`,
-	and `--summary` are supported.  Diff stat formats
-	(`--stat`, `--numstat`, `--shortstat`, `--dirstat`) are not
-	currently implemented.
+	The following non-patch diff formats are supported: `--raw`,
+	`--name-only`, `--name-status`, `--summary`, `--stat`, `--numstat`,
+	and `--shortstat`. The stat formats count only lines within the tracked
+	range. `--dirstat` is not supported with `-L`: it summarizes change as each
+	directory's share of the total churn, not as counts for the tracked lines.
+	Use `--numstat` for exact per-file counts within the range.
 +
 Patch formatting options such as `--word-diff`, `--color-moved`,
 `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
diff --git a/diff.c b/diff.c
index a7604a773a..4a30d7b631 100644
--- a/diff.c
+++ b/diff.c
@@ -4162,7 +4162,18 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
-		if (xdi_diff_outf(&mf1, &mf2, NULL,
+
+		if (p->line_ranges) {
+			struct line_range_filter lr_filter;
+
+			line_range_filter_init(&lr_filter, p->line_ranges,
+					       diffstat_consume, diffstat);
+
+			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
+						   &xpp, &xecfg))
+				die("unable to generate diffstat for %s",
+				    one->path);
+		} else if (xdi_diff_outf(&mf1, &mf2, NULL,
 				  diffstat_consume, diffstat, &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
 
diff --git a/revision.c b/revision.c
index 35afe52208..4639c0df8e 100644
--- a/revision.c
+++ b/revision.c
@@ -3229,8 +3229,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	     (revs->diffopt.output_format &
 	      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT |
 		DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
-		DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY))))
-		die(_("-L does not yet support the requested diff format"));
+		DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY |
+		DIFF_FORMAT_NUMSTAT | DIFF_FORMAT_DIFFSTAT |
+		DIFF_FORMAT_SHORTSTAT))))
+		die(_("-L does not support the requested diff format"));
 
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 233dc232e3..4e8f71c289 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -176,24 +176,9 @@ test_expect_success '--name-status shows status and path' '
 	test_grep ! "^@@" actual
 '
 
-test_expect_success '--stat is not yet supported with -L' '
-	test_must_fail git log -L1,24:b.c --stat 2>err &&
-	test_grep "does not yet support" err
-'
-
-test_expect_success '--numstat is not yet supported with -L' '
-	test_must_fail git log -L1,24:b.c --numstat 2>err &&
-	test_grep "does not yet support" err
-'
-
-test_expect_success '--shortstat is not yet supported with -L' '
-	test_must_fail git log -L1,24:b.c --shortstat 2>err &&
-	test_grep "does not yet support" err
-'
-
-test_expect_success '--dirstat is not yet supported with -L' '
+test_expect_success '--dirstat is not supported with -L' '
 	test_must_fail git log -L1,24:b.c --dirstat 2>err &&
-	test_grep "does not yet support" err
+	test_grep "does not support" err
 '
 
 test_expect_success 'setup for checking fancy rename following' '
@@ -793,9 +778,9 @@ test_expect_success '-L with -S suppresses non-matching commits' '
 	test_cmp expect actual
 '
 
-test_expect_success '--full-diff is not yet supported with -L' '
+test_expect_success '--full-diff is not supported with -L' '
 	test_must_fail git log -L1,24:b.c --full-diff 2>err &&
-	test_grep "does not yet support" err
+	test_grep "does not support" err
 '
 
 test_expect_success '-L --oneline has no extra blank line before diff' '
@@ -806,6 +791,113 @@ test_expect_success '-L --oneline has no extra blank line before diff' '
 	test_grep "^diff --git" line2
 '
 
+test_expect_success 'setup for -L stat tests' '
+	git checkout --orphan stat-range &&
+	git reset --hard &&
+	cat >file.c <<-\EOF &&
+	int func1()
+	{
+	    return F1;
+	}
+
+	int tracked_fn()
+	{
+	    return F2;
+	}
+	EOF
+	git add file.c &&
+	test_tick &&
+	git commit -m "Add func1() and tracked_fn()" &&
+
+	# Modify both functions so whole-file stats (2 added, 2 deleted)
+	# differ from the tracked range of tracked_fn (1 and 1).
+	sed -e "s/F1/F1 + 1/" -e "s/F2/F2 + 2/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Modify both functions"
+'
+
+test_expect_success '-L --numstat limits counts to the tracked range' '
+	git log -L:tracked_fn:file.c --numstat --format=%s >actual &&
+	cat >expect <<-\EOF &&
+	Modify both functions
+
+	1	1	file.c
+	Add func1() and tracked_fn()
+
+	4	0	file.c
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '-L --stat and --shortstat limit counts to the tracked range' '
+	git log -L:tracked_fn:file.c --stat --format=%s -1 >actual &&
+	cat >expect <<-\EOF &&
+	Modify both functions
+
+	 file.c | 2 +-
+	 1 file changed, 1 insertion(+), 1 deletion(-)
+	EOF
+	test_cmp expect actual &&
+
+	git log -L:tracked_fn:file.c --shortstat --format=%s -1 >actual &&
+	cat >expect <<-\EOF &&
+	Modify both functions
+
+	 1 file changed, 1 insertion(+), 1 deletion(-)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--numstat across renames and multiple commits' '
+	# parallel-change carries the tracked function f across an a.c -> b.c
+	# rename and a merge of two parallel histories.
+	git checkout parallel-change &&
+	git log -M -L ":f:b.c" --format= --numstat >actual &&
+	cat >expect <<-\EOF &&
+	1	1	b.c
+	1	1	a.c
+	1	1	a.c
+	1	1	a.c
+	1	0	a.c
+	13	0	a.c
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '-L multiple ranges with --numstat excludes untracked change' '
+	git checkout --orphan multi-range &&
+	git reset --hard &&
+	cat >m.c <<-\EOF &&
+	int tracked_func1()
+	{
+	    return F1;
+	}
+
+	int tracked_func2()
+	{
+	    return F2;
+	}
+
+	int func3()
+	{
+	    return F3;
+	}
+	EOF
+	git add m.c &&
+	test_tick &&
+	git commit -m "add m.c" &&
+	sed -e "s/F1/F1 + 1/" -e "s/F2/F2 + 2/" -e "s/F3/F3 + 3/" m.c >tmp &&
+	mv tmp m.c &&
+	git commit -a -m "Modify all three functions" &&
+	git log -L:tracked_func1:m.c -L:tracked_func2:m.c --numstat --format=%s -1 >actual &&
+	cat >expect <<-\EOF &&
+	Modify all three functions
+
+	2	2	m.c
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success '--summary shows new file on root commit' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c --summary --format= >actual &&
-- 
gitgitgadget

