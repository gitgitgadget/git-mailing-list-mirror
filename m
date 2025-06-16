Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F686340
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085147; cv=none; b=KoSWdhGorSqmde8nPYRPxfsQB0QIQLUlJ5HtMpkdnw5TD6w5stc4Hxv3CX7oGb5CMneJPFzOK6fYHHvc5RQcDX7ua6MCDfusNShJp5ME61ZQ1FI/QTVAZtqmagmgHvqWi95pKdH1v+LsvKoX3VyU40uO/eBZcfb3Og2NfebGIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085147; c=relaxed/simple;
	bh=i18xJB9i/SpcJXp9OimcdVi6MEqlpJlduojzp+InhJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpslJRYZsmXDhZk1FNw0rzj0oxBh/o/XPJTOSbogMAHiBiVcMeFEtSHdAJdXx3Xa1gn0iyzK6i6nP638VflLjLtOaHEDCRoJOHUAwdmmsDHZ0yuP8967HdbQoln+OrYiziwVTBwJC5gSq0C4FtXZS2DBeLeJouH3Cw5bPpqoZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2wBMmez; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2wBMmez"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e731a56e111so4291867276.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750085144; x=1750689944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNPPL4KlqhjvxUntaeFoB0gaRyJ+OI9NKhlfiyFbGk0=;
        b=Q2wBMmezEExLRXsEBPlXSx5q+6Fpq1dQ7MIbzjlEQ1QnHf3R055Pz4f4FQ3Ch3HffD
         ppc+iXq3g8LOxCQRUBxbzkxOfxdRY7llm896F43sC2vQ6K9lssDAN0dkGU4dKFSTsYEc
         Hc4SSGyd3Espb7SZPPjpCx5rhIAQfE/vfYR1dgTq9Mh6lcEcHhpV9J+tWHrZ6k9+1ZPu
         CMN1EwKPTe+vNCaXADjoK0U5zo89BurebNt//iP73HBUV7XmJ8vT//k62tP8jcf2YrDU
         c2ZexPjxOxYfMbDUvl08KEaTrWlFQK2xd/Yt8Bjc3hMgYUX5memGGo9AltpBb/0vOtAe
         3KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750085144; x=1750689944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNPPL4KlqhjvxUntaeFoB0gaRyJ+OI9NKhlfiyFbGk0=;
        b=mqIWdAnp0XSAa/mGfNLqvChjvunMUXB7Emu4NUjbh8Yc3n3i7Gb1ilWHFTWWn8AWp6
         AudrhEYel+AKoKHb6tgGHB4YxFLbNQTAJOV2fYRJnUcyXaQRIf4M9mJIcbmo2hELLVr+
         DkJhoQ9/uKg+PYBJKWJ3jN7c1zgl6icO6DpZlj/4N4BR0C34oYfB5BD0Rlu54nw44WjZ
         etUN/O9R0x71J15dybjL8i4wldWBRZJY+vS2T+9LyK4nXESlYDLWL2NYv/ZBVFoQSis7
         GBokqAvh0jasGAlX9Bhsv6e/aPkUQrSWwKc86AvQmrnXSXBDBdphCmqwPa47M1GkGIFC
         IGzg==
X-Gm-Message-State: AOJu0YxyN2xD0Ha75GPqk3ru1oEqtX1PiUu6LRZn+SCMZnOtBUyyGDk8
	zSmVOfye0SYcQrwAjvNgAHfxINlpLc8/ilR2zUSRg3s2pqL5GbMFkOdDWLw+krnY
X-Gm-Gg: ASbGncvSJNhNOZswFcdpquc3J/dwdykjtkNYTQLtRHPapOK06LvTTWatumPf+jjo3Dq
	9iI2c0CNjgyu8bPgh1qDGlWDbhbWIInaf4YDFLx92QEknCFEJ7gjU1gCy29YN3fv1ge+/1eicKD
	OTWugU7rbgXSmMHSMjbSjNkMvuZTnDwkVExucPyUKgWK1YS0e05nhwGGatcl4UJzSf381H9B9mt
	pkkq3hGA+wY2y6oEQm1SGuZ3eqquLoG/6QfC6sS3NaNVVYxqbf6QLyplY2PBRMOHKJyRRFCMX98
	o5R9DHPDY9ASNWSu7IfzBCDX7uOyNV07/3TE5plKxv09Bx1X2GQLJIY/tAWE614WxlrzIhOuD9P
	YHKhTQwWvrw==
X-Google-Smtp-Source: AGHT+IFlIlZ76zRA7bCbP+T0ojcA2cw9bmgGEsc1LErPNBhJHvBT37Izhs0Ik+7A2z/d4s4m1XgIJw==
X-Received: by 2002:a05:6902:cc6:b0:e81:b080:31df with SMTP id 3f1490d57ef6-e822acf0121mr12283907276.36.1750085143734;
        Mon, 16 Jun 2025 07:45:43 -0700 (PDT)
Received: from APOLO.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e09fa44sm2978501276.24.2025.06.16.07.45.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Jun 2025 07:45:43 -0700 (PDT)
From: Rodrigo Michelassi <rodmichelassi@gmail.com>
To: git@vger.kernel.org
Cc: isacaselli@usp.br,
	rodrigocmichelassi <rodmichelassi@gmail.com>,
	Isabella Caselli <icaselli@usp.br>
Subject: [PATCH v3] t2400: replace 'test -[efd]' with 'test_path_is_*'
Date: Mon, 16 Jun 2025 11:45:40 -0300
Message-ID: <20250616144540.21075-1-rodmichelassi@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.48.gf1ca98f609.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: rodrigocmichelassi <rodmichelassi@gmail.com>

Sorry for the wrong commit message on V2.
'test_path_is_file', 'test_path_is_dir' and 'test_file_is_missing'
are modern path checking methods in Git's development, that emit
useful diagnostic information when detect a failing condition, while
test -[efd] does not.
Replace the basic shell commands 'test -f', 'test -d' and 'test -e',
with this modern path checking approach.

Co-authored-by: Isabella Caselli <icaselli@usp.br>
Signed-off-by: Isabella Caselli <icaselli@usp.br>
Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>
---
 t/t2400-worktree-add.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 90638fa886..023e1301c8 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -42,8 +42,8 @@ test_expect_success '"add" using - shorthand' '
 
 test_expect_success '"add" refuses to checkout locked branch' '
 	test_must_fail git worktree add zere main &&
-	! test -d zere &&
-	! test -d .git/worktrees/zere
+	test_path_is_missing zere &&
+	test_path_is_missing .git/worktrees/zere
 '
 
 test_expect_success 'checking out paths not complaining about linked checkouts' '
@@ -70,14 +70,14 @@ test_expect_success '"add" worktree' '
 test_expect_success '"add" worktree with lock' '
 	git worktree add --detach --lock here-with-lock main &&
 	test_when_finished "git worktree unlock here-with-lock || :" &&
-	test -f .git/worktrees/here-with-lock/locked
+	test_path_is_file .git/worktrees/here-with-lock/locked
 '
 
 test_expect_success '"add" worktree with lock and reason' '
 	lock_reason="why not" &&
 	git worktree add --detach --lock --reason "$lock_reason" here-with-lock-reason main &&
 	test_when_finished "git worktree unlock here-with-lock-reason || :" &&
-	test -f .git/worktrees/here-with-lock-reason/locked &&
+	test_path_is_file .git/worktrees/here-with-lock-reason/locked &&
 	echo "$lock_reason" >expect &&
 	test_cmp expect .git/worktrees/here-with-lock-reason/locked
 '
@@ -412,14 +412,14 @@ test_expect_success '"add --orphan" with empty repository' '
 test_expect_success '"add" worktree with orphan branch and lock' '
 	git worktree add --lock --orphan -b orphanbr orphan-with-lock &&
 	test_when_finished "git worktree unlock orphan-with-lock || :" &&
-	test -f .git/worktrees/orphan-with-lock/locked
+	test_path_is_file .git/worktrees/orphan-with-lock/locked
 '
 
 test_expect_success '"add" worktree with orphan branch, lock, and reason' '
 	lock_reason="why not" &&
 	git worktree add --detach --lock --reason "$lock_reason" orphan-with-lock-reason main &&
 	test_when_finished "git worktree unlock orphan-with-lock-reason || :" &&
-	test -f .git/worktrees/orphan-with-lock-reason/locked &&
+	test_path_is_file .git/worktrees/orphan-with-lock-reason/locked &&
 	echo "$lock_reason" >expect &&
 	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
 '
@@ -474,7 +474,7 @@ test_expect_success 'local clone --shared from linked checkout' '
 
 test_expect_success '"add" worktree with --no-checkout' '
 	git worktree add --no-checkout -b swamp swamp &&
-	! test -e swamp/init.t &&
+	test_path_is_missing swamp/init.t &&
 	git -C swamp reset --hard &&
 	test_cmp init.t swamp/init.t
 '
@@ -497,7 +497,7 @@ test_expect_success 'put a worktree under rebase' '
 
 test_expect_success 'add a worktree, checking out a rebased branch' '
 	test_must_fail git worktree add new-rebase under-rebase &&
-	! test -d new-rebase
+	test_path_is_missing new-rebase
 '
 
 test_expect_success 'checking out a rebased branch from another worktree' '
@@ -535,7 +535,7 @@ test_expect_success 'checkout a branch under bisect' '
 		git worktree list >actual &&
 		grep "under-bisect.*detached HEAD" actual &&
 		test_must_fail git worktree add new-bisect under-bisect &&
-		! test -d new-bisect
+		test_path_is_missing new-bisect
 	)
 '
 
@@ -1165,7 +1165,7 @@ test_expect_success '"add" not tripped up by magic worktree matching"' '
 
 test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
 	git worktree add --detach ".  weird*..?.lock.lock" &&
-	test -d .git/worktrees/---weird-.-
+	test_path_is_dir .git/worktrees/---weird-.-
 '
 
 test_expect_success '"add" should not fail because of another bad worktree' '
-- 
2.50.0.rc2.48.gf1ca98f609.dirty

