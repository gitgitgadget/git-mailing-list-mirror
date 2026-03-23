Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC962773E4
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279785; cv=none; b=MHyWfRNZkGLWzIDkV65Dd4IlfXkWIuoeiN1HOr/YuYkG0BWBlyYKLd+5oWxOwzyvIBf+9V9T8vXxssJIzTsoqWbNauyZkT1Q7UptxOjVdoWcRXysskpAIOo6aFamToB7GEYGtyBkEBKMLri5EdS0QwjpdzXNbPlICRYjYUPBvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279785; c=relaxed/simple;
	bh=/lvMaiDEpoqnhJrfj4ehEgsLskndqeeWENcLu0aHVys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OpMvjJiKTzbCNd4CWgOZxxMgD3D9SaHvl+9rayVJJRB+duIV9rEnwlT5EUDffPOZib9t0k4csPEZrfN+mcPPp3vRJuInPVsd4xot1WPxbP9aiRbeZSkm0fL5UsUyrT5V/efTJGTFHV65NEutxxKFvak4+ZadvSijbJM2jIorcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqUi1iMT; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqUi1iMT"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so319947f8f.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774279782; x=1774884582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sgdjg5v4KSWcEectdzvM0DWcUBj3v7yWln/tu9KbPPg=;
        b=UqUi1iMTF0UgK+9CI0LCMUnZJ1+drDY6l3ANG4um/JI735UV6p8b/dyBptxp3YXtj0
         8H13vmgyRkyI9+5Zl583d3S73f14qo+/EiZ6/Yb+5Uy3PJZKBLQhyypybPNdaS+BJ4MZ
         ErIj51C4LUYOkjjHX48U3edrYV78m3ta43a7Rafrrwx+BUEs7/zWii2vTYqjDYM92UfT
         RlY45OEhX+YJt6TMoh8lks918yv9nBz6jYepy1R04Hre3UN9hwH99OxtiQN4113w1TsQ
         rEBmVy4N1skuMI6hJha2SqbZLm6ZBsgrj2mcEgvm98XAxVClp6W7fSPl1x/RQN5bQgGj
         iFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279782; x=1774884582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgdjg5v4KSWcEectdzvM0DWcUBj3v7yWln/tu9KbPPg=;
        b=EmLSjW/tQQ8MP4Q3qgYwYLGaHyPWhSwTknsUMmEMpilsWvZ6X1uV1ttH0+A5blN+PE
         uuzi+y/BAs0rOrdYWbFnXvC7gMRVQ8TTCSzHt9gJpvP6nsSrOCnIXSGjXj6d3K3xOhSN
         L0u8DZ1BOvNM9rLkOk3JkhaCv7MvVoM0M6HJXnXS6VgNk37W/sIyiYMIqr/tdnNwVgY6
         KDGKSonIczw2EWBducajWZBF3EVNfSuEzPAUR0YVpYrys1DScGahh+P0GZ5gSOz+o9q3
         mClr9KMa8GDYOtU4wTv5HS6XJ9JzCFknXpYYxBsqUlmM90a4sofjUPFqNr8/N4bSnnic
         bliA==
X-Gm-Message-State: AOJu0Yz6D4RpfA4lwXhhOeH0RPGSQrZEGBkM89e49WRAoEmjiH2hg1Od
	NDx+NojeQOoVs7WGNxJO8uokYbKh+XUxmyvjbg19UdvcmT5269N+fgiQqL+iAh3PzC4=
X-Gm-Gg: ATEYQzzHYLXgIDJzxBhy04lOx4V+oV56VJkQ8RQ/h3zU1t5cwVclN+uxt5P3qz16Dt8
	92ZIVYQw9mS0ICs2uX4pshWNSlzKeuQSaeFvGAe7Lg47T0+eUlpduc+48/TpzQmbc9NREHGj+UW
	+Z8CkLL46mlJNhnXJjQ26NwbyTjjR0+BkjM1gEzK0i2Sq5z5qQyiDvD+YH5+/JD1Adl0tX/+bOG
	fzddBJ9OX1FzaaWP8nUNOmBgo42D/7JJm/sKVBSGn7VYSlVTJ8uRFYwuTbGJ9L9/nckEv22QLjf
	npf1OAjDyvdsBeSWdmWSK2Uo6yamlhJt1/+uy6IrA7hsscyiJGNcKTtFAN6vEq0C4KOsQnF/Xls
	EQJpewFwNTra380cO2BnEEOO6GjUjqP4QpFJg/No0sB1mek7+XiPHmksUUgnpBeBIx3PcYEKyPd
	nEDV2sNtc5va4qz8hEO25U1N1LTc4L0fS8D6wPHLqAq15p1phpyZW+3/sUuHZqikrQsBjs2KBj+
	oBCIFB+rcA4dwav
X-Received: by 2002:a05:600c:8707:b0:487:338:b4df with SMTP id 5b1f17b1804b1-4870338b5d9mr120494765e9.15.1774279782022;
        Mon, 23 Mar 2026 08:29:42 -0700 (PDT)
Received: from macbook.. ([88.130.184.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe032a55sm551802205e9.7.2026.03.23.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:29:41 -0700 (PDT)
From: Mahi Kassa <mahlet.takassa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	lucasseikioshiro@gmail.com,
	jltobler@gmail.com
Subject: [PATCH] repo: show subcommand-specific help text
Date: Mon, 23 Mar 2026 16:29:37 +0100
Message-Id: <20260323152937.257406-1-mahlet.takassa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use subcommand-specific usage arrays for "git repo info" and "git repo structure" so that each command shows only its own synopsis in help output.

Keep the top-level "git repo -h" output unchanged, and add tests to cover the subcommand help behavior.
---
 builtin/repo.c            | 15 +++++++++++++--
 t/t1900-repo-info.sh      |  6 +++++-
 t/t1901-repo-structure.sh |  5 +++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 55f9b9095c..5ccc5c401a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -27,6 +27,17 @@ static const char *const repo_usage[] = {
 	NULL
 };
 
+static const char *const repo_info_usage[] = {
+	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
+	"git repo info --keys [--format=(lines|nul) | -z]",
+	NULL
+};
+
+static const char *const repo_structure_usage[] = {
+	"git repo structure [--format=(table|lines|nul) | -z]",
+	NULL
+};
+
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
@@ -214,7 +225,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
 
 	if (show_keys && (all_keys || argc))
 		die(_("--keys cannot be used with a <key> or --all"));
@@ -879,7 +890,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..e0e79ff167 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -148,5 +148,9 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	git repo info --keys >actual &&
 	test_cmp expect actual
 '
-
+test_expect_success 'git repo info -h shows only repo info usage' '
+	test_must_fail git repo info -h >actual &&
+	test_grep "git repo info" actual &&
+	test_grep ! "git repo structure" actual
+'
 test_done
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 98921ce1cb..0f7ec4da10 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -224,4 +224,9 @@ test_expect_success 'progress meter option' '
 	)
 '
 
+test_expect_success 'git repo structure -h shows only repo structure usage' '
+	test_must_fail git repo structure -h >actual &&
+	test_grep "git repo structure" actual &&
+	test_grep ! "git repo info" actual
+'
 test_done
-- 
2.34.1

