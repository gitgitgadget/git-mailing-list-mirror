Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551315D1
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734387; cv=none; b=h597ev+nLobRe8nfvvgJldqpwO/TEEdR0ke+I2aaXijByWy6sfG9pBn/eFT7XHL6Bx6UAR8s0FXwmAXkmLYGJqQkKG5M4I8l3FuUZXyqLA1AV6c32s1/IFTGLb6I1oL/yPOBri8rqnz3dJcNKJFxF9iuFBsVly3rA1hUBPywd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734387; c=relaxed/simple;
	bh=tPzuINsYDBLlfOhI4J2szmlDib4kJDVzwGqamoAu75E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W63PTF7NOVIUTprMJXw6fF/SUuTADEM9EQirk0u1YX+4FKVc3Wdiu07k44W+9ouJQL4xLg06//qKBwkTGD7IwnKzw9Fad3oGYfjuOZGYPqd3TgilaMrUgWg5tqdhqLQR4DSzbAi7BEVPPd3cNeHLgeYhC1JYx5BKovQ/C6WtQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=emailcarter.com; spf=none smtp.mailfrom=carter.tools; dkim=pass (2048-bit key) header.d=carter-tools.20230601.gappssmtp.com header.i=@carter-tools.20230601.gappssmtp.com header.b=XFcGQUkq; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=emailcarter.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=carter.tools
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=carter-tools.20230601.gappssmtp.com header.i=@carter-tools.20230601.gappssmtp.com header.b="XFcGQUkq"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fa8fa48ee5so1828991eaf.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 21:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=carter-tools.20230601.gappssmtp.com; s=20230601; t=1738734385; x=1739339185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XJrCzx6bCaW0ufjf9PugCigC1G0OLsjoSkdEjEFOO0=;
        b=XFcGQUkqNbA6E5M+bnUdLtpuEsr7ASJW5RY5+W9b2A1sy3K4eJ661/Ff9LlXiN3WME
         0l3CFhBeeGTtee5rJAe+KWqHWGKuxPM3dOBCxY6M4/Muoz3v/9qSCMhWxOcEkwCdfEEj
         3CxnqHL1gOfPkFJ/mWePtGAr03wJmrusvuathwk/CJGM2uweiXOzWLX2HSCZfpbfLaKD
         dj/gxxSqf0E93ckbppXp63go+84Ny/yo6dA52/zm8z1GVgjuTDHvKZ9oJLqBxh5eXUtQ
         Uh06XGKMEj2i5B5WW8udkH9Bs47Lf72fiQL3XaC8L8xFIVztdHU8WZmXNn1gTxxvIfTn
         oPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738734385; x=1739339185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XJrCzx6bCaW0ufjf9PugCigC1G0OLsjoSkdEjEFOO0=;
        b=BsISXaVIHzIRiwBc54RAOggq5xvMVMjm7nbd9nP1uoNT07RQGqZAMNzckafGbg4dJ6
         N0ru4EytQiWt5EQ5VDAdma2dd8yUVcXCckcSYOWjY5zRUMWi8xz4LXCFIwcP+VrfV2lp
         5NmMTNPk/lV16iSLyQ7So08Sgw/wuJe0w9jjhY9APKQMRMot1BDCDQWMX7a6auDYhgk4
         W11Nn5ph37nweXPrkiShcLMotQoZrCp7cu0Og0iQxWXpRzb7apcRowszfWj+F0JJMl1I
         AFihyOM845yRzwlQm+66TyRQj+hQFTXmkJXz+FJRkkCcbHQgtcFG7QRIXndvIgxDXk10
         98JA==
X-Gm-Message-State: AOJu0Yze3qC7iamPztCUzVYttbfIqbdTy9KHuGet9hXNa50V1KvAcKIz
	w5Up2YttvRRRctWfgYtmSjGtEKjym9zn+FNh2OwixW5ImSoRlyqZ4qBTTJ9nUoo=
X-Gm-Gg: ASbGncsR6V1a7ouaP4tjvyjpqxAFqHUE9fGfeMMjDjagdAD0wMGELnS/JaFn+FV5TsN
	z6PnkRpdhXhPkl4E7dZSDzvfrF4Nupfw8rH/F274xjnct7qMBWALzXuCc7FY3xpPynNrgbEh0rZ
	GnjJxk/Xh2+6OdKqtR/RSLkdEGfFFPLgeQVwSM81Cj9EiLKxtGgxvK8YGE5GvUJBNFK9dmMon25
	JF6VyhOOvMjF0o0qF5FZwK+nstc+kHE4o3eUWXP5w0qT1twhmqaZz4E/qm6Fo3L2cOXae7uKB20
	AgxvHZMHOOo+jzjpDZe+w+22A74sb0cDoAaNEp4wXtHb+W69ug==
X-Google-Smtp-Source: AGHT+IF3jZIdcSmSv2uyOViHkbJ7SYBB3JTs7HVNWTo9MhTW0yyk+O0JuRJOFBQ+pvlqxoGwDzDcHw==
X-Received: by 2002:a05:6870:611f:b0:297:2479:a35b with SMTP id 586e51a60fabf-2b804ef04b1mr1112198fac.1.1738734384698;
        Tue, 04 Feb 2025 21:46:24 -0800 (PST)
Received: from ?IPV6:2605:a601:a5d6:1800::19af? ([2605:a601:a5d6:1800::19af])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356111477sm4528239fac.9.2025.02.04.21.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 21:46:23 -0800 (PST)
Message-ID: <8f9a3a2b-dfa2-4ff4-9f97-e65404315396@emailcarter.com>
Date: Tue, 4 Feb 2025 23:46:21 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: indicate http.sslCertType and sslKeyType
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
 <dd5d9b93-1585-4165-8f5d-d9737725071e@emailcarter.com>
 <xmqqa5b8aqn1.fsf@gitster.g>
Content-Language: en-US
From: Andrew Carter <andrew@emailcarter.com>
In-Reply-To: <xmqqa5b8aqn1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/30/25 4:22 PM, Junio C Hamano wrote:

> Andrew Carter <andrew@emailcarter.com> writes:
>
>> 0a01d41ee4 (http: add support for different sslcert and sslkey types.,
>> 2023-03-20) added useful SSL config options, but did not document them.
>>
>> Signed-off-by: Andrew Carter <andrew@emailcarter.com>
>> ---
>>   Documentation/config/http.txt | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
> warning: Patch sent with format=flowed; space at the end of lines might be lost.
> error: corrupt patch at line 10
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> Applying: docs: indicate http.sslCertType and sslKeyType
> Patch failed at 0001 docs: indicate http.sslCertType and sslKeyType
>
> I thought that the initial iteration I received from you on Jan 23rd
> was just fine.  Did you change some settings with your MUA?  The patch
> is heavily whitespace damaged, with full of &nbsp;.
>
>
>> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
>> index a14371b5c9..38e874307b 100644
>> --- a/Documentation/config/http.txt
>> +++ b/Documentation/config/http.txt
>> @@ -216,6 +216,21 @@ http.sslBackend::
>>       This option is ignored if cURL lacks support for choosing the SSL
>>       backend at runtime.
>>
>> +http.sslCertType::
>> +    Type of client certificate used when fetching or pushing over HTTPS.
>> +    "PEM", "DER" are supported when using openssl or gnutls backends. "P12"
>> +    is supported on "openssl", "schannel", "securetransport", and
>> gnutls 8.11+.
>> +    See also libcurl `CURLOPT_SSLCERTTYPE`. Can be overridden by the
>> +    `GIT_SSL_CERT_TYPE` environment variable.
>> +
>> +http.sslKeyType::
>> +    Type of client private key used when fetching or pushing over
>> HTTPS. (e.g.
>> +    "PEM", "DER", or "ENG"). Only applicable when using "openssl"
>> backend. "DER"
>> +    is not supported with openssl. Particularly useful when set to
>> "ENG" for
>> +    authenticating with PKCS#11 tokens, with a PKCS#11 URL in sslCert
>> option.
>> +    See also libcurl `CURLOPT_SSLCERTTYPE`. Can be overridden by the
>> +    `GIT_SSL_KEY_TYPE` environment variable.
>> +
>>   http.schannelCheckRevoke::
>>       Used to enforce or disable certificate revocation checks in cURL
>>       when http.sslBackend is set to "schannel". Defaults to `true` if

Sorry for the inconvenience, and thanks for your patience.

The original message was composed by GitGitGadget. I pasted the v2 patch 
into Thunderbird initially, which clearly failed.

I sent a new v2 patch using git send-email, and at a glance it looks 
unbroken.

If further changes are needed I can get an updated patch to you with a 
faster turnaround now.

-AC

