Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792835300;
	b=uIaNy5A+lJzB2hjfFS7Ue9glaJGsxRtQ72yZ7ZJlag+cMqhxQLAlg/yqP86mSFHvDJ+u
	 I9SQx9mFuewW5FguLmH6NJVv2akLYnL2ZG049D0DL3R2P+MQMZ2ThSPWk/fq93oM5iRMv
	 o5AQUMbETFYQgAZ4ta7pFagSvbT6dYHzoU4nDstchaa6dbmL+yNPAt65tBFp1iHtY2rbd
	 flpFDmcIxSi5+AJwPzyBUxaksFpzqzK9tLuKvQOdo+SVUxMs5jztvIMU9IpNKhvA0LhmU
	 1xQitHTkxB76wF9SEStimEQJRAwRTovftN1e7hUlV2gT4RQGHhPQcVaj/6uZJVjdxOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792835300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YO/UOJA+qmwZ4DuJM5IHghwadKB1Lm4eTzo15gtA5os=;
	b=aF1Q+bdcJ0AorjDmUtJdyA2leur5M2RHj+ThczgSiFPTu83ZLjCNZuZZZz2D7PfzQJMB
	 pTcbvE8OHH4VwujW+Q5V6za/cahiYVB5Rsl5bQAO+Avdv3bP2JcW1QcPZnb1TPaljC0sG
	 06r+t37WUl1CzTpuXkoqvpSvvNVl7kMOarmRhBiBbg1FPCEH6NpiRii2p21Ttfn6l5hFm
	 Gjuzf2MSozClwZpq6nwSFq5VN3xl7KRDNxUw7KyCIl7lv4GfeOY0s4i7Z0k3UWNdIKF5r
	 4DdLnKxBhuVP88qhQVYFlU8AnfC83fes7/sBANjvM6QfbUwPI0xdqWwt/iSc2AhijIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cA3Yd79f;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD4606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 09:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCD4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cA3Yd79f
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e00eee27dso985939f8f.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792835298; x=1793440098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YO/UOJA+qmwZ4DuJM5IHghwadKB1Lm4eTzo15gtA5os=;
        b=cA3Yd79fgYzELCINyTKoJmrFCwsAgQvCsve/KKcs1ZXGOEfUFxPP6GCB90Fd6k5lfO
         7ZO15VJDGPvdJ1qA1atYyiB7Zvi1ST3JfRf8bIK1BSi1JYc/r7aaq/ZdpV6luvm8vMCQ
         BPGpGowMlUifdmTNvtXkJZCL4FnN9EEkRMPfBmz0JUkDti41vqyCEoGU5sZyeDBkH4IH
         xhvWGeaOaEpDgEXFlVZVEr70QPREqxtiOLRCqxT8ZqSOsiX6G/I0pyvc3Z2/jzH5Ci44
         8YYAdo3nF92sgznbW77grWVhL48Va4zg+wDZuTWwNOvU2Ys4fLIlwpqnl8lT/VUTO7QU
         ZFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792835298; x=1793440098;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YO/UOJA+qmwZ4DuJM5IHghwadKB1Lm4eTzo15gtA5os=;
        b=BtbBpcXFjwV6nY3bNI0wUNU7hiqY5a2hcJS6ztH6nvTxthBGsd93URxWc11DR3xJcy
         fwFw6RL4DAOCicrFKMzoRSsfrgq+GfKpVvrSSTEJC0jcJfbcVpGahWH3EsnPLPOWfkfA
         Jfq34NBn449ANN8PUmN0bm59uDI4/88HDOtJyA7MyuNXgFN2eBbRIlL5zXCoQLhZQUpl
         9HuCuZ/oIwPs24eeKhuqIJytE5ktsVcZjRmTQwig0180SHM0ay+qeRG/RmsKMq4AwlZf
         EDvPVaappLUfLukH/UOGKj9CUhLY4Ki124ooaCRirPk7/QXABYBac2XDvuL3PYjzJtWm
         BNpg==
X-Forwarded-Encrypted: i=1; AKwUvBxtyQHMoekslTgxlyt0G/hV/Zv3TjICzGf/ubjYnmsBUr6Am1qaDUZtW3rrX2pBVbbOUuU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIZ2WYV2OXpg8XIxtDOLhlAEeQ3+u6rPFW/9xU9knx89PwbDu3
	EncYOR8Dx/NIPbP+rfNaMX91F6VSfnuXhwXenxGbCvNlNWJKHsvovi81kw6TfA==
X-Gm-Gg: AYBFou3EEQ6YAxesAM9P4Bx0hfiMEZM8I5QUYTVzSCosy8siB593//36N8BmIO05Ozf
	GIx/EpsP/bXObTzZd5CylfvlVuAA7U1Km9pjDGJo6vOKpnuv65KzA7HJh4vlMjEBmonWWjgZ5i2
	N3rUFogojafcBI3MLF1hpcfJ8VgVD5TuuMLkGSYyGEUZluLITdYpLzkcr29evF8EUOWUbguoN41
	S2hpLGWBFTfKeAUPgworp8TeJhyNhL7QdQgirxqRGEOpKBbCuaiJ+MKnHhwoTlLeunwCDTaJcGN
	nv/t7Vl51wdLdeD5uQleKSfIsg7KO6ovSIInUZslV+bXbfFNI285nPGzsa+pmPs4EEigoN1FLds
	Z7gohyZHtjjb+WNqI2pgZlbrJGq+ZdDC8ugdDXdrGhZnuMhYyBy/MBBfuFE0sBSXnWIWamS8xbA
	CNcgs61uHghyfgas/ARFv2MRklLfAHgfqyJOTYe3P3V647s/JiMw954CG8k7HDbvqDLeiXO0F29
	r6HlfiQ5BZq1TJ9FcYy0DCdKrkr9rpdme9bWK+jqacB9h+1fX82svcnpgGrDgSe/pO8Cp7w74CZ
	Z1654RhaZVfvPs6FVe3X6pobweCaboRb+Q==
X-Received: by 2002:a05:6000:29d3:b0:48c:6f3a:fe30 with SMTP id ffacd0b85a97d-48e3eb82c06mr1305982f8f.15.1792835298162;
        Sat, 24 Oct 2026 02:48:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm3180996f8f.56.2026.10.24.02.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 02:48:16 -0700 (PDT)
Message-ID: <2907524c-4869-4280-949b-e6fb930e57b2@gmail.com>
Date: Sat, 24 Oct 2026 10:48:14 +0100
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] Question about check-ref-format test coverage
To: Fien Dora <fiendora5@gmail.com>, git@vger.kernel.org
References: <CACWAS-X4BqnMa8iJKTakF5E=zYkkyr=qsQ-=c3bxoAJ+Kpcfiw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CACWAS-X4BqnMa8iJKTakF5E=zYkkyr=qsQ-=c3bxoAJ+Kpcfiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fien

On 23/10/2026 16:29, Fien Dora wrote:
> Hello Everyone,
> I'm called Fien Dora and outreachy applicant for the December 2026
> Cohort. I'm interested in the git project "Improve how command
> arguments and options are scanned and parsed."
> I'm new to open source generally but i'm ready to learn and contribute
> 
> I've been getting familiar with the git codebase, I've successfully
> cloned and built Git from the source on my Mac, ran the
> parse-options(96 test) and check-ref-format tests (107 tests), all
> passed.

That's good

> While I was exploring builtin/check-ref-format.c, I noticed that Git
> supports --allow-onelevel and --no-allow-onelevel, but I couldn't find
> any tests of --no-allow-onelevel in the t/ directory.

Yes, "git grep -e --no-allow-onelevel" shows we don't have any tests for 
that, adding one would be useful.

> i tried running
> 
> ./git check-ref-format --allow-onelevel foo
> 
> ./git check-ref-format --allow-onelevel --no-allow-onelevel foo
> 
> it returned with an exit code of 0 and 1 respectively.

That's expected because --no-allow-onelevel comes later on the command 
line it overrides --allow-onelevel and so we exit 1 because the ref does 
not contain a '/' character.

> I've also gone through the list archives and saw an earlier outreachy
> work converting check-ref-format to use parse-options.

It's great that you've checked the archives, be sure to bear in mind the 
feedback that was given when you're writing your patch.
> Would adding tests for --allow-onelevel, particularly how it works
> with --no-allow-onelevel be a good contribution for my Outreachy
> microproject?

It sounds like a useful project to me, it is small and self contained 
and improves our codebase.

Thanks

Phillip

