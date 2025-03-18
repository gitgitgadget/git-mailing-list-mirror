Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D331922FD
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296588; cv=none; b=A82OhZ6BXVH6vSDlMjUp/WMRDTNcuCgXIlXJ1gv3aMCdo5O5XUb+zyr2FiKeJd7bFXYhTwVhgruAKF5MPoIMMh+7wyQbf1I4O9sSYhVS3EP9YZaEajUB5oA2e0i8U3PKQwfCASzHYgB+2aFdipkshQ6ZhH0kiMTSKXyM0S55bHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296588; c=relaxed/simple;
	bh=yLR0c4bdLKFHulJmE/VRgIiV3qG6Yv2Fg7A3/UAJ58c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRsiPo2U1p/uhPLm0Ylrub0rFvBcKWminkfqTv3cyVeSH1gIdgHZCfVomsl4JNsB0L72+YYRZs107T4MaciAVRkeYg0rixtRVVKuDP8OYiufmFso9BJTiWnGrwF3ZcSQOfFnJkqfNeTnx7yDgUE3m5Jc0QBAC/zmN+XhnpKFtv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvQY1ISQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvQY1ISQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225b5448519so101452935ad.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742296585; x=1742901385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALJupLDkIBbGbD3ZOJhXYzaHVTUzVilUYmH+is2/XiU=;
        b=RvQY1ISQDqlLq8QucTJCEXqPeN5F+ZbV5EOolhYmxJf2vb6GDHZ2LO2rtTEgFuT5l5
         ZtRymkS90U2T+uzkpYXiWCZLZILmj6jBwOetyyN4hdQWAnogm/Sc3eugCarjyzHKkbLo
         KmaUAn9GkxNt7utg2n1ASw1hpBQCsqB68WvBiPZNDB+zfA4Dy3+fqjb42WSh2q8IyKsZ
         y48mLI9RVG7vhqWcGOCyA20vPhbGaeqoR4OmpSECvM5jz/iNENlLVA0yYNPdQsE5oB2s
         5KoEPuNCxtlH9xKgs7wfhIzqVjJsM9WesVPFqxY1uzz2y9DH565uUiogkxVVE9r3Oipk
         qprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742296585; x=1742901385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALJupLDkIBbGbD3ZOJhXYzaHVTUzVilUYmH+is2/XiU=;
        b=A42czcdBMM3dZz+xzzZ6VzxkaR7roM20rArY+Vc05cOBXTMz2dH/t+BVAOF6gswipe
         9y/MHrnVakql3ZwJRsQbQ5w+KapZ/zAoyS3YN7yo8gd/1AKiv62ytm/Ft+9u9aK7yd32
         1tev7ZIf9MiT9yYPWFwvmq6vg8jIvrhGkWFdHIlIEhGzAti/uNjWCF1nHFcWoTSbGV+F
         0+z3eHqyaRT8I67ixbqhIyG3EH+f0wqx3iQkmvWvxg5eXhM9j3EbwmOxxVTYNEnIg/iO
         J+dYtqJ1xA5WKqH/JpV70Z2cVMe5WG8tOk8TeX0nq9xGXSshIYTrRZbDF+qcgERIo838
         2jnA==
X-Gm-Message-State: AOJu0YxmkpHaBqS4titdFcg0dczcudfkDPQOmsOtL6eYaOHufmDDRPM6
	DF+ujgxleziuPZ9pX6YC+5yAtCaFyaxq+0GWQks7OWVDTxrYi7xUMxsK6nz5iB4=
X-Gm-Gg: ASbGncuQER9WcSkO9ahRI+QlWc/1k1VSyrPD6Nfqbi7Wm/AoujDvo5d0dINnFx6ODuy
	MRQV8uPOV5uyu4ynOj0nkvuUMY0tzsbZQqfcCjimHfms6Z+gmjyVYqxlCLky2cj5JG+Utt/C62i
	TlTWcshhH+yE6SnkZ5BNLNWo07qvs5Hv5b99yj0d8gPWl6ifsfCFlu7qar0Ki0Chltg6AnnTEP2
	silyUurce0VJ8q23BiLeSl6NNXTPxdwI07GBI9WJTdFCI0rumhsAsGM97NW7Lkv9A4WEUnx+9zV
	UXqAgV7KG1soL4UkJ2q7P6BV2iDYq3zIMJum47A2PSC+TBut7iBUOZE6A7RhDdM=
X-Google-Smtp-Source: AGHT+IG0MiVK3/hZ/vSPWkmn7Tx0DaeeCSzTOpjX9I8qKxvN7gAde6jgDqN/WJhCxSI2ueRRwoucnA==
X-Received: by 2002:a17:902:e750:b0:223:66bc:f1de with SMTP id d9443c01a7336-225e0a67c2dmr223562775ad.21.1742296585580;
        Tue, 18 Mar 2025 04:16:25 -0700 (PDT)
Received: from localhost.localdomain ([119.130.107.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbcdd2sm91599995ad.172.2025.03.18.04.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:16:25 -0700 (PDT)
From: Jensen Huang <hmz007@gmail.com>
To: git@vger.kernel.org
Cc: Jensen Huang <hmz007@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] index-pack, unpack-objects: restore missing ->init_fn
Date: Tue, 18 Mar 2025 19:16:10 +0800
Message-ID: <20250318111616.113941-1-hmz007@gmail.com>
X-Mailer: git-send-email 2.49.0-1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0578f1e66a ("global: adapt callers to use generic hash context helpers")
accidentally removed `->init_fn`, which is required for OpenSSL 3+ SHA1.

This fixes the following error on fetch:
  fatal: fetch-pack: invalid index-pack output

Signed-off-by: Jensen Huang <hmz007@gmail.com>
---
 builtin/index-pack.c     | 1 +
 builtin/unpack-objects.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 52cc97d52c..50573ba049 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1286,6 +1286,7 @@ static void parse_pack_objects(unsigned char *hash)
 
 	/* Check pack integrity */
 	flush();
+	the_hash_algo->init_fn(&tmp_ctx);
 	git_hash_clone(&tmp_ctx, &input_ctx);
 	git_hash_final(hash, &tmp_ctx);
 	if (!hasheq(fill(the_hash_algo->rawsz), hash, the_repository->hash_algo))
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8383bcf404..c5a6dca856 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -668,6 +668,7 @@ int cmd_unpack_objects(int argc,
 	the_hash_algo->init_fn(&ctx);
 	unpack_all();
 	git_hash_update(&ctx, buffer, offset);
+	the_hash_algo->init_fn(&tmp_ctx);
 	git_hash_clone(&tmp_ctx, &ctx);
 	git_hash_final_oid(&oid, &tmp_ctx);
 	if (strict) {
-- 
2.49.0-1

