Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92535942
	for <git@vger.kernel.org>; Wed, 28 May 2025 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398691; cv=none; b=rGe1HrijhpPDhSvXvi5L1G9sVycmooMQI2I8y0DsY5Jyv3bB1vwCFsqU9Sv23uQZ9vunWa2qlXnSWW3ft5ghAq2lhGSiajPcRkfJgOwzXSlYALM66VGBl5Z+qQgHxsBxmPxMuXlTnJEAJZGYcRuoNN+udWlAFSlmBABogVDvxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398691; c=relaxed/simple;
	bh=j2uwhtziwySaxhZz2re6SJNQnLt0a04Tri0MC0Kr94w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV/RFIIcgZhLpyws68sw0uN7hvXkKRPM/0/93WKRblOfB8y9zq7nQ1V6YUpw9n/OUbxQq4E50cKGy52Cdh0+icbR/NRjrlyjrWXgRuwc+a87ww9fdXAqTZBpJl/M2njUgjB47FuKZlfsTS9tmFgSllfr46aFmleRXiUaL25d/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PaD64dk9; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PaD64dk9"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7cd0a7b672bso247757785a.2
        for <git@vger.kernel.org>; Tue, 27 May 2025 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748398688; x=1749003488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOquo2uxUHnAWLCeuqLs4Ux3omVCrcpjb4ZDNxq1yik=;
        b=PaD64dk9sJrdGWZJPd1Ioo7csKqOo6YS1p6rVSL79HxD/a5UnzaS7Y3TWFPwcAXD7A
         xQBp0NTU42NXadgosDnMSMNyF+7j9V0cIItMt+gmYHCj0f5JMcBkbjGabZUmjhNM7RXz
         2dA+WD6epJ6jHU3ZhEcwJKOIwhp6HKh4sZYSaj95Stm8AMf5PCcZ+RffAQU5fdYB6PSV
         o++LZuFfm55C3O4f/6He9ft5UQxu1v0QuH9hlGB0sc3ymULh4f0ngMazG61pgCCq4/WU
         j8K/+QXY2+Q7+Gzi+i94K2TtAV1IwDt6pr9QVf1IjbVmEKEdkYqc4bMuG+4Wbs+0kE+Q
         wfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748398688; x=1749003488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOquo2uxUHnAWLCeuqLs4Ux3omVCrcpjb4ZDNxq1yik=;
        b=i12hFUTvQuUtCCBPParLNjrE6ao7eI+V6KKEj3BWHB15M7+nUqRPz++WjtY+iahXMt
         PSCAbIARvRXOg2M3hSIbEXw2UdunDQ42yK6b8gwkAEs6XZLZPYTZlipeaejp0tuDJg7c
         QNrnU5tOy/+s0FC3qe2LJ8iGcVptgLsds9rq0Cxx57ISNZOakIqLvKu1ARMoZovQuQHp
         QzKeMyeI5ZZucsoE8EnCUNFRiwEdWA6qpmG3ahPPylo7GhLnp2in4zY8VizwoiytLUvH
         vXf3fBeSp4N+Z3QPv9BJjlq4LgCDoe0YfyQbuz62GS63Fmy3MtKYmWQgfGVK4YUbe9AX
         ke5A==
X-Gm-Message-State: AOJu0Yx6FRfeqwcHG6Y7NfqRCDfFx6cUlokwNC+Tm6h2sFTmQPp/PXTy
	Qw61wVZKzQ81PvmlAaj0X6giqKRMyb1QAJ5zyrjpcSOgPt6cN2prz75o9yOfG64JfJU=
X-Gm-Gg: ASbGncuQcpP1zthxTuOOWbGpHTee64KHcN0h+8S3qzxfRtfsfku3on9R9jkzaR++q1r
	oUSwg8gcURhxyBiIYhCuBQvJJG6e4E50xzLjnOLOdgRskzHTBpUh4gLiLhS2/SzzQZBjZR49ODU
	Wn+y64Nk2K3WXztGgKAcQFLtBgGy7t3grRHuBDa7V6OyeYXKeaf9JhECxJLFQ/5wYThCBj6QQ/O
	nrG6REnbpKH0QAd/Fz5za4wDoD2lkd/uhZKwdl8Kj78bGJZMQjizhrEVIiun9koDWGDgzniFc35
	4yPCYzmqAM/4BIfkZnI+Nd4x1+B5c4qG8hUYEyPMagiiWMWRgGw0/HTX3owipgKCrkgBZSrrZ37
	FaNCI82GJ4sMEFpMLe/RWz48Olg5+4MqErQ==
X-Google-Smtp-Source: AGHT+IHhNYQFsZgHmmiMhs6N6K2UucTf4KIgdcl33lu2ZKQQ0C3bb+JpkJEkEqPocZ5VjIIlI/K08g==
X-Received: by 2002:a05:620a:414b:b0:7c5:b909:fde1 with SMTP id af79cd13be357-7ceecb94895mr2428173385a.25.1748398688575;
        Tue, 27 May 2025 19:18:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cfb82102e8sm16859685a.28.2025.05.27.19.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 19:18:08 -0700 (PDT)
Date: Tue, 27 May 2025 22:18:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] midx: return a `packed_git` pointer from
 `prepare_midx_pack()`
Message-ID: <aDZyXlPojqxxxjl6@nand.local>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <80699bb3ee35f8c4728e7efe8dc53d17134a5fe5.1748198489.git.me@ttaylorr.com>
 <aDQXEz-RtrcUAwic@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDQXEz-RtrcUAwic@pks.im>

On Mon, May 26, 2025 at 09:24:03AM +0200, Patrick Steinhardt wrote:
> On Sun, May 25, 2025 at 02:42:03PM -0400, Taylor Blau wrote:
> > diff --git a/midx.c b/midx.c
> > index fbce88bd46..f7f509cf46 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -449,50 +449,48 @@ static uint32_t midx_for_pack(struct multi_pack_index **_m,
> >  	return pack_int_id - m->num_packs_in_base;
> >  }
> >
> > -int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
> > -		      uint32_t pack_int_id)
> > +struct packed_git *prepare_midx_pack(struct repository *r,
> > +				     struct multi_pack_index *m,
> > +				     uint32_t pack_int_id)
> >  {
> > -	struct strbuf pack_name = STRBUF_INIT;
> > -	struct strbuf key = STRBUF_INIT;
> > -	struct packed_git *p;
> > +	uint32_t pack_pos = midx_for_pack(&m, pack_int_id);
> >
> > -	pack_int_id = midx_for_pack(&m, pack_int_id);
> > +	if (!m->packs[pack_pos]) {
> > +		struct strbuf pack_name = STRBUF_INIT;
> > +		struct strbuf key = STRBUF_INIT;
> > +		struct packed_git *p;
> >
> > -	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
> > -		return 1;
>
> Ah, so this series builds on top of my patch that introduces the
> negative lookup cache? That wasn't quite clear to me and makes it a bit
> hard to iterate on my patch now.

Eek, sorry for the confusion. I mentioned it in the beginning of my
cover letter as well as the (less visible) "base-commit" identifier. Is
there another spot where I could have highlighted the dependency more
clearly?

> Could I suggest that you maybe include that patch as part of this
> series so that those can be iterated on in tandem?

I could, however your branch is already tentatively marked for 'next',
and Junio applied this topic to a branch based on yours as I had
suggested. So we could change it, but I think it would be more of a
hassle for Junio, so I'd rather avoid doing so.

Are there changes that you want to make on top of your patch?

> Overall I think that this change is quite sensible and hides away at
> least some of the complexity. Thanks!

Much appreciated :-).

Thanks,
Taylor
