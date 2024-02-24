Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4211190
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774078; cv=none; b=BM0YHSoFcCZXx+d0rXQuB/3OrUpy5ZPAnR9RDK3cs5YUznOXS4fZb17cs34ZnNBWGo8X9ccOYnBPoyzeBDFCYvNA945OosZg+hwnbCUnsQkG2BlD5TvgvnNm5cVn73gxsmUsc1yAVpBG5XJGKjFRSWPYZrXgwHcJC/7wQA2iY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774078; c=relaxed/simple;
	bh=SfT4UdvkEXGhWa3qKX2hto9LQZyEMT75eCuH8sqfNDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiJDFRqmGG1Qb+tGhXUaWbtotPmzyB5VCWuWNWYIqGqOTyI+5Oshs8ilSUE626vMdCxUKXV/xWmDY6ovQh3dWLNrceBL5vY1GI7nHkwEqQNxdMNlfzhvQLAS2DuXA0EG+ZY2Y6+Sg3PlJeFv/t6QJavsFtyxS/wA1rcjJ8jUFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4K21bwR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4K21bwR"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so1675970a12.3
        for <git@vger.kernel.org>; Sat, 24 Feb 2024 03:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708774075; x=1709378875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTvQoK4G3hhcyt3MWngXmiyhZw8QOQBtFdTnT1Z/njo=;
        b=G4K21bwRhC7AMRbb4jUDpjyezSNmrPQEQZF4rP2QmgIq39ttKbyo3yEnmZczJ+WyjD
         YntyrWPVGqf6XndU1bc34FVr4BFROazMWMpTbM2VvHY7cCqGCqX4z3o6gDMSPqrSJZJX
         hP+gSBgUjyzutLDXSHgbKSYWl/mXlLtXyWRyOM8BH3rfdN52xjlO/E0KpnXEOADjltfC
         j7DSULi78abGw4axld5dXwr1K4bYg2dhdRF2s+Ghp6jHvO/DKMMypUr/Qz9IaK1Oi0U6
         Bv8nSAcBeLs3hkt7QDZT856YonxPTLScwphWct+7rTFoXRAn9CQahOSYivnAurv7IvtS
         M05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774075; x=1709378875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTvQoK4G3hhcyt3MWngXmiyhZw8QOQBtFdTnT1Z/njo=;
        b=kSc1SLaaXV7xpkICYDcgSNNCGg1sjoH9EBmgDNH+zc0H5nNbNOyzWySEel772zElky
         sYDqB1ynuPgNYB7LU5FDBC48Sk+qXr8ZRQe8G8KFngIzGLMuiWNtQO0hId2/7gPkYqT1
         IXXOmVdbFOM5BGvGIJsDLnPT2drlFcFqWDfycQL3IPmEJ/h0zrQxoH68R3MuXD2r0Oqa
         0Ggs5vKdLx7BgiUUzqbwocLSVxU0VMfDhf5MpNFyJI3BHPPxV+QfKvKVrn1G+zPoGFMm
         2obKXeVqXy19PmqT7YcgKgAxvL+09rN+FLL4IcYj7W5fX5xy+EiDV1F+w2nBKANqUTei
         LEjQ==
X-Gm-Message-State: AOJu0Yywbe1M36ZCdeQAQkWIMkEMc/0vTCfTb9l1s9S/k/sryFQmR3YZ
	dgPbylB2OL9/QE/NkFQgv3MQVRXB9w9NMip0aHxNrnXSlRKRPL6GZ7jfNmFgAWk=
X-Google-Smtp-Source: AGHT+IF3qrt43q+inYCX1W2dro3h5DSQYRD+ZM2qHPoo6dDduUCU0+2xoWm7M/GP+9Xks/0jrcgR3A==
X-Received: by 2002:aa7:d513:0:b0:564:aa72:78e1 with SMTP id y19-20020aa7d513000000b00564aa7278e1mr1394800edq.9.1708774075195;
        Sat, 24 Feb 2024 03:27:55 -0800 (PST)
Received: from eugenios-Air.homenet.telecomitalia.it.homenet.telecomitalia.it (host-95-235-237-78.retail.telecomitalia.it. [95.235.237.78])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c991000000b0055edfb81384sm449477edt.60.2024.02.24.03.27.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Feb 2024 03:27:54 -0800 (PST)
From: Eugenio Gigante <giganteeugenio2@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	gitster@pobox.com,
	Eugenio Gigante <giganteeugenio2@gmail.com>
Subject: [GSoC][PATCH 1/1] add: use unsigned type for collection of bits
Date: Sat, 24 Feb 2024 12:26:38 +0100
Message-ID: <20240224112638.72257-2-giganteeugenio2@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224112638.72257-1-giganteeugenio2@gmail.com>
References: <20240224112638.72257-1-giganteeugenio2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function 'refresh' in 'builtin/add.c' declares 'flags' as signed,
while the function 'refresh_index' defined in 'read-cache-ll.h' expects an unsigned value.
Since in this case 'flags' represents a bag of bits, whose MSB is not used in special ways,
this commit changes the type of 'flags' to unsigned.

Signed-off-by: Eugenio Gigante <giganteeugenio2@gmail.com>
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ada7719561..393c10cbcf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -115,7 +115,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 	int i, ret = 0;
 	char *skip_worktree_seen = NULL;
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
-	int flags = REFRESH_IGNORE_SKIP_WORKTREE |
+	unsigned int flags = REFRESH_IGNORE_SKIP_WORKTREE |
 		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
 
 	seen = xcalloc(pathspec->nr, 1);
-- 
2.43.0

