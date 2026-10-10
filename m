Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5C314D13
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627213; cv=none; b=DBMIlziYR3Erkw7O8kysdwEgqAIj8KD7qnj8TugXQrlulBtksGxUAIn38zfzDFYls3LjjjiumDbL0mK3F1b9OB6gcCsGeBCVJ7fmpAoA6a1VGkghfJNX0ohlk6MpMcmDgNEl1m8L5R8VBW69Ferwy+fCxx7LJ6pAIf0QVtOOD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627213; c=relaxed/simple;
	bh=CUmHLF1cqEwuIalXqxPmsUelZQvTiVT3YcaPB5lkePA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AtRGiwNICtohEKP1JZEfG5P3uQij4hbuZ1SGjSklntt1xl97u3fqyFBhATwPOLSif9BKoF69Ys6QHjRgBFG68RKAN1vaIpgyCgoBBcDIhjQa8oo4h06ynJaWn0JLGEQwOuUKfhSjZJQTVP1bhxb4QvpWWtrBPIR0Opy87Tvjzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF8aMkfi; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF8aMkfi"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4f6d98ff6c7so414324b6e.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791627210; x=1792232010; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CLCPjoW3ghJIxFZ/PH27G0ZixLDpQ2GzU4amH579QMA=;
        b=gF8aMkfiAVRkdVqtLUxxbSDCXPTym/qC8nHB7fH0sqc7P0kPinou6MlkoRWfmvGQND
         g0+nE8pU9g/3HNoiIXzH8blYHPgrDoGZFCnn3qtDWJa7xf2QI4GdBaowWItMwro9qOQe
         jNnIVWkv9k2r1m+Hgvn4vxQOWZ6IhFlhyAwE2Ob12mX1eMKKeu9jkpc+cTH9Et7RS0y0
         2sMcWrIZwijSt4PejgqBvF9cf6U39MlETK/AIPcAaPeXjLBAY/l7JAUoEaqTISqEPDlu
         hzCqQsXT9pgi0BuBED2dOZlcy7mW8uT+zBykFH5X/Yj9ta1xC+CNzsRqBGaGCoLQFaii
         pDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791627210; x=1792232010;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLCPjoW3ghJIxFZ/PH27G0ZixLDpQ2GzU4amH579QMA=;
        b=l9aV8KVwegOXWlPegDSQ5nNfoLrSY3htePwOThXoyoSUFi3Zlk7wK+oYnjvnik8dj1
         1mvezPKWqF/aj0t3qyD92DeHLMHoOzbVlb8Oxt+/F1Dn/bdoeyExx9n0mes/HpM0TlvM
         UboLPAyvR0b2hwPDrB407qLW8D115nKP94xEW7bVGgy7MI1C9jpzQVKWPsrSQ+ZFoHEM
         VhgW5BoOmbKciTFd0WIYgj++V4dI7DirFyaOeUlE45X3Ku7ISeb956UZjwEgcXkNKwCS
         1dRry3kIekVRIHMiHybwndDmQzmtcvDB9BNLMel/Vkt7HLvEL0C+v7L73e24All3kjvH
         asKg==
X-Gm-Message-State: AFq9FYK55592Dzk4++aLWACavHgb0WYupQDJf5ivZgSZX7Wkeyr47N5Y
	iSMRDLlH1Ga4Rbf5fz3Dawy4A+zVSofDQHaQzbbtpGXcVZ2wWEM3H1YZ8BLi/L6W
X-Gm-Gg: AYBFou1mASGy4fLUrdj9ij5UkJysX14HqNZ39obOcrrM3yhiyXbnFZLcmt6TBZ1ECWr
	FcG5SHNjCqAzSfaNx3YusPUPZEvcLyt/SgH36TjHXg1gzMZTKxwFa/9RZX8rxF1PbilPYCTIh/S
	H4xRGqCKDyxSRb+1/xgU2rmlVXpi196SpQdLRmrgUG/T0VVQm3vvR9GHzwuSmVm0xWBtTy75/J5
	pO/zzZkXUAtuClizCX/JK73SjPiMMuQdSIJudiCtYZRcv/l46YxJJ/EDSZ4jnUI6dcgImqk19/T
	LaaIryHuacE2XNpxogP0oNP19ggZv/Mmf8joiZNfsEZPnxZDoNX3n4ajrtgKNyFXk7KZ+N29/m0
	24SxS6RoO2zx0ybdyGREeLnLth/dxrWe7CeO9nKEnQB1qdhHEFj2qdKyfHGiQdFpUz1hzPQLcZu
	6igfccF9ThTG6VsvKuz5Ri8ydNceb0+PyIxnwRFBG3Kk95Dl/cre08vHVnnQYOLGdViJRtvcmo/
	bfKMqonvJ+t5w==
X-Received: by 2002:a05:6808:4fe3:b0:4f5:c4b9:dbfa with SMTP id 5614622812f47-50c57f42facmr4699660b6e.48.1791627210440;
        Sat, 10 Oct 2026 03:13:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.239.199])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1674ddf8sm4640712b6e.4.2026.10.10.03.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:13:29 -0700 (PDT)
Message-Id: <3dc3d02f12a3118ac9e270c19960815f6b8170cb.1791627204.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v7.git.1791627204.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v7.git.1791627204.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 10:13:23 +0000
Subject: [PATCH v7 1/2] rerere: wait for MERGE_RR.lock before giving up
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR, so of two
processes that want it at the same time the second one dies. That
used to be rare. Since 452b12c2e0 (builtin/maintenance: use
"geometric" strategy by default, 2026-02-24) the auto maintenance
after a commit runs "git rerere gc" whenever rr-cache has enough
stale entries, and the gc holds the lock while it prunes.

A rebase whose next pick conflicts while that happens dies inside
repo_rerere(), before the sequencer has written the state that
"git rebase --continue" needs. Every later "git rebase --continue"
then fails with "you have staged changes in your working tree".

Wait for the lock for up to rerere.lockTimeout milliseconds, 1000 by
default, and only then fail as before. Pruning a few thousand entries
takes well under a second, so the default covers a rebase that runs
into the gc.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  8 +++++
 rerere.c                         | 22 ++++++++++---
 t/t4200-rerere.sh                | 53 ++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..30e827f32b 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -10,3 +10,11 @@ rerere.enabled::
 	enabled if there is an `rr-cache` directory under the
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
+
+rerere.lockTimeout::
+	The length of time, in milliseconds, to wait for the rerere
+	lock when another process holds it, typically a background
+	`git rerere gc`.  Value 0 means not to wait at all; -1 means
+	to wait indefinitely.  Default is 1000 (i.e., wait for 1
+	second).  When the time is up, the command fails as it does
+	for any other lock it cannot take.
diff --git a/rerere.c b/rerere.c
index 1c3745d9e3..64fac07c71 100644
--- a/rerere.c
+++ b/rerere.c
@@ -33,6 +33,9 @@ static int rerere_enabled = -1;
 /* automatically update cleanly resolved paths to the index */
 static int rerere_autoupdate;
 
+/* how long to wait for MERGE_RR.lock, in milliseconds */
+static int rerere_lock_timeout_ms = 1000;
+
 #define RR_HAS_POSTIMAGE 1
 #define RR_HAS_PREIMAGE 2
 struct rerere_dir {
@@ -850,6 +853,8 @@ static void git_rerere_config(void)
 {
 	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
 	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
+	repo_config_get_int(the_repository, "rerere.locktimeout",
+			    &rerere_lock_timeout_ms);
 	repo_config(the_repository, git_default_config, NULL);
 }
 
@@ -882,12 +887,19 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	if (flags & RERERE_READONLY)
+	if (flags & RERERE_READONLY) {
 		fd = 0;
-	else
-		fd = repo_hold_lock_file_for_update(r, &write_lock,
-						    git_path_merge_rr(r),
-						    LOCK_DIE_ON_ERROR);
+	} else {
+		/*
+		 * Another process may hold the lock for a while, e.g.
+		 * "git rerere gc" while it prunes rr-cache, so wait for
+		 * it instead of dying right away.
+		 */
+		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
+							    git_path_merge_rr(r),
+							    LOCK_DIE_ON_ERROR,
+							    rerere_lock_timeout_ms);
+	}
 	read_rr(r, merge_rr);
 	return fd;
 }
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7bb601e117..7bd92235dc 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,59 @@ test_expect_success 'old records rest in peace' '
 	test_path_is_missing $rr2/preimage
 '
 
+test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	{
+		( sleep 1 && rm -f .git/MERGE_RR.lock ) &
+	} &&
+	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
+	wait &&
+	test_grep ! "MERGE_RR" err &&
+	test_grep "^=======\$" $rr/preimage
+'
+
+test_expect_success 'merge fails once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
+	test_grep "Unable to create" err &&
+	test_grep "^=======\$" a1 &&
+	test_path_is_missing $rr/preimage
+'
+
+test_expect_success 'rerere, forget, clear and gc fail on a lock they cannot take' '
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere gc 2>err &&
+	test_grep "Unable to create" err
+'
+
+test_expect_success 'rebase --abort fails on a lock it cannot take' '
+	git reset --hard &&
+	git checkout -b lock-held-abort third &&
+	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
+	test_must_fail git rebase first &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rebase --abort 2>err &&
+	test_grep "Unable to create" err &&
+	test_path_is_dir .git/rebase-merge &&
+	rm .git/MERGE_RR.lock &&
+	git rebase --abort &&
+	test_path_is_missing .git/rebase-merge
+'
+
 rerere_gc_custom_expiry_test () {
 	five_days="$1" right_now="$2"
 	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
-- 
gitgitgadget

