Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C1357718
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580346; cv=none; b=TRWpWqAqoVLht/8Joo/Q2K5CC4VqndmUx54jw4+Gmal46QEf1jKlAllnxyy8y6VRHuRTAfg94UgJDbJRcdANh0aZl6fQc9Z4LeKOOKv9uPnVBnptMPcNwlFG+DokS+LL2pUa4WfMLzdwAaxcANQ95sTI5LyU4EuLPc/TavMVpeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580346; c=relaxed/simple;
	bh=pfZjCyjOK1SHTd/vfFZLBbYGo3h1Izr1CxRlGAIY+yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvfNnysXM/x2WqcrlkQoxdLnEUV0Y+c+AwI1mDHUM2qh/qwCpGk4UMLakY5lsqFXiFqK9EazHbQfpPv/l9NkAAJl69HHMNPDXkKuYnX+q80G4AtNjyNycmpDcm2Xr/je/BtiYU+ADTqth/cZyAL5rmj6MYMa7jixq3X368wMzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu09A0zx; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu09A0zx"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-44fe903c1d6so15779b6e.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763580333; x=1764185133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0uMcW/s1oyYoOjKlIlbbtrmSErE/TdyWmg1Li4800Pw=;
        b=Vu09A0zxXtq3RlWwalvCTXvNyvhbQsGfPRuJNhTQTauEVIM+eTPXPWdsqJguKP2kOW
         /ecC5/w9oyFX9DUProdgqw5S4NrVuJk+oKAY9q4w7r0WXv9JiFJh22x23YXbKDxHX9Bp
         rD9YPkewTt/CzZ7A9iOfnn5oNN1uSK58ljkTIzfbzhplBrzxtWmY6LM/oPyT6FfHqUxY
         iyrB0xAwLFUXZSUhSdLN8V9sEQwVlXN5DDWixFIFjr4J7OXU9H0dntkTzNMn9gsEv921
         du4Xgk0OkQNVabqk51SG1Pz8CUAr4NMaclSgunhw8HLHRjdZGrSBYOGd0bF7ibXrVOFb
         MzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580333; x=1764185133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uMcW/s1oyYoOjKlIlbbtrmSErE/TdyWmg1Li4800Pw=;
        b=Kud2SgmDf8ilNg7qyBnuNNHjaZvKidRsjI/KdzzyXp/x1C7uDeihhZwyFV4T40ANDG
         1mObOUwZtZJlDuo0Ukwd1UMCbsvyLrSrhj3639NH3Dyf013AsM0fjSofGAik2cAuc+Po
         eFqJgFaMgDAT67cHXA0QNIVGgWVVf0qOxvOKa4NuxYQmw1du2sb/H1y/PL8RaDKPUD9O
         4byJYs9SssmhctVPcNRw5XTSXJg2BOlztaql801GCISSVpn9X9ZnF850+LPysFMOv9l2
         jFt1VwpD0Vi/wEdLCdzU77HFlRciVpnugvf7Vfb7egs/zo9sw1Zi0czGPfcPe9bjlRK+
         iO7A==
X-Gm-Message-State: AOJu0YzcAknuBvFczZT00LvJ1Ov1saZEeFBa79dzHuJ/RIh8uApfY50Z
	E1FQDgmAtn9PVgigqHlTkwQdMSvpCc1CKeUd30PC7nD/Vg0mw5We+jhkXTdA3w==
X-Gm-Gg: ASbGncsF6zrZwWIr4uCi8lWvNfMG4iTVgLwOi+0ijxKFqhWzgP05j3FzqTxFJWGkNg5
	rX7Ow+kcxoeKhJ66+T0Mb1NDLqOeDA4XMWcMRO29yeuFY1rq58Rv4/S4VfpOlEay4KbE5QQfFST
	xFNRXW4jJ9MO34XPX6Hm7uRocP7P5ieNnMCMTsJUPqjcdiTMr+5StcQ03bJF5umSFrdEczdPZx7
	UcdEgNHSTEY4QXqdJbfQ7yA/l9nE/UYLKzehNBjgwOyvAAqjKPp/FLlSfRinAJtmEb074oDdxAL
	Hu1JSsC+2YUrCIbhSZ3rK/lRa1JY+/f0jZzmpCndnXSLDd9UjfcVQnz5lpAOp7PBCqNQVBU3ksf
	CdZTSGA4gsYlBCtWMed/hNtm2EEtNvN7UjKMzKq5HqtvgHsbfT8OQhxp59KUFOKfXOlYDrkjz7N
	oh13HyVB2XoqR5jIY=
X-Google-Smtp-Source: AGHT+IEJPo76qMz+8l8eDXsDydYzoGerx+KG52eyGU+txDVkUuAB1UIYdpo2FFyH1lIY3CyjeVLaTQ==
X-Received: by 2002:a05:6808:4481:b0:450:3e21:f567 with SMTP id 5614622812f47-450ff3d3998mr222448b6e.56.1763580332703;
        Wed, 19 Nov 2025 11:25:32 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a384a6sm152802eaf.2.2025.11.19.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:25:32 -0800 (PST)
Date: Wed, 19 Nov 2025 13:25:29 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/18] streaming: propagate final object type via the
 stream
Message-ID: <cuvoz5gl7d6xgj757jgb26kj3qeunc4w3pg72it53zi6rs5lka@2nc5x4b2e3eg>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-3-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-3-adacf03c2ccf@pks.im>

On 25/11/19 08:47AM, Patrick Steinhardt wrote:
> When opening the read stream for a specific object the caller is also
> expected to pass in a pointer to the object type. This type is passed
> down via multiple levels and will eventually be populated with the type
> of the looked-up object.
> 
> The way we propagate down the pointer though is somewhat non-obvious.
> While `istream_source()` still expects the pointer and looks it up via
> `odb_read_object_info_extended()`, we also pass it down even further
> into the format-specific callbacks that perform another lookup. This is
> quite confusing overall.
> 
> Refactor the code so that the responsibility to populate the object type
> rests solely with the format-specific callbacks. This will allow us to
> drop the call to `odb_read_object_info_extended()` in `istream_source()`
> entirely in a subsequent patch.
> 
> Furthermore, instead of propagating the type via an in-pointer, we now
> propagate the type via a new field in the object stream. It already has
> a `size` field, so it's only natural to have a second field that
> contains the object type.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  streaming.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/streaming.c b/streaming.c
> index 5ce6350123..9596a94c58 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -33,6 +33,7 @@ struct odb_read_stream {
>  	close_istream_fn close;
>  	read_istream_fn read;
>  
> +	enum object_type type;

Now we are storing the object type in the stream. This avoids having to
pass the object type pointer around as much explictly. I think this is a
nice change.

>  	unsigned long size; /* inflated size of full object */
>  	git_zstream z;
>  	enum { z_unused, z_used, z_done, z_error } z_state;
> @@ -159,6 +160,7 @@ static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
>  	fs->o_end = fs->o_ptr = 0;
>  	fs->input_finished = 0;
>  	ifs->size = -1; /* unknown */
> +	ifs->type = st->type;
>  	return ifs;
>  }
>  
[snip]
> @@ -496,6 +495,7 @@ struct odb_read_stream *open_istream(struct repository *r,
>  	}
>  
>  	*size = st->size;
> +	*type = st->type;

So even though `open_istream()` returns `odb_read_stream` which contains
the object type, this function still accepts an object type pointer. At
first I thought this was a bit strange, but `odb_read_stream` is an
opaque structure so this make sense and is also what we do for object
size.

-Justin
