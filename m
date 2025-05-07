Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B102B9BC
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580479; cv=none; b=oDRFDa6u1KFM0StbV0xtKnuucfFT+hAPc1q3ejJ4Oy2/DrATmZHudcNbPH1wRl3RM2qmOAxPQDbpoVEK3aDAa1ltHK1M24M19WahDDRmQJlv/oaH8OpgcSVaQTMc5kJ1zQbXS0wT7vOX8sNVnTBwEUPd/8j56xv7tmPJqCfJ6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580479; c=relaxed/simple;
	bh=vdk7yWb79sgD1A5k1jGSXCh3c0Z3E2VzBbdmXlGPoTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbiufZ18AtGitEgNU2jP+qpGnGnFPKOGfG/q20PnjbGna/DA8Ke8+nKHrNtaE2HQWD0veub5+q2Kw7/aFgHFxOfcblzrX9LfYJmr6Y+/+bKekO29vIjJe+JWhhMCzXhqt+qUd8Pt0MjGW/3XFuqJrn3BZ4E0C6whOyD7ouHudlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rLSz6EuQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rLSz6EuQ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5b8d13f73so775981185a.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746580475; x=1747185275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJnjWfx/ST05i7eGBdvwch/aTV1qM6M9SzaAZ10vxyA=;
        b=rLSz6EuQBFCe7Pi0aRYhzFd3HIkwJlqPwNKegh9ikb9pLKTnxm1j/JDnMlZvxmdseS
         XSKOUiD8+ygi/OPnNQhivvf3+3bHN+0yOOaDgbs5F282Zmlre+8pJa9GGemm51jvB2aW
         6z48CzjNPsp4rmfvWfByVUd1761qEfavao6rUFY0lK4dIBzJjJ9Sm55D4heXBdGOycNj
         iIefGo94U9i9raOiYQS6febcPNw1SMQw0KAf1n7EwtyP4s3zM29gJHeoOHuJEKFeXj2j
         nnHYnCPwC1z34SlyHO6lEVHkhwcK8lYOjxR6t72a1e1+GxG1MqEmTtk1CLVV2BBE3NRJ
         /cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746580475; x=1747185275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJnjWfx/ST05i7eGBdvwch/aTV1qM6M9SzaAZ10vxyA=;
        b=RDnbMU+ASuopHmDIVUYs1wdWqlG4HzCuZJMs0NcMueFAingQakIdu5aUVfvOHZLHfY
         OEpPBrKJ5NH9kgg0F5x+Y85cFFbSke6e5+gXnMreogufpnosYFl2AEbnCfsHKNpzO1iG
         ORgilErg9GvZiteHda2pRfsfwhz9q9YIE5F5VxuqETON3P4052I3MnH/6/QOXrrux35G
         zANJv26E/P8m6QM/ONrBb69DvaZl8m9NSQMrApDasGyu9s5kDSiraS0aAhShZXZ5nUbC
         hQ4nDpfrabBBUZaXj92z8w15Abu7jeqWs0cYuxgd7ysJf7MowkhNS8AIujAGFmMNTZbw
         3FuQ==
X-Gm-Message-State: AOJu0Yxn87HboQmG9DHasS7AZaOU7fViP0qmUrVmxrybid0I3DZ6XmmK
	Y8qxnnSb4G4Mbtp5I/SXZfJvB3ZFY7mLPOMygC8Di5dXUqNTHLnYYxB+2eQAc4s=
X-Gm-Gg: ASbGncuJhW6kKzblb3HJFywZol2lE2efRovGjhRZ1OezOurI29CXaTqaAcQoC+YN4e0
	I0lR10HmUFwUo3jMIanwe477eYhNeS07sD6UstYryJNW4XJ+GEmXlB3ycMbz7WU9uSEAptzgE21
	69YgGGlTIpbZ9lYpzdjZjgk5IQm0TqdPOby7Bw61112S8eg0l4sgzpe4M7SuX6bOtjwzXmuOOjh
	vdkgGTjl/eGpVAjJisT3PCMCCkosmIdeDUz170Ma/++3936rziBL2QtDbvTxl6irAp97X+Q5mRB
	XS/03LP93aLLyF1a/PvbjuY6FIGe1/hzGPo/Gpg7oBeZr/C/6LJOjNxF4Fw7CqcdFdmaepWkdfA
	bSiv2Wy8wDMBs
X-Google-Smtp-Source: AGHT+IG4rGKz2kAoDNrQ3txqlzaiV/3GlmvOMXkojeSSoc+ZGKq9pr91flWPsn3vYojEpjIuL4UcSA==
X-Received: by 2002:a05:620a:2a0a:b0:7ca:ea9a:31b8 with SMTP id af79cd13be357-7caf741d81bmr249316785a.53.1746580474980;
        Tue, 06 May 2025 18:14:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf75b87casm60873985a.74.2025.05.06.18.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 18:14:34 -0700 (PDT)
Date: Tue, 6 May 2025 21:14:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 10/13] pack-objects: refactor path-walk delta phase
Message-ID: <aBqz+VfSvecJdWHw@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <622439d78557d94da899d21444920c27768d3c67.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <622439d78557d94da899d21444920c27768d3c67.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:46PM +0000, Derrick Stolee via GitGitGadget wrote:
> The current implementation is not integrated with threads, but could be
> done in a future update.

I think that "in a future update" may be worth replacing with "the
following commit", as the former suggests (to me) that it may be perused
outside of this series.

> Since we do not attempt to sort objects by size until after exploring
> all trees, we can remove the previous change to t5530 due to a different
> error message appearing first.

Makes sense.

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/pack-objects.c       | 82 +++++++++++++++++++++++++-----------
>  pack-objects.h               | 12 ++++++
>  t/t5300-pack-object.sh       |  8 +++-
>  t/t5530-upload-pack-error.sh |  6 ---
>  4 files changed, 75 insertions(+), 33 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 0ea85754c52..d4e05ca4434 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3236,6 +3236,51 @@ static int should_attempt_deltas(struct object_entry *entry)
>  	return 1;
>  }
>
> +static void find_deltas_for_region(struct object_entry *list,
> +				   struct packing_region *region,
> +				   unsigned int *processed)
> +{
> +	struct object_entry **delta_list;
> +	uint32_t delta_list_nr = 0;
> +
> +	ALLOC_ARRAY(delta_list, region->nr);
> +	for (uint32_t i = 0; i < region->nr; i++) {

I know that these values are all unsigned, and very unlikely to get near
the 32-bit maximum, but I do think we should use size_t here (and
likewise when dealing with values that deal with how many entries in a
list we've allocated and indexes into that list).

> +		struct object_entry *entry = list + region->start + i;
> +		if (should_attempt_deltas(entry))
> +			delta_list[delta_list_nr++] = entry;
> +	}
> +
> +	QSORT(delta_list, delta_list_nr, type_size_sort);
> +	find_deltas(delta_list, &delta_list_nr, window, depth, processed);
> +	free(delta_list);
> +}

The rest of this function (modulo the inline comment removal, which I
wrote about below) appear to be a straightforward copy of the previous
home of this function.

> +static void find_deltas_by_region(struct object_entry *list,
> +				  struct packing_region *regions,
> +				  uint32_t start, uint32_t nr)

I imagine that "start" here is setup for the following commit which will
parallelize this task across multiple threads, with each thread starting
at a different position.

I wonder if (as an alternative) we could get away with passing in a
(struct packing_region *, size_t) pair and drop "start". I think this
can work if you pass in the result of adding whatever the value of
"start" would be to to_pack.regions here.

That somewhat hides the fact that this code is meant to be run across
multiple threads, but in a way that I think is worth doing. It lets the
function avoid having to do things like:

  for (size_t i = start; i < start + nr; i++)

and instead do the simpler:

  for (size_t i = 0; i < nr; i++)

since the caller already adjusted the regions pointer for us. As a
side-effect, it also means that the call below in prepare_pack() can
avoid passing a literal zero.

> +{
> +	unsigned int processed = 0;
> +	uint32_t progress_nr;

This uses a mix of uint32_t and unsigned int types. Should these all be
the same (and/or size_t's)?

> -	/*
> -	 * Find delta bases among this list of objects that all match the same
> -	 * path. This causes the delta compression to be interleaved in the
> -	 * object walk, which can lead to confusing progress indicators. This is
> -	 * also incompatible with threaded delta calculations. In the future,
> -	 * consider creating a list of regions in the full to_pack.objects array
> -	 * that could be picked up by the threaded delta computation.
> -	 */

Nice, it is very satisfying to see this comment go away ;-).

> -	if (sub_list_size && window) {
> -		QSORT(delta_list, sub_list_size, type_size_sort);
> -		find_deltas(delta_list, &sub_list_size, window, depth, processed);
> -	}
> +	*processed += oids->nr;
> +	display_progress(progress_state, *processed);
>
> -	free(delta_list);
>  	return 0;
>  }
>
> diff --git a/pack-objects.h b/pack-objects.h
> index d73e3843c92..7ba9f3448fe 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -119,11 +119,23 @@ struct object_entry {
>  	unsigned ext_base:1; /* delta_idx points outside packlist */
>  };
>
> +/**

This is an extreme nitpick, but I think that "/**" (as opposed to "/*")
is preferred, as the former is used for Doxygen-style comments. I feel
like I have seen Junio comment on this before, but searching 'f:Junio
"/**"' yields a measly 83,000+ results, so I am unlikely to find it ;-).

(Not worth rerolling on its own, but if you are rerolling anyway, which
is what I gathered from some of your earlier replies, it may be worth
picking up along the way.)

> + * A packing region is a section of the packing_data.objects array
> + * as given by a starting index and a number of elements.
> + */
> +struct packing_region {
> +	uint32_t start;
> +	uint32_t nr;
> +};

Same note here about the uint32_t versus size_t.
> +
>  struct packing_data {
>  	struct repository *repo;
>  	struct object_entry *objects;
>  	uint32_t nr_objects, nr_alloc;
>
> +	struct packing_region *regions;
> +	uint64_t nr_regions, nr_regions_alloc;

Ditto, but this one jumps to uint64_t. What differentiates these two?

Thanks,
Taylor
