Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17531327F
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312995; cv=none; b=GeojKPa7j4efEzW7Jp/6SD+pTdd+EtDLBZO7kSF2hzs2nqocSKiUNXT/YilFP0M9wDmWJx9uRcw3sVUpJ5cljiezzgQ0u4LjWpamoWfNFSCcCeQYzt0qP0gx1k6T4gTV/8MRxDpKnn41Iq1t977Mjuhm9uFiKdkZ3BmX/1o+G08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312995; c=relaxed/simple;
	bh=YiGo6eTU8Uts53dSpdMegYtpgu3xfBjT7LgsEFJ8vV0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GHldOo4Iq7z/5t229OlLSTGg2D9ESRxOOw4GqsjEOK4ELnsIw3Y5UcjI1aDOPBwnN8zlHsSNi3hj0FXGGw0tr1DxoAYlM6yLkPYs0o0/kBKRnzVTXdlaJRwNmaAgaQNSBi0ROE5KRW2rK8SNM6gVgDxAJpc66LvL25zUX6CZo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmeYxNHx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmeYxNHx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso16158365e9.0
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761312992; x=1761917792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dzj+ySzrWwVg/yV+hD0EzHdav7kzuxXjcSBnX9Jrpac=;
        b=VmeYxNHx/3l1hAERBAcUSbaA4e36aDB8bFfzhqZxdITo2dMxL8H6kNJJWnxfhUfZkS
         HFWKFUS/oEEYVqLrQgsgoagAxFb5LzqlhOh8ZlNXF2zbazzNGNYRdV+SBFZW7K6UziVy
         KC9KIpu7YrArAWjkIZmK1Bzkw1V1SGHwqA1juFfAI8p+sp4RwFLJXItA58PVyQDF5vDB
         PoFuZkQQPGsKiw7eKAWlJ1LifWwEKx2MFjIXfrYioXZ2xkH/FHRdCNYVIXoUorjXthdh
         lDkbGNY0rRKvEae1OHqPrHUeF4m3Mk414ukQTr7sH+3zhZtMzbPbqL53AUuoWI4DMBqJ
         aV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312992; x=1761917792;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzj+ySzrWwVg/yV+hD0EzHdav7kzuxXjcSBnX9Jrpac=;
        b=PJsw653XCOINE/TKayLLnOnRC3fgUmQn1VcnTaOahW4nHsuA1kfH/79dYSf7Gl3dUK
         p6HnGjQhWOHY5E0x5VvjzgWQOmUx3U+9JnGBZ0Gn2dT5p6lzM0zC0LON+zh4+w5W7O+s
         0N7t9SpAwbtGp36Ho6y0GaLyUw8WZatkRcjDwIGMLH5xaojkgQeyrrfkL9KhsptMUjpr
         sCBIqY22x7xDp9CPQBk2XX0Godw08bOl4NfZG8t/RJ6RblPs3PLi+ltvj9XhLRzCvtk0
         47VPojQCz607XsXAiWPlaKmt99XqUv2/J11BLZcagO/ekmJ78RR5tSJD1BEkjQISUPaO
         53Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV7XlaeulUkRuHMVVGDhgkrlg6ym0H8pHR6UDtIwz+TVTRmuPZ3c1vCgNKNamAA5F+/b/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5NoQDRhW1FENucN3ZYS5a6I689C8f/Aun6efS+6My1mcfGab
	T9Zsadwi3tRqdiBy2fcYxVa4ydN130OP0necNr78dT8uPmzXsXNaIAuX
X-Gm-Gg: ASbGncsS9eLviWgZB2HMJQZONcCbO3s/nVvFf2UuFaM2Cjolnz1rmq78N3sus1VoAG1
	AU3GG80zTJXWRItUuM0Uhns3bQFJua0NxaVkMvFTG0Jc2kVhuA4XPyOIsvNCsOGrJ9jZAEQxFG5
	PxJbvc83CM6dH5mMbdBOCaGmjHlpUMIk4DD2W+qNCUFHpudQVtCqwcNIV4ajy2ZakgLT89sdatB
	tcAEI8fkjR+VDgkpy+pVE7KEg1kVnwGD1SyaO7ZB/SbAWObJWa1opQzKZuZcm7dqcmfbjIpRvF1
	I+A6dKSqgdw/o0rx4/uc6RQ4eMZys7CzlAxzcwACBzZKFc0DeEnrmvJkonzAQ7VIQYVSw7XMKI9
	e7/350QFPvWHdIcg+h8/P0CYMIU1BjBgCrVh025QGoViPDzxjIDWD83UQeeZjugiUxDtNz7p4ZZ
	60tklEFTl3gfzohYzvOY382xjWoKu466JJIZs3sh8HjbPXFLGEHCfFOAQDuGBLwxs=
X-Google-Smtp-Source: AGHT+IFWh719zamm22uzA67Qd5zNsn0499cGMIKGKQojkbnuMcbLQxBHb+ocFf2m9RqFYig+iX5FrQ==
X-Received: by 2002:a05:600c:6309:b0:46e:4499:ba30 with SMTP id 5b1f17b1804b1-475d2ed1ba5mr19568385e9.30.1761312991537;
        Fri, 24 Oct 2025 06:36:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b33sm149151165e9.14.2025.10.24.06.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 06:36:31 -0700 (PDT)
Message-ID: <7a3161d1-4e30-4156-876d-7eede4b06705@gmail.com>
Date: Fri, 24 Oct 2025 14:36:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] replay: add replay.refAction config option
From: Phillip Wood <phillip.wood123@gmail.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-4-siddharthasthana31@gmail.com>
 <a4cd31ad-7086-4d05-ba00-db65ec24b45a@gmail.com>
Content-Language: en-US
In-Reply-To: <a4cd31ad-7086-4d05-ba00-db65ec24b45a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/10/2025 14:28, Phillip Wood wrote:
> On 22/10/2025 19:50, Siddharth Asthana wrote:
> 
>> +    git replay --onto main topic1..topic2 >output &&
>> +    test_line_count = 1 output &&
>> +    grep "^update refs/heads/topic2 " output &&
> 
> Rather than test_line_count and grep it would be better to use test_cmp 
> here.

Oh, I've just realized we don't know the value of the ref so 
test_line_count() plus test_grep() (not grep) makes sense.

Thanks

Phillip

