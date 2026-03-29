Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AC292B44
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774809371; cv=none; b=MxljEYA+ZPRL5wU3bn4SdLQR9fEW6VeYRKVDjRO0KH2gyhtMehoHNbtneq8O6cerIF3HGpjMbzpJgnTvgjnUuOkhbW8jY9bRMWtdAP/S14In/H5lRoUjZi+67Zb0oQMXqCmDSxNsYjvlT0giWPG75G9DrQJmHx6ts5zMpbn7WhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774809371; c=relaxed/simple;
	bh=YiL5fAflkrpq23Uty8tl6m5m7YU5s67vlaVTyn/DsUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcjlndRloLSdh9D2QI/ly4jFAyWEB6hVZHboKGTHovg9jpYt0eAPZfO2/sje5a/j8vvCgK3jXwtfnUmcgnarUS6DuYTcOEVkgd68SVarB8uSfCFVYyeBzPCzfu7/hmmQdlFsaoCL/zo8lHPpyjG+Uq3w8NVun5xMYJn3ej+LHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtx8bEG1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtx8bEG1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso833978a91.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774809370; x=1775414170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAYv6dhbGmBjQu/vFnvB4nMEJz/dESKuhrymCZouGPk=;
        b=qtx8bEG1GmEdWq9EG9giAM8UGn/9A4OT/o3qpDWOWTk+BW+4WGmz4vbWMNnouGkDf+
         lpqetbXEeWW7/MukQdLhXexx49UQpgCRrVhkBlik7M9fud2FMYL6EqBc/9cmIf98QY70
         xmbAH6R68iMIPp/l7Fex+qLNoBMqxNS0rO40k1048Exg1+b3HEQEHp6uJjsaN3Q18NS3
         3lAG+loPx1Alm3b2srueTPRDxu80clpmSmf9iwPgwrJ48dZVelQQk5IXCL89LRrbWPoK
         mJfExf0aSTiFaUsDwUVOpgxIAEAGDoP/lK+MGMf5qnC96r/Y0obtGJhSfFjwIhKAXfeZ
         kgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774809370; x=1775414170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAYv6dhbGmBjQu/vFnvB4nMEJz/dESKuhrymCZouGPk=;
        b=HYeNAJrc8cgh1xW4yuyQrfNsTnpN1BW0d9yUAbuHTyNcLyLEC7Q0MPYU8E8tp55gHe
         MZT8i2TFuLl4VhNN9l4GdhG8jgKJJLAe9CDVgEPw/HgUPVluTevhngmj1NU54JqCKUhZ
         AzS0SoT/se+H75NjXMjQ7QMgQrci3NxJaZvHc2SbCdktMEop3FXPIeZwvUlvARcN4Zk9
         l5RGZ9Flmex4Z+KB8rXnQLQInLs5LlcTTz5CcciL5dMYPpd8EisbVWem+dbKWOnG6OAg
         qLP8dBvWbMDDT2a2AdM6P0wUSichdzQwRnrxbUwN0GFpceMQBar5Jy85Y+4n4SQZW7b6
         ppHg==
X-Gm-Message-State: AOJu0YwHdXlRFoD4E+nYcw0ZryL1nzO2CYf4tmEcq4o4SpOM2l5f3Xsk
	cDZ9hNWr6QMqoBRJYn1WbI5k2iqcl8WiY6xTWi77Kpv7KjP9W778B7lL8OWNbwMQ
X-Gm-Gg: ATEYQzy9LyYymnuhRHu70r2LXq4OVwLWvuSq/tNVnWDDAfypb8bwOV0M1fd3jPJtrP0
	LU3aVgEk6xPR+4uSWuIOGd3S95z2AziFTQd/esZnlJ7iBJS3Arqc9Ynp/hIH7YqDY2CZ2Ykz18c
	39dZKNdQN7LqxNJRfdJbXdNQIDUhHZ8aV5ytmmaPbAo8xRy1TtLijLEwv5tLLUE44D0z2scqtbE
	AlplYQCAHsUPJxRjYgt9fo4AOtk49/YB04gQsw4B2bDG/K24tUyra+2QSztJ3oOc/UBJzPn7t0p
	w2ZWYcVqVqnV9OuYnQKE6fbLoSrpiYp5zfLMPuHYBsrSGSP/Z5IPWc2gfYKcDYbXWgUcJM8sWKu
	uZwY0moh9ZELoVGlFVqx6D/CAPXah+8vm7m3fxlxKyizFnTMQ4BPPClmMwwDAqTwTaDU9OmcBPS
	0z73RTMnZpAHX4xmBc0YwmQ/xN1ucG9KwZnzs04z8rjzT3kZj8A3urQPcuGS4rRkBSh9ohG/r2/
	7LbAfKWNvji5Kgw0uGk
X-Received: by 2002:a17:902:f542:b0:2ae:6133:d170 with SMTP id d9443c01a7336-2b0cdc3ec8dmr102748755ad.20.1774809369583;
        Sun, 29 Mar 2026 11:36:09 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242680148sm53467025ad.31.2026.03.29.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 11:36:09 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH] backfill: error out when HEAD cannot be parsed
Date: Mon, 30 Mar 2026 03:36:03 +0900
Message-ID: <20260329183603.538241-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_revision_arg() returns non-zero on failure, but do_backfill()
ignored the return value. On an empty repo with no commits, HEAD is
unborn and handle_revision_arg() fails, but backfill silently
continues with an empty revision walk and exits zero, looks like
success but did nothing.

Check the return value and propagate the error, consistent with
how builtin/pack-objects.c handles handle_revision_arg() failures.

Add a test to verify that backfill on an empty repository fails
with a clear error message.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 builtin/backfill.c  | 3 ++-
 t/t5620-backfill.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 27a301f9b2..4b2db94173 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -96,7 +96,8 @@ static int do_backfill(struct backfill_context *ctx)
 	}
 
 	repo_init_revisions(ctx->repo, &revs, "");
-	handle_revision_arg("HEAD", &revs, 0, 0);
+	if (handle_revision_arg("HEAD", &revs, 0, 0))
+		return error(_("unable to parse HEAD revision"));
 
 	info.blobs = 1;
 	info.tags = info.commits = info.trees = 0;
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index ff67e8ecea..91b5115732 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -101,6 +101,12 @@ test_expect_success 'backfill no flag on non-TTY is silent' '
 	test_grep ! "Downloading batches" err
 '
 
+test_expect_success 'backfill on empty repo fails gracefully' '
+	git init empty-repo &&
+	test_must_fail git -C empty-repo backfill 2>err &&
+	grep "unable to parse HEAD" err
+'
+
 test_expect_success 'backfill --sparse without sparse-checkout fails' '
 	git init not-sparse &&
 	test_must_fail git -C not-sparse backfill --sparse 2>err &&
-- 
2.43.0

