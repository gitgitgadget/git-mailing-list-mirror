Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560245;
	b=ZWqT48a5F3bkWSDze3V6mzIcuQPCPS4ncOt+iW5I8demgFGsERqfBgCn1ybLeaGzaoGl
	 b1uMs73luLRcG4TuEzAKcrcIVdcPODvtT7w+IVzVU9dQdg9gKQn4CZdn62fVrPmX4ty/j
	 FiUJFmFzkriGXd2y/B2VZcfPVbuQHT+DkUmrBlCsMAzKzHV3pgsNs/nuHw9QAHhMAe0IE
	 UGUFlyKqiX8BWEluiJxKTPv0b4tJNF7wIgL5nwoqTiqH/JcdvfubwarPpVQF5Mm7G0Mt1
	 sAE7Y/Web9rxwFMigPHqLW4eYg7nWR7ewdJsPURX1fQ/U3808pcH7umCcB9kpNoLXvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560245;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=m5WoKTtTP7rr0bdIQDSnQ87Er0Wvo7xlDuECE676iEs=;
	b=elyofia86XwNh1wDJitZ81UGXZp+aay8F0f/Ad57CmhGghjrioblVTCbn1WLPfmGNkKy
	 MbblgWXLYeOx2D+0bnw/LGTeMjDDjGM7Sa0EPhxXpOp7ghZsW95FT+ZQAgGeZwdzIaxbY
	 RDVBZexEIBVEQeD+uiJruL7Avtw3l7Z40bCDdUSoqjGGjbp/LY1EbJUzNGCjmAghTCFBQ
	 sgGjM8Nc2vRuLwXY+iuCOAMhkvcV++9kAo3IF78gwWD4ffxS+2OReEDcGXVxJAQ4f4vfC
	 F2r5scfiOaO4jmI/ler7s+zJg4Q4CTkAY3pO5O+2wgfG39h2GNjmdjD2STqqJnhawow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OORhoPTS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DBt60UuD;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76014606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76014606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=OORhoPTS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DBt60UuD
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9AE5D14002F1
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:44:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 17:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795560244; x=1795646644; bh=m5WoKTtTP7
	rr0bdIQDSnQ87Er0Wvo7xlDuECE676iEs=; b=OORhoPTSQyld0XYNB5v5wBzT5n
	uUgC1CIYmiKABYpJarIe3jiaQwLvIcituB5Y+Lw2CEPNKgRETLMY43zuh4WC8mpB
	FLS7Sv9TO8kk4j+VW9UXL6XCg658s3yi01x8ziOm/iuZYKt5Ilsgr7gBbEmgg438
	k0m5hV3U9W69GRXXW5OJz2PlLRlvh1JXM7Ffqiwe2+SrbgfDzODb9vPyWfib377K
	YdbLoXGayJGHmcQ2eNaD9/tdWNAIK9UdSi0yqpZ6rjy0y1kzXCFrX1f+h90K7zqz
	TiFbrRfOv7l+nZoJnq3fafOH9kN6Ad1JpwlETuFLGUmkQMZP8bhToudZC79A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795560244; x=1795646644; bh=m5WoKTtTP7rr0bdIQDSnQ87Er0Wvo7xlDuE
	CE676iEs=; b=DBt60UuDtEgji48asoEM6JbpZKU5NmTQRHfdAgtsUayCxhGvW0s
	T5QzwjR075rrCWUPAiHmQyUvNMPMQBY/Xcb5v6L9zq5AROfc5PU+oT/Qaaols7iN
	EYPNejYVuIPveHgiv5KP4iBNmlu57SzAuxlHeIfvFke24qTTbOX+wvKjAg15EcU1
	ZSmxDq/YcPSItRZ1DIjaQQS8CbWbyhbFlaHVkCtG3x76y2DP12+aKddIZ6VO6m2T
	f5I8dYss0egTm8i+EzWUI2gviVECErwf7VIWECsOUlENMSt9XBTcLvZuS3Tchs67
	cj2Zzn1lGAuz+ywxDVSEo4/kY/+KQiW/YSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795560244; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RJZ1LCS4MP4h1BWT5K2FezrNhggzjseUJXvKcPFUIfqoo1F
	xT0r4exq0N098RGTKdtjbRnVOYS8RFYoy3rOLP44tqEByNBUAhZ/XAflCoLaMjqK
	DSln78rMSzQKKueqImkpiakpJb3pVqja1HDKswG8XYCHH8qnJxH+Ec4sYpXIwUze
	M0rEd2UsdzQahjd0dPGdXz0G3DORlFChCHktygTJrqPvB7i76cZQMbwxuR1KrU+6
	467VxqzN6KgJss1y7UjzuLPidIpYZuAw4dfyewaWyNtD7ppKh9pUdlMN1/Qncfk2
	42LDXCxdmHxJqIBHconjF7QJZn4iAMbMel6MaGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:6KdGNH/goOGWzKILStbtrmeML7o3SHSNnDtqrrkwZok=:d5oFQ+nWMeYr1oXDiwMqQwmgJZ49j7WG0FQQOVRNQks=;
X-ME-Sender: <xms:NBMGa1Zcdw5sqkWiqeouvaobhxXLkppCYkr5SkRV9Zm1TqbHPcVojw>
    <xme:NBMGa-qY3RfQPBlL0s4YXR2EsejsFT5tDYyefFBjD-TWthX7yskgUaLvgZhpX6uTL
    sWQxWmKdP8ZmjVsXWuit4_tZvD0S9_j-5yYTfWDSJmX2e7XdY8tQ_g>
X-ME-Received: <xmr:NBMGa6MzuA9JVSEE5VF1SqGdwGbTpqaVFDilEsme4U21eGhmBzRStyPK9lSYTv4DRnhlCQoTv2E5_WFp8H4o6L_goHnaa_2kyEVTtIc>
X-ME-Proxy-Cause: dmFkZTFfw/X8rsaTakoeCPIU8av8KK/okQrqFb+cy2xXz/6DNNA3X7WkffPsK6aAwns65I
    +Hyq84qdrtkLwOlmCDZjxNwcKoj0NaMLNIqasGO6ZxBkhxGceNauTNfe/v7SsWS79nqjNh
    87Yf4V3v3oaDH/UYp/kBhXKIHPSgWmDnh1Nvd0Ny+p/pgW7E6o03HpuwrnefztrDxnN5qv
    5Vn4a53gxDjjSvLDBcPFvTHfk0+7MdmYvfBH3XZp5TWBN+dJZyyFoE5+N4jRTgdjLmy/eP
    l6YaAiKSjsklKeuvbeXW9LE8SVzLJsUEgwN0hlusiwN5AdliIMf12vg17fCUPuIni8dyVp
    d2aFEEJ1rMZxZDHSVhFIC7NqGqNzA25Enl4Y6P8W84W8K3STNpWudhoof7roQZDkQl8w25
    Sfe62BNmw6g7FRADEmBBsUo55cqTtuxnZtg2IXyqMJNicNgv8Whvc/hhhdM88m9xYK2DXk
    N7xYGK7o8aNf6nkSZfUo1vOjhZ884eu+vFpUs26SdA3R3IhJ2JGsotJt6LnPBxV8roUqL4
    6HBBnIzPHkcev2m2y4MtnF7Dupxuo2YHVzkQtG40SmyVZ+fTRhGTABtj4L19h39Fy+XIsy
    qSsL3nONx5RPbAYj/4SOz0tMGMdhyeF6ke+XNzYUSh4E5lQdO1vApK3Fpufw
X-ME-Proxy: <xmx:NBMGa5rcxbKTeOUOE8mnrhzg0RrOfn_g1a3OroW1uhkEbYXGWFrFSg>
    <xmx:NBMGa_cdHhRf-RhQ1lO_ENt02e7-MHYfhmKuKoWq-oByVOhtAHgyhA>
    <xmx:NBMGa_QLwMMUfJtLHgrHW9C9Ogqy8Z7SAF775CGTm3F6hwwazTM0mg>
    <xmx:NBMGa4aqTPQie-R116WbrnpsJEj7yQA1NwxbMufQ23itCMcalruyZQ>
    <xmx:NBMGa1oETfD-7fp8MyYaM4h9kyB8D-MW_drtXZqlHjsGqaLVSSvMoDef>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 17:44:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v4 3/5] http: add http.retryStatusCodes config option
In-Reply-To: <8dc66bfca4f42b1d847cf5e39d5940e0150ef2e4.1795103883.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Thu, 19 Nov 2026 15:58:01
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v4.git.1795103883.gitgitgadget@gmail.com>
	<8dc66bfca4f42b1d847cf5e39d5940e0150ef2e4.1795103883.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 14:44:02 -0800
Message-ID: <xmqqqzg9kfyl.fsf@gitster.g>
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

> +http.retryStatusCodes::
> +	Comma- or whitespace-separated list of HTTP status codes (in the
> +	400..599 range) that should be retried up to `http.maxRetries`
> +	times. Defaults to `429` (Too Many Requests). Can be overridden by
> +	the `GIT_HTTP_RETRY_STATUS_CODES` environment variable.
> +	See also `http.maxRetries`, `http.retryAfter`, and
> +	`http.maxRetryTime`.
> ++
> +Service providers are expected to return HTTP 429 when rate-limiting or
> +overloaded. Configuring additional status codes (for example,
> +`429,502,503,504`) is intended only as a temporary workaround while the
> +underlying provider or proxy infrastructure is fixed.

OK.

> +static int is_retryable_http_code(long code)
> +{
> +	const char *p = http_retry_status_codes ? http_retry_status_codes : "429";
> +	char *end;
> +
> +	if (code < 400 || code >= 600)
> +		return 0;
> +
> +	for (; *p; p = end) {
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

http_retry_status_codes is a file-scope static that has the value
obtained from the  environment variable or a configuration variable.
It may be worth noting in the documentation that configuring it to an
empty string does not restore the default (i.e., 429 and nothing else)
but disables all retries.

It is outside the code touched by this patch, but because
handle_curl_result() checks missing_target() and 401 before
asking this code if we should retry, 401 and 404 would not be retried
even if the user includes them in the configuration.  That may or may
not be worth noting.

Overall looking very good.


