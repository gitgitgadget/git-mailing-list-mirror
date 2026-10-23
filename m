Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792753715;
	b=g4KqkU+7Vq4SvfRsLfobYSMty5v9zAE907ZhxgwvmiIjCDg8M4CGAW1mx8iCX4kcBJO7
	 ZcfjNq5pfK7bL0KllXwWeG0ov+jVemQVCFKRkbF9cTV8eEYSQEj5mifEv2QTP4PZs3WbH
	 5UD+rGkYIE5xKZHH+Q9m1OaEG1VxxcmnauHFaIcCnsezFIHBjsEqgtT0vovNWP4Ys34FW
	 3r+/p0NfN1aq/u2Q3fuKFUipNKo4ZvNNUJg3/pMDqpxW2rBltT2MpKJDISz3mNPAwWwtI
	 RXPVAFhU9Rt8THyHWH8aKJxjZIc8jFiMua60RwMpRe0Xl+jAGYVDXk2g22d5RGDNL+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ImQ6d6NE1T5YHHcbtZuMDM/aNCgnmsjBYjJqJvWR7rg=;
	b=ExaDPsCOwRWUanuGYnyUtDF5EdNHuK6rav7bXrjWjiEg8KoaxBluSlhW63wtGzGq2qZm
	 6YE3ACQT3cCfnti2RdY8IMUTFm2mnJVMrLIvT2hdpCLpji9Xj7qFkbIl9/9/D1tkfNrOA
	 mnoSaeu2X0ED1p/US4YA0W9l82VG4hpcExhxSB/0ySZ5pud+W3lRGp4KHIr74LKhNefns
	 qKZxtVh1MIDTYZup5lw5ghrUmLLUWH7cakYs3Ow7jEVC0u9lXbipdHVdm7JT22R9DQfvq
	 rDp/S/22TYZqu1ScFiljt9gKTD6PZNtlXN4TAPXhQE4Lka3/r5lZVVgGW34Ihl+R8QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eOqUVFmR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F4606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C0F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eOqUVFmR
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so1206757a12.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 04:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792753714; cv=none;
        d=google.com; s=arc-20260327;
        b=nF6RDe2AY8/ZOP77tP0Q/jIDWBjkNHAUNBu0bfw5p/4uHv9kr+1H56/wTnBeMMvjk+
         Uy6TWXtVdwfwdaNTRb2ImiPMQbcfxzZCs2673dPizS/spiHI9os1CyP5e//97VUpU6nH
         UbxE9rfWEAmZ/uEjvCYHrmhiuqN7lGz4bZIlVSQ+cMlKH4iNJsarriGFpuDN1Z8U2dUe
         bSmSaewuBPwRy8ayPY4fuDslqaEsVDku+gXzGd9e2WOOlybtuRAaZ0bAJ978ovn+o/0G
         0OgQPwO8fvBDADE7ZyrlEncEhvTVRQXtacShvaU21YJqEBntpgKnAOhb/Mixy6uFMV9K
         3TIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ImQ6d6NE1T5YHHcbtZuMDM/aNCgnmsjBYjJqJvWR7rg=;
        fh=tC8xgLhcehYtH8bWQojm0E+Xx8XGYiR8+AnNsejDUBw=;
        b=hfFahIj17KWnGADcxGG06xhelVn8P7m8urQH60sR5Wk0WgePU0nm8d8faFB03yaQI6
         hXBTp5nsiaYDocsUpWSk+IOmYoWYq7/ZBCeWeQmqGKVAyUbwTdL5R6h3u/+P6h+ueLts
         jbyddwkCFBf/WkGfm4pYOrM6s6NmYrfCfllG3mgGn6dnbgxXQWkvSl6L+wWvkm2gt9Lx
         oUTG0XTF9V8/5aSo4YjU3JffTRAQcbk+uKPRZGt1btx4QrERgVJWHQQ5s20mB47h+Xge
         aU5XuPm7FI5J027V9BL4RYMKP/zZtl5zmjcNF4RHSF70nXAGu8lo5cTM9EKtUE/irEnw
         irGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792753714; x=1793358514; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImQ6d6NE1T5YHHcbtZuMDM/aNCgnmsjBYjJqJvWR7rg=;
        b=eOqUVFmRnx++C3J0APggEvLfNfwL2HU0GuWqS8Q0x9J4OCO5UAbPwa+ngtx4+u6aNO
         WH8sl969pzp3c1dmqRi4jODIbfG0X1DdKKcFgrbuQ5JDdnmXGZadEDDpzKyM4FmZ7Jmh
         IsMsLgu3RFejfAP0SvnfoihGuzS8ART86fF8eWPGgd2GKXiYQ4AMCpbX0jGx3yuoRlv0
         fBwmyj3jVMxXw7oX0RDyAUDBX922oSmWr+1mz1uzh1ly4pdkhkeqc+883j62kcUhD4LT
         rtnRsQknxP0wfjgIR/VGBhTdo494764FbMbi1DzHk/uAJzTJSA0NWefLXNpJ98XhluPt
         GZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753714; x=1793358514;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ImQ6d6NE1T5YHHcbtZuMDM/aNCgnmsjBYjJqJvWR7rg=;
        b=KmYWDLhBVmWTj4BXhcR4rOoXbpnlLaPvKx3+NpMBIGqM96zO9xg8H3YhtsbfNI9hl3
         46897OcRVCvwUS71u9tW3XRzjWRhZMQaoJ1rloEJSl4kiudxtQebuz+qz7eacWt9EqSC
         xLOo0ugKay5m77klW4dXLLR+EPrCG8LBQjAkhaFlDggV0bgdWIidFAlRPWAwnYao8Lv5
         37ZGS6wpl00+nMLY4zawADXI1EwcsALZ9GU1gB/TbXra/6BfgCscKO/1n1HELZ2EcCN5
         bzCVbEUltZ1Z0XLBwepOadUX1wwFO3i56WyzGzp6hMhUqV9HHAKuJsukonVxQg5C+PfE
         TD1w==
X-Gm-Message-State: AFq9FYIiG6XgdBEZ3bDB4pYNlA8xdrJi38qgqS+fPimSgckVKOeNphs4
	efGKpsMM2HJ5ANN9PdhuU2QOqTb7GZ4y6mJy8B9khaLfCW456TEusup5O0oOi49UUpFQcsM3kBm
	F1bha7WF51ObpN8ygJBS+VnWtXbN3Sag=
X-Gm-Gg: AYBFou384YBaH5bi6jUjo8z/eVBYW082nIFJvTBnvON0iYODGVM8BhMh2azf/4/KY+z
	AiKCl9u9g0rpHV+Vh0V2f0DpspMWMSF9UNIE4EAEmS8wmVmv7JgqaHvmnDDSMFQmmMZ52N9ObkM
	icHqAcZKhhT5sMPxn72a+lXjOw3NtM8gj4iQEnIwrOOifxmmOwLSYC/YJ4C0sHBiXr8DE8NduGX
	a502zH5CY5YgyNO++hMpHLsLQCHlQ9OMljrmra0mVPdMWWiuFNPrRf4FyHjKo0yt6LgaKPdtJPq
	R4r2N2VSrcepS6gTwPcpZPMX9frHqBMRyYmEkHoazVa3ASCTGWAI3n5ojEVG21B7kCpB0tEdUMB
	j68YVWONBpCoNoh92VQ+n+wj2Eypltr5LeoUX
X-Received: by 2002:a17:907:2d21:b0:c3f:d912:ff8e with SMTP id
 a640c23a62f3a-c46a9295e40mr252891166b.16.1792753713584; Fri, 23 Oct 2026
 04:08:33 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOcE0wJ88hbd9n-A2C0RxksKVtnt76u4vGxvhQ4rdNDEdGTmOw@mail.gmail.com>
 <CAPSxiM-dxHUE5tHf830=zHnLfg1U5jyb211-ZODS7bu8OjqEnw@mail.gmail.com>
 <CAOcE0w+EciSBZDTTNzbi8hEzZAZjB6gut=Pc9qB5yEgs-w1f2g@mail.gmail.com> <CAPSxiM8Nv5mnWoFVjWE284yhYG0rdLmfXN2xbZpm4H-wO7oAng@mail.gmail.com>
In-Reply-To: <CAPSxiM8Nv5mnWoFVjWE284yhYG0rdLmfXN2xbZpm4H-wO7oAng@mail.gmail.com>
From: Priestess <herroyalpriestess@gmail.com>
Date: Fri, 23 Oct 2026 12:08:19 +0100
X-Gm-Features: AclHuK_R2AZZe-mk57ai5T_4Okqv0j7Co0HWJF8zveHhjLhFh9mYt0jmh3o7-2w
Message-ID: <CAOcE0wL5_+m-=qSrGV8JcunTgpBKGaustYc6xgKhKuCrSzP8kg@mail.gmail.com>
Subject: Re: [Outreachy] Applicant Introduction
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Next time, you do not have to wait for someone to tell you to proceed,
> you can send your patch when you have checked that no one is working on it.
> You can also indicate that you are working on it after ensuring no other patches
> addressing the problem.

Hi Usman,

Thank you for the advice, I will keep that in mind next time.

I sent the patch the next day, and Patrick reviewed it and said it
looks good to him. It is here:

https://lore.kernel.org/git/20261021033723.5265-1-herroyalpriestess@gmail.com/

If you have time, I would appreciate it if you could take a look
at it as well.

Thanks,
Cynthia
