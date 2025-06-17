Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7C8635D
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120188; cv=none; b=kS+YpZ+m+8fx9yve0Dd5kp0g2fSUC26foT7qKGp0mdWREe9nvGhlfhLcb+G0IIHXIumisIodk4BjL5ey5hsefapFEtpP9ke7ex3NdQfJDvV+wTZaij16kaWW8/NJOHwhSmMfbs+lVaRO9Fa1G4SRmxRAetA3acLEbTBvPta1jVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120188; c=relaxed/simple;
	bh=VSGqGCTixSArBr3CyQgrmEwUMgaBs4sx8L1//qs/ikg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5lvw64bnDhD0oPsgBHq0qHtRVeWu0Fi7eom321SL0gOFsk3IP/aTTazIIPz9EHxe1aoO3mD3xKx3RdYotGKZBbwsmTjRBxS+jPZX/+Y+9a1LVuO6u2A9n/z746EeagLWaQfU7hNkaOTqGKUGFWAlS26Zzzv/2VlK9yuT+gfdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ+Rj7EI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ+Rj7EI"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3134c67a173so5997890a91.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 17:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750120186; x=1750724986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CFLa8P6C9/6v1XxNlJoj+jaAV7YFTlFhyT1I3FVaqI=;
        b=OJ+Rj7EIYJSDJIq3UOyLlTdxx6nl3OqLpjlZHCetb16yTou7STA/U/Lx/wl+vt+WXX
         ky420+F1gvBTD5uCMYJrjdoYS41fRKncqADX1btuFQFNKwntoNDcOheGF4XE9/9g3kOX
         w9qbFkz0adnr+u3304wGj5kODj02kv9hMoJlu3CqymP7njKY+1XJGUMX6pyjLWWzPJZd
         HX0/fXIw+REhAyIKSMP/E43nf56cM7BWOdygfkZTxC4wrt21kYx7luE8A5p3PG1ko4bn
         XFBMDNeMoPV7vTQZg4RrEKBZHnNmBn2BWhuSp0J0QmQEg8GTOZrzPPCXYFQHr6uH9lnQ
         Qc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750120186; x=1750724986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CFLa8P6C9/6v1XxNlJoj+jaAV7YFTlFhyT1I3FVaqI=;
        b=YumJOjEYB2FXFoAQbYSD6e8HyRjyjBHarvK/Sa+ELxsIbKTr1Vw8SkS1/G4W4ddPTX
         S/ieBoKV9sEGkQwejP1rM9LxMinlEGvKBZ7n8gEjAwdgSH0D9yr3h1uD63WtV/AlTf1c
         3cCMA/VCYzZ2qsuV7JYPYVfo8V6hPLi09s5MztELf/iSMHWnSZ9wE3PW34RTwQ2VQImf
         5tcnxTZYqPptOF9iandP1liNRpekVCsF/K74d+Jo1G42b+PiHOuIwL7QMBEYalqvZL2C
         iXdKIpnbj4s43mSP+6TKgY9WydQqDZJq/N8uxREtpg6Tb7puMxfJYa4wPjcGPTxyzexI
         f/bw==
X-Gm-Message-State: AOJu0YyEd6red8VAPJc5Xv9iXQBvgM5rjneGTVWZjIdcC6Z5NdrJbfZe
	GCUCW/Kw/1yfMuJWb2tiljhc0DMKSuY62zTDsqIiP+gws79hEmc6mQz5/jTCui7h
X-Gm-Gg: ASbGncuQUeBJqnP2gBGKaAPShChrLhI5+jtyZTSy1tHIY0TmrX/qzcX8IeFY05cHhF+
	6c52la4RF0HmOYQcC9TfWSczUY7LZhhgbfD7Qq6l8FP83f2A//X104Ozff8JbHgRUF4LTHD/sTI
	lVmi4HwYpO8zz0BhwHToIG1JhDHXQuw57NW1H/f2PoZ+D+38S5u6X244z//QYNR6+wNP9Z0MpDd
	8fssu+YCjK7/lJZqsIQXgQ64Xxa3COnYY2DFc+Za68RBotqSug3HpDuJXeuXf4tAbWK1r5QhduT
	smaH5NVbqR0/UAZb10aNw+QCIRDWbCLkZCnh2Nq88y522Jkcw0KUGBflnvRErFeKm8q295f/9LU
	J2t3B2BFRFCNrDA==
X-Google-Smtp-Source: AGHT+IHPNNhOrW7sgWpLNHKhT5fa+vEgavrs2BpOrRQI3KF82rfHK1Dfjxo96/wkcNzANZQDfO345g==
X-Received: by 2002:a17:90b:17ce:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-313f1d020f8mr14321985a91.23.1750120185987;
        Mon, 16 Jun 2025 17:29:45 -0700 (PDT)
Received: from APOLO ([2804:868:d051:698d:edd9:8f23:476c:6db1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b49a8asm9308267a91.32.2025.06.16.17.29.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Jun 2025 17:29:45 -0700 (PDT)
From: Rodrigo Michelassi <rodmichelassi@gmail.com>
To: git@vger.kernel.org
Cc: icaselli@usp.br
Subject: [PATCH v4] t2400: replace 'test -[efd]' with 'test_path_is_*'
Date: Mon, 16 Jun 2025 21:29:39 -0300
Message-ID: <20250617002939.24478-1-rodmichelassi@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.48.gf1ca98f609.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'test_path_is_file', 'test_path_is_dir' and 'test_file_is_missing'
are test helpers used in Git's development, that emit useful
diagnostic information when they detect a failing condition, while
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

