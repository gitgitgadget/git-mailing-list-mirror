Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875F2877CF
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694897; cv=none; b=h/5e/Pdhhe1KhO7LLgDlHnVE/O7ANBXDpjxGBK7QdHxLJMrRFZP6OVgEB6+CmyXOoIgR37sE+wgzuM/54UtShjot8ER5xY0nA70lLYkzGTZPyDIfSa7nDfV9qzzdFMhFGmcNGMcBprOOvyrNYbEZpj3MCI836p57o3PhXqdAWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694897; c=relaxed/simple;
	bh=wyixuyjnVPrRaGc71S+BAKFa+ktHhkuBTBSWpqVbWSE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Dfbl6DOoL/JPtlwipe6nAGj7fSCRZ1k7oGi8IE94CaOruOALtQdjH0GpMIukKmFj5SWc3oz/kA5TLmFB94XE5zknxXhiPOxnj5q7IEjEPHYvY7DEFCfUMril8x96RjBFsNWtCPE0W4akdRUWqmYS2g3jrEHJlTVGeqiJ8kDNd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/G8XgdK; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/G8XgdK"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8972a14e27bso40712036d6.2
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 09:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771694894; x=1772299694; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvGCZ5IVbje1ftONX0Imn7nYWvNLy+FsCqQANCjOgM=;
        b=k/G8XgdKgGds85tk0dtlnF7BZ8GfrXA1IKH+Yuab4BTPqrLDQdG4sE+VEUlnlkWydi
         8/9uxJpmhV92aTzHfQb1lDopDenwvDKM2507tCnyqbsH+H2o+RV2FcaMy8EXvoyJgxFN
         YBKwzxRT/f/Eyn3iAzvR0KrVom9gX3O84hYFd3iiU778SMpZu+xRN+l0jlxiF1QDs3e5
         UfF1vTaKxhdDkrPbBHyMPb/hJq7nHl5HTFv+8G5sUKlijrd7eemSmLrYtugcYRtfdWPB
         MW6CepcBXwdskjHf5tXuF4yWCtsLYBe/HOkHBydVm43dFOpDTDhPzqOxFdCwpjm1LBLn
         vm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771694894; x=1772299694;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BvGCZ5IVbje1ftONX0Imn7nYWvNLy+FsCqQANCjOgM=;
        b=GoRneax1P1VcCOJIiG/sCHD8HlcsuFoaXWbaDI4VFWmP2sq1tzzrf/D4fRMLnPkzVX
         6GKlzvGRwpEE+o71i8wruNEySWc1F6AJNsDVbTWYQ5wseNxMXa2dVtaxNe79Hnp+5EYm
         QNkJS0WHoNEUshvcJ0iSvqd8ahf5gKs5XFir6NpavoTR20109I/YieHkpuVBlV+6MSH5
         /ylLq2r0NIeHEFnxt3SU+QOQue04QADpPV+eOqc006b8a+Tl1uwGwS57gaNkNVpZuDvX
         6w2TtELxEbLuqwTAOjXXPKqzFg2wa81aCQgwYoSHUIy6z3qMwjRisWcsDlqpSEbGaKV9
         XgFw==
X-Gm-Message-State: AOJu0Yz8C5k3B3dpBZeaKEKjxoLCiZw9hNExK0DTOqF2U1oACD9yJJrF
	Yv7HoFQ6xZGVd+Lji9R4mxTyolgdFWgY04LJnJJd7zRTu0bx4Di+wSb1OtQkGQ==
X-Gm-Gg: AZuq6aJKrjl43030essJ6KN00ZfUEJbvQrJkGZLi13Vgq3wytviXPh9OKS7GzVnOrX0
	WpS4MSBFATYmPkRPRlGcwtbAvlt6Opasr5hsiA4dPm86tJtDDwnR80JuooCq6xzFPCwzt+aitcn
	tPK5gKIu8m/ncuNiHYXNvuXu1Of6ZjqWiNDRvE4Vjt33QgipNJvUvaFczlQNSJm4IKHdqpIN44P
	cutnKfjW/1awoDoMvlTR0gO/kCMZFwbqLvxEGMsqmuXKMcLpY5GhXyKSc8I2ZkWeuTpECORrs4a
	0wJToBqB0klbvzXOalv7X3eHwRwkfaVHHNGGyRuvbGf028GTVFQULP0DMv3WNDiDoIGR6elaUuG
	e9nVK6JNkvCcbeVTTZD4RmjcOensoQDqbxvRMKUsW5C7R9EIM4UktL/1a/m9S+BLQeEZqaFaSH5
	qI+PUeGN+VAsaAtHQMWDAVc1uF
X-Received: by 2002:a05:6214:21ae:b0:894:835d:b112 with SMTP id 6a1803df08f44-89979ecbd6fmr66307646d6.40.1771694894604;
        Sat, 21 Feb 2026 09:28:14 -0800 (PST)
Received: from [127.0.0.1] ([64.236.161.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c697469sm21614196d6.9.2026.02.21.09.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 09:28:14 -0800 (PST)
Message-Id: <pull.2049.git.1771694893208.gitgitgadget@gmail.com>
From: "Lambert Duclos via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Feb 2026 17:28:13 +0000
Subject: [PATCH] t2004: use test_path_is_file instead of test -f
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
Cc: Lambert Duclos <lambertddg@gmail.com>,
    Lambert Duclos-de Guise <lambertddg@gmail.com>

From: Lambert Duclos-de Guise <lambertddg@gmail.com>

Replace 'test -f' with the helper function 'test_path_is_file'
to provide better error messages upon failure.

Signed-off-by: Lambert Duclos-de Guise <lambertddg@gmail.com>
---
    [GSoC] t2004: use test_path_is_file instead of test -f
    
    Replace 'test -f' with the helper function 'test_path_is_file' to
    provide better error messages upon failure.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2049%2FLambertDuclos%2Ft2004-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2049/LambertDuclos/t2004-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2049

 t/t2004-checkout-cache-temp.sh | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index b92d96fdc4..0afe0ff7ca 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -42,7 +42,7 @@ test_expect_success 'checkout one stage 0 to temporary file' '
 	test_line_count = 1 actual &&
 	test $(cut "-d	" -f2 actual) = path1 &&
 	p=$(cut "-d	" -f1 actual) &&
-	test -f $p &&
+	test_path_is_file $p &&
 	test $(cat $p) = tree1path1
 '
 
@@ -55,7 +55,7 @@ test_expect_success 'checkout all stage 0 to temporary files' '
 	do
 		test $(grep $f actual | cut "-d	" -f2) = $f &&
 		p=$(grep $f actual | cut "-d	" -f1) &&
-		test -f $p &&
+		test_path_is_file $p &&
 		test $(cat $p) = tree1$f || return 1
 	done
 '
@@ -71,7 +71,7 @@ test_expect_success 'checkout one stage 2 to temporary file' '
 	test_line_count = 1 actual &&
 	test $(cut "-d	" -f2 actual) = path1 &&
 	p=$(cut "-d	" -f1 actual) &&
-	test -f $p &&
+	test_path_is_file $p &&
 	test $(cat $p) = tree2path1
 '
 
@@ -83,7 +83,7 @@ test_expect_success 'checkout all stage 2 to temporary files' '
 	do
 		test $(grep $f actual | cut "-d	" -f2) = $f &&
 		p=$(grep $f actual | cut "-d	" -f1) &&
-		test -f $p &&
+		test_path_is_file $p &&
 		test $(cat $p) = tree2$f || return 1
 	done
 '
@@ -108,9 +108,9 @@ test_expect_success 'checkout all stages/one file to temporary files' '
 	test_line_count = 1 actual &&
 	test $(cut "-d	" -f2 actual) = path1 &&
 	cut "-d	" -f1 actual | (read s1 s2 s3 &&
-	test -f $s1 &&
-	test -f $s2 &&
-	test -f $s3 &&
+	test_path_is_file $s1 &&
+	test_path_is_file $s2 &&
+	test_path_is_file $s3 &&
 	test $(cat $s1) = tree1path1 &&
 	test $(cat $s2) = tree2path1 &&
 	test $(cat $s3) = tree3path1)
@@ -143,8 +143,8 @@ test_expect_success 'checkout some stages/one file to temporary files' '
 	test $(cut "-d	" -f2 actual) = path2 &&
 	cut "-d	" -f1 actual | (read s1 s2 s3 &&
 	test $s1 = . &&
-	test -f $s2 &&
-	test -f $s3 &&
+	test_path_is_file $s2 &&
+	test_path_is_file $s3 &&
 	test $(cat $s2) = tree2path2 &&
 	test $(cat $s3) = tree3path2)
 '
@@ -162,9 +162,9 @@ test_expect_success '-- path0: no entry' '
 test_expect_success '-- path1: all 3 stages' '
 	test $(grep path1 actual | cut "-d	" -f2) = path1 &&
 	grep path1 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
-	test -f $s1 &&
-	test -f $s2 &&
-	test -f $s3 &&
+	test_path_is_file $s1 &&
+	test_path_is_file $s2 &&
+	test_path_is_file $s3 &&
 	test $(cat $s1) = tree1path1 &&
 	test $(cat $s2) = tree2path1 &&
 	test $(cat $s3) = tree3path1)
@@ -174,8 +174,8 @@ test_expect_success '-- path2: no stage 1, have stage 2 and 3' '
 	test $(grep path2 actual | cut "-d	" -f2) = path2 &&
 	grep path2 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
 	test $s1 = . &&
-	test -f $s2 &&
-	test -f $s3 &&
+	test_path_is_file $s2 &&
+	test_path_is_file $s3 &&
 	test $(cat $s2) = tree2path2 &&
 	test $(cat $s3) = tree3path2)
 '
@@ -183,9 +183,9 @@ test_expect_success '-- path2: no stage 1, have stage 2 and 3' '
 test_expect_success '-- path3: no stage 2, have stage 1 and 3' '
 	test $(grep path3 actual | cut "-d	" -f2) = path3 &&
 	grep path3 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
-	test -f $s1 &&
+	test_path_is_file $s1 &&
 	test $s2 = . &&
-	test -f $s3 &&
+	test_path_is_file $s3 &&
 	test $(cat $s1) = tree1path3 &&
 	test $(cat $s3) = tree3path3)
 '
@@ -193,8 +193,8 @@ test_expect_success '-- path3: no stage 2, have stage 1 and 3' '
 test_expect_success '-- path4: no stage 3, have stage 1 and 3' '
 	test $(grep path4 actual | cut "-d	" -f2) = path4 &&
 	grep path4 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
-	test -f $s1 &&
-	test -f $s2 &&
+	test_path_is_file $s1 &&
+	test_path_is_file $s2 &&
 	test $s3 = . &&
 	test $(cat $s1) = tree1path4 &&
 	test $(cat $s2) = tree2path4)
@@ -203,7 +203,7 @@ test_expect_success '-- path4: no stage 3, have stage 1 and 3' '
 test_expect_success '-- asubdir/path5: no stage 2 and 3 have stage 1' '
 	test $(grep asubdir/path5 actual | cut "-d	" -f2) = asubdir/path5 &&
 	grep asubdir/path5 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
-	test -f $s1 &&
+	test_path_is_file $s1 &&
 	test $s2 = . &&
 	test $s3 = . &&
 	test $(cat $s1) = tree1asubdir/path5)
@@ -216,7 +216,7 @@ test_expect_success 'checkout --temp within subdir' '
 		test_line_count = 1 actual &&
 		test $(grep path5 actual | cut "-d	" -f2) = path5 &&
 		grep path5 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
-		test -f ../$s1 &&
+		test_path_is_file ../$s1 &&
 		test $s2 = . &&
 		test $s3 = . &&
 		test $(cat ../$s1) = tree1asubdir/path5)
@@ -230,7 +230,7 @@ test_expect_success 'checkout --temp symlink' '
 	test_line_count = 1 actual &&
 	test $(cut "-d	" -f2 actual) = path6 &&
 	p=$(cut "-d	" -f1 actual) &&
-	test -f $p &&
+	test_path_is_file $p &&
 	test $(cat $p) = path7
 '
 

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
gitgitgadget
