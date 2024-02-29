Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E606137756
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219122; cv=none; b=aDHZfX2tmpxx6wy1MNWzpWS9QJxNJ8DeZVRqzwHMggXhq1zytxaQ5s7ztks0/s0BcQGmnVxvhEp7tys+qMHHv7BrG+iPB+dpmitDCtXB0j8+Y7WDZ1EY3toCL64Q+J3NM3PYKNoVXyeiUgK0n4E4sHoXk6NF9AmCqkJzxyBQSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219122; c=relaxed/simple;
	bh=fx4u10fHHOr7ICSjnnMB7fXSNdLyx/iFNWhk6l5OAaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sY0bae+0JwE7dSuY1wNs5TdB9E7+ATlps72uoXFR5JhVeN0ecd0vqDKJRqPVh3SFtwd2iFhxy+vsWZli73W+HKLoGbbzTB0JqMseq33DM7GX4ljk1hOdk/BPr3gi/wSdnOZVOk67luw03HkFwLFOZBdTz/evWzYIPyLIhVhBl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmvposFC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmvposFC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcd0431f00so7545375ad.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709219120; x=1709823920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsNk7T9978sxbE/4BQ+g8OQnTKhPchMsBQIHdLG2QZw=;
        b=WmvposFCSUyGnW2nM4EwGRBQHEVILTm6IR2/xriJvFJxBePMr1sMyyd2C4//AOe6Y+
         x8L5V4ITY/LF5uUOaEho33Fxm3bGWE3wQ9q7itqhd6l399xsEmkfienm9W5bvYyMAPpf
         JCKMN1cwMRTF3hDz2Zav3Kd83BzOoo7A2fzbdXcYBGw//raaC2DQru4fIsq3BJ4OJmU1
         NL3BKpjRTWtYnFJOxuhXwTZCBb/TvIe6Bxh93uPFOlTxuznCltE1HKK/OCCdCsaDC66k
         nsS+zSf38dEFgQyOnXYOo1Ag1ggs1xkDp0KLBe6WO44ybPFbzUZLYGq6tnQqOGZIk2/4
         ctQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219120; x=1709823920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsNk7T9978sxbE/4BQ+g8OQnTKhPchMsBQIHdLG2QZw=;
        b=d3E+lm5W5m/oCUhCOUHDAfBQHbCcmomIhtYdSAlrh5i2QiW8KjyiixJ4wbtP8SMmw4
         jwedpWmqgj1hXo6m1Y+vxoT6wsy7Yly/JUZVWoNsz0D85wmIJmcyAqQLMovXX2Q+L2rd
         NitgZTVVN4/MSuCVHnxevhX+mbxgTK1QiOXunRlwjdRfYoA198fbmVBxaY+BiXKhR1D8
         0jJMqqkBue7zQEJJC9R84a4rxk8m5jWgb9YqfGTYAyJh4ZYL8+CUDdQ0oiNYVfpZkgsy
         bqU8Vtggt376qAlM70sLs8YGCnJ6JVdBDxTzlf4nRcCIHN1uCXG7Ca5cM1o7XHA4oun3
         sG2g==
X-Gm-Message-State: AOJu0YyRdtLUiJcWudzHgZf3K7c5Yo4jOtOFjMkvxeWtHew1u2ocT6xm
	nW+IQUtssjBQfUEgJJnw2OSCXpkHZraspusid55sTpOFLHFuBOOx3XuzpZuox7925A==
X-Google-Smtp-Source: AGHT+IH0VULWHJL2faaDtX0ItWDBH+B3fwKvrJdFD0sV8rb92ignWN3IuZ1ZUPhBcfv8G3GfdTwnlA==
X-Received: by 2002:a17:903:181:b0:1dc:2d65:5fd1 with SMTP id z1-20020a170903018100b001dc2d655fd1mr2787486plg.2.1709219119946;
        Thu, 29 Feb 2024 07:05:19 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001db337d53ddsm1603014pln.56.2024.02.29.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:05:19 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>
Subject: [PATCH 1/1] [GSoC][PATCH] t3070: refactor test -e command
Date: Thu, 29 Feb 2024 23:04:42 +0800
Message-ID: <20240229150442.490649-2-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229150442.490649-1-shejialuo@gmail.com>
References: <20240229150442.490649-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "test_path_exists" function was proposed at 7e9055b. It provides
parameter number check and more robust error messages.

This patch converts all "test -e" into "test_path_exists" to improve
test debug when failure.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/t3070-wildmatch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4dd42df38c..d18ddc1a52 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -107,7 +107,7 @@ match_with_ls_files() {
 
 	if test "$match_expect" = 'E'
 	then
-		if test -e .git/created_test_file
+		if test_path_exists .git/created_test_file
 		then
 			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match dies on '$pattern' '$text'" "
 				printf '%s' '$text' >expect &&
@@ -118,7 +118,7 @@ match_with_ls_files() {
 		fi
 	elif test "$match_expect" = 1
 	then
-		if test -e .git/created_test_file
+		if test_path_exists .git/created_test_file
 		then
 			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): match '$pattern' '$text'" "
 				printf '%s' '$text' >expect &&
@@ -130,7 +130,7 @@ match_with_ls_files() {
 		fi
 	elif test "$match_expect" = 0
 	then
-		if test -e .git/created_test_file
+		if test_path_exists .git/created_test_file
 		then
 			test_expect_success EXPENSIVE_ON_WINDOWS "$match_function (via ls-files): no match '$pattern' '$text'" "
 				>expect &&
@@ -175,7 +175,7 @@ match() {
 	fi
 
 	test_expect_success EXPENSIVE_ON_WINDOWS 'cleanup after previous file test' '
-		if test -e .git/created_test_file
+		if test_path_exists .git/created_test_file
 		then
 			git reset &&
 			git clean -df
@@ -198,7 +198,7 @@ match() {
 			fi &&
 			git add -A &&
 			printf "%s" "$file" >.git/created_test_file
-		elif test -e .git/created_test_file
+		elif test_path_exists .git/created_test_file
 		then
 			rm .git/created_test_file
 		fi
-- 
2.44.0

