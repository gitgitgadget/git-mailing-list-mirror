Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FB1D86C7
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151417; cv=none; b=gNAIkiozW9A4tY9X/gFXzOBTERxSpzifNcJ/xvU1trYPxLCloCskOh1v2uX3xipAdlgbfgGdYllfe9TX7Qi9C4kTkh5ku4BBn+qNc2OBmiLnKI78dOiENkunuttOPMgmm6eUMfzBDCZTjMBh9bQ+tcidgHGBKTg5OW2ZXsL0NyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151417; c=relaxed/simple;
	bh=Q+pHBQNslBienbX/Wz9J/TCqDekok0lDXoQcJ8Rhaiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlGn9Pggd5vY2f9ZGnwFg8ZIbN/KNoUN5TboRnhAyXjx6M3YsqcaBpWtPqGDdawGwYkqCnTU/kpXVtci1AYRRMJliXKh376KEQJcWYjGZaEZbWU9/MZlWGFovlFpz3RrDmcroS58OBaSckmsHkiEpKljCaBNwf0P253xKt7+A5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vm+IiSQJ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vm+IiSQJ"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so4289927276.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151414; x=1737756214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJIDRo5Ke0OvXwV3YjkKD7Fj8WeUZtCAkJVeWYEnzdY=;
        b=vm+IiSQJ6p198brt/uFPdOU/svbUBgdxcDc6xfq3aA4hldomlaQmkSvggQfHKU0M8e
         V2LQPA6rX4wAPWlqWi8uqS2Dqy7HBtu3JhvVIY4qm3o4R4UutaUVldB7tjSEkEeyzdzI
         5He0qXHgEc364dHyaB+N9wtxnUNSapmwfHS0PNzGl0YvGOJRMz7z4/o7Q0lYgKcjRbqh
         xVN1VtKgiw4tASP7VICHUyCPEQ0JWCQpU0kiJS70ii8H6UkQMBD2sBoe/Dyy4KuFecrd
         OQVj6Jqlyjg2yElDJEgD0Atsyc6uOkyBCTW0uoDE5hS2yIw9aTZrMQtiFuT0emLrFmip
         fgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151414; x=1737756214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJIDRo5Ke0OvXwV3YjkKD7Fj8WeUZtCAkJVeWYEnzdY=;
        b=KCjbR9O4Kq3ACqvsRBWCXb/xLd3m43KcpPcp+2Pz48VsGItqOLn3kMYrA9Zbysr9iX
         ZEe7yXRNfxJqzgXOuhoWucNYw6If6osQRnXDt51fLwGrxgh5dwV1cC6WjOa2QppgKP24
         lutw8gkETpGG6PVUIrUNrrfY4AaI/OxI6PZaf91XlkINTGGuIGjcgtLGsSR4ywEYTrAV
         Ix5II59QGoTIrDjQmpUzsQdqhQavCAv2vHIQoWhUycZphvHpgX7rMNcNJjXSh7Ck5Zyz
         1qH78UoPlCKvaTc787LD+bsQBsVmhrIK8AHZWerTx+yGKjQtPiJFCunTkDqhsvCR9D75
         FVgQ==
X-Gm-Message-State: AOJu0YwpbfrWG3PrB8nJbkMni0gAlfdRB725qLyT19j5woMJ1Y9DL9I9
	dzykdD3lA88AqS9908kIzz6ZF4e3wvQ7/C/Hwnu9ULFgkhtUyWR0+5+lhye13/G29aAbyWFSfnR
	P4JU=
X-Gm-Gg: ASbGncvgnzJfT9PBzfG78XKe5IoAcWOn3/PC+VO2oSVTCCI2nYdVASP034L12Oelhzj
	2FIdC8AP+yfX8sPafEJaB28++3IMcNG7qMd1PTbP7muexUfNEFCmOpuxgt/XlBxyDjqnGLaGQwE
	dMYH9Grc+ThdgPNWhYqjddklu1DCK2nExnHPFHcI+21Ots872DqQ9Y1EaarnFJkxIByVRHCWUga
	WYuQkuCvhKCeoUXrhiqgCwgRnpXsh0LQOUbNyd6dN1ERKiPLuEZZc8Gj9d7C6Jrc+Wivu/3O3Xi
	rWW5IYt0OF1xAtiOqspgm9YCNPQ9
X-Google-Smtp-Source: AGHT+IEQrrT+pam3toALyYjhzlFUp9Oc21L0Dt+gAchRP6Pb0HP6Vhypt6qa+Y4JDMJ2oCxBr17/CA==
X-Received: by 2002:a05:6902:2b11:b0:e57:90b7:e37d with SMTP id 3f1490d57ef6-e57b13afdc0mr2791313276.33.1737151414269;
        Fri, 17 Jan 2025 14:03:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab479729sm584543276.54.2025.01.17.14.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:33 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:32 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 8/8] hash.h: drop unsafe_ function variants
Message-ID: <0c4d006e6e8005c10387d10fe0224aec5c5613e5.1737151386.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737151386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737151386.git.me@ttaylorr.com>

Now that all callers have been converted from:

    the_hash_algo->unsafe_init_fn();

to

    unsafe_hash_algo(the_hash_algo)->init_fn();

and similar, we can remove the scaffolding for the unsafe_ function
variants and force callers to use the new unsafe_hash_algo() mechanic
instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        | 15 ---------------
 object-file.c | 15 ---------------
 2 files changed, 30 deletions(-)

diff --git a/hash.h b/hash.h
index a68a2b6a161..68d4292e6da 100644
--- a/hash.h
+++ b/hash.h
@@ -282,21 +282,6 @@ struct git_hash_algo {
 	/* The hash finalization function for object IDs. */
 	git_hash_final_oid_fn final_oid_fn;
 
-	/* The non-cryptographic hash initialization function. */
-	git_hash_init_fn unsafe_init_fn;
-
-	/* The non-cryptographic hash context cloning function. */
-	git_hash_clone_fn unsafe_clone_fn;
-
-	/* The non-cryptographic hash update function. */
-	git_hash_update_fn unsafe_update_fn;
-
-	/* The non-cryptographic hash finalization function. */
-	git_hash_final_fn unsafe_final_fn;
-
-	/* The non-cryptographic hash finalization function. */
-	git_hash_final_oid_fn unsafe_final_oid_fn;
-
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
diff --git a/object-file.c b/object-file.c
index 43efa4ca361..c4b42dd4be9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -230,11 +230,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_unknown_update,
 		.final_fn = git_hash_unknown_final,
 		.final_oid_fn = git_hash_unknown_final_oid,
-		.unsafe_init_fn = git_hash_unknown_init,
-		.unsafe_clone_fn = git_hash_unknown_clone,
-		.unsafe_update_fn = git_hash_unknown_update,
-		.unsafe_final_fn = git_hash_unknown_final,
-		.unsafe_final_oid_fn = git_hash_unknown_final_oid,
 		.empty_tree = NULL,
 		.empty_blob = NULL,
 		.null_oid = NULL,
@@ -250,11 +245,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha1_update,
 		.final_fn = git_hash_sha1_final,
 		.final_oid_fn = git_hash_sha1_final_oid,
-		.unsafe_init_fn = git_hash_sha1_init_unsafe,
-		.unsafe_clone_fn = git_hash_sha1_clone_unsafe,
-		.unsafe_update_fn = git_hash_sha1_update_unsafe,
-		.unsafe_final_fn = git_hash_sha1_final_unsafe,
-		.unsafe_final_oid_fn = git_hash_sha1_final_oid_unsafe,
 		.unsafe = &sha1_unsafe_algo,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
@@ -271,11 +261,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha256_update,
 		.final_fn = git_hash_sha256_final,
 		.final_oid_fn = git_hash_sha256_final_oid,
-		.unsafe_init_fn = git_hash_sha256_init,
-		.unsafe_clone_fn = git_hash_sha256_clone,
-		.unsafe_update_fn = git_hash_sha256_update,
-		.unsafe_final_fn = git_hash_sha256_final,
-		.unsafe_final_oid_fn = git_hash_sha256_final_oid,
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
-- 
2.48.0.rc2.35.g0c4d006e6e8
