Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896CA21E098
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764534928; cv=none; b=MJEy/gq73L+QiFp79YGYtRvtt+mEGJsFK7pq6OGm10aHJq8Ba4wQ06cdrvW3B05xlMZHthrvQ/aXSaQ+ZEA2gUMmzooMZwr5nZKOidM7KntGzke8bGV5MBZSg6XDhil3MiTqwdP+QPUKZbnrjLqew4FsH16uEnEcMdb5z8ShEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764534928; c=relaxed/simple;
	bh=UedOLogCRW5Yifj38FcePi2PTQLa4zSTSeYPR9+naDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZg7Y6lmduYtrRlInLxQao/PE0UY/pkJqmzugVONlCtAJtSYCRqL+CAhuYkY7XNMvKwqQf0yNIKF2XJhaiNtd7qnZIpscROg9IMyDJYqGs9mJLL2Cxeapa8PE3aye2d98Tr3DpxcsJ+PFTY84/lllF072rLlJ7ap4C4u+G54AwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neiGLcxU; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neiGLcxU"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11beb0a7bd6so4656828c88.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 12:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764534925; x=1765139725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1TIOpZqEQ5n4MTbsskhs//s70nxJ0/Z+RtNc0cqMCA=;
        b=neiGLcxUafExY/i/fTMldG1wKe24UcY533ysuIB8AvGf0wEPHBvtTs7tUxV+5x8HA8
         om/x8jyXUkMxrFtlWho+oUBY1I/UCBCXQHUSMIvd6qsOv2GDXvnut3ECgw1qBLY3Wjjv
         2LtDRtNqbeFcQMgQK+lr4xEaLIxAf4KGZReKGmPce2DLFcCDIb2QRuzA1+K57ukrbImT
         9diUQOpXVaBdYEOSflVAX+wiDWQ+MB3X1+JxrDDSdElbuuAXqG7Xitk/wfMlP289qOVz
         zo9DUCr1KZzQumjIeoY/aQXirghoQOv+aLnIK6RIrFeAAMBs+zXUTGbA+shySc3/0252
         TS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764534925; x=1765139725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1TIOpZqEQ5n4MTbsskhs//s70nxJ0/Z+RtNc0cqMCA=;
        b=s2O0clhNKfdcPAyThZnHQ79/HeZzfQmvNRXm8N3E36qsx332jNLy+1B9gdWFOJQrFN
         u2ZLm6qprpbsOxzCQehA5K8tkiaFqql9/wnkhZ18hZQSBWFByFgiU81LEiLuAo8qWazr
         hIlu6651dlhEqr7ivKMkkbIEsSKLT0V0rjc8WrEPc+S3DOdPcUV+h9vYNozmqy1PwwmP
         hlZaUPFrkmd6PMoGqQjtyCiS0JJStzDpVQ2f4Kuv7FbBNVMUpUEpP0GFjr7dajQ9nYPg
         7/b0Kw3hHK8PG3/BILDTnA9n7lCGrVKj995gyYrQuPehaTdypsD6zr+s6KsxM8QlDGUI
         ALRA==
X-Gm-Message-State: AOJu0YzwPDps1cMZ4V1D50mOyt2Vj+SIQx7dJ2CH3wzFkyITyVFm+EEc
	wewD1hhGCP8L9tb0UWU4R3NLKOtpylEiHVIr20xlQwSLbbqI47w7SUY48qEwVw==
X-Gm-Gg: ASbGncuvkXm0I2QtIOHU96KDnzKXch9SOkSsdXZmCtrMlkQgZEJGK+dinDzcr/XqRqU
	Itf/pivnmnsuxNDUmGVUPBIHCTQloC/8LNE5deJBY+INTqrBRpvS4gzNNHTRUOwMLuX97XjKk+p
	OrOpqLmsB/Eh/qlkyc8d74GbsjT2Tz6760juabR3IGlVEjKB57SyJZyLKUwEANGR2cSJsUqmIk8
	t30oDqmUMGIwJ9zpvyygFU9DXpBJ+YbntgQQKvvv+1GMJUcbKTXudI6fuyhgqTgNEUtAW91P69Y
	FAjmNbmg1gGGRX1oRi3eFZbyLtd2INo5gVwYsg7ZZndODsmUdF4ce9XUIiV3c2YMHp05ZaixQ17
	6AadSpmoh/V8jSVxivpJkIgruwD7+nmmFMPWtXgKcquIyNnx1Fn+ifp1DCuQGE1/lYLLfUC3Uq7
	FoXpCjd/LU5frH704dpJUBOrGkVtABhRFup6wQFRwGZwvd91eyQz0akCrv
X-Google-Smtp-Source: AGHT+IFa9INYbcDbyU2NwWmq44Q67ZJR7lACYM29eMqeNRWPtu45Af7YRme0NPQQzd0rnBZuShQ9Zw==
X-Received: by 2002:a05:7022:69a9:b0:11b:c86b:3870 with SMTP id a92af1059eb24-11c9c935fb3mr13285047c88.4.1764534925151;
        Sun, 30 Nov 2025 12:35:25 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:1b6b:4432:519f:79c9:825])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5fcasm58684155c88.2.2025.11.30.12.35.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Nov 2025 12:35:24 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH] repo: add -z as an alias for --format=nul to git-repo-structure
Date: Sun, 30 Nov 2025 16:59:55 -0300
Message-ID: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other Git commands that have nul-terminated output, such as git-config,
git-status, git-ls-files, and git-repo-info have a flag `-z` for using
the null character as the record separator.

Add the `-z` flag to git-repo-structure as an alias for `--format=nul`,
making it consistent with the behavior of the other commands.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

Hello, again!

Since git-repo-info and git-repo-structure share the same format parser, this
could be done by only copying the OPT_CALLBACK_F from repo_info.

I'm cc'ing Justin here, as he was the author of git-repo-structure.

This patch is based on top of master b31ab939fe (The fourth batch, 2025-11-26)
with lo/repo-info-all merged.

 Documentation/git-repo.adoc | 5 +++--
 builtin/repo.c              | 6 +++++-
 t/t1901-repo-structure.sh   | 6 ++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 70f0a6d2e4..8820954f7e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
-git repo structure [--format=(table|keyvalue|nul)]
+git repo structure [--format=(table|keyvalue|nul)] [-z]
 
 DESCRIPTION
 -----------
@@ -44,7 +44,7 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-`structure [--format=(table|keyvalue|nul)]`::
+`structure [--format=(table|keyvalue|nul)] [-z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -72,6 +72,7 @@ supported:
 	the delimiter between the key and value instead of '='. Unlike the
 	`keyvalue` format, values containing "unusual" characters are never
 	quoted.
+`-z` is an alias for `--format=nul`.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index 2a653bd3ea..1c06207a39 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -16,7 +16,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
-	"git repo structure [--format=(table|keyvalue|nul)]",
+	"git repo structure [--format=(table|keyvalue|nul)] [-z]",
 	NULL
 };
 
@@ -529,6 +529,10 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
 			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_CALLBACK_F('z', NULL, &format, NULL,
+			       N_("synonym for --format=nul"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       parse_format_cb),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_END()
 	};
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 36a71a144e..5a50acf345 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -101,6 +101,12 @@ test_expect_success 'keyvalue and nul format' '
 		tr "\n=" "\0\n" <expect >expect_nul &&
 		git repo structure --format=nul >out 2>err &&
 
+		test_cmp expect_nul out &&
+		test_line_count = 0 err &&
+
+		# Check -z
+		git repo structure --format=nul >out 2>err &&
+
 		test_cmp expect_nul out &&
 		test_line_count = 0 err
 	)
-- 
2.50.1 (Apple Git-155)

