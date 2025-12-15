Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC32D0C9D
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816000; cv=none; b=N+TvharpJKrXvND9/QAclWSZb+auWBdSGXpxfDzYJZYr7I3Cemwn+CTqSL881BFs39i/4QW1VBQKs38yUkp6Sq/G1iEEwUWxuIC3584YFDeuySTonsLv3F6/pedb/c+syCAYXenPZPgB9PtspS5bitenstUgRPTC635IgvrmHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816000; c=relaxed/simple;
	bh=KzOlVfwXcgVsU2XN89EDX17/fg3XjWjH9z1c+2ssRNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XODceI9dyc+43RnIw278H7CDTenEGJbdQA5DgXMG9zDG56cRVpvSUlSlNInYHu+ccZaEbfpXIPOIjEgQP75gmed7VfhHPHIuaUgXpmH6MAHQNG1goe3tIpXEj79a2J/Wp2eUxGpiNIO3hbxFU3CwwezMo9WGK+inwuWewgSKeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DixNRMrl; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DixNRMrl"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cae2330765so2466155a34.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765815998; x=1766420798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lzrQnsJHO8lGugHpbzDXQqi/enNrOIRdjnS/W9LbEjE=;
        b=DixNRMrl8U0Wa0sIy+hNslymQ4Op08lUYUmIx2akIAQWJ2WaLxQ5K40a1xnbY0I/l7
         sGtTEt2PUW+0cZvmrdDZWQ0BtyhKoCkW2rfyFljt9Y4DBFJigQ69dGcX2IoFPjJXLrE4
         gCCPgF4DpW3W33Xofz/qnWh6jR6H+5k2OSyoUOfUl8g9QV+g21BXqveSuTZ5gjS3faTt
         hy3JvNt8UaSj7iL1a/hf0Np3QU16q9Gk1nHSt7FtrVHBKO5h7yfwF5DRi8NBmrtNTSpg
         1j1+VRyjK+r4kydJvplLTczBFbkJkED4P9QBeVTxBw5G29twDd9mNRZCnmnBk3fJnMrQ
         65Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815998; x=1766420798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzrQnsJHO8lGugHpbzDXQqi/enNrOIRdjnS/W9LbEjE=;
        b=m7tTc4jcdUY+8kG9osyP+B+By/3paTrKLZ9YGFX6qKn1YgO2EoL2yqzMN7agEjZzHM
         WiVbfPy08GzDzIQAkDSTUhPuZAY0sWVG6IQ2el07RY9Py8sd34hGW/DJYBoxILOS7NNb
         2emDVghDz0zpGzol6DuDLw3kXVRtQ9O8XhmSEFE2v0Vfik+ireGFXOGXRG06RuswKJ1a
         +9T/bOFtx6oL+OszILYFCHD+rxuwtryHqw924PPRS/6QFs3wGGsxEOghgEZ44TrkRYMH
         DWcl0pK8/RyMPQpoE93FVksrTpfTwJUC/AM3UapDKoSkvzkhflCFUySJ8f+Co2khtiit
         nXig==
X-Gm-Message-State: AOJu0Yx1tX9d4AogDTUdF9pKlPZbTHCRgAz7vdO22EMc5tyN3ys46VnD
	qrMvoSKBoX/0y0fcq9AbpKHk1MGMk2lFrDKCM+TP3dHFhlklBbAN9KfC
X-Gm-Gg: AY/fxX5RmP3Ytdpgy4KkLpp0AeQiecQ0iVcmrYIhhxtC5KtJL6WBgN9QzLuehouSQ6/
	vySQzEceHXyKOYUPTiq4KoS8x/EK1aesdcIG3LN18oigzP2Kqba67Jq0MP6W0aUdYP7c8HGWCyI
	GXv8xgTIimVsBkFXtPUT6BXnmdGuWwJIGVJkEBVRbB7nLPW0rH82EuLUeE9kIwZkHyfF0+jqdVo
	71LcxcuEgkMp/DIMqia9UzYd/QCZA3LUowXOR/g9F74wsKfav3sDzRgi4h52Js0whx5h2PTFWIS
	ez8zt/BazdtBQYdjMB9RERCaR0m6uvhqUHcGD69//Je+4dcG6RndlR70S1BcFz100WEWfX2x0/1
	3uRmYPT6JbBSXq+Xy6Kw9KKVMX5ZTu/9JtSxjGu4HOlDPXdTGKwgiE7w/STVEspxrbOSnCzPKWM
	nFINnq
X-Google-Smtp-Source: AGHT+IH8gQzdeeY5e3C6QnFiTnXiuDM9a/SuDY30S40VeqFvi81qSywvfXo/mtdI9hoXHeD137Xx0A==
X-Received: by 2002:a4a:b5c6:0:b0:659:9a49:8e35 with SMTP id 006d021491bc7-65b37fcbf4bmr5865730eaf.39.1765815997818;
        Mon, 15 Dec 2025 08:26:37 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm4481668fac.10.2025.12.15.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:26:37 -0800 (PST)
Date: Mon, 15 Dec 2025 10:26:36 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
Message-ID: <qi2ealcgo5lwjjhx3m3acc7mukwaaxeblnbu7fmyw3gqvu3wvt@hqdatbug7s6b>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-3-jltobler@gmail.com>
 <aT-dppZm8TsibzyZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT-dppZm8TsibzyZ@pks.im>

On 25/12/15 06:33AM, Patrick Steinhardt wrote:
> On Fri, Dec 12, 2025 at 04:36:39PM -0600, Justin Tobler wrote:
>
> All branches use `xstrfmt()` with strings that are essentially
> constants, except for the translation part. So isn't it possible to drop
> all these allocations and have the function return a `const char *`
> instead?

Ya, that would indeed be better. Will fix.

> > diff --git a/strbuf.h b/strbuf.h
> > index a580ac6084..a5e3ab0cb4 100644
> > --- a/strbuf.h
> > +++ b/strbuf.h
> > @@ -367,6 +367,15 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
> >   */
> >  void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
> >  
> > +#define STRBUF_HUMANISE_RATE 1 << 0
> 
> I think nowadays it's a bit more common to use an enum, and I think we
> should also document what the flag does:
> 
>     enum strbuf_humanise_flags {
>         /*
>          * Frobnicate the string.
>          */
>         STRBUF_HUMANISE_RATE = (1 << 0),
>     };

Will do.

-Justin
