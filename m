Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B41E1C11
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030717; cv=none; b=mNxNzjZ8QFfcSZJLut6+n6dkaqVhLHcDtrv/4BR/jRsCitJLXrXEBXggk+qV1SRESl1spAzwPl3ouZi5F/bxwKQE1ibyxZDPUA74ATlXl92eHv8Xy7g5zEP8N7xhwQiLioZQ7W8ngor0YIHZ7W6bNs6rmBrSzuADa+28dIBa8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030717; c=relaxed/simple;
	bh=1gdoLK4vM63wf04+Pf6qBO245s/Hl6oTP4vLMcst1HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NF90wlLy2crCVRwBrSThlX1Ck34qynfmH5GoqdxtE3dCa/Qu8aXcq5zniZtEBTItkMRrIlK75GSHKuKqEmr3i27+W7j6XieEE4A8/l/LMp3NDwFisyByjAV3vhVVR0tc0miSzmEMp+MuBryaRzjqMEl5FjYsNRPALt+3DjfpVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORfri9b5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORfri9b5"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79427f739b0so16009337b3.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771030715; x=1771635515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZxTltH9cGgA2QuumYDApBkEygFPAhX3Y58v2etUHqY=;
        b=ORfri9b5Arh42DN+I7YoNn7OtA/JpD6/34SqJErbSXODVZb/rE14aizsfAmePzZPMz
         c2tRwdSxa4MOjZQtcNBWyGvRs6i/AuLBW6Na2/F4+wA0WTfdDwjGLr/DYhtPnYSjl3Bv
         tPXHS36k+gabb+ZsmMMWGYUmWg4bEtVWWPpS7JAQLOp+acb4AfiO8lUCjqHN/V9Fqj+W
         lUDAZTiP9GYuoBnZH8wkp/FoXW2kRoIqNtFQqzznOjyILc+S3NNhUgrlEJAJx4PpMlIX
         m/5nOouKZ47xTmFfc02GUX25KZrRts02/5YyXf0nByT471wHV8FFAAc8T4irPHsWjMN8
         Iccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771030715; x=1771635515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZxTltH9cGgA2QuumYDApBkEygFPAhX3Y58v2etUHqY=;
        b=iSWROMIkIxqWZCdpybKgOKJq2fOV6U9s4zsf28lWp63Vls0TYB6w+MEopckL7ULDWa
         VlPkkEZwCQsmo2rvzH5jX7UO7WmTitGamh4/+pNUL/5rFzYc/E9o5uxIVq7M/vci5449
         jk3UW18Wgq1iU5xKhNulZZFvxS0kxEL5MTEEk9A8xGFKL2wk98YEpaGVBuhyhtQIPwqa
         0a14GE49HpzwvOOeXmw1s2nzhdx2oXyx2KKcde8vnObl7DXovR37Rrg33xF2Vvcundli
         AL8Rvipy+2MmppOHO4KDEOO1CwTwWV02LpHEJJEzv6Bvc/yqn4EZmLwCY9ErFMHfH3FK
         s+QQ==
X-Gm-Message-State: AOJu0YwCcUSz1L1DZubVUNCgPe1xARcYlDkkh73tessrSx3ncCl7Hbpe
	cnRbZrp57LJ0el131dWVRYI+L0Xjscral+n6wWbamWP8n5U81ZGtOgQHewFrEw==
X-Gm-Gg: AZuq6aJZVKM8Iqu9Aw0EL1mOeVL24Qt1419HwB5MeW5aJo9DY/hMy8OLRXz8X9Zju2W
	1WDUlFi1MeM5OEEDosndRVEz21yl8NgY84RVBZFaa18a/neagAzvK82NnzzDcfp8lbMsdhhK2hl
	SxU9K54+W+dj37RMPEawiwLH5wxrhkaof7mK9HiidQLAAkzT9zb2K3rYYYHccKUdRVM+WapjzLp
	EJOzg+Ewpa210BoMIeenDv3l8+qaNiVAAQ5caMCfPfFgyJNiym7qyCThxBl6uDEj+9jkPpfW0K3
	avq/9HtaDpZB7/BEUf/UEOQbvsKQXM24y3HQIMooPSigFIUhXcT3ThaC6tNsRP6OXg9dv3c+FFP
	zYkwOpEwKUCWQNHkYYWNz4l6VcC+LKi2W2kgVMtuasqlf/4RAZFxkTY99KoytyWywGjaP++zN8S
	IBJxo3mvy3DNWEIZYkrfwVCgvseUQ5msFJzjS4ArmfuIGsPf/4OTE46LXGkEg4NQ==
X-Received: by 2002:a05:690c:fcf:b0:794:77da:aa55 with SMTP id 00721157ae682-797a0cb9be0mr34519187b3.42.1771030715173;
        Fri, 13 Feb 2026 16:58:35 -0800 (PST)
Received: from localhost.localdomain ([177.118.182.126])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c2533ccsm77824947b3.36.2026.02.13.16.58.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Feb 2026 16:58:34 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v6 2/2] repo: add new flag --keys to git-repo-info
Date: Fri, 13 Feb 2026 21:35:16 -0300
Message-ID: <20260214005818.37349-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214005818.37349-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260214005818.37349-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user wants to find what are the available keys, they need to
either check the documentation or to ask for all the key-value pairs
by using --all.

Add a new flag --keys for listing only the available keys without
listing the values.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 11 ++++++++++
 builtin/repo.c              | 32 +++++++++++++++++++++++++++++
 t/t1900-repo.sh             | 40 +++++++++++++++++++++++++++----------
 3 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 693e1bbced..319d30bd86 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(lines|nul) | -z] [--all | <key>...]
+git repo info --keys [--format=(lines|nul) | -z]
 git repo structure [--format=(table|lines|nul) | -z]
 
 DESCRIPTION
@@ -45,6 +46,16 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`info --keys [--format=(lines|nul) | -z]`::
+	List all the available keys, one per line. The output format can be chosen
+	through the flag `--format`. The following formats are supported:
++
+`lines`:::
+	Output the keys one per line. This is the default.
+
+`nul`:::
+	Similar to `lines`, but using a _NUL_ character after each value.
+
 `structure [--format=(table|lines|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 23c5ee88b0..6a62a6020a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
+	"git repo info --keys [--format=(lines|nul) | -z]",
 	"git repo structure [--format=(table|lines|nul) | -z]",
 	NULL
 };
@@ -148,6 +149,29 @@ static int print_all_fields(struct repository *repo,
 	return 0;
 }
 
+static int print_keys(enum output_format format)
+{
+	char sep;
+
+	switch (format) {
+	case FORMAT_NEWLINE_TERMINATED:
+		sep = '\n';
+		break;
+	case FORMAT_NUL_TERMINATED:
+		sep = '\0';
+		break;
+	default:
+		die(_("--keys can only be used with --format=lines or --format=nul"));
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+		printf("%s%c", field->key, sep);
+	}
+
+	return 0;
+}
+
 static int parse_format_cb(const struct option *opt,
 			   const char *arg, int unset UNUSED)
 {
@@ -172,6 +196,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 {
 	enum output_format format = FORMAT_NEWLINE_TERMINATED;
 	int all_keys = 0;
+	int show_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -181,11 +206,18 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
+		OPT_BOOL(0, "keys", &show_keys, N_("show keys")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
+	if (show_keys && (all_keys || argc))
+		die(_("--keys cannot be used with a <key> or --all"));
+
+	if (show_keys)
+		return print_keys(format);
+
 	if (format != FORMAT_NEWLINE_TERMINATED && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 4155211e5d..a9eb07abe8 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -4,15 +4,6 @@ test_description='test git repo-info'
 
 . ./test-lib.sh
 
-# git-repo-info keys. It must contain the same keys listed in the const
-# repo_info_fields, in lexicographical order.
-REPO_INFO_KEYS='
-	layout.bare
-	layout.shallow
-	object.format
-	references.format
-'
-
 # Test whether a key-value pair is correctly returned
 #
 # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
@@ -119,8 +110,8 @@ test_expect_success 'git repo info uses the last requested format' '
 	test_cmp expected actual
 '
 
-test_expect_success 'git repo info --all returns all key-value pairs' '
-	git repo info $REPO_INFO_KEYS >expect &&
+test_expect_success 'git repo info --all and git repo info $(git repo info --keys) output the same data' '
+	git repo info $(git repo info --keys) >expect &&
 	git repo info --all >actual &&
 	test_cmp expect actual
 '
@@ -131,4 +122,31 @@ test_expect_success 'git repo info --all <key> aborts' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
+	git repo info --keys --format=lines >lines &&
+	lf_to_nul <lines >expect &&
+	git repo info --keys --format=nul >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --keys aborts when using --format other than lines or nul' '
+	echo "fatal: --keys can only be used with --format=lines or --format=nul" >expect &&
+	test_must_fail git repo info --keys --format=table 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --keys aborts when requesting keys' '
+	echo "fatal: --keys cannot be used with a <key> or --all" >expect &&
+	test_must_fail git repo info --keys --all 2>actual_all &&
+	test_must_fail git repo info --keys some.key 2>actual_key &&
+	test_cmp expect actual_all &&
+	test_cmp expect actual_key
+'
+
+test_expect_success 'git repo info --keys uses lines as its default output format' '
+	git repo info --keys --format=lines >expect &&
+	git repo info --keys >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

