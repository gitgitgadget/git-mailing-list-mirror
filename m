Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EED227B94
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493407; cv=none; b=MjqSTSOY6Ho/NE1WvCJUhnsFFgwX5l2aCuQoVd169jVe9Sevun8IsESwmJqvjn3wHoqJuAw8+onNaATFoU1vtTGjLhyyJRH0wVKbKRKIt7zD+7KHoZeyXS4d4aQBneavu/dLU9GGRZXySGRSlUs1h5QCU4+7Ojna6DpD4KHuqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493407; c=relaxed/simple;
	bh=w+FWzi+d79JHyFNvK19jyyUreyXv9q5+YLkSlVuvIb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAS2Df6Hj0Fjyo+H3dksanZxohYfsHOAxy/mmDW6TaTTlmgWhbBskD3HzhVieKYXlCTA2di9Jtnc74LjUfk30ksZ4rbBq2ULdtpJMGmEaO+w6YoXbZ7NcYnT/P0bOVV4NZC+YSYClxb4vdTJYum9tB0pi3C3NW6LoSP6fkLT0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LnJGrlaS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LnJGrlaS"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c54a9d3fcaso114009885a.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493405; x=1743098205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHXdBU51oj8/+AmU79u/pG8c0vM4ZJxhjUALWOOkKUA=;
        b=LnJGrlaStlDMXRnxz1xsPO1khZKh5iKW17jLE6cD5L0uFRGJ7eXxxc8ldg6HqyKl2a
         2WvBFb04fT6Vjlg6hLjzcp0+sp8i4ZZhXgKAQ3vTdBMmpR6AflJ4BZQch5dyPGqmpoe3
         PHldPhU1qaRqjB5k6CqkRqjX+HOB3N4bCbpP4wozYvad9e1zHdEEDo1sn7ratMjASG0I
         3qEvpJvX7EnlDaKkdhXEV9BMLWOKYBZxoG9hM/XO1MPYO5k3jA4jMe5zq7+sbF2RccM1
         XL0y4MQKfacVoo4oaxGBWIJoSsrnao2M32CcaNSPen9srfnyhOBBKmvu/1YM69JFDEsM
         L+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493405; x=1743098205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHXdBU51oj8/+AmU79u/pG8c0vM4ZJxhjUALWOOkKUA=;
        b=FHJFpH/B++RFgYIDSqcoXvfuLbYvyFYT+bhmVkTCcSQjjhiGAf1gYotCWDsVNiBqCj
         3MzjpqfkZ7z67+lBpJsnjtZpluQUGVaJK6MLjqFOfvIgnAQYC58fZPLpovAsZeqf/Kt7
         Al1lCJ28WFWT01qCo16CIyaT71bOLvIjJjZf1Qi7wgzxKezBvoFODVVxKeiNzpQ2hdo5
         Fa5QrYt+ydAdEXn9ZM+9H1PNnwFP1RozlIl26paYEmyRijTKf9dmV6VBUPdHSVcXxj7M
         J2Ou1U3CdSQp/8ZFABqdPV+BAUE7gwm52xvHkiC4KGqtXTCGlR3fpMUxZEINCn5xRIC+
         298A==
X-Gm-Message-State: AOJu0YyYU47YEoSxo0CvINB1YS10R143LhEhmnfiWcPJPtDugMY1LDGz
	uJqZyn6vG/PsysvxH3MzpNb6I8we3/jRtSw2aitH7g0JnVA+iPp09FeL4T1ZWaIUWoAr8W7rHcs
	MonU=
X-Gm-Gg: ASbGnctV5pCJ7CiVXmVNg2FPZzs9reL7edqN7PY0Klx21qbt+BrXlxo5qhOcjpechZG
	m7m/66HGAreEL9RUt8R2BP13uL7z8v+Pdbn9v9BKX5oZEzrTLrcLXAY7kPApBQGshW9K3+qBiKy
	IoMS5cyIL7BavpqPd+Kl9TaDeHJuvXNcrwjJhuKr77fuVpOs7ChqtzhugTjyJrmNz7WoS0h4Imp
	1YePAwTT0tjCJxWHF48YuzADxfEA9P6abo/S+Jnp0zroHcAO0oJiQZcjD+Sv7I/HU0uNd62h4+x
	1LtrkA43/MynJEmfEN+18Od3ClZM+ZRCv/1G9RyWLCr68d71ZB4Dlxk6+dx8S2McfGf6NLAIU1n
	LFdBZ0bM5SbtC8dOK
X-Google-Smtp-Source: AGHT+IEHRZouOC3s6ZA//vtuALdzFCyDz5fnCkAl+SdCLwbhfrDg8MdN/vbUV8qawwdwq9OVXn2ihg==
X-Received: by 2002:a05:620a:6089:b0:7c5:43c2:a904 with SMTP id af79cd13be357-7c5ba12cc3amr19180085a.10.1742493404924;
        Thu, 20 Mar 2025 10:56:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b9355b19sm15177185a.109.2025.03.20.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:44 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 07/14] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
Message-ID: <e31bddd24055c9c5b04e14d16d20274dc4f87134.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

In a similar fashion as previous commits in the first phase of
incremental MIDXs, enumerate not just the packs in the current
incremental MIDX layer, but previous ones as well.

Likewise, in reuse_partial_packfile_from_bitmap(), when reusing only a
single pack from a MIDX, use the oldest layer's preferred pack as it is
likely to contain the largest number of reusable sections.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f3ef9e43ef..5ff1bbfd54 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2335,7 +2335,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		multi_pack_reuse = 0;
 
 	if (multi_pack_reuse) {
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+		struct multi_pack_index *m = bitmap_git->midx;
+		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
@@ -2361,14 +2362,18 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		uint32_t pack_int_id;
 
 		if (bitmap_is_midx(bitmap_git)) {
+			struct multi_pack_index *m = bitmap_git->midx;
 			uint32_t preferred_pack_pos;
 
-			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
+			while (m->base_midx)
+				m = m->base_midx;
+
+			if (midx_preferred_pack(m, &preferred_pack_pos) < 0) {
 				warning(_("unable to compute preferred pack, disabling pack-reuse"));
 				return;
 			}
 
-			pack = bitmap_git->midx->packs[preferred_pack_pos];
+			pack = nth_midxed_pack(m, preferred_pack_pos);
 			pack_int_id = preferred_pack_pos;
 		} else {
 			pack = bitmap_git->pack;
-- 
2.49.0.14.g88b49c1b34

