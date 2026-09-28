Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67744B5150
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596708; cv=none; b=qYtNL7pah5nuMQQiwc8xXYov3dXR1aK89CndbZ46j4cASM2XQiftc4lkfCWyYgbksRZhL/hxH9hCp+O4I0SCOIeS2Jmy71ddAujDh3M8yZpaLnv2N2/9mUFRcpZXHoeKLdPpICHEiXgN/+8CezuVGinWROVSdpzwubnaWU8Fa4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596708; c=relaxed/simple;
	bh=CUmHLF1cqEwuIalXqxPmsUelZQvTiVT3YcaPB5lkePA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=h4hE7Eqwo/301FggtmMzLfb5RjmyQplD1BG+KyRbJAsFJz4fAF6vKqzdHs80OYsoZ8imfiKZuFeh4p7bMUwGD4WRUhYpF4sYqrNDAd0MP86bJN01XxdhtrznC2K9LWxSU8MRcBbQmCbXX2arstBVbMdADmHdsCw8o6fBWkyD2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLn6tadX; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLn6tadX"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-349fed3431bso417767eec.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596705; x=1791201505; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CLCPjoW3ghJIxFZ/PH27G0ZixLDpQ2GzU4amH579QMA=;
        b=YLn6tadXKlR1snfiudPNx6zKk7mTX1kqRnFqx0j/sCsbLt2bjTWpi6lxvBkRk7yMF3
         h/MWlGIQmxYJORtueBKzPwho8p8oBxiUDwNgLu1MhmQ2DO/MK0doLqQOLF/+0XHVP3/q
         HSHejeEt6z90Xgkz5cxfxn+ET/pnBK7O0WeZ6gRVbRHYUHI+hFSIbge2U8UwHxmtEo6r
         a5dkIZdJy+cv1m/IC0DF1NXjl/PJmbP4qR7jJd8Xihvjur/DWBmt2pIHiytu3GS7osIa
         Gd+pqoNMXsm2DpLAtye1LtXRruMEJat374E9ARmtlh4sSN/konidthm2Bnm+lnHxBHPs
         ZSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596705; x=1791201505;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLCPjoW3ghJIxFZ/PH27G0ZixLDpQ2GzU4amH579QMA=;
        b=SsO2m2S6nFqWpIa9I341/ZmrmQAxsbMAkr3wouqiXTVGh9r7l6Nn4zfEkcCvd45oNj
         kWHkGry2wP3N+R9Ki5KZ5NXT8mTP3NEER+tCkUa19qz+DSfSFGnk0rQXGsDrTotV0T1e
         woIwGP6A8RCN27OMDuWPF3N0XDwazu/lZQyd4ZC6dB2VEZ5Itk3hN3xu0q+hpCSdHto7
         dPPjORUub2TyzirvLbR+mQpsmxxpzrJUcZt6yrOr4Z+o/uCJIlJ8MMzRzrAz9GPDeAJq
         Dci/+CrK97LX7itIEI6f7kni7B1zyW0JD0I+zmFER94e7nA/RBM/9DowTnxWKMTVnX99
         kjGw==
X-Gm-Message-State: AFuF++lUZcfxqp5HW3Lb2VCBnJRtdK7Dbly/BpC3Rp07VkOsxGESoEyC
	f1o3zatvXZHXFvV76oCFoR7dteT/FE91H1xFOjNLtdZbKdjwCrALzuBLlnYXCQ==
X-Gm-Gg: AYBFou3pDIOile9z1LH4qNnloGqvJdP2a6ZJ978eTrzUo5SQ/myMOONwl9WIFQtqH8X
	tsBZHaIHMWDm02np5p4P5Mvx02aQi6FoXE/RuvsErp2R5tCUiVnQKb6scTI86PphmOdPICao4HA
	uNm/r1ytr+A5087rSJW3gaGbn59i0ds2J39qx/l5nNeEhwXDosWvvT/OQorwZXF6w4SRf4P7DUD
	pVfypTw0trK3RfIGGGFPf7AJc/nNBtildyWZtPDcIomXrOf/11jWY1dbFk0XLxCYrfp/X1uDQNw
	nlfI6rSgZKkD+ScTEzk1hLBvPMjzkqHiLGOtxKhXB5SolWh9FeY/aaZ54awKJZaqrPHc+q+fLqj
	W9vU4zioxHNSv38F89/2f51HQYiURvSl8XmmCECWEYp8BS73XvNL9+3xX7/fvwKXnTLJ451Yuz2
	RxVwpWjT7glZLAky0CknHuw6gRRBfT3ne3/ZH0w5N6hg1KR5/4rpUNDXWdTqkfIAgMJJbuphNkT
	Q==
X-Received: by 2002:a05:693c:895c:10b0:33e:5c4f:f46e with SMTP id 5a478bee46e88-3427207abf8mr8593862eec.30.1790596705370;
        Mon, 28 Sep 2026 04:58:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3475546b1aesm7493127eec.4.2026.09.28.04.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:58:24 -0700 (PDT)
Message-Id: <3dc3d02f12a3118ac9e270c19960815f6b8170cb.1790596702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 11:58:20 +0000
Subject: [PATCH v5 1/3] rerere: wait for MERGE_RR.lock before giving up
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

