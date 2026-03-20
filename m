Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2DC399376
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007313; cv=none; b=tHRQ2C+jKm3xTK5rKsjJ5rKTcc6iXQhFFfiFzGytctRR9ChySZnWLG/720H+TxjoGaIImakpeLLn1iffEL/UZ0za7ruvbv4pQX/DPRoqeOt+K2XwuhOuBQ3KIIikOXlLh5NuS2Vgb9KMlfs/SSAhQvpbwTl3NugwYJ8ZmQavZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007313; c=relaxed/simple;
	bh=3L7HVivVZ1n9eCBeiH+fe4yiGwqmsEI8BPwjIqddFkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngpRaRwjIcsYzOatpHWgcExM6+wkxAzhkMjKeU9Hy9Nf0zYBXow7j+3PgBYHeOINzg0gOuQjDf//hgGXL1nROQd53cv9mlwnfEC28Mp0lZlElxFgV52GM71Dl6Bb2oJ/G+5ljvM42neTmhzKpmOJuNBiNxIeM+8HsrZQEbQiue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9uf0lqk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9uf0lqk"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso263963a91.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774007311; x=1774612111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9jrIPRioXWez60rr9qG2KXcp1g/1MITz+CvUZtUqw8=;
        b=M9uf0lqkBaUTH2Ycj+fnU+j8gZQlDGntg/4uEioTwUq8o/NCGcGQvIsLVoFw5FdRgT
         j3N+RdJemD1hvMdx5kioIkpTdwrLQcTUVMvBrJeIBnONOKVfj5XUXWOWG1RYijVlO0fw
         0geztPcoZuNb4JT5XuoKaj14tdPiBXAnBXeawLrtP5BIBMy67GdhEGEnKgGDvi6ZJK2Z
         DTUGHHaGZ5bOQgX9Wkcqfi2R1WRHlUXfJ553aDDr9271+qGB+xyjO1a6XvYykQPYPJVH
         Hw/ifZNAIwhbGzwH8xvN/HgBGnqaOqqjJ+ozQcG2QpvjORdaxVPYWFJyD3S11Ixj0Cbm
         RaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774007311; x=1774612111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9jrIPRioXWez60rr9qG2KXcp1g/1MITz+CvUZtUqw8=;
        b=aihjedPgnW+gDNBZBmEHON8FXLSEkJoXkeNdM3o0zS3uNuu4nv9zQrDRz3+GG1mOng
         sD6a7S4GH1fHcVjmFtZr9dm4NQFEKneRuHQv9GKCV/Rh/l5OpP5eZkrEkEnlohlRh+gX
         Xx3sGRfp2FekKXe6CNWxekxumBCoDMIZzE5F1oudIxaMcL8Z/WNU2Skv/yoAjH5PggvB
         RCAQk/o7GhPtplNsThrkCZTdRfjcc/4Gq+nzLHUq4vhnftHNTO00rPQQu8/lv1vn0QoP
         VCpZjWuB8oTSL017DPLm3FBypXACphpszNHnJTNoOcxOdyi2x5SaCy5T54NBzqYbx5ss
         qOVw==
X-Gm-Message-State: AOJu0YzyK4EdP/vRR4E/WNosM4ueOrL17e27tAUJ/tpOGd8wwibDaFke
	OlSxxEx8I/OoLAe7wTmB797swGKxPuFrzrAzjgj/FiMa6d9i7XeYFgbv11X6O5eaW+k=
X-Gm-Gg: ATEYQzz3Nh1meaVYmwWepQYcG9K/NUgpU9s184dKmSseGQ9MzlJqNQ0gllRCSDAwGzu
	u26CmN3LpKPQf6VtF+INIgEnVQ8KC/gkyagExIdl4eVmoBkI0YS4rgJGAw0jASSwUZff88Nxq+Z
	WdjFPEqQ0X/t1HhXz5bft1ghERLeUGJdv5usJExZO+M309j1UqifRD9sg21OFEbbRGUXHcZBpoQ
	kEz77+DV0/BYl6g3EU0L7A/RVpaghO3LHVXkGIzkwJ3l1MWdkzW4cJX2S/Yo/nzXXbkBgvQlRbW
	HRBCLcjQPez175ypPdbBwF9SIqm6rkgbFqT9ARX19hxR5BXTVUe+EUp4X6+DYvhqOaqDNcKB7Pu
	ZTiB5KYZZsflGshzQBEo7Ula4sLBV8E3NAJlovSvnquyg8Fet3tZcKgqcMtifrEsPO35lis1eQK
	N3rjVmso3Fj1GIi8W7jsrPE2Q29dWyolJxp6uYPk2JsPJTfRgON+GonFGcKQFb7Adookok7PgEt
	o9GO2dSIR0/2jhQRluZ+34/4R31z45aIlD7yaAjP2NKxlfA+3Zwynkl55H+8Lm8sg==
X-Received: by 2002:a17:90a:c107:b0:35b:a30f:8bf1 with SMTP id 98e67ed59e1d1-35bd2b9e133mr2128575a91.6.1774007311251;
        Fri, 20 Mar 2026 04:48:31 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6 ([220.158.168.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff704bsm5219130a91.2.2026.03.20.04.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:48:30 -0700 (PDT)
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	stolee@gmail.com,
	Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Subject: [PATCH v1] path-walk: fix NULL pointer dereference in error message
Date: Fri, 20 Mar 2026 17:18:23 +0530
Message-ID: <20260320114823.3151961-1-ysinghcin@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When lookup_tree() or lookup_blob() cannot find a tree entry's object,
'o' is set to NULL via:

    o = child ? &child->object : NULL;

The subsequent null-check catches this correctly, but then dereferences
'o' to format the error message:

    error(_("failed to find object %s"), oid_to_hex(&o->oid));

This causes a segfault instead of the intended diagnostic output.

Fix this by using &entry.oid instead. 'entry' is the struct name_entry
populated by tree_entry() on each loop iteration and holds the OID of
the failing lookup -- which is exactly what the error should report.

This crash is reachable via git-backfill(1) when a tree entry's object
is absent from the local object database.

Signed-off-by: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
---
 path-walk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path-walk.c b/path-walk.c
index 364e4cfa19..839582380c 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -171,7 +171,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
 
 		if (!o) {
 			error(_("failed to find object %s"),
-			      oid_to_hex(&o->oid));
+			      oid_to_hex(&entry.oid));
 			return -1;
 		}
 
-- 
2.53.0.582.gca1db8a0f7

