Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC92187327
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250743; cv=none; b=fkBbGSKFxy2JOd5jlRB3mKP+NEBPkssJdo1077lgFeeLObMRI4xgWzh6tKx5Iwx28YTwKHhlC3r6VIPb7Up+cV/V1Yju1Orfz1fU00wOujnXTDIfug5J+AvPL5PKsr0Jkn2/hMvQ3f0F6++ImAJzEA4QOxF+opHumh8r0R4gJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250743; c=relaxed/simple;
	bh=Z1uJWiM0bY0+Z/2NRKFSV3TOqCNO8nT/bznc9aElnMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqxSFKwqeCJ1E1+/GnT8+6qlXN0FumSZL2Fc46SO8ayOryeZBKCzaRD3J5kIzYUVhe8KT3i0P1Of+urVhOzwgvZdaYLIDUPPfYU9XqNtscFN3botdQybCt86olZogUqQ2RsO/wiOhY4xmwaA9LMCq9u2LUSUkwxOcJbNCqfHBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ADoRBpoU; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ADoRBpoU"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e05ebd3d607so138646276.3
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250741; x=1721855541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpOwbj/ng4c/WJGvfE+VS011anhpk8Rt14+aBR7cXfE=;
        b=ADoRBpoUW3MXwv9Cqcavhbpp7royes9XXDcyxn4Sm3a7b9laziB9PW6e177GiAFaJh
         eGek20R+9vUj0Ol9ERt5aLTXMg4AZtR/eFHEKdhqNZh6E2IXJlj/4xPPeagqzQJ2+Zqc
         3Un/FXVGYQfdHcpJRXvqzKNWqcDqEMUwSPttLRyxZ7KkMDZUtoo6dEQcd8mkesxdrzDZ
         i/Ras/aGEJGZIgwouTzCGsfDWF5uR+QJG/ke98z4HKEO3olFemTg3dHvqDMexzEnBvbd
         b1r0dEmOTVrSArnQX0z6VAu6GWqbXmWJ3+NppA63dyP58XcW8EekEY5zMIHbNmeucWCO
         j46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250741; x=1721855541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpOwbj/ng4c/WJGvfE+VS011anhpk8Rt14+aBR7cXfE=;
        b=f8oHA9PqmEi1Tc116/ggk2C86Jvxa9oOgp0aAwN8oIQIwRq/3fjjkKzgZUEDjd4qX5
         1BsaKofPUqtFqnSoGWS7JryCx1MxBTjBzue2LaSgp4BmqHX4R6Gy5tRVIGCzMHy9G6pK
         5v6XVTTmOiDTS6sXZdjVIWdetu/poDDNzlGPUnJ7Ivyg7DDrpibtlL0IOjG7NCWXk2Lp
         oxHnJr68Oo+/y9KMSzbejXH3TrEtLSZwtIkApwUTReDQLAWFG/D0vGDHIu8cdfannpgU
         P11yzmFb7p791wLMyQr0v10eAA4mjMKO355L8OF74PmiIa8+P5JxKPIz78ANnnw4Fx8B
         qb3A==
X-Gm-Message-State: AOJu0Yw0R+xbWlAnGjwB9jnx0ag5KDyEdCA9eGNxF8mObVFWZ5xjj3Ru
	O+mFAemTx3gcTqhNC7aL5jY8YmavhXwsWQiUhLo1qyvysNi/1GSvdD0Tw+tHFEw3LeqPF5Zi3Hf
	v
X-Google-Smtp-Source: AGHT+IEJBSCvkqr6J8jBf4s9PCM8tdVoEvfdTs40Tsw2spXcLvsT2hik9W181nmQcFS1jLSD+Sl9yg==
X-Received: by 2002:a05:6902:1205:b0:e03:53a1:ecd7 with SMTP id 3f1490d57ef6-e05feae4d54mr781392276.22.1721250741042;
        Wed, 17 Jul 2024 14:12:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05fea87adasm81027276.34.2024.07.17.14.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:20 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/19] midx: teach `bsearch_midx()` about incremental MIDXs
Message-ID: <38bd45bd24436d3404b089dff5c3d85f4026da97.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

Now that the special cases callers of `bsearch_midx()` have been dealt
with, teach `bsearch_midx()` to handle incremental MIDX chains.

The incremental MIDX-aware version of `bsearch_midx()` works by
repeatedly searching for a given OID in each layer along the
`->base_midx` pointer, stopping either when an exact match is found, or
the end of the chain is reached.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index bb3fa43492..cd6e4afde4 100644
--- a/midx.c
+++ b/midx.c
@@ -343,7 +343,10 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m,
 		 uint32_t *result)
 {
-		return bsearch_one_midx(oid, m, result);
+	for (; m; m = m->base_midx)
+		if (bsearch_one_midx(oid, m, result))
+			return 1;
+	return 0;
 }
 
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
-- 
2.46.0.rc0.94.g9b2aff57b3

