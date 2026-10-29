Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298810;
	b=JTGyIFu13vTMCCmSQlykFuBkHvcLQJlxYJiKgaYaSaC1HruobpTwvLDJD5Pd+vT+YInR
	 +CqFhRL36MOzifjQSm0L2FGhsMsxl7KbNKYKqBVATPEGvfXeJcc3Xj2Qja6MZ8gadiSYA
	 zF3+GeH35YtnkxUf5nvkFDu4bBt2E5qQ6ZtiCg1J4F9E6QlvW6BsxrxuDpnXBZ/W4gUgK
	 iPwigfjFPWiYKElP8nUTlf/o1DknO7nJ1BuTKPKKGAIOAYNzKkKFe1O0ieSfuX2x0lgFw
	 PfE5yp82olYjlT+TKjJRWjdfBV5gs9WVCvEWVLLT5sUA+dFro+a+IBfUq9q3CrLdcYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=JT2cXjgvvOJieViMBkjfTYw/I/u/Ku3gzMCUrx164AM=;
	b=4O2M8A88CLWmhUnzPozuVR1UOsOlhSI8WlWLO8XWVQ6Pe5W3ljzsBv5MC1Lvo0Wdf4hJ
	 M9Eeh3R/EWatDQDRdMAYLS5Dogsd9KdiUXhwg5i+wRYCjM7w6frTNR9Ov1oHLem+eVGNW
	 QrtVMSuYzwTF0WM3wP215xSCyvkwOsVUiDwwpOUJOcqE8uqUkuHQG87gcpXZ1qoXfv9IA
	 sXJYXoB4y0PwITFWJGxqy5aFdZrYZqQ6ko/0s2YNJYRo3OvZLXIDL6AHiv7FUZj2GYGfq
	 +0bQ8h4cMepunXEkohBIz1tM3BJHZ+NKefPGubOB7/vFFPGORS7QpAxVYLtZnI2eA6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLx4mWQ9;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADF606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4ADF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLx4mWQ9
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5363c8de563so29089331cf.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793298809; x=1793903609; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JT2cXjgvvOJieViMBkjfTYw/I/u/Ku3gzMCUrx164AM=;
        b=MLx4mWQ9C1IZco1yFZlQfPuY9zYkKXhJ7kpgM+m6ENIDk6ZM3w8AkaHRyauQs4dcEz
         7Pc9bIeViPNQeLXJGrU2aZDXsK3fWwMLcNBS7cn+fOMA6tMvyw+VP63p9oHzux73O+Id
         ol4IMBsYjTi41XeVAhdsr8chv12WFar10GUMOfnVafzcyI2u1eq9ZMTZi0e/Myan/FaH
         MNDoFGTWzf5ycmY6fXbHbw2OHji8HJe4tOFeXAQkI1y05Vb6LY6rjXhLHz6xa7GTMNhH
         senNZm4nNmp3oa4NauyjPKdY1U02nVU053SYH+1IN8IkjL4WTIMQlPqwv7HCunvGwcGN
         0lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793298809; x=1793903609;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JT2cXjgvvOJieViMBkjfTYw/I/u/Ku3gzMCUrx164AM=;
        b=TMVduFcPfFPZsd60etdS141CwCacOnIQ7fQqCQuJg1kD5CQVuTln35sSX7jpeUyqm3
         n9t+9uLqx6lkUaGf8JpY4lLWnVKyyAhMPoDy3cX+7DNBmmZLVUG6sOyZlmq3sEIXFmI3
         u7ozO0x9B20LktbUweX57YkExpJGPUK42MqYnvXiZN4MZkRZCLIfFk44miFwq7EQnTYw
         fVnrjtlS3jlpeJ/PfrPTm+y2z6penQQUy8HwI9KFxaj8zaFPaX0z4RiVsSo/fgEtOReg
         IKsmDrrNRy2fi/zgFAWgEuFoBM+5T9MPTIS7kGLUT5P+0bKPhHMR4+iwvYSB4PNQA/0A
         7Umw==
X-Gm-Message-State: AFq9FYLVxVd0c5qVtVn6GLHClhilK7JdpZxmbEag8Oi2MEbMBEIrbwXa
	h1hb2iIsMMB4k8LYrx9qNM4DjEXUu5BQ2SS3o1QpM1euHvAkvTo/U0vpGGpgSlFa
X-Gm-Gg: AYBFou0stTqaBeN69BnZ4Zzxq+VesNpM6cWG5AqLsY48VPVH4jub/eT6czlz7yDbGXJ
	ZzbXm0PDOm7TtZLibMRsn6LSRlbaIfaR6KnZktLRxvLlN/rSN1V3JNdpdZkjyb1LBOEpiZDGANt
	6ZQ6jc1pmOKUaI0c12YJzzr5Z0adPZAoVUjSgVi3NE7E/KG7soopS+XLZGbR5+QO6h1uBpMB49m
	9Xjbt6terkSbNNlyN/mELwhhL+aFG8UWpALBs6/HKYUV9VVCSKqNeT4myAghYOqUmE+mCLLYUih
	EjcibB6WnKx6k8jAh3g8zv4m2OxtyhSXx3q16fgq5SfjEVizm8f9XVmFtaXqkmdYZNPHdYhuFdw
	sVIQuxYTo9HRSAYBMSPYwkdNAmLPIBUUxxoADvp2aR70KZ8tw7GCP557SK2NM3NADdwckEW+2Wd
	Xqfnbk5RDfvSzqPRYezjeIRfPdqFoZPgjFm4doFrXRfDTkxiuM3H/U0CrHD4+Wb8WsCEqbiCcMo
	+ZCJBbciJ0mELhNrEAp2ev/k9zhqgjhT5PUMVWDYMMm8AFh4aLeV8dXWgdS/oBPyOoNBuFcBjwv
	9is5Z5BMAvnOWEUNnCW7XEs9vKFf6q60IDI=
X-Received: by 2002:ac8:5a16:0:b0:533:33c6:e635 with SMTP id d75a77b69052e-53fc8db3913mr99118271cf.8.1793298808598;
        Thu, 29 Oct 2026 11:33:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.92.165])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-542a40265a6sm738551cf.4.2026.10.29.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:33:28 -0700 (PDT)
Message-Id: <pull.2470.git.git.1793298807397.gitgitgadget@gmail.com>
From: "Husain Sitamuwala via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 29 Oct 2026 18:33:27 +0000
Subject: [PATCH] check-ref-format: use parse-options API
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Husain Sitamuwala <husainsitamuwala21@gmail.com>,
    Hussain Sitamouwala <husainsitamuwala21@gmail.com>

From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>

Use the parse-options API to handle command-line options
consistently with other Git builtins.

The command currently parses options manually, duplicating
argument-handling logic. Using parse-options makes option
handling consistent with the rest of Git.

Replace manual option parsing while preserving support for
normalization, branch names, and refname validation.

Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
---
    check-ref-format: use parse-options API

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2470%2FCodeWithHusain%2Foutreachy-microproject-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2470/CodeWithHusain/outreachy-microproject-v1
Pull-Request: https://github.com/git/git/pull/2470

 builtin/check-ref-format.c | 45 ++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd1c9c0e0c..58e60eecd2 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -5,13 +5,20 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "parse-options.h"
 #include "refs.h"
 #include "setup.h"
 #include "strbuf.h"
 
 static const char builtin_check_ref_format_usage[] =
-"git check-ref-format [--normalize] [<options>] <refname>\n"
-"   or: git check-ref-format --branch <branchname-shorthand>";
+	"git check-ref-format [--normalize] [<options>] <refname>\n"
+	"   or: git check-ref-format --branch <branchname-shorthand>";
+
+static const char * const builtin_check_ref_format_usages[] = {
+	"git check-ref-format [--normalize] [<options>] <refname>",
+	"   or: git check-ref-format --branch <branchname-shorthand>",
+	NULL
+};
 
 /*
  * Return a copy of refname but with leading slashes removed and runs
@@ -58,13 +65,26 @@ int cmd_check_ref_format(int argc,
 			 const char *prefix,
 			 struct repository *repo UNUSED)
 {
-	int i;
 	int normalize = 0;
 	int flags = 0;
 	const char *refname;
 	char *to_free = NULL;
 	int ret = 1;
 
+	struct option options[] = {
+		OPT_BOOL(0, "normalize", &normalize,
+			 N_("normalize refname")),
+		OPT_BOOL(0, "print", &normalize,
+			 N_("print normalized refname")),
+		OPT_BIT(0, "allow-onelevel", &flags,
+			N_("allow one-level refnames"),
+			REFNAME_ALLOW_ONELEVEL),
+		OPT_BIT(0, "refspec-pattern", &flags,
+			N_("allow refspec patterns"),
+			REFNAME_REFSPEC_PATTERN),
+		OPT_END()
+	};
+
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
 	show_usage_if_asked(argc, argv,
@@ -73,22 +93,13 @@ int cmd_check_ref_format(int argc,
 	if (argc == 3 && !strcmp(argv[1], "--branch"))
 		return check_ref_format_branch(argv[2]);
 
-	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
-		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
-			normalize = 1;
-		else if (!strcmp(argv[i], "--allow-onelevel"))
-			flags |= REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--no-allow-onelevel"))
-			flags &= ~REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--refspec-pattern"))
-			flags |= REFNAME_REFSPEC_PATTERN;
-		else
-			usage(builtin_check_ref_format_usage);
-	}
-	if (! (i == argc - 1))
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_check_ref_format_usages, 0);
+
+	if (argc != 1)
 		usage(builtin_check_ref_format_usage);
 
-	refname = argv[i];
+	refname = argv[0];
 	if (normalize)
 		refname = to_free = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))

base-commit: 37b3475fb530c14109211faca33716a173db61ed
-- 
gitgitgadget
