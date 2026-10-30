Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793366038;
	b=aOCZ0nmwEkCoZLdEWWiuw5D4llE3LvSvc/QXGy8DaD+tRvAzGSVrtba/bnNBvtgjBrBW
	 +ZhwqtSj2o+Gn7WgHsQu/IQXeVx5IvIqfz2OBz6DZWDPYIx2qrU0QCVnH5R5XtADm6Ypv
	 3ueMKrXyq0939FHk+bf4lvPwIGV/3Ku/AMK8umhPbAJX+4F1YNbvKihaNfycAAD7IUFup
	 tCVW8BxLymLHcCr0Dnbl4O/NT149pPrTV9aDGqFJ9B+uyQ5YWM6mEulCn7N/NT1HORf3L
	 HIwtuaNsH+F7tDRlqcH/n7TLAqTIBud2CAKzWsEL0mrzsKeNSXbSVc0FwciyEkHfIeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
	b=CH5U6vgDeyMIFI59Zxr+2hfX1Ne2Ro8yI+wElsutPDCRzjVB0yCKLTGCHJ5q30MvphRR
	 rbh3cK0vFCQqbmxEh9C1D6bQsghLdz1mLrkcIwzr/QLYcyIHkMLA/rsCnPXoSrAGhMR6N
	 rXSumJ12XCEDXRFldlNcRhmrHwGi43P8zq+pr08VXkaEHMMR/Uf/U6UiDMmU+miUzIpSG
	 fEqMWu/DJJhm39bvgve7PcJIxW4OX+5qDKSyu3B0Fht9Z8gMGMcyCR6h5G+YsScmsMViD
	 E9QoOO3OfgZNZofmTTqRxEX1IvjdhKSULHhrYJTVXczKrUKXmpe83nEO4mVG9rOOVcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VSswUdga;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2D606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC2D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VSswUdga
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so5124055e9.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793366037; x=1793970837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
        b=VSswUdga4AEPyRW0c981KOqJqdvjzvE7usYn3+g/Yc6VYzHlLJmtv+DiyDnV4ZWYBn
         0HNJqSeOaaDk9cEuYIOPsKEuXfLjY/7OpkxLR6MeZuQPl0DZTodFw6x2yiIHowjOa+Ad
         Z980XmBVzsxGDNu8uv51UFNbG7r/E/FPQExJXbVul76Y+19RyQehicdVzlD4qEdZDns3
         sUpCO72ITVNmFfDroRWW2xOWtrnK+thbznKWba8HIyrdgvq0/oRMHLeAx4o6AL/KRR8w
         dxpjT4ggpP7RqVNjwiuKSzPLpEn7leZp/Ud9NQk/RnCsOORGx+D59mJsB1fvuDlc2MlS
         9eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793366037; x=1793970837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/sjVtLbRLs7L6oZGk8aKsMD7OafhaCics04Sjpe83U=;
        b=2Q+jbsFl+IYWzdnLLwVKkbBmVLnXi8iH5IDRbwvvskb4v5nSDxj8KmNn5xO50iXhA4
         T0t7fWJlcK5GFzPb+k1pC8vNGKsg9q98SOJS5udT8Ycodv2351yknV9M03bZYXMuUFu0
         wMav+HsvFFpql5DQuqKnVffoLRCj6wCJRBKwX+2hWuXNQMVM1Q0ILKgyhnEB82H2FZS8
         rfIzr6J5AHa9fSg9T5AUe+afVDc6nCBBm4B8tqdfbRncVSP9t6Sgb0DCGCv5dhbh5i3y
         ATPY838d83ThzOu5JfpUSY0dK5RvnpCaJ6p/dpJBK8ZfV6IXpsVB5UZrRwqAJaGWD4vl
         9B/w==
X-Gm-Message-State: AFq9FYKeiJecHnrzStw3jWMSteIsD4RHHuGROn+yVVTgPK3uiswsFEIU
	DKZRM5JgSx5tEq9TjdNVtBrEADE3dktF5fxWQ5X0fGoCosRTWk345Y0wEhAk5rlXWk9NE62/
X-Gm-Gg: AYBFou3Q2itIsheHegmNlCrNJTKoMMqs1fMABR1dXlZ52Li8hBt0O9BXZMVoiZ7hAKv
	QcTCKO1gQHCGmvydX7o3U+SuJFafT3sSN/WYWijIABJGXfIeFkc8gAonr8W4PCGPsZGgAEV39mU
	Hf15zLOiV2T3OfrZ45KOe7x1FdD9EpCrD5ce5jneC6Zg3F2aC1ENj0pcIv+KzjWAXxXC2RrtFgJ
	ipz+lSv5DrRy74eGzzNSka9NBjPXCtoWE4p83T9FEq5ar0en4JjA0rAf0zX7vYZxuaQBjLTrRo/
	KOjr0PIq6LrnQssstwNEnHGELsE7qWbyLKsJvOi/M2oER1XsMZGJYWHUy4gBYa0MzUFXOUOon8H
	1KchJQryJftcDcd+F2+rEmgBHEFSAlifTbtEuTGcwT41emI/TnVju/oRcjyY3hJwaO/vL2E/sqA
	misj3Tb1UXyx6tVrV/K98vgB/uxdFkWo1jKeu3lUYog2UziEw63+RRaufmRHa/lfRCZBuZ68rLN
	81bP2pCmiQ2kQK0qbAqULiVObCuCNraCsGwONtmr4Yqp5G0zed2H1VH6hbANcWUAz3Em4P4cywu
	VyF14L8QN7VL59A0r2pedsObAWYWf37IdBboLDZVo8eJMPhRDVxUpXw7v9cMF4R+C4H3fC/g/6J
	sRSBpcqzWiASsCf2HZlIOo2jqHZoJZBRv5WjjkkbSCLvhjNO4r8wQaE32RpGOaQphu0cx/9Ko
X-Received: by 2002:a05:600c:34cf:b0:4a7:c366:d791 with SMTP id 5b1f17b1804b1-4ac150b38ebmr50914635e9.1.1793366036678;
        Fri, 30 Oct 2026 06:13:56 -0700 (PDT)
Received: from localhost.localdomain ([212.88.111.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d295csm138740875e9.7.2026.10.30.06.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:13:56 -0700 (PDT)
From: Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: edsonwasswa54@gmail.com
Subject: [PATCH v5] builtin/diff-files: convert ad hoc option parsing to parse-options API
Date: Fri, 30 Oct 2026 16:13:38 +0300
Message-ID: <20261030131338.1513-1-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wasswa Edson <edsonwasswa54@gmail.com>

The cmd_diff_files() function manually parses --base, --ours, --theirs,
and -q options using a hand-rolled loop with strcmp() calls. This is
inconsistent with the rest of Git's codebase and lacks features provided
by the parse-options API such as auto-generated help text, git completion
support, and option abbreviation.

Convert this to use the parse-options API by:
- Adding option definitions using OPT_* macros
- Removing the manual parsing loop
- Using parse_options() for consistent argument handling

The --base, --ours, and --theirs options use PARSE_OPT_NONEG to prevent
negated forms (--no-base, etc.) which are not meaningful for merge stage
selection. This follows the pattern used in builtin/checkout.c for similar
stage selection options.

This makes the code more maintainable and brings it in line with Git's
coding standards.

Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>
---
 builtin/diff-files.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index ea91347ce2..e9e4907311 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -14,11 +14,12 @@
 #include "commit.h"
 #include "preload-index.h"
 #include "revision.h"
+#include "parse-options.h"
 
-static const char diff_files_usage[] =
-"git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
-"\n"
-COMMON_DIFF_OPTIONS_HELP;
+static const char * const diff_files_usage[] = {
+	"git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]",
+	NULL
+};
 
 int cmd_diff_files(int argc,
 		   const char **argv,
@@ -28,8 +29,19 @@ int cmd_diff_files(int argc,
 	struct rev_info rev;
 	int result;
 	unsigned options = 0;
+	struct option diff_files_options[] = {
+		OPT_SET_INT_F(0, "base", &rev.max_count,
+			      N_("show base version"), 1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "ours", &rev.max_count,
+			      N_("show our version"), 2, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "theirs", &rev.max_count,
+			      N_("show their version"), 3, PARSE_OPT_NONEG),
+		OPT_BIT('q', NULL, &options,
+		       N_("be quiet"), DIFF_SILENT_ON_REMOVED),
+		OPT_END()
+	};
 
-	show_usage_if_asked(argc, argv, diff_files_usage);
+	show_usage_with_options_if_asked(argc, argv, diff_files_usage, diff_files_options);
 
 	repo_config(the_repository, git_diff_basic_config, NULL); /* no "diff" UI options */
 
@@ -48,19 +60,8 @@ int cmd_diff_files(int argc,
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
-	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "--base"))
-			rev.max_count = 1;
-		else if (!strcmp(argv[1], "--ours"))
-			rev.max_count = 2;
-		else if (!strcmp(argv[1], "--theirs"))
-			rev.max_count = 3;
-		else if (!strcmp(argv[1], "-q"))
-			options |= DIFF_SILENT_ON_REMOVED;
-		else
-			usage(diff_files_usage);
-		argv++; argc--;
-	}
+	argc = parse_options(argc, argv, prefix, diff_files_options,
+			     diff_files_usage, 0);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	rev.diffopt.rotate_to_strict = 1;
@@ -73,7 +74,7 @@ int cmd_diff_files(int argc,
 	if (rev.pending.nr ||
 	    rev.min_age != -1 || rev.max_age != -1 ||
 	    3 < rev.max_count)
-		usage(diff_files_usage);
+		usage_with_options(diff_files_usage, diff_files_options);
 
 	/*
 	 * "diff-files --base -p" should not combine merges because it
-- 
2.46.0.windows.1

