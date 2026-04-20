Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969D3845DB
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776724220; cv=none; b=invJjVu82HrXZo/xSP2YY6fQrL741Ljd5f1OKd9yHcE4sUXIiDT0l6D1enwYxfsMdzQrnYcsjqM6NqQ+9xpg61vit9A4EWMomg3dWkmOFrYHhACT3og8N3U0wRlRGfQPbf2nyj6M6pVK/zkXNx3flgS5NiSWbNEvedxZCnndeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776724220; c=relaxed/simple;
	bh=g8VtRbHn8XZaPxaIMmAqwER1DZneIY5Rt48ku043rRI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cU6nDNHOC3u6lR5luFHqqPq86NkNhKT9da1rdoFlRalJc3f/GMvFsvx+fgx0ZKVBPoKh7OyTgO4269ffCJb0y7eBJtlSKWiLuJ+7uQG3AqK0zWnmFlPhn15VOxgwv7pqxzeAbZZmTNjpt0jUcuhkI64M8bgd9y1cK2nRsFp8s0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le3y6QyL; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le3y6QyL"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so394268785a.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776724217; x=1777329017; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qk8pT2EIJmXh2TzzVHhImtDILWVU1/1yOolCZbTujNE=;
        b=Le3y6QyLiRHRn1nFB7zq3WbpcNjNXvH4eN9aYWdtA6PHOC+eg3FIyt8QHg5TD8zlWL
         F62O0Fi88cQeSsMIR/eRGu8IP98MqdfEI4T3A/qo4RCEJQlffWls7l6/oaEdNE3NZ/Su
         gBT/9c7EqqDJfEhRifIobuKkYfvaQxVQIPOMqu2vqABdLXRg+ffby/7lphumKW+IvLoK
         UB9oXTZe+oofrXujGt0dEIeWx5k/1floVVxsZGKafsWeLG164/3i7s4lFOQdFhHPkFk6
         r9Wip/JJvO9TslyhV/XU43P2NyHRSAXIuEBsGJuGC1w2JsS86bI38DSf+P9OZrs5Qi6l
         OoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776724217; x=1777329017;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk8pT2EIJmXh2TzzVHhImtDILWVU1/1yOolCZbTujNE=;
        b=rU9uOuYsfBUsuGDpmJaf3wsNpHQQtoIoKA9mWkyC2BknLQQT4RJYI2lRrrYDRsyo0o
         ha1tZW9cTubpfCt8fqlrq25HDABIQsQefC5Bdel4TevQRFciODr9eVEYsJT+mH6vaDuQ
         /ZY/WH3AVTAnXRIzYfiLAysp6dtl1NhRQdIllG145aE9NKglpKYQIr/eT2maDxP8WB4g
         JHldzj6q4+86ymEqu7lDlhehukW2bNpaQm1RfWwAaaeG8GShcEivedGvY7AH80Fkt62m
         nO4g8nRUy41z75PnKTnhsIjPpBKeJMsl6nZCAqgtTd25qdKB5d03lewsDkJ79pfTnPZ9
         47Ig==
X-Gm-Message-State: AOJu0YxsqFypFJFtNbScpjsh4z7kMzuEP1i5PEV5xYb3z28DkYBcYXRi
	5WVgc9NNI6Yikl+ShurcqCjrGXn5flDwZfdWKUdq8GfEayc2h/vSsobAXGL5GA==
X-Gm-Gg: AeBDiesXdFZE44XDtESkDb6V7JBClOp4467/Fv8LM5OC9EYyaUXKB+8G0x6VxbFRjKE
	S3ElIyJnGEPTiqqK+LymeWPhUOcGO72mBkFVHpi3BTPqVVJA+Q9QycWimSQP7EQSmYA9xoaqEUD
	/WYIAFii7ycglocbO9CKEQtYczWkYRpys8kYOj8q/bbnak8Zzy4j4Hx+LePs6wWW293X22pEOgS
	XQ3sp3BRKh9Sds9EgasWEt3tAkB/wwsXhi72vrQDmHqU3q1yRujdBaALaQtCXSGzthHh1xJcjGH
	VPOunmaZBj2oKt8p0G7gNWoKRGxx7T3mLN9J+JM4e2dSuIcV2mLS1HLYvn7CfgNuqJLNBXLiwdS
	H7jbbM1Si4BQ+Ge6x772FLoBoSErOljCJLavP/odlhCf3O0TcZ+zU6THpOLfmsTvjvK0+kMVrkg
	RHfwBOqAiI32V+DAaZPNSwBz3Kpm0FW0YCPRDEsA==
X-Received: by 2002:a05:620a:4623:b0:8cb:62c3:3690 with SMTP id af79cd13be357-8e78f443268mr2203123785a.13.1776724216801;
        Mon, 20 Apr 2026 15:30:16 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ee585e9fcdsm27589285a.16.2026.04.20.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 15:30:15 -0700 (PDT)
Message-Id: <pull.2095.git.1776724214171.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Apr 2026 22:30:14 +0000
Subject: [PATCH] merge-ort: handle cached rename & trivial resolution
 interaction better
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

Back in commit a562d90a350d (merge-ort: fix failing merges in special
corner case, 2025-11-03), we hit a rename assertion due to a trivial
directory resolution affecting the parent of a cached rename.  Since
the path didn't need to be considered, we side-stepped it with

   if (!newinfo)
     continue;

in process_renames().  We have since run into a case in production
where a trivial resolution of a file affects the direct target of a
cached rename rather than a parent directory of it.  Add a testcase
demonstrating this additional case.

Now, if we were to follow the lead of commit a562d90a350d, we could
resolve this alternate case with an extra condition on the above if:

   if (!newinfo || newinfo->merged.clean)
     continue;

However, if we had done that earlier, we would have made 979ee83e8a90
(merge-ort: fix corner case recursive submodule/directory conflict
handling, 2025-12-29) harder to find and fix, and this particular
position for this condition isn't actually at the root of the issue
but downstream from it.

Instead, let's rip out this if-check from a562d90a350d and put in an
alternative that more directly addresses trivially resolved paths that
happen to be cached renames or parent directories thereof, which is a
better fix for the original testcase and which also solves the newly
added testcase as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: handle cached rename & trivial resolution interaction better
    
    Longstanding bug discovered recently.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2095%2Fnewren%2Fbetter-cache-rename-trivial-resolution-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2095/newren/better-cache-rename-trivial-resolution-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2095

 merge-ort.c                              | 48 +++++++++----------
 t/t6429-merge-sequence-rename-caching.sh | 60 ++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 00923ce3cd..544be9e466 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2953,32 +2953,6 @@ static int process_renames(struct merge_options *opt,
 		if (!oldinfo || oldinfo->merged.clean)
 			continue;
 
-		/*
-		 * Rename caching from a previous commit might give us an
-		 * irrelevant rename for the current commit.
-		 *
-		 * Imagine:
-		 *     foo/A -> bar/A
-		 * was a cached rename for the upstream side from the
-		 * previous commit (without the directories being renamed),
-		 * but the next commit being replayed
-		 *     * does NOT add or delete files
-		 *     * does NOT have directory renames
-		 *     * does NOT modify any files under bar/
-		 *     * does NOT modify foo/A
-		 *     * DOES modify other files under foo/ (otherwise the
-		 *       !oldinfo check above would have already exited for
-		 *       us)
-		 * In such a case, our trivial directory resolution will
-		 * have already merged bar/, and our attempt to process
-		 * the cached
-		 *     foo/A -> bar/A
-		 * would be counterproductive, and lack the necessary
-		 * information anyway.  Skip such renames.
-		 */
-		if (!newinfo)
-			continue;
-
 		/*
 		 * diff_filepairs have copies of pathnames, thus we have to
 		 * use standard 'strcmp()' (negated) instead of '=='.
@@ -3329,6 +3303,28 @@ static void use_cached_pairs(struct merge_options *opt,
 		if (!new_name)
 			new_name = old_name;
 
+		/*
+		 * If this is a rename and the target path is either
+		 * absent from opt->priv->paths (because a parent
+		 * directory was trivially resolved) or already cleanly
+		 * resolved (e.g. all three sides agree on its content),
+		 * the cached rename is irrelevant for this commit.
+		 * Skip it here rather than in process_renames() to
+		 * preserve VERIFY_CI(newinfo)'s ability to catch bugs
+		 * for non-cached renames (see 979ee83e8a90 (merge-ort:
+		 * fix corner case recursive submodule/directory conflict
+		 * handling, 2025-12-29) for an example of a bug that
+		 * assertion caught).  The rename remains in cached_pairs
+		 * for use in subsequent commits.
+		 */
+		if (entry->value) {
+			struct merged_info *mi;
+
+			mi = strmap_get(&opt->priv->paths, new_name);
+			if (!mi || mi->clean)
+				continue;
+		}
+
 		/*
 		 * cached_pairs has *copies* of old_name and new_name,
 		 * because it has to persist across merges.  Since
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 15dd2d94b7..56ee968989 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -846,4 +846,64 @@ test_expect_success 'rename a file, use it on first pick, but irrelevant on seco
 	)
 '
 
+#
+# In the following testcase:
+#   Base:     subdir/file_1
+#   Upstream: file_1         (renamed from subdir/file)
+#   Topic_1:  subdir/file_2  (modified subdir/file)
+#   Topic_2:  subdir/file_2, file_2  (added another "file" with same contents)
+#   Topic_3:  file_2         (deleted subdir/file)
+#
+#
+# This testcase presents no problems for git traditionally, but the fact that
+#    subdir/file -> file
+# gets cached after the first pick presents a problem for the third commit
+# to be replayed, because file has contents file_2 on all three sides and
+# is thus trivially resolved early.  The point of renames is to allow us to
+# three-way merge contents across multiple filenames, but if the target is
+# already resolved, we risk throwing an assertion.  Verify that the code
+# correctly drops the irrelevant rename in order to avoid hitting that
+# assertion.
+#
+test_expect_success 'cached rename does not assert on trivially clean target' '
+	git init cached-rename-trivially-clean-target &&
+	(
+		cd cached-rename-trivially-clean-target &&
+
+		mkdir subdir &&
+		printf "%s\n" 1 2 3 >subdir/file &&
+		git add subdir/file &&
+		git commit -m orig &&
+
+		git branch upstream &&
+		git branch topic &&
+
+		git switch upstream &&
+		git mv subdir/file file &&
+		git commit -m "rename subdir/file to file" &&
+
+		git switch topic &&
+
+		echo 4 >>subdir/file &&
+		git add subdir/file &&
+		git commit -m "modify subdir/file" &&
+
+		cp subdir/file file &&
+		git add file &&
+		git commit -m "copy subdir/file to file" &&
+
+		git rm subdir/file &&
+		git commit -m "delete subdir/file" &&
+
+		git switch upstream &&
+		git replay --onto HEAD upstream..topic &&
+		git checkout topic &&
+
+		git ls-files >tracked-files &&
+		test_line_count = 1 tracked-files &&
+		printf "%s\n" 1 2 3 4 >expect &&
+		test_cmp expect file
+	)
+'
+
 test_done

base-commit: e8955061076952cc5eab0300424fc48b601fe12d
-- 
gitgitgadget
