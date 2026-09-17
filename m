Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBE4E0B6D
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667566; cv=none; b=ePWt8h7oJFm8ahiGU4IKhhlmKfn2pSa+0IxFwRTH4+uKESrTfdjd0AmdmTXP078WOI+IETc1wUvO+hayTM09s4T3EJ7scIZrVTEwdCcua6avqdbPhxJMuprXVRMiJOV8bE1bI4felDreowkoPlGfvBr1b4Gujr+yg1uuk9AGWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667566; c=relaxed/simple;
	bh=wwaW04L50v3DfC0xE9aJyrV+15ncpC2JUhM34tMmjc8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T/cxIdJcv4eSkUPr0fB6WarlFtsomsa2dxCBgCmYnZDjuG62W3PtyTP/RYmlc0VuALMRjmmK4a4Afs3kEXeEqtOivpPSThfkflP+1eb4Tw3nQhrSzJEd0jiazHM09zMAAsfJEUC5gkJrUdIqmziymS3uz01O2ChrCHn+JwUPFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqw136y9; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqw136y9"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba92so1038429a91.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667564; x=1790272364; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5OnMKj8X3qgLypUYUyTT0RuP7tJKvSefQJi1iED/32A=;
        b=Jqw136y9QUZd3r7HdY3L24rPnC06eO68gEaGcotXnGbk0FK6WjZN5Uf8kpf1hbUFcI
         tH2rzBRNjdCWv1xnhrrwV7ZN1iaw6C7EocgI8Efs1fj6XvTRux15YCheLLcZUKbFku/a
         J/uzLsSsjs7SoxhpPxpaAZ9ODrCAxWWfDK3UpLnyePcfALw+r7HZ7uxR3lDvfKqMke4m
         YqrhBHLcNvy2HxYrzqkgISNwU20+wuDwPGsjT4MG3pMtaHus0wBQ5wJUPVZFhYnyPDAO
         i4XNYj7YjUhkunvz3LSpyBtOvouMMkKFrFiSAeO2oZ8VsiqWiBb3luC+w6HIn0Ah08iD
         tCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667564; x=1790272364;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OnMKj8X3qgLypUYUyTT0RuP7tJKvSefQJi1iED/32A=;
        b=Y+yd4bpeODh72iMaljmdwB+84Gyw/ajBSM8Yy7Lto3SNcTE4jXl/Pyn0ARug8MWeXP
         LyFisN1U9funMN0uuLv8Wpm9t6uwBsaNd5mkqpyE0lcVnFb/1zjPaoJPeyJN9gdQ6mZy
         7SVyrGN9thU92SZULdzvCtXjxEeTSO2XehCzrB2EcDM/W6T2A81Y+5pa6/Ub5Y8uKTuE
         lX/dzHoVCCe/kgh8yXefBaGXCRWwJU5hOGJ0O1d2k/hVgoO9ADpW8vEsKpvBp85lT8GA
         z7VVsQOeK/ZOCXZmd/Do6O/yyxwMZDP6PaWqaWNcsWlIuDLswNcrANZucTpnPhfb6Vac
         fBNA==
X-Gm-Message-State: AFuF++lEWhPYuTlxQ+tT61DqCHtUaS/4gb0Tf5Tq08zv/84mQB5k/xdW
	mk1gp7dKsRiZImTwsbzWIKWES58z3Z3Lhp7GTzg2/24YEq3P9OthD+wmnr9n+Q==
X-Gm-Gg: AYBFou2kq4sL5v2pkvBrR+WdwJle1NTIF/Y+rNZNQHJQbnUqpzmkGRTOwh7crfVXmea
	CAJgZD2QLi7Jni7SQ32V0wYyZF9eWOofN6HeLrpl/Ah7ua6s8IXPYh8j7zAWjpY4tdevVrJ5Y59
	KjnPEzkxTW3/yatYGkbPrSH6u9dLvvvKi/7+7ocKd/j5YJX9r/FWyGhxfHEbY/kk8SFNdldkd9w
	Cqjej5OiVy60JK1QrXEc+7Ia9DBq34EDu+fur0xUwFShOlPy5MDc/ptKpdB/0ZKxzReLYiYOoSY
	FwDfPwQUWfwigV6sBRY/vpUWrNBBitL4MZ6fzA9LmN5sN0JAs4+t3tyhY5hNGBjzXvmGzpp6Be0
	baEpjj436ITeqrBycTaiEanvwb2bCEpZbc1UrWnyMmmVwCGNVE+bswirjRs4lZ1lwI/pzoRiDZH
	As67ruxSgX82fUn9PCnhO9fGimlKjVGcSKiUZfijeQQulHQJEp1Nqq8PrLOtLDkPASmSgQvVzU
X-Received: by 2002:a17:90b:57c7:b0:39e:34d6:7eb5 with SMTP id 98e67ed59e1d1-39e34d6800dmr9506011a91.9.1789667564181;
        Thu, 17 Sep 2026 10:52:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3618ab38sm6229765a91.10.2026.09.17.10.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:52:43 -0700 (PDT)
Message-Id: <1cf4e5ddb5996423478b7543f7978e58cfcc4eb1.1789667556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 17:52:32 +0000
Subject: [PATCH 3/7] midx: validate incremental MIDX pack IDs
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Incremental MIDX support made object-offset pack IDs local to each layer
and then converted them to chain-global IDs by adding
`num_packs_in_base`. The conversion was introduced by 19419821bac5
(midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs,
2024-08-06). Chain-aware pack preparation followed in 1820bd878c62
(midx: teach `prepare_midx_pack()` about incremental MIDXs, 2024-08-06),
but the final `midx_fill_entry()` lookup remained tied to the original
layer. Only with 8f909ff4e9e8 (packfile: recover when a multi-pack-index
names a removed pack, 2026-08-29) did Coverity point out this issue: a
local ID such as `UINT32_MAX` could wrap when the base-pack count was
added, producing a plausible but incorrect global ID. After
`prepare_midx_pack()` resolved the chain, `midx_fill_entry()` could then
underflow or address the wrong layer while indexing the current layer's
pack array, causing an invalid memory access and crashing Git.

Validate each local pack ID against its layer's pack count before adding
the base count, and obtain the final pack through `nth_midxed_pack()`,
which resolves the correct MIDX layer. This prevents an invalid local ID
from wrapping during conversion and ensures that the lookup uses the
layer identified by the resolved chain-global ID.

Assisted-by: GPT-5.6 Luna
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 midx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 6d1c548e3d..6968fc1c00 100644
--- a/midx.c
+++ b/midx.c
@@ -583,10 +583,16 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 
 uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
 {
+	uint32_t pack_int_id;
+
 	pos = midx_for_object(&m, pos);
+	pack_int_id = get_be32(m->chunk_object_offsets +
+			       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
+	if (pack_int_id >= m->num_packs)
+		die(_("bad pack-int-id: %"PRIu32" (%"PRIu32" total packs)"),
+		    pack_int_id, m->num_packs);
 
-	return m->num_packs_in_base + get_be32(m->chunk_object_offsets +
-					       (off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
+	return m->num_packs_in_base + pack_int_id;
 }
 
 enum midx_fill_result midx_fill_entry(struct multi_pack_index *m,
@@ -606,7 +612,7 @@ enum midx_fill_result midx_fill_entry(struct multi_pack_index *m,
 
 	if (prepare_midx_pack(m, pack_int_id))
 		return MIDX_FILL_OWNER_UNAVAILABLE;
-	p = m->packs[pack_int_id - m->num_packs_in_base];
+	p = nth_midxed_pack(m, pack_int_id);
 
 	/*
 	* We are about to tell the caller where they can locate the
-- 
gitgitgadget

