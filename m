Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BFD15ECD7
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653680; cv=none; b=d3DF0NX8CNYjTRO8/ETl+MdqkHt5zezmfF/JgA3p9dPJP0TME0SnoOaqqTMRTd/T+rZpMLs+LTula4hghC3ZPIZ953jfVhye8ESAK0eC2Yr1nEXnnmkoTkcUY3E0zmQrmPRBLsZX3unDrdsPqpLowfHgmZEU/o5e2/sVshxsMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653680; c=relaxed/simple;
	bh=iaYLhVr5ITdgKklU3wMRBe6kRZ8OVjP8Gufp/dLGIak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0QEnMUeQzAj3Z9vtXqRWOXkLYnvntSNgSFjzJUw0aEoe8xG3LrFnV78KA0tLLpKu4DIw5Wa0FkF6j/8opVymvqWeMJPUnNlrIx9kgPXIf5tuy58wtNBBMe+GRZzx+WdaRz7xyZ9Ix1tnzWAYRPd0SCeaSs97EAVOb9j2F72OQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2Vcg+jb+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2Vcg+jb+"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e39f43344c5so1705002276.1
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653678; x=1738258478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvl2c/EZuDTHNncUogAJwA1jcWgV73J4Dfo5ZA9n33E=;
        b=2Vcg+jb+nGse5n8hpyu4hfEpMs8iJOIFUPSE/MxHL2wDmVHCXe0z3UVlsfoI1Xvot1
         qlX6WLtX0AQJB/pNdjNPVFAWCNDleh5yRIbI5pelnKfRxINrGd7qCG26gyC6+2Ufuhmx
         dkyJ1VxaSj8NUb+ZGMbbBSYU+Qt/rS8I9kwhospth9B1NtS5XRHMGzbQO3rB7x0LQuxb
         7B2z6/cx6VWGAAcgXdtMmJU4+z2JsSLMwuyku4EIT68/Z+8FRgV8cAQfGJXr66Zi58yC
         SCHvD1gVb0qAW4TgXVj7jbxUZr8sd46pTjNw+kCJueY/CU+ObPBo5sKIzrA2y3k7yrG3
         HmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653678; x=1738258478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvl2c/EZuDTHNncUogAJwA1jcWgV73J4Dfo5ZA9n33E=;
        b=mXrjhI2H5xJlRB1Q4zZG5/JQb/9jw92iisoDvGt0pLN2gE2S0Z2lmBwHCkzI1SyUYm
         0cTcoAeoqHJLUfK1B9keEO3Hhpp/AQ579Z/+/JD3jNY8MhKFr27oJPg/MX35JeaNU9J1
         7n+6bMmH6FRJFTC0pkt/QKKQ2JEMg4E5nFYWNkZwgRLbEBKv+/18RBlfT3hUKdEJX0xC
         4OmwbyP279KggS3ofEvSvtonubIopEgokRFipA9aT+IknAdKwdK6IkOBSLD/HRJsvnRy
         ofgAwrjfswo7d7CBc+ZTVZuthLxGzZUJ9xCyzEoWwlEyemOscSGHnFIPoUYIl9/BHM2N
         PZkg==
X-Gm-Message-State: AOJu0YyxItUHjDsamOc8N1L4kszUAakzaMr+mkeTrDZ95DADL3VDlq9A
	Y/kSC82IwUBvRCB7RQ0GddckxsokYRH2hEyHhRjyy9q4T+Adk+Sgq3fGjviGx15tLWFYyK82MAM
	e2N4=
X-Gm-Gg: ASbGncutZ4ml8TqQ03QD5flsuiQxJVTpQ7O814cqu+9YAgWsI/GhtoMKSUzDRDh+5oG
	FEl0H0+Amm/eAkvV/OgHnaTSzeHkYvClAapyCqDc/9F9EdccZ0jd2tXbJtvQT/Rn//btoutZUBU
	aF3Icg7moaRkQMd3yr55EDsxl+V9/5L4PdIHBOQjPA90LDmulWuzylxdJFNnarDpmEeSGFnlzqU
	/Qn3qsjhUCC57+2LOMYKIeKkxXrB4BQ4bmD264qgGqywq9+XMoTnmnsFTcxxR2kWTZ3NOlEtpKp
	CUxCwFWD/qqqJefIhDDoYZT0Pzq+FKLkZPROAC1Ku/g5/uXps9Au
X-Google-Smtp-Source: AGHT+IHjr2YfPhiDbvTppSX2G5yUZzu42US4mbyLI07ffKi0SnIyZcymdRMMbVNYOuFFf2pPhErXxQ==
X-Received: by 2002:a05:690c:7202:b0:6ef:4fba:8137 with SMTP id 00721157ae682-6f6eb65c4f7mr216443517b3.6.1737653677780;
        Thu, 23 Jan 2025 09:34:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a0124fsm453387b3.79.2025.01.23.09.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:37 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:36 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 6/8] t/helper/test-hash.c: use unsafe_hash_algo()
Message-ID: <3dcccccf75275d62d533773db4e027ef051d5388.1737653640.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737653640.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737653640.git.me@ttaylorr.com>

Remove a series of conditionals within the shared cmd_hash_impl() helper
that powers the 'sha1' and 'sha1-unsafe' helpers.

Instead, replace them with a single conditional that transforms the
specified hash algorithm into its unsafe variant. Then all subsequent
calls can directly use whatever function it wants to call without having
to decide between the safe and unsafe variants.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hash.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index d0ee668df95..aa82638c621 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -9,6 +9,8 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 	int binary = 0;
 	char *buffer;
 	const struct git_hash_algo *algop = &hash_algos[algo];
+	if (unsafe)
+		algop = unsafe_hash_algo(algop);
 
 	if (ac == 2) {
 		if (!strcmp(av[1], "-b"))
@@ -27,10 +29,7 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 			die("OOPS");
 	}
 
-	if (unsafe)
-		algop->unsafe_init_fn(&ctx);
-	else
-		algop->init_fn(&ctx);
+	algop->init_fn(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -49,15 +48,9 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 		}
 		if (this_sz == 0)
 			break;
-		if (unsafe)
-			algop->unsafe_update_fn(&ctx, buffer, this_sz);
-		else
-			algop->update_fn(&ctx, buffer, this_sz);
+		algop->update_fn(&ctx, buffer, this_sz);
 	}
-	if (unsafe)
-		algop->unsafe_final_fn(hash, &ctx);
-	else
-		algop->final_fn(hash, &ctx);
+	algop->final_fn(hash, &ctx);
 
 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);
-- 
2.48.0.rc2.35.gd215225db14

