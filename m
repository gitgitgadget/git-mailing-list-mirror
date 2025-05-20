Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2510266EFB
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732998; cv=none; b=oS3cgGkvk538/973wG0Qd2QHCtdCMOULLaNxqpZvem9IfxqCttiR+z93JnhBVpuMqfFWO3a7ZkvV9U/Ya+EbRrWzIUL6Z6BQjwnvngV5IS+zW3uWEJBHfyhPkf/f3tE9tV27qrlmnoQtjEXn42SMZpvEYiIXWQCnj9vV54wdBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732998; c=relaxed/simple;
	bh=2che5DasQZJHufC5AUe2xOwDPTuD8Y/kz1HXq3Kx534=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YPd8JKrk1uBQOQ/pXTbL6evTrWafDAldarzHit+rsXLXg++3dUHuAH5GMs4KJ6BW9F35XmfwyKF2UcEfmn/3LuY48qRdREttYNFpTsY8O+KxFrGaUTJx1gLiazEZ1VlKZFu3lOtvSgrHlcsVTUchW6di/WPxHRCOa7srQclJLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQHrvAAS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQHrvAAS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a3758b122cso933488f8f.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747732994; x=1748337794; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BAB9TtnW5lFlrvp9c8YmiwGarQD9To36W8vCNbuIQk=;
        b=nQHrvAASTmx5h0TFFH/F4jJGSePHAMcVT+Cfu27fGECVP19HjyWLAL3MqH1MEmoTEt
         sbtzkRitXPz3Vv9P5gnjzUowk3IZIN6W2AFD+8lihuoGI5FYUwhfJpPmikAxPZdaR6lN
         cm9agIa8JpU8NZ3r5whBmiTslcThhCxq1eawa7eTyacbr4hviuaXKGiIpPDlmqr/Qtgm
         Zs09C/CJbsye7vI7cySssUbxoYUk5TD3gD3otMgbp6bBoL/nXMfjG1OuKLlka9Bf5dA3
         YD811RcQ97OD7QoD92ecG+VHe8BITDEFpNhHsWxfH1ESUAjLKDx8qJ8TG13No1o1IoHg
         bYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732994; x=1748337794;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BAB9TtnW5lFlrvp9c8YmiwGarQD9To36W8vCNbuIQk=;
        b=qTkNNw4a35KJMRS22Y8mBd3ptHteWrVbQHt2Lq5yTCmLGLx5H7JNe8VX3BorjVkUoJ
         GygO3WXRUkjS1U4Zbe1bNmQ5MbIEndapl895z59NON+RTozYBrGtz6geK04LdGGLrmoW
         3r4FD4d/y0lTf6tNrwhL4KLY2ABr1BR5+DcbYlyV9e8BenBYY5uK8C6tBkeCbbGl9sGl
         TX/R1YWIsgIiNZz+Uf427wfdj8IxfzgbyTjAXmDx9E3td2v2+S6zv3P8Mm7VMG+c3z8j
         hFGP83Q/O9EIr/CEBT4l4+lep1zQ3XHQcCaBdMeAsjIHCr3KhS8LQyVQ3qaRDNSp5UYU
         n4cA==
X-Gm-Message-State: AOJu0YzFdVob3B2caIuI2wCzxvaWjvsKYGRifwzemgVDn5aDQRndL2fo
	IWnyglo7aHY64TJbmmBKmUVTBnom+7r89USfenLIXdfAKM/JTZfRKMg1otlWRw==
X-Gm-Gg: ASbGncumaKszpmmMZuNBzGtwsACB7EJmhpK2ncXpn2j+BuA63V0z0/J22LK+TdjoK7w
	e6wP4tzVSsw4pi73FiFUXBlmxkrBhkijD6r2z4s6RUAxvtY/kNV5ga2pAfGjSgCNbEhBSuf0F0b
	l5JXoNCbXVy4ggAlvhfKYWLLWzrHXM3AfSEfHZX5B+U423BveuN5HcKBLx++qXz2ObQLdnZXZX3
	8S2sSLTfC8f7q8csyS3ekfWfpBcbiQi/PS27Nm5zsqykwuu0j7XZzHk0RY6w2uKt3VMJVwXv1pp
	BAuukjf6BNug8onGeYdzjPD0eLA8lY6ookS9zeKOvliNEw5NJF4G
X-Google-Smtp-Source: AGHT+IH/J9QimQaRzjtAoBCm+c+WiwGyzVgotdkx5SQ5RiKwkXkrXdDdBFNgBPV3bpC/E7fw1OYicw==
X-Received: by 2002:a5d:5f46:0:b0:3a0:7017:61f6 with SMTP id ffacd0b85a97d-3a35c825eefmr15515607f8f.14.1747732994320;
        Tue, 20 May 2025 02:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d310sm15842286f8f.17.2025.05.20.02.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:23:13 -0700 (PDT)
Message-Id: <b515c278a8fec6c2ab9d11a49261f44fe0f37bf5.1747732991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
	<pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 May 2025 09:23:09 +0000
Subject: [PATCH v2 2/3] pack-bitmap: fix memory leak if
 `load_bitmap_entries_v1` failed
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

