Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15ED30DECE
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567325; cv=none; b=DRwXACHq2tH7nuVS4UbP9zbJ1vUYgKGVsER37rXQIDxEJOB9j12IFHwVnyAHKA5gH9CQ1Bid45/uwjDJKC6FgaWnI4Of6TajiSg9NnaVZvEkyFdzoFnIm/6PoX4kTOhqyMeFeeS1t6AeVAWksUcfOdZr2RXfrnz8b1gKSa6LRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567325; c=relaxed/simple;
	bh=fvTVy6iJrsK/00PtUWChYZIkY5MHZORa4GF/HEv+wSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE9qbhswRarMBFC+G2hhZhA2/hSeeEZd9OG1ZVDYcP+amUn8c6t9ZlGfnT2F6R7Ijbz2HdhEcmkxzrAwsW1eSISfGP2N8XJ20VFIxmGh2dcwnL6XwRhrCtHyuohX6OV6SwBErlodevpd4G/sB3wYbgCgA76WxPreGRwNInE4ukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qhNLKGyK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qhNLKGyK"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7815092cd05so891637b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567323; x=1761172123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hco8dkGqo/C4yr0LPf6NiPKNKag6+zIsuizae8+TIsw=;
        b=qhNLKGyKmYxvd3HqDDq9Wt58yUuYtsXV/6eBfgPQI7gWNOO2dMsEVobwk/4w8veNrw
         DSRom1lbvZjgyj3cVMi6NlTcvNNpmyLVYcA5jfa9T2M30vElYunWBhY1RcPQeNXfD/lc
         LdYeqK3Me5QnNU9yaeLC85J7uDs27GD3FUW3P2otnfp5z6c3iEI9pAkJktycN8RTPmYs
         XGvOpu9+yNRRmhjkNWpMqIebmFR0YiFPfFlxe8MkYfgNuC3RR2RAFAqalzQUlmTwM6su
         EpmccgJI865546sFtb0ODd0ZOdh4XHmQYHX7V8RoxFs8BRUdwsp2H9GV9IfjgCVF21dz
         VrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567323; x=1761172123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hco8dkGqo/C4yr0LPf6NiPKNKag6+zIsuizae8+TIsw=;
        b=IVzgFMLZa2piFYFmOz4UbGXdaiUnV3H29r4W4Q7VfNRTe/7xGx0KVorbZdN3LwJtU2
         G6AvDVcOc3VeebZWmi4/xCNBPOkGxOhriUjS0MjQkVvfbWppr7XsUzshykzBThY1fSDI
         AYj/fPqt5Mhjw4TbR52jttDZaE6TE3F8OgXKqeqkpNv2Nop0f/tJeqK60RGAZoW8gxgZ
         FGTvvUFW05md1utURAbN+rtZCczMWc0hRPRBmsU0clcG/Zg1Y6SfmZiERzdX50UnKQRO
         4s4jhCuut4dAV+UW9HHmkhbAiYpd3L1kO1Q2H5Jocw5pLHb2xQ0KXlNKUqcTOED2eZxg
         5w7A==
X-Gm-Message-State: AOJu0YwYA1iVPIio+y9c89ex6xX1xhzp92Oea90ers/+aGJKzsartqWf
	KyifKWwni0pu6n35iEOoMkKlURH7oWzFXqGVZ6yCr8R0ging7sdeX3QbBelE+dPVPa5Vog/iTrx
	Bx08xVlsFtg==
X-Gm-Gg: ASbGncsNBYXMoGOr9FhbDf/EgRC+yzCvnhtC4JGp5A4u1opnuRw7gGan5emHI93stsA
	dbs03cpFgOdhFdrlebpYVU/4EbwgG6fmK279V0kva+zeHnpPDJEdUfee2hK840xhMFftFh+1rNu
	4fb/PMAImNMgksgCFD0mzS2bXHPLpBQcCFryinf1o7MaoQb6jOzxZXMGfXLfG/duwJ0ALmGNp3K
	l6vgnowhhjHWKA88h8IPu99vgab/FiXy90cU45I+TQNF1FlguEu+E+QVZzP+2w6LagdS5bHSpnh
	iddWeEgpStRL45ddkJ5dhc/FFnRx6/YNWp5/hk0hiV59Jf+hMDyGLAVtfaEgZW9PEunbj0cw8xv
	d43KA1O29M5bssIs/sxfdf8IGvQeopII0KPjKg/+GNrCMqbLCbV8r09JUuD6acef0atNV2rlKl8
	CoCyCLNjX4JzEn4ZiztbdTsXzeLfk5zKZTAvtUn4g8V/ieNU8gZ/jwWalTtYNllAEPP2j64GOVA
	hnXobs=
X-Google-Smtp-Source: AGHT+IHQlsRlzvgSYO9D1uFcugQtW9NfElKgz79UIb/A8yJLxgXqyvd8fsZAuNpDs1MT4/bBuXOipQ==
X-Received: by 2002:a05:690c:6289:b0:767:d202:712d with SMTP id 00721157ae682-780e153bacfmr296943027b3.31.1760567322843;
        Wed, 15 Oct 2025 15:28:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828a105b47sm2855197b3.0.2025.10.15.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 28/49] builtin/repack.c: pass 'pack_kept_objects' to
 `pack_geometry_init()`
Message-ID: <a3d99c485299221bc6fe6c012e1efaaf38ac41d6.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Prepare to move pack_geometry-related APIs to their own compilation unit
by passing in the static "pack_kept_objects" variable directly as a
parameter to the 'pack_geometry_init()' function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 42f05d2ebf..ac8c80d0a5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -136,7 +136,8 @@ static int pack_geometry_cmp(const void *va, const void *vb)
 
 static void pack_geometry_init(struct pack_geometry *geometry,
 			       struct existing_packs *existing,
-			       const struct pack_objects_args *args)
+			       const struct pack_objects_args *args,
+			       int pack_kept_objects)
 {
 	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
@@ -1063,7 +1064,8 @@ int cmd_repack(int argc,
 	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
-		pack_geometry_init(&geometry, &existing, &po_args);
+		pack_geometry_init(&geometry, &existing, &po_args,
+				   pack_kept_objects);
 		pack_geometry_split(&geometry);
 	}
 
-- 
2.51.0.540.ga7423965ad8

