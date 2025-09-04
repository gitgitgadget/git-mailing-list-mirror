Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F41308F1F
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995745; cv=none; b=DBVT2Gmkv+/vJ0htuLeBqraLaQDm39zW+iiln4z3NwqABR0SKg/xI76AU062qo8wyWtS9tnbtrGdqvOLfF1G9x6o53zBr99BRphR3K4UcuzdVlRlIgFjtlkG33rufcvB65gkN5KjeG/oqxRwNCFQABUcCRoVUh/AdZgipa9KdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995745; c=relaxed/simple;
	bh=i28lJEA5xXlMmWNAAwK3AjrvLaR3AduHpl2Rsei61E0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSQwpbp5LCz9neoVfrQ8zplviOEYwjw7YqKQfd9wVyeg8UdbmFEDBvaG6te+0YvQjhnHuvr7W3aTyHPVIz9wG5nHfr2Zt2yQ6PXxxnvjsSgFWVmjlrSON+jxErYeo3WEcGAksKwLJijFly+VD8C3COuFquDEJcfjG+vRcbWehNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0hay26O; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0hay26O"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-545dccac2f9so965428e0c.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756995742; x=1757600542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzQ1y/hSnxUvy+p0oYqoyY8QWRh9/rhzLzzVGOk0zYQ=;
        b=B0hay26OSyaAI2RIe/Td4Z9YtdPMtcF3ifobdd5+O+sxXUoWcdhfyL8YWXNecZMj57
         NPBdP8L6FgwEm7h9VXeZ6RfI4QfuJ3CC/WICzTfQZaY9PeeMbh+V1g0DbyrVJ4/CWuKf
         jV2frFwWAXSXPuEHdnYES4MH6IqkDEp7SDpO7tZfCGH8xXOy2kjNmRRbgNN2vISZgZfR
         Kg61+wbzfeIIaCXIEEnurx/5H1r8FdFKMug1b7dywAIunbKBGybyCsHoFffN1B+/NSyD
         krxHgCF4qC5zauLwPN2lBDg3LEuLmpd4xFey4F5jLwBEKsoTiq7MleY7xE7vkHsYLDOG
         /XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995742; x=1757600542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzQ1y/hSnxUvy+p0oYqoyY8QWRh9/rhzLzzVGOk0zYQ=;
        b=ia3wbkvq2AdfpmruWjjUgtdwROIVn4dwnKDCAzUzGjGSh0vfx4L/Gkuffh7RUF4Wpp
         lyOjlVShSfRsiZ1DixHnKMj3+xtdpfV8Its+hdkjLevxW7f8MdozG4nNiHaAA7aulI/U
         4cLsAJ4H6CU+GkMwKlsQLGMUDm8BSpoFUIiAr9JpPbSa+piZklxn/FSdf2RckM/c3amt
         qHrdZI5BH0Gi+0hDgzql42cFB+vNnwhaPG8gqV89vb1xAzhH1kapdBqMAJ3GOwzoGI7P
         Mc/2aJFUwUeoOk+fCMhQYEeSWjuRUwkEZb0dunHka6N/tDldcmjMLg8NNk+auswWpJcr
         BcZA==
X-Gm-Message-State: AOJu0YxDJqwy9PyHUgSsmsm+JSXQyNYE7HWV05YF5wwpS7PkD8A/IW8B
	WRPlUfSLSG2MZA7lcA3tw3fkKyyZRPpCJ7DTfCleW1mXpaS4wi5UYnWCDMnYsA==
X-Gm-Gg: ASbGncvf1zMqMmgIm5QiYNnHUE88s5OF+h7CWSeHI50ReafkTvUsh5H5A/csxTsUGl1
	IBUNWfx+Ch1qf5E5JEm+cQxal3s2SQm0+TznYsWPw+GfDZErijhsClLQgiRmx9ApDlvFdkg34+5
	HVLcn/RU+1DM3SXVBCp0aePuBNHPIwWxbqmpDQptYnv5kyYITrnlm2hc/uI5oTbq9dIh0FqGdWR
	B10fBaqC259cZOras4ZILwn+yBXAKGLUQvdvQS0rpOUKhv3rklpIxDizG7wSyJANuHU4VtjRsdy
	6HGU0hE4Qru3u+94SVTsEVDowHt5vaShur9Y2a/pP3xWSPxMxFM6Bbh1LTns5OnGlu4hbHw0LeT
	+7Na3iuAH0ytQ47YTyfBE2Mo+K8H+wQ4X651xDUN7cQnTBcTDas+hfiXmFRGLiB8=
X-Google-Smtp-Source: AGHT+IF5j+fgM05zhFjw9u7SIN2N0hDjJkb52w9vOyZAtT8keDlvdhRPMbsebbY41DC3St+4Z4Qwnw==
X-Received: by 2002:a05:6122:1309:b0:53c:6d68:1d31 with SMTP id 71dfb90a1353d-544a02f8a13mr7387679e0c.15.1756995741538;
        Thu, 04 Sep 2025 07:22:21 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:8aa:3d64:69a5:cf8e:268f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544b1933316sm5409732e0c.9.2025.09.04.07.22.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Sep 2025 07:22:21 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v4 1/2] repo: add the flag -z as an alias for --format=nul
Date: Thu,  4 Sep 2025 10:40:16 -0300
Message-Id: <20250904134017.47364-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250904134017.47364-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250904134017.47364-1-lucasseikioshiro@gmail.com>
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
 builtin/repo.c              | 38 +++++++++++++++++++++++++------------
 t/t1900-repo.sh             | 12 ++++++++++++
 3 files changed, 42 insertions(+), 14 deletions(-)

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
index 8c6e7f42ab..dc9a267469 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,7 +9,7 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
 	NULL
 };
 
@@ -112,26 +112,40 @@ static int print_fields(int argc, const char **argv,
 	return ret;
 }
 
+static int parse_format_cb(const struct option *opt,
+			   const char *arg, int unset UNUSED)
+{
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
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
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

