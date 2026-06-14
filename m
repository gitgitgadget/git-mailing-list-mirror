Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45B309DB1
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463574; cv=none; b=hcXvEDSsw3XKnTf6P0BGRK3CLdsTsPuAfKqdIKG3UTVIvGZFKQR5YxKU7JJCpJhgCCQV2Lz5Z0if4SY0AwI1aHLGAgQWR0ROCtn1Z4p4TzSIBhY9P8f/xPJYdxEUmDkmPajkWNExe0VNtlSBdQHGZtjn4nvpyX9p5n+wvtkiqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463574; c=relaxed/simple;
	bh=XMRDW+zxV0puFfVrnX5lQlnVFmGk6FbNCek5LhPrJVE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QuyDZR5p7795QFp6MyRhkZd82/uoiYBVu+iezcCXVgMvv2S0dCkt4OUfmLROBMlTPBwDpNejVo4hOscPgoDytCHBnn6TcJ4ezUhM2dGJPipI2iMc03BAsdGwCnTjZluc0sUzDrmLD2j6gv8pQXl7FyK57KF34V1iCuUYlpjTUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU2UKCQT; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU2UKCQT"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-307631dbfedso5783752eec.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781463572; x=1782068372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al5cMtU/dPQQZEQGYDslN+VUKZTsMxqTnWzgf8Yfw8I=;
        b=bU2UKCQTQOQ1PE4Ty0D72GvKZQ7fG4yStqrkRY1nhcsp25xvIKm2NGsm17B0lyn/3A
         aWF9D2r6T7omHDeRKLsf9NibeLvodXEAggA20JBaETglc/JXweyzsKuynJG6VlnlGSR7
         kgQTz93+xGioz7/mYZ/MOWlyCmJeQa0m0Dc0C2ffEy80Dszk5tAg/aXs44mQGfH75lyU
         5wK0JASGRoR0cXwh31Kz3GFMqmB9yFailIwRlPNsiiREI4Utf4NTNs2Q4tDpk6xvLMpc
         D/19dOuJs58IKz3Ac9yZldJpv84KgQNGNgkBFXKHRfY4ddKtBHXZBDcZZrpqs9/P0HJC
         TijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781463572; x=1782068372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Al5cMtU/dPQQZEQGYDslN+VUKZTsMxqTnWzgf8Yfw8I=;
        b=s6r7KWqH7AGRkeJdv2fveGtliNX84NvQdK7x0G4WS/Ook9aBqrvm9i+GA33kNwxKmd
         Cst0RcrChNTbd5tjzB2aEca8N/wIT7HHJFImrkEAlaf66hCD25cl4I8wjPvY18J4htBZ
         GOHH/3aGB2+J2Iq9I928FuvWY05//S7eje1ksVUhgl3Bibfcm32T7zEKK/weiveeltZW
         e3DtX/M8CuSjhXzUI6uRrfUResysu9L0oyNNmUCUb6pTW8n8sky9hDePtMaw+2x8Gjcj
         5vWup2rLOafrz/vhc4d6EMp4+2pRDbVb+oKBZJD1zCLvliaXa200u15v/rHP6Mdw9wPD
         yIZA==
X-Gm-Message-State: AOJu0Yz+abFsyWWVmBRFBkCuqCAemrHt+LGztQHHAlscXYroesj9v6t+
	oRs/U6IKua0jlbWd2dThB6kD8dP0VmZR+vD6oP33w28qFlze06ucF2X/wGAaZA==
X-Gm-Gg: Acq92OHT1V3gYoj+ay5vPVZACRXzDSakytml6C9oIX0VBSlsLolw0hhr7uZdBRRDhzU
	lOlIBUuyr/Tj/Z9gotmWpAVolGDeqNbGu+S78G+usmQxj9l1dfG6r3dO5foQK7tgP6wTgWsDdW3
	TLenlriWon1msbpcJJILq2BtEHzQZKDzyGkVYhA6JORTfL6tqdo+PliyfHr25of0sMycT6hQ45F
	CazpZta6Qd+nh43f491R8/7arodw1zK9TnyO+hWKBkDoxyT71RnnNwtARKjYB3Dx2IvawqZuo8D
	S3ErE5S5Vkv738/ALUrsaYYCvdtS2uUSf3HaupJcEnuzp1kyEgzqujydUdpooGvSPLRQk+cp04g
	Zfy5R/6KAkCAQXx4kmkMkRUNkdNk5HhuoxAfI420vlx2BJdUErO2jFgReAuTcb4lI9xsUJZPIJR
	W8w5x9aTkDt1Owp/3yWqk8las3
X-Received: by 2002:a05:7300:6425:b0:306:f474:7389 with SMTP id 5a478bee46e88-308200a18c4mr5535722eec.25.1781463572453;
        Sun, 14 Jun 2026 11:59:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8d3c9sm11682501eec.26.2026.06.14.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:59:31 -0700 (PDT)
Message-Id: <6ec6716ea4688289917cad3dd4928b90d60638fc.1781463564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
References: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 18:59:22 +0000
Subject: [PATCH v4 5/6] diff: bypass diff process with --no-ext-diff and in
 format-patch
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Make --no-ext-diff disable diff.<driver>.process in addition to
diff.<driver>.command.  Although the two mechanisms work differently
(command replaces Git's output, process feeds hunks back into the
pipeline), both invoke external tools and --no-ext-diff means
"no external tools."

Replace the OPT_BOOL for --ext-diff with an OPT_CALLBACK that
sets both allow_external and no_diff_process, so a single option
controls both.  Passing --ext-diff explicitly clears
no_diff_process, so a later --ext-diff overrides an earlier
--no-ext-diff.

Disable the diff process unconditionally in format-patch so that
generated patches are always based on the builtin diff algorithm
and can be applied reliably by recipients who do not have the
external tool.

Document that --diff-algorithm also bypasses the diff process,
since it forces the builtin algorithm.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/diff-algorithm-option.adoc |  3 +++
 Documentation/diff-options.adoc          |  4 +++-
 builtin/log.c                            |  7 +++++++
 diff.c                                   | 16 ++++++++++++++--
 diff.h                                   |  4 +++-
 t/t4080-diff-process.sh                  | 16 ++++++++++++++++
 6 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-algorithm-option.adoc b/Documentation/diff-algorithm-option.adoc
index 8e3a0b63d7..4d7e2ec35f 100644
--- a/Documentation/diff-algorithm-option.adoc
+++ b/Documentation/diff-algorithm-option.adoc
@@ -18,3 +18,6 @@
 For instance, if you configured the `diff.algorithm` variable to a
 non-default value and want to use the default one, then you
 have to use `--diff-algorithm=default` option.
++
+If you explicitly choose a diff algorithm, it also bypasses
+`diff.<driver>.process` (see linkgit:gitattributes[5]).
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index c8242e2462..a884445211 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -833,7 +833,9 @@ endif::git-format-patch[]
 	to use this option with linkgit:git-log[1] and friends.
 
 `--no-ext-diff`::
-	Disallow external diff drivers.
+	Disallow external diff helpers, including
+	`diff.<driver>.command` and `diff.<driver>.process`
+	(see linkgit:gitattributes[5]).
 
 `--textconv`::
 `--no-textconv`::
diff --git a/builtin/log.c b/builtin/log.c
index e464b30af4..363052f468 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2217,6 +2217,13 @@ int cmd_format_patch(int argc,
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
 
+	/*
+	 * Disable diff.<driver>.process so that patches generated by
+	 * format-patch are always based on the builtin diff algorithm
+	 * and can be applied reliably.
+	 */
+	rev.diffopt.flags.no_diff_process = 1;
+
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
 		die(_("--name-only does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME_STATUS)
diff --git a/diff.c b/diff.c
index 3d97a188b9..4d9cb9b26b 100644
--- a/diff.c
+++ b/diff.c
@@ -5936,6 +5936,17 @@ static int diff_opt_submodule(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_ext_diff(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	options->flags.allow_external = !unset;
+	options->flags.no_diff_process = unset;
+	return 0;
+}
+
 static int diff_opt_textconv(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -6266,8 +6277,9 @@ struct option *add_diff_options(const struct option *opts,
 			 N_("exit with 1 if there were differences, 0 otherwise")),
 		OPT_BOOL(0, "quiet", &options->flags.quick,
 			 N_("disable all output of the program")),
-		OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
-			 N_("allow an external diff helper to be executed")),
+		OPT_CALLBACK_F(0, "ext-diff", options, NULL,
+			       N_("allow an external diff helper to be executed"),
+			       PARSE_OPT_NOARG, diff_opt_ext_diff),
 		OPT_CALLBACK_F(0, "textconv", options, NULL,
 			       N_("run external text conversion filters when comparing binary files"),
 			       PARSE_OPT_NOARG, diff_opt_textconv),
diff --git a/diff.h b/diff.h
index 7dc157968d..bc7da6986a 100644
--- a/diff.h
+++ b/diff.h
@@ -173,7 +173,9 @@ struct diff_flags {
 	 */
 	unsigned allow_external;
 
-	/** Disables diff.<driver>.process. */
+	/**
+	 * Disables diff.<driver>.process.  Set by --no-ext-diff.
+	 */
 	unsigned no_diff_process;
 
 	/**
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index 9bb579b564..df4d08e31f 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -295,6 +295,22 @@ test_expect_success 'diff process bypassed by --diff-algorithm' '
 	test_path_is_missing backend.log
 '
 
+test_expect_success 'diff process bypassed by --no-ext-diff' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --no-ext-diff worddiff.c >actual &&
+	test_grep "return 999" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'diff process not used by format-patch' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		format-patch -1 --stdout -- logtest.c >actual &&
+	test_grep "return 2" actual &&
+	test_path_is_missing backend.log
+'
+
 test_expect_success 'diff process not used by --stat' '
 	test_when_finished "rm -f backend.log" &&
 	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
-- 
gitgitgadget

