Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FB18FDCD
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386052; cv=none; b=V/lLw6ddCTzQ4q4qq0gw7AUb6JGNOg8Q1/HwzLEfuCfPe2wlX9EwIRmAwsyNmRb3uTRoDsxQFALW+tc9kHGbbwceF3KKSCLFV7HH0diHZZrAbavHZLjpWiIfsdpCK54L+PDYyukD2D4b5nHe6JoASdKF/Ds8ftEyOQn1pXL7uIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386052; c=relaxed/simple;
	bh=sKQy44pXHETObVbz89Z90/ZeU3cjIUJqakFc5R7Xadk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UcoiHONkhGkevQr8sqBHWBttOEYx9rEURsckbQxofPZIM47AHH2PxrcHA53wVgI60geya++0cXC/ahEGxRt/A+6orUc/rmrVflm8A5xvdshcp8Dqta137sI3hSq7LxgrjqU0n8sVIhOVCHdEaYpparGtZWAYM2oGqA/3a8IA7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DunsOhIv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DunsOhIv"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8696e9bd24so664479666b.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386048; x=1725990848; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0o5uiUSXnKY0Ql+yTadctJhr2MQZdTo+sASYu/abx0=;
        b=DunsOhIvx+ih62umWL083koNqBSaydR3KyszFFHJ2JzMMsoW1Y7P07kgjG6TAhPtxJ
         WXTw6JHSEiIVe3YL12G10TrgS+lJ+UwlUkDb+tqELQnKPcjZVi8vDTejRteP/NXYB/Cd
         UhmGVxeEAmJL5gAG5j+9k1aB3EoYekUtkj1SZCE7q+186KPXSqU701wGNdqvYgvmyrjM
         a9D+b0CE0Mr89f5RiOoIxQ8utlSh0Tk7X9eGaODuibfNpyp5HMOo3qODbpHfHfigdgJf
         TRaTNjACnzY2cHzFnxpJ8ba4l8c8etNEnirG2KBykaDR20JTskVnpyPszwTglfR8gbAs
         UsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386048; x=1725990848;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0o5uiUSXnKY0Ql+yTadctJhr2MQZdTo+sASYu/abx0=;
        b=qrpRe/waCG6gU9KcH4hwvUQH5fiTl2UCiX/exeDv8NA/r3lHl3PN69+XD8jRMwNsyJ
         u+PWhijtzmXUtr6f3fUWLEs2337ZDY8co8Fb7StOdxGuKi3AILwHiVoVzUOFWXoeQdYW
         HLmoan2h+TkMlsnJZ5sGpKd0WErUjWTxJFgehGWfEOR2PlqGxUtLDgfY4fmC+jwY1P8U
         48zQiAaeq86pcO9dSyBNSnfoiZ7eywgfW6iCze4LmqVDbzjjyUEXOdMjpTo9cKuDQk9X
         qAVnvehknsZ+IqIM6ZubrukyV9R54WrTaA1YVAL3UNkZO46URihJo+VMrM8MDvd26cGJ
         GdxA==
X-Gm-Message-State: AOJu0YzcsR3RsDSNFTePdaCTI6KeLekz6XXU0Yyp/PQrZUL/ZgjOJVgZ
	VBkwd6Lvvm4UwSf0gQpaVaJeDVonuiBrJg4Jp1A59OWXehmxizeMgAbuvg==
X-Google-Smtp-Source: AGHT+IFEt3oQwBG6DJPmcr6Q5INrZjaQl2iPTnkhu4AWwCoiBUwKANBceJ0MndGGM5SkEIm2Mb4Jyw==
X-Received: by 2002:a17:906:f589:b0:a86:8f2c:5cfa with SMTP id a640c23a62f3a-a897f789236mr1331596066b.14.1725386047923;
        Tue, 03 Sep 2024 10:54:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6d88sm711090466b.151.2024.09.03.10.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:54:07 -0700 (PDT)
Message-Id: <f4d1461b99350151970528e12a92290cb65f7860.1725386044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
References: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
	<pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Sep 2024 17:54:04 +0000
Subject: [PATCH v3 2/2] Mark 'git cat-file' sparse-index compatible
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Kevin Lyles <klyles+github@epic.com>,
    Kevin Lyles <klyles+github@epic.com>

From: Kevin Lyles <klyles+github@epic.com>

This change affects how 'git cat-file' works with the index when
specifying an object with the ":<path>" syntax (which will give file
contents from the index).

'git cat-file' will expand a sparse index to a full index when needed,
but is currently marked as needing a full index (or rather, not marked
as not needing a full index). This results in much slower 'git cat-file'
operations when working within the sparse index, since we expand the
index whether it's needed or not.

Mark 'git cat-file' as not needing a full index, so that you only pay
the cost of expanding the sparse index to a full index when you request
a file outside of the sparse index.

Add tests to ensure both that:
- 'git cat-file' returns the correct file contents whether or not the
  file is in the sparse index
- 'git cat-file' expands to the full index any time you request
  something outside of the sparse index

Signed-off-by: Kevin Lyles <klyles+github@epic.com>
---
 builtin/cat-file.c                       |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 36 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 18fe58d6b8b..1afdfb5cbae 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1047,6 +1047,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	/* Return early if we're in batch mode? */
 	if (batch.enabled) {
 		if (opt_cw)
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 87953abf872..fbc10c8042b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2358,4 +2358,40 @@ test_expect_success 'advice.sparseIndexExpanded' '
 	grep "The sparse index is expanding to a full index" err
 '
 
+test_expect_success 'cat-file -p' '
+	init_repos &&
+	echo "new content" >>full-checkout/deep/a &&
+	echo "new content" >>sparse-checkout/deep/a &&
+	echo "new content" >>sparse-index/deep/a &&
+	run_on_all git add deep/a &&
+
+	test_all_match git cat-file -p :deep/a &&
+	ensure_not_expanded cat-file -p :deep/a &&
+	test_all_match git cat-file -p :folder1/a &&
+	ensure_expanded cat-file -p :folder1/a
+'
+
+test_expect_success 'cat-file --batch' '
+	init_repos &&
+	echo "new content" >>full-checkout/deep/a &&
+	echo "new content" >>sparse-checkout/deep/a &&
+	echo "new content" >>sparse-index/deep/a &&
+	run_on_all git add deep/a &&
+
+	echo ":deep/a" >in &&
+	test_all_match git cat-file --batch <in &&
+	ensure_not_expanded cat-file --batch <in &&
+
+	echo ":folder1/a" >in &&
+	test_all_match git cat-file --batch <in &&
+	ensure_expanded cat-file --batch <in &&
+
+	cat >in <<-\EOF &&
+	:deep/a
+	:folder1/a
+	EOF
+	test_all_match git cat-file --batch <in &&
+	ensure_expanded cat-file --batch <in
+'
+
 test_done
-- 
gitgitgadget
