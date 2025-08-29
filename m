Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED763FE7
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431312; cv=none; b=RvYVML5qwu0WoM5XXH/K5ixURBXyuoJnvC+LIlsmccJvwUnpdsMiwZct4UtMo8yKeIElmjxQgno+y2ncj8K13qg6jaaBbgwOcC/XvEfUil70Uw5rIO2mSq8r+wlTPEuNnhnHJGyBo6mLmwPBbVsjjNFjpbdgtDC1a2/7zapAHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431312; c=relaxed/simple;
	bh=7J8P2mnqJ1Y+wVof9UpmpMIjjr3dKInC01uWPqyp3Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTADCNmAjejSyb5mB0IK5sEWgZi2nBhZvfVfTUDEOH7DO5ES3YRixvuvZo6WaJh4r05aG/Z2pQmjKZCb6ZjAkYDVgX48JuuyykSl9gRjuxFmYBZvG/Dzhui5NbIH/z2GlhMlPX4Xlnobz8EXcI6XdWn1livBlLaZnEKmQ2NvSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jrm4WUqi; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jrm4WUqi"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f2b6e0b942so923535ab.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756431310; x=1757036110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iigQslfwzil5RVs49aF8FbznLBxPZt1mA779Y5YiEBw=;
        b=jrm4WUqinzbtYLI5a79DNAS9axBXmi8KlJwV2Cvf8DihxPQz4D7zl9FmohQK4ZVoib
         ALT+9vN3/QeHwnxQqOk3VDMwH4U758WTD/4R4g0myRuRONDlU0w2WW2YKQKy9ErWZ7Ak
         1wrVwPBCRDp050c8wyBphl/xGgZTEfeYMGonouC8f878sZ8UGI8M85clSkw+NFivsHr1
         cBsjigNpjpX0OJJibtJeVv/MGE7TKtxP4wBu8FRLDP916Cy1JYZVCcakoZncaYwjTl0Z
         kwzreYetRLX5jVc1S80DiOhD2Lzx7vCZy+4+Jtw7CL40GwqkisUkg2/SfFXKcCiPKaNz
         BvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756431310; x=1757036110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iigQslfwzil5RVs49aF8FbznLBxPZt1mA779Y5YiEBw=;
        b=gGnXTXf3oaIAzj96oBXxoOVln40bTk3QLLwpJp5ZgVnlH4p+tlmp4E0+b+KODflCFj
         5cPZB9EHiWH0oJHINeo8TtIkZXshrs2nDB6ZMRVoTBsudr+vMJz7IPudxtQWdCa8ekDd
         g0UqS75StlBGaMn8DAdPZ3RG/U2vB4e5mUtq4OmSOuRfaD1Gl2OkRMooXZ0uzX0luEuL
         pE3JHIfeoyAhASVWjmRvX1IdOpbGZKTvw3Yjt4kLiQP4wuUDL5VnUbFcbBiDGGvFQkO1
         DSWkCoCM3YV9AWWC7CSaEXvBdqCeYi8Y26jnHb+VvqShdUmICARaATRCoEo3lcaWdIB/
         aNRg==
X-Gm-Message-State: AOJu0Ywl584nCfgVgam+S9obLZn8EnR/Wg8az0zgh/YJRlfMWGQJwR/u
	P0EHt30N7RC7AkIdNys/Ei1PbKkhmrIIx8B8Ibp5/tTCNtNw5kJWS7A9s0DA7LeVh98=
X-Gm-Gg: ASbGncsmM37rxH52wcD+m6t1YB1t1czip0vFbq9wtKdfYIyEkeLb4YCEOax9jkqwDjY
	IzBA5ZU7LNUcBfdCoSo7PJP4AsiMv4A6Fi3lTnqOzzxVdOLmoc0Dvk2fqjmc6aVXZ1mzrekXzZf
	r4a3qp4ZyQI2Ar99aZ9Fi/DnwyyOVCZvB2Ic8KPq++xADmrDVo1oYhw0NHt++TLPzKejeAvZ3ht
	T5qG3g8xxs+irJGs5dL1B8i2kzrlFqM8aKC/GWY8UsE8ONk29ADzTbIZ1v2S3/YdOlxJiTWBeH9
	+aP1MNOaVczQ0QDFxwvmjwUhhEyzk95jkllBI3aEE4WZZZAP1P2MAd3K6lVd02xhaFp1n+xFL5u
	FMESzPW4xxNMwe9l77Koc7YyXWvJsgq22UaZf0t+DnTax7H/exZcwBNh/ejU7qowZqsCihsPwCe
	F4zrInPo0wmVIwQleMidL2lsfNj8UJp0Z5e8rl
X-Google-Smtp-Source: AGHT+IHoP80uZq9QuSQDATuZpflEorfSLwbt+qKWCAHWA+FWLwsH7shUzp+VBeuO2icEuemtRsBgAQ==
X-Received: by 2002:a05:6e02:19c8:b0:3e4:9a1:6542 with SMTP id e9e14a558f8ab-3e921c51667mr410327515ab.18.1756431309638;
        Thu, 28 Aug 2025 18:35:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3f29f398205sm2489395ab.12.2025.08.28.18.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:35:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:35:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/5] midx-write: use uint32_t for preferred_pack_idx
Message-ID: <aLEDzF3b6tax6Lnq@nand.local>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <bd97db26f7f789315134dc796403b1ab9976135b.1756402795.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd97db26f7f789315134dc796403b1ab9976135b.1756402795.git.gitgitgadget@gmail.com>

On Thu, Aug 28, 2025 at 05:39:54PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> midx-write.c has the DISABLE_SIGN_COMPARE_WARNINGS macro defined for a
> few reasons, but the biggest one is the use of a signed
> preferred_pack_idx member inside the write_midx_context struct. The code
> currently uses -1 to indicate an unset preferred pack but pack int ids
> are normally handled as uint32_t. There are also a few loops that search
> for the preferred pack by name and those iterators will need updates to
> uint32_t in the next change.
>
> For now, replace the use of -1 with a 'NO_PREFERRED_PACK' macro and an
> equality check. The macro stores the max value of a uint32_t, so we
> cannot store a preferred pack that appears last in a list of 2^32 total
> packs, but that's expected to be unreasonable already. This improves the
> range from 2^31 already.

Nice ;-).

> There are some careful things to worry about with initializing the
> preferred pack in the struct and using that value when searching for a
> preferred pack that was already incorrect but accidentally working when
> the index was initialized to zero.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  midx-write.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/midx-write.c b/midx-write.c
> index f2d9a990e6..ea1b3a199c 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -24,6 +24,7 @@
>  #define BITMAP_POS_UNKNOWN (~((uint32_t)0))
>  #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
>  #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
> +#define NO_PREFERRED_PACK (~((uint32_t)0))

I think that just (~(uint32_t)0) is necessary, but I don't mind the
extra clarity.

> @@ -274,7 +275,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
>  	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
>
>  	for (cur_object = start; cur_object < end; cur_object++) {
> -		if ((preferred_pack > -1) &&
> +		if ((preferred_pack != NO_PREFERRED_PACK) &&
>  		    (preferred_pack == nth_midxed_pack_int_id(m, cur_object))) {

OK, here we should make sure that the preferred pack was provided.

Like you mentioned above, I guess that means we can't have the 2^32-1'st
pack, but before we couldn't have any pack greater than 2^31-1
preferred, so this is a strict improvement ;-).

>  			/*
>  			 * Objects from preferred packs are added
> @@ -364,7 +365,8 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
>  						    preferred, cur_fanout);
>  		}
>
> -		if (-1 < ctx->preferred_pack_idx && ctx->preferred_pack_idx < start_pack)
> +		if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
> +		    ctx->preferred_pack_idx < start_pack)

Looks good. It's tempting to say that any value of preferred_pack_idx
lower than start_pack is going to be OK, since start_pack is a uint32_t
as well, but we need to make sure that the preferred pack was specified
in the first place.

The rest all looks good as well, thanks.

Thanks,
Taylor
