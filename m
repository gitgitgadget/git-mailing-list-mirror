Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794820060;
	b=ewfySrxLnvq3N4IgE4hWcSC60fncA+WbKZ5dvwk60uqPqltqHJMqPtLn9EvThgrXyoAZ
	 WB1m0g/K8QxJ7hfpwYWIaOjN/bFvpjuBU7jGyruO8KjdPkIMrlF146h62DY5kEXIEo3WI
	 HVG0yBVv0Js8LFdL5IRZ4aOeVXMXbMeOPf7y/aFJDwNzHBHUrx42/vvRQ6VY3vYEyMNKI
	 UxZYC9VK4wQqnjjtZDBU8qvrB9BRRJRjpMRWox1vxwbK4TrcHi1T06rK9xRkfqh2bUmDM
	 gNA/xj4FAL60LMIk1FWP41u+4jHslzn49O76TmdA33ExoBAIDHRNG935ZP2OOuLxwwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/S60JJMVQ4sJW1NA4ESkYFPya3IbNuaE2ccD3lfr+NU=;
	b=23+Dz596c+5+qxkwsQiN8hkB9tP9TatVWum4LfJQFIJCulJAhEP+wT7MEEowrhLpf9+Q
	 sVjLmezB+2rlzqf4xW1ehb08SymiYriML6q5VedahXiXBHhIP6KCrwtc1CTMZJwjOSmJg
	 kCK5ptqfKar7u4Jjx+73wvHab1lL6brxditPY7PzCDLTk5FG5E0PfyZAEyBTVbpjlBr6f
	 3n60gZpt3DfH5bASe9GR7Lf5KIKLhIwc6wXNoCBqcNs8Fc5jLtRq7AnPSAnlMcQzYxIlB
	 DwzL0BYOno2ix+DmC0EWB9Atm1hu3Efo9iQUGdVR26Ocvo6pI0gEl1s5gPltnq3smmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b="HFThOQ/+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D70606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 09:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5D70606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=HFThOQ/+
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67db763cec7so630269d50.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 01:07:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794820059; cv=none;
        d=google.com; s=arc-20260327;
        b=HfPFYXCwUoDC7rP98a2MtUFKUbdg4PZruAtY/KDeSrzxQq1HqnJkyP6BVqglnma8rO
         vnTPAw+2CscJB/S2FtFXKTsQr2D/AMWdcnfxqJRWzbfft3F8BlJkAweLAjGXNE/0mTFF
         yqmCyK+QKYb63cdxoBieEtp4dgzOUNZisOLH19jN7AaUMZz7fnxMnMPH4txLuGTL7Sak
         4mEz48xuBSUgSbgQS+UBLxHjk3AJ3yqjd+58yN6uITt02NBNt/7NL7jl9XgLkkXCb6f0
         N3BV5otGGSK+WSkQulrp73npGJbtttkthyOdCb8AIWim5mncLMyN77bZbcBQ1Xq2ff4C
         TBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/S60JJMVQ4sJW1NA4ESkYFPya3IbNuaE2ccD3lfr+NU=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=JGZMZKzzGUcMtOsSSumDj4wYE9k2sWd1WC0bKHDGcU1sTcuCanqZ94Duh29fLUycF2
         tWrxFD9xhX/cWsHb8Ie3jsR0gHXsuxu6s5ZiiBh0CLMR/b6NBXLC099WzN+X1xY3Levr
         qTVvoErpwbgT32GfVZuLYvafMrpyO+kQaM1nIfdOKuMzBdjQYF/zisXwWniBJIIFS7e2
         g18voen5oqqsK1uLwrMyTjoYGD+ZDy6NvoaZ7HoBWZ+TZv0g4DZZoJceUy5EjCdrBRhj
         kPQK8pJe0lbMzSQzawR36m1buTWHIg53WDeuyOPRNV0Mvgc4+8nRErjS1hVkb8pgmIH1
         rqBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794820059; x=1795424859; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/S60JJMVQ4sJW1NA4ESkYFPya3IbNuaE2ccD3lfr+NU=;
        b=HFThOQ/+KD1R94HYUHBjnJfhRRpCFwkhhhkeXE5EL4X/sPBtfOIVqlx7Gf4EI7q1xI
         nLJamvT0/tuLDo+eHXoimErWucHR4XTS+Jj4DmXEGfWl9pzsafHPkCgYnN2hxSuakuSH
         EF1kcR/vycjm2IVjEJlk/sFzPN+Z4WBz87stQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794820059; x=1795424859;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/S60JJMVQ4sJW1NA4ESkYFPya3IbNuaE2ccD3lfr+NU=;
        b=MScgQjqDBOCLS5eFwG2eLYnPCFu/boWx/SVwQThcPXOasbYJiO55QAwcF4JDJmlHnU
         YvcYA4I8D6hpKY7dwnKcpovDwU3U9Y/pr3Ndw2oQ7eMHfRU+u6OsBG90OkAK3eSu4cK9
         gZecncnOToxyjvHfh54HxBxXZ2cZtDn5feguqcXQjKXbQHvCucJ0iHx/nRtZ8+c62ypu
         YHLT9beJNaQIARAtBD9K7uNmdmXzpwIkxtnNKlk+RWwQfdqQYAVKD6uXFN5iM86WQZFL
         /9V6zbf5JldWbvaHZq1XKrjArB7yoQn1MzfkdHymqfQWLT8X5NCfPQtUoNt7N1ktNRSk
         q0lQ==
X-Gm-Message-State: APuU4Z+AKREaQuUdLT8m5h6SboKh9N8LM389weFB6+TbCR5sRcVfEZI6
	4KCforXe1Y7nGMP+FJHHkSK6NVv/ddLRdR+WDrK58NU2enVnmLEa7FhHwtVDdNAJRrAGhalT6jQ
	qqEbUe+YA5pZDXwZu/oWcXaAjYdYoY8vola/h0/yj5nSmlo+yW/r48FcwvQ==
X-Gm-Gg: AZFdTZfOZbIQwkZzpgBUJavRURXHXre8ddpuu6CzJby+lFyotnEDUlQuIkq0fPj6Py7
	82V1ZR9UB6P/TgVVGA0wrGGGGXfd5z1h8mvinMkIjPpKg9YmjuRJZ6Kh9f0oNHPD/z+EwgyDhoT
	i24YL7Wyf5K07bwzz76yop2rG+WQ8oy8ngUBPLGYQFzz/qh3YMUAARKZhCevK2tzpwJNjcKb8+i
	KZ7mmz5UMOMORJqutkxq2Y1azl0MxTsbk1MFLVdBtwVNJlFj8n4rhRD+YJFNctAz2w7SMKh5lwf
	rlks9+hQFTEAZ2ENuMWmnmZ9eV2ENTKEsgire8F3QgKvQhryHHg9mV1VtYK4fw1h4Xq7ZKegK1A
	oYZ2hcdsP9J145+Zzs7T39/vrxWXQ4tr0MN2VPw==
X-Received: by 2002:a05:690e:4085:b0:67d:a511:5e71 with SMTP id
 956f58d0204a3-67da5116ad6mr2309380d50.150.1794820058531; Mon, 16 Nov 2026
 01:07:38 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im> <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
In-Reply-To: <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 16 Nov 2026 10:07:27 +0100
X-Gm-Features: AclHuK8ktnmyEUIQpVOAQwhSbVG9WbZ-dHdjySzzUJYfleuqor68-rVp4sTd1XY
Message-ID: <CAL71e4OcVOS4LPeNmLmF-92PMB_NC5NNZieAdGB15g4Yr7n01g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] builtin/repo: improve counting of objects
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 09:01, Patrick Steinhardt <ps@pks.im> wrote:
>
> Range-diff versus v1:
>
> 1:  a7a1c1a8041 ! 1:  2780e491ead builtin/repo: only parse objects as needed
>     @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
>                 case OBJ_COMMIT:
>      -                  commit = object_as_type(obj, OBJ_COMMIT, 0);
>      +                  /*
>     -+                   * Commits have already been parsed by the revision
>     -+                   * walk, so there is no need to read their contents
>     -+                   * again.
>     ++                   * Commits should already have been parsed by the
>     ++                   * revision walk, so in theory we do not need to read
>     ++                   * their contents again.
>      +                   */
>      +                  commit = lookup_commit(data->odb->repo, &oids->oid[i]);
>      +                  if (!commit || repo_parse_commit(data->odb->repo, commit))

I think this range-diff addresses my only nit, so I am happy
with this version!

Thanks,
Kristofer
