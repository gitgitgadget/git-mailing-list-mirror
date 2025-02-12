Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF21DC075
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381396; cv=none; b=uomxBzyvwmg5GZcF875lfBbfAacIFzLLQy09WR5Yd/huPhGjsqh1prIecRdG3YVL6yRa7M3rrho/y1Nb5uV8BIOFzw3hqowSCfcW5x0HNnyK002+WMzZQ3UULucWcHm8DQluty4Ou2YbwMoLRj/f/dcmoExJHh9numLM25MZdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381396; c=relaxed/simple;
	bh=S7iIbL/iclM4m74klZ/DzgAiyHJSo6TkkwKx+lTpOHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAgt+I+oRra5zSr4ZUHfm1+sraF/TWpXEyZgmPKBJChalQiyHCW8t8R+NnYYhnXwPOs9AfqtjIhqQ/6xKTmTOKLKdDXvVVPF8fgXUloGnUkcrp7PmXi33TcJL+0qxC4XKJHuUtl09nzZL90rDR7urzGPwsFnw2PChzsevKLmtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKcw+5P9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKcw+5P9"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa2c456816so45747a91.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739381393; x=1739986193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1JbapwZ3DqT4kd3zv5fU2G+7mQDGvo04g6CkoGRAww=;
        b=gKcw+5P94exeSmkn+0bjIMEOKiPYP/grmT1ekbSAftT+GlQ4nwpOdBvAshd0xnGgeq
         yd6cxMXXJtY3qq50BW0nIQwWQSgpd4SgFONjos5Uznok8/eGZudRydthQWCIZg3aGXsz
         ABmr+2iuFBi60kFj4KZiVKVHFhMe7TA9oYsn2Qeoeq+ml56TONlfSD1n1xF/4foOMnBX
         igdNy9gdDjCVc88lBPFznN8dr11I0zdsWAXSTCCKFVpbk8KrE9aSN6KiVgMZcVr+nqr3
         0CifIa4x53e66S0mgNSU4MXxoAL8kXaD0RwQ/021whNArvphsvQI5VnaqZAeRGJLDCIi
         7lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381393; x=1739986193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1JbapwZ3DqT4kd3zv5fU2G+7mQDGvo04g6CkoGRAww=;
        b=pBFHxK2UXYwfgc/YeAXZAj60z1TFyTAxH+HKR+OaT0hoJ8DUMpDqbuetqZa3U2woQS
         LPdU0SvqaYXmnRrJ3USTBlwgt3D4GaemaZwIkIgF+/7c34HBk0pJ+wPVOobsWx7Q+7zi
         EndXc4UkfhiuXvHRnGpNw5VB9Jc94gq5yy1x2A9oHDkwxPVN5z80Fua+SNmoXghkHJWh
         s+BcNOeytumT4fTcq20qpeGWKh8Jn4cGsZDvM0BmTkrO8sWr4U/3M6ElBj2kdvaDxqon
         iUkWoiCuv3WA7fu/WU92la41V0C/5L6NjZmboIGfL8gt5nSNEJ1K1rU9WLBKJX65WgD2
         pGzw==
X-Gm-Message-State: AOJu0YxsFHsQ716UiIehxRJJ7Qbryj3RuQ2Sg9fsaWZghZBl9z60WUQb
	OAO7+hWyoziNdDF19Quue+FKukXuEn4baNx7D2nqJMUnilrbG89KnJSZf1nk
X-Gm-Gg: ASbGncsmsziIkEAB2nLce71P/7FdXf5eJvFJmKGEGRrPoxrpsKcGtK9SLpmiC927Tsh
	RSvsSXsJRLZCawoh4ZnyuZ6nvZxE7HMPii//ql93lO1D56/GBrLOGdPL8DgMZ+K7Tv+Osqlh2Xm
	4Ze/RS36P/a9+HNlGNAqkN9gkxlnTB4pkOZ/3N9UbL1Hn26VHRR33FLIQMdHHN9kdYg+wKImrSU
	fUMaJ8/LUf5uR4YHF24rEVRXE5UE2/YVdosfh9CHIY+JINQAlGNp1CEXmIi7D4122HJ6qOCKNyB
	GzR3ES4LCYmv9SlKu8Ff0w01qRcHc0o=
X-Google-Smtp-Source: AGHT+IHjtOq4ZbYXGe594MZ8o/t2c19m1B35cisUAkZJ/IjlD9ZA0ZoqeMCmpwVkW+r84J5+HpEnew==
X-Received: by 2002:a05:6a00:6c8f:b0:732:2170:b68b with SMTP id d2e1a72fcca58-7322c0947ffmr7059117b3a.0.1739381393114;
        Wed, 12 Feb 2025 09:29:53 -0800 (PST)
Received: from auto.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad54bca7d0csm6265668a12.58.2025.02.12.09.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:29:52 -0800 (PST)
From: Lucas Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][PATCH v2] t7603: replace test -f by test_path_is_file
Date: Wed, 12 Feb 2025 14:28:16 -0300
Message-ID: <20250212172909.21257-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`test_path_is_file` provides a better output when asserting whether a
file exists. Replace the occurrences of `test -f` in t7603 by it,
facilitating the trace of possible test fails.

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
---

The only difference from v1 is a little typo, missing the t before the
test name.

 t/t7603-merge-reduce-heads.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 4887ca705b..1f8c3b7ccb 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -52,12 +52,12 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
 	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
 	test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
-	test -f c3.c &&
-	test -f c4.c &&
-	test -f c5.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
+	test_path_is_file c3.c &&
+	test_path_is_file c4.c &&
+	test_path_is_file c5.c &&
 	git show --format=%s -s >actual &&
 	! grep c1 actual &&
 	grep c2 actual &&
@@ -75,12 +75,12 @@ test_expect_success 'pull c2, c3, c4, c5 into c1' '
 	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
 	test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
-	test -f c3.c &&
-	test -f c4.c &&
-	test -f c5.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
+	test_path_is_file c3.c &&
+	test_path_is_file c4.c &&
+	test_path_is_file c5.c &&
 	git show --format=%s -s >actual &&
 	! grep c1 actual &&
 	grep c2 actual &&
-- 
2.48.1

