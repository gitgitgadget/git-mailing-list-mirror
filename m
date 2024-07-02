Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A481C9EB1
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947279; cv=none; b=Rzz30h4HZjIocYehxe0kQVH4NbZhGCt1RAknZtHtEMJ2N67SgvgfTsRO8NM4x2bMkrY2tNAQVI4yfD475pTnlNShEnnKL/vzK1XnhWBPaYtG2jv86wSZLGjtybpXG45h1tarsvwsJ7ommIM3FNk0Edtyn5yyCf1R+Vx2ADfDKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947279; c=relaxed/simple;
	bh=w3eeKQnUxHtohCqmqjZyYq1WXJjqdQyY5NsPWuBZ5vY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HiNALRY+X/QFoNbNB3MeGhJ92BpKQ3KjIm2Xx0whx0eJzLxPZ0D4i624EYmCClscq5kavWMVRdMb5TLjs/LV/C4Ju2SkV6V6xUaiRgvA1lasO7UgZaqIK1xYfUQR4UK//EjBJyebxB6k+lggPdp/HHo6W2veF+wDOQaFPQ/ZlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9PwU2gm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9PwU2gm"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52db11b1d31so6379874e87.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719947276; x=1720552076; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxeMZDpDKO+CCinf2JC5NAnqcaCSOnczVeTFe7e4RPA=;
        b=U9PwU2gmVJVgt9d6NOhAeUAgyum6xPRY4oDJo0AmLGtLmHrn2LjwDpsPSfm2y5/Mle
         KLcJoFpOapDeOsY4h10zA3Jq28VgiLdRVtFA5KX6eP8aFKbjmiLBf9GI6gD4ERHCMimv
         b5nMxwrKld/prHFKuC9pPrM8RF2YVfNeOXVTizPSghU6VvgVLQBTnwCfcamyvhNElefk
         ukB6ZWdP57bWRzTfstk9cpahe6pL5CsDKLJQGslNGFgT0uxoDe5DyH9M44QpYDEmgO4+
         6Ed8u4D5oQrP7vpaCNsA+dLwj6ye+a63dixSjfexPEEw/chgmp7VjRF7v8vRRXLl80XW
         F4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719947276; x=1720552076;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxeMZDpDKO+CCinf2JC5NAnqcaCSOnczVeTFe7e4RPA=;
        b=Ydp13jA3nPB5A0wRC7Km6kS3XNptpngxH4Jn+/rfPMw699LlaaAMzI/beGSutBfWdk
         2JGSQhWi87fcUw6HrXBrAyA6u589QM8XTdc6FG5Os+IWLDFPxjeq1ldALOcZyN5L2TkR
         SQ5ig497tcY8e2J+FTBDEbDU6sG9u2LfAxLVtv94GFvi0R4Rva0N+7iRVhv1sGosC6df
         85goYfErKzXqxGoj0O3j8/reVtFmGoklX8THQDYNULghJ0np456oxYaTYT6spR2w8v2/
         APCLPnABGQ8I+EHuw3mmf7yHD6g507vIM8AwXj3UyioGQn1YevE//T8j484dUodRzITk
         9fhQ==
X-Gm-Message-State: AOJu0YxoPLDoSd1futCobyyUnGAP4PyK/YETHor40tW9TCpfFO4naIoe
	Y01dCq8rawDdRISfuHgzcnqaTh8LuWEUd6INwvYUaJyzlJrsxMlq2yX4BA==
X-Google-Smtp-Source: AGHT+IF0NlJEC3c1RSTfWHXJG/TxvFYoJcE04Z6kQsGU+ouhruf4rivHecbR2Hbr3decqX1DmZ/lxA==
X-Received: by 2002:a05:6512:e97:b0:52c:cd7d:4e7d with SMTP id 2adb3069b0e04-52e8264bcc0mr5545330e87.5.1719947273865;
        Tue, 02 Jul 2024 12:07:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257d0d38bbsm125855575e9.38.2024.07.02.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:07:53 -0700 (PDT)
Message-Id: <1679ab7b7a0db40733ad60ada8b226657782d33e.1719947271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com>
References: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com>
From: "Bruce Perry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jul 2024 19:07:50 +0000
Subject: [PATCH 2/2] clone: no-shallow-submodules clone overrides option in
 gitmodules
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
Cc: Stefan Beller <stefanbeller@gmail.com>,
    Emily Shaffer <emilyshaffer@google.com>,
    Bruce Perry <bruce.a.perry@gmail.com>,
    Bruce Perry <bruce.perry@nrel.gov>

From: Bruce Perry <bruce.perry@nrel.gov>

When the `--no-shallow-submodules` option is used for cloning, pass
the `--no-recommend-shallow` option to the internal submodule update
command, which will override an option for shallow in .gitmodules
if present. This allows the user to force a non-shallow clone of
the submodules if desired. It brings the behavior in line with
the present documentation, which states the option in gitmodules is
used unless explitcitly overridden by the user. Add a test to confirm
that the override is done when using the clone command (similar to
a current test that validates similar behavior for the submodule
update command).

Signed-off-by: Bruce Perry <bruce.perry@nrel.gov>
---
 builtin/clone.c                     |  4 +++-
 t/t5614-clone-submodules-shallow.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50ccce8902d..63cfb48484c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -61,7 +61,7 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_single_branch_submodules;
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
-static int option_shallow_submodules;
+static int option_shallow_submodules = -1;
 static int option_reject_shallow = -1;    /* unspecified */
 static int config_reject_shallow = -1;    /* unspecified */
 static int deepen;
@@ -798,6 +798,8 @@ static int checkout(int submodule_progress, int filter_submodules)
 
 		if (option_shallow_submodules == 1)
 			strvec_push(&cmd.args, "--depth=1");
+		else if (option_shallow_submodules == 0)
+			strvec_push(&cmd.args, "--no-recommend-shallow");
 
 		if (max_jobs != -1)
 			strvec_pushf(&cmd.args, "--jobs=%d", max_jobs);
diff --git a/t/t5614-clone-submodules-shallow.sh b/t/t5614-clone-submodules-shallow.sh
index b23c7d085aa..8e2965248a2 100755
--- a/t/t5614-clone-submodules-shallow.sh
+++ b/t/t5614-clone-submodules-shallow.sh
@@ -102,6 +102,22 @@ test_expect_success 'clone follows shallow recommendation' '
 	)
 '
 
+test_expect_success 'no-shallow-submodules clone option overrides gitmodules' '
+	test_when_finished "rm -rf super_clone" &&
+	test_config_global protocol.file.allow always &&
+	git clone --recurse-submodules --no-shallow-submodules --no-local "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 4 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline --all >lines &&
+		test_line_count = 5 lines
+	)
+'
+
 test_expect_success 'get unshallow recommended shallow submodule' '
 	test_when_finished "rm -rf super_clone" &&
 	test_config_global protocol.file.allow always &&
-- 
gitgitgadget
