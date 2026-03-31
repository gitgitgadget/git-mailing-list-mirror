Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781538F23D
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995968; cv=none; b=Z/YjLYpsxpDqe/q4Q412bJ7GS5pGh/AmGd/dvjGNjNyu/l9DEuCezB1mHoH1poYu6f8xCTEX4CCzr+p8M6+ObExJHl+bz7/W9wY/O/Rpb+iJLUMD4fT0dVtQ7UqMUfLM0HZLBoZHJu3w/7XARJss87aVVUXincjCnCqag3Z4pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995968; c=relaxed/simple;
	bh=Xx60UJy13/vjVCbR1vQHFem2QPmW8krf5n8Q2CdPTUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeqD/JFhX1WkS32VU5UumAcdFviUOtAx2PNOzsP3Qs+SwZI7ZMKzp3tNRXGN3AMEZLWvaZGhbP3xNpO0ZIsA7HUcZXES5p7RNBN2+q/Ie1XtlC+Gjaf+HANQUV0PfWpAW4Sl+lB+CQJyk6OcxbGwT3ldAssiR1QqQ/Avu2hbMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Y+WMDltq; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Y+WMDltq"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7927261a3acso27704007b3.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774995966; x=1775600766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4XsiQeh1NgTeAEhmYogIpf5iL+JR+MMZgKU1Diq18M=;
        b=Y+WMDltqAvIcjiQVjo9zcp9Na2lmNyuOmgs5QL4Msk93EZ6VkufQUY8WXhiWMCNEW8
         L7Sr4j1ol/unfEwpcszOMYFchXTiXtIxeDBv+d17ZibVdFw+oOOVosLfAeyt0QN3iMAZ
         CNxh3OL62l3RjEbhlqZ1Z1kEXsIUkrODZ3iaQq6hdLelLfY/EepSa/PLVfV+jZ7HuBH3
         8nlgvTcGbbWgX3LqftUl6fg93FG+ulgbFYK1cqKs/cIMAw5mkaXW8FiZbw+5/pEwyyZX
         qykm4uaIcLQgSYltZIbOkVTpqiS0zqNFC0/kKoW82aXnn1HpA2OHvPwMC4Qn8K4xDmTu
         x+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774995966; x=1775600766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4XsiQeh1NgTeAEhmYogIpf5iL+JR+MMZgKU1Diq18M=;
        b=a2ixsNBER7pHma7JeTbMthBA73sclbTUeZ34PjRE926qpCWw/+52U7nkHniEKJIBCR
         z+a3dIsWogWEYEECm15v3WUOBaUHf2bwxbvzIMLzpz2uZiFfgGfGa1k6iFbR/0/Q9GRv
         /MINqSGMEsfMsVnkGDgXYrLyrpO61OKFYFdl1Gow6JY4iMXHeoMlN5t/3GMX+gcDg5r0
         20evsC6acy7byX6eLn5/40edseT+MJzWVxwvbGsVxBgSCyhpBwDVHGxmRDUxP8gcE8g/
         ni5Vt4gDcHq0HrvLhUE4P9UuOvrBaTBPLARzhsAqY4E0rd+THsHAwDJ9qpB2YcIQAvmL
         /5tQ==
X-Gm-Message-State: AOJu0YyIXn7kKrh3IsemCV+xhP5X11QZAepi3MuBqnmYhAUKzrR6si75
	XH4CvAKe5o7CCZyKG8BP1aKyhkDEsgLKI/iFZKT9LbGiNmC2RrCCYWQLLAGMTqs/WrY=
X-Gm-Gg: ATEYQzxiCS+fw1yitsNTkNqYcmwRjJZIM9C3nG5SNvQiK/VE0nFAE0QwksrmXKQJB3I
	FEMrdS9MBAdj/QpEu/WHR3ob3rJkMh7wsN8z9D54HETJicW4BNjrHGuLgznk6ahT/RuQJqT17HT
	wfjeJ3P4CksFO3jM221o/EvObf9c2PeZEBEuqQwoILnb4AJCajJIOzm5CnEfw2VGdNOvGbLYpjF
	SI7kpchys+4h7pK0mOcFy6hKFx+EJsfarbNIa1QH2hGdYT91fpt9reyEkrqQcp61nYwD7pqJgSo
	fS4bGkreGUA/h7ges1k7j7gRUOpfQ8jLwMfpC3PtOE8ayhocRuhq6S7fWyVyLzKAPZ1Y0B4WOqq
	gFtFW0H2jZyqXdE0vstasgfpWUmsRfqWo9WMGPuWe0SHsyY/f0081HBxHwrX6AJNbjNDzRO0CjH
	s3CiK/rQRdazVjAWpP/EilMgqRXxdW+OdhpgEEI9+NHAMJ22AzJ3ZGN2yhrMKP01+HLQ3wEImUC
	xPtYORDmauIhBN9aNlTcuihQeeA7xJdyJ7W6/ln
X-Received: by 2002:a05:690c:c4e5:b0:79a:7cf4:1a47 with SMTP id 00721157ae682-7a212832ccbmr14155067b3.42.1774995965825;
        Tue, 31 Mar 2026 15:26:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f19fsm54543357b3.23.2026.03.31.15.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 15:26:05 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:26:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <acxJ/NfLNloCv3o+@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <5fc72d5049a602ae5ede6bb243f44546f02d995d.1774820449.git.me@ttaylorr.com>
 <20260330230130.GD41843@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330230130.GD41843@coredump.intra.peff.net>

On Mon, Mar 30, 2026 at 07:01:30PM -0400, Jeff King wrote:
> On Sun, Mar 29, 2026 at 05:41:00PM -0400, Taylor Blau wrote:
>
> > -	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
> > +	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
> >
> >  	if (ctx.incremental) {
> >  		FILE *chainf = fdopen_lock_file(&lk, "w");
> > @@ -1760,39 +1760,45 @@ static int write_midx_internal(struct write_midx_opts *opts)
> >  			for (i = 0; i < num_layers_before_from; i++) {
> >  				uint32_t j = num_layers_before_from - i - 1;
> >
> > -				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
> > +				keep_hashes.v[j] = xstrdup(midx_get_checksum_hex(m));
> > +				keep_hashes.nr++;
>
> Gross, we are just manipulating the innards of the strvec ourselves?
>
> Is it really worth doing this (and adding init_alloc()) versus just:
>
>   strvec_init(&keep_hashes);
>   for (...)
> 	strvec_push(midx_get_checksum_hex(m));
>
> ? That's amortized linear-time, and it's not like the number of midx
> layers is going to be large anyway.

Yeah, this is all pretty disgusting. It's in service of what you noted
below where we need to fill in the array out-of-order, but that's really
bending strvec around MIDX-specific awkwardness, which I dislike.

> I dunno. Maybe that is hard to do. But if so, I question whether moving
> to a strvec is worth it here, since we are not treating it as an opaque
> type anymore. And it is not buying us much to use it (we get to pass one
> parameter versus two, though that is easily solved with a struct, and we
> get to use _clear() instead of our own free loop).

I think it is worth it to move to a strvec here to avoid having to
manage our own memory and pass the length around separately, but I
dislike the way that I did it in this patch.

I tried adjusting this patch to juggle the MIDX layers in a way that
would allow us to just push to the strvec. It ended up being less
awkward/difficult than I thought, so I think we should go with that and
drop the previous patch.

> >  void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
> > -				      char **keep_hashes,
> > -				      uint32_t hashes_nr)
> > +				      const struct strvec *keep_hashes)
> >  {
> >  	struct clear_midx_data data = {
> > -		.keep = STRING_LIST_INIT_NODUP,
> > +		.keep = STRING_LIST_INIT_DUP,
> >  		.ext = ext,
> >  	};
> > -	uint32_t i;
> >
> > -	for (i = 0; i < hashes_nr; i++)
> > -		string_list_append(&data.keep,
> > -				   xstrfmt("multi-pack-index-%s.%s",
> > -					   keep_hashes[i], ext));
> > -	string_list_sort(&data.keep);
> > +	if (keep_hashes) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +		for (size_t i = 0; i < keep_hashes->nr; i++) {
> > +			strbuf_reset(&buf);
> > +
> > +			strbuf_addf(&buf, "multi-pack-index-%s.%s",
> > +				    keep_hashes->v[i], ext);
> > +			string_list_append(&data.keep, buf.buf);
> > +		}
> > +
> > +		string_list_sort(&data.keep);
> > +		strbuf_release(&buf);
> > +	}
>
> This hunk was unexpected. We move from xstrfmt() to a strbuf, but does
> that have anything to do with the rest of the patch?

Yeah, this looks like it was left over from when I was writing this
patch and trying out different approaches, and I didn't notice that I
left it in when sending this patch out.

> Also also, the original was leaking the strings, right? The string_list
> was initialized as NODUP, but we assigned allocate xstrfmt() results to
> it. But because of the nodup, string_list_clear() won't free them.
> It should have been:
>
>   .keep = STRING_LIST_INIT_DUP,
>   [...]
>   string_list_append_nodup(&data.keep, xstfmrt(...));
>   [...]
>   string_list_clear(&data.keep);
>
> in patch 2.

Good catch, that's right, but partially obviated by the fact that we're moving to
strset here.

Thanks,
Taylor
