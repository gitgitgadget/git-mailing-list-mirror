Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073C2063D2
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757230; cv=none; b=TURZJSKKv9QhhgidBViZQUA9pbTh2sIfUgKOwqesfIrXds4q595gqUe23t4Ybm3eAqwEsk135PktrWvmF/362mGK7Q3GnEGHXTG0XLHyQgngdUkSiWDOeAFSi+1PE16lv4qfKKJoTkGHPDWTGtcDCbe4urpnUWZMB6x1hb9zfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757230; c=relaxed/simple;
	bh=hP1POH9Oxs+UqPZGTFHXuUYUS4SR81sHGlZ6cD/MC6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/Nqb0Loj37/8luACXcZeihGQT/tatImYYmQ4sqkBeVyS5Qe8pioSgUL3ssyrL5dssypxLTXQl3/pZuSL48huWTI29O+pQZdg2EtC58mkW7IKz+SBmgNbwkM+fyDo4UybTNqHdj8hs6u/CupBmFQ+rlcacbMyoOq9JvQz1OIU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qvRTZHyO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qvRTZHyO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0ad74483fso64407896d6.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757227; x=1745362027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnLgjrhSpY+i0iWWeDkjxgdH0dseFd77tQ42KQwZnSk=;
        b=qvRTZHyOzG53/18M9HhvXb664M2YVMxAwjGOYw6ochz12Xd1GCxtqohG/9dBCuJjEb
         PhIFh2DqkfeFSoG6ClihVEykEJJrJILnkeNuKn07U9ckk15ZX5NjOB0kAWC5lqh9Sffz
         LiMbYxcOzcguwX0D97QJLnL26zNCun8azsDFBO/Mheq6O8RI4Spj1jlCO22/kg8YpnDo
         BZNPaNYecjH4I8jHDcDaWKy2nuU8UBF3I8k7uWOvW6QY4qlFnI2rMm5pM0kjr+kj2Lfb
         1JC1Gmk5TfZceAkR5me5DCynDWfK13eJS47qnSGC76WwTpBO51WwSRTULMTsqwvliZTv
         8o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757227; x=1745362027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnLgjrhSpY+i0iWWeDkjxgdH0dseFd77tQ42KQwZnSk=;
        b=vMXXI88bh1ImEHELBeUxR2fBHfMjRzEbAvzf3UifuAALiTnlx3Vx0ULUgTIX3mTXqK
         PpSFLsNxkqC0fKA5O4q92QXZ0j/R352O4prY5gRwDoHWTk4XBiKEAV+2drey3LNtVOS/
         AR65DCldR0Jbagx5Ud+DhH3rvfUVHfgyQnjYvykOwAGv6I/NHie57ZLOuLeil4yX/ejC
         ReAwCFzGhji/m2VdEx+kvvAbdLfzWycms0SUVvUgJnCj5lAWL5bnYJJMI3wrsCGkfhAS
         E6nbYLhhhHankycKdiG/mEbb5JkstVTFHhtBK5SogOKDNzO6TKdcaKSnOPGuq1J17aM9
         MqWw==
X-Gm-Message-State: AOJu0Ywv6ZsnJoeYpCfLiaeefHUoz1fuGvnBQYzQDp57zf0h1xGVHd1s
	ZPdm+t+dxht4KwuDz72NqGFv7TkS1zjlAT7qsZ2QyoeFuEyazJIPmMaOf8xqkbm3kpeyJk6UVV1
	Np68=
X-Gm-Gg: ASbGncuR9IEQ41yhQAF5Oc3xSkqKCITskvbsM7ktDp+yj/clchuOT+cBuznv/ZFgpJW
	FSiVdoW2X2cmjFq5Z/cdp7M5GXjzJHT2/CyB/WIiD/uYSGJJpblpIgGlGDxYVHeIVzDtRhOcch5
	FhVW98xubRJgc+2rZxQuLlV+/3UR643IYfNDqTEsndQoLv+e/P/C2xH9XAZp/6ULoAv4XMWt50R
	uUdAJmhuprLUv1dBj//oLHv15xHWIxuJqtqXvJ3FG/7Tq9pzkKruPzPOA8fr+zYk2gVwRGTXOnd
	4kL1f/NjgrjDLzyzLslaPBVW7KWp0ca1nizTdowNpMVuCn5GYUnvVnEgGgKbI9Mv4ZCEesnBLWL
	tlmvOqVR3BAAn
X-Google-Smtp-Source: AGHT+IHpz6eHgZWvjuoVNKZcM3mr6y/QpElk5yqupHsoRF1N0WGrQi2CHvn5cdXeziOlPFdUkgnUOA==
X-Received: by 2002:ad4:5aa5:0:b0:6e8:f3ed:3f21 with SMTP id 6a1803df08f44-6f2ad974d24mr21910096d6.31.1744757227259;
        Tue, 15 Apr 2025 15:47:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea107a3sm106399306d6.114.2025.04.15.15.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:47:06 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:47:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/9] pack-objects: fix typo in 'show_object_pack_hint()'
Message-ID: <9a18fa2e52bfe1bd98ea2d50b8e91509dcf67102.1744757204.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744757204.git.me@ttaylorr.com>

Noticed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index eb2a4099cc..f06b359150 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3532,7 +3532,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	 * would typically pick up during a reachability traversal.
 	 *
 	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
-	 * here using a now in order to perhaps improve the delta selection
+	 * fields here in order to perhaps improve the delta selection
 	 * process.
 	 */
 	oe->hash = pack_name_hash_fn(name);
-- 
2.49.0.230.ga662d77f78

