Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B04FE2D2
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893279; cv=none; b=suZmf880Cguckzpt2y9l3KcuPbohGU401uIe6ggUXmohH5w+DrA5ScX07rkOoU25+iszuz64zYw9STt88/ykW0WE7Pl5v78DJ892Mg72yveEjKMXttbpEJvnKxRwrNwftkVLrkAG00DfLB61Y1V4xyn5uq+48nv51KGVFrPX0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893279; c=relaxed/simple;
	bh=x5mVYq9a9g0vFy8tFmJh3GCyqww6NYdyJO9fqlVSNbM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i9xxOljhqTG5J+zgRRq1Kd7z/QdnfEyaaJ4A30KjsLO/wml9Z4cJZO1cyKTAlKIdTvZ3KagtXo9TtujhyjbUT9D3umOxUHtfs+/F5H03ur0HGSU0HGuGNt1A6g8dt4ucPA0lhjGnquN2Ji3yY/SHgTZukOMd3BBTfeYu3EupGKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5/yx/Fe; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5/yx/Fe"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so2307946a91.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893278; x=1792498078; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YkbZijw5mwT1PpIL3niKHI0cVd83KclI50y/REcLdd4=;
        b=Y5/yx/FeF7jlcjhFyLto6GTQNLgCQltfn49naXJ2BtVrKmi44hQlSCag0IaThHW26w
         P3dLPvmqMiKTmJSMfLaCXBPPNq36tzdiQNBBxSwFRFwlJfZ6LsgpSQccgv/ZQdAUaTS6
         8iQWTW/LeqIxG6kedEEqYDgPlxlk0vfuzNQkzoWKP2OZEQoSKGKRrdh0f1MR9JXpv3eO
         4gE5Z1yMQu+xGjlTesIR2I6mQdFmnVgqSCOJC5AMpoMUbeiT9hJLClc8gfOxlLyn8hBg
         7UC1JMu4L5SrnxKMGD5W5ayXLzZVgJn/Akobajb743DJGvj5DLwtUCae6M3XZ3aDFozE
         eEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893278; x=1792498078;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkbZijw5mwT1PpIL3niKHI0cVd83KclI50y/REcLdd4=;
        b=q3j21HmdoMJ8MO750myzw/tWm8AY5hOj/s0rUlwvK0kKgfHuutBCCWZS01jhPYlRqE
         nQoRO9hWvRT6cmtfEMCACSTPJ+Smr17eQiZtoACBQHTDapY12jQaRkG8Yr734EatObgS
         YF6qAbxCl5jC0YSGxi3gssr2DAJJdY15gUQFJVTgPzdrtxJTMM0QLWfvKj++aP7wYHwK
         dfCutighDDAWxnEkrkdZ2D5Kvnzyz1k0ItjNY0wgWRqs1PrLt5j9n+1s9gDi0dNJUA6K
         VY1Xk9Z8fe3bHEDE0rZZ0MzpHutEkFYF/IRjJ821HbOhUY8W08iRy6s4SW23KpWvHkhH
         MEkQ==
X-Gm-Message-State: AFq9FYJwbyQ1Mw09z07aQuPBLm9XnkqcmnJFo340k8NW5VFSiUu2UWmu
	mJI5AmfJJvJWSkslCdOLcznNbrEmFQusogl/igXyfgcGbKsJKAOGy54ij1CM1Q==
X-Gm-Gg: AYBFou25UJ5PV1YtcGDOJhnZlhgVaCQmgob0OsNPHQcVQ/sJEI6lvbosJSfSgqltJuL
	pnoiAZI2OL2U/+FNuQRa50opJZKThKuy+BWwyR7rG8b37vmoEyibbtfjwbaFDlp0paIKQYJgEAs
	nAx4yrJ1rS8AmrpQOTtwqDAIcjwBaFf4J2xqxe/HOoGI1NPVgpQkQe9QKNvcQxqnM0QWNxIAfMW
	KQxeSTvsLP8JcvzzvqenOJKo7hgQpDNLj53RsbxO10ATbs8xPXvHEQKwcZXCPkiPeUk+2D/UeGJ
	uEtPdp7yKsbJhZXdRoPLwHXSY+Vq3jg58hplKIOurlNgf2U3wRUDfRBC69SCrfWCB8gfOYVxC05
	WSuWGICpAKpSctcjr06Uw+I4+8mh+IkFWtldyNhbL6nGczOvVOLLlHudE0RBYS9yPCEUoDHoK+V
	qZ79Mp7EGtq6nyn+f2Ib3T9ebHmsA+7XPO/b+bzkJEr7YJw0aeymjAGgaWkKiUyY7RgPZRuRZ0h
	ss=
X-Received: by 2002:a17:90b:2ec4:b0:39e:574d:3d2f with SMTP id 98e67ed59e1d1-3ab3a39ee2fmr10521712a91.7.1791893277485;
        Tue, 13 Oct 2026 05:07:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ca0033sm20748094a91.2.2026.10.13.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:07:56 -0700 (PDT)
Message-Id: <06f6c774391bf8d6d40a30d0b7fef6c80596afca.1791893274.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 12:07:52 +0000
Subject: [PATCH v8 1/2] rerere: wait for MERGE_RR.lock before giving up
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

setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR, so when two
processes want it at the same time, the second one dies. That
used to be rare. Since 452b12c2e0 (builtin/maintenance: use
"geometric" strategy by default, 2026-02-24) the auto maintenance
after a commit runs "git rerere gc" whenever rr-cache has enough
stale entries, and the gc holds the lock while it prunes.

If a rebase's next pick conflicts while the gc holds the lock, the
rebase dies inside repo_rerere(), before the sequencer has written what
"git rebase --continue" needs. Every later "git rebase --continue"
then fails with "you have staged changes in your working tree".

Wait for the lock for up to rerere.lockTimeout milliseconds, 1000 by
default, and only then fail as before. Pruning a few thousand entries
takes well under a second, so the default covers a rebase that runs
into the gc.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  7 +++++
 rerere.c                         | 22 ++++++++++---
 t/t4200-rerere.sh                | 53 ++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..ab035e2d7d 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -10,3 +10,10 @@ rerere.enabled::
 	enabled if there is an `rr-cache` directory under the
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
+
+rerere.lockTimeout::
+	The length of time, in milliseconds, to wait for the rerere
+	lock when another process holds it, typically a background
+	`git rerere gc`.  Value 0 means not to wait at all; -1 means
+	to wait indefinitely.  Default is 1000 (i.e., wait for 1
+	second).
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
index 7bb601e117..94165c8417 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,59 @@ test_expect_success 'old records rest in peace' '
 	test_path_is_missing $rr2/preimage
 '
 
+test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "wait && rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	{
+		( sleep 1 && rm -f .git/MERGE_RR.lock ) &
+	} &&
+	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
+	test_grep ! "Unable to create.*MERGE_RR\.lock" err &&
+	test_grep "^=======\$" $rr/preimage
+'
+
+test_expect_success 'merge fails on a lock it cannot take' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
+	test_grep "Unable to create.*MERGE_RR\.lock" err &&
+	test_grep "^=======\$" a1 &&
+	test_path_is_missing $rr/preimage
+'
+
+test_expect_success 'rerere, forget, clear and gc fail on a lock they cannot take' '
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
+	test_grep "Unable to create.*MERGE_RR\.lock" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
+	test_grep "Unable to create.*MERGE_RR\.lock" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
+	test_grep "Unable to create.*MERGE_RR\.lock" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere gc 2>err &&
+	test_grep "Unable to create.*MERGE_RR\.lock" err
+'
+
+test_expect_success 'rebase --abort fails on a lock it cannot take' '
+	git reset --hard &&
+	git checkout -b lock-held-abort third &&
+	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
+	test_must_fail git rebase first &&
+	test_when_finished "test_might_fail git rebase --abort" &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rebase --abort 2>err &&
+	test_grep "Unable to create.*MERGE_RR\.lock" err &&
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

