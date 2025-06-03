Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3242A96
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920451; cv=none; b=H9ALQGJxnr4P/JEbVxo2bxwF3gG9qE217SaknIBF8kG62uU1z9wAfz06EbaL2pLc0yL+aYlihBePRRK4dgnsejXzeE9qOsZ/rx8cwz5Um67yMuDDp3ducCY9Lbad6FEB2E7E1xKhfPUzCUGbbor5QkpY2tXFcaTSzXg2SyGVh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920451; c=relaxed/simple;
	bh=4qfN/Htk8j+gWYeD7xCuhR7yrFSCmHzuS6q+A1Remzg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GC/05iwohNnKcmVFu6Qo5kBL7cnNr5N0Ao+JepFo6VE0V/fH7bVUIQHm3AZ0SXaYlTtUMBoMGuR0xCL/TXMjSanxgOGA4bG7jtKQLnXuwAL5fL+AZmrpTfKMjOxYXd9367jXB27IOFkWHGHXyV9A/iFtN08hIRDkG1KnHRr60dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xjzjc1ct; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjzjc1ct"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso43077345e9.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748920448; x=1749525248; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24wOI1qjJT5xflbBe9dZUP9RwMgrltL/KrP5WlSRI2s=;
        b=Xjzjc1ct6vJA73+pM2OxzM/JZeNYfxnASeoR00rvpeDkbscb4xgDG21cNamPzzZFyo
         AS3TFIMZjXhNlvGa6tYdTpN2/9E7jI9905TidoM2i1IfM8KMrvQhoEIAZK1DhkhdKY8t
         OGjvoJtfPMDKzUpzo8fZzxr40qcf9bPYOQo2X932x6tCOHKQP+jtENmHtZ0alkSzxQ05
         mCzW5FdtRzELxYvxatuw7D2yAMeFq32z1jANe2wcNLXteT4DWIw9yCqI1bMJiO1UMHqy
         kLSDZhcUUgN+Dqb4eftCindImwJ0Bjq2Ln+hatIGMixm99WwHN+09N+qLTaIiPZ8XgQ+
         2fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920448; x=1749525248;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24wOI1qjJT5xflbBe9dZUP9RwMgrltL/KrP5WlSRI2s=;
        b=hQCHCCvwE34bs+s+54V9XLbM5/XCAPVvE+3rWIVtmIBsCUXh9ZQ1Vn7v6w9ihdy0IR
         maWH5BwJ7pTe9mEFdP6MMgu0Cx9OAN/0HNRSjtcM93GDIQjxq08cJ9DbKnGphzCQfQ93
         smtkv+k3v2ZHRO9cvKbNVoYkeIcH4U/emFkten5UFEz6eNDOzsOUN4OPSKJYqg6EOTTw
         KNiw7uBZ5kbhsc+ts/BSP9eQ0qYvawOeLNWXrZ0/pCg+LGNr1TxNAW1g4E9fpkSCEhgh
         F2DDPvuP4P/bWAxYYDKcI2GJll5zW6aXuE7XzboqO9u2EHZzRp2ErTZ2NskWOWOp6yxn
         dEig==
X-Gm-Message-State: AOJu0YxJWFyljdW9JGH2npsVJow1SoMaAx1o6BUVRTd9LCkWGu7EOHm3
	o7c281AlXzDtSo681nioKW1NtAnUjoc4dGA/OC7CQgnhx6qcqMDizLz/1ydeMw==
X-Gm-Gg: ASbGncsi6OmDwAVAdseGZ3aIUVdZsfhSxlIaKjLoWSqSAWAv3B2Bogd4PRiCqqhBOsd
	NLYEFdvtV30DcqF0+q/2C/nvFZxh6AnVvejnrUClI04LxU0qcamckXMHOIQEnANrvwKYfkpClMd
	/h/WGEX6fITlfWLk1lxpsvCrhZwPsJyD14WDdtJ2tXTGggXGwjYMe5Uq2CMozqqg5lLhGMrlgw5
	kqmfrZVu2l65SHqYYKcTxr6Gwd9ZK4cqZQLk83fX/Mz5ui974Y7RXyUPU9REdSTdGVigJen7TZg
	ppEfV11B7oWIslM4dcGkv4PY44RWDn8Eu2yX9pX8UmhWutqWYD86SpbRzWr/UzY=
X-Google-Smtp-Source: AGHT+IEIi1D6R2nzX2WaslAAIfcR9Syp1A75cBHVONrb97jSwBPxpmrQjNWxktlSGc4jnRbMagGJbQ==
X-Received: by 2002:a05:600c:470c:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-45126574a0emr102379055e9.31.1748920447891;
        Mon, 02 Jun 2025 20:14:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009758esm16858415f8f.75.2025.06.02.20.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 20:14:07 -0700 (PDT)
Message-Id: <9ce2135df2a1f728fd24b99f171f3d6dfe8dc350.1748920444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
References: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
	<pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 03:14:02 +0000
Subject: [PATCH v5 1/3] pack-bitmap: fix memory leak if load_bitmap() failed
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

After going through the "failed" label, load_bitmap() will return -1,
and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
will then call free_bitmap_index().

That function would have done:

    struct stored_bitmap *sb;
    kh_foreach_value(b->bitmaps, sb {
      ewah_pool_free(sb->root);
      free(sb);
    });

, but won't since load_bitmap() already called kh_destroy_oid_map() and
NULL'd the "bitmaps" pointer from within its "failed" label.

So I think if you got part of the way through loading bitmap entries and
then failed, you would leak all of the previous entries that you were
able to load successfully.

The solution is to remove the error handling code in load_bitmap(), because
its caller will always call free_bitmap_index() in case of an error.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 pack-bitmap.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac6d62b980c5..fd19c2255163 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -630,41 +630,28 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
 	bitmap_git->ext_index.positions = kh_init_oid_pos();
 
 	if (load_reverse_index(r, bitmap_git))
-		goto failed;
+		return -1;
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->blobs = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
-		goto failed;
+		return -1;
 
 	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
-		goto failed;
+		return -1;
 
 	if (bitmap_git->base) {
 		if (!bitmap_is_midx(bitmap_git))
 			BUG("non-MIDX bitmap has non-NULL base bitmap index");
 		if (load_bitmap(r, bitmap_git->base, 1) < 0)
-			goto failed;
+			return -1;
 	}
 
 	if (!recursing)
 		load_all_type_bitmaps(bitmap_git);
 
 	return 0;
-
-failed:
-	munmap(bitmap_git->map, bitmap_git->map_size);
-	bitmap_git->map = NULL;
-	bitmap_git->map_size = 0;
-
-	kh_destroy_oid_map(bitmap_git->bitmaps);
-	bitmap_git->bitmaps = NULL;
-
-	kh_destroy_oid_pos(bitmap_git->ext_index.positions);
-	bitmap_git->ext_index.positions = NULL;
-
-	return -1;
 }
 
 static int open_pack_bitmap(struct repository *r,
-- 
gitgitgadget

