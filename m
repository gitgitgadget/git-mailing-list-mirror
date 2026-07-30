Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E6395AF0
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392363; cv=none; b=WBJSXD+fa0fCZHfVrXxC1iTH9c5CSpgG0JznL83dDRM5yQ2NvTbXal04thi03w9rNOiW6PHbh/75gYIUxn9FN9LWtqrvIYQNPIpMsTBE5QaB1/U6sp6KnHFzfb9/D0zwHyYZxg5ecHTljgo9Czvz4y8/wvyF/D2XPweAtXP2ZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392363; c=relaxed/simple;
	bh=Rqb1uj4EstfGSz7A0DY0D3czXvdW4GJJbY8HymzknAw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AmGzNLi0S3Ro7AzCFuT0fGD7gVHjF6X3Vsylo9Qxw1Wvf24mVKY8ZD027XP/I9FwAm3btOWsUqIMQHP6bnKtbq3vSlTbXqFR4PC01eDsYmRgngx9ntq2hPk42RGkXTTXFn3PUuZ2EY3GQK48+S0cIcYQBTiqunhnOvUGwyJwHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv9mrcyR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv9mrcyR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1403325a91.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785392352; x=1785997152; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZJhWirFYCf2tQfNLN/JFvoTf8m8a4nU69PkgNTEEfq8=;
        b=jv9mrcyRAGtBcnFjVJ4yTLXMoH7plZerVeE3J4uKwJBbLhs1D5Y9OZMds6LQwZNzWg
         ujxk/Wti6ZyFfYE7hvbBs8lzBEPe1NgBG6fYO6IgxmUIjRpKZuJMNX8YgFzpHJtRv1U6
         PeytbNd6WwCCAuhwpppoI4aiov/ILhwdZBRvjS84ro4hZCfQM2Dv20o3SzvDOolIrkPh
         6ibrJ0YXhK7lv6nHAC3UL3H4GbtpF4Bj9PKz66YHPO0oRObQ6WNzjSi+hD++4BrZvrY1
         3sU329xYyiRbY2zA/bpBmwyGx7m/BIuEr140CX5aMA4l/V7AbTZYMbPrqA4pzh6OermT
         c0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785392352; x=1785997152;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZJhWirFYCf2tQfNLN/JFvoTf8m8a4nU69PkgNTEEfq8=;
        b=MoxB/Hhb3wOshi/p/qj6YOXpNfxbVPUXGpIwmjYdKk67aTfM9a2gmqHvjoYyCfheAh
         DgXXf2V/bXlBLnt22wHLE5QklCax8yh6gxMv6EF8hHV+QakURgrmkkjWBxp6M/vNAVbh
         z9X9mcmqXNwK1T/BVuXyVmcBdZg1VG2skeem328hlA6yLZ0ZKrH5XPCivDYXGsXdZR3p
         AQM2GfMO2qRr1/c3p4qO9SWKBBmjIq2LrLm+W6F8fW3CyE8IR8lBeDpO52cag2wBMYSq
         QUZjefJiWejaENioTKrKXc5iO8qI8gceUAhYgv2PPj1uDYS551HWBecxrbtAVvMOttyE
         IZ9g==
X-Gm-Message-State: AOJu0Ywf9/+AWeGmH8gLsjAxWzG6xrGEmv3fd7nMwdnvOFnuPWQvgl8N
	WqeFBDOsPerjPl85XQWoxsQTlJZodRgUf5cjLF1Fau+w2qDp3th1n3nYJsy5QA==
X-Gm-Gg: AR+sD10PvKiXLIc6tpSwt/Mqw4s3HxPxrT29YQz9TBEK4WMEr5i1rGGLSqsQbJoCFY6
	2QCyG3bTdkXcFPQkgkzeCjFyPwuQUkPInvV8qHqwHK55efEqees6dh2NGd1YhnrDnBouDheRnYg
	jUjk5hgDLqv33gMQ09G5xoH4t8tTkJZ1t9ID9mSzypdi9giwkfO8SeCLj+ieMZVnJYOFUCALYJc
	TvvVho7mhQnCPHS5tFhsK+tpIlE0O5oDaL8Jf4f5gotTe6kiS8EedcmhmfC28nkDAryJNj7ZBom
	f0IlF4+ZBsdPN1FWTUeCEici9Yezmycb/viFTt+3IyOdnxQEXfM8p9bo8ntJAMdgyxdrxkoztj4
	wnwnjxIV8lYk7QCZ9+96eg8v30cFYqHEUElpw88XvCMqm2Lb2Umc7JjLyq6BHKVnpl0guF688t2
	mYvof7yCvhFHyoP0zuuZx8d6CK6RA7aWA6icerxNq22+nCEDICcYO5Trw0g0D6x16+
X-Received: by 2002:a17:90b:3e87:b0:38f:1e1a:5164 with SMTP id 98e67ed59e1d1-38f9c0c8bc3mr1206800a91.37.1785392352232;
        Wed, 29 Jul 2026 23:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9babfcb1sm473211a91.16.2026.07.29.23.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:19:11 -0700 (PDT)
Message-Id: <pull.2186.v2.git.1785392350660.gitgitgadget@gmail.com>
In-Reply-To: <pull.2186.git.1784998828879.gitgitgadget@gmail.com>
References: <pull.2186.git.1784998828879.gitgitgadget@gmail.com>
From: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 06:19:09 +0000
Subject: [PATCH v2] merge-base: add tests for --is-ancestor
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>

From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>

`git merge-base --is-ancestor A B` is used a lot in scripts but has no
tests. Add some to t6010 covering its exit codes: 0 when A is an
ancestor of B, 1 when it is not, and 128 (not 1) when given a bad
argument. Also check that --is-ancestor and --all can't be combined,
and that the resulting error names both options.

Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
---
    merge-base: add tests for --is-ancestor
    
    Changes since v1, per review:
    
     * Reuse the E---D---C---B---A history and the G/H merges from the "set
       up G and H" test instead of creating a separate repository.
     * Add a test that --is-ancestor requires exactly two commits: too few
       is a usage error (exit 129), while more than two is rejected with
       "--is-ancestor takes exactly two commits" (exit 128).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2186%2Fnikolauspschuetz%2Ft6010-test-is-ancestor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2186/nikolauspschuetz/t6010-test-is-ancestor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2186

Range-diff vs v1:

 1:  e512e35788 ! 1:  319bf89d25 merge-base: add tests for --is-ancestor
     @@ t/t6010-merge-base.sh: test_expect_success 'merge-base --octopus --all for compl
       	test_cmp expected actual
       '
       
     -+test_expect_success 'setup --is-ancestor' '
     -+	git init is-ancestor &&
     -+	(
     -+		cd is-ancestor &&
     -+		test_commit one &&
     -+		test_commit two &&
     -+		git checkout -b side one &&
     -+		test_commit three
     -+	)
     ++test_expect_success '--is-ancestor with an ancestor and a descendant' '
     ++	git merge-base --is-ancestor $E $A &&
     ++	test_expect_code 1 git merge-base --is-ancestor $A $E
      +'
      +
     -+test_expect_success '--is-ancestor parent and child' '
     -+	git -C is-ancestor merge-base --is-ancestor one two &&
     -+	test_expect_code 1 git -C is-ancestor merge-base --is-ancestor two one
     ++test_expect_success '--is-ancestor treats a commit as its own ancestor' '
     ++	git merge-base --is-ancestor $A $A
      +'
      +
     -+test_expect_success '--is-ancestor self' '
     -+	git -C is-ancestor merge-base --is-ancestor two two
     ++test_expect_success '--is-ancestor with diverged commits' '
     ++	test_expect_code 1 git merge-base --is-ancestor $G $H &&
     ++	test_expect_code 1 git merge-base --is-ancestor $H $G
      +'
      +
     -+test_expect_success '--is-ancestor diverged commits' '
     -+	test_expect_code 1 git -C is-ancestor merge-base --is-ancestor three two
     ++test_expect_success '--is-ancestor exits 128 on a bad commit' '
     ++	test_expect_code 128 git merge-base --is-ancestor $A no-such-commit &&
     ++	test_expect_code 128 git merge-base --is-ancestor no-such-commit $A
      +'
      +
     -+test_expect_success '--is-ancestor exit 128 non-existent commit' '
     -+	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor one no-such-commit &&
     -+	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor no-such-commit one
     ++test_expect_success '--is-ancestor requires exactly two commits' '
     ++	test_expect_code 129 git merge-base --is-ancestor &&
     ++	test_expect_code 129 git merge-base --is-ancestor $A &&
     ++	test_expect_code 128 git merge-base --is-ancestor $E $A $B 2>err &&
     ++	test_grep ".--is-ancestor takes exactly two commits" err
      +'
      +
      +test_expect_success '--is-ancestor and --all cannot be used together' '
     -+	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor --all one two 2>err &&
     ++	test_expect_code 128 git merge-base --is-ancestor --all $E $A 2>err &&
      +	test_grep "options .--is-ancestor. and .--all. cannot be used together" err
      +'
      +


 t/t6010-merge-base.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 44c726ea39..21f09a678f 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -305,4 +305,35 @@ test_expect_success 'merge-base --octopus --all for complex tree' '
 	test_cmp expected actual
 '
 
+test_expect_success '--is-ancestor with an ancestor and a descendant' '
+	git merge-base --is-ancestor $E $A &&
+	test_expect_code 1 git merge-base --is-ancestor $A $E
+'
+
+test_expect_success '--is-ancestor treats a commit as its own ancestor' '
+	git merge-base --is-ancestor $A $A
+'
+
+test_expect_success '--is-ancestor with diverged commits' '
+	test_expect_code 1 git merge-base --is-ancestor $G $H &&
+	test_expect_code 1 git merge-base --is-ancestor $H $G
+'
+
+test_expect_success '--is-ancestor exits 128 on a bad commit' '
+	test_expect_code 128 git merge-base --is-ancestor $A no-such-commit &&
+	test_expect_code 128 git merge-base --is-ancestor no-such-commit $A
+'
+
+test_expect_success '--is-ancestor requires exactly two commits' '
+	test_expect_code 129 git merge-base --is-ancestor &&
+	test_expect_code 129 git merge-base --is-ancestor $A &&
+	test_expect_code 128 git merge-base --is-ancestor $E $A $B 2>err &&
+	test_grep ".--is-ancestor takes exactly two commits" err
+'
+
+test_expect_success '--is-ancestor and --all cannot be used together' '
+	test_expect_code 128 git merge-base --is-ancestor --all $E $A 2>err &&
+	test_grep "options .--is-ancestor. and .--all. cannot be used together" err
+'
+
 test_done

base-commit: f60db8d575adb79761d363e026fb49bddf330c73
-- 
gitgitgadget
