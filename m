Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68643B3DB
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951362; cv=none; b=dH7tHFZUwMSov6PmBZbh3ciBdX8PztEE/Le4WYxO/az/VypDOmq9PKH5HMwmCqeenPvLG2oeTRo3IB/f754DX/p8CcJXkXswKLdJiOJepF+qJi3haOFamL87jyFliIvYlQclhGr4n4TGYDn5AxBks8q46zpMjuDPSKDKS2HuKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951362; c=relaxed/simple;
	bh=lq58gOSiBNZ6RBj+QVSE8ZG4/ffMfAudM8yRCHeHuFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xc/Z0kUFCwn6zXwquCoGlMAJViUm5XA+usgEj/BIYQUYXsI9gzUqVsB+kAVJJiuZjrSgVVyrURF1mAAROyOiUY14cJGgX2r6XAdE1YA1YkvY2y6hUPPeIqYGuTR73oAxZeyw20Wu1QJMHoSKMOQgqHPoTqiMzDA1lsIW8HDYQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBq33YOT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBq33YOT"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so2314521a12.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951361; x=1784556161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3pISDEew1EQhBb7L9Ud1J6yQ6j23VMjHYkme6H5rqo=;
        b=RBq33YOT6RBZa6BifnVXtSFIHcDc8o5EnKpK108umh+CfQE8GVYOTlWsO1Sz7tc66q
         bfpR0DZ/3/H+sH39cI4OlzxKpTpFm59Gkz7Fmr3ZDWxAfAuqf3O4EivsaJy6hWyBrD4o
         6oLau9pbONjAVc9S8nfJgA/BKlJmcwPLGfLNtYfS2T4ezpV1Cp9ufNaJNtNyeBIgseTx
         eLeknhBeWMiS5BDFD9HJZcex7rsYzGB/LEPQshaFx6oYs4S71S4UewIGmH9zVGbMbuSJ
         KVGlSPK4wDZYzUUR20JfY82f5uG/KoSoEhcinm7o8itGV2e1Nafhm/NVsFUozW2+jvHE
         UPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951361; x=1784556161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3pISDEew1EQhBb7L9Ud1J6yQ6j23VMjHYkme6H5rqo=;
        b=Hs12A5/iWtWWSMAF/eFTZJSRntEL7co/0qMa3AxDPgsLpowzvXf+b70IGd6Mwpbr1f
         RfTeMLtHqDxGno1s2K0Ig+aU6OMo2XjrBdRT2VOU1sGhPPNHfRlWGzbp3toPwVgyzJYa
         Lz1nx05zTkCVX7Jjay5m8mdqHHvnvS5UgVk8neKyLHu5Z/rfe0diNUS39NCzqjNPHOsZ
         vt+qg6Chy181uBSELY8hY2OWjqBPq4dRqqrdaHPBF71eRChYcTPXIRjJeSp5Y2c3G4mT
         nSxBbJMOUQJbFNwbX0w5WF5RmQxMgVtP8oA1VVfK3tznrjpBf4IQEzgzcZiN72VvcXjX
         qnmw==
X-Gm-Message-State: AOJu0YzopOK5HBIaEiawfjV79dgXMxIWoPwfvSXNxIW4OcI6Nhb4xajP
	Uxsd9fDAJA/xw5fiZZPjvYFAlHYbOAVQ2+wb4Ya2mcHQLSnTUZyAsj0a6pC8HiwG
X-Gm-Gg: AfdE7clIGqu3A0kWktYV+xqPxC4d7l+Sb9Tfyw4eY/cFMHEakwInSejYJRsxpfX6tto
	E0MLps74JTly1um0mRKEcUbEzXCA6+GRulMFaQzxIErgYSc4Xh2tsf2uzr6KvwVZXKyjmfTJitW
	jp1YyhXG2AK8SxDw8Q6Qj0vTbiAYYpiCSVTfUD8zqjd5SRZlIUP9xc6VIf592F9nnXrnnahZqRm
	y+iRr+2Akc8R5ZuVaw3kR6Hhr/r1YKPfJxcPuE/C7/iGWPS1XEQy/gy8weJCQ94pDgDr3VI7yLG
	bWcjbKa04X86bYV4ZfdAhDfIAOP8q6M88iTzLHU4DdLMYuiEyiERQEh4sflxPcl9+QXkMgGPyuC
	2PVumAdUZGfTEwSaK8JLRNiUwGJvyDrqbBKMnjIk9TjXrCrQbXJRINaG/+t0OAp4J0AmKuxyq6Y
	1nApwGNhb0Xp5wYo7Wq95P33pBYCK4wYX9TcAZrcrexI9vbg==
X-Received: by 2002:a05:6a21:b8c:b0:3bf:983d:e9b4 with SMTP id adf61e73a8af0-3c1104e577cmr9412580637.33.1783951360808;
        Mon, 13 Jul 2026 07:02:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:5c10:3a1b:ac91:58ec:550:f309])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm19600646c88.15.2026.07.13.07.02.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 07:02:40 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Shlok Kulshreshtha <diy2903@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t1100: modernize test style
Date: Mon, 13 Jul 2026 19:31:40 +0530
Message-ID: <20260713140142.27898-2-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713140142.27898-1-diy2903@gmail.com>
References: <20260713140142.27898-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests in this script use the old style in which the test title and
body are passed as separate backslash-continued arguments, with bodies
indented using spaces:

    test_expect_success \
        'title' \
        'body'

Convert them to the modern style in which the body is a single-quoted
block on its own lines, indented with a tab:

    test_expect_success 'title' '
        body
    '

This is a style-only change; no test logic is modified.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
 t/t1100-commit-tree-options.sh | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index ae66ba5bab..fabe5a97cb 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -22,28 +22,28 @@ committer Committer Name <committer@email> 1117150200 +0000
 comment text
 EOF
 
-test_expect_success \
-    'test preparation: write empty tree' \
-    'git write-tree >treeid'
-
-test_expect_success \
-    'construct commit' \
-    'echo comment text |
-     GIT_AUTHOR_NAME="Author Name" \
-     GIT_AUTHOR_EMAIL="author@email" \
-     GIT_AUTHOR_DATE="2005-05-26 23:00" \
-     GIT_COMMITTER_NAME="Committer Name" \
-     GIT_COMMITTER_EMAIL="committer@email" \
-     GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null'
-
-test_expect_success \
-    'read commit' \
-    'git cat-file commit $(cat commitid) >commit'
-
-test_expect_success \
-    'compare commit' \
-    'test_cmp expected commit'
+test_expect_success 'test preparation: write empty tree' '
+	git write-tree >treeid
+'
+
+test_expect_success 'construct commit' '
+	echo comment text |
+	GIT_AUTHOR_NAME="Author Name" \
+	GIT_AUTHOR_EMAIL="author@email" \
+	GIT_AUTHOR_DATE="2005-05-26 23:00" \
+	GIT_COMMITTER_NAME="Committer Name" \
+	GIT_COMMITTER_EMAIL="committer@email" \
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null
+'
+
+test_expect_success 'read commit' '
+	git cat-file commit $(cat commitid) >commit
+'
+
+test_expect_success 'compare commit' '
+	test_cmp expected commit
+'
 
 
 test_expect_success 'flags and then non flags' '
-- 
2.52.0

