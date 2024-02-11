Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4982E842
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663202; cv=none; b=bKpLe6Vk8/HO7h+DjLHfwq5nCqU41KiOABJTCYkyrlcZjf/RXWMsX0jnfWd08vz/Dkts5dy12RFF7zHwUt9a5axtC6NuCbWJQN6CBeAlmJ9VJc1EhK38i12GJA+i7/O1dp30Xmd6zZ/vhOUW+Z7zszTMqQyWEEHM5lZOd5muJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663202; c=relaxed/simple;
	bh=U9cDf4lN35cByTZdbhfePKX4Z43+k8Kd/NcGklQ8e9U=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=al05D4u17ONK6fKKjeQEiTfm0vIyuYrbTo1yWq5oX7vMIQg1qcleb7xdYK+Ft4hsb1UQA7IxBj1B00xic/O84UGwxHVBkbdYMpTqITgRigeUeJqzLAwpIKGl9nbgW/+OHASLwWEvnPHQEe/qKZmUgBbgbBjcD8vUNWGtfZ54Ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isGQleTs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isGQleTs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so20193805e9.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 06:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707663199; x=1708267999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sulOqkF+OYEswCZcaS5fh5ObneaxvOCkBrB03SdeQFE=;
        b=isGQleTs/PKYg4KfSsZAU1tNIpc8S85F0JVzME9jk9gzkWweAMwRHg7/M/VKD7C65R
         gZfviqrBaXI+tYR21WknDcyH0mtM6/OzGNp7HdQFSiIUM9RahQvguJarMDU+VDS2Zk7d
         b9UipIuYRggYEo2OthrB4vyQjTnmzWDAc8FAdaA5lusWQt8QCrmOyI0tYA2ELxFe9xv8
         nuTY8uMohmf7KRhsHybmMyZ1/yzic6KFFzsC/8V9f/trDaUdhHxI9zRGpw5k3xwN0jU2
         8+KGPaUyMV1T+nKbEMzjPcMHtrlC1nAmwrpRwTtkLgiSk9OVljmvsm3ojYOn8c76HmkZ
         n6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707663199; x=1708267999;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sulOqkF+OYEswCZcaS5fh5ObneaxvOCkBrB03SdeQFE=;
        b=rEaev0Zqhke25bZN1oNQfJ2c59EUlS+li8BvY9lxViJdMMm0W1Xl/a4GN3KUWrS/Kq
         60We3PKWSO3mNypOCts0tHk05E+EB2qy4NddQjc24mP7N9PtmSwBwKwHCwnUcq8Nm/Yf
         q2tNDMBQxrhYP6Q8+bAO2n793d5Cnm7rMroUWG04Cf6+vm2of3f6vJeXjC5FnQNRmSrp
         x43JpL620lvhg+XK3KplWsUQ97VEm28ZVUx3UGIxy8H3cqXaZExz27UBbkeG3L6iwuEm
         1uc6ri/VyKL2ahFgRHhrlCmurSMCJcTlO0Vlc6t+x4rm3tBzdaRMpeLiBW679GuS1Az+
         fVrw==
X-Gm-Message-State: AOJu0YwZLvMh01bBNbUEIfCULGecjIB3/lXfX1Ynf6A3ziC5+TeJC1uj
	K5EjKpuQokoJcKAMaIRMBwigBsN1VSA535rW3mT/fOu1zQ0tB2ZjX8FItneS
X-Google-Smtp-Source: AGHT+IFkP6O1ORYBnoQKjxjlBKY5MGiwrrEuA3GifVnfXyYQxGb3hvAnVx7VIvPCz+u6NsIpSdA9Jw==
X-Received: by 2002:a05:600c:19c9:b0:40d:3fee:97f6 with SMTP id u9-20020a05600c19c900b0040d3fee97f6mr3858788wmq.34.1707663198514;
        Sun, 11 Feb 2024 06:53:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSkuSgwQQvcR83sc98rUdaCm9BGV0x6sWPSWl31RA7Ex9floDE67/b/vMMZBYfZ3dWvb/uvnEGaflgtyUB1CnAdiNL9Lmra2r8hRY=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b0040e9d507424sm6127791wms.5.2024.02.11.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 06:53:18 -0800 (PST)
Message-ID: <pull.1661.git.1707663197543.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Feb 2024 14:53:17 +0000
Subject: [PATCH] t9146: replace test -d/-f with appropriate test_path_is_*
 function
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
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

The helper functions test_path_is_* provide better debugging
information than test -d/-e/-f.

Replace "! test -d" with "test_path_is_missing" at places where
we check for non-existent directories.

Replace "test -f" with "test_path_is_file" and "test -d" with
"test_path_is_dir" at places where we expect files or directories
to exist.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    t9146: replace test -d/-f with appropriate test_path_is_* function

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1661%2FChand-ra%2Ftestfix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1661/Chand-ra/testfix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1661

 t/t9146-git-svn-empty-dirs.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 09606f1b3cf..532f5baa208 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -20,7 +20,7 @@ test_expect_success 'empty directories exist' '
 		cd cloned &&
 		for i in a b c d d/e d/e/f "weird file name"
 		do
-			if ! test -d "$i"
+			if test_path_is_missing "$i"
 			then
 				echo >&2 "$i does not exist" &&
 				exit 1
@@ -37,7 +37,7 @@ test_expect_success 'option automkdirs set to false' '
 		git svn fetch &&
 		for i in a b c d d/e d/e/f "weird file name"
 		do
-			if test -d "$i"
+			if test_path_is_dir "$i"
 			then
 				echo >&2 "$i exists" &&
 				exit 1
@@ -52,7 +52,7 @@ test_expect_success 'more emptiness' '
 
 test_expect_success 'git svn rebase creates empty directory' '
 	( cd cloned && git svn rebase ) &&
-	test -d cloned/"! !"
+	test_path_is_dir cloned/"! !"
 '
 
 test_expect_success 'git svn mkdirs recreates empty directories' '
@@ -62,7 +62,7 @@ test_expect_success 'git svn mkdirs recreates empty directories' '
 		git svn mkdirs &&
 		for i in a b c d d/e d/e/f "weird file name" "! !"
 		do
-			if ! test -d "$i"
+			if test_path_is_missing "$i"
 			then
 				echo >&2 "$i does not exist" &&
 				exit 1
@@ -78,21 +78,21 @@ test_expect_success 'git svn mkdirs -r works' '
 		git svn mkdirs -r7 &&
 		for i in a b c d d/e d/e/f "weird file name"
 		do
-			if ! test -d "$i"
+			if test_path_is_missing "$i"
 			then
 				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
 		done &&
 
-		if test -d "! !"
+		if test_path_is_dir "! !"
 		then
 			echo >&2 "$i should not exist" &&
 			exit 1
 		fi &&
 
 		git svn mkdirs -r8 &&
-		if ! test -d "! !"
+		if test_path_is_missing "! !"
 		then
 			echo >&2 "$i not exist" &&
 			exit 1
@@ -114,7 +114,7 @@ test_expect_success 'empty directories in trunk exist' '
 		cd trunk &&
 		for i in a "weird file name"
 		do
-			if ! test -d "$i"
+			if test_path_is_missing "$i"
 			then
 				echo >&2 "$i does not exist" &&
 				exit 1
@@ -138,16 +138,16 @@ test_expect_success 'git svn gc-ed files work' '
 		cd removed &&
 		git svn gc &&
 		: Compress::Zlib may not be available &&
-		if test -f "$unhandled".gz
+		if test_path_is_file "$unhandled".gz
 		then
 			svn_cmd mkdir -m gz "$svnrepo"/gz &&
 			git reset --hard $(git rev-list HEAD | tail -1) &&
 			git svn rebase &&
-			test -f "$unhandled".gz &&
-			test -f "$unhandled" &&
+			test_path_is_file "$unhandled".gz &&
+			test_path_is_file "$unhandled" &&
 			for i in a b c "weird file name" gz "! !"
 			do
-				if ! test -d "$i"
+				if test_path_is_missing "$i"
 				then
 					echo >&2 "$i does not exist" &&
 					exit 1

base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
-- 
gitgitgadget
