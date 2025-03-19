Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319B22094
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364243; cv=none; b=Jlgl6WWu13hm11GhSa6K6XXHD8rTvvvhDalcQCQ9+feIR1n/IwzKAKMMmeJcQarkSr/Fyn6fJtkHrL7MxQ0zEHThJQphSaE7tYAjEm9EE+VQoXaG+UP6Yg+fiFXMjEmAPY3GrG5TQRMOYeSIogQpeKocefq+mkJFFdyI/CYmszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364243; c=relaxed/simple;
	bh=zrVd5zsFmyiPZG4LAZy+TECTreB/+eM7rk7NPed3SAY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JhUMs4ldGnnh3rD3ODJYmP/K7tG88ol3lm6va0YmFMDgKGitUHqsqj6QVoMQos5V/jelNQnXiA8Oa86Nza+HJwYNDnFYLYxEqK4xLfof6pj5MDfiHUepHlosIr6/eNsFTovN5vjyJqj8F3Ln1pHYUx/ItKzzlcKAistqTE5iR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFaVecGF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFaVecGF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso4249080f8f.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742364239; x=1742969039; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kif3UiF3GCKCnQa2vCjv58zuFqdk0rxWvOQj5m9ZgrQ=;
        b=IFaVecGF0x/GjomEZqLYE62KrSUU7XTMAAqh95JQbZoLYub5ptTJgD5LcJB8vRcZ1v
         bhb1Vv0TThrHyqZdOTlW+ia2X6CO7AHTeKMt3t9++RBnsWjQXLaHWn37cdjKV/AWr6VP
         4iTu0+UiGMk/MlOPD2h1WKW1rbvUeIWCAWkUPiBZ1ZOe9IGaQo6nhM9Fo6vvPcwIEEeg
         noyELkkGtPYv16iONtn00FG8//Bv4YthsFykquICXdtj0vxlXlo48CrUFW3NubKHAMMp
         wrJa5pulbHpBVdO1FYl8OgkUK1F0Y+O4u1rzh9AvXoosb7+SmmIYINEzCwxqo6arE4dh
         qU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742364239; x=1742969039;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kif3UiF3GCKCnQa2vCjv58zuFqdk0rxWvOQj5m9ZgrQ=;
        b=NUcn0+8HJeDjBkuv54r4ePCF+Ah41wcuj/MO4WWpcpCelPjgFoz00a7SpsPyy2+OHc
         EQXB9ycM4ACi9E3vnl2tcrTf8lju8QAbWdN7VLU3k2B1jVNpC90ANY1Pc4z740jFSQd+
         TEvA2xShyWV7GM8gBFJMMylZQS/+6WTzrbn3qU3Q7dwZYDzaGMSOTQBCuVKdEz0n4+GX
         0YE43eKhetZQ0QkSPb/SUuOt+A9UqCO+PoPlOLhP49GZsRzNHj8PHvNoTZqGBKV7b2gX
         rEnBIUtMwAT2nQ7v+pMc7oJKCmZkTvjrOUJ/dgXeDZAMW6M3djW/uSbzTJqgJHWoRM2P
         iT/A==
X-Gm-Message-State: AOJu0YwSqfqA4FPvqR9YBoz0FhN1zzPoBIbFjHkzn1BJOscAgXWgVL30
	GKpVdQXIyxnzUbDBBBuBXkrTkFNIIacP5R0N9YtBYKvKcQZXAjw025cdOw==
X-Gm-Gg: ASbGncvacweyFAi4DceysVIwYof8A+E3qOLnIA4x3ZiHNauJZ8012atwBn/diGVGdMj
	KkzgXJaCRSS4LURYOBH2Oo0wqKrQ6x+rz0fNlliRTNWZq2Ya6ZtK8vwz5xzokTkKkP29ZPq9xpa
	SkJTNs5yHsPO999IQbyWjp+HRdidAB32UPLwB/5BufDKu/ca5BvFI27yCikWltrPaj3msh2R64P
	BVqsvJDn5ZyiTSC0Q86pum0KHObme2gYihkWtPNR5X7F4RdKYWBSjdPLVTxhGhRnx7edyyd2hUf
	jESIw0W5Os4XzRgvfJfuN9pkJ5DjN4rNll98C8ErjIKWug==
X-Google-Smtp-Source: AGHT+IGJVo2r8lwoBqeVGcg2KK1KZP+SzqT54dKKRjYLJzid98OiQi06iQgB80Lsq1wwVDn5XpHHIw==
X-Received: by 2002:adf:a31b:0:b0:38d:e48b:1787 with SMTP id ffacd0b85a97d-399739ed94dmr1009062f8f.14.1742364239093;
        Tue, 18 Mar 2025 23:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df344dsm20604006f8f.10.2025.03.18.23.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:03:58 -0700 (PDT)
Message-Id: <pull.1923.v2.git.git.1742364237330.gitgitgadget@gmail.com>
In-Reply-To: <pull.1923.git.git.1742329571265.gitgitgadget@gmail.com>
References: <pull.1923.git.git.1742329571265.gitgitgadget@gmail.com>
From: "Sampriyo Guin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Mar 2025 06:03:57 +0000
Subject: [PATCH v2] [GSoC Patch v2]Modernize Test Path Checking: test -(e|f|d)
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
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    "Karthik Nayak [ ]" <karthik.188@gmail.com>,
    "Jialuo She [ ]" <shejialuo@gmail.com>,
    "Christian Couder [ ]" <christian.couder@gmail.com>,
    "Ghanshyam Thakkar [ ]" <shyamthakkar001@gmail.com>,
    "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
    Sampriyo Guin <sampriyoguin@gmail.com>,
    Sampriyo Guin <sampriyoguin@gmail.com>

From: Sampriyo Guin <sampriyoguin@gmail.com>

test -f changed to test_path_is_file
test -f does not provide a proper error message so test_path_is_file used
Changed for t/t2003-checkout-cache-mkdir.sh

Signed-off-by: Sampriyo Guin <sampriyoguin@gmail.com>
---
    [GSoC Patch v2] Modernize Test Path Checking in Git’s Test Suite
    
    test -(e|f|d) does not provide a proper error message when hit test
    failures. So test_path_exists, test_path_is_dir, test_path_is_file used.
    
    Added changes for files from t/t0007-git-var.sh to
    t/t1700-split-index.sh.
    
    Signed-off-by: Sampriyo Guin <sampriyoguin@gmail.com>

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1923%2FRimoGuin%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1923/RimoGuin/master-v2
Pull-Request: https://github.com/git/git/pull/1923

Range-diff vs v1:

 1:  432dbe6fb82 < -:  ----------- [GSoC Patch] Modernize Test Path Checking in Git’s Test Suite
 -:  ----------- > 1:  0f74a82d681 [GSoC Patch v2]Modernize Test Path Checking: test -(e|f|d)


 t/t2003-checkout-cache-mkdir.sh | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index ff163cf6750..9d2f59e0d78 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -24,16 +24,16 @@ test_expect_success SYMLINKS 'have symlink in place where dir is expected.' '
 	mkdir path2 &&
 	ln -s path2 path1 &&
 	git checkout-index -f -a &&
-	test ! -h path1 && test -d path1 &&
-	test -f path1/file1 && test ! -f path2/file1
+	test ! -h path1 && test_path_is_dir path1 &&
+	test_path_is_file path1/file1 && test ! -f path2/file1
 '
 
 test_expect_success 'use --prefix=path2/' '
 	rm -fr path0 path1 path2 &&
 	mkdir path2 &&
 	git checkout-index --prefix=path2/ -f -a &&
-	test -f path2/path0 &&
-	test -f path2/path1/file1 &&
+	test_path_is_file path2/path0 &&
+	test_path_is_file path2/path1/file1 &&
 	test ! -f path0 &&
 	test ! -f path1/file1
 '
@@ -41,8 +41,8 @@ test_expect_success 'use --prefix=path2/' '
 test_expect_success 'use --prefix=tmp-' '
 	rm -fr path0 path1 path2 tmp* &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
-	test -f tmp-path1/file1 &&
+	test_path_is_file tmp-path0 &&
+	test_path_is_file tmp-path1/file1 &&
 	test ! -f path0 &&
 	test ! -f path1/file1
 '
@@ -52,8 +52,8 @@ test_expect_success 'use --prefix=tmp- but with a conflicting file and dir' '
 	echo nitfol >tmp-path1 &&
 	mkdir tmp-path0 &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
-	test -f tmp-path1/file1 &&
+	test_path_is_file tmp-path0 &&
+	test_path_is_file tmp-path1/file1 &&
 	test ! -f path0 &&
 	test ! -f path1/file1
 '
@@ -63,9 +63,9 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary/ where tmp is a symlink' '
 	mkdir tmp1 tmp1/orary &&
 	ln -s tmp1 tmp &&
 	git checkout-index --prefix=tmp/orary/ -f -a &&
-	test -d tmp1/orary &&
-	test -f tmp1/orary/path0 &&
-	test -f tmp1/orary/path1/file1 &&
+	test_path_is_dir tmp1/orary &&
+	test_path_is_file tmp1/orary/path0 &&
+	test_path_is_file tmp1/orary/path1/file1 &&
 	test -h tmp
 '
 
@@ -74,8 +74,8 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
 	mkdir tmp1 &&
 	ln -s tmp1 tmp &&
 	git checkout-index --prefix=tmp/orary- -f -a &&
-	test -f tmp1/orary-path0 &&
-	test -f tmp1/orary-path1/file1 &&
+	test_path_is_file tmp1/orary-path0 &&
+	test_path_is_file tmp1/orary-path1/file1 &&
 	test -h tmp
 '
 
@@ -84,10 +84,10 @@ test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
 	mkdir tmp1 &&
 	ln -s tmp1 tmp-path1 &&
 	git checkout-index --prefix=tmp- -f -a &&
-	test -f tmp-path0 &&
+	test_path_is_file tmp-path0 &&
 	test ! -h tmp-path1 &&
-	test -d tmp-path1 &&
-	test -f tmp-path1/file1
+	test_path_is_dir tmp-path1 &&
+	test_path_is_file tmp-path1/file1
 '
 
 test_expect_success 'apply filter from working tree .gitattributes with --prefix' '

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
