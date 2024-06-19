Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457D14265
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766027; cv=none; b=Deokr+34yv+N2q2DjHTGBkm34OYgTWUNfXXzOUFngl2qRECAeKdSxUVgZP/sdTml70V85175Bt81vCV3yFJ21ep2MoZky94f/6jvu6Emfd2L6U9CprADv7RJpyl3ABIjn2QSawBBNY2AVFfYCG71idqCzrkjD2vxLS3/jbppo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766027; c=relaxed/simple;
	bh=YjclWHVUF13LYDFXYKOF8UjnWqMnijPbrOPwIrPqqis=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f5cCxVQUZUlEYs9mSQMXCZnChEXjxMcNSdb3CM08dSoPw3Fh65UCddjFNTx1mjEXRe20p2XcLFodZ2CIZE8B2pocwc8HSo2nnMNkpe9jjefrH/DRsnB+/nkZxFRVOKZz03LVjNARuZ0qbHtmiAYyZr/fBzeTuVu0+JOzpY5bw2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLlYBxVk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLlYBxVk"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-363826fbcdeso134173f8f.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766024; x=1719370824; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wAiMfckS8jQMvlxxLrZhJdJEE9l28mGLPDlEX35XnQ=;
        b=fLlYBxVk26RoA1DUAX0oWFOOzShEGWbOU/n5q4HOE9IMbqeUkbEZRvI08gcm+EFYsj
         /pW9DvNw15Yj9eb6UNrenL/EXKu06SCv8rKONftV6kMXBVGMz430fKKkPfuEpCzjzQB3
         HvGCH0F/+AR7XLrdxu9EI0BF54c3Zz2+YfCR0kBkl6RwB+MFjpJisRzG4Z0+eZ9Q5gOn
         pf8ZAPkvf+vB5vb2zBInbxshYtz0K4X8c19LbJMUxzzvOdg+HOLH7CODDaS5IRtSn5GA
         qTx1Nym9W6Wl7ScyTZsaEhZJvmAnvKChA7OOl4EPFOQ+loU2l9iftFElG5MfzTSn+9B3
         YqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766024; x=1719370824;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wAiMfckS8jQMvlxxLrZhJdJEE9l28mGLPDlEX35XnQ=;
        b=cQNkJ8KNkcRqrRPDRw6/qWHdfIezoDOCueEtw2P3ATwAPht8hJT9yGUcGZwWQwK9yY
         RN+laG9c8xacMX8bdAUtvmXSYqqGvlJYl/GGhKenvvsYWAjT5LYRiJerSNOXLHgPGD9u
         kFEVEOhfnPbuxyfbwyMLPh8ab51O8TSvVAe4O1XBGtOSS7jiGv4sWcH1IrRxEKzZwLLz
         SY/zx41JRPKLamU2En7xVtp51KU4Ag5w0JaGhZGAvW74ylcoirXbwyL/JY1MhCWDm9O+
         L5vOuUKWuyZ8x0XHbP1BYFXSDXgmwxaYm8KUUfoGp9wRrfhL2HkbdGy/drWZ/+U4FPrI
         8VQA==
X-Gm-Message-State: AOJu0Yw2UZWA93LQKRmjD50/md6tIhUhpZxKS1Lmr5nAE1ijrBt0WK7P
	vBFdcKW+UkxQn2EzV8rW36oBIwdoYYTe0lN4GCV87h4ieUupMK/wML+S3g==
X-Google-Smtp-Source: AGHT+IFGBNNWsfLkPIcwDCWbjwlO+/ZoGjIeab6LTsFW3DTGpC7ZApI/8NTz0Tz10GJ1QFOsS6speg==
X-Received: by 2002:a5d:4b46:0:b0:360:8683:c072 with SMTP id ffacd0b85a97d-363192cde9emr731870f8f.50.1718766023911;
        Tue, 18 Jun 2024 20:00:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127c1esm209783085e9.23.2024.06.18.20.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:00:23 -0700 (PDT)
Message-Id: <d1adec6d10556e247c21f94420879724fa2c6436.1718766019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 03:00:14 +0000
Subject: [PATCH v2 2/7] merge-ort: maintain expected invariant for priv member
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The calling convention for the merge machinery is
   One call to          init_merge_options()
   One or more calls to merge_incore_[non]recursive()
   One call to          merge_finalize()
      (possibly indirectly via merge_switch_to_result())
Both merge_switch_to_result() and merge_finalize() expect
   opt->priv == NULL && result->priv != NULL
which is supposed to be set up by our move_opt_priv_to_result_priv()
function.  However, two codepaths dealing with error cases did not
execute this necessary logic, which could result in assertion failures
(or, if assertions were compiled out, could result in segfaults).  Fix
the oversight and add a test that would have caught one of these
problems.

While at it, also tighten an existing test for a non-recursive merge
to verify that it fails with appropriate status.  Most merge tests in
the testsuite check either for success or conflicts; those testing for
neither are rare and it is good to ensure they support the invariant
assumed by builtin/merge.c in this comment:
    /*
     * The backend exits with 1 when conflicts are
     * left to be resolved, with 2 when it does not
     * handle the given merge at all.
     */
So, explicitly check for the exit status of 2 in these cases.

Reported-by: Matt Cree <matt.cree@gearset.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c           |  3 ++-
 t/t6406-merge-attr.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 700ddfccb90..dc62aaf6d11 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5050,6 +5050,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 		    oid_to_hex(&side1->object.oid),
 		    oid_to_hex(&side2->object.oid));
 		result->clean = -1;
+		move_opt_priv_to_result_priv(opt, result);
 		return;
 	}
 	trace2_region_leave("merge", "collect_merge_info", opt->repo);
@@ -5080,7 +5081,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 		/* existence of conflicted entries implies unclean */
 		result->clean &= strmap_empty(&opt->priv->conflicted);
 	}
-	if (!opt->priv->call_depth)
+	if (!opt->priv->call_depth || result->clean < 0)
 		move_opt_priv_to_result_priv(opt, result);
 }
 
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 156a1efacfe..b6db5c2cc36 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -185,7 +185,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
 
 	>./please-abort &&
 	echo "* merge=custom" >.gitattributes &&
-	test_must_fail git merge main 2>err &&
+	test_expect_code 2 git merge main 2>err &&
 	grep "^error: failed to execute internal merge" err &&
 	git ls-files -u >output &&
 	git diff --name-only HEAD >>output &&
@@ -261,4 +261,44 @@ test_expect_success 'binary files with union attribute' '
 	grep -i "warning.*cannot merge.*HEAD vs. bin-main" output
 '
 
+test_expect_success !WINDOWS 'custom merge driver that is killed with a signal on recursive merge' '
+	test_when_finished "rm -f output please-abort" &&
+	test_when_finished "git checkout side" &&
+
+	git reset --hard anchor &&
+
+	git checkout -b base-a main^ &&
+	echo base-a >text &&
+	git commit -m base-a text &&
+
+	git checkout -b base-b main^ &&
+	echo base-b >text &&
+	git commit -m base-b text &&
+
+	git checkout -b recursive-a base-a &&
+	test_must_fail git merge base-b &&
+	echo recursive-a >text &&
+	git add text &&
+	git commit -m recursive-a &&
+
+	git checkout -b recursive-b base-b &&
+	test_must_fail git merge base-a &&
+	echo recursive-b >text &&
+	git add text &&
+	git commit -m recursive-b &&
+
+	git config --replace-all \
+	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
+	git config --replace-all \
+	merge.custom.name "custom merge driver for testing" &&
+
+	>./please-abort &&
+	echo "* merge=custom" >.gitattributes &&
+	test_expect_code 2 git merge recursive-a 2>err &&
+	grep "^error: failed to execute internal merge" err &&
+	git ls-files -u >output &&
+	git diff --name-only HEAD >>output &&
+	test_must_be_empty output
+'
+
 test_done
-- 
gitgitgadget

