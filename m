Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FC185B48
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092733; cv=none; b=UFUzlBSWx3+C6naKLRdLZDe1rsBurBpRnERu4LUV9Tm+aJe2RxEn5yrA1mvTIyxfraWEul5QKqyeCaiY3bYEBaXdCd1QAToIns/2kgyuUWGy1Aget2sJDZ3PcUCDKVGLuHSP1jYsStdtYsxTddhOoY0+zp8fLtlcy+YCjSl8IvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092733; c=relaxed/simple;
	bh=M/3ib0M2iWhM/MrpBul7Il7vCrDTRqQXU+kGAIeOjNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltrDsQTGbjQwSefpGazEd4qYspWdHYW2Tla1EXRgP6nVC98qkn8DOXkQPKoSx2wJ87MtfrlUiUVWxIewXsor0V0ot23xG8xrpNMDkBkcTg45F5+PykJBiwtvlO8oQiHOIJb4cPNoSFSyqCM1qupUGRo4wtsOnmVBB/LKX0pMEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bVaIrUUZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bVaIrUUZ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee1939e70bso10870711cf.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 13:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1766092730; x=1766697530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9zVo6cA7LJpqUBBY7I4WNaF0SNaKM2rFspXuiZB33Y=;
        b=bVaIrUUZcGTRTNLqSbUxTbJghJvmgQyF3ADM4uuKySNJGxwPu0dB0fmJj6PM46Qzbk
         sX0oOa+YOAcl2pIF0yo5S4qQXGjxfsjSJgjlcuKW1pcybBkwPnlzCWboXPtUZnHU1z+G
         Y5UdC+UqY803GTMtfrQQt6K9ld79Us+od4ZyAE0kvEigDksnOg9o+0R+HZNCYeUfHPzr
         KB2ki4Fm3XfMN3ZKb10r/1G9s5V+4ITGfB0tOvzfKNoBBCcuByO04z4Ka6+SMMPiEMy5
         +yu1kK809lMmX0Kh7E9tDd0bvhJoQebR2mq+PEOG8T7+M58xptm9tcj/KKksA2WbDzT9
         n3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766092730; x=1766697530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9zVo6cA7LJpqUBBY7I4WNaF0SNaKM2rFspXuiZB33Y=;
        b=N5zf/OBVUZPrLYIxsEr1TMw0dZtJdxNYz87SZRio8y6JNB4S+dyKFlqqkYoYfb9xEh
         HDVJDoo4HtKEZB4WTJJhz7/JY1AI5YAmiMQzFQpzu978XOlJGfgD1PQdS6FJJEpKDa5I
         IO948M9UQLVZvcbfjVPkNt4/SBSA1QH2XHHVdk29aHlez987tCphtt9m3Pcwja6tP7Ka
         k+DMqJOkrBZ6SxqhH5hGZn1mD8LVXcOwK27U3ehBQroOMgLd2cE6/JM3ZSveOemZG17x
         Xn7RddU3EHf632BzlSjnhfFz83BrliPZZkr6Iy0ixHO9tH5Cs5kWsxcCAjAVGOailO4/
         C7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVJTOuzbJf9Vb9QvHGsrHRSLGgPwq+PGd+3UgSulPz4XdErf8zDNpN2uFmnbzO+lpIPd8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDq1kZWxGowEgnjrj8gyF4uKC37na5IqHz0j2tUVIUpOhqfc7
	CvtF3kPr64uW3OqzWw2hIZCq99c2OXvGrDIwomRBmFjIKJU+8/wdTpcW6QuWrkSSEjY=
X-Gm-Gg: AY/fxX6fxRqe7tiNkCklNEEN6qhmw4fGP6sIWEzfLPlwCxTZihPl+JON579b6YZn9jG
	YOZk2eDDpvjmoN+JcFx0Br/DjzopmndI1KZIUCL7+YCMa4uCzyC6ctSQp/I8nKb9w9hzVl04WAd
	7jGerFyGWfwnNEpBm5cS4n9VNwhmj6qR+bvop5m6a+o8ru2evGI+smLVQyhQqz6Srz2brrG0vPP
	jdmSXUdIYNezxhQ79zeteSTDHD01uEqCUAEIAdmqdt3s0Si5aAh3DXM7Tub2ymEQ5eg9VbH0IqM
	W8V9kFEcZil+9KBHjDFXN4igBM9IIeq62g9HRQpimwwdIDrPHiNc1QEHJ6Wq1kkgNq7SUdWJJPn
	lTdI91QSzFyLqG4E2NXqNohGU9OsB1mxJ5y/Vw6to4/cV8Pqah0B3EyhmHxoqtyknH0B8T1Wxql
	IlcR4YojlElzHu9SAtqvD/bHcfrH/sd9AYA/XjLX4jEyHSxj+fDgD9T4+RfNK2N67AGwcatamES
	0sx9xN8+kNLnzYIY9H5lRLkPje1
X-Google-Smtp-Source: AGHT+IGawRsIowV5TM01ewCzdv92QgksaOoeLYnABpwpLlh19NCXTZavIfhtcEM4sGtJ07sBkD5Phg==
X-Received: by 2002:a05:622a:1307:b0:4e8:a413:bb3a with SMTP id d75a77b69052e-4f4abd799fdmr11376231cf.46.1766092730282;
        Thu, 18 Dec 2025 13:18:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac530f0dsm2510211cf.3.2025.12.18.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:18:49 -0800 (PST)
Date: Thu, 18 Dec 2025 16:18:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] builtin/repack: avoid rewriting up-to-date MIDX
Message-ID: <aURvuLcIVpBSIhiE@nand.local>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
 <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
 <xmqqsedhe78q.fsf@gitster.g>
 <aTvFOlhtPHgWQC5L@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTvFOlhtPHgWQC5L@pks.im>

On Fri, Dec 12, 2025 at 08:33:14AM +0100, Patrick Steinhardt wrote:
> On Thu, Dec 11, 2025 at 05:46:13PM +0900, Junio C Hamano wrote:
> > This and Taylor's incremental part 3.2 have a slight conflict in
> > that this topic factors away the logic to compute if we need
> > recomputing MIDX while the other one tweaks with yet another flag.
> >
> > My tentative resolution in 'seen' looks like the attached.  Sanity
> > checking is very much appreciated.
> >
> > Thanks.
> >
> > diff --cc midx-write.c
> > index ce459b02c3,f2dbacef4c..66c125ccb0
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@@ -1014,73 -1131,30 +1131,89 @@@ static void clear_midx_files(struct odb
> >   	strbuf_release(&buf);
> >   }
> >
> >  +static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_context *ctx)
> >  +{
> >  +	struct strset packs = STRSET_INIT;
> >  +	struct strbuf buf = STRBUF_INIT;
> >  +	bool needed = true;
> >  +
> >  +	/*
> >  +	 * Ignore incremental updates for now. The assumption is that any
> >  +	 * incremental update would be either empty (in which case we will bail
> >  +	 * out later) or it would actually cover at least one new pack.
> >  +	 */
> > - 	if (ctx->incremental)
> > ++	if (ctx->incremental || ctx->compact)
> >  +		goto out;
>
> So this here is essentially the change you had to port over, which looks
> about right to me. The comment is becoming somewhat stale due to the
> change, but I don't think that's much of an issue for now.
>
> Thanks!

Thanks, both. The new version of these patches looks good to me. FYI I
am going out of office beginning tomorrow through the end of the year.
In case it's easier to queue, it's fine to drop my 3.2 patches from
'seen' and take Patrick's v2 as-is.

I plan on sending a new round of 3.2 in the first week of the new year
and don't mind it being dropped in the meantime, especially if it makes
things easier for the maintainer.

Enjoy the holidays everyone!

Thanks,
Taylor
