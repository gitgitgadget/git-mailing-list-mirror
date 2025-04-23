Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9C17D346
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402721; cv=none; b=YjIMXVk38opoYAKAFkAZrlVxIp1GGpqqyP6gN694dz6ygsHYlDtHbMa4LRarxJoMODhc2VnRNuwWlInWg+kvMM9AIdVY5CZlaNuPu9wd2eMiTxGJFqZKpClFzoLBVbS9Pkiz3e032tXv/ocCPvtGHXcQ4QOcCEKaDpDNYvyuG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402721; c=relaxed/simple;
	bh=f5xHT7DiQb5pi9TfqjhD58SpHYgxmh+SOm3IM0ISbdc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JtI4iF6hU6zHvCdOoU6taV+YXoja+gq6ZEPC6SWeYA3YKmp3yMVp523DYyG8mXz1PkRTjeQa4hdnVk83s5VljQiWmRbk7FouRuOuRynSu+HmTk72Xp+AJTzzYjhYhFK8FL20eywJmd578GKSwIMZmNn7QGM24vEKCydArrg0USQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbKchWv2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbKchWv2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so5872655e9.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745402717; x=1746007517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTFKqjcVVQYXxe3PFwdefYrBLDk6ABmj5nrvvXD5TxE=;
        b=PbKchWv23O12NZKrs7AxYCiymx1GLazkMhJUVnQF5cWreGWMZI8d0ni2p0sGEm3Tpp
         Jf62HBBtJZNTFQ7FO2EPiUidYEkOJPhb4oOd0P2FosP7RKs8mBqT1+7FH1NQCyYK7egf
         P8hTV4AKj8kZw2mC0sKSZo364AMHVqsvwqDvRVsE0RSy+NPQgJZS1EUwHZ+bQ7OKPysW
         Hc3LHUX8NPXPE3YXNl5KEZJlK4z75lwvBAYcexWt0pYl/HFpRj3QULD8xTpgNk7VZz0V
         h5RYfivmDVIdMUtRSH2TCi0o/ZJSo3V8GvdUcHHJ54pKoJaP1n1CC3iNFLjfrH7zSml3
         n3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402717; x=1746007517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTFKqjcVVQYXxe3PFwdefYrBLDk6ABmj5nrvvXD5TxE=;
        b=qFI6gvlnuZUWaYrpdSK1Tkq8MQMWoUcO76CkfgNoocqo2sWlmoWvRWSrj9wYRKGj3i
         sCNe96qjs7tXFyDVurrNpt/1gYoq5RRJpVpP1bHBcMH6+Zw/xnNX7PJrhCrMNHX4L/nf
         eE5OXiFkDjM6ADjQvJtXCtZihiTSddEz3Ds8QyVTkPExbOSt46QeONgLjavjFuj2Q7FI
         RXOyFZ/DoSHYApR8wCkY4aG0bPBM5KQg9G9yBy8GnCrCF5yazwbtLmKZ3g3xOjuBzK6Q
         VZTf07tdPs26kz7j4hj0sk8rTef9iDs/aYyjTFbSdy+xqtGB3EzXPsdxqvloc1uGrF5s
         CNSw==
X-Gm-Message-State: AOJu0YxG9qSl17/QaPZ8eZ0Aufn0XF7f4wmwYWQt16c60njfgpTgiB+X
	BEqhYLNK9DtFu5r/BPfAekp4OsQ+h6UpSW9C8D4HpWfSJHXUWUQjeQlOTw==
X-Gm-Gg: ASbGncsEOOleBjd/pNSauBezDgtlIc8QZKSQZOX6PbgK84wvtFueRHOmUIqX7LTAbOL
	f7VTSg9XmIQI0L8tMri8WJy/QGYW6n6l3jFTUICYak6kw1X5wY1JSaOXuQO1nE/h8GFz3nqZKVJ
	F0gpLuGPL/S/oc2XYEP2wUeYuD0zYP/YMzfXf5OvHuGR7KMbumqbpx8KfvFWRmpKFTI3JVQ7eeO
	z/GXIQ3eLvQPtQ0YP1X69zLxxTh2/2WKurKcrwTEfK4qZovyfjYkcg3eNnTkyG07MwtQFCutzQD
	Qf5lc0AOjRK48UkcoUMwPO9aNRwU46btn7qHjNi60Ly8ArvyuHu2HBLCwEm4OkyOud3QjwZpsen
	scWte/8j5gCRem0u2
X-Google-Smtp-Source: AGHT+IHtCsv3AnnamKa4ijbG+iE7J+sZOIamtU5HV0fakWXm1H/21Gd/QyH2Svaw4X0DBMCvq1DVbQ==
X-Received: by 2002:a05:600c:3d89:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-44091eed7f0mr18026405e9.5.1745402717070;
        Wed, 23 Apr 2025 03:05:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4931c3sm18123808f8f.77.2025.04.23.03.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 03:05:16 -0700 (PDT)
Message-ID: <970e77bb-5e5d-44f5-abbc-201d9e673a89@gmail.com>
Date: Wed, 23 Apr 2025 11:05:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com>
 <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com>
 <CAOLa=ZSi5FuhpaAiGn5OydLUXhkWC9VrkOvXKwTeP=9S2uhKgQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZSi5FuhpaAiGn5OydLUXhkWC9VrkOvXKwTeP=9S2uhKgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 22/04/2025 19:56, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> Hi Karthik
>> The commands above omit anything that updates the package cache as we do
>> that anyway in install-dependencies.sh and we only really care about
>> getting some version of git installed here. It also uses apt-get to
>> match what we do in install-dependencies.sh
>>
> 
> Seems like this is a no-go, since apt-get fails [1] without first
> updating the package cache.

That's a shame, thanks for trying it

> So I'm going to do that for all the
> commands, which should also ensure that the package cache update in
> 'install-dependencies.sh' is mostly a no-op.

Fair enough

Thanks

Phillip
> [1]: https://github.com/gitgitgadget/git/actions/runs/14598683520/job/40951070359?pr=1905
> 
>> I also wonder if we should ditch the checkout action and use something like
>>
>>       git clone --depth=1 --single-branch ${GITHUB_REF_NAME} \
>> 	${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}.git
>>
>> so that we know we will be building from a git repository.
>>
>> Best Wishes
>>
>> Phillip

