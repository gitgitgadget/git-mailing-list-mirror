Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B630F928
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567328; cv=none; b=kdNqOKqivCDuOhCXdmyMUl6QhQPrMtc+xqsHUQCL2FFnR65Aea2vq/Zbl22kUFXyegLP+mpaHwQVbGOLYBBwXOcE3le6cWIclrvngHm2TB81hWk8gAwrelFi2AOqDoCLjaoBm1OsHndowYe6VcQ6dhsjirpR3AK46T/uTnsCvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567328; c=relaxed/simple;
	bh=T7G0QOHu+ahOviTphRRvuBvdUk9XKzqJrCUgVMNC3+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH4ooyN+6cJLl7m3LW6FUEf3p8VAaU5cXcSOuuOsS/9VFeV+HsK1szWaJYwYCupSqthjbfHMZzpuL8zdKBUUQXRX0l/FGK14cA0jmGOsbB/LgzxJ4cmdwYf7UZ8JCnjN1gSVkK49X7/IBc7Fh5pUzbGyRc21b1SjZXcyaff9VoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qXir+GPb; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qXir+GPb"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d5fb5e34cso927417b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567326; x=1761172126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuddVvbsBtL1K3tGIxaFZRMtJwzTDkWT1aDvUrn4GSE=;
        b=qXir+GPbfDpYhZBkwRngU7m6o2KbkSINTxtUu9h35P29xWFqHMW5zydNViAg5GdLBj
         IdiVNP5zleF52DVqCimztP228uFMQLVnZQxU2adNWQvdANDpJmgyYmjQ9akvf8feHkRb
         eQdjktfg97g2VyhVtblWBElGmIjzVwutq6CRdMX1ePM06XEivtSGulPZAA1Q/6Vnrala
         pInrkybRsx2WBNu8unvVFs3FnoWUoTgJ/01AH0Z9wp2EtQVeFyjdbuM9W3//xCwru4HU
         d+ZfQ2yC95+OH9qwPDngdXd1Bu27oJMdKltmFASYlFj3HgtfxVa6RiNuVi4smtwQmA7y
         4dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567326; x=1761172126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuddVvbsBtL1K3tGIxaFZRMtJwzTDkWT1aDvUrn4GSE=;
        b=l0vwJlYZ2HvK5GXWG1jjUFDLEfmSqEP2YXVhY9dPgNMhsnxP1GOnMAW43JQw6POMXR
         +YGa1JWDIYOaOVWnGt2GgPnKH+NlLsbugtQ4Osw8pGu2ambIppceRiBLI9FF0IR1GISw
         MrGfnKYUKuCXFMmE24HUbjSH7bOCEuZsIU/ho8h/YiJaDEAiZ+EPYtw4aZKaJaKs4YDE
         gvuIqvgNzqpr7jyYZwx79hOoRZfhzM5EfK+u+mTq22O71ctGtShrN70gQqywyeWiqew6
         7+e2wUiaZ1yCgZ9w1PdTt672Bzv47wkf7jl2LmAzvGxSl/Qkv/TmlxCWEWK76deHQctm
         Lylg==
X-Gm-Message-State: AOJu0YzDZe9VdO/Fb55QD5YBRyGcE8pA8Q3x+5pniufRPfloPE2x9K/2
	808bBfLTl2sC1XSkalpJdZ6y3CzljO9p6XlM0b5db9olUiQr8PDFBmjqEonqUPZKKP60HRS0r7X
	CyRkd9dxVxg==
X-Gm-Gg: ASbGncvnmSE47yqLBL5ZRNLPCrFrQVBQqZm2+mUwnIYc6gUPugnwJFkW7e7y6brHwlJ
	38Py0RJAjaMkGEDox2FlUuGFit92rjtJdlytjBHSLxjThhC5820vf5VKRfQ/Y8BPW4UJMEbysZG
	2h8kOol5RlK+SzDGzr9zuowrJDHl4D8dlR1sQQy55+8MbR+z83Mz3Imh7DF5tosoHqZXOTZWFCw
	Da/ZIL+JfkEbquWzJ7sCfXFuSKtyPzWr91++4IZLzssW9L1m/MzCWFCutCkNaA78jD1WBcq3Dvz
	/4XEnCpicBT8BumMnUs65b+p7GnWHRDMpXUkvTUVTweLHoNZyuQCzLRc+/32nuQUhOcZ89TNkGD
	7fDIxoSfHBGB6H4oZyofs6WZ+V87dzk+Bw+2AtiSBLB7vNVDRAGV9mVOyEKwaZpR8zP95UrMuto
	dWdziI6ZRguh383EaQBwtPierhtKfqFmxukYkBj3LICGHq2YxPDp/yEpj3+7mwVlEKZT+2sDItp
	o3PlsY=
X-Google-Smtp-Source: AGHT+IH+N85mO4g4CTU190eYxa/lVqvhkdjOUv9df1A/JI3VCaLgvkwP3fwPJAuo+97TWcvizv+2hA==
X-Received: by 2002:a05:690c:3691:b0:782:b8a2:61c8 with SMTP id 00721157ae682-782b8a26423mr6857897b3.18.1760567325726;
        Wed, 15 Oct 2025 15:28:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292c13805sm2592537b3.38.2025.10.15.15.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:45 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 29/49] builtin/repack.c: pass 'packdir' to
 `pack_geometry_remove_redundant()`
Message-ID: <0a2a72ea22d5e4ad2fe5c93c2691a5d089b32589.1760567210.git.me@ttaylorr.com>
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

For similar reasons as the preceding commit, pass the "packdir" variable
directly to `pack_geometry_remove_redundant()` as a parameter to the
function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ac8c80d0a5..f6d04b33a7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -307,7 +307,8 @@ static struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geo
 
 static void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 					   struct string_list *names,
-					   struct existing_packs *existing)
+					   struct existing_packs *existing,
+					   const char *packdir)
 {
 	const struct git_hash_algo *algop = existing->repo->hash_algo;
 	struct strbuf buf = STRBUF_INIT;
@@ -1327,7 +1328,7 @@ int cmd_repack(int argc,
 
 		if (geometry.split_factor)
 			pack_geometry_remove_redundant(&geometry, &names,
-						       &existing);
+						       &existing, packdir);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
-- 
2.51.0.540.ga7423965ad8

