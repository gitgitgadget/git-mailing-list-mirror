Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E951CD1E
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260735; cv=none; b=Xs0d38g8NAHmYsMGLeGCQBAIJpMwPhao7gy1T8jDWNyMUpvVsFUtXw/Y19APc+az1wy0wBqtGG2kybyzpmNUOVpJJm9kAfmBbEvFICBvOtpwU3AJshA4nMNZFrARnvR7fk7EdKjOoe9QEpnFofk3gf/sti7ZtXpjpEJQ/agC1Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260735; c=relaxed/simple;
	bh=wJIFueftImMKsRrETiQzXQ7IobLJ/IzSPVEYHc6Rd2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0n7frO5SVSELszIQcvLJh7PlZhlfmtfRm2dL6nUreTab/9F/LPGaLWU5spNaQXyD+rGccFLPJ+MBkDZ22tLjkTOtrjcTQVL0FB1H8WHVWA67fGfId5qrX8rxaj+R/5ZCfbCzPCBe0WQJ8DPoFTCPCwekyTPU11MSM8ViX2ku+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEKtx2yl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEKtx2yl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7881b1843so510615ad.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 15:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707260733; x=1707865533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLozVxFXrI1jwDxjqQa1EeEosMwctfRFjXMDPRUY2sE=;
        b=CEKtx2yl9fp92SA7QfFpW3SoTPlTYmm7iLmqs7TE5Nz7JiSgSF18MJXYH9iJnvcpLo
         YiybxhyJ1FjR2hUVpJpZsw+EM4CnQzjGGQYD/R0CyBUtz0ZvMO8u0Bn1MAdofNYRNGaG
         1OVJr4z/2EY+T/dNeuRuD0GoV648Qy/ANZuequnxk/mILOChRdsLlF3woVoKLmyYH6P/
         gm1vy0GES4LMa7l1sXAM32POm0pbmQ9gOUv25spimyRn8MxZ/5Sj7TJuQCKZPB6KLizv
         5QnOGO0payh+GBGNl70qIx+JaJ1ym72Ofb/i/I+QuzC72DlbqLZsFelNvNKjkfUT0jeM
         umLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260733; x=1707865533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLozVxFXrI1jwDxjqQa1EeEosMwctfRFjXMDPRUY2sE=;
        b=aKwoztdfk9nuVHohpwduvblckmROwbKnATlycGTmmFwHhUR4YT5dCeHLiPGVvod33B
         kspx1fZN2UVZmqOBYhOjvgaHVf6/tThBA2peEzbU0SyBcn9n1cJUv2n3DtqysB8yplBv
         ekr9t3Fi5SFtwoFXe1lRCXF+8OWj2GVSkUohq9bRgvsVZNI2L+LA2cLipiC3VAzy5ThD
         jp7CAuVpYHVC8u0KoFZFTy76o7BsX/HQjBM4hqu/LE/aRzc/qAYrslMVpP7aZBjjgshd
         glYWUdRtcXQ7f2PKSva+D1sBV3IELKeEkHcdlDh0WyaoMuxwg4O05wXRb3J/kLi101IU
         xxQw==
X-Gm-Message-State: AOJu0YznT0IooUBjIEwAlz2Ip1zhdt0EVMTUtUTpgbJ2fW0awFj7A+Xt
	XSUHt5/gEqoV/OKLJXXkp6CuvRK6MT2YheDdQ4ioqd4M1T1Uas6F8CoPcqa6
X-Google-Smtp-Source: AGHT+IHN/Vog5ytrhHN3S/G76ILbG7QuMBkpAdgTSI1DgjfX8uQk5kqZANnvEPGbcla0Z3X9SqMoCA==
X-Received: by 2002:a17:902:744a:b0:1d9:9331:5281 with SMTP id e10-20020a170902744a00b001d993315281mr2826670plt.24.1707260732854;
        Tue, 06 Feb 2024 15:05:32 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170903279800b001d95b3c6259sm49639plb.263.2024.02.06.15.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:05:32 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH] restore: allow --staged on unborn branch
Date: Wed,  7 Feb 2024 04:33:50 +0530
Message-ID: <20240206230357.1097505-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some users expect that being on an unborn branch is similar to having an
empty tree checked out. However, when running "git restore --staged ."
on unborn branch having staged changes, the follwing error gets printed,

    fatal: could not resolve HEAD

Therefore, teach "git restore --staged ." without a source option, to
take empty tree as source on unborn branch. Note that, this assumption
is already taken by "git reset" (166ec2e9). However, still disallow
explicitly referring to HEAD on unborn branch.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/checkout.c        | 27 +++++++++++++++++++-------
 t/t2073-restore-unborn.sh | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 7 deletions(-)
 create mode 100755 t/t2073-restore-unborn.sh

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6e30931b5..1258ae0a59 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1691,6 +1691,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct branch_info *new_branch_info)
 {
 	int parseopt_flags = 0;
+	int unborn_and_unspecified = 0;
 
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
@@ -1754,12 +1755,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
 		BUG("these flags should be non-negative by now");
-	/*
-	 * convenient shortcut: "git restore --staged [--worktree]" equals
-	 * "git restore --staged [--worktree] --source HEAD"
-	 */
-	if (!opts->from_treeish && opts->checkout_index)
-		opts->from_treeish = "HEAD";
 
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
@@ -1785,6 +1780,18 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		opts->new_branch = argv0 + 1;
 	}
 
+	/*
+	 * convenient shortcut: "git restore --staged [--worktree]" equals
+	 * "git restore --staged [--worktree] --source HEAD"
+	 */
+	if (!opts->from_treeish && opts->checkout_index) {
+		struct object_id oid;
+		opts->from_treeish = "HEAD";
+
+		if(repo_get_oid(the_repository, opts->from_treeish, &oid))
+			unborn_and_unspecified = 1;
+	}
+
 	/*
 	 * Extract branch name from command line arguments, so
 	 * all that is left is pathspecs.
@@ -1812,7 +1819,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	} else if (!opts->accept_ref && opts->from_treeish) {
 		struct object_id rev;
 
-		if (repo_get_oid_mb(the_repository, opts->from_treeish, &rev))
+		/*
+		 * when the branch is unborn and no revision is given, use
+		 * empty tree as source
+		 */
+		if(unborn_and_unspecified)
+			oidcpy(&rev, the_hash_algo->empty_tree);
+		else if (repo_get_oid_mb(the_repository, opts->from_treeish, &rev))
 			die(_("could not resolve %s"), opts->from_treeish);
 
 		setup_new_branch_info_and_source_tree(new_branch_info,
diff --git a/t/t2073-restore-unborn.sh b/t/t2073-restore-unborn.sh
new file mode 100755
index 0000000000..fbd8b2df5f
--- /dev/null
+++ b/t/t2073-restore-unborn.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='restore --staged should work on unborn branch'
+. ./test-lib.sh
+
+test_expect_success 'explicitly naming HEAD on unborn should fail' '
+	echo a >foo &&
+	echo b >bar &&
+	git add foo bar &&
+	test_must_fail git restore --staged --source=HEAD .
+'
+
+test_expect_success 'restore --staged .' '
+	rm .git/index &&
+	git add foo bar &&
+	git restore --staged . &&
+	git diff --cached --name-only >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'restore --staged $file' '
+	rm .git/index &&
+	git add foo bar &&
+	git restore --staged foo &&
+	git diff --cached --name-only >actual &&
+	echo bar >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'restore -p --staged' '
+	rm .git/index &&
+	git add foo bar &&
+	test_write_lines y n | git restore -p --staged >output &&
+	git diff --cached --name-only >actual &&
+	echo foo >expected &&
+	test_cmp expected actual &&
+	test_grep "Unstage" output
+'
+
+test_done
-- 
2.43.0

