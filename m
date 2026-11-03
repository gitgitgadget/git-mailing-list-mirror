Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713277;
	b=2hfwziZ2er/J5QuRLVnPomcN0/Fxn7+nuebjmjvPorgW5MsNuEZ11HRBmDoCFzmmXk/F
	 5lL4xplaxhQB3qKCa0kHEGwU4g4Nr1qD5elKQ9Dkj0QY0p4ZZ1K5fpJzAuZEn8LiuwqlG
	 0kNE9RALBxRLTe2R9DuDoBUUPyjQC/MkSjVfklsM8NQIyul5qlLOznKEqE6x9Mg0gUF98
	 qwPcwPXQaIsgm3gIKim7J+wLhadnn1v/T+TVzHJg7yH58Vq3A74knuDR4swGAbHsxu33x
	 nbvcbv+kiJnyzCFJjqSNsDz+na5unwTufYRCaEU3eZDgZ1Ypgtm4iRjSdk7NvhYYTwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713277;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=76dtchYnHjdzD/dbx/iV2Tnxasr2eP3yXiwG7H+YWA4=;
	b=Nd+UPOUqP7DVK80I1qVowFSL67LXnTkQb+FRizwT326redsP3oei98kIP8igdhTchc7o
	 aUYN+nRzwKp4s7SokptNvBQhcgNfXQjORjgkl66UPVJCa1X+rUlhYgNKTrSpDSbztCxy7
	 xvrHkJV5cUyWDwS6NsOFNv3wCcJHemZHINJRcFpNY1uZ/50X0t99zxfX0WJY3qHNR/LTQ
	 b5Lb63uIv1toSIi8/pjgmKQSWwwg5b4YJf4N9tK8xBVJ3OF7vNVdnzFzaHQlzD/L+T4Gi
	 N0OK32huhZ4YUoe1J3tk5iMTANAEU9DilDXajPltjIxcoH5brhJa9aKPZvZ6s8JBD/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kZbvXEkm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gns70fcr;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E0606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 263E0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kZbvXEkm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gns70fcr
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6357BEC05A8
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:41:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 08:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793713276; x=1793799676; bh=76dtchYnHj
	dzD/dbx/iV2Tnxasr2eP3yXiwG7H+YWA4=; b=kZbvXEkmnOSid4tqOKeSJvuUS/
	jNAMya23nAJZNHr1iMNt+dD2xCHzODhGWgY5LWFMIpJSRs8M8kyl3k4pJMlHkrHd
	QAEcPC1zwMbGib8A3gIxofMlU49bysko/fYQqskAVFZXu60eFdQpI1sRUYspy1F6
	BIHHLhJ5+whorWw7ULfxcfiFoZpC4h8thHr5Sk3MW1tELtxA92nrWawncZU1ulhZ
	uut6Orb5OwGtO4tZPhDhRQ6QNrmQkCfeFu6nlTKzIJJR06yhtlfl5Gpy7GskNKTm
	aYbHoliSRSU8C1JdlE4dr0QVKJjI5mQsZ7vZOrXHPfkvUUBYpUSsXihvZeTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793713276; x=1793799676; bh=76dtchYnHjdzD/dbx/iV2Tnxasr2eP3yXiw
	G7H+YWA4=; b=gns70fcrYZL/LZUw9luTi2UDvGfx9zU0aIk+NHxeGlN2wqRFv8s
	5i8SIf7LSs+bbU0rXfEfUPXOIuQvnEbdqvTRUut31PDx19xQ5VxMFW7GD7qMxm/w
	jrNKPUMs/qkbhtbIcHoWDYuWT5aGvDB6vMKnPYpgOz8bff3sv7i6AShRiNbxx5uK
	AIXjwVs44sBUXW+uEVbEUtaKcuJxZxjQBzvhSFmvEP19gv17vmUaqVgGwcwQ3DZy
	QHlBc/pzxr3Bby8DTYpkO7WETYw6E/Ah93OAMb5B7YAO8UnqIAi7mNGWNMDJZ6KA
	IcVctE7wTkNxnDtYvAWQT1n5e3V2e2M3yKQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793713276; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VKgEVNl7jvkZr4r7/aqYX+CKWGhzXCcf0hRiHmt72g7RxhW
	XS0nOmMK/zdHr8EcqksuBof3iNZSAfgbYC7o1GRwZLvFVwvcXOxHz8noHFJW/qYM
	TZ9PUjj+RGsgXnhU5jv9CjM1fBcOhNm5DpWOJKrgXKV66r0MIOQNqlIpTJfZpQ4s
	c1fFBbepLjvNdWwhq3nH1835CikGapjHO1JwrTlDI3U/5y0NpHnoRqphZvfCzqeR
	xuteHJ5YO0xR7ijG18OFdTTVUrgmBSqfMGAjQ+hUsZ3BZLC55hnK1Zm9uXWZxL4X
	JgqiSAxsChJsPJpCA0AGwxQy1Duo4VTl6jLTRTg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4/YZ4jqRX19bUy9hhlfz6gjoTJau1+E9wAg/7q5I2c0=:MU47HoP5GYdLVr7DWS5W8Chsj+9f0uYXaTavshBeFmc=;
X-ME-Sender: <xms:fOTpavsvQsdMQAkz6yHlW7nmTBHWmYaUMqi_pakoZRyaC1UnKb6PVQ>
    <xme:fOTpaiv0ezLaCOGo4DNWmsIqHyhvFRBqlLfxJN7Mh7kZ9GqB15G3JpxdEuBjUgnQj
    LWripwI34U3BbGYj1_fO-UUw_6DCpn5PsNbQzaCLTmfMBDfRmcKYr8>
X-ME-Received: <xmr:fOTpalB0DSlJ70sQmj4PNS_V29oevAyY7wP0iAAFd-hn7QdM5ZltZAmgy85hSAcYxU_HX0-P8naxkjlKgmrXcKpfpZnt0h66a439>
X-ME-Proxy-Cause: dmFkZTENEUdH5m3DNOPZ7sRYfHJJzTW4u4o5SE3OUmSw3uB8KnjBNgDkTeKLq7ldinRnZg
    fLP61ZCwm3QFUAXne11bTCDVLJzEkFGhJh0jsy6J/UezOXRZsNfdkJNM464wNt6127n7Ni
    c9ciDvEkftAuwda5Qzru/RfB62Fhp8OVYzjbyglm60pThLMUAh+FPl9OqoOSSy/C8d8dWH
    ygJSeQ5JCzeiiwh2LF/JBClrlWNz2KTO2Ugn9GfJjnspPIcHYRp+WjanxPMqADF51rt50o
    JjBere+GdFHqy52bgAR6sLMtrhG3KtIH30wVzQHnAoY4ERkkf/q28EXS5Yw10idWBDtwMQ
    6e90lfXVjpwfDdKZbLLUDyk7WjF69BKyvcmpc/SF8hWfwjoJoBqj5kVGuHi9dDWur8N5sZ
    7oROvEngt7udECCuW0b/oRJxNRsMfwdjzBXzxFJfnY6KMOR3OIH2kh95EeJHDaPAD17Nb6
    HZInL2esJmfn/rn9ZIcct2SF52kOoQcIeChATLbZCldngOihtlprwX48UTdkdPEM3k446x
    c1NdWxj1woPXXwPqE1aCDb2L9xzGb+2ByF95/q+W6cZ12SgewnmPAdgIYKe02DI788PqNE
    l4nsR7ifY/k2qdT5Af8DUtuDNpcmWy8vISdbbYVLUpvMX1oHotFWhd1mYDyg
X-ME-Proxy: <xmx:fOTpakPUqblB8I-s4lXCq7QAi-Wuh-Wr2odHYL_tBPLuFiO8mNQZjw>
    <xmx:fOTpauxmfLFahjVhj_TlVAQElBSiq1VvknRLG4Q0IVf--A8UFGUeYQ>
    <xmx:fOTpakU6TTLYgIOvwd80uVomd1_EcfEieoDq0pQ1kXm2qnBZl_5Ahw>
    <xmx:fOTpagMpss4IR5oI7d-dOPB1gKTrD_Gx06zBBUH_Lwkr90vCyP0sLg>
    <xmx:fOTpatuDjZRPcBsXKA0W_cfKMS3ZaUl09lkXoqqiwgQBEArPVfxpELTS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 08:41:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH 3/4] http: add http.retryStatusCodes config option
In-Reply-To: <f56ab2afaaecfbd64c4460be5d95637054623e4a.1793462224.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Sat, 31 Oct 2026 15:57:03
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<f56ab2afaaecfbd64c4460be5d95637054623e4a.1793462224.git.gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 05:41:14 -0800
Message-ID: <xmqqld7aav7p.fsf@gitster.g>
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

>  http.retryAfter::
>  	Initial wait time in seconds before retrying when a server returns
> -	HTTP 429 (Too Many Requests) without a Retry-After header.
> +	a retryable HTTP status code (HTTP 429 by default) without a
> +	Retry-After header.

This, and ...

>  http.maxRetries::
> -	Maximum number of times to retry after receiving HTTP 429 (Too Many
> -	Requests) responses. Set to 0 (the default) to disable retries.
> +	Maximum number of times to retry after receiving a retryable HTTP
> +	status code (HTTP 429 by default). Set to 0 (the default) to disable
> +	retries.

this, and ...

>  	Can be overridden by the `GIT_HTTP_MAX_RETRIES` environment variable.
> -	See also `http.retryAfter` and `http.maxRetryTime`.
> +	See also `http.retryAfter`, `http.maxRetryTime`, and
> +	`http.retryStatusCodes`.
>  
>  http.maxRetryTime::
>  	Maximum time in seconds to wait for a single retry attempt when
> -	handling HTTP 429 (Too Many Requests) responses. If the server
> -	requests a delay (via Retry-After header) or if `http.retryAfter`
> +	handling a retryable HTTP status code (HTTP 429 by default). If the
> +	server requests a delay (via Retry-After header) or if `http.retryAfter`

this all share two issues.

 - "Too Many Requests", which is a helpful comment to highlight what
   429 is, is lost, and

 - What we want to say is that there is a customizable set of HTTP
   response codes that we treat as "the other side invites us to
   retry if we want to", and that HTTP 429 is the ONLY member of
   that set by default.  But "HTTP 429 by default" alone in the
   above description does not quite say so.

It is unlikely that the reader realizes that we are talking about
the default membership in a set until ...

> +http.retryStatusCodes::
> +	Comma- or whitespace-separated list of HTTP status codes (in the
> +	400..599 range) that should be retried up to `http.maxRetries`
> +	times. Defaults to `429`. For example, setting this to
> +	`429,502,503,504` also retries transient `5xx` gateway and
> +	service-unavailable errors. Can be overridden by the
> +	`GIT_HTTP_RETRY_STATUS_CODES` environment variable.
> +	See also `http.maxRetries`, `http.retryAfter`, and
> +	`http.maxRetryTime`.

... they read this, which is very clearly written.

> diff --git a/http.c b/http.c
> index 0dec6377dd..950e2bbffa 100644
> --- a/http.c
> +++ b/http.c
> @@ -156,6 +156,7 @@ static int http_schannel_check_revoke = 1;
>  static long http_retry_after = 0;
>  static long http_max_retries = 0;
>  static long http_max_retry_time = 300;
> +static char *http_retry_status_codes;
>  
>  /*
>   * With the backend being set to `schannel`, setting sslCAinfo would override
> @@ -607,6 +608,11 @@ static int http_options(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.retrystatuscodes", var)) {
> +		FREE_AND_NULL(http_retry_status_codes);
> +		return git_config_string(&http_retry_status_codes, var, value);
> +	}

OK, the input is a simple string.

> +static int is_retryable_http_code(long code)
> +{
> +	const char *p = http_retry_status_codes ? http_retry_status_codes : "429";
> +	char *end;
> +
> +	for (; code >= 400 && code < 600 && *p; p = end) {
> +		while (*p == ',' || isspace(*p))
> +			p++;
> +		if (strtol(p, &end, 10) == code && end > p &&
> +		    (!*end || *end == ',' || isspace(*end)))
> +			return 1;
> +		while (*end && *end != ',' && !isspace(*end))
> +			end++;
> +	}
> +	return 0;
> +}

Ahh, we parse the string every time?

I guess it is not performance-critical (after all, we are talking
about waiting and then retrying here), but I somehow imagined we
would allocate an array of ints and pre-parse the string upon
reading the configuration variable.

Also 400 <= code < 600 is a constant throughout the function and it
is a tad strange to see it in the loop control part of a for()
statement.

In any case, the strtol() based parsing looks cleanly done.

Thanks.
