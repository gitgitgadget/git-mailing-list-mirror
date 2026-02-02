Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0526738D
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049277; cv=none; b=rxlle2Fu5TEGDDG7HSGYOysj4DGjWQxlAKw+W+QRH5Mi+Lh2pXNmxSrve7M94wbnLplNjmiZYLyiAZszbrjrFnYIBJXPVyfuSr7Klu7CZ2nUwSvSPyQysp6nwS5bHUbWUeR4OHMzIJjuEGJq4xYyiQB9+UFP+T8t7oAQ2K3tuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049277; c=relaxed/simple;
	bh=a8mCmuQV89PHML6tBa+t9k7RiqocWhD3MnKHOa5SUa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5jOIHneICLZTT5AsQaBca75Z0dVKj0PunpGVtdOTRSd+XxgynQpiWX0W7iNtlBb0R2F1tj5DVn5muxAJOsw5QVI67F7zq6ojct3h6NAf+7PZIv06fy9jfCWunz2JrbwJr7aN1JyKp40da1mPu7TcAMXmQW8Tna0SoQ79tSL0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYGe0uhT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYGe0uhT"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50334dd44d2so54036411cf.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770049274; x=1770654074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG6Jfk6s6LjCYhL29YpFYzgcTGuPZp7+HiXdjm8I7io=;
        b=fYGe0uhT7Sv4dnfO7p4e+xVHz6ZsX3Hag8n/oRGiEeIJ6osfl5jbHdGHwg1eoxhEmd
         AXFUrNdY4XdwppoonIs12COrV24tuCfHClSBtByElaOBt8GMWjwhVRjrDMEC++HXRkhx
         XRw5eZdGFGKdUzeAMq2QEK3wPynYUrSA/TseyOOVYwGZ9hFc+YtTSnXjsP4rvrKD6ZD8
         mGihaXBE6M4I+4oVyRmyJ/M9BwDrDU0KHPKVreCM1cA3jeKsHmvxIyvlhBt4mX9ip8TO
         Q+kmHEZ/jBwQgZY1yknsoD1AnhQBr4WkoK+c9chjfLHQxQHK9XiJn7cHcb28XLvUi1Vq
         uQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049274; x=1770654074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uG6Jfk6s6LjCYhL29YpFYzgcTGuPZp7+HiXdjm8I7io=;
        b=iIMvCN+OQarrJDjJOvstHasr08I+h8B02EEXfnXOFntBblXrZJZzl9vQsfxo/9P43r
         4bt164eNiTD45Bnd71TFhEuZSaRc+0xsEIEK1Sjsq/Q3Ny+LvcLknsRyupU/B+d+codB
         m/wbOs9K0Lr0HKUJz4kcc4oHsBmQ/8Tphb58RGbSaw+OE8KEVzvRdtqvYyef6sO5lqIR
         nJUC5KhjOLY1PPuoOcnILm6M3g+s+FMNAkzddr0kiIz90t/qZZA3bKb8aEtSlWQLdMBw
         X96MeQURkKN0BaY/Ab1eO78OG6TY9RhrWD6KZbBOLc6jNcU0MKeR4nW3EzopvSK/GqVz
         8AvQ==
X-Gm-Message-State: AOJu0YzF9cpPdULI0rNGouDvdi2KY2lJfCZ8waVNV6Ui1SGOkWGng78H
	raHjzc1+E1JTdrL9HTgRsaCv8z2h81e817UtiRPypuIo8xNNcdbOBymDO30uYVOI
X-Gm-Gg: AZuq6aJ6qQG0Mmiz01CqFUGnZRDFFZ2sebRMwB9+T5DglpD9BNvWTW57KMqxrm1R/zo
	POEsCSy1axWSa4v9G1VNG5a8mghvHgGH7tA1vDISVD2bzwNz+8YPRB8xRwMBkBcd+cHwlSvwWna
	txCJ3mPksRcVypXe7ETo4SGvrl7Y98n4c/qd/0ojtER/g6D+TjYdl6prLLbwipQH6nyX0xK5gub
	dhYwamdZvWT62CRgGXT7ElIFbDAw5pC39vc8ul0ld/NMCSAv9Aw3KTdrNALGQq3o7ALmOOuUqfE
	Gd7S+ovUAS+pFuLXihbjnwlNaL8dP5PXHNUaOFuSFIYQ4CeFwmGczfKH5Ms6yVUsVdPGJPxoeED
	OgjWQfB0Bv4Y8Cmt4EkNT1LTUb2Buc+DM8tL+5qvNQI+5xNsnNPlo/v4VHrbTwkrG/83MhxL1p8
	fKVci4xx7Mes1rTcMjtOLSaOEJyhqR4A==
X-Received: by 2002:a05:622a:1810:b0:4ee:1b0e:861a with SMTP id d75a77b69052e-505d21531a7mr183394081cf.13.1770049274404;
        Mon, 02 Feb 2026 08:21:14 -0800 (PST)
Received: from MAC-XFC3JLX ([130.41.151.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c426sm110096631cf.7.2026.02.02.08.21.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 08:21:13 -0800 (PST)
From: Hoda Salim <hoda.s.salim@gmail.com>
To: git@vger.kernel.org
Cc: HodaSalim <hoda.s.salim@gmail.com>
Subject: [PATCH v2][GSoC] t9160:modernize test path checking
Date: Mon,  2 Feb 2026 18:18:00 +0200
Message-ID: <20260202161759.84355-2-hoda.s.salim@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <pull.2160.git.git.1767625195071.gitgitgadget@gmail.com>
References: <pull.2160.git.git.1767625195071.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: HodaSalim <hoda.s.salim@gmail.com>

Replace old-style path checks with Git's dedicated test helpers:
- test -f → test_path_is_file
- test -d → test_path_is_dir
- test -s → test_file_not_empty

Fix typos with the word "subsequent"

Found using: git grep "test -[efd]" t/

This improves test readability and provides better error messages
when path checks fail.

Signed-off-by: HodaSalim <hoda.s.salim@gmail.com>
---
 t/t9160-git-svn-preserve-empty-dirs.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 36c6b1a12f..de32cf2542 100755
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
 
@@ -133,19 +133,19 @@ test_expect_success 'second set of svn commits and rebase' '
 
 # Check that --preserve-empty-dirs and --placeholder-file flag state
 # stays persistent over multiple invocations.
-test_expect_success 'flag persistence during subsqeuent rebase' '
-	test -f "$GIT_REPO"/7/.placeholder &&
+test_expect_success 'flag persistence during subsequent rebase' '
+	test_path_is_file "$GIT_REPO"/7/.placeholder &&
 	test $(find "$GIT_REPO"/7 -type f | wc -l) = "1"
 '
 
 # Check that placeholder files are properly removed when unnecessary,
 # even across multiple invocations.
-test_expect_success 'placeholder list persistence during subsqeuent rebase' '
-	test -f "$GIT_REPO"/1/file1.txt &&
+test_expect_success 'placeholder list persistence during subsequent rebase' '
+	test_path_is_file "$GIT_REPO"/1/file1.txt &&
 	test $(find "$GIT_REPO"/1 -type f | wc -l) = "1" &&
 
-	test -f "$GIT_REPO"/5/file1.txt &&
-	test -f "$GIT_REPO"/5/.placeholder &&
+	test_path_is_file "$GIT_REPO"/5/file1.txt &&
+	test_path_is_file "$GIT_REPO"/5/.placeholder &&
 	test $(find "$GIT_REPO"/5 -type f | wc -l) = "2"
 '
 
-- 
2.50.1 (Apple Git-155)

