Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A625A357
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762816; cv=none; b=Da48u4IhIp5PBymK9RfD88jWbBXpYTP1FTxD5dGBVaxy7yg9SJV/ZIdc8sc8YJmmPnNHre6drM12yCA1xe19pSitDd0HRYACVJFcZLUehDPIhDtr2BEzDx/T1DJ8/UeGub6MMCmE8Lw0MWEaBf1nWsqouf73XgcY0+n9svt+OQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762816; c=relaxed/simple;
	bh=8e41KL0xwIo9xvHGbZB4u2MDkB0G2vsoEJh2/ysi+C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBKM54ypoFL9f17tFUDyvBlkOrm8ATEwKwwYI7HGP67RmtGBB6sC/uX7Ko7ghCavCOeQgtfLZwUXEcm4jbwXpl9Mflc51zl5L/7Bsz91FvMif0OragRPU/sevopdVft0qkOawS2D8DUuKmbxiQDBFghClPSDsPuh8KZR1SM4RvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqZbOsmZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqZbOsmZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a8fba3f769so28336115ad.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773762815; x=1774367615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+1wmXlYk25fH/exeh38+ojr0EL8Z9zxPHnx4S1ee2w=;
        b=HqZbOsmZqZ8D2SyrDzYHri92OKGhWtb3abFC4I9jmJmr8Wsi2J9miu+EHrsGUgtvjJ
         z9Y3+Ue8kKIvWy8GKVADQgbxMltFBF2cb8zlM1v/UBzKbLzBvDThiwDHP4cdDYTYeVEN
         pEELEFnVxaRgA8P2i1APZOZq/TAHNIBT62nLcuLFk80XyWkrp0i+hNp8LIxvV7RNOWlb
         /3Lg2JEdy/VjKWDEW+uALIGy9pB002hwTNh/fP3Vxmz8NQUlNVYAc2kPKAozNUim1vgF
         VUa+1m/i1d9ie8IMR3pQzjAMM8ysiDzaHWCbdMGgSavuUEox15en4i+qezN5LSl4DYDC
         9t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773762815; x=1774367615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+1wmXlYk25fH/exeh38+ojr0EL8Z9zxPHnx4S1ee2w=;
        b=W2Jmt8/rilrtqlX2Pp7oAPXlNrEHZ0kRQvZzKK/QuI03tY4++GJRFSa0HuRbZen+pn
         B0ena1X59+mJnHx/+c6khRwcxdDhxcthdsbiq1Xzfj5FDcnFOEXTd+r9PGiCADAHCktA
         hHed5FNKQL/FF/v25epWAW5mCfeuS8ifiwsUyzkCTSPF0C2Ud1VoDfkyGR49y6k7uatG
         m/EX/0GJGEMPlzmIHaX1p0oGA8wu1+W2ARTXVHhnLfUAmoWtsAylixOVdmdvqMrtiTCZ
         Rz5LW9F/ZE6sIqJb8fkpUZRjb0RtoOgb11dklK2vLKMsWwMjkN2wIVgb+HyifKJjzwsf
         EW7w==
X-Gm-Message-State: AOJu0YzPukJAKl6c3WTrLhqS5HF7srp4cfjgfZwL8b+LSfsC0fzODlsW
	qgnQoQjCbhj3ty0vIYIJedIZvrytA5u4cm26GfVMaBMYkU82MoEBnCNI9XkaoQ==
X-Gm-Gg: ATEYQzwVp3XnaCqeqx0WjwbEpVSUWQpmSMfJJ9VZ80XLp4UsMuJkRWLZJfN/rFHZZgi
	i/uMzq1bPv+qJDiahpEi8T7PT1nq47hDRDNH/86SH1H+6Mpokf2wZwikTElzXDOPcOUGvNSEGoH
	mkyDeSU3E/7/9VY9WuoW8I6Ma4HVqcDsD3q4vGHdBUGOPwp+qApZFCufixIHXVGOaT6EoQheVy7
	BDmvRjpuFwyC04XTfw96N/pv6Pan//wGo6uwS+8bO997yOFL7TJCM5eE47fC3/kHz5Adu4+v6et
	mEOQ/m3dvm3aMkKvR7dRMvupuraploGXwe+hf6CsA7FGespey/PTh5Qsj3+Nr3hA82Zs/ehM9cD
	xL98ad9AP25JRAR6X97Uskxqx6kF4Dk6TgW5vH0Yrfj8XxyxOlyeNr4zQONnm+ZoPF4XDBY0DX8
	CR3tnYTgSwRiS3ziDnkFZEjKMJJoXEApcXXxVIGVFdknA=
X-Received: by 2002:a17:903:2ca:b0:2b0:3f76:9e9e with SMTP id d9443c01a7336-2b03f76aac0mr134493265ad.52.1773762814844;
        Tue, 17 Mar 2026 08:53:34 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:4c9f:12cd:260b:8809:a4e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece5c0f7asm148360085ad.22.2026.03.17.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:53:34 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH] add-patch: use repository instance from add_i_state instead of the_repository
Date: Tue, 17 Mar 2026 21:20:29 +0530
Message-ID: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions parse_diff(), edit_hunk_manually() and patch_update_file() use
the_repository even though a repository instance is already available via
struct add_i_state s which is defined in struct add_p_state *s.

Use 's->s.r' instead of the_repository to avoid relying on global state. All
callers pass a valid add_p_state and this does not change any behavior.

This aligns with the ongoing effort to reduce usage of the_repository global
state.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 add-patch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8c03f710d3..30df920723 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -434,8 +434,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 		strvec_push(&args,
 			    /* could be on an unborn branch */
 			    !strcmp("HEAD", s->revision) &&
-			    repo_get_oid(the_repository, "HEAD", &oid) ?
-			    empty_tree_oid_hex(the_repository->hash_algo) : s->revision);
+			    repo_get_oid(s->s.r, "HEAD", &oid) ?
+			    empty_tree_oid_hex(s->s.r->hash_algo) : s->revision);
 	}
 	color_arg_index = args.nr;
 	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
@@ -1147,7 +1147,7 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 				"removed, then the edit is\n"
 				"aborted and the hunk is left unchanged.\n"));

-	if (strbuf_edit_interactively(the_repository, &s->buf,
+	if (strbuf_edit_interactively(s->s.r, &s->buf,
 				      "addp-hunk-edit.diff", NULL) < 0)
 		return -1;

@@ -1551,7 +1551,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
 				if (use_pager) {
-					setup_pager(the_repository);
+					setup_pager(s->s.r);
 					sigchain_push(SIGPIPE, SIG_IGN);
 				}
 				render_hunk(s, hunk, 0, colored, &s->buf);
--
2.53.0

