Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485A2BAF4
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380111; cv=none; b=Ha623qEmld9w4Zs8HiDUQ4CjD3gG8yFjfhL33tj1T0XqT8BlTv6MbnNucobafmXbSeqgnzSGgPYCKjluNwdwYuE+IhWsxoLVYGavqBF1l+DF4PWRf5RYtVMEHYBGSpXfDqZFguZIAv6AKmeh4lhG8k/+hYwDiWmZR91TfrMbdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380111; c=relaxed/simple;
	bh=f0LyaP8P3kVmCzq8sx6ax/76R9IWMjgSnC8Hr4uD8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHrwi6HVP3sN8j1hg/SDlm835v8KS+IPgt4HTw+sN8bQS05FD0DoVpwgVKccatNEuDxjB/7GBwzcFHDGNvAUSWLLNliWnf3y7KZajIYJHIFY2x3uDHv1T/bPtGo5vEcC7QGdp/1gNvMUZLGOJBY5V9hzShUAwxANoiXUQb6daD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRZgeWmH; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRZgeWmH"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3f5c9275b31so284991fac.0
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 07:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765380107; x=1765984907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4knHrW+vDy0hmfKCRza3NrbM9H+px1UQRoEWvBKlNu8=;
        b=mRZgeWmHWJ4Immek4uxuxeuYo+v8/k20jOjPJbTuQmUNg7lluXhOOPiqIyuoOf5pF4
         pOYyM7TtwmsM0g3UIzTqPSOqmV+2zlMNU4SnYiPvRMr5urnzZmKLCZ2KRuH8e/UmXpko
         KMji09bZDWb1RC2sMC+3ciI7hGOiegTJE8OB/P+F03JT7H8uXaH6PTeYqbNzUBSRVcMo
         TwC74G2iEyWLTCFaKEkLCKm8ym/Zsp+1QEo+u1nu55GplSK3xmSNzp2my1ypGYLVMQNR
         ffbVxEBoqlTY2VeMl5DMaG3GixCQy5cCnrEIIn1LzkjIJkms7NL+KXD0rM51p81ipGZH
         1fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765380107; x=1765984907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4knHrW+vDy0hmfKCRza3NrbM9H+px1UQRoEWvBKlNu8=;
        b=OudjAI3IySqHb4JzUPr91wgZqhcGBMD0lt1VnmslHoFTdNcSkzTIGZUYIgHQK7Q0i6
         kXcTS8ERER8+V5MivmkmIFd7+Ex8QcWgPL8qxPcDNSwjn9triGJy7anIZhVf4MMwiOxs
         p0FXOoTR12H0+UogBFYFsdneIqnVLQ2Ik/Ef401YKDk9YHAAgLmoQ3/icH9VZ5aPmsNo
         v0tEYUxNd1F4TO3qftqrEqrUWe8stuZT1G8LAnTGbgW0SkVuD3JetxX0wlMc+GB9Ar+z
         cwmihQPWqnxYubFG22bo1f/PvLxngaWTo8HZvDtIJpCwv5hSAHIeFIm6D9d4pIx5beeC
         +f/A==
X-Gm-Message-State: AOJu0YyITtPR4jjs19x/B0dQWmcG0GbnM0DLEXRa5c0bB8sPp0Td5BQ9
	ZElUdR0cIdwjQI/8Eeko4CxAqptRZ8QPiFjBsrvxYvhg9JdLeGrHkhRl
X-Gm-Gg: ASbGncvLtJVABb1fpGFgXuibE3jYx61wrsSXmznOyZTNRJxVLRtTr8qW5juTMmfHCnw
	bvauc7/vaII2IkA4IuN2pIm9Sa9CVitpSCUq4u4D/aMSfoTg/d32gD1bSBfOY7fEFMtSp/TkQzR
	PnVw5D/n9LSnrI4CvMDx3OsoyfIggwdVWypPQXrSxtP5bd3NicV8rWdjA/ej0EaO3q9w7zjTpoP
	KT3PG+6Qlg98o1UFtF1sIZnOzdIU6OiHo/vpibAKC1ZHt28j15QOZFLL6mEOsztYIk3F7aF5UR8
	lLQpA3lPs1l1J6cN0MyCKce72PdoP8dlpvBdw1tjyUeGACeel0MW20nBg3HH5T0WZINHz5tOylE
	j7+XPl/zv+GjdvTtLgjwwLb1XL8FVIwJPW4cNevUdS1+oBmONj7OimcsDSskA7mJyqrAFsp8KE0
	2OiT5r
X-Google-Smtp-Source: AGHT+IFdNnc7DzaQX7KZN4cK+hRf5+nYYgDneGcjdnqhEB22vM7HhXSV8YI2YMPoTfYwOODl+JO7hQ==
X-Received: by 2002:a05:6870:294:b0:3ec:38a7:a076 with SMTP id 586e51a60fabf-3f5bdbd8ad3mr1747759fac.28.1765380106541;
        Wed, 10 Dec 2025 07:21:46 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f5ca9e43a8sm852393fac.20.2025.12.10.07.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:21:46 -0800 (PST)
Date: Wed, 10 Dec 2025 09:21:43 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] builtin/repo: add inflated object info to structure
 table
Message-ID: <vrlxdgvibiuohfc6k6nbmloibivntex33ucnmfdqpqu4dparbi@piyq3kckcyje>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-5-jltobler@gmail.com>
 <aTkTEselZ4yL11qd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTkTEselZ4yL11qd@pks.im>

On 25/12/10 07:28AM, Patrick Steinhardt wrote:
> On Tue, Dec 09, 2025 at 04:58:18PM -0600, Justin Tobler wrote:
> > Update the table output format for the git-repo(1) structure command to
> > begin printing the total inflated object size info by object type. To be
> > more human-friendly, larger values are scaled down and displayed with
> > the appropriate unit prefix. Output for the keyvalue and nul formats
> > remains unchanged.
> > 
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  builtin/repo.c            | 57 +++++++++++++++++++++++++++++++++--
> >  t/t1901-repo-structure.sh | 62 +++++++++++++++++++++++----------------
> >  2 files changed, 90 insertions(+), 29 deletions(-)
> > 
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index a67215ae31..5c37f4116f 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -315,6 +315,44 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
> >  	va_end(ap);
> >  }
> >  
> > +static const char *unit_B = "B";
> > +static const char *unit_KiB = "KiB";
> > +static const char *unit_MiB = "MiB";
> > +static const char *unit_GiB = "GiB";
> 
> Okay, nice, you already use KiB et al as I suggested in an earlier
> comment. But I guess these should also be marked as translatable.

Will do.

> > +static void stats_table_size_addf(struct stats_table *table, size_t value,
> > +				  const char *format, ...)
> > +{
> > +	struct stats_table_entry *entry;
> > +	va_list ap;
> > +
> > +	CALLOC_ARRAY(entry, 1);
> > +
> > +	if (value > 1 << 30) {
> > +		uintmax_t x = (uintmax_t)value + 5368709;
> > +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 30,
> > +				       ((x & ((1 << 30) - 1)) * 100) >> 30);
> > +		entry->unit = unit_GiB;
> > +	} else if (value > 1 << 20) {
> > +		uintmax_t x = (uintmax_t)value + 5243;
> > +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 20,
> > +				       ((x & ((1 << 20) - 1)) * 100) >> 20);
> > +		entry->unit = unit_MiB;
> > +	} else if (value > 1 << 10) {
> > +		uintmax_t x = (uintmax_t)value + 5;
> > +		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 10,
> > +				       ((x & ((1 << 10) - 1)) * 100) >> 10);
> > +		entry->unit = unit_KiB;
> > +	} else {
> > +		entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> > +		entry->unit = unit_B;
> > +	}
> 
> Euh. What kind of black magic is this? This block at least warrants a
> comment how you came up with these incantations.

Ya, I'll add some comments to explain what is going on here. :)

> Also, git-rev-list(1) already has logic to output human-formatted disk
> sizes via `git rev-list --disk-usage=human`. Can we share the logic?

So I believe `git rev-list --disk-usage=human` relies on
strbuf_humanise_bytes() under the hood. The problem here is that it
combines the value and unit prefix together. For alignment purposes in
the table output, we need to store the value and unit prefix separately.
I couldn't immediately think of a great way to share logic here so I
opted to implement it separately to accommodate this specific use case.

-Justin
