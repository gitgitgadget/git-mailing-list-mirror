Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0629992A
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762241; cv=none; b=oLOFc+KxwUi8w5Yj2bBrn57O22Y/wOp9hVPjVIKHqCcxPqDdNZhRq76ZVrRd3ICbwjnyquDw/JmpXT6mnCdBSiHhKltUTV0/x0XswtGLFIqMwNF//nMF7P9dg9AP0uIIWPVTaR/9m7wctCkrzjMOAWixkMVMJsDnsYUR4FeKjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762241; c=relaxed/simple;
	bh=Jx0+1yNuGPWa2b5zV/MVVBTgIYFmK9MIXCUZm7If8yw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l8Zv2E5N7vablfX6hhAsbUZjcRwOY3U+NrdV0m1BIIAKys+T3duIQ7zr0Q+giI0gNfxCqckPkvcWbYz9yvWW2oHaY2bvUZ++sl3El5mzHehsaIQY+Sney3OP6oi6IUOZcjt93bkTc3b8KQfjMfv8yCgMsEOEiu71fCdx8T/izk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNgl01xm; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNgl01xm"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c15849aa2cso1521654eec.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762239; x=1776367039; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXR6EKUOMRQNkVXe6/pTNC2ezVIYXypTxt68r/jFNis=;
        b=XNgl01xmU8Q8Ro+LZl6CzBNPTlTHb65bygkCOTMDIbhxKt0I3nke8qw3WuchXlJepi
         gkju4JTv8uFt3ySdr9nAKUqFAIcjSPYplfrKqruibO6E+sHbLUw7VTIM26MmCVYMDS8L
         +KBTK2CZ/FPq0HjRC8bURCma2hClULRPnSauV58W/tHS+vxybWc3cWbES6+eCj/+WeND
         oRhZeHyzKcCREY2K1CXKmMyd7FaIwwgLG1M5js1HPfVUlamFvkzXKqhVE8wgnCo8G+GP
         YRYO+dmabu9rkk3WWYD9zZf9tV5EqTrBl/SMQkr3yYuek6ngFLFckUZEdlscuRcfzlE/
         EmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762239; x=1776367039;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mXR6EKUOMRQNkVXe6/pTNC2ezVIYXypTxt68r/jFNis=;
        b=EkHewMgJzLzxyRzYrhwSzqQ1S8LZWKF0CMCW6CFhptqXPTceUVhgvF3jtTNRsy/aoU
         tW6JyRaRIMX7435Q1fnnj1oj9M7v8ZPSnO+4nULQ0GtcnTrRa8N8ojF1DqY1md84tUFu
         XrOlopS2TdRM/LN17wBT2KErw/PQL3xr39AYrc8QWKp8BnQlziejdZLY2gBNIgwBwnUJ
         dG+bSZrz/HbYaF/xV0cC5j8XikXcWGAW5IVqfW4woHxod9S47+t2ebgXPXDkbsvO8SDu
         q93g1uc+wY69/+W1quMU2BRZWJ3FFy2Mdg7UnnZx8KtAwnc78jyfNFFUC2sDaEjZ9Hu5
         ZKrQ==
X-Gm-Message-State: AOJu0Yz0aFENIruICxyix4P1J/qbn6GxpZGLv3Ar7TfhqpRX0WHFBjFp
	nLYaSXr8PTK/oxctHSVGiuOOHF0qF8HaUA2QvJ2fAo77utu6SUnZCSgPYeZULQ==
X-Gm-Gg: AeBDiesMdhbbvvajbrOg3danVMaJRtWyFZU/bqfKuZZ40Dn0lmvKk8mnDsAzJdt4SxQ
	TLOB0WGzVse4/WuxFqsCDPdM5adapbAfEA7k5dqGQAkT+3jmuBVSVHZ+SiV0K5k8sGQy/wgxZDN
	sPO1KIuOPQAWJqYnN7WalhCDb7iNK50c6OKDeEb3nO+OZ2eoGGMeYzFL9dVWy66jl6vUa1UwOgB
	Ll1jIgdDVyDwd1Z6v4ywUvZCX/4viAdpBXcQdLu0TOm+OriiJDr8Bq95wMhrX0MaosHsloKta/P
	sh7G2gsmJF6aZNCYApgfmKVJz+etycOCGvFBALMzIAxmHko+/pBkM/AYabgiSorvoItlWf5LbJk
	RPF1diyynqzbJNyHEnLbsURQrsFnja35zH8tEzutHCb65g/SPeGqr22CFmZVhccOmMc2XftdNBJ
	5Y7kPIxL7MzZa+A0HJmmCxp9Drty9z
X-Received: by 2002:a05:693c:3114:b0:2c6:7f49:a871 with SMTP id 5a478bee46e88-2d58879fdfbmr235013eec.20.1775762238610;
        Thu, 09 Apr 2026 12:17:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm1157233eec.18.2026.04.09.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:17:18 -0700 (PDT)
Message-Id: <8fcf3778205d4742a56ed2e4c3b97defa21a1538.1775762235.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 19:17:12 +0000
Subject: [PATCH v8 1/4] stash: add --ours-label, --theirs-label, --base-label
 for apply
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Allow callers of "git stash apply" to pass custom labels for conflict
markers instead of the default "Updated upstream" and "Stashed changes".
Document the new options and add a test.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-stash.adoc | 11 ++++++++++-
 builtin/stash.c              |  2 +-
 t/t3903-stash.sh             | 37 ++++++++++++++++++++++++++++++++++++
 xdiff/xmerge.c               |  6 +++---
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index b05c990ecd..6829ba1140 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -12,7 +12,7 @@ git stash list [<log-options>]
 git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
 git stash drop [-q | --quiet] [<stash>]
 git stash pop [--index] [-q | --quiet] [<stash>]
-git stash apply [--index] [-q | --quiet] [<stash>]
+git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]
 git stash branch <branchname> [<stash>]
 git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
@@ -195,6 +195,15 @@ the index's ones. However, this can fail, when you have conflicts
 (which are stored in the index, where you therefore can no longer
 apply the changes as they were originally).
 
+`--ours-label=<label>`::
+`--theirs-label=<label>`::
+`--base-label=<label>`::
+	These options are only valid for the `apply` command.
++
+Use the given labels in conflict markers instead of the default
+"Updated upstream", "Stashed changes", and "Stash base".
+`--base-label` only has an effect with merge.conflictStyle=diff3.
+
 `-k`::
 `--keep-index`::
 `--no-keep-index`::
diff --git a/builtin/stash.c b/builtin/stash.c
index 0d27b2fb1f..54bcb6ac73 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -44,7 +44,7 @@
 #define BUILTIN_STASH_POP_USAGE \
 	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
 #define BUILTIN_STASH_APPLY_USAGE \
-	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
+	N_("git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]")
 #define BUILTIN_STASH_BRANCH_USAGE \
 	N_("git stash branch <branchname> [<stash>]")
 #define BUILTIN_STASH_STORE_USAGE \
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..d4e4e4d7b6 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1666,6 +1666,43 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
 	)
 '
 
+test_expect_success 'apply with custom conflict labels' '
+	git init conflict_labels &&
+	(
+		cd conflict_labels &&
+		echo base >file &&
+		git add file &&
+		git commit -m base &&
+		echo stashed >file &&
+		git stash push -m "stashed" &&
+		echo upstream >file &&
+		git add file &&
+		git commit -m upstream &&
+		test_must_fail git -c merge.conflictStyle=diff3 stash apply --ours-label=UP --theirs-label=STASH &&
+		test_grep "^<<<<<<< UP" file &&
+		test_grep "^||||||| Stash base" file &&
+		test_grep "^>>>>>>> STASH" file
+	)
+'
+
+test_expect_success 'apply with empty conflict labels' '
+	git init empty_labels &&
+	(
+		cd empty_labels &&
+		echo base >file &&
+		git add file &&
+		git commit -m base &&
+		echo stashed >file &&
+		git stash push -m "stashed" &&
+		echo upstream >file &&
+		git add file &&
+		git commit -m upstream &&
+		test_must_fail git stash apply --ours-label= --theirs-label= &&
+		test_grep "^<<<<<<<$" file &&
+		test_grep "^>>>>>>>$" file
+	)
+'
+
 test_expect_success 'stash create reports a locked index' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 29dad98c49..659ad4ec97 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -199,9 +199,9 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      int size, int i, int style,
 			      xdmerge_t *m, char *dest, int marker_size)
 {
-	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
-	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
-	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
+	int marker1_size = (name1 && *name1 ? strlen(name1) + 1 : 0);
+	int marker2_size = (name2 && *name2 ? strlen(name2) + 1 : 0);
+	int marker3_size = (name3 && *name3 ? strlen(name3) + 1 : 0);
 	int needs_cr = is_cr_needed(xe1, xe2, m);
 
 	if (marker_size <= 0)
-- 
gitgitgadget

