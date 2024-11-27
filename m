Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964001DFDE
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732670594; cv=none; b=hWSdV0X/Pm4wmDrRVx0i5KvM4nVaXK7Hf58Rl3JmqmVdPCGDaS6MbrcYUVAK6tmZ4mXABPwE7ZVkXYzIaEp4RVgkPjX8OJ3H1wizkojPq48tneJi4Qj4EfY7sksfUgD7dfc9bY2PPGU8ZUE4iwaGLF7qTvmDDR0smo5G/VumIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732670594; c=relaxed/simple;
	bh=yu49bfP8Iy1C6Nkzv3ViNLBsLugx2MuRLsUEsJch3x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3y0Hr5NCnmwvhTFv0DpQI46PwlCMIsRurya3M/fPtfb4SfbOKyChBclVerdZquySBMkdqYz3KGH4ntqZW1TopMYHcv1Aik1GOgtp0ytdn9dO+cFsL+VT1AQNZDtwxQwTGz5DQyu1ZTFQIVXoMKIJhqN65y3RoA1d+Jd0JpdQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwFym+Jp; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwFym+Jp"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f205c4625dso487513eaf.3
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 17:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732670591; x=1733275391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxzrlPPnmbWdDGNRE85cRYcUMXwC2bOILRWQLQZ2mgU=;
        b=mwFym+JpE8aXHZUuHXIcA9FIc1yykNTccg6OeGT+fZSSY1VbBhRPYIUYM+d2hk5En6
         9QtliFMnIQphsAmoEX7/EfbM9LC1yv5Z6lwh2MQU9JJzpdmxFxY2YSnwsiYdyVbGdjKr
         7Q/gGcMRCifEumcwbddJo30RrXjkOHuIwrle1N2AIZhzdf8uL4WJF2jN1BVhY4Yiit5h
         ZuUfuoOFc7mOIADxMjU0kBbFCnR0/NZc8vebZiWlqpYJZ2MWBawCLuuQaOZ4PbugnVoK
         IlE5/t10zyQ0ptKrwcPgebV9X4w86UUoIlOG/MDM2hm+AnaaiCGS3rTs6J7YKBV91BbC
         3mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732670591; x=1733275391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxzrlPPnmbWdDGNRE85cRYcUMXwC2bOILRWQLQZ2mgU=;
        b=d8Acx3ZxYXNtk0mKRfXstdUk9vDHH/12yDcOOW+LwI8k80yZiXb0KrzQQupIo9AhGJ
         42GaCF4+ymkgpHymAcDq8iVFIr0SLlJxK6eC6r3fsGyLIL57D11mkNTgzsFF5rffR7fa
         qSj8VVYcedAJGo8ODbzIIXJE09VhMlmxvk4kgcvLdINYB2PpbFil1JC1BnVfzu2OEnnm
         i5hSc3IAArhwZuxJEVVCRf/soGohxzzTfqizBXhDfmJgi9NRg+aCbVWE36gIcZVDoFdG
         71rGnSPQwj0+SYeESgPsAY0BpJ73eBn3j+MMbSwuWxjBcYFPeMkiHXZcBjH1YkYNS6Zi
         c3Rw==
X-Gm-Message-State: AOJu0Yxn/3XjMJW1Ih/3laOky1adYEjbXcTjHqMbfNSaK9BvwHoOAc3t
	4QthLjoNguwoRPb49rmH4syQ3Lz29cnffxgx51ZBdKTvFmA9FjFv3ajTVQ==
X-Gm-Gg: ASbGncsASzt1md13LdVMD3XwsS3Nh6fWVCneD4txfRpIomXuw5xdYitYt+U9ZmbsuFG
	1TeycLnnW1UkYo82kEcR3Q6hjePXZrF8rUhqVKzKtiBt84cj0+oro3Salznin0y5o+ONRKo5n1R
	Tlz9nMzR09MuMqFeQbdilWvSKWoGCrcW7o50qvE/VWfzf2aoFei8FT2KTmSJsRIT9D5WJQZXW3k
	kc5YzMxtohxX48XqXfZ2U5RB4sfqNACQIYJ218Axug=
X-Google-Smtp-Source: AGHT+IFHzJINqmBp8LbbopTGiRkAmct+lpXXxl3Pp5QCWcroa9Id6835DMyT7+b6f9ahnALWcxLN8w==
X-Received: by 2002:a05:6871:691:b0:297:250f:4199 with SMTP id 586e51a60fabf-29dc418cdfemr1102009fac.23.1732670591673;
        Tue, 26 Nov 2024 17:23:11 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0381d184sm3323904a34.55.2024.11.26.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:23:10 -0800 (PST)
Date: Tue, 26 Nov 2024 19:21:12 -0600
From: Justin Tobler <jltobler@gmail.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] fetch-pack: expose `fetch_pack_config_cb()`
Message-ID: <4f43efzkdocq4lohy2nkdebhdmlxt7adaui5h3pc4cvqb4gczu@mei2h3twif3z>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241121204119.1440773-5-jltobler@gmail.com>
 <Z0C1PxdltxDm8pyA@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0C1PxdltxDm8pyA@ArchLinux>

On 24/11/23 12:45AM, shejialuo wrote:
> On Thu, Nov 21, 2024 at 02:41:18PM -0600, Justin Tobler wrote:
> > During fetch-pack operations, git-index-pack(1) may be spawned and
> > perform fsck checks. The message severity of these checks is
> > configurable and propagated via appending it to the `--fsck-objects`
> > option.
> > 
> > With `fetch_pack_config_cb()`, fsck configuration gets populated to a
> > `fetch_pack_options`. Expose `fetch_pack_config_cb()`, to facilitate
> > formatted fsck message configuration generation. In a subsequent commit,
> > this is used to wire message configuration to `unbundle()` during bundle
> > fetches.
> > 
> 
> In my perspective, we may not separate [PATCH 4/5] and [PATCH 5/5].
> Should the reason why we want to expose `fetch_pack_config_cb` is that
> we need to propagate the fsck severity to `unbundle`? Without the
> information of the last patch, we cannot know any detail thing. So, they
> are highly relevant.

Thanks for the feedback. Due to other suggested changes, I've opted to
condense the third and fourth patch into one in the next version which I
think helps somewhat. I've also tried to update the commit messages to
provide additional context. Hopefully this helps :)

-Justin
