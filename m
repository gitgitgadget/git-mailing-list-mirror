Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86622259F
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767283170; cv=none; b=D+ZKLrBcqASIqpHShXbiIxsuF4q9aidA4Uwf3Ams4iqp5C69AN+MpYKgGaPZcDciA8hUMCOddb2eJvkmPxxB7tlRU/ZR1h9/Q3Y4giZ3p/d2f6gJdGILUkWxEwLCxp+JfsqGev98yBsc1wQe3tp5G9e7sS6YoSu5C3vhObVWWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767283170; c=relaxed/simple;
	bh=VY5pL/V9s4pV4edXrE2TsC3NF3HyWrj03JSljyGkjRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIlnCm36Tt+MzBj6FLqFWLHqjYT1RiJP4b33/OVurnDDxoDJ+wzOmb/pyj/s9eGD/MSn9X4mWyUiCQsX86sRP0EbZtRlbU4QouTTVXTqCTVvzF+qYERiF44oXFm/e0spn1HRNFZXZsGMRsZY9OaHT+YRyOE7/r8sy0aPahhVWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyrmXrzg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyrmXrzg"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34b75f7a134so8413992a91.0
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767283168; x=1767887968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xeymfhzYJ07TMPoWgJHxgOi1o54aTx1E0cDwlpRhk+k=;
        b=DyrmXrzgvYrt8Y13CpLrr9lvVbiU8hOs5lR+4okEC3vrKUGTgJCEZz1GaAoUGbEo/C
         p7gfKQi9aPfKBo8AFqhvfQj6YYyhmd05u/8QagxMjo6suYE7BUcbwAs//ytm2UKnPVhG
         tQlTPQ2zo1ZEWYKryGXh4ls1F4eAyqOmPBKOWdqitgPVjpJWSePwRMMGXijhilqihAht
         gVZdZ5oXBdc4IDu7kqIPsO8Pjli/GG0PYJXylc7tqZLJQ2empNpED0PiHoxPa4OUB1hs
         107ZlkzpEo3mnGGrnV2hmvX0N/QownTY8JOubcqiOdVQzvQ3FREG2ZEj5iqpoU06UGsw
         AM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767283168; x=1767887968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeymfhzYJ07TMPoWgJHxgOi1o54aTx1E0cDwlpRhk+k=;
        b=I7ssyNWOxzTmSvBvX2e8R/O6PxCuNl8O/vNdfTP3VgT6vZ7LztyYFx2kKDJtWu3APl
         DcT92id/Yh12QdzhFBQDmMwgrfPhiRuKAgH6GHW0BOe59JVQOEAbNFVw823v9HcRPVz4
         P0R/9ulOo/3bN72mR1Db3p5/1bx+vKj+7NNJJiWkoOHfLPGvntMl57bT1A1imTjZJ0/t
         Vh4ERcqSJHPtHMNZ1vwX758r+hETrVPhB7UEU9zjcOmgUWGbzgdYHtCnAOnB8R0tcFsY
         j089FjAV8ZY3FTmDVo8nwTAvvPaA6JHF3Ug/26nwNF3PQqH5oB0ZkTv6IgmwTpSBSBcj
         yMGg==
X-Gm-Message-State: AOJu0Yy/W8PyQkroubrdvbJugQESWNGnGdwOu6vAdm9I2VtqJ6CJEoPC
	luKriY69muJDBylHpA4gn14La0zpG7YAsSeoNWpgEWVwRLcvrxhnbDA/goH1L03r
X-Gm-Gg: AY/fxX74SRDKVfyrtI2X+62sMkUfJT+hTQlBZGRUsgoJf0FQ7TrGPLb1iXZwI+2iAbP
	qksBikgRfK4rqzkmQsx5ZBusWRj+rjzvU9vFVWg/8fFpAAnyOIXQlcTErqMiI5xHz81aUn86RXP
	N8leDnYYd0bdfuhAQwmd+jR+rLxxs8jJWzZ/YUfHo4mx3V5Xfsr7mNACG8Y3LQerHhImy/Hen88
	UK467o8X++xDy4NH7b2BAI7vsSaBc247/9nXM1LSB9AeCoz1cUTy0LYNk/TCNykianZkZm9Ykyk
	3pU+B5W96bbkQFY5mnSQ6GLfVMi5XczmXdbVq9SYBjpCgGEfJc7AOt37wZvtmTFfuvnVwrN42m/
	FQRKMs+maZ9lBvYmF3p8Bs/Do0aOsyqZEQfgAPUvpcyCuRxCk2V4hs0Vzb3Nk0SPICyOIYZG1K6
	hZbtTPw9CbsM2u5EGNMEPKpk4l/tCZLjsf
X-Google-Smtp-Source: AGHT+IH+nRCXQXfOgZQfcN+yMM+UCy+TJYMwnuE1gG17cZv6jBH2szQoDbrS+KsSQ0jAK7krp2PQdA==
X-Received: by 2002:a17:90b:4ad1:b0:34e:5aa2:cf68 with SMTP id 98e67ed59e1d1-34e921e7148mr35026450a91.30.1767283167644;
        Thu, 01 Jan 2026 07:59:27 -0800 (PST)
Received: from Fedora-Gink ([2405:201:c005:b959:acb7:a699:c03a:f9fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm39107056a91.3.2026.01.01.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 07:59:27 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com
Subject: [GSoC] [PATCH] t7012: turn TODOs into tests for skip-worktree operations
Date: Thu,  1 Jan 2026 21:29:16 +0530
Message-ID: <20260101155916.635049-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The t7012-skip-worktree-writing.sh test script contained several
placeholders marked with '#TODO test_expect_failure ... false',
indicating intended test coverage for skip-worktree interactions
that had not yet been implemented.

Implement these tests to verify the behavior of git-apply, git-mv,
and git-checkout when dealing with skip-worktree entries.

The results of the new tests are:
1. git-apply (adding a file): Works correctly.
2. git-mv (to skip-worktree): Works correctly.
3. git-checkout: Works correctly (updates index despite missing file).

4. git-apply (update/remove): Fails as expected.
5. git-mv (from skip-worktree): Fails as expected.

Tests that pass have been marked as 'test_expect_success', while
those that confirm known bugs are marked as 'test_expect_failure'.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 t/t7012-skip-worktree-writing.sh | 101 +++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index cd5c20fe51..7e6c529b6f 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -188,11 +188,100 @@ test_expect_success 'stash restore in sparse checkout' '
 	)
 '
 
-#TODO test_expect_failure 'git-apply adds file' false
-#TODO test_expect_failure 'git-apply updates file' false
-#TODO test_expect_failure 'git-apply removes file' false
-#TODO test_expect_failure 'git-mv to skip-worktree' false
-#TODO test_expect_failure 'git-mv from skip-worktree' false
-#TODO test_expect_failure 'git-checkout' false
+test_expect_success 'setup patches' '
+	test_commit setup_apply &&
+
+	# 1. Modify patch
+	echo modified >setup_apply.t &&
+	git diff setup_apply.t >modify.patch &&
+	git checkout setup_apply.t &&
+
+	# 2. Remove patch
+	rm setup_apply.t &&
+	git diff -- setup_apply.t >remove.patch &&
+	git checkout setup_apply.t &&
+
+	# 3. Add patch
+	echo new >newfile.t &&
+	git add newfile.t &&
+	git diff --cached newfile.t >add.patch &&
+	git rm --cached newfile.t &&
+	rm newfile.t
+'
+
+test_expect_success 'git-apply adds file' '
+	test_when_finished "git update-index --no-skip-worktree newfile.t" &&
+
+	>newfile.t &&
+	git add newfile.t &&
+	git update-index --skip-worktree newfile.t &&
+	rm newfile.t &&
+
+	git apply add.patch
+'
+
+test_expect_failure 'git-apply updates file' '
+	test_when_finished "git update-index --no-skip-worktree setup_apply.t" &&
+
+	git update-index --skip-worktree setup_apply.t &&
+	rm setup_apply.t &&
+
+	git apply modify.patch
+'
+
+test_expect_failure 'git-apply removes file' '
+	test_when_finished "git update-index --no-skip-worktree setup_apply.t" &&
+
+	git update-index --skip-worktree setup_apply.t &&
+	rm setup_apply.t &&
+
+	git apply remove.patch
+'
+
+test_expect_success 'git-mv to skip-worktree' '
+	test_when_finished "git update-index --no-skip-worktree dest.t" &&
+
+	test_commit mv_source &&
+	>dest.t &&
+	git add dest.t &&
+	git update-index --skip-worktree dest.t &&
+	rm dest.t &&
+
+	git mv mv_source.t dest.t
+'
+
+test_expect_failure 'git-mv from skip-worktree' '
+	test_when_finished "git update-index --no-skip-worktree mv_skip.t" &&
+
+	test_commit mv_skip &&
+	git update-index --skip-worktree mv_skip.t &&
+	rm mv_skip.t &&
+
+	git mv mv_skip.t moved_skip.t &&
+	git ls-files --error-unmatch moved_skip.t
+'
+
+test_expect_success 'git-checkout' '
+	test_create_repo checkout_test &&
+	(
+		cd checkout_test &&
+		git checkout -B master &&
+
+		test_commit checkout_base &&
+		git checkout -b side &&
+		test_commit modified_checkout &&
+		git checkout master &&
+
+		git update-index --skip-worktree checkout_base.t &&
+		rm checkout_base.t &&
+
+		git checkout side &&
+
+		test_path_is_missing checkout_base.t &&
+		git rev-parse :checkout_base.t >actual &&
+		git rev-parse side:checkout_base.t >expect &&
+		test_cmp expect actual
+	)
+'
 
 test_done
-- 
2.52.0

