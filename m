Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976688;
	b=3qKa8m0PZGmk9RDA8jauoFYDer+2zVj581fHZnjnC2/S0gHdtaH5sSnoRKrbLnLl/Zuq
	 ad6WGwlk/00jKNKmr3jiTZwJL2yDrCZmN/MyvW1qnFhvXJoQ0mO6uBiP/3qzh4wUBMEDW
	 LiNMrHk7ECHo98P0vZVZRYyUnuLwiGGnFUPZVT1mmlHHQGiMb6AC9iBcqtQpFx66WHXS0
	 or00bMvbXQMx1G/JlxURthVRJ2OibnoIT5h0ORRybt/80fbo9CImysPlBnbsEbtUp1+ib
	 1Mz8iA2z0DeHhv03BvvdIIagn+AsuP/nxSJ7lPbud9b3fQsOn5BhA5P7+6Kjx8XLx4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rCuirL97yZZLnBO5Y1xZcCivORfOw9CTHiyk2LjCJF8=;
	b=p7ZvQJOlPUAmKaYKemiQZWbX7LcCY4v6ohHFpPIY4YkhblLPfIQqpg6ws9SYtKy+402q
	 bRZWxxo/u8Zytkxsy7E57pmhEWYZhGYEhliczx5qSLeJxbRv4Nts6kc5biXbJ/n34n15F
	 DCgiG16Qu0V5Xh5q1+OYBGLyHYlYzS6IdVdMcRS7OjTnP9kWPsTS/YYB5cwPmnRpjFH7T
	 LIaV0VPwrR2zxUZMGHvky5iKM18jHmuwHKFnxqgPtC2GFQQIYptH7rsP8eJ0jD41wYN0I
	 FgsUcflijIx+4Okw7u7jvoceJjXoIknAIAtPxXT5p3y127/FQK9pqPp5ldLt96kOKsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uynD+mhe;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B597606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B597606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uynD+mhe
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f259cdc86so65434485a.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 06:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976687; x=1794581487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCuirL97yZZLnBO5Y1xZcCivORfOw9CTHiyk2LjCJF8=;
        b=uynD+mheV3WDCdLZ0fvPB5ZzpRn+5ERJs2YCIgBxWp9/Y/o6e484C3lS6IRmAnFiNh
         CpjuClG7Oi/Uu6pN0hqQlXIA8oyRHoIMABkuOvVo5gloyKNDpYco+/vz4orWBRoZdTIJ
         iqIqe5ScUL6M36hQWCVbXYhAPsivyJbFeeB6YelE02j2LylZPl8cXhPCV45VzeTuaij5
         0AN7Dud0EHs987yY6UFAieORNUAs3fQISNA3/6JP0fe7HBVdm4F896aXSTbf2ZBYQBH6
         dDt+rAk1seUmIQOps5d0WeDjo+7XrDV543QQazROnkidaN3VgKSlHuP7Kf19Yn58PnES
         WIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976687; x=1794581487;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rCuirL97yZZLnBO5Y1xZcCivORfOw9CTHiyk2LjCJF8=;
        b=1QtpgszCaLy/Fk3tL/rAkeRB03Bc7HjG/Oyu/tEmlIomniZa7zVym3h3sWrwUntiD9
         Vhf3ssCtrCES0OrwF8kThAXDqGa9SgQZCiT0Of6dlWIZBmfd2gRZmqpWug0tXVv+mVi8
         BdzIwGW7a/mtKK3HOYuMxvrdykey84F/dCHKuHLZU4/knOSw/0guyFNHBRW0uxRvyuYD
         4J+7+JledLNmGwhukaPcw7DcnKgzU3GzREamcGEPzNlHvbHQWows3H+DCJqTxChs+T/Z
         TyRJG+14PeOJ/Ljf06jkJIU0ALwC1qJ2SnG2cTtt92xqVsKB8mcQ01s0lUiOFryDcWzL
         YH9A==
X-Forwarded-Encrypted: i=1; AKwUvBzk0TdbWecP1qmMewuxc0sVIeq/rm2ZiF6gCQAv2zFqVujoYYL34OOpXMMc2SR3mpwtqaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8R6VCOsuncuRzRT9hjv2CcrugGb2aFx5izR/8wGB6pJc7+WMc
	GSPWXTELgGkIkF+nYMHEd5BJMw98jktZwBeFG/OiQdWCi0Vx3RCgavxE
X-Gm-Gg: AYBFou21wKvG6jQlu/PRB/CMoUHF9C/n0D/tt5Gtml2XqBrai15Y0w1GOiKBEUdwGNu
	+beFgtvbCVkvB5Zm4WNx69gsYJi7C9i0RV6+0Pxy6TustaHxbOm4SuJhJpuLjEpaSZbDbeBmDpe
	flbwzSdj/vwq0KIb3Rt2YGgIYNown+la47YT8cmrHAtZb843pusUxkXrJrIwFwrgEKW6JznL+B4
	16/vtgonRiHIcA+2U5nEz2aEP09uwXIZGGda6Xiv/3REG+MfyrVXoXMimwiWxTUcgsg+DhWJFH5
	56060yrky4UTQLa7yUq62suEp1PjX4LIvh4fbsUcDWzxtxWRo/76S+z9DL0yJOXrTWymSkvuz7p
	ZL3fyZ/8sCz6iMsVn4ISK29yo34ulJAtW5Lm4n88QdtM3Lb136MY+cP5xW0RF2a+hzJFusBSnSF
	aKcXBFclFpEzHr4q5MVDi2q7n1tF20+bO28YSM07Qf/eDTh6iDZusBkaOAwZ2gw31G9diQMDLFj
	WPIDq4HQ6QlhPcaWuRGQQvZc1QbkXcZch2Bmo5gaOAkmxILb71m6ePbqiTMeLEmJH6yT3Y1eDKE
	3xq+Q8dQzL5SeEU2s960afXma6sCgCYlQ9O7wRlfV77brgCFbBORSwqSiT8SvUA/b1vFTU0nD75
	epJSnjWwCalptkBsh/wsyXZiPppqkX/+Nm3obwySmFx9NMx0ALjKtEKO+rU7jr+I+IwaNTUK/Ku
	xHhfXnr8HcBLE0u2SSyxcCuoLD+gw8EO68ohFlw6Le1/EokkuNIAr/toIddxTFXa5e3ZJ+LohU8
	Q==
X-Received: by 2002:a05:620a:2b92:b0:93f:3e45:a419 with SMTP id af79cd13be357-945f3537dbemr388027685a.38.1793976687245;
        Fri, 06 Nov 2026 06:51:27 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5a95e82sm157717985a.12.2026.11.06.06.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 06:51:26 -0800 (PST)
Message-ID: <0ad84940-b107-4015-849b-f91f1e4ac1d3@gmail.com>
Date: Fri, 6 Nov 2026 09:51:25 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] bundle-uri: do not die on unresolvable relative
 URIs
To: Aniket Gupta <aniketgupta3001@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
 <20261105152842.566318-4-aniketgupta3001@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20261105152842.566318-4-aniketgupta3001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 10:28 AM, Aniket Gupta wrote:
> A bundle list, either advertised by a server or given to "git clone
> --bundle-uri", may contain relative URIs. They are resolved with
> relative_url(), which calls die() when there are more "../" components
> than the base can absorb, so one bad entry aborts the whole clone.
> 
> Resolve them with relative_url_gently() instead. When that fails,
> bundle_list_update() reports the problem as an error and leaves the
> bundle without a URI. The download code already skips such a bundle,
> so the clone carries on with the others.
> 
> This resolves the TODO in t5750, so update the test to match.

This TODO was added in ebc39479558 (bundle-uri: allow relative URLs
in bundle lists, 2022-12-22) by _me_, so clearly I thought that this
was a good change at the time. I should retract my concerns about
the change from patch 1.

The only thing that is different now is that the feature has existed
for a while, so maybe some depend on this behavior that we're
changing. That's unlikely to be important.

So I'll officially say: thanks for contributing this cleanup!

> @@ -210,9 +210,17 @@ static int bundle_list_update(const char *key, const char *value,
>  	strbuf_release(&id);
>  
>  	if (!strcmp(subkey, "uri")) {
> +		struct strbuf err = STRBUF_INIT;
> +
>  		if (bundle->uri)
>  			return -1;
> -		bundle->uri = relative_url(list->baseURI, value, NULL);
> +		bundle->uri = relative_url_gently(list->baseURI, value, NULL,
> +						  &err);
> +		if (!bundle->uri) {
> +			error("%s", err.buf);
> +			strbuf_release(&err);
> +			return -1;
> +		}
>  		return 0;
>  	}
>  
> diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
> index 70ae94c4d0..8abf8f31ae 100755
> --- a/t/t5750-bundle-uri-parse.sh
> +++ b/t/t5750-bundle-uri-parse.sh
> @@ -68,17 +68,16 @@ test_expect_success 'bundle_uri_parse_line(): relative URIs and parent paths' '
>  		uri = <uri>/bundle.bdl
>  	[bundle "two"]
>  		uri = bundle.bdl
> -	[bundle "three"]
> -		uri = <uri>/../bundle.bdl
>  	EOF

In the context of this diff, this looks like you are removing the
bad input, but this is actually the expected output of the test-tool.

The input is a few lines earlier:

	cat >in <<-\EOF &&
	bundle.one.uri=bundle.bdl
	bundle.two.uri=../bundle.bdl
	bundle.three.uri=../../bundle.bdl
	EOF

>  
> -	# TODO: We would prefer if parsing a bundle list would not cause
> -	# a die() and instead would give a warning and allow the rest of
> -	# a Git command to continue. This test_must_fail is necessary for
> -	# now until the interface for relative_url() allows for reporting
> -	# an error instead of die()ing.
> +	cat >err.expect <<-\EOF &&
> +	error: cannot strip one component off url '\''<uri>'\''
> +	error: bad line: '\''bundle.three.uri=../../bundle.bdl'\''
> +	EOF
> +

But this err.expect matches.

>  	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
> -	test_grep "fatal: cannot strip one component off url" err
> +	test_cmp err.expect err &&
> +	test_cmp_config_output expect actual

And now we're actually seeing the list match the expectation (minus
the broken item).

LGTM.
Thanks,
-Stolee

