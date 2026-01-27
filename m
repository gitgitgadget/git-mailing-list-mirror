Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A78F346ADC
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552012; cv=none; b=fBJ82970kf58M9yefphShg0GGfkCVs1YxHRJmtRESU5kREG3vDq5GJNyXSm0MfSdAJMfdLpBT+ZZiU8pCDVRnivkpY1rq96k2tSB5XM6W1LHZrWis4T4oaUXV/LTM4SaahtSBEVJy183Q4xFkCYbvCecsSa2xPo7BThN4SlAT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552012; c=relaxed/simple;
	bh=1yXEQQWbvzj5bzHlY/sBF2tok6hl1ii6Z1vfZgj53oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF4AlDcl+2tOaicrq/K1CxZnF1yMpymia0ofrT9bz+RKTAQ4qUeR+6ofmenE/2MRyLnxrGIKPgmjk12+ab4m4WvT6FITnWTF29CZXyARx4qvf6GwgHLt/8RkuzqdsajRv+nltjpmSKJJhS1FfE+fD/XGStJT0jS94ADBCSK3vJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OlOSaeVv; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OlOSaeVv"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a26ce6619so79653906d6.3
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769552010; x=1770156810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ClsY0sU2ZX6iUtkXmDbY/gGn26IP+YZ+XnTCDuY9bzs=;
        b=OlOSaeVvQym0x4bejnXmQ56phx5yL8VE6fhpH7t27JnnNciHREA/dAwYQI78b01WfH
         hL6wUsDWJ3plgCE7UJoI8GZPTXl32o59FgxD7/q73ArhfHDJ1QG/9aSo9shvEogdrAKs
         gAau51ojwJVtXrUM83bsylR5JpQ0AwFd3+hDwJuVFJ3Vw5OzbNBF4zk6fpHngwy2ajuo
         310MUsYUHEKQld92nKvFUyZ6kKUIyWPN4tDJhXQbG5znFApzt5WqO5rV6oGW4sNNwpQu
         kX8y2JuVVaf9Bif7dqBbYuWVUuGV17Sam+krBf5CqREH1smFeoLr5LwvFffvr75L7+y/
         4/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769552010; x=1770156810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClsY0sU2ZX6iUtkXmDbY/gGn26IP+YZ+XnTCDuY9bzs=;
        b=w4PT9WR9xbdHpYlTpM8U2wAMfalkVG4iby+/QNZafTBD/aGBfeW+ek4EoM9C2nQWPH
         sv/umUIIjhfsFfjKgjdo9Y/zbidd7RWNKHjVikFgGm/3LxH+Dae1TS5vgPPEJmeK9WnE
         K8lRNpT03dFlqqmvXZtIBPX6uuFWsSlbw26PKcWYfvBIwXku0kH9ZYrHw+Z26qmpMrJB
         jf5Xyj+3TyFr+wTSEChqAjAI1CWsILJ4KONrjANODHd+I1aSAwfrkp4x8p58F09BNs3o
         CA1rzruAcrrUlM2AVY3OHqkm1ge7t/GZB5b4mw/T3RwaKXV9jzHYYBvBzWDNNQjck7F7
         QqHQ==
X-Gm-Message-State: AOJu0YzuD9qvpjEGcYoqL3geLEZcn+zcTDpBE2gbxfyFDMbsf1W1wpXA
	T6PyqnEa0dATuYXNmVdV4PQn7363zJndr8uoSdZXd+FR6r0p+TRh0jBPgWmu3/5BZ9kJMs6sT5K
	fN9K14Bo=
X-Gm-Gg: AZuq6aKOviMYRd1wZb6C7TeEQSuYxDQHSvxhq0xiA42WIMlpy1rfSLFU6TltIkAwYOM
	EmsCqxF8RmZyWXICPd7h8rTDZI7ajBGMGAy/d6dHR3ZgpS877VDJUdWqlmtAhd3pm4mm3wEdL+h
	rF3MctNlnm2vRswicfVcljmfPSTadKOAgLX5/826LtUeGkSQvmU77l0kiMcJBRJbXNMWvETOXuS
	Pqiex/GJo7CUMSynJd21YUsG3qoV5kk+MuEqQnlpAGrQTeCpxYbW1GkkYV5+oAD57SjlyPmaUR4
	EkfFKQaBZ19o4jVQJbQMDMgImeV3D6gdjFcgVF3YjH/h5Bt4VTJYAZ42NT5WSkSEeUiuNfISyCU
	Jmo/bprUs4Uq+Vjhnu8A89e0M7z1GV787vB6P8hfc1EOw/2yomcjZ0uNSE6fIsHEIArf2x8M1jC
	Lyk9bsXRuX5GSa4eNfu+8Rm1usn5sIK1mVD0+kbE/pizCIkSPBLtEmqRS9Gbs0n+6CSkNglC91X
	t2ORQpzziSB9cBeSg==
X-Received: by 2002:a05:6214:262e:b0:894:2c12:aed9 with SMTP id 6a1803df08f44-894cc7d0a73mr44033686d6.5.1769552010256;
        Tue, 27 Jan 2026 14:13:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a9bdbsm5195396d6.11.2026.01.27.14.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:13:29 -0800 (PST)
Date: Tue, 27 Jan 2026 17:13:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/18] midx: implement MIDX compaction
Message-ID: <aXk4iIHRu3mPxY6S@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <13336e864f4ed3a6954b782f0bcc090d92ac722c.1768420450.git.me@ttaylorr.com>
 <aXhqroubXFbnBgJI@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXhqroubXFbnBgJI@pks.im>

On Tue, Jan 27, 2026 at 08:35:10AM +0100, Patrick Steinhardt wrote:
> > +	if (!from_midx)
> > +		die(_("could not find MIDX: %s"), argv[0]);
> > +	if (!to_midx)
> > +		die(_("could not find MIDX: %s"), argv[1]);
> > +	if (from_midx == to_midx)
> > +		die(_("MIDX compaction endpoints must be unique"));
> > +
> > +	for (m = from_midx; m; m = m->base_midx) {
> > +		if (m == to_midx)
> > +			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
> > +	}
>
> These new checks all feel sensible to me.

Thanks for taking a look and suggesting them in the first place!

> > diff --git a/midx-write.c b/midx-write.c
> > index ca2469213e6..afa077a09cc 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -1120,12 +1216,23 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
> > @@ -1162,6 +1270,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
> >  		die(_("unknown MIDX version: %d"), ctx.version);
> >
> >  	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
> > +	ctx.compact = !!(opts->flags & MIDX_WRITE_COMPACT);
> > +
> > +	if (ctx.compact) {
> > +		if (ctx.version != MIDX_VERSION_V2)
> > +			die(_("cannot perform MIDX compaction with v1 format"));
>
> Right. So if the user has configured "midx.version=1" they cannot
> compact.

Exactly. I think the limitation here is a fundamental one, too, since by
its nature compaction *must* retain the pseudo-pack order concatenated
across each MIDX layer in the compaction range. With midx.version=1, we
don't have a way to express that information in a backwards-compatible
way, so midx.version=2 here is a requirement.

> > @@ -1354,12 +1491,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
> >  			ctx.large_offsets_needed = 1;
> >  	}
> >
> > -	QSORT(ctx.info, ctx.nr, pack_info_compare);
> > +	if (ctx.compact) {
> > +		if (ctx.version != MIDX_VERSION_V2)
> > +			BUG("performing MIDX compaction with v1 MIDX");
>
> Isn't this `BUG()` redundant with the above call to `die()`?

Technically, though I put it in here as a sanity check to ensure that
any potential regressions with the above die() don't cause us to get
into a worse situation that would result in bitmap corruption.

Thanks,
Taylor
