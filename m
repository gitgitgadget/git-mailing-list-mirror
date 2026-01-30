Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09022F7ACA
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790576; cv=none; b=Jib9sf7t78G7hufE0/8WCGWoZ7dGUikMGCfcr7s22AICkPVUzahZRZfbKz48FxGUix/VSRu/oiWw5P4uah5yHev6nsY4Ob6tY7+4HeauNYpDCA0TcuJ4iC020rmKnNxf1qKjZgV4v25U+YJjsvnQzsD3y2FeNP022lLfVL18++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790576; c=relaxed/simple;
	bh=NSoZqE6HKO4af9aojkOqKXy3teb4/i+E2hlq3x5WBF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mswnT7ZMDVSw6/FtB41kDY/hXXN2JCZFcM2iVsPX9AnvvwfTC/y3CAuaQZxmkRLrRIlK0WwnWUFvq8bNbDa8+wabghecPKQAkB3Rmah9YKftDLC40bMF7R6I8HHxnEhe8QMq/YCCg+0wo/l+sRM8ekq2P8V63kqdMlG2L66HbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN7LAL/m; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN7LAL/m"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a8980c848eso1029515ad.2
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 08:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769790574; x=1770395374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLtylTwvl66vM7LK6Kpjv4sl6n/tkto11yIjWHI/s3M=;
        b=HN7LAL/mOw37H2hxVMsQ9KcnsCtqqsAIxMU69w+sWccZgNUfdgyh3VuowBVfNP6p9/
         LECWYIMxXz/uCySNHBxdI4E/Db4khpjMDvU2UZneqJWFNGm2X6dOQ5lXfcuaN1JFypVi
         XHcHHCNAalZ5ttJhDBEyzyC577+tgMvgQxMmZV8ICf2VWD43G73CSjRRT7yKz3Q8AduV
         d/puVbHbkd+1iWsLhdZRXunZJ89Uq4qyQyWp4Dh0UOzvBVkonF7Y4zd10Ailg1Kgsb+V
         mTzCjkHiD+NjoylaA3A2W+2qdISI7h1PmFn6MvVNRgydV/VJZF5zxB4VBpl7ECA0ckEk
         7XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769790574; x=1770395374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLtylTwvl66vM7LK6Kpjv4sl6n/tkto11yIjWHI/s3M=;
        b=E3Hx7fQ4tkE8zcEk/ZtZQsb5pRGBuM0sJp75Y6MHj1vJEImCkL6Hma1FDfjmI7MVPF
         FxRiu6MsUxpZ8QcmIBMhXs2h8LXLqac60Di0v9GJlunCdiB30hQlNSbrhHQeqI59L8V3
         fTwTWuR2Fg9o8E91p5kZb6MnvkPO9ZnXPlbFPBH9J4ggTaUJBAFGe+j0mTXwXT87KkCQ
         KRHZqgj2DSE8+hRFJ0P+yxzK68sp9Rq7W0jcUvxqoj3dWpO10ErTNn5s1GF5bthpc69d
         QYHHq13BapKWQPdKm+Gy9rpbTreAAeq6mu7tOOFTkjWu0IfCUbC1iwmTrjgn3iBz3LvI
         odgA==
X-Gm-Message-State: AOJu0YxMLzgyFRALbrR0u/r4Erdu27xxwxUkezPQkY6vQ5rrFyzewRmH
	4cxuSu1Iqamlk4DNEI6PoWKxUDklCgnJPEBr9ZqYoNZD+a0pa7JiC/tIKsFanx3u7yk=
X-Gm-Gg: AZuq6aIPX1Oh27W/GzvVgPLbGCAD9IcWtex2goD6Ks9Dq8kFoQjZyG5vt3x8MCu52W4
	reaVo+3qNwKsJPI8BdcZHow+LBKXcvWYfuS5ha3/UiAoj8azM8I4tno6LK6un77rhIYpoWvTzQv
	9GKKmIJV8xT/yrbqU5kFuPUBeENvjYSkg2RVBU4WO9RWf4w1mFxMJ2F/LmWTtGOqAGM1bDoJF3d
	MIr4XnHU9w5Hv5hA88qvhQI8wG1GphS6/83PLBszab7JE7/evf0s45EqV1pkB052h/XNcCAyPHU
	/RX3uruY1pGqnjlAwkYxs+DSBtHyY23p0GJmlD3xjj//jX9N17ILioSZNdIxJk2cc9jfnfz99Ty
	NKKvChX8mkbuDAEyhlHbnqLKEJQN0xgZYe/1vx1A9ahaUeFhwuYxQM2BQwuOTlD9xMeF2iYMBpp
	3kdqJDTmFQfynJosAwpbcjgzn40Jw=
X-Received: by 2002:a17:903:32cd:b0:2a7:9b6e:33db with SMTP id d9443c01a7336-2a8d82045edmr28179705ad.7.1769790573626;
        Fri, 30 Jan 2026 08:29:33 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b426ae4sm78764425ad.43.2026.01.30.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:29:33 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	j6t@kdbg.org,
	phillip.wood123@gmail.com
Subject: [PATCH v3] t/perf/p3400: speed up setup using fast-import
Date: Sat, 31 Jan 2026 00:29:27 +0800
Message-ID: <20260130162927.638672-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128160717.611391-1-a3205153416@gmail.com>
References: <20260128160717.611391-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setup phase in 't/perf/p3400-rebase.sh' generates 100 commits to
simulate a noisy history. It currently uses a shell loop that invokes
'git add', 'git commit', 'test_seq', and 'sort' in each iteration.
This incurs significant overhead due to repeated process spawning.

Optimize the setup by using 'git fast-import' to generate the commit
history in a single stream. Additionally, pre-compute the forward and
reversed file contents to avoid repetitive execution of 'seq' and 'sort'.

To ensure the test measures rebase performance against a consistent
object layout (rather than the suboptimal pack/loose objects created
by the raw import), perform a full repack (`git repack -a -d`) at the
end of the setup.

This reduces the setup time significantly while maintaining the validity
of the subsequent performance tests.

Performance enhancement (Average value of 5 tests):
           Real        Rebase
  Before: 29.045s      13.34s
  After:  22.431s      12.98s

Measured on Lenovo Yoga 2020, Ubuntu 24.04.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---

Changes since v2:
- Optimized `content_rev` generation by sorting `content_fwd` directly (Johannes Sixt).
- Used `test_tick` and standard `$GIT_COMMITTER_*` variables for consistency (Phillip Wood).
- Fixed typo "reversed" -> "reverse" to match original test (Phillip Wood).
- Added "done" command and used `git fast-import --done` to prevent errors in the loop being ignored by the pipe (Phillip Wood).

 t/perf/p3400-rebase.sh | 56 ++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index e6b0277729..6bb58282d6 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -9,25 +9,49 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
 	git checkout -f -B base &&
 	git checkout -B to-rebase &&
 	git checkout -B upstream &&
-	for i in $(test_seq 100)
-	do
-		# simulate huge diffs
-		echo change$i >unrelated-file$i &&
-		test_seq 1000 >>unrelated-file$i &&
-		git add unrelated-file$i &&
-		test_tick &&
-		git commit -m commit$i unrelated-file$i &&
-		echo change$i >unrelated-file$i &&
-		test_seq 1000 | sort -nr >>unrelated-file$i &&
-		git add unrelated-file$i &&
-		test_tick &&
-		git commit -m commit$i-reverse unrelated-file$i ||
-		return 1
-	done &&
+
+	test_seq 1000 >content_fwd &&
+	sort -nr content_fwd >content_rev &&
+
+	(
+		for i in $(test_seq 100)
+		do
+			test_tick &&
+			echo "commit refs/heads/upstream" &&
+			echo "committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
+			echo "data <<EOF" &&
+			echo "commit$i" &&
+			echo "EOF" &&
+			
+			if test "$i" = 1; then
+				echo "from refs/heads/upstream^0"
+			fi &&
+
+			echo "M 100644 inline unrelated-file$i" &&
+			echo "data <<EOF" &&
+			echo "change$i" &&
+			cat content_fwd &&
+			echo "EOF" &&
+
+			echo "commit refs/heads/upstream" &&
+			echo "committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
+			echo "data <<EOF" &&
+			echo "commit$i-reverse" &&
+			echo "EOF" &&
+			echo "M 100644 inline unrelated-file$i" &&
+			echo "data <<EOF" &&
+			echo "change$i" &&
+			cat content_rev &&
+			echo "EOF" || return 1
+		done &&
+		echo "done"
+	) | git fast-import --done &&
+
+	git repack -a -d &&
+	git checkout -f upstream &&
 	git checkout to-rebase &&
 	test_commit our-patch interesting-file
 '
-
 test_perf 'rebase on top of a lot of unrelated changes' '
 	git rebase --onto upstream HEAD^ &&
 	git rebase --onto base HEAD^
-- 
2.43.0

