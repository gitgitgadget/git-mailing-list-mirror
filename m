Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE823A453F
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374292; cv=none; b=SnYqLisuXc+XkiLzfRxgIbvvDH0PKCj2uoa7rH4p2IQl7gtQDgp4IcV5bqvRSfFhb9AnMq6HOw8i0fui0ZcUDYKrUOhxtKc4mAUZR9ineXZAlrQEbCeBWRK6sgYER2MoNw5beU920fflG+BhgY9hhotupcTtIvgyACk7Zzz1fGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374292; c=relaxed/simple;
	bh=0hWBbYxm1aS1/wYQXHoUEiWT9V4h3ywRtNiGMcDgY4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaWjkpZVOcpbHcmuVgMa96OG2gKKulZhsglQqTSWm3Yionskpzlv3GHuuaP9Vl3T71EQDFScXNnwbKF6EqkISdWXeHoESp4crSd3cHMt58fFjz3AvafhsLL6AMh5gu81982Ignl0mwIVp/qXLS7JMJWQE9WGxMGG/Pr6uCHDL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlA9kX0C; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlA9kX0C"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34907so1540120b3a.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789374290; x=1789979090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=99hp20VCjyT1FYFn9pdlyCRsK6Zxkf2K16MfEAHKmIE=;
        b=IlA9kX0CPWIJLD2y9wVkFFa/8EJGYlk/pMp3/4fsbcZw5/s+wCdDKMU0ekJjlIHr8v
         nMYt2SdAxl9++XrcFtxfaYscia8d5cndHEv3D7FJLf4Mw7sCoR5Y2dKDERTlyOAYLXbf
         534CRrzjz6cqwBaVUeVabKVSxq+uog7kNFayqpeho8x3S/ViaiCE86UdfFUTdIHN4LzG
         8HLg7orXM3cCJ6FyHpoMzYeNmeNlv5lrt9w6ZIfP+Fx8t9Lh9CzqjuanP3Tz8lAq6y1v
         xV28zo8yBYiHuOOmX1WTfgTMRWQ51yK54867tww+cwDvlQE2iBnLnb/SWmtkYJB5p3Ik
         53uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789374290; x=1789979090;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=99hp20VCjyT1FYFn9pdlyCRsK6Zxkf2K16MfEAHKmIE=;
        b=lrXwRcOBgxzm4CoWDsHr6RLi0I1Zc9fMc/r3TDKz9vQGGs+H5ZMG+i7wqYeCA3gOA7
         EjWGh9FW5fsV5zTpXPVOvBZA5ebjCXRyKqO2fI/UZl9xb02UGOsGJLoZk0GqwfjyBGFH
         45ruG8vCOizeoUe3UZtFfbzgDmj8PWy9/jMHI9UtbMLcxxnXNWbYSsp9uim9TFGpw6C6
         pN4IfJ2qPa9DJQiSzlYKm8ZhMAHVfNK23OB/+SuztMHWoUpuiZFjqYKTfjr+a4rRTKEP
         xywumlGVrQlbRw74eTHdrXsGgzoBR/oO5SnP+bGpC6aObIoS9YB0JZcrgbAbyFP0ZQeU
         XEag==
X-Forwarded-Encrypted: i=1; AKwUvBwCgnKKLCRAo9OSpAhSCFiOpWXFJgSGLsZzXK85ZmqpG8EAE8f85Sy8pS+UTJ2ThEui4r0=@vger.kernel.org
X-Gm-Message-State: AFuF++mJyWcunB+CWq/ZNpAa7C6XQgV+KiEb/JZvsNoxFSRmyluMqHt0
	4/kfjMrDL2qkBVr5hqHnkbbnMYUMlJjKiMa3q7JUVlkk9YKRsT7aHTzO
X-Gm-Gg: AYBFou3rIN1V/IAdnhXZI9uh3jptyu4h3lncqMlaM69bQtB1DizVaWAUodXljSoGjZ9
	b2SxBilmRJyYijJXFO5/1rjaSaY2wadk2vF2wTMWhRW95PUVWhyeF1ZADy7PUcvyPYQ8cw53j7T
	xi3wvT4itIvuAgsus4MLEGCr+lENehxHplgNKrc2c1AtGukE43D/FngTaBQdrFFEptfEy09Zqrq
	prxRGqQWD3+WoBiYwmUEClPzeXsPmVXZFHV9JHZA8WCrymKzo81SphPCAzF+2ucXYRjYful26FX
	pIGa/ziDsSxS2WiSsW5JEd5qXb5VdwaVG+hmmd0Y8YgeDxWJMNpmEsckB9gbqI7g4Lu0Mzx3oOf
	ZguavSjeS9mkNshnWVsvUDKF4AtXEZ/ugR9uP5XUKhsQ5QwD9auBvLCF5SicaOhmGSkqNnVDikp
	iVnTQGOLMHydYTFf/UVB8tzdZD4y486p56No11eCFQ2DOKmMIDuGjJiKTpNTI1vBu0uJNorPLiq
	Bdwc9t5QhoCp4xA9Zv2yYRxzkPX4duZfP6E6tVdU4eBtFneE/mv3kU=
X-Received: by 2002:a05:6a21:9208:b0:3d2:2afa:d7d with SMTP id adf61e73a8af0-3db4061f380mr3690305637.18.1789374289950;
        Mon, 14 Sep 2026 01:24:49 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:61a6:89b8:2267:1cc6:d572? ([2406:7400:12b:61a6:89b8:2267:1cc6:d572])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm22678570c88.8.2026.09.14.01.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 01:24:49 -0700 (PDT)
Message-ID: <f2c1a858-e259-4e9f-a48f-f553f4d43153@gmail.com>
Date: Mon, 14 Sep 2026 13:54:44 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Git at SFC <git@sfconservancy.org>, Pablo <pabloosabaterr@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>, Tian Yuchen <cat@malon.dev>,
 git <git@vger.kernel.org>, Christian Couder <christian.couder@gmail.com>
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
 <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
 <080f0485-3cf7-481a-8c39-c69afc81fbd8@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <080f0485-3cf7-481a-8c39-c69afc81fbd8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Siddarth,

On 9/14/26 12:08, Siddharth Asthana wrote:
>>
>> The links to these projects are currently only available to approved
>> mentors and coordinators. I applied to mentor both of these projects
>> as this was required to submit the projects, but I am very much
>> willing to remove myself from mentoring one of these projects.
>>
>> So please apply to (co-)mentor one of these projects, or submit other
>> projects you are willing to mentor if you prefer.
> 
> 
> Applied as co-mentor on the parse-options / early-scan one.
> 

Thank you for volunteering! I've approved you as a mentor for that project.

-- 
Sivaraam

