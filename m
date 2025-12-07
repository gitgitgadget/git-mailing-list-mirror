Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF74C9D
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765134355; cv=none; b=mUdoyEvZ6yZEDiD08l25tB3HsrR6wSN1ZYq+fIV8wjrhSG5vdufQRmtneFZAtObaWiXSBgVz+QecGiPvk0agclT3HMlgaO+Iiv1D+ZE/yMQHv0aTwKPiLBAqc6dr3lwrtGftcw2r3nm9g8AetYsg6/rGwMVixTCWQzPQCvRnfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765134355; c=relaxed/simple;
	bh=Ea0jAKO//xGVqJyaut6tm8UFEm/QWyFtiv6x2wvjMag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVgixiL1NvsjTbHJoZVA/9KvwFxUA9SkfQ9JGFcWd1EK3PTQ0DUROffZ4WCxg8uTyyW43a5kleJU1zEPS03WLWtTCcL+/eHwk7KGtJ8EUhUocJsam+XLmkpqOGK5RxIE/hEizCrq5MKle8mp2FJjO7l0RGKnkSxfQnTLokUhEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ8QPry1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ8QPry1"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso6144884b3a.2
        for <git@vger.kernel.org>; Sun, 07 Dec 2025 11:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765134353; x=1765739153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTPFHcZ7XO9j/pket7V1F82IAArWLxNNXDgDXJg5E2I=;
        b=TQ8QPry1iOr2Lu43il5KhvRLWu9sw5Nkm+6A8Zi/pqYM8XYT80Qvk6IOcypyrLa+Da
         tkieQrSymemUW/yW1/Kvns5PU+KTJYHgfjjg3wRp0pgFiXCM3kyInlK5rpZCaUhZZZv5
         Rujwi8bXTwcKOjYYnePktWoRK3b5p4MYUmoZdFQflwpz3ROy2e4JBYXYnvlzmADN+g/X
         sTTpRz9ILijphzaXnXEXAmibm3AGV3Bxtsf0oD1Tw+R2irfv/rRqDvolmaqhnaFAoTyA
         hGPtFGjo9xVhBrbHTMzwOkR61gEz21722y4G7kaWAtaBWgaR/KdzwKFV50YUvjAEOpga
         C1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765134353; x=1765739153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTPFHcZ7XO9j/pket7V1F82IAArWLxNNXDgDXJg5E2I=;
        b=kZuwrbYyLVcPyGEmZeTp6FuQtK3nXs7eaxSpq5SsKF5miXUf9wJYHab5BMoUw783tb
         O3EuYrtHhTN3NdhBYiIKoHGuXEzu8GYS/QRYMVAzQVD8Wyi58rZ2cT8w9EMSMVhlrQZJ
         NvpMSbhxl2/bZmOFcxYiDa//i7XTpFFdR8nFsBnmwZCikqOuoDNDGK5nLYcY3eqndwKW
         UC+CTKLvrrOjdxbHPKoJv0r8Vq1krNR5o7CzlLI1ODTVbpStwuHpM9KYWK1WJ5JQhwA6
         8Z7rtQAutQdzBYS41VPL2tSxkqgU4ZcTbTNoKi9Bgd32N5ZsaLlqfThRoOUr82iPo0Mu
         14cg==
X-Gm-Message-State: AOJu0Yyc2pq2g2pTJMxJ4q+OIwkz2mND7J6w3MF7/4EgkmmnGnSD28BD
	DD6UBtfOYbBciQzw3i1tGNh6DPHeeDL0W6kc4IrWi7CAN2MoSd4IBR193M0Cmw==
X-Gm-Gg: ASbGncsiUcdXnQR314XtdSAPn4X6kA3T4TkkG9AdmBf8YcwWZrpu7ml/fJTrQD2HAXG
	j1NyskXk91WatPRg3RxFOrjd+oOGWoJbRmhceASJ1fFHT1VZ1J4J0nYM0O8xifj0V6LZcM+QzCM
	eLC5F7stTzolmrT0ZNbLavdzfkvSFHTCARyhxbhObcXN1jCSLLo9NC0OL8Pk/8XnuC3PfJpUmOk
	urpaqt8YaLmfODCVcVmWzULZrnDmElgQK2aVjqEkfu4HQNo7ccbFvDbaVDVfzkZ8Ofqlcm5MTc1
	9jlDOIyNCwZyCtpgkzFu+U2TafUGw2A/yv0pqP4kCUv73StRZ8qtOIdTmAgvbHr2SH8L1Si0UD6
	zh/cW2lFthTSq/7mEuyZ6rDkzgVlYqD6ecnGdb2ebc/pkadf2CGtHRCihhhPf6bHjAK2MkSMiwa
	5E2QcpVeAZV92cB4K0FYzQPmrmTpaFJeDYMEsDLb28Ane/ljwg1T4kJkXI
X-Google-Smtp-Source: AGHT+IHDuFf5dVnr3UtHPvpo1D1oUiIVIi2m0pN5F9H69yTRPEMM3P2lx+puKF8y4WZExeKnopVZMQ==
X-Received: by 2002:a05:7022:699d:b0:11b:3742:1257 with SMTP id a92af1059eb24-11e032a64e1mr5065725c88.34.1765134352584;
        Sun, 07 Dec 2025 11:05:52 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:1d14:e806:4720:2c8a:c40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ed82esm48767092c88.7.2025.12.07.11.05.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Dec 2025 11:05:52 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH] repo: add new flag --keys to git-repo-info
Date: Sun,  7 Dec 2025 16:02:10 -0300
Message-ID: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if the user wants to find what are the available keys,
they need to either check the documentation or to ask to all the
key-value pairs by using --all.

Add a new flag --keys for listing only the available keys without
listing the values.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

Hi!

After the Junio's suggestion [1], this patch adds a new flag --keys to
git-repo-info. This new flag only prints the available keys, without
printing the corresponding values.

This patch is based on top of master bdc5341ff6 (The sixth batch,
2025-12-05) with lo/repo-struct-z merged.

[1] https://lore.kernel.org/git/xmqq8qg3do99.fsf@gitster.g/

 Documentation/git-repo.adoc |  4 ++++
 builtin/repo.c              | 17 +++++++++++++++++
 t/t1900-repo.sh             | 13 ++-----------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index c4a78277df..f0f4d77db8 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
+git repo info --keys
 git repo structure [--format=(table|keyvalue|nul) | -z]
 
 DESCRIPTION
@@ -44,6 +45,9 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`info --keys`::
+List all the available keys, one per line.
+
 `structure [--format=(table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 0dd41b1778..45e9d59d55 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -16,6 +16,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo info --keys",
 	"git repo structure [--format=(table|keyvalue|nul) | -z]",
 	NULL
 };
@@ -146,6 +147,16 @@ static int print_all_fields(struct repository *repo,
 	return 0;
 }
 
+static int print_keys(void)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+		puts(field->key);
+	}
+
+	return 0;
+}
+
 static int parse_format_cb(const struct option *opt,
 			   const char *arg, int unset UNUSED)
 {
@@ -170,6 +181,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 {
 	enum output_format format = FORMAT_KEYVALUE;
 	int all_keys = 0;
+	int show_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -179,10 +191,15 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
+		OPT_BOOL(0, "keys", &show_keys, N_("show keys")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	if (show_keys)
+		return print_keys();
+
 	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..d6e84a78e5 100755
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
-- 
2.50.1 (Apple Git-155)

