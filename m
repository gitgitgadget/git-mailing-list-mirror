Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348E3B42E4
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309288; cv=none; b=HuMxs1Yt1qPmVaFyj9cOeI6xala+YBqc7M08P+Znqfva3EHWq2jRfYUqe4Fc9xMBYSOjbSOo5nue0Ngl14RI6GScdozs5r7DjW1xy+IzzMi4tSVvshByRDwRACOZxm+NFEkxwSqbXZ8zy8oMpi+bmAU1mHfyN1uTNTZj5SaZNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309288; c=relaxed/simple;
	bh=aa1f0meL7P7TZI70lxHDWFfptKLbqVzE6gvR6/yZup0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQE4XZgFgKedAE4td9kxBiLYt249kLMuM5HR2hpxLLekHmQXUShCf2k4QJqyhSJmv0kzZXJrFoejJjUMmL8cP5iU8qnbxIA/Gp/FZX3eI+31Q+HoTYLfCfOY/wqcf+6C83mAFggIFxg1vvmYby0a0n7kOzBSe6ZHY+CoMjOIXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuW2FOq/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuW2FOq/"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ad4c229861so791983e87.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309286; x=1782914086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnqNptdvrMHpOPvzOnbVm9/ppksM7b0mzaLskg/wPpI=;
        b=KuW2FOq/TixtuWoZmGYRdnWR1VgQI7BfIlBqRnIOPL3ylHePs2bnA38maa6nFDXR4O
         12OnIuKNLfdc0tRznQNGtUF71/ww/V6zvBoQ2e+kbv4jTF/rG0Z3M7nO0QciptOcaVzV
         P9+V+TBfwr1JWr+jx32iyKsvBvGR9mSOD+pEpxL2HPoEhH7RthR99iskwgqA3Fc4sZfY
         /MnonE3vjO5Lqj5Y3OaE/yoPP82QXvN+u4DQBLlMtNnO+3I7rl7gim/SbSahZVF0SPXj
         p5iFTvLXBsGpAZBwRWuys+9zTwNGnB+xfk1ILMOTgKQ3YaoeHx3iuDwU0bDJySOWcJ//
         L/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309286; x=1782914086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnqNptdvrMHpOPvzOnbVm9/ppksM7b0mzaLskg/wPpI=;
        b=aTzQTjQtUzsDE38pQjK1MTTUFf7i6TuLREW933BT4/cFnaaT3mXQg6rA8oGuX6vWLE
         xVQNbE/IwpKisyvpraLkjZzVcvI2x9vw/UM6/3skOuLgA/qzb9vYOImfuLpoJcwiuJqt
         59src5H/bOpP7Anw24IxMBC9unniEVkE78DFT+qasm36TS+uVikiiiY4Bgtv65eJoLQH
         jn18yx7ruaiExM3DxDoJfe6paa7mG/xhGoObSFh4PE4tGbI5vfbqdnq7xY5hsr4gQZD/
         NStSJElwOWq46JJy8D4el59e7vUje7hhkU/eLIZQP/GZ3QO9dKoYPf5SQEdmJFrBev7g
         1VqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpThcAfjBfCQh6OUf6ZBaDssHbahXvpllYgto3aA0rZ45MmP8Sdkl6rChw0zeZXeC5nUFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSzJzmaiowTgESU0ogI8y5+4HcBq31cQrZULwhKYZQvIIJ0A2F
	acl4mQA1lR6refSeTvMX1NPh/m4GPfzW11uOhbilebDLQe8cGEie+srh
X-Gm-Gg: AfdE7cmMn1EYUjpXfD5fvBBYygl8we/hGWwVeRnZsFaYgnGYZTgFKl4dIkCD8Ed9BqM
	nyifknmXE0xGDe53gv0hSvzV0a5A6Rn+UOOtiQ4henPHwpZqhC6CUrdMQ4iwaPceMzX9Q5rYX7Y
	WEumIovN+5WBTUHnjuiO8WRSEV+80KSoRLVPkoTnBdaqUXPJhsxCOUTxTwY3FxNeGoQdOXulmym
	I1+Sd8RivgrC9sHtlJGlRPol9+m+v2u+JLfr0tAzx0y8P/sZJ4s5KCKrnB44+10U8hwv45rBX3n
	5XlixudDIKLYsdhuG5zKYOYZSZt+SYKKbivuze7IDx89emM0arfiR+QbdDz2v/rl0F8y7EYjU9D
	6fhsH4ZC/b+6f6N3uklapQwgaVbJJeGRIOnpdNiwdV6OnVnSW0ADafYMhOB0W9Svlf8l7vHYlzK
	Gd/1uHYHzPfMd0HpsJebuqR3ZbKj1GBq2bTXiCAhjv1hWV5EnmlBBuMGUYZg==
X-Received: by 2002:a05:6512:a341:b0:5aa:6f0e:8404 with SMTP id 2adb3069b0e04-5ae9d55e5a0mr709701e87.21.1782309285181;
        Wed, 24 Jun 2026 06:54:45 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a268sm1794258e87.38.2026.06.24.06.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 06:54:44 -0700 (PDT)
Message-ID: <19639ad3-2d16-4f3b-be79-138e00144ea3@gmail.com>
Date: Wed, 24 Jun 2026 09:54:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] commit-reach: introduce struct paint_state with
 per-side counters
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <f24edd45f0af1da64513164d5d720fe70c1decff.1782303254.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <f24edd45f0af1da64513164d5d720fe70c1decff.1782303254.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/2026 8:14 AM, Kristofer Karlsson via GitGitGadget wrote:
>  Termination
>  -----------
>  
> -The walk uses a `nonstale_queue` wrapper around `prio_queue` that
> -tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
> -so far. Once that commit is dequeued, every remaining entry is known
> -to be STALE and the loop terminates. Specifically, the main loop
> +The walk tracks the number of commits of each type in the queue
> +(PARENT1-only, PARENT2-only, pending merge-base). The main loop
>  ends when one of the following conditions holds:
>  
>    1. The queue is empty.
> -  2. `max_nonstale` has been dequeued, meaning the queue only contains
> -     STALE entries.
> +  2. The queue contains only stale entries.

I'm grateful to see these changes happening to the doc in real-
time. I know it was extra work, but I'm grateful right now.

Hopefully future historians will also benefit from this effort.

> +static void paint_count_update(struct paint_state *state,
> +			       unsigned flags, int delta)
> +{
> +	switch (flags & (PARENT1 | PARENT2 | STALE)) {
> +	case PARENT1:
> +		state->p1_count += delta;
> +		break;
> +
> +	case PARENT2:
> +		state->p2_count += delta;
> +		break;
> +
> +	case PARENT1 | PARENT2:
> +		state->pending_merge_bases += delta;
> +		break;
> +
> +	case PARENT1 | PARENT2 | STALE:
> +		break;
> +
> +	default:
> +		BUG("unexpected paint state");
> +	}
> +}

I like the use of 'delta' to allow reuse of this switch.

> +
> +static void paint_queue_put(struct paint_state *state,
> +			    struct commit *c, unsigned add_flags)
> +{
> +	unsigned old_flags = c->object.flags;
> +	c->object.flags |= add_flags;
> +
> +	if (old_flags & ENQUEUED) {
> +		paint_count_update(state, old_flags, -1);
> +		paint_count_update(state, c->object.flags, 1);
> +	} else {
> +		c->object.flags |= ENQUEUED;
> +		prio_queue_put(&state->queue, c);
> +		paint_count_update(state, c->object.flags, 1);
> +	}
> +}

ok: if we are already in the queue then we have old flags and
may need to subtract their values because they were counted
already. Otherwise, we need to queue it for the first time and
only add the values. Makes sense.

> +
> +static struct commit *paint_queue_get(struct paint_state *state)
> +{

Since we are going to make this a more complete termination
condition, we may want to make that very explicit with a doc-
comment. Something along the lines of "dequeue a commit when
possible, but also signal termination of the walk when we
conclude that no more merge bases will be discovered due to
internal state."

> @@ -187,12 +253,11 @@ static int paint_down_to_common(struct repository *r,
>  				return error(_("could not parse commit %s"),
>  					     oid_to_hex(&p->object.oid));
>  			}
> -			p->object.flags |= flags;
> -			nonstale_queue_put_dedup(&queue, p);
> +			paint_queue_put(&state, p, flags);

I like how this simplifies the flag-assignment logic somewhat.

You mentioned in your cover letter how the min_generation value
can add extra termination conditions. It may be a good idea to
insert min_generation into the paint_queue struct and make it a
termination condition for paint_queue_get(). If you consider this
direction, then I'd make it a separate patch on top of this one
_before_ adding the one-sided change. The extra tests that cover
the exact number of walked commits can help to guarantee the same
behavior, assuming that some of those tests check a non-zero
min_generation input. (It may be good to add such trace tests in
an earlier patch to help confidence in this case.)

Thanks,
-Stolee
