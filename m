Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003258;
	b=sZwyZfgWdfy2latISiIumlWQu5GAE5DKDLXQ4x4LXlPCDPy50rIPVedMj10oCl5bPZVi
	 +hpl3uImAocfuxiQ+6G+NOOpCipcx9/CnwCdsKjEzZG/wW1yDSY0mX02ZbtqO4HR9FUrz
	 TIIjok7+Qqx30Q7+UCs8oovX/hY+hN3d/w1mNMLiaYurGWfpCr+3wy/zuynKGyFKml6Xm
	 g6Mv6m1ECfeVwKUJ1xTKZPgq9nG+EqaP/1jInDPxwpASi1Y8KguK+EfzqgwBFZxQVl2XU
	 keN9ojA0sOctLLwNDAnJBjA96szygXPQRQ0e5YuJjNkQCKn8BPEya/83se8vbrKe1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003258;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hHAtRCIpQc2kT7UgM5JOeoIgYyQIbGnOLE4tCTeT10Q=;
	b=dJ5yRMix1mdjWUrOyQZdJYXDCJRJQEkQADYWGcNgNVbe1EqXhxPtYe+95ZvGi+lutVVz
	 ZJkSBJw06ZnSm3XVxM4UYYa7t4dvHCTtrlj+JGxZ8AmBjKHgZV8ZmQTwZalxwxqKemX3O
	 m/AemHef+QUi3SatPxLVtYDI53o1yGAuZkO1+R1hFvgoebw4mbtKlr7sQcQ+IxrOk0lwI
	 vY8PDToNjRgBfWIHgr9EFQwv5WNaJ9TyOsS/i4BDO11g+uukHaU9IituHjX2YdpsF/c7r
	 ecssTzESxLictyaWl8uzisdO47T1EFokFkeITaPzj6j8v67lHmA8pvlqEBwPhcHMMTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=aNKDWNWO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QB8Uz6m3;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DA606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 450DA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=aNKDWNWO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QB8Uz6m3
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65EC0140016D
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:00:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 07:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795003257; x=1795089657; bh=hHAtRCIpQc
	2kT7UgM5JOeoIgYyQIbGnOLE4tCTeT10Q=; b=aNKDWNWOQM9A0GSDx+Y3XGSuVK
	PflNxSVrcJTPnPxyqc0FGid/YVdWyom+Ls/lIMrknacGcQjVa2nVMy5aoRj95uZl
	E1sOctB03ypjtnID8qkH/ZNkfJnUdwh+E3JzPby4KSKZOZkYRd0QvqsINVR0RMDW
	MPpY2rG7KnsjNEhpmSTcdsRLI8iWIp+Kz0CGMI8J1FfZOvWAts/YlIY/Ut0/WZQu
	HOLQq3P33ASQMlrTUWMxCxGKmUVSQQWs+wC1Xz3YynRkSV96InwF7hcYwD4Gskfp
	t14rz9Z36ClPIOk3sHl8XLkUqCAbFpTwaiMANT5xPsTmDg5ARxw70nhZfZrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795003257; x=1795089657; bh=hHAtRCIpQc2kT7UgM5JOeoIgYyQIbGnOLE4
	tCTeT10Q=; b=QB8Uz6m3mJqN1PRpoaKMXWoiXlnYFbwVcb0D1HNgKPhmXFlAOdx
	K2rXmglXbam9P0HNTBBNkfmZ93c16w8UIOYBQlpu/njQND3yJcoWxK8m3jXHqKD0
	oP8pQDbg5Tw5l29LLJPn18Mqs7M71BZ6uXnG5VnHSv8Q5eULjzvbGgh7LV8vJqeh
	aX8RUQdsm/JRvVyFMAVqp9Qc6dzb4TsKyaIknKcTu65u7Cy4OU6OepQJySFoCQST
	CgRi/0HcWgZ30kzGmqXslc8ju8j6kIwB0eowpeZefk09KpfGnlCCVbW4VCovTyhR
	9jwD1s3S4JCYtbGO1oBbV1cRTaQ1jCKxVzw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795003257; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:GAia3v+ONqiDYZssNDIDyENCAOA3NoIVOg6jIt7RCAnfQ19
	FQ2wHYdSO7pqLcyTzl+f2o74LYYJerT0nhh8d4lSbtOCg+sl5Aj5x+RzXOAbXl9p
	8PKRYC4rvpp1GqXvV3IFqX4dDXpG3TTOgVdrXzUapuKwl+TpYXAHrAnb9Rkr/6iq
	LOWzdmyE9Vc5uJpA12mgEA6GycFRqIEwIfu054brl19LS2YUh/wlLRlRQ7JvISs6
	EfIIZoVhRY9jwjn3GIAJ53B+/dyc3yJYvIu5UzejOkzG9fr3PnuMyZiI0c+l1n7h
	W/5o9ijLVcLbO4/+8VZog0k1RVtXxlS/Yywo9yQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:je37eFRo6qTUGM9e+s3QaHKPMngfQzE2jTGeA2Rm1LU=:GFbMrTeIZTt5NFetG4AIs0HBzO0CcoOqL0weCmZGZdE=;
X-ME-Sender: <xms:eZP9akA6SyaK2C6yrefriMRbSV4t_vrgWSGXxA1kjPTDvQk8vrVXXw>
    <xme:eZP9atYzijII5MEwftQfLgEb_d3YVjhg6r2bpiZ7JSsY9ju8vnJs3SO7gzePBKTGJ
    mkXAY83TNY2deyVqNl8m9cJYcZhxmLNMhkjEEwCe2SpVlUJU9iLH08>
X-ME-Received: <xmr:eZP9av7oxK-sig2QlToYElKHK5wtd2DeUGddEh5Pa4U5qdURuaAHHA>
X-ME-Proxy-Cause: dmFkZTFCM5iiH4Kmok8iNlF4BVdAXtMGfHbl+RQzLAFX8ZpxyOOhDVMQb16C5gYhyfZAFY
    hJBRws2VpxcLnMt1ouCejXDt6H+xO0pcffkClEyHNeV9JTP3EHOD2RvhWfBJAM7Ldqz+tT
    slU3UNyBi+BMoTNiBZSFmH3OjFq7+SyvR/MLqATUU56N0alC0OrfOdf3cjtOLisRqRfSDn
    EfcxAysOPB5Z6vO67ILif3Dr8840KZEOfn2C+wm/vIrKLrZPRNdItPubQ9o6W9a/FZO5f5
    U+Dch/miwW1bo4iMWvcmrptfy+3wVBsBHjEaFOfEXHEPigS7U+ffz4ygZQ+bdtdzNkfwB5
    fh262yw2eoeXqbyV1of6I8jfFFee6l2VtJZemwvBoKdcGntfu4XfejJbMdzeq6zP8Gsnft
    YQGtLL+MGlHW/W1rcH5dNp9O/ZlMTwclUEsF5agrzYzuH9ZsGh2VILa3COs9NYsgEoGvis
    cTgV3Jn5kwqDLcJXYpBl83JkjOV6t9LH0Qv8EbA81V8HT70sthsvZGvelRVTPSYQIkfCEu
    AbNPOAtya0queamgnZkvZmiaunyRBX+TBt3DMY8+Fi7QxtUOo/ljMrf5enCOoLw+7EjBbD
    FKZ5ZFyM3trw/K+RkVqtxhX+WncgbipK7xLW6GKwRW5+/CHQlWaQ2E03qNjw
X-ME-Proxy: <xmx:eZP9amaS9FPACSqQrDlp4xyz_x2oQlO89zWxZ0tcLZX3empsPR5jnA>
    <xmx:eZP9ami2xxk7s0H8Lk6BgKPihriS7ItH8qLcwUI1ySvWhTe6Ix_nfg>
    <xmx:eZP9av9zxsOOAq7eBpDxhZzs4rFk8lo7MFkXU8-nEJTr8fKbhthokA>
    <xmx:eZP9aprFAw8yAR59nMIbgL60zNYXCIcLpUU0IbFaeLDmFxgNUGQUwg>
    <xmx:eZP9ai6UUjkrL1amwolH7ljDI6m_q3sWUcU6eFMijw3gk31S56jUSoSU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:00:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f9a9e77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 12:00:54 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:00:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v3 2/5] http: add exponential backoff without Retry-After
Message-ID: <av2TY6Oqm-LzA5NW@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
 <fe1e847dede7579da911b5a9ba16c806b5332723.1794022836.git.gitgitgadget@gmail.com>
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
In-Reply-To: <fe1e847dede7579da911b5a9ba16c806b5332723.1794022836.git.gitgitgadget@gmail.com>

On Sat, Nov 07, 2026 at 03:40:33AM +0000, Ravi Mistry via GitGitGadget wrote:
> diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
> index 792a71b413..8e7538ab76 100644
> --- a/Documentation/config/http.adoc
> +++ b/Documentation/config/http.adoc
> @@ -327,9 +327,14 @@ http.keepAliveCount::
>  	`GIT_HTTP_KEEPALIVE_COUNT` environment variable.
>  
>  http.retryAfter::
> -	Default wait time in seconds before retrying when a server returns
> +	Initial wait time in seconds before retrying when a server returns
>  	HTTP 429 (Too Many Requests) without a Retry-After header.
> -	Defaults to 0 (retry immediately). When a Retry-After header is
> +	Defaults to 0, which retries immediately without waiting on every
> +	attempt (unless a Retry-After header is present). When set to a
> +	positive value and no Retry-After header is present, the first
> +	retry waits `http.retryAfter` seconds and the delay doubles on
> +	each subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
> +	capped at `http.maxRetryTime`. When a Retry-After header is
>  	present, its value takes precedence over this setting; however,
>  	automatic use of the server-provided `Retry-After` header requires
>  	libcurl 7.66.0 or later. On older versions, configure this setting

Okay, having exponential backoff makes sense to me, and we do limit the
maximum backoff via `http.maxRetryTime`. What I wonder is whether it
would also make sense to introduce some jitter, but that of course does
not have to be part of thi spatch series.

> diff --git a/http.c b/http.c
> index 0308f973a6..8a28cd0fb3 100644
> --- a/http.c
> +++ b/http.c
> @@ -2411,7 +2411,7 @@ static int update_url_from_redirect(struct strbuf *base,
>   * Returns a negative value if configuration is invalid (delay exceeds
>   * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
>   */
> -static long handle_rate_limit_retry(long slot_retry_after)
> +static long handle_rate_limit_retry(long slot_retry_after, int attempt)
>  {
>  	/* Use the slot-specific retry_after value or configured default */
>  	if (slot_retry_after >= 0) {

Nit: a bit weird that the number of attempts is signed.

> @@ -2437,7 +2439,14 @@ static long handle_rate_limit_retry(long slot_retry_after)
>  		}
>  		trace2_data_string("http", the_repository,
>  			"http/429-retry-source", "config-default");
> -		return http_retry_after;
> +		for (int a = 1; a < attempt && delay > 0; a++) {
> +			if (delay >= http_max_retry_time - delay) {
> +				delay = http_max_retry_time;
> +				break;
> +			}
> +			delay *= 2;

Isn't this the same as `MIN(http_max_retry_time, delay * (2 <<
attempts - 1)`? Feels a bit convoluted to have a whole loop for this.

Patrick
