Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179643242A9
	for <git@vger.kernel.org>; Tue,  5 May 2026 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022150; cv=none; b=FcOLW9O+yR2y9Dm3s8SYj0NPLc+DrW+BqRFUTq9Q1RQ2ZKPP+Lc0RlbKIHhGVscS+ac4BHUD8VXadep8oJVMVOJtXxiWni+3B70KPb3MRyhjOmedGsreXZx5m2JumwsFROHiei6kHhMK7HgmdF56P9oTTo70aa6GBL01Ws63n1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022150; c=relaxed/simple;
	bh=Zw0PXRy5Xd3nTKkn5i3awChzGDMTHT2BWi0FFKIYmcI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DKajjYRcyShmHBC7xhl/vYGRtxssSewlvgDztHFi7/YbhXVBsJ8CQl72GPaZ5EpQF8+3TUmv5IAA0HHdJ8qEvHyj830X8J6ecPeAIXckEaSsy8RrQSNVHTIbh0BmZzLSZ55lKBd141Akh4Pqe30zfrfeoiIXGy9nzzWEaFM/rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbnVhA0w; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbnVhA0w"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-130c653cce4so2647024c88.1
        for <git@vger.kernel.org>; Tue, 05 May 2026 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778022148; x=1778626948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGHzrl3quX3z60T8kONwjbzzf7T+eEu8xUvA834RUGA=;
        b=WbnVhA0wkAYqp1pdMTjLB2ssjf7RPNLasXofSk8OzIS2J7qNSvJCVsNMXUy8ZA4/qM
         t94bPVO/YcBlF2PX9PN/MRLzghHWnpRFQIi6Oss3pImBKMYhRq41m7zHe49GKp2bCeJF
         /37fa4W75uobIW3kXXkL/V4PCtoscTusrq8yEt02/thoB9pmoGQFyHBlXD/xktgJqJfv
         qgVkOZzviU0WukQw4HdEoWairlrwQ3Q44JsHDM4K4Z/rX+Ybi2jY1zj8MDeKq5EAsw+J
         9sFQwJzDHt7mUXN/QY+4s5TQXUhZ3vMcKoIzgewI7kX3dXpvo5k/y22uduG+Oauyvn1g
         qL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778022148; x=1778626948;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGHzrl3quX3z60T8kONwjbzzf7T+eEu8xUvA834RUGA=;
        b=R5aDbGCEVeE7HeCd4FNCvvy1EQZT2YDvMOCvBUqIBRIH8essX8QMn2QSbidNlaIaNI
         duakNzM7q1FiOp0iXCLt2jgTbStzOJfPuxZsIYKWMsREi2N/f+StKmzPARcDV7cEcDL+
         0rK4J4anlExu9RpSSo4nQDm5c0lRLCde1LmC3A3+N7u3OcQILbOJEhbYxayMX/B/9rvY
         ACkN7SI9m0OoKOyPq0+qy6GEzsF03NB2hrxERs3dgThZ8YGKWSqanFmyY02ZlfNbleMe
         rD/BKwg7Rm65x8USH9lwC5MvvATmiWgNFOfCfoniSSb2SnaYpWAfzqVmKP1TAvxUfldh
         NUPQ==
X-Gm-Message-State: AOJu0Yx3bTgwRRKHvB12peajuffPN1wC/bdfTau6IrL5oH4rFkst/dD6
	/TW066cS1LIJYgMBxL0etgojgPc/JfXQouw8TXWc3K0gSKEdISHUPITjBFE+yA==
X-Gm-Gg: AeBDievi/qraKtcvfMF5aIpA+k0CASl8y7I5mobTXyyedw7hoxblpvr6PrZqar6fqE1
	6mCFShqtZcpa2DAIXW5XIM3Da3XwtdPGXXbu9oQ8ktGlUFwWmtTanOWk7/rEhTO3CIFS/hyGdbo
	8sIxr4gKngplifhohlyJ820Lba/NC8eSb3QewnJU4t2CEdz1FwR+wGwzBoTuUdEtczAZ9zvSlGU
	Bbt0Z325YguA+xmNTUcjQB7+Wm2+DzhJAPOS9r5tlzwLB2VsU9a+sFjAwvY+q56FO/v50Wnf9/5
	kaZU3ABb2zK5Ck/9a9Gkj+Vjqs7f6KvX9wtG0/VhvaYGLdKAPvtL27Yodezna5sE8OmTvExtUM/
	MzdCWUERDsXI6bfyjsaefyCo0fLxZkigNnsxDVP70ENXf4vMHKmrpg2XzWtnNWqSvsu16wHt/Zv
	vYdoyPZR+KrI3ZsUQsNK/8tq72D4fe6/kn
X-Received: by 2002:a05:7022:2511:b0:12a:b39a:339f with SMTP id a92af1059eb24-1319cd2660fmr575442c88.21.1778022147417;
        Tue, 05 May 2026 16:02:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.4.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f968999fsm820538c88.5.2026.05.05.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 16:02:26 -0700 (PDT)
Message-Id: <cca75eca0e81430bc966cad3506b0017652c2ab8.1778022144.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 23:02:21 +0000
Subject: [PATCH 1/4] diff: reject negative values for --inter-hunk-context
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

Negative values for --inter-hunk-context produce structurally invalid
diff output with overlapping hunks:

    $ git log -1 -p -U3 --inter-hunk-context=-100 791aeddfa2 \
        -- git-compat-util.h | grep '^@@'
    @@ -110,6 +110,9 @@
    @@ -115,6 +118,9 @@
    @@ -116,6 +122,7 @@

Hunk 1 covers lines 110-115, hunk 2 starts at 115 (overlap), hunk 3
starts at 116 (overlaps both). The resulting patch cannot be applied.

The config variable diff.interHunkContext already rejects negative
values, but the command line option does not. The option currently
uses OPT_INTEGER_F with PARSE_OPT_NONEG, but PARSE_OPT_NONEG only
prevents the "--no-inter-hunk-context" boolean negation form. It does
not reject negative numeric arguments like "--inter-hunk-context=-1".

Change the type of diff_options.interhunkcontext and its static
default from int to unsigned int, and switch the option parser from
OPT_INTEGER_F to OPT_UNSIGNED. This rejects negative values at parse
time via git_parse_unsigned() and enforces the correct type at compile
time via BARF_UNLESS_UNSIGNED.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c                             | 13 ++++++-------
 diff.h                             |  2 +-
 t/t4032-diff-inter-hunk-context.sh |  6 ++++++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 397e38b41c..5df28e49c5 100644
--- a/diff.c
+++ b/diff.c
@@ -61,7 +61,7 @@ static enum git_colorbool diff_use_color_default = GIT_COLOR_UNKNOWN;
 static int diff_color_moved_default;
 static int diff_color_moved_ws_default;
 static int diff_context_default = 3;
-static int diff_interhunk_context_default;
+static unsigned int diff_interhunk_context_default;
 static char *diff_word_regex_cfg;
 static struct external_diff external_diff_cfg;
 static char *diff_order_file_cfg;
@@ -388,10 +388,10 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.interhunkcontext")) {
-		diff_interhunk_context_default = git_config_int(var, value,
-								ctx->kvi);
-		if (diff_interhunk_context_default < 0)
+		int val = git_config_int(var, value, ctx->kvi);
+		if (val < 0)
 			return -1;
+		diff_interhunk_context_default = val;
 		return 0;
 	}
 	if (!strcmp(var, "diff.renames")) {
@@ -6111,9 +6111,8 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "default-prefix", options, NULL,
 			       N_("use default prefixes a/ and b/"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_default_prefix),
-		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
-			      N_("show context between diff hunks up to the specified number of lines"),
-			      PARSE_OPT_NONEG),
+		OPT_UNSIGNED(0, "inter-hunk-context", &options->interhunkcontext,
+			     N_("show context between diff hunks up to the specified number of lines")),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
diff --git a/diff.h b/diff.h
index 7eb84aadf4..033d633db4 100644
--- a/diff.h
+++ b/diff.h
@@ -296,7 +296,7 @@ struct diff_options {
 	/* Number of context lines to generate in patch output. */
 	int context;
 
-	int interhunkcontext;
+	unsigned int interhunkcontext;
 
 	/* Affects the way detection logic for complete rewrites, renames and
 	 * copies.
diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index bada0cbd32..bec1676f8d 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -114,4 +114,10 @@ test_expect_success 'diff.interHunkContext invalid' '
 	test_must_fail git diff
 '
 
+test_expect_success '--inter-hunk-context rejects negative value' '
+	test_unconfig diff.interHunkContext &&
+	test_must_fail git diff --inter-hunk-context=-1 2>err &&
+	test_grep "expects a non-negative integer" err
+'
+
 test_done
-- 
gitgitgadget

