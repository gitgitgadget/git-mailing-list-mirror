Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610341A83FB
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763651; cv=none; b=cPs38uyS9xcN4kFQj3W3HFz9315ffDlWw1s4mubGmJfV7FamXEG/iXfPS7lerBpZbbFAu/sowPSuBiNb0iQxed0jY9dnZ2xQuqyC2pTEx0wtrE2WmP3//3TTmHm0DyAeU8P4lt7YYjegiJldiJIZq3AhXwAwfYDHoIDLId2TP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763651; c=relaxed/simple;
	bh=R35Rqts1ZhNGNJTCyfL4OYg7blM4v4uvSbhT/brP7og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9t5atewfIR0V6R0UiVXogFnN8DBlycU65DO/LdxiNI0AjC1tAY5zIlD0qwHyxhQP5NNpo5vRA0tzz6xge39BMoFgFzYsiNWMMgCYn8ufHanEUBj8pnlS0fb/XLMIUfgXFtKAvlOwVoFZxJWDKj5vcijXedIVmFWHhMss25dvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TE302fXd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TE302fXd"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476ae781d21so58136391cf.3
        for <git@vger.kernel.org>; Tue, 20 May 2025 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747763648; x=1748368448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OQaos0/rny7znF4TQvNZk/5ecpyTfGI/FpnkQxSkUc=;
        b=TE302fXd5O9qQLlD0dxj5+ht525Ej3DRrb/fmacy89LmESpdBBW310Ldm7wNg7bd2N
         TWhbbpIbUntP/Syl3YLZcJq0TG9J4YynRF51w38aLjpgOc+l8gIJnYVV75BSFmPl2qC/
         CGr6L+RXgNZHAkvnvszojbFKqRhROYE9Epl5ZbZtMnolEAp03qMWUlkXnSVQ/72GvO03
         nbBKcBEviq5B/eG2qb3WXwuRTZ3skECBv8PAGcikUH3oKUPZnclbVBcSp8DT4982Mtoo
         EVPbH8FTFSbyJ1Jg719EVgTRNHQrYEh6jlRZhErX+bG8wPnqfOQG+5LAZbt8l1kmo4Yj
         GLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763648; x=1748368448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OQaos0/rny7znF4TQvNZk/5ecpyTfGI/FpnkQxSkUc=;
        b=Mwu5uS4wJgfiL7IY4VWhFIIJ5sYLsfzt5TNqCPy8WqcTTEgLJ5aGbPiAVo6H90yg08
         yloWrRHrJOiCt4uySa0AhZgUfSMAYE0l0lxQoZ9j0yG1JYrOjxpzczi4Qth8+P2k2yze
         RbIaQmpQ1fmTa2IBnxLyt8vcVcrGoH6ja0h9vESnPpra6DD9Z84/5hNwmdMhA0tct6Jl
         rflbK9L3ePWlNAcSRwOwJ/tYIsJHgLnSvtpIockkMw1pMOZcqOlUZyV+k2lr1r7IX7C9
         kGDNLFfhycZ5LY/f1eU/rA8mGAVr32leZVOzb39oKCa4NraLdTqyKIAPv2bdLkU+ZOqA
         7hyw==
X-Gm-Message-State: AOJu0YwTAjvjYxsZhgFw1n0gSokQriM6tUD++CJDjSfprasQDxn5dhpe
	rgXl65zXmewsg8CXDb6AKPFgoLbFFTjGyNNYLOlgoIIZO7bvRI8i5bDkFcX5ya6j87TI66fuiT7
	l8L+p
X-Gm-Gg: ASbGncuNg15y6Nds1OsRy8ifljIdA5gLlYI93y6Nw5FEmil+o+W3f42DeUxFvyuDXVQ
	au/lniMnO1yEo4l9h0QwmP2aBw/XHw+HS7dG0+jB3PBNce4cnfBJzTa0pwHMNd8BNhnVt48BzK/
	bGP8RqKPDW8/ObN8UoUF3RaQfQ1f9IQT6TnOB6TrdV1872GuTYh5bgp4IfwgJavm8W4zKo7HMaw
	6cSkuCJjQGXda+GvHQlBaOZFmxROKg39mN4HWXPUWry9NphFSwrhGW8cKYqYsSQcNuzl6UNR4yg
	GTwh8vwa0W1gn4fzCxFA02icWPPBWAUtRWo9Lx9UXFTqIHxf78r4sQCXa8ampY4mUqU990MNd6G
	MVF4cu6TmSRXHUzg/VvC6x7k=
X-Google-Smtp-Source: AGHT+IEqTIrs7c23Fp1Q7eKaMlmwJUzW506zyuIKTbFk63XbPEU5Kcibeb1xJDhTSYPzcCZlcfAe9g==
X-Received: by 2002:a05:622a:1e92:b0:48c:512d:bd21 with SMTP id d75a77b69052e-494b00e973amr280034941cf.0.1747763648092;
        Tue, 20 May 2025 10:54:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae3cef4csm73424511cf.1.2025.05.20.10.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:54:07 -0700 (PDT)
Date: Tue, 20 May 2025 13:54:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] midx repack: avoid integer overflow on 32 bit systems
Message-ID: <aCzBvvZDS2OFJ30h@nand.local>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>

On Tue, May 20, 2025 at 04:04:24PM +0100, Phillip Wood wrote:
> diff --git a/midx-write.c b/midx-write.c
> index dd3b3070e55..c7cb2315431 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1699,19 +1699,23 @@ static void fill_included_packs_batch(struct repository *r,
>  	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
>  		int pack_int_id = pack_info[i].pack_int_id;
>  		struct packed_git *p = m->packs[pack_int_id];
> -		size_t expected_size;
> +		uint64_t expected_size;
>
>  		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
>  			continue;
>
> -		expected_size = st_mult(p->pack_size,
> -					pack_info[i].referenced_objects);
> +		expected_size = uint64_mult(p->pack_size,
> +					    pack_info[i].referenced_objects);

Makes sense.

>  		expected_size /= p->num_objects;
>
>  		if (expected_size >= batch_size)
>  			continue;
>
> -		total_size += expected_size;
> +		if (unsigned_add_overflows (total_size, (size_t)expected_size))
> +			total_size = SIZE_MAX;
> +		else
> +			total_size += expected_size;
> +

But this part I am not totally following. Here we have 'total_size'
declared as a size_t, and 'expected_size' as a uint64_t, and (on 32-bit
systems) down-cast to a 32-bit unsigned value.

So if 'expected_size' is larger than SIZE_MAX, we should set
'total_size' to SIZE_MAX. But that may not happen, say if
'expected_size' is (2^32-1<<32). Should total_size also be declared as a
uint64_t here?

I wondered if it might be easier to count down from the given batch_size
instead of adding up to it (requiring the second
unsigned_add_overflows() check). I tried it out and got this instead:

--- 8< ---
diff --git a/midx-write.c b/midx-write.c
index 48a4dc5e94..f81dd9ff6d 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1671,7 +1671,7 @@ static void fill_included_packs_batch(struct repository *r,
 				      size_t batch_size)
 {
 	uint32_t i;
-	size_t total_size;
+	uint64_t remaining = batch_size;
 	struct repack_info *pack_info;
 	int pack_kept_objects = 0;

@@ -1695,23 +1695,23 @@ static void fill_included_packs_batch(struct repository *r,

 	QSORT(pack_info, m->num_packs, compare_by_mtime);

-	total_size = 0;
-	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
+	for (i = 0; i < m->num_packs; i++) {
 		int pack_int_id = pack_info[i].pack_int_id;
 		struct packed_git *p = m->packs[pack_int_id];
-		size_t expected_size;
+		uint64_t expected_size, factor;

 		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
 			continue;

-		expected_size = st_mult(p->pack_size,
-					pack_info[i].referenced_objects);
-		expected_size /= p->num_objects;
+		factor = pack_info[i].referenced_objects / p->num_objects;
+		if (p->pack_size > UINT64_MAX / factor)
+			die(...);

-		if (expected_size >= batch_size)
-			continue;
+		expected_size = p->pack_size * factor;
+		if (expected_size > remaining)
+			break;

-		total_size += expected_size;
+		remaining -= expected_size;
 		include_pack[pack_int_id] = 1;
 	}
--- >8 ---

That reduces the two overflow checks down to one, and avoids the need to
introduce a uint64_t-specific variant of the st_add() function.

Thanks,
Taylor
