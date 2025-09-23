Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4522E3FA
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645418; cv=none; b=lV5kAM5fdvOHGdm51MKJviqHHNfmzrBkznC0Eyrv9n3HO60L07kkFWO6Nf58aSEKqbp8m6rPLDhY5jzPHl89ssQucv7QvVtb1AGHc1+vIuBYWVm00otDGq/LT2ze3E/aluzHbHVQsTymRF4eLqaGUe1kDlapOamG1HJVJjAn8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645418; c=relaxed/simple;
	bh=xcw8uCUIJRMdlQ6SI7sI755/ysrEPZmt6V/cY17frkk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QTfS7El4cvje1ENF2dcnPNPs2LHWQg6QryOmfEtPwA5OyzNxsTB9LV0gliyA05omP9otEAqMjnb0LJhZVuSCRttDvfGaOX/vTqu6ubBElToEo2AGyIQ9SVu/k6gHGy36DSedujIzMdpSKaEAsW+/yQgKCiYubleucEbvCeMse24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digital-mercenaries.com; spf=pass smtp.mailfrom=digital-mercenaries.com; dkim=pass (2048-bit key) header.d=digital-mercenaries.com header.i=@digital-mercenaries.com header.b=QpuGi6Et; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digital-mercenaries.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digital-mercenaries.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digital-mercenaries.com header.i=@digital-mercenaries.com header.b="QpuGi6Et"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so6521094a91.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digital-mercenaries.com; s=google; t=1758645416; x=1759250216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xcw8uCUIJRMdlQ6SI7sI755/ysrEPZmt6V/cY17frkk=;
        b=QpuGi6EtR8CHn6c8CqAfMEfxatGWODEyfSTUY86sruVG91Wj481kSBu5kvTPaxsEmx
         TsxA8cVweRvni1NBlDFIL8GgE3aIstSJAd/0LL3DT8lMWI7uMq+LAiVZ0owuyI+9lbAu
         hicyfWsKAb70vV93l/Q/wE176Vl5Bvd9sIue4rh2ANVPDwwJA26BDZPfqgkfwJCLSodh
         S3WFncZk0z53iaX4BuBl3x9S5t9rFx+hUKc/UPzaB+Fd/BvJ6sWL6y+VdBngJHYWS6Ux
         KJqNdYfSrLHkubPGcnRTqMo3uzk7rNeyOUGeKfFKJ0L0ha/TVLzB7pRbXTu9S5JUT0yZ
         4xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758645416; x=1759250216;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcw8uCUIJRMdlQ6SI7sI755/ysrEPZmt6V/cY17frkk=;
        b=M6SAY6e6Z0ShsSFIvC60qBYg0Bz72v2wdg0kPH/n1cc6EktZs3+ur976YyO/iLJel5
         ZdaO655XvrgsYIRFeL11zcn71NnRS+W6zUTsonPgFUi/JqWhLxpjKr4zHxmvS+hKwKZb
         EqdHyTQhZBaVvxhVUyOJxXM3QQSDrFjaiUnREFhTgIPAp0z3CLmAEZnIzobZuVtrG95R
         KF0r+93Pjv2t2GIyGMkwTnueTqdFIrdx/PRG1QDhKsJEBxjyA7VZYgNdGAbUjUdvltpD
         cDYRNBaVR3qYVC8IJIJwbaybwqbnHh1dpXZKmWrxb95yPxZ/CbdyZ8QAMCZJjyEUbto4
         kbFA==
X-Forwarded-Encrypted: i=1; AJvYcCXOtEDHKW6K8totu1NbGJGvT/k2Ahi4t7GLFBOY0akIiIVc5HwXGeqxR+8VmnL2YtbAPHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrPqwOrCyUINJ13DqE2tUtRjRbDiOLXtKuGSOFwrF3fhwg2RW
	5omuNNJV5AReRmCLYRWkJstIQF8KGxps/VNbH6Phl6YDbb81yrH13fhsMt83KgGdnwSASu8NcOX
	pC1Ac
X-Gm-Gg: ASbGncvboOyUQLD0DrwnzIbDTShKnP6LbNAWIoNdu76+B/BNezuHir+oY3ZtPBdYEIU
	+KW6yr3MOX/oxLPVh9wCWFEu+dLb8TvwG/WvHEs5YJM9UH+y8/1J/sCLAYxCSWFhl42rwfNYnuQ
	XkjNL2wAkH3x+KDhIwidH31zrJzzIG6MaM1JuDE7oaxUII/y3LMKKxdJ1hfHHl2M8ikyetAIpS2
	DBc2yuXuUVMJ5GYGnPvg3p8YqHrY8b7tsD8WazjzIK3YhhREUmF0H5tp17Zqj0Llg/zMMLoj85q
	ynB2UygFlkr1nuP4OWLLJXF1ykmTnryt9A7lDdpEpgkgFgSJaVlnUQyd1Ur/cEQWOFR7gzwXEBv
	njSEnACppttJSaWNRrnHQKeA/GvKdcKHYLnHOcT3WRp1PJJpwkg==
X-Google-Smtp-Source: AGHT+IH3UcfJChLaS4HlOpK589EcJrvxGFhYWN13cab3LN8vuHcODrRFEQ2V5pt+Es0GdgtcG8CJ6A==
X-Received: by 2002:a17:90b:4a91:b0:32b:a307:23dc with SMTP id 98e67ed59e1d1-332a95e936amr4031691a91.24.1758645416159;
        Tue, 23 Sep 2025 09:36:56 -0700 (PDT)
Received: from [10.0.0.21] ([174.127.235.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-332a68cc5e7sm1305008a91.0.2025.09.23.09.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:36:55 -0700 (PDT)
Message-ID: <39045a98-cc86-4733-8365-2238e9747201@digital-mercenaries.com>
Date: Tue, 23 Sep 2025 09:36:54 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: S0AndS0 of Digital Mercenaries LLC <S0AndS0@digital-mercenaries.com>
Subject: Re: I still use this/these
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <8f201082-07b5-44a1-88cf-d6db551a598c@digital-mercenaries.com>
 <fd993486-069b-445a-ae91-a0f149fd3ea8@app.fastmail.com>
 <f2ea5a0b-278f-460a-a0c0-00477f61e19d@digital-mercenaries.com>
 <CALnO6CAkyScNvARtxSadUL+fNDQmbXke=+fF=O0cnsV8Biwtww@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CAkyScNvARtxSadUL+fNDQmbXke=+fF=O0cnsV8Biwtww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/23/25 06:04, D. Ben Knoble wrote:
> On Mon, Sep 22, 2025 at 8:56 PM S0AndS0 of Digital Mercenaries LLC
> <S0AndS0@digital-mercenaries.com> wrote:
>> If I am not miss remembering plans to remove `--since` then is there a new
>> equivalent for filtering logs over time?
> I don't believe "--since" is deprecated: I can find no mention of such
> a thing in Documentation/RelNotes.
>

Thanks for checking Ben!

Oof, I cannot reproduce warnings with `--since` so I be totally mistaken.

Again thanks to y'all for time and help...  and Git in general (-!

