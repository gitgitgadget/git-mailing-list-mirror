Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E73ACA60
	for <git@vger.kernel.org>; Fri, 29 May 2026 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087713; cv=none; b=RKFlTz+IUtNSlSxB2HmQxhxRfe/xocghst3vDX0uDbnqHotF6gQ2BFH9mFbhxbmv0q9Ns9mqFYr6ni5EvEVLHTGzZq39sKfi4XtufE6VM6kW8gHQ3q8T60B6ThMH5NWMy60oh1+v627k3qWVMh0/czK9TkNberb5ycHC77+lDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087713; c=relaxed/simple;
	bh=enEF0pNwHUGv0esDoxOkuVn0WbSsqtCrwEDuMBgaLtw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tIep9M0Thx+yh7X/e+gm4hTj4KAaY5fNP9u+uTCZws3zozgQQ3CF6GhE0n7aDKncT9YxINZA64VjklkVSHlIrt1dYuUhTfz8EbmBfYAI6wqyObimSQhN4oZbkkMOqCgWowyB4C39dCi9IJ5V6gofj3X4S96CcGtCx3lsvoYmXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbbK7lpp; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbbK7lpp"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137335bc3caso5939842c88.0
        for <git@vger.kernel.org>; Fri, 29 May 2026 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780087711; x=1780692511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbkIMQN2Xhhnu/SKnY4DJ0oXDofk0RSFK1bLLR917f4=;
        b=HbbK7lppcnsDTlYbYB0wC9L3v7wThKPfq0/nsPDgRbKyHs6uK0jSssS+mQWmuvNkEh
         9vuXBQtVjs+stB2tY+4YOmA24bMRb4jRGEsNaIgs7CdX1dkd0V0jA5fkl9nz0GueXjHw
         qa6cW522MBiOb1tijwe5Gep4Nba61wTcC80HYQIKMfM0GPb5j1Nkz3Zq8+xZpbxDbPNU
         ibr5k5I1qUM0DyJauI9/mDQeN15JRKx/beuJfR+ewMEhWeBuZ80cIKH1h5sKJhXUfrB3
         BOzsym1txATMGTL+aLd+ecGqIjkAS49Fn5BvnAP+olc24+hE7EvKyQ6NOEZMj57pSTF/
         jGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087711; x=1780692511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TbkIMQN2Xhhnu/SKnY4DJ0oXDofk0RSFK1bLLR917f4=;
        b=svfZlfuc1kG9zb9mgKscq4uB9lffzBygxdgkLBWrHjO3L3Y+ssp9KB+d0fBxBJCBwF
         f2wcEYWexEUQVsVw2tpiwyrZbKBua/x+L+B5TImUwHdpy8TWiQcs25zmnQMgMzOH+F+N
         bKr6/d/8Y2B7T2ad03eLvy0zd8M3LQwrS0TAWOzqXQRID1X1W3Luf2HP8Aj+2GiYALo6
         fBx4tyhUjOamDU7lHdhFTUGI0fdivOVE2zZj6KV9aQtS6hBAB5JcnrMhj3SaGPGk48u8
         YmH/1O1u6BKpRSXNe1HZvNghFRIEestFe/KCErKPQIPMMzy4IBt+0PVZDsWjb3JSmoGI
         KRJQ==
X-Gm-Message-State: AOJu0YxWntcgN/fxMyF4HeecxSBe/XBoMjxwS/ILuo/+L7QnLfdkJBRC
	GMAH2fCjvNn9hnxiyjKHY8Vk7aboO2WinVHIekcyUATh95LYc9v/aRTqCjED0Q==
X-Gm-Gg: Acq92OE3aWmAPVMQZlKh38BDlkb6FiKiZO5NGfHcxnDoQ+HODv19D4VEIkHllyOJICP
	p4xgAzMZyGg0Lpzcg3bPv5a1sRxpYLE25Sth5IBMrn/tOfyMC4ruGw0aEpiC/vB3AEjUJHIg5ns
	GcdNUBB5QemK5mRS903pv6O8KrtaqSLZWyfTjiZA9bW0V95o1jECZtDDbur2UrgsZ2kT6SBOHyV
	V9r+afVw4oK8M0YTnF8xFh9FtaC8SafnRKLw9AM1jHFPI/JGF8GzL0EK7whbWJARn1Hwz4882Rt
	diIC4T7aK0iLVeJm2fxCZJiurB0x51NX91b9Msf5nqqvA0E5nEq6RXQy6THcf7M1AyifRp5CQ7r
	HO2AH7VpgQG2yc+OM6CzXMVm+zg3w3UfxdBmlkRUAXXTHvI8mJzpu5naWWZrpcu10qWHOPBybmj
	qOhXlNVzkRmYvQt6ma0acl9+NO4kg0NRv0J0Z2YQ==
X-Received: by 2002:a05:7022:ff48:b0:136:b370:64c5 with SMTP id a92af1059eb24-137d426d974mr573984c88.30.1780087710986;
        Fri, 29 May 2026 13:48:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.227.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69c0asm1984185c88.11.2026.05.29.13.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:48:30 -0700 (PDT)
Message-Id: <f4fd9aa682df2100715366022607b32fa6948cfa.1780087700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 20:48:18 +0000
Subject: [PATCH v3 5/6] diff: bypass diff process with --no-ext-diff and in
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
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
since it sets ignore_driver_algorithm which diff_process_fill_hunks
already checks.

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
index 8a63b5e164..18b8b0ed24 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -825,7 +825,9 @@ endif::git-format-patch[]
 	to use this option with linkgit:git-log[1] and friends.
 
 `--no-ext-diff`::
-	Disallow external diff drivers.
+	Disallow external diff helpers, including
+	`diff.<driver>.command` and `diff.<driver>.process`
+	(see linkgit:gitattributes[5]).
 
 `--textconv`::
 `--no-textconv`::
diff --git a/builtin/log.c b/builtin/log.c
index 8c0939dd42..1ea520c12d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2213,6 +2213,13 @@ int cmd_format_patch(int argc,
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
index 2d5ed6ea8c..38932db084 100644
--- a/diff.c
+++ b/diff.c
@@ -5913,6 +5913,17 @@ static int diff_opt_submodule(const struct option *opt,
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
@@ -6241,8 +6252,9 @@ struct option *add_diff_options(const struct option *opts,
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
index d1e5a13e9e..71ba389f03 100644
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
index f159cd86d8..ee0c306abd 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -419,6 +419,22 @@ test_expect_success PYTHON 'diff process bypassed by --diff-algorithm' '
 	test_path_is_missing backend.log
 '
 
+test_expect_success PYTHON 'diff process bypassed by --no-ext-diff' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --no-ext-diff worddiff.c >actual &&
+	test_grep "return 999" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success PYTHON 'diff process not used by format-patch' '
+	rm -f backend.log &&
+	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		format-patch -1 --stdout -- logtest.c >actual &&
+	test_grep "return 2" actual &&
+	test_path_is_missing backend.log
+'
+
 test_expect_success PYTHON 'diff process not used by --stat' '
 	rm -f backend.log &&
 	git -c diff.cdiff.process="$BACKEND --log=backend.log" \
-- 
gitgitgadget

