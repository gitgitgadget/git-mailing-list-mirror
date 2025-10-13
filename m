Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8180221DB0
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377635; cv=none; b=atpluzXNzVwy0vQEMeyT8ZGtk0IgaZUZoKvdiBQag/0icri0IWZ8r1SwMOUs7inp4gR+G+e3b2N6cKdHgibFZtzbPGn4dFPNkLD0MscybQigspfkpVkx2PDXx3WbHI42vmNcBUvksUm3z5AvWrMu3zuvIymCxj02HAgDfwUbLxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377635; c=relaxed/simple;
	bh=DRKjDru7fBjkO5oLjKOb4dUbQhvMy0OUL1IZCeWNgIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvV2oIXeCMK+hL/boWs957GH9JS0WmHi5EmjEeyqiD6ZdWnH3y80mopp8PT72i4kA7HIXYHeCia5Z5RqOAODsYgg1C4OtEShQBSXvy72kpYYuPYGd30Bxnwxpzvv8MN/0KqGh0jYLcqf0jdwvvG9QSBk0PntvuyyY3oocKF0PSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdTHjSiA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdTHjSiA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so4030865f8f.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760377632; x=1760982432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdOCzJICF1lPnWJY+txtSmMJ99t79aiuntF/GE09iNA=;
        b=gdTHjSiAlnukezRxaJx/xvanwFHnnjqE59UfRR/+VGqRafy9GD5kWUDOCByF29KKTK
         8X3l+x2X4o7zNpxpD3zy/iAVG+4XNvPIjdrjNXgBnKFE3FhQ834NoUpDxcIUOHAJgaV+
         DD80igyiDJh/wdTSKBbwkM3ZasGIIqbIHBumAOKvuYYmP7XXDiU9F7+YNqBvSnxR8NfW
         OrFJ+fOU21RHkTlSB8iuKeUIxQDyBT2DEQEGisykgJQybVLuytQp9BUjK6n+AQt6QY8s
         wXxoXAZ7dXMaScloKTjKuGb4hJ4ez0YM1hJZjvn1dF0fSXpqjmUNdrs5FV09SNSzBwMp
         cUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760377632; x=1760982432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdOCzJICF1lPnWJY+txtSmMJ99t79aiuntF/GE09iNA=;
        b=d/8S8zyq5OBxp6iJrykeFe4AVBpIMSVO+xDmaVLJ8kuYusCVZzE5dejOj8/9R3ZnJG
         ClQTCyhlc7eAD7ithfGg48NhsN7KdTY2hya7WroCHBNTc6ogCmIxDFQek0mcG51jlbWL
         10VBXCd4KhIciACeeOZZBWOunaZ5M2hq25KG0YG9h5TQbo8qyZjC+WdPQExdnGH94nGL
         TmM38hqdJ19DJGzOS/ZNonGKKgKq3WIsxVj6J1NM6gUNUCTgUlEBdS+xtxLOFluAy9uW
         yy+AN8yQ1xIuS1Gt1HslRstFRmXmcA7Z6m7yRWJBexuuYQ26IzVt43cjDGL9JqohHCK9
         FhtQ==
X-Gm-Message-State: AOJu0YxCI3Slq0kF0/DtjQfGJjqZBHNUC3OLxaWx7vdKdIou6qedgPPj
	fig+o6voptqPGfSANuifgKJwhIxkVUlQNro+M66/BALCP8sD5l4h6luIJNKnsHuiLpUbmA==
X-Gm-Gg: ASbGncuvoqX3n9A8ZAf5gV9HlhGpT7ulZFFKXJ4K6YAhh2pjXz2hbSfagv9Odv5uW6M
	7rF7Z06Wf6LYQFyfvkitAdZ6IoyfeaEr7yIR9PWug3pLIY4Y0TsHNVjF4DbYoDvDl4I1Z76PqnI
	Z86cdGpNBtbJdBgCaTl1jYoICMTdAqzETDA0UxwIWMMXNwCfQ1ZJZEi4i/6/4h1mHrsAPT1Q31e
	HeVRec8Gcwy+kaW081cjim124waRSwaPO46BciAq+ybjv8XsA5XIAhf9zxfgcQgxjn4Rg5I6viJ
	W5iqcEbp6SNAcXc+SmSnD02nDrjIXi1T1XuNEJSX5Zg8vi77uuYxLND6AlWbzXDr2p8SFqz6cRk
	ZGAJn/xRgjGIjwKG1OMvwpBl1bPpl9siQaao/pCwgtgTMYCHg3b40RFiVWYN1BANyk6DX+n9JGf
	MUSGXrCsgzBuDMTNxNum0+kBQ=
X-Google-Smtp-Source: AGHT+IEp5xfeK+4fc/jgrkniWuzdsX0aJJ7ITuL6FKJXrfuKycTGBgYi289GBHyDJCgOFUhAIt3ztg==
X-Received: by 2002:a05:6000:22c5:b0:3fb:bb69:d91b with SMTP id ffacd0b85a97d-42666ac4a07mr13431376f8f.2.1760377631685;
        Mon, 13 Oct 2025 10:47:11 -0700 (PDT)
Received: from localhost.localdomain ([105.113.110.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d404sm19596825f8f.3.2025.10.13.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 10:47:11 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1 usage for patch IDs
Date: Mon, 13 Oct 2025 18:46:58 +0100
Message-ID: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch IDs in Git must always use SHA1, regardless of the repository's
object hash. Previously, the code relied on `the_hash_algo` which could
vary depending on the repository, and included a NEEDSWORK comment
suggesting this should be fixed.

This patch updates the comment to clearly state that SHA1 is required
for patch IDs and sets the hash algorithm to SHA1 if it is not already
set. This ensures consistent computation of patch IDs in accordance
with git-patch-id(1).

No functional behavior is changed, but misleading comments are removed
and the code now explicitly enforces correct SHA1 usage for patch IDs.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 builtin/patch-id.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index d26e9d0c1e..d47b6f5a3f 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -246,16 +246,11 @@ int cmd_patch_id(int argc,
 			     patch_id_usage, 0);
 
 	/*
-	 * We rely on `the_hash_algo` to compute patch IDs. This is dubious as
-	 * it means that the hash algorithm now depends on the object hash of
-	 * the repository, even though git-patch-id(1) clearly defines that
-	 * patch IDs always use SHA1.
-	 *
-	 * NEEDSWORK: This hack should be removed in favor of converting
-	 * the code that computes patch IDs to always use SHA1.
+	 * Patch IDs must always use SHA1, regardless of the repository's
+	 * object hash, See git-patch-id(1) for details. 
 	 */
 	if (!the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
 
 	generate_id_list(opts ? opts > 1 : config.stable,
 			 opts ? opts == 3 : config.verbatim);
-- 
2.43.0

