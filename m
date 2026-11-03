Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667828;
	b=qaKDSS/dhlYqESo9oF9YrWZly4t8K9lmQEzBSRUGOFD1OQ4cVdckIQeFhf5q8zO1F5jd
	 fC5XRC3owzPcwzfsx7oV9hokpVrPAHH20VlXO4fE6PP/dApw4wZeJsYeAnIDTSzD+qz2m
	 JPrzwykjBoUG8Jiv2l2kP18/+xc/cdn+tLEigh3x89Y6vTUgK5cGbpyzqMLQfnyNdo6st
	 JWKKGB+VwRmgX2XjMxPc9m6Ms4HvgCvjEbTArW7boQ4jXiI3J44aaDDhyOkZBbXuhDYws
	 X/Yq3CefzqP/hUKC5yRuYpArJD3SwvHe5W7qe/iJlHIQ5UEZpRYR5uBBDggmlayauVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667828;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=qYrm9Gm3kbO2z7dIc5rV+QIF2hKBHQeV6tRy7AjsFqA=;
	b=ypDyWDqpYulAmYvaGUhtWH7qQXQQY1X2aNKqMQkD5qdJdjMq9wl6cBYGe7BKo9j24sgj
	 NbPoRrHnWHiFpyu9FotUIvWLEUS1HAJBMnIO2M4FoeQ+eqFvJE/plkN9seNUlTzuQkQUP
	 uzEkZxRBXJghiGzHmt/S5u288Gi+agQhrS5J6257JiAMyj0wL5ICHOjwXuxalZCL64suA
	 o1KEALWjqYjvfHy1hFDsJLG/s86yc5Quv9raUy7XY6J2GMNTr0AGLWIe7t7PoJQMRhzWd
	 YJ2GwQzZoczE3RbtuRk4swuGrf+Q8AauSufC4BKPr5qYn8ArDbMMRgwHkZmtwhLfeLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="bMDvqQ/q";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pfcuj4A1;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB4606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 01:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEBB4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bMDvqQ/q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pfcuj4A1
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A011140021C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 20:03:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 02 Nov 2026 20:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793667827; x=1793754227; bh=qYrm9Gm3kb
	O2z7dIc5rV+QIF2hKBHQeV6tRy7AjsFqA=; b=bMDvqQ/qq+NSxoF8kMl1yswraX
	ZGS3sJDUTKSW6+6R4DgNynaCmdYTLMrgfcj+EBbZ0UECV0Ev1E9UMeoEFl56lPTO
	EFFaRjs4qqM6jgXcApVMYsTGeXa8181K55PvQEUT/QQO5sD4+S62ezZycRPK5FLY
	EFv+7aLqSxT5zoIpZEY38GypBmbFkMtrtzUogdZ/n6/58py6XaQW0rXckNXvJmvk
	TdqVxscgVSlNPy+n0hcyc+BhbShBSwARJUwzRDG/hPe/LdRE+7DrY0chXDcjorAX
	cAs+bkUB3UQ7OpaRyL6gSEByiBFn1fhd8nr12eQt154D6Vmbx4mxyEaubZ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793667827; x=1793754227; bh=qYrm9Gm3kbO2z7dIc5rV+QIF2hKBHQeV6tR
	y7AjsFqA=; b=pfcuj4A10xOkqF6zckqQQwSKwfY1zKFxk1jdJRny29lrudhCE6j
	gXIltMGqAosx+2k/wLJnzTSJ74iwV7ApTkDSM66qMzo+QG5+eJfcZ5C4j7Oy/mxK
	tk5C2JKX5yLmU2wSdntEqyJ32LEVBhftUr59KeA88UfZIumNa5yRQp+zjV8LMdQc
	j4bO5sbGeshR2b0efmJdDBOuX9MQFmuQiC5KmQ4yamYhXxnZqu1yhGCtvuSthmIG
	Cyywq2S+92dJpk2Adb2xL8ITJNbPEhPSUmbwZ5Qz0mjotXd3DqVdiW+jvMDxxc1n
	Xe2KaPPUX5JNdZCsmJLu22SMiLtrcjna1pw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793667827; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eb4Jv4kBhP5xRSvEv4LmzeqAF54dF5OokoyQ9DnlI61o6LF
	lrUrDWmW62skuUOo9Zei+Hu7B0iwbR/w6ElZ+d1dzX8W21g6Of+KTkdpkzqFU6SH
	2bkrCRdmQLJrrHCrWN/L7I+j00FsK+u28PNeV9AOjTSUUBHgLrzJjbeZv9cIKmW8
	QX4O6pPJonWH82Sz70X7lLLq5+q+7ZXc84AwzuPWfRbzMTLZEC1x66RMD2DEq0GK
	ySi9Lud/1GvXlC5wpnYtVMR6hOhC36zTm/3UuXrX0hy9fb/tjHx//Dy07X0HlteB
	uyAWJp3FkGlfoJQMb56TqR+EkG+AlT4Q2lD5J+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:SZmr86lAVvy5Rs24gmfdA3YuaVpZJYRIIgh19iCO8D4=:6zw74FvNwYtf+2nc0azHD27Ki4ZMs/ZGRjgGYr+nvis=;
X-ME-Sender: <xms:8jLpanCv2ITz6bHj81I9dbbWXtyoqGoAh1zkKg_1pCLX58sNXGlolw>
    <xme:8jLpavxW7xekYLP_PGIvNHYNCBVXr5CZoViDyaR71lgS10CHHH8PgPLQWhS9HGegH
    tjNqfiIup_1cpuVbbUsI0Ye4a6CyvLoIuZyNQa8vmWQU0JuTpeEz8o>
X-ME-Received: <xmr:8jLpak1NotyZNJb_FGulHGfpjdM2zMpgbMQr6Qi4FyAWpaSt04Rq8g5fwI9elemTnGvho9x8eYJEauQTeat2ef48qjMhfMxB1xbL>
X-ME-Proxy-Cause: dmFkZTF6hhcZUeCpnGD7/SSEkZZ4Op9H61i9Ae09v2nvj1CP2Z3gvcQw2vmycfSor5oQ/G
    r4QcF77Z5CVlh54NsnscinQ+aSBY0uua6OVk8KWiq6eoh84M7EfFH+QCYGSc0dnl1TRy5L
    EhFcTlZTbb26/cl07OXyRw+xjT3/jKuZ8k3f83WiIha+Dn1h6wz2SwnUX7Rnia9lpA+uH/
    RC4QM5QOUpcQZOwDnUEOpF8spUP8PVL9T/5M2Qkpu6k8Q0dPAgRuBNDkS2Fxyf0yEoTTZE
    IcgGQW2QY+eCZLk/m9cFxon/4VZDbieO0v5UIQ59wzocOHdNLEaXjFRWHtoe/MPC6JRpRg
    Fm1RgXT+kej+c9t4S2ATHJPIeOsWuVbUuj8j+/0M8rJ6kqPhiGhHBMDO1UU4li6CxQbE9T
    02n+gFf36f0MpTfYlBuFzVH0X+b7zFHJS19auNJrJT+Vj7PBb5+yyKJW/+01kMCRtleiq6
    yavqt/4YrR0fQVvWd3BX9u84OXs5XCkq0VVz1WJ3BV2GB8366mAR6ULT/kJt93WjwWb/BD
    VVm9DrxJ0kTFU7jR/RWA/7EOVx11MD9wKRu+elLDr6o2meSr2MFiSqhNCLE1i5DXtSExHg
    XTQgAzDiUQ/IA2aTmA/t9UipMNvzkUow5gZiUZzdxyaDQ9QkJRUhLgmn5T0Q
X-ME-Proxy: <xmx:8jLpavyFOVpQnBM3cVwMKOR1zYzTjwVn8ZmZjGqXv8YRg16t3PoUow>
    <xmx:8jLparFI42xUkxSGI69Zvv6iDsXNMoLRnoaZDRfwmWyHeyeIhlcXPg>
    <xmx:8jLpaiZZjmNO-2HIb48M_-VAMqczPLLnzyhIAPyNQze8thDSNYTHpQ>
    <xmx:8jLpatB0lt5htsBNO-Av2QdrlBIrJLngee6_RxIsXwHgryIGChp4iQ>
    <xmx:8zLpauwuABzDSixEohslira7Bd59zqEWprYgwgTw6JQjwNnL9LHfYgXJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 20:03:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH 1/4] http: fix retry count and Retry-After timing
In-Reply-To: <80b7f207f42cff0a3dfe23181ee315fdc90e50ff.1793462224.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Sat, 31 Oct 2026 15:57:01
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<80b7f207f42cff0a3dfe23181ee315fdc90e50ff.1793462224.git.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 17:03:44 -0800
Message-ID: <xmqqpkwmenf3.fsf@gitster.g>
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

The new test exactly demonstrates it, which is fun.

>    In
>    addition, if the first request returns 401 (HTTP_REAUTH) and the
>    re-authenticated request returns 429 when http.maxRetries is 0,
>    --rate_limit_retries wraps from 0 to -1 (truthy in C).

Hmph, which would mean we would retry essentially forever until the
integer wraps around again?  That sounds, eh, nasty. 

>    Fix this by checking http_max_retries > 0 && rate_limit_retries-- > 0
>    in the loop condition and returning HTTP_ERROR when
>    http_max_retries <= 0.

OK.

> 2. In http_request(), CURLINFO_RETRY_AFTER is queried after
>    run_one_slot() has already called handle_curl_result(), which logs
>    results->retry_after to Trace2 ("http/429-retry-after") while it is
>    still -1. Move the CURLINFO_RETRY_AFTER extraction into
>    finish_active_slot() (initializing slot->results->retry_after = -1
>    first) so that both handle_curl_result() and callers of
>    run_one_slot() observe the parsed Retry-After value.
>
> Signed-off-by: Ravi Mistry <rmistry@google.com>
> ---
>  http.c                    | 27 +++++++++++++--------------
>  t/lib-httpd/http-429.sh   | 31 ++++++++++++++++++++++++++-----
>  t/t5584-http-429-retry.sh | 21 +++++++++++++++++++++
>  3 files changed, 60 insertions(+), 19 deletions(-)
>
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
> +#endif
>  	}
>  
>  	/* Run callback if appropriate */
> @@ -2286,15 +2295,6 @@ static int http_request(const char *url,
>  
>  	ret = run_one_slot(slot, &results);
>  
> -#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
> -	if (ret == HTTP_RATE_LIMITED) {
> -		curl_off_t retry_after;
> -		if (curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER,
> -				      &retry_after) == CURLE_OK && retry_after > 0)
> -			results.retry_after = (long)retry_after;
> -	}
> -#endif
> -

OK, this is the fix #2 explained in the log message.

> @@ -2461,10 +2461,6 @@ static int http_request_recoverable(const char *url,
>  	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
>  		return ret;
>  
> -	/* If retries are disabled and we got a 429, fail immediately */
> -	if (ret == HTTP_RATE_LIMITED && !http_max_retries)
> -		return HTTP_ERROR;
> -

I am not sure I get this removal.  If it is because the change to
the next hunk (the condition to loop with the while statement)
already covers it, I guess it makes sense, because we never enter
the while() loop and we will return HTTP_ERROR more or less the same
way as the above if http_max_retries is false.

>  	while ((ret == HTTP_REAUTH && --i) ||
> -	       (ret == HTTP_RATE_LIMITED && --rate_limit_retries)) {
> +	       (ret == HTTP_RATE_LIMITED && http_max_retries > 0 &&
> +		rate_limit_retries-- > 0)) {
>  		long retry_delay = -1;
>  		/*
>  		 * The previous request may have put cruft into our output stream; we
> @@ -2518,6 +2515,8 @@ static int http_request_recoverable(const char *url,
>  		ret = http_request(url, result, target, options);
>  	}
>  	if (ret == HTTP_RATE_LIMITED) {
> +		if (http_max_retries <= 0)
> +			return HTTP_ERROR;
>  		trace2_data_string("http", the_repository,
>  				   "http/429-error", "retries-exhausted");
>  		return HTTP_RATE_LIMITED;
