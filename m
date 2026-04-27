Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAE352F95
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310591; cv=none; b=LceWZ4BwSA+rujYPiKEtoLlIH7DP8CUXHTuanKVby+cR3INlKMNMCPXT0CVgpXU0PuQVC0FgnIiCaYSzeQCydmYHDdCZbB0gPmR8rEcEFLb8uFcpAJ5gRNSkze6ZVRTyC9OQz9Ca5FlKtzH/BXO9gu2Jr0T0/xuzuzytk4saieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310591; c=relaxed/simple;
	bh=Nd9FgNUG6s26zFtzuOCZWN9ixl28RolC5SMVRqxHuIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kggFnHedQY1EG/fupVmhc0XJGv6SiSKK7EsTzbXxdKxRKFSSC7HhbjQi5haxdVbboerpthUeYz31nOkTkRIYT7yQU4sDwfed0eU2lqITy+QbxXVFhLD9ck6FbG9vP9MG85rocRNZ7fOX2V8FU8KnW/N9Gy5BKXRbHBk5pSVkQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0QA9/36; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0QA9/36"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ec37d52c0dso1059047185a.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777310589; x=1777915389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UemOsuvanW8JSFFP85AVIFjmd5jyVDYR+kDpVyCTE4=;
        b=J0QA9/36OAc2gaXCVq8u3gxIRw6i2v2VRHg3q9YwBAprBh5+mVB/wliCILrstXEqTn
         9mICdjbVJHAjRFiOw2KU5bhwjF/sxMzV5VIzc2O+9b3++cmGXrQLmPibDk2a8oTdqUjB
         CXijKSBIq/A6JG77M13J/h5J8l0GZaSNKb8Fp9y9Vnwt1Oyn4F/cUTFNWhevfbKdfL2e
         JaV8/9vjYSNL1jDD8XD4XUVL9SUkb5xN/48zqm7bMv5K1TArA3JWvC+lgvkpItSDdhpJ
         aFD3e9TuoyUvxT8e0FctyyF8zKOz0KYmfIcyHu+oQRRNi3sWS6JKc3I5GEnPHlOLHxEk
         w6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777310589; x=1777915389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UemOsuvanW8JSFFP85AVIFjmd5jyVDYR+kDpVyCTE4=;
        b=TVXPmjXs8nMLLhYqxOi75F3FIAFzL7czLh0CiKYZIfpbarRRFIdmWW1fPP9EUpFJPR
         XdoN1MlH+BElHaEUZipwrFmEjy/XjXyEDIlsXusqQx1sJfdBP658UgiOrankaMLzyazu
         GZANNmCkI6IUgT1E6rrSXKHVEZqt0zv02kir0I+xCiQi75vGFfU83NjY4Ko6QhdvWbpe
         rJ/0zbWMuNugAnK5NjqO8RdIAGAp8JjAlJ9UHb557m+GoA61thIXhfBdKu31/7QSQSoO
         onf84STrp4mt/dQsOmoNGSX/rpHdJgBddUlreH6B224+/mNliM3SodzygffmXPiM2yHQ
         mpCA==
X-Forwarded-Encrypted: i=1; AFNElJ+G9xIPfo4UhrXY+g1f3GMCrThniOM2L4II/YOYJq6qYh0Z9sy4r6TNw6ywASXN8taI0Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QBUimZlXMfam4mZ3FZhekzt3kMqQLBMkt93lGxiY8zMD0twa
	pJH8DaRV+P8CVE33J3/NB5q6cQRQpp7CJ8bK+NHgOV1B6Y775AY63bSV
X-Gm-Gg: AeBDieu8EZr4M5HFluRC4D0nHoosL/Nc+ghs09JZ1scOizaotDxbCIc8JqWXWLXkU7l
	RN2VIe/KaA9FYQ4sVdrlv96GU1kaAouZ5TTjPin1AsCztTTTqqOoGxaup04MMI6P1EoHvGvfSXG
	hr6TLQQ/h9hFcGhHTwnOMBKKM5BzcFHcN62MpvfmnmWsfsCB1GY+zFvX1AVKxw+CyjaQzdgqlUa
	aoExzkHdHLnxfPdgJ+fUB0S/B0brICwcibZgYYnicbFlCMi7RzAccuHr6cjpr1xpTFzPpVFBCTF
	/xw5B1c+VrQ6M/nZ3g2ZlDIQOafzNjna8IkPrIqPxr5UmT+Ud/AzcXn6+tfsbAYzGa5426FCGAP
	U+KthVnR98nnROzNrOosUgbKvnL3T7UBTRZ5sx8PbjA7NSbEJ4fZYYldZqwiyQFL79WWCzf8h8c
	sioDENkkZA2r+LUkKYW6sIyyBPf9gVvI7wcXFygGdoMshJPcHJAd6zXlO0NHQ4qPvUiGLSKsZZL
	pqbsO9i
X-Received: by 2002:a05:620a:46a3:b0:8ed:3c1:4bc6 with SMTP id af79cd13be357-8f7b5ba3754mr51385a.57.1777310588913;
        Mon, 27 Apr 2026 10:23:08 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ebde788c01sm2031676185a.10.2026.04.27.10.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 10:23:07 -0700 (PDT)
Message-ID: <5498637e-178f-48aa-8cdc-adc38b100627@gmail.com>
Date: Mon, 27 Apr 2026 13:23:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] index-pack, unpack-objects: increase input buffer from
 4 KiB to 128 KiB
To: Scott Bauersfeld via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Scott Bauersfeld <sbauersfeld@g.ucla.edu>
References: <pull.2282.git.git.1777058098756.gitgitgadget@gmail.com>
 <pull.2282.v2.git.git.1777306114914.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2282.v2.git.git.1777306114914.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/2026 12:08 PM, Scott Bauersfeld via GitGitGadget wrote:
> From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
...
> Wall-clock time of git clone over HTTPS onto a FUSE passthrough
> filesystem with writeback caching disabled, 3 runs per variant:
> 
>   vscode (~1.26 GB pack): 84.5s -> 75.7s avg (10% faster)
>   git/git (~306 MB pack):  22.6s -> 20.0s avg (11% faster)

Wow! This is much higher than I expected. Great find.

I imagine that other platforms or non-FUSE setups will not
have the same benefits. As long as they aren't _regressions_
then this is a great find.

> -/* We always read in 4kB chunks. */
> -static unsigned char input_buffer[4096];
> +static unsigned char input_buffer[DEFAULT_PACKFILE_BUFFER_SIZE];

> -/* We always read in 4kB chunks. */
> -static unsigned char buffer[4096];
> +static unsigned char buffer[DEFAULT_PACKFILE_BUFFER_SIZE];

These changes are what I expected in v2.

> diff --git a/csum-file.c b/csum-file.c
> index 9558177a11..c1aeaf587a 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -178,7 +178,7 @@ struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
>  	f->algop = unsafe_hash_algo(algop);
>  	f->algop->init_fn(&f->ctx);
>  
> -	f->buffer_len = opts->buffer_len ? opts->buffer_len : 128 * 1024;
> +	f->buffer_len = opts->buffer_len ? opts->buffer_len : DEFAULT_PACKFILE_BUFFER_SIZE;
>  	f->buffer = xmalloc(f->buffer_len);
>  	f->check_buffer = NULL;

This one surprised me, as this hunk wasn't in your v1 patch.

I think using this replacement makes sense, since it _is_ an
exact value. It did make me think as to how we landed on 128K
for this example.

The previous line is due to a1118c0a446 (csum-file: introduce
`hashfd_ext()`, 2026-03-13), but it only moved the 128K default
from hashfd(). Notably, hashfd_throughput() still uses an 8K
setting in opt->buffer_len.

Hilariously, I went spelunking for the original reason for the
128K and it was 2ca245f8be5 (csum-file.h: increase hashfile
buffer size, 2021-05-18) written by...me. The motivation was
due to using the hashfile logic for the .git/index file which
also used 128K buffers in  f279894 (read-cache: make the index
write buffer size 128K, 2021-02-18).

All this is to say that we now have two constants of identical
value, where WRITE_BUFFER_SIZE in read-cache.c could be replaced
with your new DEFAULT_PACKFILE_BUFFER_SIZE.

This does make me think that maybe DEFAULT_PACKFILE_BUFFER_SIZE
is misnamed? Should it be DEFAULT_HASHFILE_BUFFER_SIZE or
DEFAULT_FILESYSTEM_BUFFER_SIZE to better fit this size value
being used in both packfiles and index files?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index ae1bdc90a4..a2f037811c 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -712,6 +712,12 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
>  # endif
>  #endif
>  
> +/*
> + * Default buffer size for buffered I/O in pack file operations (index-pack,
> + * unpack-objects) and the hashfile layer in csum-file.
> + */
> +#define DEFAULT_PACKFILE_BUFFER_SIZE (128 * 1024)
> +
I see. Putting this in git-compat-util.h makes the rest
of the changes good without any need to add a new include.

Thanks,
-Stolee
