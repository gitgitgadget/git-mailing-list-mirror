Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FABEC4
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737787123; cv=none; b=Tax0EMpPof1apecqTZEE52YUpnC+zEi6TNt01GC64RyLDQdjUb6wlCq6XdKGUxeFGV6NGxSU0f5o7hVb2X5C2bAe4ZdjyOHOdi33GYRa1l9lU3kkqoxiDfN8kr8YFZp1eZplPUM2U507jJeNGLAn37AMraY1SCeUh4yeLR09tIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737787123; c=relaxed/simple;
	bh=5BGiONUzViVxlKMdQZXFjyCSFQhZb3cmArNFZ037iN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo+HtynQK3ZcMcJqmbftDxx4Y1LzvGtlrZxz6QsV60UWxFR/DQJBEitvtyjBiw14V0jHvPcfwvagCDTKglNwqutBT4p2h1dlsVcDhzI9ELDlZHo69GGGOIMa6ds1349JCGL+0VWNssG9BNTZK6j5uzjgFK9YkqTujUtOe+IwFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=emailcarter.com; spf=none smtp.mailfrom=carter.tools; dkim=pass (2048-bit key) header.d=carter-tools.20230601.gappssmtp.com header.i=@carter-tools.20230601.gappssmtp.com header.b=cfOkgQu8; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=emailcarter.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=carter.tools
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carter-tools.20230601.gappssmtp.com header.i=@carter-tools.20230601.gappssmtp.com header.b="cfOkgQu8"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-3eb7ca55c3bso1682067b6e.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 22:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=carter-tools.20230601.gappssmtp.com; s=20230601; t=1737787119; x=1738391919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqMMwjDt/mzy5AXVP9zIVntRYR8h1D1OBnjFXrQSE1U=;
        b=cfOkgQu8iCZPAJ2hJqqDSlakcwUiau9X4FGX5SVOQUcDb28PdnCs7Pi1W1y2cGh+tn
         goPokroo8FBvUWesl5y1fJlv3trNdLzPtO3GezCTFH3B3qeRfALoxJmb5ASq4vlFnTZL
         wGyE/KE96xIgrP3FXwb9F3UW8mxuqVorlbhzHDGKB3FaBCtX5B14PU+2Q1aI3ZFEsAE/
         CghVROZPmGIc3m2Ra50DlGJSuL55664LnHlKpqO1KOdnMo2TThQCAiFU1Grj2QTToIOG
         QSECo0/b8Vhclv7Ndb1cPrUZLPgyATZQrXx43mgvDlJ4oHGVaCukqi/cLknI3Xo6aDsR
         Freg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737787119; x=1738391919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqMMwjDt/mzy5AXVP9zIVntRYR8h1D1OBnjFXrQSE1U=;
        b=arSH8oku+VC3vC3Uq4T3tPGmwSgsIvszyw1aQh4iYwCHiseqCV1rRsdCa6byhtX0CJ
         Gpna7ltrj/EFhXd2vOYgV4oyPl6FtEHwzFoNAHwfe0NyVo4yt1d1vQ+rswukNkZwby1+
         hUIbB3U0U3QLH+0jYqLS/mXDziAVjgKvETk2oj0ksoz716uQr5Cr0cNTSQkVxLDWS7V3
         8G0tENb37vEaBPYZaHzqUlTrDG6Ixo4LArWU0sA7ltUdo9AZbUXK17shErtYmbUfljUj
         j72vcNodiWQ4u521SMIgpSN7KjRdwO0KaHGdCTtWTbfv2B4xMhE8LBZ71ywxaWuhyi0Q
         JeMg==
X-Gm-Message-State: AOJu0YxlhfTwbJppmIYpKH+0lVtTcdDFHKWl0v2/viLdEtqBT5cyBGfp
	rE9gQx24aL0OnQaNhxqMACtPeM9B+E2lx6V8b3GaZhuzWu+TWz24kuEaoZ1dZfs=
X-Gm-Gg: ASbGncvbh1nxV5rC4NVNd4IkgmWhXX8795BMI0tZXniG5tyrPeiXwFUvbZ12XtVR+vr
	LDj9ocLKd9YevJEVXUUyEQloLl3VDitghFxezgG6rgk6WrJWpnHa25blZPje2fiE54BpbpJBGK0
	OJp4CDd5nttbi8EX4o+0xRZj6SC7rmekvhTiutPm3mHxZkSN5zR71BwjZ6WZeY9wro5J5um4KGm
	rhbUf672XrbbXyoYiyA9NB4HgWVjhE6vgKp++Hp1v+GfAug98dW5DnCZiRr69IaJbXlAVKy4yEE
	DXi0LirjflwYNjy8tdBG5I3sLzlDcY5oIo4Ef0I=
X-Google-Smtp-Source: AGHT+IG1miw8MlkKPNOdxRhNLsyg58paSdqAq/VEc7vJVjz6A+Rfoq1ISxdJuGS/YpHz5hHS+l0YrQ==
X-Received: by 2002:a05:6808:8311:b0:3ea:41ed:5287 with SMTP id 5614622812f47-3f19fcb474amr17734153b6e.22.1737787119538;
        Fri, 24 Jan 2025 22:38:39 -0800 (PST)
Received: from ?IPV6:2605:a601:a5d6:1800::19af? ([2605:a601:a5d6:1800::19af])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09bcfdesm873116b6e.49.2025.01.24.22.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 22:38:38 -0800 (PST)
Message-ID: <f89f8ed0-1d0c-41f4-9360-4fd01b52a517@emailcarter.com>
Date: Sat, 25 Jan 2025 00:38:36 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: indicate http.sslCertType and sslKeyType
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
References: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
 <Z5GOfwBR7JBloIs0@tapette.crustytoothpaste.net> <xmqq7c6ltoib.fsf@gitster.g>
Content-Language: en-US
From: Andrew Carter <andrew@emailcarter.com>
In-Reply-To: <xmqq7c6ltoib.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/23/25 11:43 AM, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2025-01-23 at 00:16:06, Andrew Carter via GitGitGadget wrote:
>>> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
>>> index a14371b5c96..cd39e182527 100644
>>> --- a/Documentation/config/http.txt
>>> +++ b/Documentation/config/http.txt
>>> @@ -216,6 +216,18 @@ http.sslBackend::
>>>   	This option is ignored if cURL lacks support for choosing the SSL
>>>   	backend at runtime.
>>>   
>>> +http.sslCertType::
>>> +	Type of client certificate used when fetching or pushing over HTTPS.
>>> +	(e.g. "PEM", "DER", or "P12"). See also libcurl `CURLOPT_SSLCERTTYPE`
>>> +	Can be overridden by the `GIT_SSL_CERT_TYPE` environment variable.
>>> +
>>> +http.sslKeyType::
>>> +	Type of client private key used when fetching or pushing over HTTPS.
>>> +	(e.g. "PEM", "DER", or "ENG"). Particularly useful when set to "ENG"
>>> +	for authenticating with PKCS#11 tokens. See also libcurl
>>> +	`CURLOPT_SSLCERTTYPE` . Can be overridden by the `GIT_SSL_KEY_TYPE`
>>> +	environment variable.
>> Are there any particular limitations on these values that are platform-
>> or backend-specific that we should document?  For instance, I seem to
>> recall that at some point PKCS#12 files were limited to schannel or
>> Windows, although I could be mistaken.
>>
>> Do we also have documentation for whatever engine parameter is required
>> according to the libcurl documentation?
> Both are very good points.
>
> I went back to the original thread that added the change cited in
> the proposed log message [*1*], hoping that maybe somebody brought
> up caveats but didn't find anything relevant other than that we
> punted to add tests for this since it was too cumbersome to set up.
>
> Note to Andrew, when referring to an existing commit in your
> proposed log message, please do not just write its abbreviated
> commit object name, like 0a01d41e.
>
> Instead, use it in "git show -s --format=reference 0a01d41e" to
> obtain something like
>
>      0a01d41ee4 (http: add support for different sslcert and sslkey
>      types., 2023-03-20)
>
> that would help people to immediately see what the change was about
> and how old it was.
>
> Thanks.
>
>
> [Reference]
>
> *1* https://lore.kernel.org/git/pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com/
Thanks for the rapid feedback!

I was leaning away from including too many libcurl-specific details in 
my original patch, but I see I went too far, and these options are 
misleading or at least hard to decipher from my initial patch.

As you mentioned, per the curl documentation [1] the supported values 
are fairly backend-specific.

Git doesn't currently expose the openssl "engine" option. Because the 
default engine in openssl is "dynamic", in my use case, just setting the 
SSLKEYTYPE to "ENG" and using a PKCS#11 url in the sslKey field works. I 
can make a patch to introduce the option if that's desired.

I have something written up that includes backend caveats, and I will 
submit another patch this weekend.

Thanks for the correction on the commit reference. Please 
correct/forgive any list etiquette mistakes.

-AC

1. https://curl.se/libcurl/c/CURLOPT_SSLKEYTYPE.html
    https://curl.se/libcurl/c/CURLOPT_SSLCERTTYPE.html

