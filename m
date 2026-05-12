Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CD34E744
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609429; cv=none; b=O+j5vPEopqg87Vb/8wN2//cB+GChglZZj5ApvUfabxIupgVJi9f6oGMBJG0wvPNOJbNf6csSuJI9L0/peCoNYJy4a4MHRpHFJH+MIg/SjgftqTnR+BkR4C7ZSm5t+IWFQPbonVNqrDee4IP8xn1Z8fSkN6Nb8uZNbr94x5yg3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609429; c=relaxed/simple;
	bh=W+XuRFddPRmbGeGV51bzPeeXjhhbMzoLcNhZQb2vPQI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y2Df0PbccKXgWSlVxhQ0bdG5qb7l41H6Zw8MQdQS5HlfU1/lFT1igCgvp1oj5DDsFOUGt73KYQlAogMv0BpoF+77Eb0bD0fGcpxiPc3vJw9+B6AsPRRhlUWXH8hP/0X2sFFMe5hWUsyDcDYNd0thv4FBqUKAxplCiYHkKNQOahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alWnuHIs; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alWnuHIs"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-133466cf955so3506048c88.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609427; x=1779214227; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/zv4VzTh4j4QZzFZBumcdGCDcUCpRinuZ7MQpxET94=;
        b=alWnuHIsNf3jEtOlnKn6pGH2xReo2EaqXD9tXqnbnzdrCIagUkWXZBm2QYsLvTdgR3
         /kQyXr+N2t84lkG/0qBTt7BQ4vHEPTSYib8dRwUme3jkuoBhMhfO6IXVk9JS2fDN86xA
         svPlmF2YqkMZG6pEzp0uevrQ2tn1qxxPC8jHDDAat0ua5WrVImu20EwH3Iwq43avLKMN
         X9JDFuLA49lgF2GUHBsn7zOx+h36zQ2QE/ijzfiCFmOOiJ2r9Jis952rfAa3cBe9bN7h
         qttkuRopPpBXTJYF+BdjlGLFxPYLUYhi/TCjmLWIAZBgFzTl4rrqeyTTZIf7G2679Juj
         fAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609427; x=1779214227;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/zv4VzTh4j4QZzFZBumcdGCDcUCpRinuZ7MQpxET94=;
        b=UgwStTowYBpyBacRVwvlBCxFH3J8ynae9hrANpZY0RPBbt8Uv32uHzvj+v/5yGecR8
         fWyztQBPdaKFPPlcIGCDX5jZmAxc4gXRJ5vb5oqhNy9ywjuQTWb9A8hiUNETH93IEoQE
         pdZMW01tZQbyHqkBb3tNrtYUEArIbkJ36B73+IdCNOxc6NW0S6Gm1LOhcAIz2sgTSL0g
         5qxJeKU1qxPjRr8QpoaMsFF/5gcLymjdqfx7uBnlabLa42sYHCUrIo/UYddILYoRQA1r
         rhW9KkpZvP86AUl9baQuZF0wpEzpX36/yZRBfjZNhDR8YZbT388RPCXoiik+Cg5vt8h2
         q8cw==
X-Gm-Message-State: AOJu0YzFi2Zepd86sBvEQJBzaaJ2NjAKbz1hEsXVY4XQN/k9UaJosgSs
	ZJvSbTyZ8W9laNC7FmWofFnotN7aS/3omPAvT2BYkbP7MbZ5zPkurzMxaJZawA==
X-Gm-Gg: Acq92OF5YY/4afwa4U4Qfs2IURh4vHaHP/EyYq4R4Y3AnaeKtB431Ed0w5QDoaWPHsm
	91ODcimLTc5RhKe0e5TcyvTtIJazEq42UUVVrR1ZYI1CAYNicBIXB0AWBrLHxuZlp5dmfb4qCtf
	ayQkZQoWevs3vlgX5uCRLbE2QfUxNo3URE0d/CjZnVi9TJjERXHXloHSBMAlAFDQRHjF4R5VDOD
	eyO2PjR9q0zSOGRmvtQivzlXUCpFsrUFICRekmjc+RSX4NR86SGlO9RzN02tBE6oaoT/pXvmDaz
	epTiajlUTmyVSx61jt64xzbDgMaXizM4HnXNo8WQRqbjr3tlcFoq7i2bpgeprZGDs0G8knKCJAV
	7b9+R0zubmYUpfGtz/xM1Boq7/iNncNf5QA5zFJMCPpFXYhUdLByl1c4tRmAclVnBWtuvrNpKq9
	2uTU851C9oAnKXbvENVrFRm6OP9X8=
X-Received: by 2002:a05:7022:f417:b0:128:d967:466c with SMTP id a92af1059eb24-1343699b1cfmr14813c88.24.1778609426868;
        Tue, 12 May 2026 11:10:26 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm24251617c88.4.2026.05.12.11.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:10:26 -0700 (PDT)
Message-Id: <f2ebb3a72b0b69da3ec525184e79681d66125fdc.1778609423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
	<pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 18:10:20 +0000
Subject: [PATCH v2 1/4] diff: reject negative values for --inter-hunk-context
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
values, but the command line option does not.

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

