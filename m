Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45630EF7C
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555704; cv=none; b=Yv5iPVOjaYTgTRFRUmnuWop8cMSNqKpX2LSh62N74hmZYuxL+j5/a5sUlptgRD1bOKol+khvHdqlMtPcOvjU8m8whUO/AvAJBMFxdmjVltuvogGXGHPrQ1Q2V53YwsGDVsxBnz8LkXcplZ6C1ts8IBeJRzvbZrwyT1qFl6ayECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555704; c=relaxed/simple;
	bh=mWEC3AHf3FUDQhg3ivIOOS8NW9DA0HrwBM3z5N0CurU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UUTqG9yVBRAs5yS+JlUp/Bg0U05egCv+aetZCV77ogQNW+R2Qt45xVLZf1ZwkPa5KF9TI5jnuYS5uJXum2AbzaoCfUvCqLpAnQ+4+mcxDx+xaHeOjLku6YltPX05m04vPQLzIsFU0isSD2hkXxh9cYJ/w6OZqE1rA+1a0tro4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx6dAP0s; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx6dAP0s"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so31100475e9.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 02:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775555702; x=1776160502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbeJ/mB7uWY2SWB0AwoS0nkF+t4WpLtZPKrru5ZrfXE=;
        b=jx6dAP0sQwLB5MPmdrdYAL65tmAkv3xlpWAAo5ff3uIBEEFs7y+EyPB+1IcqAooVds
         cHarC08vxd8wnkfoFz2pESQ/hK35gZQpjRdzObwP+lxLar/+h68XUX/Rje2PG+Rldb0K
         b7WPiR0N+GetNYqUJAoUuBcCJ3HA7IRMtnOtLoVNaqmMQcH/lcBoJ6FyoFcGO5+K0dp6
         wX5iem1FUw9qySg+o+xqq6clURrlrZgtHvPEyrs3ch4jg7j5eZmEGTPVEs7VAOItH6Ap
         Xh4ABPXhWN7SnaoXraeJdC/JIUFUaIjGMejd3bdJdUvY7G/sFTcB5U0nAVpg7FQY/wag
         qlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775555702; x=1776160502;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbeJ/mB7uWY2SWB0AwoS0nkF+t4WpLtZPKrru5ZrfXE=;
        b=QKj6v3ZpqLUZv4YoxuN2Ucx/ewIAu5ersmD5nHCmNx4PVYASesfvyABq61LwUgkhoS
         x5phEN5A41GiBSWC57BjxV+EFv6eKdPvE8tcRGFAzcHAUk9bsqqRyc8aM9CF2VjrJ0kp
         sP03XN6a/I9j4s/XjBvzZ9IhFG2f0KfUlXytWeCLn2lVF9ufjvAId/syV16asVptHaUU
         Qxr/EjZKbr2PrBMFGqIBAvnTmbsuE3wbMcUOHOnljdtcZ5VVw2VZjUPmTBJXJFFsrxZ5
         J4kjFBP+fNmUD9mAsZP/xgdIjTbro+9VwIJ5eD1n7PjGR9lD+WJb0jPx5zm8e6N//Ubq
         4iMA==
X-Forwarded-Encrypted: i=1; AJvYcCV48pvSqyRuthbkqW/6HskRJro9v9IheSbYK0l4wVCbRhNJfuDWgz33Q3rBDj9YtP1mWdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5nxpcVJ7KyvcWZiF2S7aWBVQPhUpr1YECE8BnRKluJyzrKNf
	CCauh1nEBpnQTPcZci6Q5eTLwA9zi4p9DkoEBSOGM9BJdosw2iXTEENK
X-Gm-Gg: AeBDies2ZukV1lnltcCv8NUFp7rIN9FZbKdp123rKti+BeY1WT/u35LdhtHeNbhg3Nz
	fpHxKHhc6BWF/Kkwlq8/lQgjyTQhYHNKwtK21QJSyg1X9EGx2MFVEM4ANEGbQuIuEXwNWd33TRR
	20wcT0T0yo75C2fU/m3D+Tc9RJAzTCzkoN69X5lHKIzc8kyPLKExCXrm79IHZ3um8bHkyku4w98
	9y1Hw/Njhio3MjXOfj4hLTkvPcs3rpwPj14U7romGU1SAhfKSZ9QGTJCEdTJ83sLhCHQW+3CK2e
	gWWTDnsITq5fhZ89fcsqtLrqbVFrlEP+tzMOAwW0bwf35BVJTEKLP8L+79KfkSJwD/DWdn7T6kw
	wN1/GjLNQs5fP9MyxaJ6mSbKNwsOd/Sb/QJ9Cgswba9LdXEXroqJmDOS0gnnsLNeRUm9Z1AtDFh
	zpJNc4EQ7Hf0j0u3Nyp1tXMVoc5wMiH8bohhv/IB8dqZ/F8J2V5BfZROO8fjnAKqdRLZRfUwWVi
	Og=
X-Received: by 2002:a05:600c:638e:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-488997b21f4mr229349505e9.16.1775555701802;
        Tue, 07 Apr 2026 02:55:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a9242d63sm213151615e9.13.2026.04.07.02.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 02:55:01 -0700 (PDT)
Message-ID: <68e5a1eb-ec7b-43ca-98d1-ffdf7fef013f@gmail.com>
Date: Tue, 7 Apr 2026 10:55:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
To: Nico Williams <nico@cryptonector.com>, Junio C Hamano <gitster@pobox.com>
Cc: Matt Stark <msta@google.com>, git@vger.kernel.org, ps@pks.im,
 phillip.wood@dunelm.org.uk, Martin von Zweigbergk <martinvonz@google.com>,
 remo@buenzli.dev, Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
 philipmetzger@bluewin.ch, konstantin@linuxfoundation.org, newren@gmail.com,
 tytso@mit.edu, rikingcoding@gmail.com
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
 <xmqqqzor76nh.fsf@gitster.g> <adSO6zPwtFOWBcOw@ubby>
Content-Language: en-US
In-Reply-To: <adSO6zPwtFOWBcOw@ubby>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/2026 05:58, Nico Williams wrote:
> 
> Maybe that's the trick: local configuration for determining the
> copy-or-drop semantic for different operations, and maybe hooks for
> altering when copying.

I think the danger with making it configurable is that you cannot rely 
on the semantics because they vary between commits created by different 
authors. If we could get agreement on

  - Should cherry-pick copy the header

  - What to do with the header when a commit is split. Three options
    spring to mind (1) create new change-ids for all the new commits (2)
    create new change-ids but also copy the old one (3) allow the user to
    specify which new commit should copy the existing change-id and
    create new change-ids for the other commits.

  - What to do when commits are squashed - should the new commit copy all
    of change-ids? Should it have a new change-id?

Then I think it'd be much clearer what the implementation should do.

Thanks

Phillip

