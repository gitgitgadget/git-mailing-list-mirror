Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A39483BF1
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946502; cv=none; b=A2eF8wKX6C5c10QabwK7dvRGtt5DSLPJvgSWcycxn8KXUye7i0CVDsr3pNafSy06cvbH8S5olAvGDWFm/1GInw5Hm1h8KI32z1NaQTA81L1tmJ0+/nRCjbdnvPqS94E3aD74bCKLBZcoNgHOTC7Q3DKlbh8uivPenYbkOYxW6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946502; c=relaxed/simple;
	bh=dTLJi/WZ6ji+LSDFlavMahcGkGDYQkrfUgZhRmFlvbE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SK+wn+aGg56Zb3OGClY+zjt1dew+UQJk/P0MFPyr/c+LcfpPuwjrC3MXk9ANOE0aWgWpEhOj8m4ecIUzvKG48A9A6AViprQpzuultiLbuEcfo7IUqojDYMPHMZXvhTSHc1ZGlOUxXZ1QslEh5CoemxLa4+0MrVuc7Gccra+f0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/lvo+8z; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/lvo+8z"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-45171f2f608so642903fac.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946489; x=1786551289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vwTFh6pXbUgSSuUulWyuHQdPiw34PP+qJ5+u7Tz9USE=;
        b=K/lvo+8ztxAq+llyF1Sktti3TkOavnz6d/OVfc9pQlEHd0h4vUh6e6SK1Ewn55DK5w
         bhVTMRjJhaKY0cMUA6HIY3KN8uaRfCwSNn7T3Ou2TpMkJIvZFqQKLEiJq5egO1UzVM03
         1701wy9l7Hmr0d6AkEwpgXsAiJXt+sb8vBgIAFpsmqAKB0LanEfyj9QRnR/JCFKxtxxw
         gx0shfB9X5/cBXBttxgYedN6DJNn7c2J1/78uEOlzXyn+Brjc/T5vVNx2YEvSNvut1CJ
         8WN4WhEoGnQUiMBUgnI5CZsz+qaO2TwZL20XdsAgNAZOrVSolPIReoili0LZvtacHNJu
         sJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946489; x=1786551289;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwTFh6pXbUgSSuUulWyuHQdPiw34PP+qJ5+u7Tz9USE=;
        b=a8FYAF1HTDjSAE2DJVh6C0s+KoCJHK/wB1VbeaDxpn7jHKxs9NnB+cx0duyeh0FPfj
         obVYkKCdXYcdttEVJWFBHjlP0dbHlMI61aCuCUc+BiGaE53P1TTFH0ZfjmW9faGN/tNI
         cuXyIznlLDYc7yKNMWCUlVJSPNRxt4K+zxeXSZinelkz7XAdBLW49mhEC281M7QQxo/B
         pD6TqpPXSqCyuoT7CdyFp+6iMfQhxrv+ZeCAN19Y6ju76u+uxAf9efNGqnokDQV9MGoC
         zxkDQjLOvr51wzZ937yRw76gTfEUHsEUe9DKlHjmo6+Vi/4XOumYwq+hQZhsuw8UdN13
         5zkA==
X-Gm-Message-State: AOJu0YzBN3GHC7tTsqvDBQr4MBMCWz9Y6whecTddbfEokSWKqYV9gS+w
	o8gIffVRKQVy1ahY1dbiZhEAvPvWBnQ2sDMxWq34QKc7yr46dPoaUuLL8ttVjKOM
X-Gm-Gg: AR+sD12f5Od/r6qQ19gDU8I0JMC0iNkRMRihtmI93e4lQxsgRHKZdyUxw2CxjHthjup
	ljNBjiDCGa2pST/jpshwz2bGAdobckmx7MR/fk3FH2VR90InZ8ueiND1or5LWETjTnr22PfldGe
	ktDA6T7oB7wc3ViIRhZDGQexqD/lJbS3G9ob8wCzDifJwdXG/PSxTljHKazJo2g1q4e86gHXTB6
	kGsrKNdPKPHkOfN9ZOdeKjO6WCHiRRw+qmCSX8FxFaSOcOmkL5ZW3kZ3S4S1cccjEpSbNDKeK5I
	p5DBfLT7Gzmqbl98Q1v/FxIqy4Akfn3kPWV7tKTYG2PaPWvzUs0C5MvjsklVVnZoGY2GtiiNM0R
	M8cEpfEo7w7kvh+4pgm/aUHSNlODTw0l1BL08iMEn10mxFeed6nFNskUW7ShcxSonrxcBjuflr8
	KcX3VoMOnBm9xgdwFtQdP2NYCiSVprogbdv6DKT2uZ7EneaSAvsZkhe8wG9xm0Wh4GRQ==
X-Received: by 2002:a05:6870:8256:b0:417:4693:ca0 with SMTP id 586e51a60fabf-4599ee2346dmr4173171fac.14.1785946489567;
        Wed, 05 Aug 2026 09:14:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599e646a2esm2679182fac.15.2026.08.05.09.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:49 -0700 (PDT)
Message-Id: <c3019582844896d026a092c356b3b1b0e99e3fa8.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:32 +0000
Subject: [PATCH v2 05/12] pack-objects: widen `mem_usage` and `try_delta()`'s
 out-param to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The pair must move together because `find_deltas()` passes `&mem_usage`
to `try_delta()`: widening either alone breaks the type match.

`mem_usage` accumulates per-object byte counts already computed in
`size_t` (`SIZE()` and `sizeof_delta_index()` reach here through
`free_unpacked()`, now `size_t`), and was the last 32-bit-on-Windows
narrowing point in the delta-window memory accounting chain. With this
commit, that chain uses `size_t` consistently except for
`sizeof_delta_index()`'s still-narrow return, whose value is bounded by
`create_delta_index()`'s entries cap.

`window_memory_limit` (config-driven via `git_config_ulong()`) stays
`unsigned long`: it is only compared against `mem_usage` and promotes.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 503ebbf091..96ecee393e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2804,7 +2804,7 @@ size_t oe_get_size_slow(struct packing_data *pack,
 }
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     unsigned max_depth, unsigned long *mem_usage)
+		     unsigned max_depth, size_t *mem_usage)
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
@@ -2991,7 +2991,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 {
 	uint32_t i, idx = 0, count = 0;
 	struct unpacked *array;
-	unsigned long mem_usage = 0;
+	size_t mem_usage = 0;
 
 	CALLOC_ARRAY(array, window);
 
-- 
gitgitgadget

