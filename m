Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD196273F9
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765379437; cv=none; b=I0hpg57p3zGxxg7tErnZY0cSBg1Ydrg3lMe4OUlJh/NtPdVZsIwKZgsR6Qg1DugS/NaPPVx6kurXURa2s0WZBqUE9N7faLCWqv+KfPJaXWMvt9rItPiPjw/tuT8Uyvhi0K6K7pz5YTLKxbsQQX9G8JIDM4+tA8NmTIacrME+9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765379437; c=relaxed/simple;
	bh=3a4mFNnnZXoC9MMiPd4vGvoANwaNQvkmKqTSLBp+/Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUg4Iqmi87I7KF4neLe06vrKxBCcsq7Vb5PD7N0o7I3CXKphNmY63eH+96rST6/+WQiykkKrgc8Hvg4V0KaACZseK6gN8xJOXmL7RAwYC5cl2wXnE/jwLt20BixnXwUQeI/a4cHPKrdlQQ0ua6P9fvHMAAbBrE8SLKF9avR76Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFwo/iS3; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFwo/iS3"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4503ee5c160so3749891b6e.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 07:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765379435; x=1765984235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qppKUjU8LN8azzzs78e05FC66DyJHqgaszzH6vqJia4=;
        b=QFwo/iS3nk1lJmhI8V1cqmb4QKMob9wgeMowQpALZXKAKhqE5qRsozNc+Tc2eO+acI
         TpfmbeXyjiCT1tlSFzkaXdj8alKhcjlf31H5R0RoSUE1w5fgkSM3d+GR1U3GLPo+zU4d
         0XFD9mCDGwzQ2WbK584FJJXCmhDLUrLqrQyl5opq3Hhye/iC1y7YSs7B3Gb6UthJ9ZPq
         OO8pXFP1HnEsb48IICZ60uwatNUs7BB84Fj1S+Eb3xlDL3Y8MV/VJmdKjWltZB7n2a7p
         ArrHCrqVaMAZ5PP/FGqgLSDCeUlYJ9Gp48NLpU7iYzF0+mir/I5Wy5CQ9OpLQ0SAQD9F
         EVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765379435; x=1765984235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qppKUjU8LN8azzzs78e05FC66DyJHqgaszzH6vqJia4=;
        b=S8RYUS8jvbz/vm6qas66Zwy7Yd4U99WSt3ue9zh9VVGZfHKNm4ycxWdyT3yPGyHoYR
         KILK5dkYyHMpQNw+cnwOzAsmDiZ6XTkOVDPDGAb/iNDGRWnr9Rzj04KIgnlrRs/nXWWO
         JpjyDGuUQjMjilKjWssfI0OH10yVK9YufEWmojar5kRSxDCmwgt+bnjYW+Tjzq7aXS8k
         YP8VbtmkVDJk30POIwKs3fxH/EsEkww8AK5YYCZRV4yHhewvyTR9Q3K1eG9Ut3Fv9wEK
         U0qBhZ/S5VF6uH1nQ2fgDAli40t6KTWSUb4DVvFmEn5nLISHDcynSARAs5qSoVFJ1P9K
         ig9A==
X-Gm-Message-State: AOJu0YxCvR/nPcgsmu58Qds/nt3bbnD3nlIhAvs5CL9XngkTq8MqhpZs
	ADCFptyt2SInzFe0vs88nkONhRkilcEV4u241DTtJj7UCxuSbd/1rB+/MP0OyQ==
X-Gm-Gg: ASbGncv7hcnPYLMWlaUgNyVR0W1F7m8muBrkp+MidUrZErBHIP/QF4f9UdG3rGUqBfJ
	1T56EEWWu7jdilIK2kZcLbYHaNZ3XBLL0EZD6Jcr3SWgteOqViypKuuwgB/7SkBeMomPdRKRCpK
	EBt0k1yq9EAUlet+jP/jHbYdaIdXnvTRiO3juLqGKLY+YlaRC1VgLiB72yzhLdWXEoLVFukmqhO
	eigtIoYkDMffjGwz6OXUePrp4pxAg0JXW1EKPhlqpc5JnivkQJ/Pq+r4hri9xKDhied/wd2Fukb
	iZQC1gLTdzM6kZdRqvJ0EM6FMvkngXzFIX0+SJ1zroU/mpW4IIYEtoodoSgL9XLv2DgdsTn9D1L
	DkR3FmPxHnIAv0jhdQSDnzlgCAck6OUeum1hGEmzaEQuvPZViKoFzdiWQ1RbLm2GPBk6ewnJe+V
	TfKd6+
X-Google-Smtp-Source: AGHT+IG/26hnLqeyresh4xrPjqZavkQMn92prPltFAD8OrW4YuGQI1Fc9gN+LzL1OFUavM009mxwhg==
X-Received: by 2002:a05:6808:2443:b0:450:d6fe:898d with SMTP id 5614622812f47-455866d1b63mr1684697b6e.32.1765379434767;
        Wed, 10 Dec 2025 07:10:34 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4538011c67bsm9255515b6e.15.2025.12.10.07.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:10:34 -0800 (PST)
Date: Wed, 10 Dec 2025 09:10:29 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] builtin/repo: humanise count values in structure
 output
Message-ID: <kf7vavs5yetooe6u2ygttzfriul4u5ywdnhtyksh2pbar4mpfz@orlg7ppajd7s>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-3-jltobler@gmail.com>
 <aTkS_kBlNsnbPyP5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTkS_kBlNsnbPyP5@pks.im>

On 25/12/10 07:28AM, Patrick Steinhardt wrote:
> On Tue, Dec 09, 2025 at 04:58:16PM -0600, Justin Tobler wrote:
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index a69699857a..8fb728b3a5 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -266,6 +275,10 @@ static void stats_table_addf(struct stats_table *table, const char *format, ...)
> >  	va_end(ap);
> >  }
> >  
> > +static const char *unit_k = "k";
> > +static const char *unit_M = "M";
> > +static const char *unit_G = "G";
> > +
> >  static void stats_table_count_addf(struct stats_table *table, size_t value,
> >  				   const char *format, ...)
> >  {
> 
> I would assume that these units should be translatable.

Ya, you are right. I'll make units translatable in the next version.

> > @@ -273,7 +286,26 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
> >  	va_list ap;
> >  
> >  	CALLOC_ARRAY(entry, 1);
> > -	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> > +
> > +	if (value >= 1000000000) {
> > +		uintmax_t x = (uintmax_t)value + 5000000;
> > +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
> > +				       x / 1000000000,
> > +				       x % 1000000000 / 10000000);
> > +		entry->unit = unit_G;
> > +	} else if (value >= 1000000) {
> > +		uintmax_t x = (uintmax_t)value + 5000;
> > +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
> > +				       x / 1000000, x % 1000000 / 10000);
> > +		entry->unit = unit_M;
> > +	} else if (value >= 1000) {
> > +		uintmax_t x = (uintmax_t)value + 5;
> > +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
> > +				       x / 1000, x % 1000 / 10);
> > +		entry->unit = unit_k;
> > +	} else {
> > +		entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> > +	}
> >  
> >  	va_start(ap, format);
> >  	stats_table_vaddf(table, entry, format, ap);
> 
> These units are decimal-based (1000), whereas in "parse.c" we have
> `get_unit_factor()` that is binary-based (1024). Arguably, it's
> "parse.c" that is wrong because "k" is generally decimal-based whereas
> "Ki" would be binary-based.
> 
> Not quite sure what to do with this. For counts it _could_ be okay if we
> continue to use the wrong unit prefix. But as soon as we get to disk
> sizes we certainly should use the correct units, which would probably be
> KiB.

For count values, such as number of references/objects, I'm using SI
unit prefixes which I think is more correct. In a subsequent patch where
we start collect size information, I add a separate
`stats_table_size_addf()` function which uses the IEC unit prefixes.
This way we use the most appropriate option for both scenarios.

> > diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> > index 36a71a144e..55fd13ad1b 100755
> > --- a/t/t1901-repo-structure.sh
> > +++ b/t/t1901-repo-structure.sh
> > @@ -10,21 +10,21 @@ test_expect_success 'empty repository' '
> >  	(
> >  		cd repo &&
> >  		cat >expect <<-\EOF &&
> > -		| Repository structure | Value |
> > -		| -------------------- | ----- |
> > -		| * References         |       |
> > -		|   * Count            |     0 |
> > -		|     * Branches       |     0 |
> > -		|     * Tags           |     0 |
> > -		|     * Remotes        |     0 |
> > -		|     * Others         |     0 |
> > -		|                      |       |
> > -		| * Reachable objects  |       |
> > -		|   * Count            |     0 |
> > -		|     * Commits        |     0 |
> > -		|     * Trees          |     0 |
> > -		|     * Blobs          |     0 |
> > -		|     * Tags           |     0 |
> > +		| Repository structure | Value  |
> > +		| -------------------- | ------ |
> > +		| * References         |        |
> > +		|   * Count            |     0  |
> > +		|     * Branches       |     0  |
> > +		|     * Tags           |     0  |
> > +		|     * Remotes        |     0  |
> > +		|     * Others         |     0  |
> > +		|                      |        |
> > +		| * Reachable objects  |        |
> > +		|   * Count            |     0  |
> > +		|     * Commits        |     0  |
> > +		|     * Trees          |     0  |
> > +		|     * Blobs          |     0  |
> > +		|     * Tags           |     0  |
> >  		EOF
> >  
> >  		git repo structure >out 2>err &&
> 
> It's a bit weird that this test here changes even though we don't even
> use any units. But I don't mind it too much.

Ya, the added space comes from the fixed space character between the
value and unit columns. I didn't think it mattered too much, but I may
try to only conditionally add it if needed in the next version.

-Justin
