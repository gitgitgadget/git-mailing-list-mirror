Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7F307AF6
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274380; cv=none; b=Ce2gspllF9JW4jNih995WhKPYe1n9OaXWle5fQ2MwWBXMfdffC7QIBNTMf0cBRj3wpkSRoVDNTGYElRhKDcMuAmheYgGD8aj8+worBNgiV1n/ENUPWmGA6KHBIjdlxLGjD9Kro4/uEWsqopJA1Bgjrx34Rp28AVEzpVZ9fTxzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274380; c=relaxed/simple;
	bh=7bu2IQIlMpZz9Kqe1anGsXa8JDYI4At0Wll6JNfyNBQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qQk5laXrX1JqhwF5yIMzFawr+9ZsoyI58hgtuWyjzZ7sw0KY8uzf9uMIzcGGjfiqgYkMpFBuRtua2GPPW/X/lf63x6mypAenBgqwQ9LpeBYubI4KuTKYy0Neu07JSEsaM2HVKxy2+iBicrtiWKAYmSQrX7Dgrm13Zy3i3SGyR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOlq9v7n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOlq9v7n"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so10914275e9.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755274376; x=1755879176; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsx6rxOUIcfpFdZZGX/ra97tF8txrv+EKs8kg2P3M/U=;
        b=OOlq9v7nUNfdu+sJW9+xos5Qict4yMTYUWkFiExYH578EXWaa4qkIrf+6IiOwHORph
         D42bEIhuC3L3/PRP1UUsDbDwQU4uu+VbvUwRaotGQTTG5RRZXwhGE9ZAMpaYC7SAeLdH
         4vjBYVhdVC1I0VH/NvXzcDXuIKnsZtQJNIL9+9B0WlqubcQ75FMLoGI9HpThXcibCjKc
         DLh8lZ33pvrW20Qjcl/vvK80dGOaXY4BEAdOlrkhd4KFL5bGrut0S8OR5ESDSoruikoM
         O60Ub+fJrXNviE59bTNdnFY+Q/y2sUuYTkpDvwB8sk/hJHYTvgn8WTKjDDssix42JOav
         g8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274376; x=1755879176;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsx6rxOUIcfpFdZZGX/ra97tF8txrv+EKs8kg2P3M/U=;
        b=ZYrKERz+t4cn7PnblBlzZOH8Tqi6wYQnGHZixeoHV0wQ6QzUyz4LPJ3UFNWA3T+jNm
         MVywy2GPulK0lGWYYvyYA0ijdrwZJ5zjoM14dHwVO/iKDE1kERSwxAUXW0jheB6lLaIR
         HaXEOfPMELketJbeFK7BM/3y94XkGUtRb2KfbRJIgsRk6TK/1AA0CT/Z16IBXTykEXeL
         P5XjqROFAL3hpSmTtZ2gAJMtnlVUBuEjniIkMvj5aF1+WbnUSj+/zUgpx/+xXEJUHeIQ
         jqwG07kWaX3HO4/Cb5l233GVDdUeamU/Q46/Hgqt86k01QsLo4rxcJ8ANIkd7hV4A3Pi
         PI1g==
X-Gm-Message-State: AOJu0YzmgDt/YZJ5S+5CYrPy6P+3mZTg2kaqnLBfm8+m+l/uASytMmgL
	JehsAn09Sfokh1+f34L+Xpmib4IsiVRf+f8o1ylr/of9dGrxLkn28rbfgdsewQ==
X-Gm-Gg: ASbGncvTnCgMBALi7u64QJs52xrqTyo6x7vPVtBF0JsPNSjiEC2eJgjBn6LMGpCWI6k
	ciRKuNUxIc7Du9LfhiNZaRBjYkSwhYZwJavQ2K9QFujIcZywMuXEac/X/cAfRQRu3UAJ5+tstN9
	zGVWCy0/xdbQv3jgchLtTihFoh5E3g4OKE8/ccpSKdEZ6OyVQ0DzNelPabU6BcNgtHZSitr+B6S
	8gC0OyGIbS47asjtOv2XkOS0I0HgKut/7VAbulcpJARGnPQnvL7YecJBzv6yNVZrDeJctRX4rAd
	Lq5A8aSO1VY83iKLwqjAWuUB76zdK9+fQlfUUUE/b77chz2JANccqJG3UC5vHNfmt9UPJC0IMeV
	JXLSdQR6erqFVKUUEArvR41Cf2h8q75fsQw==
X-Google-Smtp-Source: AGHT+IGfxvEeO4MsOhRhw4O9uGRPxESRiaW2b2XDd9ztfdpdfQ32fRh8t3dXSY4Pby5z2hecoQhziw==
X-Received: by 2002:a05:600c:c8a:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-45a2181d555mr23659365e9.21.1755274375694;
        Fri, 15 Aug 2025 09:12:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b7f6e36sm37207525e9.4.2025.08.15.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:12:55 -0700 (PDT)
Message-Id: <pull.1955.git.1755274373717.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 16:12:53 +0000
Subject: [PATCH] ls-files: conditionally leave index sparse
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When running 'git ls-files' with a pathspec, the index entries get
filtered according to that pathspec before iterating over them in
show_files().  In 78087097b8 (ls-files: add --sparse option,
2021-12-22), this iteration was prefixed with a check for the '--sparse'
option which allows the command to output directory entries; this
created a pre-loop call to ensure_full_index().

However, when a user runs 'git ls-files' where the pathspec matches
directories that are recursively matched in the sparse-checkout, there
are not any sparse directories that match the pathspec so they would not
be written to the output. The expansion in this case is just a
performance drop for no behavior difference.

Replace this global check to expand the index with a check inside the
loop for a matched sparse directory. If we see one, then expand the
index and continue from the current location. This is safe since the
previous entries in the index did not have any sparse directories and
thus would remain stable in this expansion.

A test in t1092 confirms that this changes the behavior.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    ls-files: conditionally leave index sparse
    
    Here's a small sparse index performance update based on a user report.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1955%2Fderrickstolee%2Fls-files-sparse-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1955/derrickstolee/ls-files-sparse-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1955

 builtin/ls-files.c                       | 13 ++++++++++---
 t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c06a6f33e41..b148607f7a1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -414,14 +414,21 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 	if (!(show_cached || show_stage || show_deleted || show_modified))
 		return;
 
-	if (!show_sparse_dirs)
-		ensure_full_index(repo->index);
-
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
 		int stat_err;
 
+		if (S_ISSPARSEDIR(ce->ce_mode) && !show_sparse_dirs) {
+			/*
+			 * This is the first time we've hit a sparse dir,
+			 * so expansion will leave the first 'i' entries
+			 * alone.
+			 */
+			ensure_full_index(repo->index);
+			ce = repo->index->cache[i];
+		}
+
 		construct_fullname(&fullname, repo, ce);
 
 		if ((dir->flags & DIR_SHOW_IGNORED) &&
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d8101139b40..b0f691c151a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1506,6 +1506,8 @@ test_expect_success 'sparse-index is not expanded' '
 	ensure_not_expanded reset --hard &&
 	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1 &&
 
+	ensure_not_expanded ls-files deep/deeper1 &&
+
 	echo >>sparse-index/README.md &&
 	ensure_not_expanded add -A &&
 	echo >>sparse-index/extra.txt &&
@@ -1607,6 +1609,17 @@ test_expect_success 'describe tested on all' '
 	test_all_match git describe --dirty
 '
 
+test_expect_success 'ls-files filtering and expansion' '
+	init_repos &&
+
+	# This filtering will hit a sparse directory midway
+	# through the iteration.
+	test_all_match git ls-files deep &&
+
+	# This pathspec will filter the index to only a sparse
+	# directory.
+	test_all_match git ls-files folder1
+'
 
 test_expect_success 'sparse-index is not expanded: describe' '
 	init_repos &&

base-commit: 724518f3884d8707c5f51428ba98c115818229b8
-- 
gitgitgadget
