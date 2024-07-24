Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B9159598
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831420; cv=none; b=Ha7cDAJSAuTZK1STVdtyCRy1QvjToOFQbRCVVrDP3uCMBZ+B2ArrYji3da2QTPSnn+ahjyweaoxIKxp/TDA0Yvt2FoNboo8AsMxnntV+/Yqwf1R36DCut53KT4M9SiNfGL/otwPJdyMD23nYfC457O3gkHNz87Z0L99BCAFwbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831420; c=relaxed/simple;
	bh=QS/dlGEOu0WtRM3oneN9+nFdNsCWagb5Y2khwGNeSXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2KnjAF0GeKCog3jbbTfcZCCOvE65HYVbblIByktUIx++YcU0oesQ0a0pPphOIjjYZ7TsOuKkWK1Q6oGDNHzk6dU1m7TK9Yonm0y4ETvHJY6vg6HX93C1oMqyHsqxvVayC2DhSQY6wEJadZ99r21SFkzj5GjuBqlUf6QC9t43X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrqL8Cuq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrqL8Cuq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so50542975e9.2
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721831417; x=1722436217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4o1hsFdswC9LF52FjVv2645wXb/g2cWx3Gp+SymjMY4=;
        b=FrqL8Cuq7h+PUknXa7xMusfHrRb4B7Lcr5jZcsmudjsv5ONH07IoJtF3Y9nCpfrFT+
         lls8pMfya/jhr5Lk9udd5QGXMggZmTNqJnw2nA1rpGZyocZRyj4Gn0AqYdWj3GgIvhl2
         hkaJn/CPIOElJEQqjvdorTyFVFXL3o4dAg5sgQtD+fwpENRu+rcBNWyU3BpUau1PtdDW
         npA0hPjpL5FO24bdngqmEve3STrJHuHN091RFLAWvHsNdYsKINJ+m84jAvv3jskduBUn
         PU780N+LCqcW+jSqge/qvi9FBaxFNZaubFoA3Cc5q2C9NOUY8L/aNS3bPJza2caOMrTG
         kxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831417; x=1722436217;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o1hsFdswC9LF52FjVv2645wXb/g2cWx3Gp+SymjMY4=;
        b=LtquEss/sMsBN2v4nthl5ziywwUrakDol452ePrdN5L6ZLOQOQQayIByy4IAYRYY8t
         jcb6+i2nZojjmzQDnXs66679NqWjRHVsQxx48xKFlRxpCwxYxFju+jP/fFGvdIXqg/t/
         RBOlpqAzWrwJhwD7YwWEFLa3UqO0/tDnuBajSQPJjS98OcdG4c9685JPUXOgHhPIMJ8g
         f2gCoh7o5qM6vwtnMkP/eGM2D6lzFbgBd9nN2nAbvgW54zr1CiIthJpvoh9Kl1CFjgST
         Ybe9K9RqnQh2JXz6lPx5BaQhUTb9RYDUeV1LH+v4RJWIka1rF/uwhogMoKU/ies5t1do
         WIzA==
X-Gm-Message-State: AOJu0YxKck2gBc6SZSdt9Xzmr8Ww7a4B7tkqjJ4wDYPYM7/0prkI/3dA
	hAnXSbtSJtpCbdVfoxYwcA/7jw1Exx6rcOUA6kjVP5YEAyymt8EG
X-Google-Smtp-Source: AGHT+IGnjLplKAKCfmGagL+5nXZGOsfMTZ0liZUArknQF4ySyaUgaQHo+fl74boeVjDMQB76qGKPew==
X-Received: by 2002:a05:600c:5246:b0:426:686f:cb4c with SMTP id 5b1f17b1804b1-427f7a93768mr24715345e9.32.1721831416296;
        Wed, 24 Jul 2024 07:30:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f935dc32sm32171125e9.7.2024.07.24.07.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 07:30:15 -0700 (PDT)
Message-ID: <1841a256-5c01-4892-99c7-ad7df14e6e0e@gmail.com>
Date: Wed, 24 Jul 2024 15:30:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] Documentation: document difference between release
 and free
To: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
References: <cover.1721818488.git.ps@pks.im>
 <5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
 <CAOLa=ZScBn+sMB7BWMpsS=Ld0sUW14Li5JVuKPGKtY91hVo4jA@mail.gmail.com>
 <ZqD9keTtimiqJnJP@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZqD9keTtimiqJnJP@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 24/07/2024 14:11, Patrick Steinhardt wrote:
> On Wed, Jul 24, 2024 at 04:46:20AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> We semi-regularly have discussions around whether a function shall be
>>> named `release()` or `free()`. For most of the part we use these two
>>> terminologies quite consistently though:
>>>
>>
>> I noticed there is also `clear()` used in some places. Should we also
>> mention that we don't recommend using `clear()` WRT freeing memory?
> 
> In any case I think we should decide on eithe using `clear()` or using
> `release()` for consistency's sake. Which of both  we use I don't quite
> care, but the following very shoddy analysis clearly favors `release()`:
> 
>      $ git grep '_clear(' | wc -l
>      844
>      $ git grep '_release(' | wc -l
>      2126

I think a fairer comparison would be to look at function declarations, 
not all the call sites.

$ { git grep 'void [a-z_]*_release(' '*.h'
     git grep 'static void [a-z_]*_release(' '*.c'
   } | wc -l
47
$ { git grep 'void [a-z_]*_clear(' '*.h'
     git grep 'static void [a-z_]*_clear(' '*.c'
   } | wc -l
58

So we have more _clear() functions than _release() functions. I think 
there may sometimes be a semantic difference between _clear() and 
_release() as well where some _clear() functions zero out the struct 
after freeing the members.

Thanks for working on this it will be a useful addition to our coding 
guidelines

Best Wishes

Phillip

> So yeah, I'm happy to explicitly mention that `clear()` shouldn't be
> used in favor of `release()`.
> 
> Patrick
