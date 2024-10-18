Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88F204F68
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279077; cv=none; b=ovJLRbrs4WDuth2gTuGHGBNJyy5NF7TpZdiIaRNMOyEchx1k93uF2yLaV9lp4M6ZVhUSUu6FhDnrMl/5KV23/i+H6vTiCWeasT76mlzj31duN66j90nW3MkAUb4ofVyhgJnLqCZAp/YR0m7iKBdknELampa78wGtELNWTrBtWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279077; c=relaxed/simple;
	bh=n3CMgcRlPx4TUQOgqvzI6LeKrtRoDj6vkLhzZAz9YMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFUjkBR1mbpRPn7fSj57Glt6BWJmwkxKs8CN5ujk83RZKIWcuM+2F+IFIL2NUTrDU5J+IQYrXrn8nmKD6qEbIIdHkAkRvZpiz7pmyqDejAxvLkqhhHi+s2bKNHSjX+bhnW95ldrE2YX7tfXFC7B5uBXHxL0gPuw76xBn2ifLaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE78JmDU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE78JmDU"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so392261866b.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729279073; x=1729883873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsE6m1i6TWAIjjUZtomDAmSzfV/QxPHZhC7ABdyooTk=;
        b=gE78JmDUG0i39tMvYvaKcctyajcvF+L7tkX2fo8An0/S6Ci6wLGIFxi01dMUEHp3DZ
         kCLtgHggmdRckY1vPBSp8uktYQtVC1E58t40U1SFVw1Plo1lfi9gl6SEPPxGyWJuV2yq
         Awca/l22EHPM7N5BjgV4rKbTZdx4sWfiTHXA6nnEmEU81B2Os7mtddBDSU9fYqrZzWkq
         ejTx9gH6joV4sx8X0FsdfIIapsdtW+9OLDfCgmFjDxI0NHj1VgL3HRwzqZg/C8/fmxY2
         Ti5rbnID7dz/cqgXJWTx9CN33FLCOSGS00JdeHKa4JQavCNNn2DwDnL/28pFQYfO/Z2B
         /JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729279073; x=1729883873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsE6m1i6TWAIjjUZtomDAmSzfV/QxPHZhC7ABdyooTk=;
        b=C3oi0gTSDVJV6FJfM0dggmE4U8He/bJUkfQrNrqnS7c9/P8LtKhXyKbf0v/2uZMyii
         2rXh/EZVzViE8r9EXnhYxemZaDfs1OPjzDkhupqcc5C2O5L7i5RB/G37j00L5IX0TZQn
         HquSybYUinaS2+66hCKeJsLfOkBZseM6x1NA9fLBtH8gm41z4lfRFEISs0lHhHhi1r3U
         kUyLBSsXXgLF+kNi2ZDt4r7JzGrBSf9NNB3geNdq3rAtsLYvsiZoqdTrwUYOzquuT9lA
         34Ftwby2oPuumY2kXBKShA5wKM9pBarQfh4EJU5+LGYhLdThUwUYwyvRGm8u2zPzdqdv
         juig==
X-Gm-Message-State: AOJu0YyOTSydVf5g+kJJLmVFQcX/+zeMPQuOKW3FAexR3cpnCfZHdl+p
	Xq9jlgA/HFzr5GYbzrzPzww3Biz3WvY4rqMdfxCsfjmdKcasrlOV/NDSw+rUadpKnog2
X-Google-Smtp-Source: AGHT+IEhWgkLxM66aahiFYish35OWKI4cVfTAK3keoVE1O6cMeo5siKQwTS1mKsd17jVr2DxzJzkYw==
X-Received: by 2002:a17:906:7311:b0:a9a:4d1:c628 with SMTP id a640c23a62f3a-a9a69c9e9f7mr328011866b.45.1729279072916;
        Fri, 18 Oct 2024 12:17:52 -0700 (PDT)
Received: from localhost.localdomain ([154.118.11.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a68a8d959sm129932666b.28.2024.10.18.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 12:17:52 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [[PATCH][Outreachy]] t7011-skip-worktree-reading.sh: ensure no whitespace after redirect operators
Date: Fri, 18 Oct 2024 20:17:43 +0100
Message-ID: <20241018191744.209746-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in the thread on lore.kernel.org (link below), it is important
to ensure there is no whitespace after redirect operators. This change updates
the script to conform to this standard, changing instances like:

    foo > actual &&

to:

    foo >actual &&

Reference: https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/t7011-skip-worktree-reading.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 4adac5acd5..c86abd99bf 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -32,24 +32,24 @@ setup_absent() {
 }
 
 test_absent() {
-	echo "100644 $EMPTY_BLOB 0	1" > expected &&
-	git ls-files --stage 1 > result &&
+	echo "100644 $EMPTY_BLOB 0	1" >expected &&
+	git ls-files --stage 1 >result &&
 	test_cmp expected result &&
 	test ! -f 1
 }
 
 setup_dirty() {
 	git update-index --force-remove 1 &&
-	echo dirty > 1 &&
+	echo dirty >1 &&
 	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
 	git update-index --skip-worktree 1
 }
 
 test_dirty() {
-	echo "100644 $EMPTY_BLOB 0	1" > expected &&
-	git ls-files --stage 1 > result &&
+	echo "100644 $EMPTY_BLOB 0	1" >expected &&
+	git ls-files --stage 1 >result &&
 	test_cmp expected result &&
-	echo dirty > expected
+	echo dirty >expected
 	test_cmp expected 1
 }
 
@@ -59,7 +59,7 @@ test_expect_success 'setup' '
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
 	git update-index --skip-worktree 1 sub/1 &&
-	git ls-files -t > result &&
+	git ls-files -t >result &&
 	test_cmp expect.skip result
 '
 
@@ -86,7 +86,7 @@ test_expect_success 'update-index --remove' '
 	setup_dirty &&
 	git update-index --remove 1 &&
 	test -z "$(git ls-files 1)" &&
-	echo dirty > expected &&
+	echo dirty >expected &&
 	test_cmp expected 1
 '
 
@@ -110,16 +110,16 @@ test_expect_success 'ls-files --modified' '
 	test -z "$(git ls-files -m)"
 '
 
-echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" > expected
+echo ":000000 100644 $ZERO_OID $EMPTY_BLOB A	1" >expected
 test_expect_success 'diff-index does not examine skip-worktree absent entries' '
 	setup_absent &&
-	git diff-index HEAD -- 1 > result &&
+	git diff-index HEAD -- 1 >result &&
 	test_cmp expected result
 '
 
 test_expect_success 'diff-index does not examine skip-worktree dirty entries' '
 	setup_dirty &&
-	git diff-index HEAD -- 1 > result &&
+	git diff-index HEAD -- 1 >result &&
 	test_cmp expected result
 '
 
-- 
2.47.0.86.g15030f9556

