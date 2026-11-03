Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712078;
	b=iOAs6TKBxX1CUn7ou0GPjIkdcCOn623kRYSw7/7Vwpl+aK+Bxt1uOTr8twmRvasxrwcf
	 PTi8dZgiUSkjt3cLc8h4n5Rn9eiv81Ycumjox4u+UsVDIltrK0I9/BLySXWT9XQg/lC4L
	 dQa65ypIdML5aTSCYR9pwOrabkTcfer26jRNh9t0CqIqJ8W9O6UaXJPcpx9XGsvqVx8Nd
	 fiZ/pB3PmjJSeRQBf6cgHBIgdsayy5136y1lgKgF8Hu7oL8RA2WdcTwMHdloRcWNNQaqV
	 3ApBVX1omJWipjc3LnMJqmcSrW2fJnxq2adSAIa2deOBI/yeJURILAboIFQttrxrArw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712078;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=yJrHqPB6WeB/Awzg9jth3tjHvukhNTjW5/xiPkyeL2M=;
	b=KVhbFhno872YAsVBATDqjYey0zspIU3MZ3jTf4Ar7elZw1NWE6BLkGRvVofe+YxqAefs
	 0K2sS22Boa4QNvLrVzgXu9QMU7ByZhO/AKu5DvcVsmAvchY1E7anXdaBmcsvA+o+IchHP
	 lV88WzsEk6FgQh7d2Twrvp1Ry1MEZiR1lS+2m1PMBtmQmMmU80Q13KMkfv+mPExu8h+uD
	 ZyOl7610mWIzC7K2D6kWH+BsHnqnVkd5NWeLN3Ez1/pgB+uVWt2gHtZgLaRjwqmbuupWj
	 M1NakoYT1CTsSe+j4rKak01SCp/7Z9aPzE+8Flq3Tm41NVRcr0vgcyjFmpBNqH+0b3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZtnpMIT5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vqz0BJWU;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F6606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981F6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZtnpMIT5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vqz0BJWU
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C4C74EC0235
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:21:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 08:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793712076; x=1793798476; bh=yJrHqPB6We
	B/Awzg9jth3tjHvukhNTjW5/xiPkyeL2M=; b=ZtnpMIT57jf673YIvmQvCfYtPb
	sP47Coq0WbrpdTN8zocnvewpkedZSAnYs5khSmNF1lbWm+DmunzcMhdR+/ZXeHXO
	S4xrRoz9ZGiUx0vKmW/Ob8hmddsGZxRw24m1MBCfvloVZVP2W59ZrPgePLVxhvWo
	LxNywLO7oM9HaryT439uN7lH1Dqjh+I4kxX8CcCYXE8ItyEs8b4Q+pa07Lnl+sGD
	ynKHkAo/swHOsKB76qZv9BbNw1SDYxmF0nDr/HuQcTHy/6qKjQa8jKpYSs/0ucoT
	tL+dCgKH3m+8rUXXl2qPWey+7W5O4DKX88juTAJt1KXN6JqdY0pTzkyNMhmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793712076; x=1793798476; bh=yJrHqPB6WeB/Awzg9jth3tjHvukhNTjW5/x
	iPkyeL2M=; b=vqz0BJWU15tFI+H6HS4Eu70t1cV6xWuhuJ1bPNbs+3X/t6n5SNh
	nrfSl5OoOp9MeaMz1c6Q/NlifVeAYL3ng83n+qeHKP2fUuxQegE52SS4i6NWvskw
	UNk/tHu6oVDwKlwcfqiE3+87YH705Fa7TimEP3oRwMGlnNlvpU9iu/46gXvzlzE3
	JMX0hbp+vg8ustsuoqGM/Q++EHFNLbjYYBtpzUqUmBBdyucpL3HfAsBW6XZIl7zg
	DbEd09J5PDuREewQQTGymjdZjY0vWaQOCMup9KlCYjAZ5MjTbYbAcRiGxosOnyru
	AW1P2Jm8COoDGtyYajw3XnV1RJaTysMgS5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793712076; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:g8Bb2ry3sC7XgoP1c6/Ey1djd3zqFNHiK5HsjmyT8LG226D
	qATD0TZfJVJoPtugort5PIs8C/Jjgh4b6ZKCJhSpidz65v7twOuWOTKqVkm6UpKI
	629HTYPiv5qgsglCbAuGawf3KudUZZqsY1trFdwlnrfeLWAqanSlBYPu9/V4QDDP
	oIRvXfScEHl6MAngnmh/uAjgDAY6Jp8/GrgtmztJZGWbFo9THy3GR7a2PWkSeTt9
	B7lBcBFYXZECWpsd66Ti1bpFs8A0QYtutIKwTC568UFE2eYqQO6/OX89bZYas/UG
	Q0FIOHta6iphrLhiDEHRuNEiR/hrNTfLNbvGTFQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:MMxLhfU1jwAPdzP4utDKJUjG45jSaO2Znwo2qe5MNxI=:KcN/xYf1tJ7R2v7JE0JhGR0XplzwsT7i4FWnF+jtysM=;
X-ME-Sender: <xms:zN_patdzWY5iCwJuAnJOvZlHK13bqPYUGXmySyFdQJWG5CY0npZFhg>
    <xme:zN_pateAKzX3rz5-GAO3a3vt3Xm2gTe2sQBC9_xA0FUUP23sU5byLoakOuOwSRzxy
    TQbjWdVD1hBvhAs7u3QOMrS-ba5F7sXmTMayoZ_0s1iWk40giP6Q2I>
X-ME-Received: <xmr:zN_paozhvtzIhcuH_1RFeFzfEnZ2ND5u4d1ANXEXu97zzfR7cUlYLadn2y61Q2J7PFsZS2rJrkWT2me-P1YQtrUHPedE1rW5IFkt>
X-ME-Proxy-Cause: dmFkZTFJhkOAjt7dCvnm4wIT80rvScN/wMOFPgv66G006BD5ibUpt/GmHJNYtWUGRgs24L
    CW1WbFrSrzL3zztVw8/o3MBk9DqeOkv+K3F/gS7FjZ/p4zU6qDyCWjDh1A6jJ+KKDoK5Um
    UthWavjmFdKCZNtnEzWPBSIsjAHxlhGcozgGxzbe67DwYDv6xVifleqrwZze+lEzxapQA3
    JhOr4GF2zX/7V1lUFLhOm2kcSWNW9dihIRBRUn09YYzSQLp9AJ8DGbitMyn1Jy1tjTRwqx
    jNUNTEL+ZPHyp5dPinzI3nEHyHIaqWOzx8Cdmm3JlH6Nvzjx/xdjWNn6D9wh7Ua+cH2EKl
    5RKoGXv8Tka12l29uylNWalv5eVzNFQWbRRbm9ihu5OqfLQI9GYi1yrt7pr8m4pzQDLKIu
    Lk5OsTz+0SOMTA0FLR2enO/E8+3qsV+P4+PfvPJ3Ef8eZdKVfRjG+JLs04bx621k8sGl29
    /woUNqTWq1OaoyxcWxOhfNfDLgXupyy89WLdqz3AWSphCPgBgzlPQWTobUSo2I+LHhPCRG
    qv7fbdN9AUYj4vRsLppgJAuONUMNWCYNAswmmFHoP1oBHmMqkHls/uREm8ri9Tv+7SCkWL
    3HwZchrFobP2dTgWuHWIc7VMiwV1HgoWI7tr1QBjBvvCdlFhiJ7dczHSgo3w
X-ME-Proxy: <xmx:zN_pas8-qV_ft2c-g6jGE65Y5Lyi-TcV-PbCQgLVG283z7jnuZCTTw>
    <xmx:zN_paoiMBnoR8kZGgiC8Cy6dMH5oxgRRZLYddLIs7Sz9W2tN_We_PQ>
    <xmx:zN_parFluaaXG0dIftyiR3wMqG3WvzY2Yllaf0agk297w_b8qbwZAg>
    <xmx:zN_pav-tUz9Cz59kXVFPtuGFGjb6bPBVR_ewcbJ-sYmtv1qON5CIeQ>
    <xmx:zN_paoerwDDC5MBlP6VugmBSrK0PPJORy2hmlGe7DvIqN1ySSBZuisOr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 08:21:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH 2/4] http: add exponential backoff without Retry-After
In-Reply-To: <36cef34668b6e2ceb867ca99029e8bc11d9cd63f.1793462224.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Sat, 31 Oct 2026 15:57:02
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<36cef34668b6e2ceb867ca99029e8bc11d9cd63f.1793462224.git.gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 05:21:14 -0800
Message-ID: <xmqqpkwmaw51.fsf@gitster.g>
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
> When a server returns HTTP 429 without a Retry-After header, Git waits
> the same fixed http.retryAfter delay on every retry. If that delay is
> short (e.g., 1s), Git burns through all of its retries in just a few
> seconds before a busy server can recover. If that delay is long, even a
> brief glitch has to wait a long time on the first retry.
>
> Pass the 1-based retry attempt count to handle_rate_limit_retry() and
> double http.retryAfter on each subsequent retry (1s, 2s, 4s, ..., via
> http.retryAfter * 2^(attempt - 1)), clamping the delay at
> http.maxRetryTime. This keeps the first retry fast while giving the
> server more time to recover on later attempts, matching curl's own
> --retry behavior. When the server provides an explicit Retry-After
> header, continue to honor the server-provided delay (or fail fast if it
> exceeds http.maxRetryTime).

The logic makes perfect sense (I am taking the above description at
face value without checking if this really matches cURL's behavior
myself, though).

>  http.retryAfter::
> +	Initial wait time in seconds before retrying when a server returns
>  	HTTP 429 (Too Many Requests) without a Retry-After header.
> +	Defaults to 0 (retry immediately). When set to a positive value and
> +	no Retry-After header is present, the delay doubles on each
> +	subsequent retry attempt (`http.retryAfter * 2^(attempt - 1)`),
> +	capped at `http.maxRetryTime`. When a Retry-After header is

It somehow feels that the default value of 0 (immediate retry) does
not mesh well with exponential backoff.  Will we keep retrying
immediately after failing until we run out of retries?

Also, it feels somewhat inconsistent with how maxretrytime is
currently treated.  Specifically, when the other side tells us via
Retry-After, or the configuration specifies via http.retryAfter, to
wait longer than maxretrytime, instead of capping the wait, we
immediately give up without retrying.  But when retryAfter grows
with exponential backoff, the wait is capped at maxretrytime instead
of resulting in an immediate failure.

The handling of maxretrytime in this definition, where it caps the
waiting time before retrying, is definitely more useful than the
traditional "if we are told to wait longer than this, we fail
instead of capping", I would think.

> @@ -348,7 +351,9 @@ http.maxRetryTime::
>  	handling HTTP 429 (Too Many Requests) responses. If the server
>  	requests a delay (via Retry-After header) or if `http.retryAfter`
>  	is configured with a value that exceeds this maximum, Git will fail
> -	immediately rather than waiting. Default is 300 seconds (5 minutes).
> +	immediately rather than waiting. Exponentially backed-off delays
> +	computed from `http.retryAfter` are capped at this maximum. Default
> +	is 300 seconds (5 minutes).

> -static long handle_rate_limit_retry(long slot_retry_after)
> +static long handle_rate_limit_retry(long slot_retry_after, int attempt)
>  {
>  	/* Use the slot-specific retry_after value or configured default */
>  	if (slot_retry_after >= 0) {
> @@ -2427,6 +2427,8 @@ static long handle_rate_limit_retry(long slot_retry_after)
>  		}
>  		return slot_retry_after;
>  	} else {
> +		long delay = http_retry_after;
> +
>  		/* No Retry-After header provided, use configured default */
>  		if (http_retry_after > http_max_retry_time) {
>  			error(_("configured http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
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
> +		}
> +		return delay;
>  	}
>  }

I guess what is in the loop is a tricky arithmetic to compute

	delay = ((delay * 2) > http_max_retry_time)
		? http_max_retry_time
		: (delay * 2);

without integer overflow?  Very effective.


> @@ -2449,6 +2458,7 @@ static int http_request_recoverable(const char *url,
>  	int i = 3;
>  	int ret;
>  	int rate_limit_retries = http_max_retries;
> +	int attempt = 0;
>  
>  	if (!options)
>  		options = &empty_opts;
> @@ -2498,7 +2508,7 @@ static int http_request_recoverable(const char *url,
>  			BUG("Unknown http_request target");
>  		}
>  		if (ret == HTTP_RATE_LIMITED) {
> -			retry_delay = handle_rate_limit_retry(options->retry_after);
> +			retry_delay = handle_rate_limit_retry(options->retry_after, ++attempt);
>  			if (retry_delay < 0)
>  				return HTTP_ERROR;

Interesting.

We already have to deal with the maximum number of retries to honor
http_max_retries, so we must be counting how many times we have
retried so far.  But we still need to introduce another variable to
count the number of attempts.

Or would it suffice to pass (http_max_retries - rate_limit_retries)
in place of the 'attempt' parameter?

Not complaining.  Just making an observation.
