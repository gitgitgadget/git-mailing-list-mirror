Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717251;
	b=vLx8iEg2qsHx7vn0Fji8ZO8BD2cwggKJKtm5sil5a4bXXlXONAiMlAjuIbFbRaa2Dpon
	 5udkiEToFSdEBL2a2jYzxpos3g+gBn2647Dfwj3MT1/Y1/V2QgSE3z+esWI2z0V6363Ej
	 kcUrFfPvQknpq92lZxlb+B46U+07kR+PJan5m2dbsHgoE+nB3J10yEaN6wo4cXGU3QF5b
	 hBQ4eqoD0M1fkfa10OGJT/xExPFGZ0M/g4AzfX26KkGK6QuevM5Oelu/9GJ/jast5QYPh
	 AYWbh5WM4nlR3XW0PvDTKfPqIvLwcMoJbHbHjgcsm9qyMxGwUxlAaiofIdwCI/aThHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717251;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=zdxE3pNrt5hoJNcWNvvibFDefpepIkGFYwE2K8p7fsU=;
	b=bPiJn9EJ359JqRVtqplN6pAAaffKB/bhnQfE9bL70xbWJkr2aD4y2khqXMEY3SDAFUQA
	 zzdJDNKAOG3K+jZ04oiMtS+b3Gr7+BL764ggQ4qXmYpwIT+SY7+yb1PcEyMySj+5sSYm2
	 Bgk+4CioH45MCwv0fRTDvhAhXOIqE1CxxR+CZI8KCL0qr8HJmCUEwSPT+A73XLQnqhwXD
	 XAQFhf6bA5bnHkG69njmImQYqwJzBEFMSzijw/yOLeZH1E1CUbSPwVa2nYzQSyBaByt99
	 5j37dyWeRNumRjiTtF9oflVde5JUqhx6CI1onZD6+Rsy/C6ZXF/uqbMsbMibuP2MpNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WPr9+Rjy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dmv3nyy0;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED47606A335
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED47606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WPr9+Rjy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dmv3nyy0
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CBC7EC012B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 09:47:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 09:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793717250; x=1793803650; bh=zdxE3pNrt5
	hoJNcWNvvibFDefpepIkGFYwE2K8p7fsU=; b=WPr9+RjypIQHSwpdnK04D/qtup
	JjXyxDgZAn+muk8sBXF+VxaU3NL1q22JMqLxQ6DlAC52vP61Rvxr7iGmoXHUfkR/
	GoVRXTKJdRrQEeCyCIc45nViB8vZ3OT4kcJ5mDpN0dojk6dA3/FDxbpsXKAR4oEU
	DBwTmC3JMwBZALyVlcFmUvWXy+uL5Rs/hgoF1108xwZPgo75yW55vn/strtOUarD
	u/CZ13idysMcZqYQapfDmvthN2tFp3NprkRT8BLvWzKKrRhaHUwphbCXzTJWnxxy
	pD2GvAiLlRNBtlSFbxQNzNpQn2JIQL13j+EaZvccP4H41GiocFaYI//v6Yug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793717250; x=1793803650; bh=zdxE3pNrt5hoJNcWNvvibFDefpepIkGFYwE
	2K8p7fsU=; b=Dmv3nyy0zTUsTnGihscCIo+jxaZBGEHMQ18dk2kz0Ip6wuXsHhG
	o8D7bF76OZt8eBXkYtLt5X7eRuUju7CzR568ddi0so45+LQ/erYmVnfZqskLM7uj
	tZ/z4EtLVl207kb7nkxhlD17hbxWPO+u5RVUZdzhgI2oMfRdcgk6eIwTy1dZ8lWF
	ZeT/4UhWShcKnf0MFCHeVSjMMsNtjOvp7LCVsvxkwxfkwIKExhu94QJ7o8DLWpmK
	sBZ/lbD38dVrQ4PVyNnk0O8zgU8ax2XLrxSeZleWESEA6XMmLFVNKsKSIOkscWmR
	8jt4p1SaaquR2vx7f61ODrc9Kc+FldM/Cfg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793717250; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Zrb50bhriduZ8X6wxed/LFQ6WLl/3dFTHBWM1SuCXXq8F0c
	wuj7SiEirfhkijikyKcpKkL2hv97zmy046AtMxn/ktUg3qJbEzsVyh0vAyCA0afJ
	A16BSsB/dweyyD6irdx7+827QMh8NpNi8yvFQC8hnsQeFHkttPtsT9DAKdBz3SeZ
	TSG6kWw6SPswO4OpU7A/nG8GkuEbw9CmVkNkyeIy8Sb2JvGhxTcsKe5stb3eee/U
	cTNRl00aU8beGfJCwve8hSM1olNib5HznTadwt+CWL9vUytY6zqyH1h4pqTuifvU
	jO2VlQ+Igw4qSOnCRxQy3MxAoHjyeNv1FsBeqIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:SlFopcjjE518TsXr4WcMN8ydsSH6fene/VDCrBa5Qmo=:ZAqGcOhkLgcuPlRaGyCYjmr/XHWy09AcvQpTlz9rwQc=;
X-ME-Sender: <xms:AvTparVt5cScAcz7ntuaJZSVue6HMkzMBTGl3w7IU7hDfF4d3PH_kw>
    <xme:AvTpal1Y6g0MZC-JaetDQgOiiJZuTGyT1yo4Ra4FcyjtiL4_jH09e6FWhEiMbO-F3
    WT3QvYaEE9AEjZ0jjhQd88GjbpM5wfI1Itm738aBDm1mlM1NnmRPwm->
X-ME-Received: <xmr:AvTpapoJK39eUkbreVreh_IMXxkGKG8MUsnnvfu-35dRQVzv24G68F81g2PMQgDddkv1J5XDBItZ6X7-CunvtRWYLL2yZYtU-cu8>
X-ME-Proxy-Cause: dmFkZTFZEAuaMEZ3XWWPBc5aFFw1T0ka4Xr9EBZehb1AQv0ixb+/iyUsURd893SQR6FE0G
    FTcl8RWp/LDoiY6LNdNH5qAFNraBfUkHiUs4//GVfz6yEEOYsSUJpBXJyo7k8HuMEL1tEY
    h7ZNxt2cGY9ZVZWP9B+9yAlLEmOUMhOyFb2Pd5DtLyIe+SR2jrSGNhWnFw0hfjFufz4hVI
    JtZiHUm3+0tX4ZUGSLjRUyBh262ZA+SSwQefx/sZuEPxw/eIyUopZnRu9ZlEgDC33ysTB7
    CrLUHt5zLrnEdVd7f3JUSRy/InGt61V1+7sMyAo7pIzJPDwLzytbjDNjTzxWk4eWwiWAkn
    1CZHqqeqXKn+kJUqlOl9Rq4HHnYQhuMyWAYe9exxmhaZlPH4tCbLQ5tjwg8jcp9kQRXWfY
    PtGfjcGJWHcQ9430CwMpg9J14BvzIE3Fb3d1/o3D1rLsGYnhDwj/lB9zAlmTh3aTT82182
    /lMUSgJgqWnO+CPvg+ufKgF+4A12d+vi4Rqkc/L5VfyY+HvIDFX9f2vBEnuncdi4A0tbqN
    18rEfeMXonZol8hdZ8vLBubuhY4Gl+t63y7pv1QRHAV4YZgGZRq0rL7S1iJhGR4uHKUxmW
    HPs5/8qoXR8ZuEM/mZbq9o7qWTXPo4MfUhKfyOQqhjLVQni0GZNJGUULXOqQ
X-ME-Proxy: <xmx:AvTpasXgmsQ4nK-8vT40-2bSWLSvIVam3VFEGBBTlJaKGRjpp_QCYQ>
    <xmx:AvTpakaGMy_J_-z--h9FwzgeUGvPaFlTULgUVDCi2MmthgPEwJ4Dqw>
    <xmx:AvTpapdvaDIUDfnq0_tVrmR4_0bsO5PUmhkXwYf9s7UWYkE77vp-dQ>
    <xmx:AvTpau2Ix4_7_0tglYzn4DItHA2CaA_gsEhEIbSdu6oEhE2MKrrq7Q>
    <xmx:AvTpao1ciajluF-sz7Y9bUD9YLmVD0k9MrRKd9PSW8nf3okEEa4PEfi0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 09:47:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH 4/4] remote-curl: retry transient HTTP errors in post_rpc()
In-Reply-To: <52819accc894e760a0fd06730d20f46cc8da9914.1793462224.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Sat, 31 Oct 2026 15:57:04
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<52819accc894e760a0fd06730d20f46cc8da9914.1793462224.git.gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 06:47:28 -0800
Message-ID: <xmqqh5hyas5b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/http.c b/http.c
> index 950e2bbffa..36b559e596 100644
> --- a/http.c
> +++ b/http.c
> @@ -2476,6 +2476,34 @@ static long handle_rate_limit_retry(long slot_retry_after, int attempt)
>  	}
>  }
>  
> +int http_retry_wait(long http_code, long slot_retry_after, int attempt)
> +{
> +	long retry_delay;
> +
> +	if (http_max_retries <= 0)
> +		return -1;
> +	if (attempt > http_max_retries) {
> +		trace2_data_string("http", the_repository,
> +				   "http/429-error", "retries-exhausted");
> +		return -1;
> +	}
> +	retry_delay = handle_rate_limit_retry(slot_retry_after, attempt);
> +	if (retry_delay < 0)
> +		return -1;
> +	if (retry_delay > 0) {
> +		if (http_code == 429)
> +			warning(_("rate limited, waiting %ld seconds before retry"),
> +				retry_delay);
> +		else
> +			warning(_("HTTP %ld, waiting %ld seconds before retry"),
> +				http_code, retry_delay);
> +		trace2_data_intmax("http", the_repository,
> +				   "http/retry-sleep-seconds", retry_delay);
> +		sleep(retry_delay);
> +	}
> +	return 0;
> +}

This code looks familiar.  Beautifully extracted from ...

>  static int http_request_recoverable(const char *url,
>  			       void *result, int target,
>  			       struct http_get_options *options)
> @@ -2483,7 +2511,6 @@ static int http_request_recoverable(const char *url,
>  	static struct http_get_options empty_opts;
>  	int i = 3;
>  	int ret;
> -	int rate_limit_retries = http_max_retries;
>  	int attempt = 0;
>  
>  	if (!options)
> @@ -2506,9 +2533,8 @@ static int http_request_recoverable(const char *url,
>  	}
>  
>  	while ((ret == HTTP_REAUTH && --i) ||
> -	       (ret == HTTP_RATE_LIMITED && http_max_retries > 0 &&
> -		rate_limit_retries-- > 0)) {
> -		long retry_delay = -1;
> +	       (ret == HTTP_RATE_LIMITED &&
> +		!http_retry_wait(options->http_code, options->retry_after, ++attempt))) {
>  		/*
>  		 * The previous request may have put cruft into our output stream; we
>  		 * should clear it out before making our next request.
> @@ -2533,35 +2559,15 @@ static int http_request_recoverable(const char *url,
>  		default:
>  			BUG("Unknown http_request target");
>  		}
> -		if (ret == HTTP_RATE_LIMITED) {
> -			retry_delay = handle_rate_limit_retry(options->retry_after, ++attempt);
> -			if (retry_delay < 0)
> -				return HTTP_ERROR;
> -
> -			if (retry_delay > 0) {
> -				if (options->http_code == 429)
> -					warning(_("rate limited, waiting %ld seconds before retry"),
> -						retry_delay);
> -				else
> -					warning(_("HTTP %ld, waiting %ld seconds before retry"),
> -						options->http_code, retry_delay);
> -				trace2_data_intmax("http", the_repository,
> -						   "http/retry-sleep-seconds", retry_delay);
> -				sleep(retry_delay);
> -			}
> -		} else if (ret == HTTP_REAUTH) {
> +		if (ret == HTTP_REAUTH)
>  			http_reauth_prepare(1);
> -		}

... existing code around here.  It always feels good to see that an
introduction of a new function is accompanied by replacing many
lines of existsing code with a call to the new function.

Thanks.
