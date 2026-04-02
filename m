Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65483E2746
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140411; cv=none; b=UnHesWrWbLQk9AaA5XD8MFEZA4gt8tLLP51BGxandDNNHx0JOMiiLw3lGEo07S63ReCV+Qz53RaW84IJPxp0VcKD0AqX6eu1NoiQNdvOTT0iwu+C+5cWeSUoymBHVX9HvZGWRBGMAlxBvsIA3yRf8Yqmu5vr9aWrp4TeNt+ZeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140411; c=relaxed/simple;
	bh=d1HpGepY7OTo4GSnHn/90JC1pUegYXD1q1N7NE52a8I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hmgU9ac7kXrnM18c4GwnASutQwPu2ZjjifMACtlkgTIklgTTTJ+ok0Qd5UlqjPVr9D+OktDh1c/55QYG7h6R1/0vLIHztHJicbWeZZPAbmDlS1KRJRByrG9mCOf84SGzf2E0LccF9euow1Q/xBUOZaSLbF6dLN8UXK+cLCl/5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hdxicbt/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdxicbt/"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd7ecedf2cso103657685a.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140408; x=1775745208; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2pMOkJGbquIsOyduzjPo7YoobacrNK2/UDFyZNLKrg=;
        b=Hdxicbt/prk/jwclBMP3HI7zZBNwLOWGeRxS3/zzbzw8wumVGNHY3b0qlX0/KnzqXA
         saJrPDAqqmhKcvyizv9FDGuMFxTwH59HzsFnyR9zpoupFRKGPRo7qsZA8ytLlbyAUfyQ
         u51cyD3MDXJtlw0jNsMe/hFUaDAdNuAVtLk+qVuCg4F9uh5aXbtjUcIto7F2+AQUc2/G
         +4GIsVHuaqWQVKnuPNeqDtu0IPTrR1Uxs3A22o4FkluOQC3lV9JN48BlnqOmtUFXyYbr
         l7DmfaR2bAYWO2Rn/y9ecasEk8EDqukH4c7+BGRAyOyhpRe43p3gi325ydjGELn+tA30
         Ny4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140408; x=1775745208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2pMOkJGbquIsOyduzjPo7YoobacrNK2/UDFyZNLKrg=;
        b=pHP8C12/10+KTf1yKdg50ltRx1dYoVa0YOAD4aF8smbc3AiXv5LTYqAhuHxMXGp9Ud
         1PopqqB81ipDCe3tG9dSrGuoBu9gGt1miMUptRuaNaBqTJ/OaZWhkhpaGI3Zo7kHBcY7
         XALPNWnH9/XrEufzTwrtODTZwfs/yXG+5/wyfZYcAUhJZpyogFkqVGgwZlx0mdjlJgJM
         lcfb7Y8LQOw3XVg06EU2ufZzDs/mjxcDcblMnzreJGvfFDzRpFT9csM3VyyyTQjbaSE7
         RocxZBNotE9Q712ZjysKLCVadd7/+5yrRyTFRZjZD0ffse3EKYMAbuo4kW5k8PEqyNc3
         WPsQ==
X-Gm-Message-State: AOJu0YzDz2w6NgrvobspJ5TjIVTjLjrACkxBIzTo66B8NsW9XA80au42
	IWHOvsM2GFOUhRP/u11XKB+QUQOh1vfOYPV/6YAIbpwzGo60isXaPoZrU7vQIQ==
X-Gm-Gg: AeBDievmgO8SgdZiSgQcntVvcsVDUaYxqP0SsVBW1zVF/8eOVDhst3Zs/O+srT0Lolv
	guO4k4CS95tX/dGit2dYz5zow4fXNbi1T5/49q66hyDwe10wNATD/uB+7c8lwrZCOYYetCnMx4u
	1yMy9EX+jDRIieFAAg3e8hr6XLidEJwEAE5gm7m7Ifpj6a6C5KS+gT0w/o5p2YrKnWzqUe/vzEm
	Zpo8WI5rrjCopw9fYnaebUz3PLV1QPc5En1E1y2pSV5lM54t+3xSZqMd+kdMDA2a/RjRaBEfk3Y
	PJNtVC0vW/NB3mK1SR3LHhtd25VYpxnl34sxz53hpKZSckCBMBiK1VSVw7tfpZIqSxyeMSM/7im
	Us+HlowBASbTeulonH331YPkAta8qt03VtaaeLkRZgs4lTRgy+wKIoCg/n2ewsFNQRB8HuB96d9
	tOgg8dCq4YxkV4rLUo/kRon2Q6qXk=
X-Received: by 2002:a05:6214:2468:b0:89c:4d0f:d7d1 with SMTP id 6a1803df08f44-8a4394b16eamr124535056d6.33.1775140408483;
        Thu, 02 Apr 2026 07:33:28 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5933333d0sm27623036d6.1.2026.04.02.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:27 -0700 (PDT)
Message-Id: <a4f7a6df516c848936e6952dac8ca02ccb0ac643.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:09 +0000
Subject: [PATCH 03/17] t0003: use `--git-dir` for bare repo attribute tests
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The bare repo tests in t0003-attributes.sh currently `cd` into the bare
repository inside subshells, relying on implicit discovery. Restructure
these tests to pass `--git-dir=bare.git` to the `attr_check` and
`attr_check_source` helpers instead. This makes the code much easier to
read, and also makes bare repo access explicit, i.e. compatible with an
eventual `safe.bareRepository=explicit` default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0003-attributes.sh | 66 ++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 582e207aa1..3a34f5dbc2 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -346,17 +346,14 @@ test_expect_success 'setup bare' '
 
 test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	(
-		cd bare.git &&
-		(
-			echo "f	test=f" &&
-			echo "a/i test=a/i"
-		) >.gitattributes &&
-		attr_check f unspecified &&
-		attr_check a/f unspecified &&
-		attr_check a/c/f unspecified &&
-		attr_check a/i unspecified &&
-		attr_check subdir/a/i unspecified
-	)
+		echo "f	test=f" &&
+		echo "a/i test=a/i"
+	) >bare.git/.gitattributes &&
+	attr_check f unspecified --git-dir=bare.git &&
+	attr_check a/f unspecified --git-dir=bare.git &&
+	attr_check a/c/f unspecified --git-dir=bare.git &&
+	attr_check a/i unspecified --git-dir=bare.git &&
+	attr_check subdir/a/i unspecified --git-dir=bare.git
 '
 
 bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
@@ -449,41 +446,32 @@ test_expect_success 'diff without repository with attr source' '
 '
 
 test_expect_success 'bare repository: with --source' '
-	(
-		cd bare.git &&
-		attr_check_source foo/bar/f f tag-1 &&
-		attr_check_source foo/bar/a/i n tag-1 &&
-		attr_check_source foo/bar/f unspecified tag-2 &&
-		attr_check_source foo/bar/a/i m tag-2 &&
-		attr_check_source foo/bar/g g tag-2 &&
-		attr_check_source foo/bar/g unspecified tag-1
-	)
+	attr_check_source foo/bar/f f tag-1 --git-dir=bare.git &&
+	attr_check_source foo/bar/a/i n tag-1 --git-dir=bare.git &&
+	attr_check_source foo/bar/f unspecified tag-2 --git-dir=bare.git &&
+	attr_check_source foo/bar/a/i m tag-2 --git-dir=bare.git &&
+	attr_check_source foo/bar/g g tag-2 --git-dir=bare.git &&
+	attr_check_source foo/bar/g unspecified tag-1 --git-dir=bare.git
 '
 
 test_expect_success 'bare repository: check that --cached honors index' '
-	(
-		cd bare.git &&
-		GIT_INDEX_FILE=../.git/index \
-		git check-attr --cached --stdin --all <../stdin-all |
-		sort >actual &&
-		test_cmp ../specified-all actual
-	)
+	GIT_INDEX_FILE=.git/index \
+	git --git-dir=bare.git check-attr --cached --stdin --all <stdin-all |
+	sort >actual &&
+	test_cmp specified-all actual
 '
 
 test_expect_success 'bare repository: test info/attributes' '
+	mkdir -p bare.git/info &&
 	(
-		cd bare.git &&
-		mkdir info &&
-		(
-			echo "f	test=f" &&
-			echo "a/i test=a/i"
-		) >info/attributes &&
-		attr_check f f &&
-		attr_check a/f f &&
-		attr_check a/c/f f &&
-		attr_check a/i a/i &&
-		attr_check subdir/a/i unspecified
-	)
+		echo "f	test=f" &&
+		echo "a/i test=a/i"
+	) >bare.git/info/attributes &&
+	attr_check f f --git-dir=bare.git &&
+	attr_check a/f f --git-dir=bare.git &&
+	attr_check a/c/f f --git-dir=bare.git &&
+	attr_check a/i a/i --git-dir=bare.git &&
+	attr_check subdir/a/i unspecified --git-dir=bare.git
 '
 
 test_expect_success 'binary macro expanded by -a' '
-- 
gitgitgadget

