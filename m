Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B930AACC
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747676; cv=none; b=BsM2xRj09ejJlJVAds0y/O1YCM7xPsQA6izjtGn5P/8N889tAreZeXEz+nIEMDthTUs+rDRYFEB24rBjZLOEOMlGHoqib2wL0V9+NQaQqGCNrEz0PUiA0MDldH513+XIueTDMdZvLdl4QiJC6qwmgeWa0HurA8xSkSP1QKYlVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747676; c=relaxed/simple;
	bh=2VS6xioveJJiGdwZXbVnzsOtU3d58Qg5Oa05oWFph3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6xmAvckZYlOVNqUfnHyb8NPZPY4Km1xjZiSkxts1hpmxkQnyPlx46wTgjIOCSxSrTnWyn/MCx+OH2Xc6eOXMjf0Sv0O3DTCEka406SdUsjqeAJOcenlAaQvgi6dp2pMq6fROJdT2MnfRJp1ON8jP/rU0R49jfzs7NAXgFjaMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGlkyP1P; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGlkyP1P"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-523264ecab8so1555026137.2
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756747674; x=1757352474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzo5cMt/noFe1osULVrUp/3kpHo66qh9zjhHfr3c4wk=;
        b=XGlkyP1PpQ3xgDLVzWxxtif7yJ7C2EZJsYMa9paHiBkmZudRIax/Q2m+/lvaLxK5na
         mjvQJzlZbSy+Qy1tW6cG6V/1alPjCRlJJr1kGnQlJH4KYcB1tYED2GVTIVdxgnhkAIMH
         dLumAY9ifohB+0MLhBDY9XK5HgLiNIGpqmEpzJJlvRedgVXyfgRvZrkeQi5obrvmQKT5
         x7PeYcl4rheVN0qf/aKkKksntlsfH7yu9EQ62vNlH4oP33npx8eyIENVqQK9N9kmrbjU
         Pt1x6our0tWb0HoyFln6uwtN8Rb72298QMJg8jtAN4tq9EenlLogiXRbbjTiVddG/JDL
         6bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756747674; x=1757352474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzo5cMt/noFe1osULVrUp/3kpHo66qh9zjhHfr3c4wk=;
        b=Zv37zpDw+sZ3M4DIb6WPed9f61H5uV71FVUp+8u0zuzVEHfP3iOUEON8gGb/uZb003
         vU0IRE91K2CVXeINvXjnO+bNPmc7LFk0AUk53ZN8V9B+KUiWHySJMwTB143+1UoCgLs8
         oXFGpKJoyZm6hdqmLh2kuE65VHTTRhdC61XAiZaLGbixaCexCvsBJ9tEyYW7kWs0oSUi
         xay6hp8JBIsnOxROWCZ2JotP6fWePBOGpq5PxVmIY6p4ZLow4xSZnL4e03PMcFfR4JP+
         QPMTXSUJaEC6Bg0W6+fp7kBFdI7f41DTJj2QrYNSdZ+2eH/+0SFySrCYT9KucSNr/lKN
         Zupg==
X-Gm-Message-State: AOJu0Yy6fbbVPeNGRT5HxV2RsbUbZDCZRcGU2Gh/e6cdbYRGYFKxlll8
	CWxWjgKHVCLAjobtMtnnuJWkD2wCdLQcw+w9lANz1/ZiX/p7wFj58S86ot3WZA==
X-Gm-Gg: ASbGncs1MVWoRFZmj4QJ+Rts/H6R2Gw/jds2VmTjs5ePQluazfoHRVGBD2g2zN0t6hQ
	nXk49jqLj0nzdHufCQlHYHvF/i3mupfRxeYPFTrrxWlPq5pSOeJ4Fae08/FpPYqrmv2LvWzlmyY
	l6ZZreXRjY1auVKvcYAIJUJ22/behYU+HQ9QqrhutjCxXEro7OykgmGWSKf3TBWwqREZYMg5MLW
	PR1tLi0sQeE3BsQCVbimQlCH3TvKndsBYU0nHaBtaxqVp8KAMkeopjEwbKBAT+dLYLa1L4t7P1k
	CHcRAFTTJgFcDMRdHQmpTiXEiZjv45x/RXYXyq9tdA2IXHmyCt/2Th4eW1JI6I0vYVY2GyHIoi4
	9I66BHSKxGEk9kdSm6GR1I7d5jpy4Pmz6/XwEFCAPB+6k8XrhHenPc4aji0HlKbB9342OzAnJzQ
	==
X-Google-Smtp-Source: AGHT+IG1C1262HhiStpiO8KGmhknoo8ZSW4svJxWJgYpokayz1mNs5qyTEOKZXmZ9BhVB5EFO1+Fhw==
X-Received: by 2002:a05:6102:5e96:b0:521:b9f2:a5ca with SMTP id ada2fe7eead31-52b19e634abmr2825679137.13.1756747673676;
        Mon, 01 Sep 2025 10:27:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:8aa:edea:fa75:64b3:34fd])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943b7c2c42sm3973283241.4.2025.09.01.10.27.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 10:27:53 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v3 1/2] repo: add the flag -z as an alias for --format=nul
Date: Mon,  1 Sep 2025 14:27:31 -0300
Message-Id: <20250901172732.98845-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250901172732.98845-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250901172732.98845-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other Git commands that have nul-terminated output (e.g. git-config,
git-status, git-ls-files) have a flag `-z` for using the null character
as the record separator.

Add the `-z` flag to git-repo-info as an alias for `--format=nul`,
making it consistent with the behavior of the other commands.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  6 ++++--
 builtin/repo.c              | 37 +++++++++++++++++++++++++------------
 t/t1900-repo.sh             | 12 ++++++++++++
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 2870828d93..6f5ee88215 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul)] [<key>...]
+git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul)] [<key>...]`::
+`info [--format=(keyvalue|nul)] [-z] [<key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -40,6 +40,8 @@ supported:
 	between the key and the value and using a NUL character after each value.
 	This format is better suited for being parsed by another applications than
 	`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
++
+`-z` is an alias for `--format=nul`.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index 8c6e7f42ab..13a34f68a5 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,7 +9,7 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
 	NULL
 };
 
@@ -112,26 +112,39 @@ static int print_fields(int argc, const char **argv,
 	return ret;
 }
 
+static int parse_format_cb(const struct option *opt,
+			   const char *arg, int unset UNUSED) {
+	enum output_format *format = opt->value;
+
+	if (opt->short_name == 'z')
+		*format = FORMAT_NUL_TERMINATED;
+	else if (!strcmp(arg, "nul"))
+		*format = FORMAT_NUL_TERMINATED;
+	else if (!strcmp(arg, "keyvalue"))
+		*format = FORMAT_KEYVALUE;
+	else
+		die(_("invalid format '%s'"), arg);
+
+	return 0;
+}
+
 static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
-	const char *format_str = "keyvalue";
-	enum output_format format;
+	enum output_format format = FORMAT_KEYVALUE;
 	struct option options[] = {
-		OPT_STRING(0, "format", &format_str, N_("format"),
-			   N_("output format")),
+		OPT_CALLBACK_F(0, "format", &format, N_("format"),
+			       N_("output format"),
+			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_CALLBACK_F('z', NULL, &format, NULL,
+			       N_("synonym for --format=nul"),
+			       PARSE_OPT_NONEG|PARSE_OPT_NOARG,
+			       parse_format_cb),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
-	if (!strcmp(format_str, "keyvalue"))
-		format = FORMAT_KEYVALUE;
-	else if (!strcmp(format_str, "nul"))
-		format = FORMAT_NUL_TERMINATED;
-	else
-		die(_("invalid format '%s'"), format_str);
-
 	return print_fields(argc, argv, repo, format);
 }
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index a69c715357..ddf788d5a2 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -92,4 +92,16 @@ test_expect_success 'git-repo-info aborts when requesting an invalid format' '
 	test_cmp expect actual
 '
 
+test_expect_success '-z uses nul-terminated format' '
+	printf "layout.bare\nfalse\0layout.shallow\nfalse\0" >expected &&
+	git repo info -z layout.bare layout.shallow >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git repo info uses the last requested format' '
+	echo "layout.bare=false" >expected &&
+	git repo info --format=nul -z --format=keyvalue layout.bare >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

