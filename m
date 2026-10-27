Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098699;
	b=hdrmYJ85osQoBvBKBt/wON26yjp/LK1x6ucQcnKSqLZnTNgyq2rUu8J3EpursMzh61lf
	 TiYRyOa8Ml3cIQnPc0T/Zdpps36CyBgFQJDI8aVnCmEaEgtn0STbd+QNJNLNtAov5X9ah
	 apHJNTCZwSVdZy5giM3e4SmrDIWp7RMXjACzhFXJDdb37uGpLfEIyzLYTz57igxFXG0wR
	 v8wtNX93n0mEhgnyduvt47PC/vgT+O5IAAmw88NdMbl6mh7AwmknJXmTCgya9QoshW1XP
	 ok8IYV2ZS8E3q0kt2qqSJrgJlfqtQLvMZk+olceNuT7v5UnTCD1H2Xo1kBw2XUI/HFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YkinI9rsc9iGEZV1cYm1XSqF4Bvk5zujqWqV6NcseSw=;
	b=RSO6FUye4ZrOKmIbxAd1Y3OYXfMF86CR+G2gNFSsxukRZC8fCb1h7tKoJKGHulJ+xGTO
	 DLRt8uqa4dAHFP27mCiXD1IP86SATmJx39uIrfr7VjQCyFC3yhQHglON80bifBiPApYAb
	 Tr/qm2F8tmyDiM0hOkyUz5rtyD3pRBMkvZswdKTjpbAHe1z2zFZgYrd7fUoS8D+5EzNfI
	 J0EU/lBzogQc0HcaE1Ygs/FQChKUjyl5LH1WKqOfHQgoTDR5w04P3pIMHiT2WwmGSKxtu
	 8/9DamjCJd5/gVrM/66ZgSCUGCvKjb3ZlKQYxH35Kw2sKtMZxK/RR07eJScL2qFYmNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hpWKGyyX;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D77606A327
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D77606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hpWKGyyX
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso26745775e9.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098697; x=1793703497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YkinI9rsc9iGEZV1cYm1XSqF4Bvk5zujqWqV6NcseSw=;
        b=hpWKGyyXfOL1/lXc1BxD0n+EGZcfQBifbZ24XMC0IISmjCnwgsyrNe/SLzbd77tCV7
         N4E1rj3T3iY+36GAJdvurmfD6/5I4q+RxRnLl/kDRK48MWfFhwtsRZzjaduhbgqDCc0R
         tDxguJPCwWHbzacjzVBIpz2Scxu3RRsnY/Fh8wOY7/+qEQbBVl385wpvjwK4ict5/hIr
         Zbj2j/XxYGTw2WOds7oWu7Vlya7ONxzT5Jf2cloZvlS9oGOETDhvT/SYNNq8mTiu51k4
         cjyu6pcl5pD/3APG8MUl2sTHcqAt9epYTohe/dO8xlzoWX48ILETGXLNe3MeqTGiXpqR
         /QsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098697; x=1793703497;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkinI9rsc9iGEZV1cYm1XSqF4Bvk5zujqWqV6NcseSw=;
        b=xe2rjke3JNBWYR4U22u5lUfw2jlsV3L10cIGYKbCAXMBSE19zalGq/LzFSPPuwi3Ox
         PlHBWBd1d63U1LaZEPCcWGvTe4SCUVFZVOASx0JmrEvbabihgMMgbHkWHq9BLZ5FUoOo
         4fFr+tAguE/WoT5ksB8TASEpq5YH5xs8BhlaHHPBUtcj3wS+qMSLxTV3/72C/VwuvVlf
         d4P1SwxdXk7T52XG64cxscVHBhydZV2vY0Afru1DbUFiGBvaIznP9+yqbnVe4wAiNGyL
         cevZXg+Cs3/RRgVBNsU4ti2J6iI47jq13w4JTh5UHUZaaQ4bIOvUfdhHf0j92eduVrro
         fpJQ==
X-Gm-Message-State: AFq9FYIqJFiUM5EJ2kcXzAXb0pCfZ+GesJd2sLdTelA0n+9bAxfyNUFt
	64crWbRkUw98i7JB1KjMd87ewTZMmGTYgrVt8unhQ1RIbR3y+X7hPK6hfk12sw==
X-Gm-Gg: AYBFou3mUHrCYUB+LLQ82gyGDR3HmbHwobVLSGMskZ5CYyEndmhzVntyRDWAGlVws+c
	1LUm5jNgUwzginRE/fb6JcBQIp3AsDbOOxej+ELwiwphtXAMGMzI1WThjQi2q5vHtmCMsoH25a/
	LMU//yeaDEOv+ST9LOWXPk3DRGaXNhPWoZCfiz5JaLaGqgBpw8jZ0ma+9LLP/mkNzz4+44aMgIK
	Moqkh8F9wuYnxYdfyejM8xWnS2uVa8ebXzIegnWV7nMYuwP6W1iVrHEcz6XT89d6iYjJ7me8BSV
	q4TsHEDwltHzoo5dLm7NfOgD8L/BMzWvKneULQTVcTciPdc3nq+fWprZ3XwgKCSV+1sZlB+eHQh
	zn+g7BQ0ot6PCPyARYGKiP0mh1NLDs7YNNoBvYqyZJ8KGKY83lDOZ/6Sh5Tui7E0Nqs1bzWSiyd
	jwvu6AUGLKo6vmmewL0js++gtH5Z0do2naa3YxnhAWP1zQBAJIsVzdV5Z8hLalrlEax1jNIyUbP
	Y9ThZfovWuBE0+ZChPIpyXYqKJIykNoESxqOEOKA+sAdOwa91LHY6JyBdkpOm5AsYq9eC92xC9t
	pP5T
X-Received: by 2002:a05:600c:1c2a:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4a35ac3a7d9mr227508565e9.4.1793098697438;
        Tue, 27 Oct 2026 03:58:17 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm321638925e9.4.2026.10.27.03.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:58:16 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Long 76 <long76.git@mail.ru>,
	Matt Hunter <m@lfurio.us>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/3] sequencer: remove AUTO_MERGE at the end of a rebase
Date: Tue, 27 Oct 2026 10:57:57 +0000
Message-ID: <2fcb42a0858dffe45241cbced066dd0c0f5da76f.1793098652.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.336.g97505d19352
In-Reply-To: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
References: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are conflicts when picking a commit, the merge machinery
creates a ref called AUTO_MERGE that the user can use to compare their
conflict resolution to the conflicted result. The sequencer tries to
remove that ref on every iteration of the loop that picks commits,
but it is only written if we stop for conflicts, so it only needs
to be removed when we enter the loop, not on every iteration. The
ref is not removed after the loop has finished, which means that if
the last pick has conflicts it is left behind after the rebase has
finished. Fix this by removing the ref before the start of the loop
in pick_commits() as the last commit did for REBASE_HEAD. The tests
modified by the last commit are extended to check AUTO_MERGE as well.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                | 4 ++--
 t/t3403-rebase-skip.sh     | 2 ++
 t/t3407-rebase-abort.sh    | 2 ++
 t/t3418-rebase-continue.sh | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2d6a5f525c7..7a88b6530bf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5181,6 +5181,8 @@ static int pick_commits(struct repository *r,
 	unlink(rebase_path_amend());
 	unlink(rebase_path_patch());
 	unlink(git_path_merge_labels(r));
+	refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE", NULL,
+			REF_NO_DEREF);
 	refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD", NULL,
 			REF_NO_DEREF);
 
@@ -5209,8 +5211,6 @@ static int pick_commits(struct repository *r,
 			}
 			unlink(rebase_path_author_script());
 			unlink(git_path_merge_head(r));
-			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
-					NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK) {
 				if (!opts->verbose)
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index a2a5ac8ae01..d4fcfe567c4 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -100,8 +100,10 @@ test_debug 'gitk --all & sleep 1'
 test_expect_success 'skipping final pick removes REBASE_HEAD & .git/MERGE_MSG' '
 	test_must_fail git rebase --onto hello reverted-goodbye^ \
 		reverted-goodbye &&
+	git show-ref --verify AUTO_MERGE &&
 	test_cmp_rev reverted-goodbye REBASE_HEAD &&
 	git rebase --skip &&
+	test_ref_missing AUTO_MERGE &&
 	test_ref_missing REBASE_HEAD &&
 	test_path_is_missing .git/MERGE_MSG
 '
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 1703b5ae9b5..fdd9a2b9f61 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -35,8 +35,10 @@ testrebase() {
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$state_dir" &&
+		git show-ref --verify AUTO_MERGE &&
 		test_cmp_rev d REBASE_HEAD &&
 		git rebase --abort &&
+		test_ref_missing AUTO_MERGE &&
 		test_ref_missing REBASE_HEAD &&
 		check_head &&
 		test_path_is_missing "$state_dir"
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index f35cd130921..1c26bf5de54 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -39,9 +39,11 @@ test_expect_success 'merge based rebase --continue removes .git/MERGE_MSG' '
 	test_must_fail git rebase --onto main HEAD^ &&
 	git read-tree --reset -u HEAD &&
 	test_path_is_file .git/MERGE_MSG &&
+	git show-ref --verify AUTO_MERGE &&
 	test_cmp_rev commit-new-file-F2-on-topic-branch REBASE_HEAD &&
 	git rebase --continue &&
 	test_path_is_missing .git/MERGE_MSG &&
+	test_ref_missing AUTO_MERGE &&
 	test_ref_missing REBASE_HEAD
 '
 
-- 
2.56.0.336.g97505d19352

