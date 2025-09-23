Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378561D8E1A
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588942; cv=none; b=HEXIMzDMEoqhmteVxB37evTvOqh28JrzfvpAbE+C0k4/PNDyih06dOCp6DWWyD2gnVoE0ixQGex49alP3WjTj48wYzlbIkAXtID8M4SczTp8O3xUOeB9hvVKU3+1XNu3fTkEMTE/+uCJU2w+u5wx8MKmhG1rn4RZ0AVYKccH4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588942; c=relaxed/simple;
	bh=jCwwwcWBETPHZJUXc4K5SefkIOWVEycIPSeeRySTOkU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=RzIBQMj1CnOy44XPnnUZifrJOWY8dBu1QCrMqSD1hd23PE6KuyoxU5vqARsU1+p2psr8a0ITf6DbpYCxz+JXEMz5jq7S38ave4udWHsMxffRDqvQNRAw3FkJLDZD4HsKTKSe/2V8d7BWMA6CB3Vdr0pN2bjoa0LWz4St7g+EiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digital-mercenaries.com; spf=pass smtp.mailfrom=digital-mercenaries.com; dkim=pass (2048-bit key) header.d=digital-mercenaries.com header.i=@digital-mercenaries.com header.b=SJnbob9W; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digital-mercenaries.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digital-mercenaries.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digital-mercenaries.com header.i=@digital-mercenaries.com header.b="SJnbob9W"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so4561095a12.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digital-mercenaries.com; s=google; t=1758588939; x=1759193739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owWDekuChY3kYxq17xxrcJx5p+YLNtlr29ISpkU5KDQ=;
        b=SJnbob9WeiKfarbvZ64R+Wh8/udjCFLYTSohUAau36HlOGKq0qG5l0eXAz7Lv6t0Ct
         eNSSdgA//JYQwd5evIZVFvOaa1HVAdmrsuazhGUSKq3u5PYIJWVDGps0lRltR2kZPkOn
         Vp6cUKoDAT/MiCAIegGYsm7sEwM62KHcif4WnXTkK+UzP0/Dk8YvB+i+lkfMhPiEL2F8
         Vjjh99h5TsDqbh54qXOtqPLDje965u25OEk4jKw/8Uaf1XEpq7J5x6SsZuL1fxXpWXjW
         2xInbRR5l9fLIwTgKSIKBsnFnZcmNzj5JfFJWdzuSVwi6HhjEUjaJIc8ufd95EHGjYxH
         3QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588939; x=1759193739;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owWDekuChY3kYxq17xxrcJx5p+YLNtlr29ISpkU5KDQ=;
        b=gsh7uSy9WwBErV+SLe0SL9nVK+7b25vHrnmK8qWmei+w5BgZWjrDiSqk9PuOnpygNv
         HcjCaLuD97f1g5IlVDYz9AIaq9Wzv28QA/jRWKhPDd8dFHeevOsxwIaHIoLB8LtkeBXI
         OPu4gIq8UBdRk65PQeNCaRSSI9lD81RUIVfVYfe1hbxRwNbiAT2CrteNX1yzfeB+i4Yk
         s2Owou9Xi4egoEmZmQGjfwkVdl9TWb4ShyFXwXkOtCnzZTeDtV5GIz5J3UmzTWpA3m4e
         XcIrApswtAgdxE6hubiYsMlZhLU7s+gRvd44aqP39tDRQBW/9Ga75H7MGp7wSCJa2RHy
         KrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWDkmZ7koBm1VZug8fClnOGoDOnaHHG0NFJyTRWf/QUNzBwxEtcJaLh2PKrsMYgk51I/24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi6Np6FvoeOjG6vnDNGe65Aaw75XUL93wm7exPcOW2d/KEUydk
	zV6SLzZo3BoslBGSfr9tR0NhvhoCAv3B7dNpamXf0Vl8pqLElwUv8L5qeIbFpcWxZQHJGIGyFkb
	JJIRZ
X-Gm-Gg: ASbGncvqh2XvCkJJl4ANCPrpj+9tf4R7a3Lg8SMSjj/HfDl1mVMgRfhZGYaICjjhkJO
	7Q6vjo0zoq/FkXlCwNk4gY3gsCE6k+fJoBJsnA7++bUhKtKuFwXAXXlBZGZK/hZyupVttTxLsGR
	3HOZuSWVpXZuG1FtiRlu8fxTgIdwxXvznequk3pgIjIVa9FCDRKnCpjeBSYUzglXOipRitREaTA
	ZX+zdBe8i444Zob97tVVtfOWXeO7gN3om7Plt28HNCcK94FWwc5yOje9Zr0JnW573rcdI8vUeZk
	QWQiajQcegoojBInglI1cc3hVdkYg/IXemywkgIx+MsS5iChjA4PrDdRTnaKJiul7kq6/5h1TK8
	N48Y9qmZkOCWsDzLpPXt15AQoB6EpWnrz/icpW9AN6cFgnNAK4A==
X-Google-Smtp-Source: AGHT+IF9f8mfsflHoXnoMeHt+RjCOBZkoOLdwt+9dA5KU3SuqaQB00KVvEhRDPooOvcAUato6N3cYg==
X-Received: by 2002:a05:6a20:3ca8:b0:245:ff00:5332 with SMTP id adf61e73a8af0-2cfd69d08d4mr1224454637.7.1758588939284;
        Mon, 22 Sep 2025 17:55:39 -0700 (PDT)
Received: from [10.0.0.22] ([174.127.235.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2f76f87dsm5202151b3a.48.2025.09.22.17.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 17:55:38 -0700 (PDT)
Message-ID: <f2ea5a0b-278f-460a-a0c0-00477f61e19d@digital-mercenaries.com>
Date: Mon, 22 Sep 2025 17:55:37 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: S0AndS0 of Digital Mercenaries LLC <S0AndS0@digital-mercenaries.com>
Subject: Re: I still use this/these
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <8f201082-07b5-44a1-88cf-d6db551a598c@digital-mercenaries.com>
 <fd993486-069b-445a-ae91-a0f149fd3ea8@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <fd993486-069b-445a-ae91-a0f149fd3ea8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/22/25 15:18, Kristoffer Haugsbakk wrote:
> On Tue, Sep 23, 2025, at 00:11, S0AndS0 of Digital Mercenaries LLC wrote:
>> Recently, as of `git version 2.51.0`, running the following commands be
>> popping
>> warnings;
>>
>>       git whatchanged <path>
>>
>>       git log --since="$(date --date='-2 weeks' +%F)"
> You can use
>
>      git log --raw --no-merges
>
> If you want the same behavior.
>
> You can also replace `--raw` with `--stat` or `--name-only` if you want
> the list of files without the filemode, hashes, and change type (like
> M).


Wow, thanks for the rapid repose Kristoffer!



I'll alias `--raw` until my muscle memory for `git wh<tab>` catches up x-)

If I am not miss remembering plans to remove `--since` then is there a new
equivalent for filtering logs over time?

