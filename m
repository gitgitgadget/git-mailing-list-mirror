Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F913148DD
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625199; cv=none; b=hFG+u+G/u6RMsZum3mektB2jOr7WC7g5AEw7aGci+T/h6BNhCY4bq7MdYdu4ta8996ETw6jEs56LxTXg3ltaiCysLpdkKG2+1i/p+ZjNNFyJNUKUxUKjmzBtzKsMj1sIrgUHKGMaqoF1uH55OlRpvNrvbkYw3C4GnQ0pKTAicZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625199; c=relaxed/simple;
	bh=yxwf2OOds1JOPHtoyQvLVFqzAGEWj7hV21JEapsJydw=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=E8JMZCltC5+rYTClLQvXXHtF3mB8RFuulO9mTfdb2dL9M/wfuZaJGnAhHygXISdAylrv1CBiz4SNqHQ73ZBbM0qTMlkmCqP5jJ6DtN4W6BQc229bEOhw7uEGjg9hIT6pH/mEPqgvicwquJhHIDWqpgLBeMSRFIoPx/z5usIntmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwAlxpO4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwAlxpO4"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso8235818a12.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 06:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767625196; x=1768229996; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AQkzJxMqQ1pV+KhEKOguqyVVqFnrpyjq7XhBFhItSAU=;
        b=iwAlxpO4M+hIL5s+wyz/fTkJNZq6nTX6zalVCrgi4tzXrqHsitQk7v9h3wx52j/SwZ
         jOMw0fEpJ8TchuZmkpstpCWx0GWId3HpoWiqASofqhqsuR6biw69/JCs7pGiBj7Crtv1
         Xxu5g9AOzimhAkjBAAIIi7PmoOD3a5zs28k1ZZYXfZW3vrtimmBjaZuoCQrrIURN7QF2
         ReMF8sfr5Poc/3sgwoDTUsNOhw3jYgIZKT2onzsGrAx2rvqmTPhNWlRNkgt/bqxSoVSF
         zUGNkMdO4Veo8YuN9V3xCSrcUtdhMdgkNQukQEhk9DdudBZkdNZppvcaNBnuFJNGs9pS
         zwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767625196; x=1768229996;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQkzJxMqQ1pV+KhEKOguqyVVqFnrpyjq7XhBFhItSAU=;
        b=TtEluNS6rUOSi/ghMU6GFjU0pj7lmnd1PWBKlSnLuI7+wRvXVCZ5YnMAW75a79Omdt
         n20HIcG50krARvydau/PcJA0Pb4ONuIkX8K7SrVM7zdC4YLkAwKcDGp2obN4J2Tb+mHX
         hLvL30egfPMriZu4apwy9ojEUlbNUIBly8Ipk0jqh+hlGfNyVfFsV6nA2Gj+ZhqewJLf
         knnkq1oto3a+cSMREny2ckomvsEQOPJ5qFcyjx3yP/cyfb8a6ORplXvkuSysKAFK3FtH
         +N96LNSILWGTYMHTW6wd5BzPVF6iC9cdL9j/tPEqswLJ5cJgaR5hDFUqBammE/tkNOat
         TiBg==
X-Gm-Message-State: AOJu0Yz8zR6rOZxRqSfJqNlIFoukskEyzSYwcg1IWZamhwspOwJQu0Ac
	wiwDn4MyhuctGPEZ7MnIEZSqOjSLMNNbWw6lenSx8mAs7wODxiEtcfmbC9aUnA==
X-Gm-Gg: AY/fxX5W2AXAJmw9LaXBgiDZ1U4muf4ps4vxc0WQPIZ5/txrvhTkuTNtIHYDu6DIrOx
	s5g4agy4sh6esmpty/q+4k7WnoH08Tl7oIJZpTzNCtyAGxykuAUaw3pii7fk3+6vEMaS+rDXNBT
	3H9LhRprz9TPicTBOLWEFSxuGAzOsHGTvRJML0F1x39+8OZFv2ttEsqJLU2TQtzgvfdkdAQWvVb
	MmO2WCONIkwfL9mQl8Xj8F4YlyEZ7PVRB8w4ik0sown8k8uZQ/47bgG0GHNhWboea0DKo6T/Z9X
	HaYzEqyaCaKPnBNwXdxTumBrEiF9AHDYu5Lm2/rBoWb6CzKfgwuI9Ys+npVH7cGoV6biy8gNK5W
	UBLWd562Y0M3NWvp6HBsmp8sxYS4grkyCHg8kqyn7ok3sLcCd6FlJ8VQIZwNF+OsajjyWR3s5wR
	bgfuNYgLSqXeVvJA==
X-Google-Smtp-Source: AGHT+IHls6sUu3n1RA8MrxlpGYe3qGQ5tNVWpqrm9qNQrewNIp0pJN0boAVML36/KUlmCXLmY2jK6Q==
X-Received: by 2002:a05:7301:1983:b0:2ae:5092:934 with SMTP id 5a478bee46e88-2b05ec83761mr49207547eec.37.1767625196384;
        Mon, 05 Jan 2026 06:59:56 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42d8asm12121502eec.13.2026.01.05.06.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:59:55 -0800 (PST)
Message-Id: <pull.2160.git.git.1767625195071.gitgitgadget@gmail.com>
From: "Hoda Salim via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Jan 2026 14:59:55 +0000
Subject: [PATCH] [GSoC][PATCH] t9160:modernize test path checking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Hoda Salim <hoda.s.salim@gmail.com>,
    HodaSalim <hoda.s.salim@gmail.com>

From: HodaSalim <hoda.s.salim@gmail.com>

Replace old-style path checks with Git's dedicated test helpers:
- test -f → test_path_is_file
- test -d → test_path_is_dir
- test -s → test_file_not_empty

Found using: git grep "test -[efd]" t/

This improves test readability and provides better error messages
when path checks fail.

Signed-off-by: HodaSalim <hoda.s.salim@gmail.com>
---
    [GSoC][PATCH] t9160:modernize test path checking

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2160%2FHodaSalim%2Fmicroproject%2Fmodernize-t9160-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2160/HodaSalim/microproject/modernize-t9160-v1
Pull-Request: https://github.com/git/git/pull/2160

 t/t9160-git-svn-preserve-empty-dirs.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 36c6b1a12f..b89c1cb93a 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -61,15 +61,15 @@ test_expect_success 'clone svn repo with --preserve-empty-dirs' '
 
 # "$GIT_REPO"/1 should only contain the placeholder file.
 test_expect_success 'directory empty from inception' '
-	test -f "$GIT_REPO"/1/.gitignore &&
+	test_path_is_file "$GIT_REPO"/1/.gitignore &&
 	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1"
 '
 
 # "$GIT_REPO"/2 and "$GIT_REPO"/3 should only contain the placeholder file.
 test_expect_success 'directory empty from subsequent svn commit' '
-	test -f "$GIT_REPO"/2/.gitignore &&
+	test_path_is_file "$GIT_REPO"/2/.gitignore &&
 	test $(find "$GIT_REPO"/2 -type f | wc -l) = "1" &&
-	test -f "$GIT_REPO"/3/.gitignore &&
+	test_path_is_file "$GIT_REPO"/3/.gitignore &&
 	test $(find "$GIT_REPO"/3 -type f | wc -l) = "1"
 '
 
@@ -77,7 +77,7 @@ test_expect_success 'directory empty from subsequent svn commit' '
 # generated for every sub-directory at some point in the repo's history.
 test_expect_success 'add entry to previously empty directory' '
 	test $(find "$GIT_REPO"/4 -type f | wc -l) = "1" &&
-	test -f "$GIT_REPO"/4/a/b/c/foo
+	test_path_is_file "$GIT_REPO"/4/a/b/c/foo
 '
 
 # The HEAD~2 commit should not have introduced .gitignore placeholder files.
@@ -102,14 +102,14 @@ test_expect_success 'clone svn repo with --placeholder-file specified' '
 
 # "$GIT_REPO"/5/.placeholder should be a file, and non-empty.
 test_expect_success 'placeholder namespace conflict with file' '
-	test -s "$GIT_REPO"/5/.placeholder
+	test_file_not_empty "$GIT_REPO"/5/.placeholder
 '
 
 # "$GIT_REPO"/6/.placeholder should be a directory, and the "$GIT_REPO"/6 tree
 # should only contain one file: the placeholder.
 test_expect_success 'placeholder namespace conflict with directory' '
-	test -d "$GIT_REPO"/6/.placeholder &&
-	test -f "$GIT_REPO"/6/.placeholder/.placeholder &&
+	test_path_is_dir "$GIT_REPO"/6/.placeholder &&
+	test_path_is_file "$GIT_REPO"/6/.placeholder/.placeholder &&
 	test $(find "$GIT_REPO"/6 -type f | wc -l) = "1"
 '
 
@@ -134,18 +134,18 @@ test_expect_success 'second set of svn commits and rebase' '
 # Check that --preserve-empty-dirs and --placeholder-file flag state
 # stays persistent over multiple invocations.
 test_expect_success 'flag persistence during subsqeuent rebase' '
-	test -f "$GIT_REPO"/7/.placeholder &&
+	test_path_is_file "$GIT_REPO"/7/.placeholder &&
 	test $(find "$GIT_REPO"/7 -type f | wc -l) = "1"
 '
 
 # Check that placeholder files are properly removed when unnecessary,
 # even across multiple invocations.
 test_expect_success 'placeholder list persistence during subsqeuent rebase' '
-	test -f "$GIT_REPO"/1/file1.txt &&
+	test_path_is_file "$GIT_REPO"/1/file1.txt &&
 	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1" &&
 
-	test -f "$GIT_REPO"/5/file1.txt &&
-	test -f "$GIT_REPO"/5/.placeholder &&
+	test_path_is_file "$GIT_REPO"/5/file1.txt &&
+	test_path_is_file "$GIT_REPO"/5/.placeholder &&
 	test $(find "$GIT_REPO"/5 -type f | wc -l) = "2"
 '
 

base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
-- 
gitgitgadget
