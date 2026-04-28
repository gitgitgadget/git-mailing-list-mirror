Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876E21B9F6
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777349135; cv=none; b=CHp3y+3NgjjSGRf4rdTAYKRaSsraTs7hj9RJRKYGeCi/+rtwAa65HfkGpgpt2kMOLlP3+Li0hgN7vZjrJflsCfNTn9RxGsyV+5uyrhypuZRJLNSaKwFMylaPzXTUQLs1pS7C7L5dGGQbZARwORml4AInDc5C528WgffhY2P1P94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777349135; c=relaxed/simple;
	bh=PjaXVShCmkmCahwwmntTaD3B3Yv18PtCW2poxyMVzsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y9gpeSmvXo4GtMtUR81oi84clbN680hvX6+bfL0638r+3Fxl6KnZ0DglwSrDuVveVvAS7cgS/u6hgcTFsgR04tlR0Ubb2aUS6xcVHOmgWNGd18nNR1t8ZLPvSGLn6i0zWtD+Cp4dBlJMt0ZfScLfU+2umkgWfTOQZRwaRG9a/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnzClkOu; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnzClkOu"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c7212836bso1157406c88.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 21:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777349132; x=1777953932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWs9H/V7C7uy+RRr8NJDV4hIhJEGwlAuCyDCnOGzNmE=;
        b=cnzClkOunBey3IA6podNbhXXW9I07Gw8aN44I9xiHqMWaEgD7vewJH2WB+ydl3+3Gb
         LczgoxrPO9fd3wfoSRF9b2+7NU68ouc/R/Kyt4jgBGZNDVUbf5Q3BZeIKA7mGeSzjzzA
         rDefk3+Bv+8qwoAqYm8Br5AoKFa0zCTNJQbTwAZfZAXqjx+61cXqW0ivIqosYGg/GYXz
         35uMvUL6jewafumc8XfYym/Zl5eF+D+paRooAumxn91bhejlQyX9ghMZtds5sY01uLDJ
         yIH3HTyKDApawIdt2yh6UyBpWvBul001qfbslKQq5/7XyMDZ4eJGi/tGT41UZs8xm9mS
         TzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777349132; x=1777953932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWs9H/V7C7uy+RRr8NJDV4hIhJEGwlAuCyDCnOGzNmE=;
        b=TNhfcIfLHXuGOnFHPhrNy4B5hOq64g/4mHc4kX1bO0k8txdKb+CsAvGpfqHYC6dll0
         bo/Eo6IfixqNpwFrYS7ztHkxTLR0YYQ2s08NdmrD/sKvEWRlZ6F9pYmPOPKZjxoL/92H
         z+W+6wBLTNVOIqrCxPftfh+ESBJD6EHgffLVsIuMOpxnpkcDqVY0chtCv47z59UBMW9Y
         EuzqUx7mx+OENtDarGw5b8gdNMEB8TenVG4znH5kphI4M+9L8K0rpE42qr6bvgaUsHjs
         NOkkfZ1ydccvjhjFLpSnJzBNBkKWzhE/QCXUE6rfKUUHFShEfF5z0zKB2pDQoUi3U1VD
         SwSg==
X-Gm-Message-State: AOJu0Yw4X52hJyXeoSwBmqdh02FtZDi3Eiy4EQuxcgbzpCH6xGVA8A1z
	yS9HmO6Q6zDSiiS586WI10o+G2jq+JKXQJ07TesgjHqmmb8eKNsuPzpz4GsuVEtX
X-Gm-Gg: AeBDievN1MnDtLGEAEzY2oVifhSFHpEFIucCKGE1YVTQg92EuMxYBLYI/sONzYYpsoz
	MT2T2ryg0f6eEmSYGhJiIAQ78F1hczdassrsZGMVAhG+vxijOiNyed7Tvjg6GSbPH0yFpp+Tk4m
	lxB2uPPN3CbyX1OTQQPdRtRACR3KrfcxYsxQl/SeSK/h5x1FnYP/x4sHtwZpZfAJdxIMbvUSRKO
	LAvvVvwFn2oznVzVMIBgVl36M+TlvkcsR28XNpce6H3grSDd0UQBwo+5HeXPhvVqeSrrwcvg0wS
	hPlRKb6iPdKO3OOdQSi0Bi0xHzYPzF6aZUHJCDP8R3FgAS4bAIJwneBDv+p2YrzaOI2UDlFYXqR
	pv4wyIzOCdWkN3fGqT4Sf/QwUPoSfHqKLc1bA9nGk78WFjC0tCWUFYUCRMX88+hOhFI2ATN2bgp
	5RIx+ysSoDHYye+JUBchcdcZtl+hAnzu7iceXa
X-Received: by 2002:a05:7022:629d:b0:12d:b26f:cafd with SMTP id a92af1059eb24-12ddd93fa06mr834296c88.5.1777349132278;
        Mon, 27 Apr 2026 21:05:32 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.167.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd933044sm1240749c88.5.2026.04.27.21.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 21:05:31 -0700 (PDT)
Message-Id: <06c24b416f55f43d5d05340130180176ee8029f0.1777349126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 04:05:26 +0000
Subject: [PATCH 3/3] line-log: allow non-patch diff formats with -L
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

Now that -L flows through log_tree_diff_flush() and diff_flush(),
metadata-only diff formats work because they only read filepair
fields (status, mode, path, oid) already set on the pre-computed
pairs.

Expand the allowlist in setup_revisions() to also accept --raw,
--name-only, --name-status, and --summary.  Diff stat formats
(--stat, --numstat, --shortstat, --dirstat) remain blocked because
they call compute_diffstat() on full blob content and would show
whole-file statistics rather than range-scoped ones.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc | 10 +++---
 revision.c                            |  7 ++--
 t/t4211-line-log.sh                   | 47 +++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index ecb2c79fb9..72f639b5e7 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -8,12 +8,14 @@
 	give zero or one positive revision arguments, and
 	_<start>_ and _<end>_ (or _<funcname>_) must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
-	Patch output can be suppressed using `--no-patch`, but other diff formats
-	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-	`--name-only`, `--name-status`, `--check`) are not currently implemented.
+	Patch output can be suppressed using `--no-patch`.
+	Non-patch diff formats `--raw`, `--name-only`, `--name-status`,
+	and `--summary` are supported.  Diff stat formats
+	(`--stat`, `--numstat`, `--shortstat`, `--dirstat`) are not
+	currently implemented.
 +
 Patch formatting options such as `--word-diff`, `--color-moved`,
 `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
-as are pickaxe options (`-S`, `-G`).
+as are pickaxe options (`-S`, `-G`) and `--diff-filter`.
 +
 include::line-range-format.adoc[]
diff --git a/revision.c b/revision.c
index a1c795de96..b41ec4016b 100644
--- a/revision.c
+++ b/revision.c
@@ -3179,8 +3179,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
 	if (revs->line_level_traverse &&
-	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
-		die(_("-L does not yet support diff formats besides -p and -s"));
+	    (revs->diffopt.output_format &
+	     ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT |
+	       DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
+	       DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY)))
+		die(_("-L does not yet support the requested diff format"));
 	if (revs->line_level_traverse && revs->full_diff)
 		die(_("-L is not compatible with --full-diff"));
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 1d566ea9bd..63cf8e5d9f 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -155,8 +155,45 @@ test_expect_success '-p shows the default patch output' '
 	test_cmp expect actual
 '
 
-test_expect_success '--raw is forbidden' '
-	test_must_fail git log -L1,24:b.c --raw
+test_expect_success '--raw shows mode, oid, status and path' '
+	git log -L1,24:b.c --raw --format= >actual &&
+	grep "^:100644 100644 [0-9a-f]\{7\} [0-9a-f]\{7\} M	b.c$" actual &&
+	! grep "^diff --git" actual &&
+	! grep "^@@" actual
+'
+
+test_expect_success '--name-only shows path' '
+	git log -L1,24:b.c --name-only --format= >actual &&
+	grep "^b.c$" actual &&
+	! grep "^diff --git" actual &&
+	! grep "^@@" actual
+'
+
+test_expect_success '--name-status shows status and path' '
+	git log -L1,24:b.c --name-status --format= >actual &&
+	grep "^M	b.c$" actual &&
+	! grep "^diff --git" actual &&
+	! grep "^@@" actual
+'
+
+test_expect_success '--stat is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --stat 2>err &&
+	test_grep "does not yet support" err
+'
+
+test_expect_success '--numstat is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --numstat 2>err &&
+	test_grep "does not yet support" err
+'
+
+test_expect_success '--shortstat is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --shortstat 2>err &&
+	test_grep "does not yet support" err
+'
+
+test_expect_success '--dirstat is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --dirstat 2>err &&
+	test_grep "does not yet support" err
 '
 
 test_expect_success 'setup for checking fancy rename following' '
@@ -737,4 +774,10 @@ test_expect_success '-L --oneline has no extra blank line before diff' '
 	sed -n 2p actual | grep "^diff --git"
 '
 
+test_expect_success '--summary shows new file on root commit' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --summary --format= >actual &&
+	grep "create mode 100644 file.c" actual
+'
+
 test_done
-- 
gitgitgadget
