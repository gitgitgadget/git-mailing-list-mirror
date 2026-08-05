Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15946EF99
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946501; cv=none; b=Wgwdsi5OrBZOga+iHxPJinG973OAfQHsRpbSHqh3OQdc7Vz0EPt0Bm7gWLXddeTkT9M6ExKzqFQuUVMa4jG9L0wG8/Lef2EENYPmiNdyFMHO+8gS57BwxGcOZexdB+rV+6IsGXnWkbQ1BmjvridhZZJJgK4qhwfZj75V4p7ULko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946501; c=relaxed/simple;
	bh=JTAut3VAw2pac211Lff/VJMgY4bg2Cq7BHwgawY/CZo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a/nOSS7WBjvSRwQf7Ce1gIQFiotj636+H4YiJpNkYgnEQVnKEWkHZb6/v5hGnC5n/FCmceLWJNM0IFBHrkZsy2jsx7J2sz9KolaGJxEuoySdVT2TrcDTZ9WiYDZ4z8r1o1ZWK9twmEE4u6Sj/liPzrlDAU+VJoFN+hCt22wqFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyF2GYd2; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyF2GYd2"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4955cd5da3dso458102b6e.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946488; x=1786551288; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=No9UgJ1nMZm4YSZxXW11S5ilQgAJMp5gjDDbRnDHSq0=;
        b=KyF2GYd2sEYZZ7KSS5TT7uV9AmDRMpF0X+wy/HFzqCXyl8NTKCoiunysqeolfEIrmr
         ULfC3TeNYUVPQ0ARoizP421R9TChXpwW6Z464n51WI9oAyDM43qTztyAhCmNcPbpbid+
         AjKNRsluSXcRantCoMuCUZSrq1QJIenqRdGGIS0eMRANeMVI7uQDviHvM/WqF3ymVlxl
         kR61Npi0EhZGmlqXJ5kahwFsXO9zTr53txrJjHbiWaW9zAfcnYgDBYjPAT3hpsclQCkq
         awJydCX0MbAo+28v2IysasqQmccb+Vb5fwwOrj2IIgW95wGneixrcHiIng/9WnTVroo1
         Ll7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946488; x=1786551288;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=No9UgJ1nMZm4YSZxXW11S5ilQgAJMp5gjDDbRnDHSq0=;
        b=gXEiZkVvQivBhXQJlUVRjyn3ZCPGAbdDo0CU+Ft81DLstUJRav7phNHJ/pyQKiRSZU
         7ZhEEg/tmlFCEdWs5WEBHb968Y22twYKZyONPesGaR+ciqo/a85ozFjIx8RaVPBsoqWs
         DA+swTRCmnnK5ey3Yiqa21zkOxDnlNy1CU/8h1OLzRqHRXc3+57DutPNHevXtpfHOtGD
         kq4AJOWYAADVAyhA/OceTk03SMGMtgLr/c7vd1AnEQDgliP7O14fMke59n+pb5rN0yRl
         rKiG0rmP/fr+wBpSpwyhvWphKhz/Uk3ZBhzkDxHvCO7J7DNq4GvTb1DPOMa1D5KlKKop
         QsUw==
X-Gm-Message-State: AOJu0YxtqrZqcP6nEo69rRKPMyDU2RM007/1QIxddyX3OEFSuXxy/vFS
	Th1MPajX/FtCwbrAt4/dQvC9SAJ59cbLjJNF70oWH98GV0CdjhSjMNbtGNPiwpGO
X-Gm-Gg: AR+sD13NQEGN0eMpYSRwxS9sRhIEu/O4th439a7YBbpahA3kjqLq9P81jLdK5Bii0MQ
	lxVIiWBywEh8BYQVWUbeu8L+vg7UPjf2dx850m+Zp4jDrpmabddVHh2DrRljjDtWSTKXFa0nhu2
	pjBz2GQyZzUVH7yfeJlpjsH2YyxTsErylGjwrJs6crqhrQX+8x65VVx00G8NK/LmDeecQ0OnxO/
	JKUI81GynGYAipebiqYvH+L44ta7+oA76HtRnVpFM8ydAF4+8gzDz0Lmhjq/z2EhFgDyO+88UEy
	6omY9vKZanesa0c6sl2LpQ9Hokp4ZVfVhA7vTLfr/c8g0frFrXFrpWW2lTqVBVN24KTtSHIoQUe
	UiNx5hG0WsN9HcQ3/WGaI3UFntiXF7Ai3G1EOW2IyOJiOq5FgttXXtVtQ/EvSbJlRX+fbdE27MR
	xwR5TqhCg8az8AFW/wTB26130XqfO/a/9DJ/m4EXm1cb9S2RPKYx4k1FxMDPlGQDbzg8MnIVfvD
	y6c
X-Received: by 2002:a05:6808:3199:b0:489:5d05:552c with SMTP id 5614622812f47-4afae235a9fmr4769616b6e.18.1785946488285;
        Wed, 05 Aug 2026 09:14:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae7583eesm2328280b6e.13.2026.08.05.09.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:46 -0700 (PDT)
Message-Id: <9850de1a91c826e673a1dd401c84a4c14c15c317.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:31 +0000
Subject: [PATCH v2 04/12] pack-objects: widen `free_unpacked()` return to
 `size_t`
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

`free_unpacked()` sums two byte counts: `sizeof_delta_index()` and
`SIZE(n->entry)`. The latter has been `size_t` since the prior topic
"More work supporting objects larger than 4GB on Windows" widened
`SIZE()`/`oe_size()` to `size_t`, so accumulating it into an `unsigned
long` return was a silent Windows-only truncation on a packing run with
many large objects.

The sole caller, `find_deltas()`, still holds its own `mem_usage` in an
`unsigned long` for now, and therefore still truncates silently.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 97246c69ae..503ebbf091 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2972,9 +2972,9 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	return m;
 }
 
-static unsigned long free_unpacked(struct unpacked *n)
+static size_t free_unpacked(struct unpacked *n)
 {
-	unsigned long freed_mem = sizeof_delta_index(n->index);
+	size_t freed_mem = sizeof_delta_index(n->index);
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
-- 
gitgitgadget

