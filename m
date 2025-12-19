Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575FE3090E0
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132268; cv=none; b=nnPdrNbSeSbHMEJ7hxNVily3JOOXFgDkBsThWEBDGwBHJUNHZJkHySERvH2nmoza7FokGG0LV8fDz0WlqDtgSNYWWsg0TZz3Jfsw7K3tkWyhgCXikmMRbVf1OkrOaBGtLj6bn8puRscR/em07oADxmWl0jvk23eaPSR6UyLyiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132268; c=relaxed/simple;
	bh=rYKaycptqQ7No3OSTFHTLwie5L9pkOzwAmAK1GB2Ylc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=PL/WN/1z7NRQVO9IBUrcAvT/CNQ3p4OuYL7XWV6ICycz2ydKCiuHvpRk/T2ieDSmI2C1Bt+2nySZtbFEwOHs0avFSEzVYKc5SHoa6TKbBZlYagEBpNqHyh+SnUTdWGUYkCg838PjBf7KGMDuZoTaDKAryPmW/hizhpLaBq5fduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNjWMYVP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNjWMYVP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f1bc40b35so27202205ad.2
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 00:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766132266; x=1766737066; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3afrJnLGKOtVkwK99kzXdFsSGCqdcUMRdapLIoy3bfo=;
        b=SNjWMYVPeWLbO63c90wbEQAf3PlsMtrd3jJk35SdkfgLFsi2QH95iA5Ei4kSmtxmyY
         30Dkx+Z2dDaGmEiIvr8S502qdmFGMCK1DRxEdlqLnNnUW5UssjOCfBqeN9IPeE6Kg+zk
         g2SsgL3hzS9C1HhDp86kzepBZ2qQrPsWuGvXRISlWcvL8Dzh8YjMG5/N7zZ/9lYhBzbX
         UjfV098MeQXe/l3Y5bWB0Z6mntngxoW+h92Tnsc+vOxH5qqFPQN4qT73tt4WTAFXvEjR
         EtNVE7GAJ3pnnbli3ViKW5jBgK+Jou9QxKiICFPaAmnt33wN/v015gVJAeF0hTViT5R2
         3UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766132266; x=1766737066;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3afrJnLGKOtVkwK99kzXdFsSGCqdcUMRdapLIoy3bfo=;
        b=EbDSMXUve7y/v/7JygkSUS3OG3TqDvSQbY8AVIc1L+ZZc0Aj3u69F88KiV/GsL3zMv
         /wxJ1slL1/+aCJrlXY0XolpcAC7AWVGTh36NK29ZdM2m46F1J2L6qb3hZQhBZg7ZrsJI
         fxlzSyGdtcMbw/vTcDxG5xz0NpC/YPsDdFPzWDvoeWnjSMEhMzXlcFOSRm8+qTM1p6PR
         wEdjRMhRRNJrM8zMaCcjUn14g7z5d+F22YtaSUWR/KGiroxUgtYOixfNKc0JYlikbCNK
         qLyM7h0RwHm2yRV/5iSmWX3u7WKagQzuZf+f1LsE8oWhjtBG6JlhKBfQNM/Veucnv3o+
         loww==
X-Gm-Message-State: AOJu0YwtoXcpGuhhcPUtTn3qYDawnOX23T9dnrKCvDt5EbH+DNvrDRiq
	QA0KTRhaiOjMT/34DI44O28hWPnvP0M6Gnj+aJzAb6KhFazGRxnMvfwIPOjQaltc
X-Gm-Gg: AY/fxX4oHdu+3vhNjKqfgB29Cqar1GLQYWgXljCzJX+kD+bOq9Jol+VlfhfQAA8rWp/
	d9jyd4VeNOJRAo8u4bJzHelSI1tbmKpGCQdCXaPCUG7TSc3HCMnsBNv87R14RqjAQ7hCbmmoZXX
	DB5HU3kI09SHkBNhhR16b6/HUqASq6/YIjce4REAFV/4N7GOLothzvzfHOqE9Eo56fxbN2bDshX
	VsDTS0snK/N7tnJliuaXRQ7VGZdLugGMKFVk/TpgNy8xrVNjUQ29dQY2JBxjbX39+PJdsH3pz/3
	IOdb1IxR6pgL2KNQqtslSCIoG1X/XaJuYivhO2iRoSxhsrNfSvdKYSCqt/F7cxWw90AgzAxFn5u
	7w59tIrIyaO4FU/Fj5Ht/8LO0gnIs8/8MBrQPf8iqQ7vsiWeh+wT+75c/nHSgyigZicmRGiocp4
	OOK0IkoTZWSmkr
X-Google-Smtp-Source: AGHT+IF2fFLTmqUcKv62GKrGe96HRfCR8h9P0bUB8EEdEG0tBt+O4mj1hGYEN3E8e6oadk9KszK1RQ==
X-Received: by 2002:a05:7022:458e:b0:119:e56b:c75b with SMTP id a92af1059eb24-121722e4529mr2634924c88.32.1766132265918;
        Fri, 19 Dec 2025 00:17:45 -0800 (PST)
Received: from [127.0.0.1] ([52.161.75.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de25dsm4633088c88.7.2025.12.19.00.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:17:45 -0800 (PST)
Message-Id: <pull.2133.git.git.1766132264231.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 08:17:44 +0000
Subject: [PATCH] diff: add --no-indicators option
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add --no-indicators to replace '+', '-', and ' ' indicators in the
left margin with spaces. Colors are preserved, allowing diffs to be
distinguished by color alone.

This is useful when copy-pasting diff output, as the indicators no
longer need to be manually removed.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    diff: add '--no-indicators' option

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2133%2FHaraldNordgren%2Fno-indicators-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2133/HaraldNordgren/no-indicators-v1
Pull-Request: https://github.com/git/git/pull/2133

 diff.c                 | 17 +++++++++++++++++
 t/t4000-diff-format.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/diff.c b/diff.c
index 436da250eb..668ba349fe 100644
--- a/diff.c
+++ b/diff.c
@@ -5290,6 +5290,20 @@ static int diff_opt_char(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_no_indicators(const struct option *opt,
+				  const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	options->output_indicators[OUTPUT_INDICATOR_NEW] = ' ';
+	options->output_indicators[OUTPUT_INDICATOR_OLD] = ' ';
+	options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = ' ';
+	return 0;
+}
+
 static int diff_opt_color_moved(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -5828,6 +5842,9 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
 			      N_("show context between diff hunks up to the specified number of lines"),
 			      PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "no-indicators", options, NULL,
+			       N_("do not show '+', '-' and ' ' indicators in the left margin"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_indicators),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 32b14e3a71..1863553056 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -95,6 +95,38 @@ test_expect_success 'git diff-files --patch --no-patch does not show the patch'
 	test_must_be_empty err
 '
 
+cat >expected_no_indicators <<\EOF
+diff --git a/path0 b/path0
+old mode 100644
+new mode 100755
+--- a/path0
++++ b/path0
+@@ -1,3 +1,3 @@
+ Line 1
+ Line 2
+ line 3
+ Line 3
+diff --git a/path1 b/path1
+deleted file mode 100755
+--- a/path1
++++ /dev/null
+@@ -1,3 +0,0 @@
+ Line 1
+ Line 2
+ line 3
+EOF
+
+test_expect_success 'git diff-files --no-indicators replaces +/- with spaces' '
+	git diff-files -p --no-indicators >actual &&
+	compare_diff_patch expected_no_indicators actual
+'
+
+test_expect_success 'git diff-files --no-indicators --color preserves colors' '
+	git diff-files -p --no-indicators --color --ws-error-highlight=none >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	grep -F "<RED> line 3<RESET>" actual &&
+	grep -F "<GREEN> Line 3<RESET>" actual
+'
 
 # Smudge path2/path3 so that dirstat has something to show
 date >path2/path3

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
