Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED02ECE9E
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817256; cv=none; b=NcDwr86sk48dm5DVr/EeAAtBViqxhTGvzA8ZoGYGApJ5PCvdrf7FpLP3T+J4MuEtwZE7azemxm/GoY3+NrCIpw4ed1rPoLzi46xq0FW39AOwS/QwNWeYHcqV7zjJtAlq/jv4wOcse338darQAp+uJMTjcOqRd9CdXkRTwXNMFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817256; c=relaxed/simple;
	bh=lEQwp+qCWVDnb9QdZmaWqbkTnjYQSlKHIWLipb043zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwrtFJXjGw751lXwwdfRzx7tNdVBe6+WBlxXcXoeY/PEpL2x1AWFCW2GGN/PijoY3i8A/x0aFxgiXAsr36S11grr+HQmjET8xf5nOVu5l6OLGqrNV6R8+RGoQeYxC68Jq8gHRMOGf3rx7lXnDrOZ2GooGSE8xJb+UHBRQtwuPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwEZrmsk; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwEZrmsk"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-657044fea68so1858970eaf.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765817254; x=1766422054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GiBr3OKGaL6AU8C53cwipg4cywX2ObNkohuIqeKh8WM=;
        b=AwEZrmsk8R0tlXDzRRQ/KzfVd+JR0A7NE5k3kRewpA8i0iUVo6yxAMYiOzIrCyHtOh
         fsMXwrQZyiRMVGAIcO5/e+BD0gQb8wVt6cAIUitNUcKHTAsqaW6m/DncpplBEX5iTao0
         Sbkp4VrMqVA7Y0OaWxWyvmC/IK1Hg0fCXllRl40A8aYTi3Wbd5LmE1u7lkbxQTQFDA9L
         dvJOIRNY8jZdKO61o6DdoujAdn7UeKv8IygMrbVfKuiAlOr1ktwmYEj96Btsm9nfZSif
         qRDMX5QHvPohwoXOP1PuiF/1H/MF6voyuaz6BF6Zazval53q/Uhp2O7NKOlQTZZWcyEM
         ML+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765817254; x=1766422054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiBr3OKGaL6AU8C53cwipg4cywX2ObNkohuIqeKh8WM=;
        b=CL+M4/7KqYNZpLBZ1KTt+MkQdxaOK0bDvG9PPo8+J3ndhCXK+ysXByjmX2MdVZ1jm/
         zkW+w2jwWu9aK7xSDHpxtva05804iIEwzKk7Ns+7+1J1sHlgV5vdnCS/heNhf7WXsoEZ
         Uo+04L4jTxiBdQLcAB/7dQnDyGM2a0YKviuHFr0foJlM3rMQQyYbE99mnTanVz+f9djz
         D8edfwWozDUyZRLzsqnPBstfqbbHyWcFSBCDtLcs64BbaJBvKCM5RYTWEnd/jeFbaJ8a
         FLceCptr0d7jcT7pw95MbVyHOk1B/4ttoRZSLyzPd+iTTbG0fRoK0xFpHaXc28tt40df
         +U4A==
X-Gm-Message-State: AOJu0YyMZ8Fkg32pRYPt8NlXVlFUpn5YJc6Wsnl3ZGFHh6/WX+Y30wKV
	jS3HQBQ3LUpqpX0QAAVb9cqKSy/XtP2tyIhnlarnXizLU8DOzIp2/sPF
X-Gm-Gg: AY/fxX4M7gFLWDYPq/S3WtnUqOY/Qa3uu6OQ4y/wk2YkpqI0P8yhKRWeMhr6oPOBxNy
	UsQp00aAJ++9KPRnR0A+Z1EJFESEXEYsATwR4WIkNrOt+2HeK8us02IvExWwax2hEU86rdalcJd
	+O0t3fC82cO6oPDKhe3I9C0M/5PdE3AgRYLYLBzLturre/xnfAAD9qr8gPwzRg+CFsZrL6i5tDO
	djDNvob8obRdqqvahh/USerdP7zMtOSMKk88Q6n5XUuR8sb1WixfLviLqENtnmkvslVfZ9WDRn9
	YQnV1nXWOMyfeqW900tFZABEy3pxxRiW1Hz2AJPfbezSxJ/EeQw2ZLpWBTD3IjW/x0xNLBQ+0Dw
	gd9w0zsJyXPC4cf11v3iu1UAK2+WuWDoz87jl3fZ2NNL1x7M+OwH4qiXYdU7yOGP10HFGEw8GWI
	o/2xXK
X-Google-Smtp-Source: AGHT+IHbvjWkFwaXgYE+JXtLVseMXOLESFtlJk0TQg2D2jDHG5fkFj20/8EdRjaOIcySGFUyjKniWw==
X-Received: by 2002:a05:6820:1888:b0:659:9a49:8ee5 with SMTP id 006d021491bc7-65b4523f950mr4379801eaf.25.1765817253762;
        Mon, 15 Dec 2025 08:47:33 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b35f2a9bdsm8188647eaf.2.2025.12.15.08.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:47:33 -0800 (PST)
Date: Mon, 15 Dec 2025 10:47:27 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
Message-ID: <kx3qdkm7rbd23hc66qamhq45agzofoppfhqnbbtw5cmjojevsq@2kkxiaem3fp4>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-3-jltobler@gmail.com>
 <xmqqh5ts88b1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5ts88b1.fsf@gitster.g>

On 25/12/15 05:21PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
> >  {
> > +	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
> > +
> >  	if (bytes > 1 << 30) {
> > +		strbuf_addf(buf, "%u.%2.2u", (unsigned)(bytes >> 30),
> >  			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
> > +		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second and gibibyte */
> > +		return humanise_rate ? xstrfmt(_("GiB/s")) : xstrfmt(_("GiB"));
> > ...
> > }
> >  void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
> >  {
> > -	strbuf_humanise(buf, bytes, 0);
> > +	char *unit = strbuf_humanise_bytes_value(buf, bytes, 0);
> > +	strbuf_addf(buf, " %s", unit);
> > +	free(unit);
> >  }
> 
> The old "strbuf-humanise" used to treat the whole "<number> <unit>",
> e.g., _("%u.%2.2u GiB"), as a single thing to be translated.
> However, the new code requires that in all languages:
> 
>  - Decimal point in number MUST be "." (don't some Europeans prefer
>    comma instead?);
> 
>  - Number MUST come before the unit;
> 
>  - Between the number and the unit, there has to be one and only one
>    SP.
> 
> All of which could be a severe regression from localization's point
> of view.
> 
> The first point among the above three can relatively easily
> remedied.  It is a bit more involved, but it is possible to fix the
> other two, too.

The first point could be addressed by just making "%u.%2.2u"
translatable. To address the others, we could have
strbuf_humanise_bytes_value() output two separate strings (value and
unit) instead of appending the the value and returning the unit. Maybe
something like:

  void humanise_bytes(off_t bytes, char **value, const char **unit)

We could then have another translatable string to configure the format:

  void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
  {
    char *value;
    const char *unit;

    humanise_bytes(bytes, &value, &unit);
    strbuf_addf(buf, _("%s %s"), value, unit);
    free(value);
  }

This is certainly a bit more involved setup for translators though. But
maybe it's ok? I'll move forward with something like above in the next
version for now.

Thanks
-Justin
