Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003281;
	b=iaLPL/ZLxFkeuKy3Z0CjQWHLxxkoxR3Sl74S2FvIsqLOILdYbTNc+QF85Wk8yxF1NGXD
	 858Hw7e8hc8nIp7Ge4AFcF/FA32MzzO0BQ0kYolVyqWJy0xeKSlLkCbvYKINsjNs8LnPU
	 p+OyJrssKEJkUUzSZd0WN5yiZGau8rJ8OuPVyEQPzu1ursgIcvnZZ8vkfH98ItjIXk6vd
	 sKqVYXFH2Dhtl00JOx82XTEOsAlmoSMcHFg8L/bmPsmOjmnxHhfxMMbSQDzHM6hu6o/zA
	 jlyU1HH7anOfu949BP1nDk3JVhnanS0HVMrMd/AbqizWzGfSWO1j5ThgjtpyjrE+H3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003281;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b6GlORlQBYnoEzSN3B39RDvvPrfCqukWosln2co+3Jw=;
	b=P7ve9t7caM9CIt2aa2y8NN5DlvQ7hASguKLBQRP5O0igotroOxtf6O6EHVX6UomN44oD
	 S2jP8OSC9N0jnu6fYaKB2PmCSf9AVGh+bSZjrIC9POabZSgreHJ7DtgD5Y+W13ZJa3ub8
	 nG+oy1AjOvZLQov6n+MB3gzyeQkjmsjjzFDuhKamuTfG9aosfc3LLgdReFVsNTtrWoLJU
	 9cL5oBlKXrXvJbUKZNhYRFllhKkctnzZ0Z1aRGpwFxBSxcJKimE9I0Weqxs6vorFafQDr
	 wkeWKsUKD7npVpgmKsuVqESrcjTDqTEVqW+B46AZ0T3ES6lFu3PpERmLZPbzkJ1vW2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=m5i5jCHd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KmEbsifv;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B364606A325
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B364606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=m5i5jCHd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KmEbsifv
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFBC6140016D
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:01:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 07:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795003279; x=1795089679; bh=b6GlORlQBY
	noEzSN3B39RDvvPrfCqukWosln2co+3Jw=; b=m5i5jCHdzmn9LOAIsR9gNuh+NC
	aexZkcpyuQvzH3sffxENPoX3zhOjlBNViKvKR73HYRHn//9fthcjNwcKypbLPhrf
	W0dauidUBImHzvelh0BPOoVyaDb2rAeee0X2EtALKE6cLRhveRiBUzT+dHwgrQ4h
	MGdZ8aLU7LBrX5+Yv3FvZ07uyLVBCutFLBQ49qHS8psupqyZwtnIf9p1vWL71qRP
	gqaxnKGwLDHMkMkW8ll8rvdI9kzg+5JmzhpLzupr7i3/rQpNaBjId5baR7RzCuJq
	1c7IiqFqiT2/hOnWH26AdR6mfqQ5fu3UpHcDnwWOAE+W9AQQCKU6JuFQIvJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795003279; x=1795089679; bh=b6GlORlQBYnoEzSN3B39RDvvPrfCqukWosl
	n2co+3Jw=; b=KmEbsifvdzXIIq+gYB5IYYU9zktUQb5h0s847eRGJjffSi4F5zy
	ejoOOxbs5nGjdQJEx6K6GtDaWxdCSzoqNJej5pAyDZ5u1toqz9p55Eyg89FdhjWV
	z/ziwMIWYSrwv3bf1g36xBDjhJ8Rc5IGe6So7KfnNwzWtx+r2XVrtuUWK/lJ5lR9
	QstilWLvgDw7cxkZU8Rn+DhI6nDw54SPpWQTnfBXyV4IOw1IS3dBL3SCdIwoqmjr
	rynEenGuTnxNn+H3O2qo44h/la/zFYhj3nCPoNY6op2Q4sT9P0XK0zqOK5aYQKf8
	4Ry4LqI6zAaXfQPwKmTboSG8WDIqD66jEjA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795003279; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:nrYCKfpJy953seBbFXbpI+CUv9yIdqqoejgVrL0X13IFFBc
	R46n4J1iVXJXuo1RYoHngUf+v/FOVxwL8311BMOZuEe/fSflUDczIfw8KVO7pI50
	DlkJlb4sr3VVBVVjwKT6619lTIeQIxR6rdFgmm5APtlDxNpuTybwts1efZiSUVMk
	x6sfB2yp3ckBuiJvrmpYJpvMavTf+ug4H57MoKQlxYAyP/EGW/qAd8ZACxGyfxDD
	4o+Qx6rlBcx7xJ5JmTcugIgHZnL1orpcWQBuGIXpgPibySCwzaK6WlNirqYKFnkp
	dxIyLtlomgUS44LfeALdkqsEeTVhj5BvKnt2+nQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:825efnKSYh8gTtPoDS55dxA+4T25dsGt05UfQrR/1Bs=:8FVchxkh8l4GCC7PDXcMZcn7efurgpRu2Srd+b0sEus=;
X-ME-Sender: <xms:j5P9antdZYPjLIqjdQpDpD7S1LETpbzOIlkEOWXLmMRBfcJNJ9SADQ>
    <xme:j5P9avU1tvaexY7BR7AQAO_soy4UOnfPyEbTN0hE4G8Ob0jnqfVeXbj8eqJpMI2Lz
    jfxif6NQUeQhoTLl8AFqbCKZDoncMRObTDvnbz7eVIsTeJUJHQPta0>
X-ME-Received: <xmr:j5P9ajGq_ZZTfuuqWHxr6RbpoCfpgI_zp7cLzw78aPc80woDuX6OSw>
X-ME-Proxy-Cause: dmFkZTGviHgodez/NBhw2rxHqKSGBH3zOq8hp5TDS4075DhgsSx9Q2hMfcxSve7o0DavAF
    To48ZAy3NAAKvQOYLD+yJXMmyt4rJJhM8az9ujd1a55+a3SlRy8mXH5SOPvwCYrw0NHQPF
    MRioCPf9nI/tLlKDg3K9bbvoZgfIG1SF8RAFfbM5+pixa89C6xPTo4lTSkNwhYY8VWsqlV
    /BjinDVVp2BRPjA/qabtNCDGJD8+n6Kc20RqrM3bviBd/C+JWFzTAOfpO1k1TguM9DHN3R
    /wHAqYVuyPC0TNaQBtRJamuNnmEt1veXBfykUwd4cppEoUuTI6Vk+kmzNiw2engoMnhINB
    v2/LgNxD13WcjX33/WDIn19olJxkBpOy7YacUQHX7+XyohHkL7kV3SPsbg6mXd8bc6lLMc
    HpUrHSKOvmDWDPMcokwixDxQpDXLSuCGoNQOMIQwPth1hkQ0uTILX3WD11t1D/1z0HeU9N
    dc0eXB/yZqIrEVDJl1nvwPNZTC7NewPuFVOFjglGDxyUsY+Zj4ulUnwcC7pxA0MNqCrSH1
    //LK0DNf3HCPuB0QxSlTAPDPJr9gdnqffESaWhAJgHSqKgcfo9hZerQ7kcQ751hvAciezn
    2RVKK8tkCe9U3D0juICZQrlj3/roFJkN1qZjZaTdKr3qYVt8XkeaAO8qvvLg
X-ME-Proxy: <xmx:j5P9ah2nthm4CFrdejs1r_DMuBVGeJpXJ0wAItNLTPbM8GIGapfmcQ>
    <xmx:j5P9alPyunbxYOP0tkkBkXt9hQuVwoaO4JUOnUJd52TmWEp83LB-nw>
    <xmx:j5P9ag4Z0OWnvmQZePEeDQo_OZ4vdsPVIzyn69Ehf7Yfa74LFHSSFw>
    <xmx:j5P9av2GPmPd13P_x2sGUiGEUTHiYgGrlhVijxBtBuNxYLv_hfOLWw>
    <xmx:j5P9aobKJ-utneQrmymgdFxMGYNGxiWq394VCNhoPoOokk2j9FFhTfcH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:01:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc6e7da1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 12:01:18 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:01:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v3 5/5] http: default http.retryAfter to 10 seconds
Message-ID: <av2TibWYq_fHjOli@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
 <61e3ffe9ab8890908eb76c37fcdf4e44654d1bd9.1794022836.git.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e3ffe9ab8890908eb76c37fcdf4e44654d1bd9.1794022836.git.gitgitgadget@gmail.com>

On Sat, Nov 07, 2026 at 03:40:36AM +0000, Ravi Mistry via GitGitGadget wrote:
> From: Ravi Mistry <rmistry@google.com>
> diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
> index e7fa251b65..aa86bc68d5 100644
> --- a/Documentation/config/http.adoc
> +++ b/Documentation/config/http.adoc
> @@ -332,16 +332,17 @@ http.retryAfter::
>  	set of retryable status codes is configured by
>  	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
>  	Requests) by default.
> -	Defaults to 0, which retries immediately without waiting on every
> -	attempt (unless a Retry-After header is present). When set to a
> -	positive value and no Retry-After header is present, the first
> -	retry waits `http.retryAfter` seconds and the delay doubles on
> -	each subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
> -	capped at `http.maxRetryTime`. When a Retry-After header is
> -	present, its value takes precedence over this setting; however,
> -	automatic use of the server-provided `Retry-After` header requires
> -	libcurl 7.66.0 or later. On older versions, configure this setting
> -	manually to control the retry delay. Can be overridden by the
> +	Defaults to 10. When positive and no Retry-After header is
> +	present, the first retry waits `http.retryAfter` seconds and the
> +	delay doubles on each subsequent retry attempt
> +	(`http.retryAfter * 2^(attempt - 1)`), capped at
> +	`http.maxRetryTime`. Set to 0 to retry immediately without waiting
> +	on every attempt (unless a Retry-After header is present). When a
> +	Retry-After header with a positive delay is present, its value

So we ignore an explicit "Retry-After: 0"? Shouldn't we honor that
in case the server explicitly tells us to retry immediately?

Patrick
