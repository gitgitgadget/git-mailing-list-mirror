Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940C158203
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565214; cv=none; b=lq0fdU0hny9oJKVEfi6rQ0rxsKHPxlIRlmvJT0dqxxzlEZKUSA1GTdRPTOgYytKhh8IxxFcedCAwOenQ995AKLgq73Z8Od0Rmwzcf6VjSjXi/l8Xi6KRYX/scwiQoeEN+ZhLVqQHjBCda/nh1Md3mWE/qoAsxw3Be72WjcEqEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565214; c=relaxed/simple;
	bh=R4aD0GPhmHGDzbRH1xOf30LByCEQWE2rM9aXDTxO84U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWKevZ/QOOL3kIh8v6Nsmc8BUVJdD6ueTVPb7cO8CnO3L8vYzu37N+5Ajbr4YLkqPleOEhZYCeXnpY4JgTbW+PzqxskRykH0igMhTqa2HEUaN/DF5cHTWAu825EcUtHJE7iEbJKroKBmWStSeyDKGLb6q4AWVWvFUTVa8HPxRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R3ZLOjvi; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R3ZLOjvi"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82cd93a6617so173920139f.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726565212; x=1727170012; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0dhuVY0EZlPOK3soERDZVuskbpFfmpbIQgeQ5R0RN88=;
        b=R3ZLOjvi9YEsxSMibeLnt6YAZ6QiNKURtr4Tqgn7ajKwxyT/tODpU1L1Gg9ik2YmTa
         z1VwkyN8pN/ARRyJvuKCw9uzJPMXXD1uH8gMjogqpKcAjFXbfo14Hzxo61c0yKEcjs/R
         mIB2OIOGVmotOW87dXz6U5SDMZfkBufASTS5Vftc7Mj7anFkCWh9CTr/mcC0GwSUKm6P
         NU945hHnH7gKqeuqGVM18HOP5+8/J1dyLDtQYtSZ5z5kFrLgktIz125HOJ4YpvhuWKsp
         ydJNqj6I0OYPT8WHdLushRDsCBh59vUrmfjn+TYXvhQNxlPm0cJTs1MhyT5qOx8tXkXx
         zWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726565212; x=1727170012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dhuVY0EZlPOK3soERDZVuskbpFfmpbIQgeQ5R0RN88=;
        b=Wjria3X/hRJAv/X8mg8DASEMoVu49C+2YjNUBxGuHroL5i+69Wg4x0RoThnErGY8zU
         K4mfHetGbeWVY6A0ipTb5vq4wnYU4AJTxbF9u6K3RAjK6HXRrFz9zQ3G3rV9zszbn/mE
         t5/8dq3JKVNWGQpHrUXMAwQgABq6UXmaxwhwdHhMilfEQl2p+F4J2GMD+MnpEzmqMi5x
         ZAhv0npWZAyba4jBEVbaMdkJUg24Sx73XOWdWXgf1eqxMwBuz3rjwGd3EQ8Hur526wsx
         o4U6jrnj7g4VN/i1Gg02pugJ+OMRExyTEFxVUu4hbKLzHGI8nOc1uEr4994rU++4F6PT
         N0LA==
X-Gm-Message-State: AOJu0YxJyKZ2yE7M5UDr36uTKBO+1ZEL1jMUU3z7gclyGdso6cQjkYC2
	njILLL2x74BCohLtxOdQJampEjF5Ssu+pRx1v+4pvIlP7R2v9cL+bIWjihPbBluUCv8jPePMpsU
	Qbk1DIw==
X-Google-Smtp-Source: AGHT+IHMJ9u0XIi1ZW/IaNrC/ljok6hEVRpAN4hsmywIptqcb/nCxKwmm7W4ss82SyUMkmCSN7kIOw==
X-Received: by 2002:a05:6e02:1383:b0:39f:5abe:ec25 with SMTP id e9e14a558f8ab-3a08495478amr160183995ab.19.1726565212113;
        Tue, 17 Sep 2024 02:26:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf4569sm1898368173.19.2024.09.17.02.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:26:51 -0700 (PDT)
Date: Tue, 17 Sep 2024 05:26:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 6/6] refs/reftable: wire up support for exclude
 patterns
Message-ID: <ZulLWJWLgU7gL1MK@nand.local>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
 <050f4906393d1f9c58a6b6bc695b004695d219be.1726476401.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <050f4906393d1f9c58a6b6bc695b004695d219be.1726476401.git.ps@pks.im>

On Mon, Sep 16, 2024 at 10:50:16AM +0200, Patrick Steinhardt wrote:
> This makes t1419 work with the "reftable" backend with some slight
> modifications. Of course it also speeds up listing of references with
> hidden refs. The following benchmark prints one reference with 1 million
> hidden references:
>
>     Benchmark 1: HEAD~
>       Time (mean ± σ):      93.3 ms ±   2.1 ms    [User: 90.3 ms, System: 2.5 ms]
>       Range (min … max):    89.8 ms …  97.2 ms    33 runs
>
>     Benchmark 2: HEAD
>       Time (mean ± σ):       4.2 ms ±   0.6 ms    [User: 2.2 ms, System: 1.8 ms]
>       Range (min … max):     3.1 ms …   8.1 ms    765 runs
>
>     Summary
>       HEAD ran
>        22.15 ± 3.19 times faster than HEAD~

Very nice.

> +		/*
> +		 * When the reference name is lexicographically bigger than the
> +		 * current exclude pattern we know that it won't ever match any
> +		 * of the following references, either. We thus advance to the
> +		 * next pattern and re-check whether it matches.
> +		 *
> +		 * Otherwise, if it's smaller, then we do not have a match and
> +		 * thus want to show the current reference.
> +		 */
> +		cmp = strncmp(iter->ref.refname, pattern,
> +			      iter->exclude_patterns_strlen);
> +		if (cmp > 0) {
> +			iter->exclude_patterns_index++;
> +			iter->exclude_patterns_strlen = 0;
> +			continue;
> +		}
> +		if (cmp < 0)
> +			return 0;

Perhaps I am showing my ignorance for the reftable backend, but is it OK
to call strncmp() against all patterns here?

In the packed-refs implementation which I worked on with Peff sometime
last year, we rejected exclude patterns that contain special glob
characters in them for exactly this reason.

The implementation that I'm referring to has a helpful comment that
jogged my memory for what we were thinking at the time (see the
function refs/packed-backend.c::populate_excluded_jump_list()).

Ugh, I just read the next hunk below, so ignore me here ;-).

> +static char **filter_exclude_patterns(const char **exclude_patterns)
> +{
> +	size_t filtered_size = 0, filtered_alloc = 0;
> +	char **filtered = NULL;
> +
> +	if (!exclude_patterns)
> +		return NULL;
> +
> +	for (size_t i = 0; ; i++) {
> +		const char *exclude_pattern = exclude_patterns[i];
> +		int has_glob = 0;
> +
> +		if (!exclude_pattern)
> +			break;
> +
> +		for (const char *p = exclude_pattern; *p; p++) {
> +			has_glob = is_glob_special(*p);
> +			if (has_glob)
> +				break;
> +		}
> +		if (has_glob)
> +			continue;
> +
> +		ALLOC_GROW(filtered, filtered_size + 1, filtered_alloc);
> +		filtered[filtered_size++] = xstrdup(exclude_pattern);
> +	}
> +
> +	if (filtered_size) {
> +		QSORT(filtered, filtered_size, qsort_strcmp);
> +		ALLOC_GROW(filtered, filtered_size + 1, filtered_alloc);
> +		filtered[filtered_size++] = NULL;
> +	}
> +
> +	return filtered;
> +}

Ohhh, here's where we filter out un-excludeable patterns. Ignore me :-).

One question I had reading this is why we don't filter these out on the
fly in the iterator itself instead of allocating a separate array that
we have to xstrdup() into and free later on.

We may be at the point of diminishing returns here, but I wonder if
allocating this thing is more expensive than a few redundant strcmp()s
and calls to is_glob_special(). I dunno.

Thanks,
Taylor
