Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5C4C8E
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720879096; cv=none; b=DsXxg/onUwx2PkXXfG+fTcg3U1WRDSBL81UXn09FQICISNt2VzLWAoeIIcMYr3nistmkUbF6osGrGRlK4mwI3m4ZtztREy/tKuXhsXPISUZUEok3t//3YYedpZSPzTv8VOQHz5jyvpHV21avp3pwPjwRTor4nWwnqKm0jOumlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720879096; c=relaxed/simple;
	bh=dKJpQ0tKkZ2HB80qe2TmfKo2JwBXvZfPlqHGKaD5UZ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GKnrSqaP4POxut78s6SR+/UVTkONGZhbmQBnO+st0Bpp3wUowmZiah8I/2MAwAZq1ygjzdFEmUi1Pu5HkGDa/Evu4phrSAF0h3CY+pVezWxVdp2JnkZ+YZAz1cm1/VWMXBFI8TzvEW3LPI9h3CgTV20xtUrE5VU0tAjkPPvGVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Myjk9XLQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myjk9XLQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4277a5ed48bso20963465e9.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720879093; x=1721483893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDHFEly2lR7KNWmJ80vhwNn6RgvjCD5L/+LmDQ2KNUU=;
        b=Myjk9XLQ2ERP7r8B5gseeAy95xftVRk+C/grfzNmQEvFCHy21rg4+tfVpeBA8iUxyU
         bekPZ733fzs0zunThT9u3IAnV+DtVSuBYbMA03/42APx4f6TrU3o19pixHPrMz0xjUr/
         JMOzDqazBU7q56CDKlNuZG2VkWs5d/ttHZO/HnhxcB8bHEQUJpJNdF26A78InRlOxleK
         qFW5HENFseV35CWPdgbD6kG8VzOqL9x9smQAgrI9xK2ocHnCwxv+jCONuFTGuEKhWrAi
         dHHM/nVx9kwyAcT2Y0uUBOWcQ+i/IgIpVZi/AsuYT0niKrLuPWfIijIpQqUl31JhehqW
         vqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720879093; x=1721483893;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDHFEly2lR7KNWmJ80vhwNn6RgvjCD5L/+LmDQ2KNUU=;
        b=cDMV560vxJHk9yTRdcP0VzaMEXRxiBrsf0UKJMjRPjLwkI4S4i6Ls9sQzhjbAaXr1+
         9b7Qph3fN+m/JWblGXG5OP9MAJ11s0szKG/g+HcwafoBWJf7bGPO9oOrb1gbwwnT5TwH
         y/eay5/wLlNjCxTBoxswTuJCUDmTkEfv+A5MIlgjyALjnmAn2npwK70TRrrWoAURVpAD
         EmHLF+LtZEzAz6wNy/bCLIdml+7S/YYhEoK4qbFHzIvPJM9WAjHch01hk8yHYZ2q5pEe
         dt9+5FWM4Z9YufS0+rvazXp7FlchR6O1zTtL9N722zGuQgB8mun/cP11izwOqLN7GIr/
         Z5fQ==
X-Gm-Message-State: AOJu0YxS6CegfAU8FBWP2op4TLQVgzauz1xfk51FQlwo5evgy0S8sJ12
	KBcGE8wIezPkT1QXDy+j88D31aPoFBajJkox5zSLI4C0A1hYhZhj
X-Google-Smtp-Source: AGHT+IGsbD7B6qSj2dupZrRT8wKzWhFz9+EzTmk7BrtbdcopbQCRHOiqXnV8mvjOnukXp1eFBBSzNw==
X-Received: by 2002:a05:600c:5125:b0:427:985b:178b with SMTP id 5b1f17b1804b1-427985b188emr58091255e9.16.1720879093416;
        Sat, 13 Jul 2024 06:58:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc229sm56036695e9.38.2024.07.13.06.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 06:58:13 -0700 (PDT)
Message-ID: <57402963-a95a-4bd8-9eb1-1764e0611bb5@gmail.com>
Date: Sat, 13 Jul 2024 14:58:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/8] clang-format: avoid braces on simple single-statement
 bodies
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-6-karthik.188@gmail.com> <xmqqle2bj0dl.fsf@gitster.g>
 <CAOLa=ZSb_S7X7pdFPp0r5bfNc3o95mGe5pU+rC1T_yM89NRqCw@mail.gmail.com>
 <12830e1d-598d-4e7d-abd6-3349800e277a@gmail.com>
 <CAOLa=ZSrVOBkziX+z3g1RqudiLp=SN4gW=OL5Ky++KukPF=QXA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZSrVOBkziX+z3g1RqudiLp=SN4gW=OL5Ky++KukPF=QXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/2024 13:30, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
 >
>> I'm a bit confused - what does "allowed to fail" mean? We don't have any
>> automated requirements on the CI passing. We don't want to train
>> contributors to routinely ignore CI failures but if they don't get a
>> notification that this job failed how do they know to correct the
>> formatting?
>>
> 
> Well, it mostly means that the CI would show the style-check job as
> failed, but the overall pipeline would be successful.

Ah, I didn't know that was a possibility - do users still get emails 
about the failed job?

> We want to ideally
> fail the pipeline too, but I'm being careful to not disrupt things
> suddenly and I think once we see what false positive rate is and once we
> fine tune this settings maybe over the next release or so, we can
> enforce this.

Starting gently to get some experience with the auto formatter sounds 
sensible. Thanks for working on this, I really hope that once we've got 
more experience with clang format we can figure out how to enable it 
unconditionally.

Best Wishes

Phillip
