Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FC26981E
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197802; cv=none; b=nl0wtvBqvtNVyyKJiEBP1IyV+gZOPjWEmG9pnTYhTccveiONtOWfNz9r8rRUBDDtTsWcV81NT8FlPRlBf61gA/EYvAxItZ8gHxCD/k4xsGiUNIgXosSA+jgaMbl0y2sAfz/bLA6gO0j1LVIXn+SpU8MIxkeCIuBEhLeqooFZni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197802; c=relaxed/simple;
	bh=/dd8A/z3rJ/q7pedsRwQVXIQb/+ZPvKoVICo+lwqOWc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I+LFLG3ErDbqXoSDDi8FCGzGFvb5XJ/Ra89sEqWiQu388MEw//XyICGj603L+56uljWESzjDsnDA1eqHu3Vn61o7RKtxFBxMBQNo2zYwOqR2Z2iTNGS4N9PKS6Sl+ENUPueCQcNxCqngzpIWpU4rk+SiuQk/Q3yECXv5IhYtKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPCpHXZO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPCpHXZO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45617887276so37757595e9.2
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753197797; x=1753802597; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QPtUBxOpWfW+8zR0Sj5LoVfRoIebj/OihkbuvawkyA=;
        b=BPCpHXZOcd2Hxp+UhtqwlcQl9jVN3A2yiaK2lh/Dhgakv3g9yEnAQisBQNhLVTdWR1
         tnRYUl2BkKvEHcjjm/NE8zkvGXFTLft7BIVUgDO7qB2e8d2ZW6aKMHvoEEy51WlQ/24M
         DMgCvxV/jUVhMCrEhz2j5+uT9Z/lSLCbUQFa2vgcuV7A36JDwQWEMlnGjJ5efblgDcCD
         IdBuAWUP3gKX9JDL0DqwdedQlJ+1XvxC7zOkvq0tUzZUOvM+u2W6e7+PPxWqFCNRd1bT
         ZyoUuldukD/viEoUdbSbDMmmILnSFCzTMVT/WsG/Boscz+RIBhioQo7SeHoiwUfL2W6n
         HlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197797; x=1753802597;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QPtUBxOpWfW+8zR0Sj5LoVfRoIebj/OihkbuvawkyA=;
        b=J2GAa7NfCgNlT0wvprZKcbUMj/dH+H26EHMi0ZZmKgxJtAbEvON7iZl0iEhzJZFQRH
         7vJhW47trbSAk+MfWBsV3Q263ghSd6w1A06qWSf75Qg6tq3issaDOn1ixfR+O2xTahBj
         tb+VLruYEbQnA2eRZV0wJlOPUzZxh+vYKCBO3v5TNhKzmO1a5xWP4idmeczwuDV4hwov
         NYEuFA2GwXQfO4ZAi368Wbhh0RWg5PiJhFLbCv3p7ga9+Uk/ZtLPmtEO0xto1fPz180V
         BhFYwYs1KhAviODbRvlajZZzTyggMCL0D2tBRrUTjJ3NX7+wLEuBoaPk5DzuARKuYC5f
         DPJw==
X-Gm-Message-State: AOJu0YwZW10wXac4uUAkhOtTFiLGwnHLUjLqRjOzgTP+EbGZhzcb5uTo
	IIYLwVnRbAefUxW1yjYwimQ5WdgFBwQhIjvwVXUYT4U2ime+ENVYbigVs/Hc0g==
X-Gm-Gg: ASbGncvlpKPm+2X2CGOND/A5B/AGeBxFu9MNvqV2IsY7ZVcnUo1HnVEhZw4rQlFE0Ea
	j99aM3RPTNt5bqDiINiEAIOBY7saywCyZkZoqY4EiLKn8t87oJ3Prdaz/w4+bYXk+RhrGFSuRro
	yG+dkZFDECsj5NxncA+/DNzTG6kuEiw9LlBdOPHb8yU4J5GjU5+s0V/FYZ8menyK+a71S+xXIk4
	wnZpcYWCA00zL9SZd/2Bq7YiNZnZWH54Mk75pV4O16X+zxvS8snD/3LO4UuAGnjav5QaQOVMVud
	2EiW1+rhkbEQZqodL+p41E48juLQfF+ZJ6kcoVdQpyfFTXkkRoURLFjjp8oSaSGmA3kRCieHHZr
	AUz89dOxaBtSd/ig2+Fqimostu6jE0Vuidg==
X-Google-Smtp-Source: AGHT+IGw3Gh2KkctWQmA9qTt1IrkfKzW228gT6vRszucb/qz6OR2caUd4ugBXY12O3ygY0y0FdTOiA==
X-Received: by 2002:a05:600c:64cc:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4562e3548acmr249469235e9.11.1753197796776;
        Tue, 22 Jul 2025 08:23:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c87esm191823235e9.33.2025.07.22.08.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:23:16 -0700 (PDT)
Message-Id: <2c7d4e022c59609bf263a7045fceb1854441bb29.1753197791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Jul 2025 15:23:10 +0000
Subject: [PATCH 5/6] merge-ort: fix incorrect file handling
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

We have multiple bugs here -- accidental silent file deletion,
accidental silent file retention for files that should be deleted,
and incorrect number of entries left in the index.

The series merged at commit d3b88be1b450 (Merge branch
'en/merge-dir-rename-corner-case-fix', 2021-07-16) introduced testcase
12i-12k in t6423 which checked for rename-to-self cases, and fixed bugs
that merge-ort and merge-recursive had with these testcases.  At the
time, I noted that merge-ort had one bug for these cases, while
merge-recursive had two.  It turns out that merge-ort did in fact have
another bug, but the "relevant renames" optimizations were masking it.
If we modify testcase 12i from t6423 to modify the file in the commit
that renames it (but only modify it enough that it can still be detected
as a rename), then we can trigger silent deletion of the file.

Tweak testcase 12i slightly to make the file in question have more than
one line in it, but which doesn't change how it operates.  Make this
change to otherwise minimize the changes between this testcase and a new
one that we want to add.  Then duplicate the testcase as 12i2, changing
it so that it adds a single line to the file in question when it is
renamed, as a testcase for this bug.

Further, commit 98a1a00d5301 (t6423: add a testcase causing a failed
assertion in process_renames, 2025-03-06), fixed an issue with
rename-to-self but added a new testcase, 12n, that only checked for
whether the merge ran to completion.  A few commits ago, we modified
this test to check for the number of entries in the index -- but noted
that the number was wrong.  And we also noted a
silently-keep-instead-of-delete bug at the same time in the new testcase
12n2.

Fix to merge-ort to prevent multiple bugs with rename-to-self cases:
  * silent deletion of file expected to be kept (t6423 testcase 12i2)
  * silent retention of file expected to be removed (t6423 testcase 12n2)
  * wrong number of extries left in the index (t6423 testcase 12n)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 11 +++++
 t/t6423-merge-rename-directories.sh | 69 +++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9b9d82ed10f7..feb06720c7e1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2873,6 +2873,17 @@ static int process_renames(struct merge_options *opt,
 			newinfo = new_ent->value;
 		}
 
+		/*
+		 * Directory renames can result in rename-to-self, which we
+		 * want to skip so we don't mark oldpath for deletion.
+		 *
+		 * Note that we can avoid strcmp here because of prior
+		 * diligence in apply_directory_rename_modifications() to
+		 * ensure we reused existing paths from opt->priv->paths.
+		 */
+		if (oldpath == newpath)
+			continue;
+
 		/*
 		 * If pair->one->path isn't in opt->priv->paths, that means
 		 * that either directory rename detection removed that
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index c2032eb6cfa1..6611331769e9 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4731,7 +4731,7 @@ test_setup_12i () {
 
 		mkdir -p source/subdir &&
 		echo foo >source/subdir/foo &&
-		echo bar >source/bar &&
+		printf "%d\n" 1 2 3 4 5 6 7 >source/bar &&
 		echo baz >source/baz &&
 		git add source &&
 		git commit -m orig &&
@@ -4778,6 +4778,69 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 	)
 '
 
+# Testcase 12i2, Identical to 12i except that source/subdir/bar modified on unrenamed side
+#   Commit O: source/{subdir/foo, bar, baz_1}
+#   Commit A: source/{foo, bar_2, baz_1}
+#   Commit B: source/{subdir/{foo, bar}, baz_2}
+#   Expected: source/{foo, bar, baz_2}, with conflicts on
+#                source/bar vs. source/subdir/bar
+
+test_setup_12i2 () {
+	git init 12i2 &&
+	(
+		cd 12i2 &&
+
+		mkdir -p source/subdir &&
+		echo foo >source/subdir/foo &&
+		printf "%d\n" 1 2 3 4 5 6 7 >source/bar &&
+		echo baz >source/baz &&
+		git add source &&
+		git commit -m orig &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv source/subdir/foo source/foo &&
+		echo 8 >> source/bar &&
+		git add source/bar &&
+		git commit -m A &&
+
+		git switch B &&
+		git mv source/bar source/subdir/bar &&
+		echo more baz >>source/baz &&
+		git add source/baz &&
+		git commit -m B
+	)
+}
+
+test_expect_success '12i2: Directory rename causes rename-to-self' '
+	test_setup_12i2 &&
+	(
+		cd 12i2 &&
+
+		git checkout A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
+
+		test_path_is_missing source/subdir &&
+		test_path_is_file source/bar &&
+		test_path_is_file source/baz &&
+
+		git ls-files >actual &&
+		uniq <actual >tracked &&
+		test_line_count = 3 tracked &&
+
+		git status --porcelain -uno >actual &&
+		cat >expect <<-\EOF &&
+		UU source/bar
+		M  source/baz
+		EOF
+		test_cmp expect actual
+	)
+'
+
 # Testcase 12j, Directory rename to root causes rename-to-self
 #   Commit O: {subdir/foo, bar, baz_1}
 #   Commit A: {foo, bar, baz_1}
@@ -5106,7 +5169,7 @@ test_setup_12n () {
 	)
 }
 
-test_expect_failure '12n: Directory rename transitively makes rename back to self' '
+test_expect_success '12n: Directory rename transitively makes rename back to self' '
 	test_setup_12n &&
 	(
 		cd 12n &&
@@ -5166,7 +5229,7 @@ test_setup_12n2 () {
 	)
 }
 
-test_expect_failure '12n2: Directory rename transitively makes rename back to self' '
+test_expect_success '12n2: Directory rename transitively makes rename back to self' '
 	test_setup_12n2 &&
 	(
 		cd 12n2 &&
-- 
gitgitgadget

