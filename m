Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003236;
	b=ZLmim2KUwWSn05BMZI/1uCv83pLgF27AfhRq/bdnip2uAwZdwwkWNB2E0XGHOObG5otE
	 Sw6/mNUQCeGuJzFXngQlCGqnkabPaEZG11+XJtDEqyW5CxE0r8chNrfwvXpRN5ABOrKzJ
	 SiRdSDkTwh8cdsEoTSJedk5RMtCh/JYzS/yVL3vKS8LEaTesSybe90f4rAXGUP2XhQgNt
	 SLWee4AU5eMYM+vEfAP2JEyPO4brFmNKcjHypO6ot84b4ZwlN8paXQGqit3jjx7o3YJon
	 YjkRARY9T6k5BoyHYdti2/MBnmKGVO/6kw9fXf1NDmeGjR1soxcumNpH4xIlqNAVNLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MXt2jBi9dTwllmM1p8HCDI9HDFU2EWSegg/gqtT86AU=;
	b=oP8f//7Yd6fmfLUcDcm0woiS9gjo1FjsPkRDmUUoeogRhxoyb3hdGH8cyOhws9ObANCw
	 djZAc9KWRkSHG5PaOIgK7SCm21eYzbzY7QSr/R7jlPXoKZvH3g7gCfzuradXN5ICfq/Nb
	 7Y44Td7HP8z/P+06Ubhg2dNkwB0cJYlSzp6VGGrQBcega5cBvIa8fIP5PChd7/c1GQ5zD
	 uMBrdbmmhiGVB/Wz/qC4EZ2AApTLyLD19g8pSRAfp+a68TR93nLY6x6O4dvzhGBfTThKK
	 35nhgcfHJ6CyEd5gbqCk2awS1PfegyZUDLEbDyvQd2qsA4MbPPb9oOQayxInN/LJc0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nAEILsUe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eZ5IHptv;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B3606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A78B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nAEILsUe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eZ5IHptv
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4ABA1400134
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:00:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 07:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795003234; x=1795089634; bh=MXt2jBi9dT
	wllmM1p8HCDI9HDFU2EWSegg/gqtT86AU=; b=nAEILsUei3/SVhFImFda9VpR7h
	0s7P24aH2QiI0fJH0rdybps4qHf5Uzd2zR14ianUu95yI91LNoNKVtWM33TMoMwH
	pr+tuAqbBOcl2gd2PTaB9R0h5ukcJGRva1drNfG4B6xrNTuehvdtQmRQg7be46Ue
	f9luKakFdiIqXcmj4MHoRuFHvRuCuEAO5oUhEN1JYoJUE9tVk0afvs6Jp81Q53ax
	QgpG7tJBn6OTPa77SDldLs79LBj7xIOr+6fYezHOWVQynz+JVd077+Enz4HLKSX0
	bnxvNneOAdROIEeVwxZZM3e3HEug7Qa8Pdf24mrv98XccZPNjXq1V60aAcLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795003234; x=1795089634; bh=MXt2jBi9dTwllmM1p8HCDI9HDFU2EWSegg/
	gqtT86AU=; b=eZ5IHptvlTe9ruWxdksDoomO/eG1hXGPtEwybIYcvLiZWGdsxFd
	pAiU6Ya0AuuUHRrgbSBpVTmpa8Dhov6S4NAXDuZenBMOkKmW9sCK1EDni26vs/30
	wHLlgwiWGoLM+JyX8JhhQVLdQdagdUg92nyI+CtoCOt4Igym4NebtU8Ko5RaAJUP
	QQ8Uz41xRHIPD/0t+wPvI10CcVaQ+S7CqDhEcgDzXlX5bXSbi1zPnrXYzFbUV8Ju
	spq2JchE/t3ogve9JwzjXg8NFL6ZgfcohAOF37MhTeDJq3R7dfgtdQiVBWEgLlkt
	0BaK6YuANCOthaJc/qSowdZ4whg58dR0EWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795003234; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:kuxJg0uPafYfmNPVjOfoakYxhFXbr7IZpKpNis3yK9PdN3C
	34wLqc0o6WZPxBeieqs3Kuyid0k0qBk+4QvRkcVFJlLthIWHnxI2BLooY6+MuOxP
	GkxtROPNNVQg1OVGzUEi7lBWWBEZqoB5jYFk7nZi1ujN24x6pDRiBoCiLS1za/JR
	0MiXuylW3h++Bbl0ac0lo4LvllzdOMndUT8lkXe7qeyTRFQshmSRUEGBRvhtheVm
	9Wxe+0wubCKfLgnn/pSnkFCLCjwQis25jo9uTZdCGWAAiWsYKDhMBTqf+tHPNtPj
	yeSbKOUK7nKAIm3Y3mX20fEhB/hAx8qync3bU+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:F+ctFTe/Z6ow4QhBYxTcGuZN7RFnzdm1BlNsqbNfAPI=:5BjIIWfYP7CyMrhENj/z6ZTUnwhdz8/cs9D+XLIisxA=;
X-ME-Sender: <xms:YpP9atc9XEKU2I7Lf52jYxdwtALoY55UhcKU56EP05l-gNOlg9_e4w>
    <xme:YpP9aiFlNrCBi0LwKLbkdq5hrgILXQIBrahsalthYVkuQtYevRKUZXxMWuUgDEfgv
    -q3XGkGhNtdyIwiV6bh2ESri19xXA2f1ZYtO26DZhueIAtxnLptTQ>
X-ME-Received: <xmr:YpP9au1Hg2F9a_OCXkbHf7YI4SRaNezshMVkPirLXlrd-8GKTBNAfQ>
X-ME-Proxy-Cause: dmFkZTEUP2/pVE/iP+qeQA7KjMgBoqAkD2OROpqcO0FTs3I3gHewFp70pJ7PEkd5w1DmQD
    kykK8y+CN4jhk0dBsHhFbxIwTtJuU+a0s1RlJpBJAwgS3AgSoGbDzKlYfVcMkWLYYM5YBH
    mtAnDG4+Lc2ltRDXs+JaOHPSPwS6W3taSmL28s+Xnhch5lV3sgSO9SItOudSpr4evQ5kHJ
    kUWFj433y2KY7zcfBiPHtrBtfeDXkoa7j5r634lHhx/qxBT7TtcS/ktme5gJ25125NqDIi
    KKnlDAWPuqCg9lqr0D0bneu6XAs/YjwNRJfbnW7h4UMYnGHMeuP/tYaBYjjR5API+3UFdN
    y9M2znttxJ48DRgAWG9J9lnsLt+ONz0t2eANlMSwsBMiOqOusx2P0tRENgJVn+53/bKIJ9
    tD0dmST7wiDtelscUJ4VTBMhmv9Xz/2GNyJ4OijfZSVwFkPJSZ8UuYEVmNxi4kPV2QYVYk
    Bi6U+2Vw2sYGKjJFDZ/+n9WZqLlSyxR99AYbBb1B63igMU9J4lam647oAzMQYfgDegLJa1
    cNlI/Ln/cg1lw1/HHDsMcFG2Rd0MlmFgFez4f+TzdTMAspku1FZv4seUbuviXERRjoajTk
    Zpo+0aSsp+eIxGV1/hZXhAKcrhe9mEIoOvhbQUPRyHlFoSR2doZDTLKFKn/w
X-ME-Proxy: <xmx:YpP9aim4odGuQX2bw4jiVkBB5ETXHn9qQR37Qk71eSoSuxfL0S1_jQ>
    <xmx:YpP9am_8MRYehk6CrA9NBAswVslMaMfGZFCxVGaIvVORXQlkLylDEQ>
    <xmx:YpP9avqOZFgQMemjvZxyINMh1bdk2adC6pt9Gpri5NQJjeZiQ-bewA>
    <xmx:YpP9annE9uswn0WzmF6wi4Qa1L9Ax6_kjn4D9iUvS9yCH433xRnX-w>
    <xmx:YpP9avGv4IrsArcckOVZ_UBNIPLDxnrArVumGGZhGXKQeNVIhUUBmBL->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:00:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db0d6b04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 12:00:30 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:00:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v3 1/5] http: fix retry count and Retry-After timing
Message-ID: <av2TTPCkiA-49K_I@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
 <d53778dd4635bd7dfb5b115a23f3642ea3ae40e8.1794022836.git.gitgitgadget@gmail.com>
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
In-Reply-To: <d53778dd4635bd7dfb5b115a23f3642ea3ae40e8.1794022836.git.gitgitgadget@gmail.com>

On Sat, Nov 07, 2026 at 03:40:32AM +0000, Ravi Mistry via GitGitGadget wrote:
> From: Ravi Mistry <rmistry@google.com>
> 
> Commit 640657ffd0 (http: add support for HTTP 429 rate limit retries,
> 2026-03-17) introduced two small bugs in HTTP 429 retry handling:
> 
> 1. In http_request_recoverable(), rate_limit_retries is initialized to
>    http_max_retries (the number of retries to perform after the initial
>    failed request) and decremented with pre-decrement
>    (--rate_limit_retries) in the while condition. Because of the
>    pre-decrement, setting http.maxRetries=1 performs 0 retries, and
>    more generally N configured retries only retries N-1 times. In
>    addition, if the first request returns 401 (HTTP_REAUTH) and the
>    re-authenticated request returns 429 when http.maxRetries is 0,
>    --rate_limit_retries wraps from 0 to -1 (truthy in C).
> 
>    Fix this by checking http_max_retries > 0 && rate_limit_retries-- > 0
>    in the loop condition and checking http_max_retries <= 0 after the
>    loop (which handles both an initial 429 and a 429 after 401 re-auth
>    without logging "retries-exhausted", making the pre-loop check
>    redundant).
> 
> 2. In http_request(), CURLINFO_RETRY_AFTER is queried after
>    run_one_slot() has already called handle_curl_result(), which logs
>    results->retry_after to Trace2 ("http/429-retry-after") while it is
>    still -1. Move the CURLINFO_RETRY_AFTER extraction into
>    finish_active_slot() (initializing slot->results->retry_after = -1
>    first) so that both handle_curl_result() and callers of
>    run_one_slot() observe the parsed Retry-After value.

Nit: feels like two separate bugs that should have been fixed in two
separate commits.

> diff --git a/http.c b/http.c
> index d79678d01f..0308f973a6 100644
> --- a/http.c
> +++ b/http.c
> @@ -345,11 +345,20 @@ static void finish_active_slot(struct active_request_slot *slot)
>  	if (slot->results) {
>  		slot->results->curl_result = slot->curl_result;
>  		slot->results->http_code = slot->http_code;
> +		slot->results->retry_after = -1;
>  		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
>  				  &slot->results->auth_avail);
>  
>  		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
>  			&slot->results->http_connectcode);
> +#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
> +		{
> +			curl_off_t retry_after;
> +			if (curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER,
> +					      &retry_after) == CURLE_OK && retry_after > 0)
> +				slot->results->retry_after = (long)retry_after;
> +		}

Makes me wonder whether `results->retry_after` should be declared as
`curl_off_t`. But that's not a problem introduced by this patch series,
as you simply move code around anyway.

> @@ -2474,7 +2470,8 @@ static int http_request_recoverable(const char *url,
>  	}
>  
>  	while ((ret == HTTP_REAUTH && --i) ||
> -	       (ret == HTTP_RATE_LIMITED && --rate_limit_retries)) {
> +	       (ret == HTTP_RATE_LIMITED && http_max_retries > 0 &&
> +		rate_limit_retries-- > 0)) {
>  		long retry_delay = -1;
>  		/*
>  		 * The previous request may have put cruft into our output stream; we

Right, this here fixes the pre- vs post-decrement issue. Makes sense.

Honestly, every time I see a pre-decrement I'm already wondering whether
it is correct in the first place. It always feels a bit too neat in my
opinion.

> @@ -2518,6 +2515,8 @@ static int http_request_recoverable(const char *url,
>  		ret = http_request(url, result, target, options);
>  	}
>  	if (ret == HTTP_RATE_LIMITED) {
> +		if (http_max_retries <= 0)
> +			return HTTP_ERROR;
>  		trace2_data_string("http", the_repository,
>  				   "http/429-error", "retries-exhausted");
>  		return HTTP_RATE_LIMITED;

Right. If we never had retries configured in the first place then it
doesn't make sense to log "retries-exhausted", because there weren't
any.

It's a bit curious that we return `HTTP_ERROR` instead of
`HTTP_RATE_LIMITED`, as we're essentially still rate-limited. I would
have expected us to only skip loggint the "retries-exhausted" message.

> diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
> index 1a5d7987db..5537fb7ac4 100644
> --- a/t/lib-httpd/http-429.sh
> +++ b/t/lib-httpd/http-429.sh
> @@ -32,12 +32,33 @@ repo_name="${repo_path%%/*}"
>  safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
>  state="http-429-state-${safe_name}"
>  
> -# Check if this is the first call (no state directory exists), or if
> -# the retry-after-value is "permanent", which indicates a 429 must be
> -# returned for every request (even if the state directory exists).
> -if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
> +max_fails=1
> +case "$test_context" in
> +	*-fail-2*) max_fails=2 ;;
> +	*-fail-3*) max_fails=3 ;;
> +esac

Nit: coding style, arms of a `case` statement are typically on the same
level as `case`.

Patrick
