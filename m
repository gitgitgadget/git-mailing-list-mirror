Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E316C3793C1
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251787; cv=pass; b=pGRM4NP/f1sIltb2n2/Pb562zRui/RGmY+mFUy5NboKd6nE84w8Cm1mwxm1Te+LfVldIryXezhtK6TS00A7L3cHPWIzKQ5m7ip+0bppF9G93JCv073HbY/qfCequIbWQsVIU+X2CUyigpxzeW/aBiC4mUeqMRoejwgxwhfpUp9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251787; c=relaxed/simple;
	bh=jXuiwdyLCUjN2qsQNSoyns0tdY4tQXPWzWGYMubBl+c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1+aWLcc0Gu7ZgpwLhuykTOL9twJV4SG3Z/krLZo1UV4HCJ/sdmFuR5OYclIcD/YuVFU/25PZz5b2WvMB1sHJ7skRhYkpfykgGYhSRVeUnCIu/2zRz4HxChcY8N9XRsBw8oxY3IvnbKXAzDbq/pauoaId12ohaVA7UD9bAyiLSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd4xn7e6; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd4xn7e6"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-953a2a4761cso3511846241.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 04:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776251785; cv=none;
        d=google.com; s=arc-20240605;
        b=GCOxdPI7tmNdp0e7FV7pKP/asR508QZzwaPhdC6wrstdTyHvLhfCPFezmqJ4PeKFb0
         F5E9OC74tUvw2M2YoR4qtKV5oflZ1nsT952a1U9wwj+3xP7rqEbq66Fq+Ax1Sv7wXmv+
         E/dc2fjwlZFqfPjs6Utm53KYa+MRoVPAfAPMNmMoesnr7+nfZRUN65kV+E+OGmiJTH6P
         5pbpsySJ03MQ7PplKzDazvxKDk/tviGW0+UQbAMvvR8aDKAQAuGvmzK7eONeUrJQnTgZ
         ryL/JeUvGfdlZQI+Cq1dW7N6w08TuPK0sKjzDIXXkq9ZLXei44zTL7V7r+w3LUjrJrg5
         mADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jXuiwdyLCUjN2qsQNSoyns0tdY4tQXPWzWGYMubBl+c=;
        fh=rspzcE39wx1ohF16KidSnNGHZtrdbOflClrfsrwGZ08=;
        b=SFQvUIu5wQJVAGIubZ6Djz5KTbTxCa7+bv1iZg8iBxTU1lXVzvkZm2//ROLh2fMnnC
         2tLZRdPMYPvIXAOFbTa+wALT1YY7LaQXn3hc1iLfFxjeIGf8uIS2H75iwzwPSI33ZPp8
         lpXSFa23DzRN3/oJ0+OVoYNZ4qMbPYqf0aOsAb+AP2oEdVYKDB9+ak4InVw8IrX8+2DD
         wxrFkoiklxH87kksvCcDU2RVp/e/Y82Sv+2IquusJQbbM4SjPIdC83FGSr9gBrLYmaUt
         VrxfqWTPf5UmbGegmXihcUjgeP//Jesj80QH+Pd5lgdeEc7yNAw26oT0Pxr7f3cK5ORk
         2XGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251785; x=1776856585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXuiwdyLCUjN2qsQNSoyns0tdY4tQXPWzWGYMubBl+c=;
        b=nd4xn7e6AHSMdWt0OaCvDw7c1u4vBHKMny5Odha9xRQruUo5IthyHIAXJaq3woMSNd
         0s1/famDCNrgpcQtcydtERtGeioPTT+m1r58tmgU8y5sJct1135L5iseyozyRdXr/lxJ
         DFO4hz27GwDeMRp7Rlw1Q+iNj/zYmvbWLV30FYumoG71rcifANG6dpEyVGQG+WQn2nnm
         jdR0XBi9CS9egNCaWcFfOS13eLeuG8VE1TDpKtkZeITBv56MUsb5ZgaRyXIrJY76o18e
         bu1H5WmBIgTalt+IlUZuz8NNcCWoDxhnST1mOSwHyi64/hzq8jhV2tWMvfqhGVKHpcrF
         bSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251785; x=1776856585;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXuiwdyLCUjN2qsQNSoyns0tdY4tQXPWzWGYMubBl+c=;
        b=WKAADSwVcVdd/SRMTynGyAp+Ms0N1hHUZ0DiaBHGGtYyS2HQ1zuuqBrWEB6r3f1l6n
         wOwDP8b+XIwjMvIW3qtSxkgLZmPKdEhKMgv+kzVkC0o4FnUVp3nv9mpTi8iAM53Ec6kx
         F08DbN7BXRHYhB6RKW9A3sPHREHnR5pNsn6bNsM9WN6uOC46VOeGUZn3BxVqEl4zLT3u
         Fj1ILIPnVyKxCzXnQukjwRfQm70QleUPU0yP5UGbcAWboPE4Hpz2YmM+HNZ3kWohRUQj
         Xt1Xa3coyzR38lD3ZZmHUbvvNFDh5PB97od7bHN+Pbmsy6WBsSduQ2X0WDJ/5+7jYM3d
         zx4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8oqP3geTT/NRryP9qALqALExzLMtUOtVoOnMK+u9c2sPpMeABnc/Q5jiQ+BppP9iQAMZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bwCQMVsfkAmvSNHpcIZUcOPhODgP0SqoK275ZPbkwhYGIocY
	5kFF1SxOkybu8Xxeto5A4OD20x6mi4m4Id95XhtEfR7ni6inCEnkT7DISrcujrpFUGMaBTNmybU
	JB27QLHXgNbJFjlBp4BL+DjsyOwvqKH8=
X-Gm-Gg: AeBDietDiwMgiBXphBOSpgEfgTt4GD20+YkMHFNkp8NEKDEFUhB59nICaf+npOqPATY
	v1ogG3GlhSM1SfoDe4RSNMnW1c8DxNsqrRwKiCquPHfU3rBSWDqyf5j8dHhRDQtd8/0XcDiiTFh
	xgBMaQkzgvvHQzIRsMVmeOPjT1jTVBKZXNUDWtZIBudm0K8u5ziM3CijOOsoQEPxE86uNiEUI4N
	+aRhpxdPcXKn0VWhBmaOhqRPv3twWvmtcSEavinfd8PkccvFz7604yb+UfvrJ6kc9EaZkNSVUjI
	kDx/3z4KzZICPHK4BaNRY0ITmF0tkqQce8Gy1QzIqeMsvT5GJq82
X-Received: by 2002:a05:6102:83cb:b0:5fe:af0c:79f5 with SMTP id
 ada2fe7eead31-609fecbd698mr9584563137.5.1776251784803; Wed, 15 Apr 2026
 04:16:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Apr 2026 04:16:23 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Apr 2026 04:16:23 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <53f43b85-b274-4352-938b-d40f942bfb2d@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com> <20260324123750.157143-2-belkid98@gmail.com>
 <CAOLa=ZTD+qqgyB4Pn4bcOfP+Ks8Zch+AWZkzhrRRbk-eJvS-mg@mail.gmail.com> <53f43b85-b274-4352-938b-d40f942bfb2d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Apr 2026 04:16:23 -0700
X-Gm-Features: AQROBzCyMCnrQMnDlIDakeHlRt-3OQdZ3_YstzztVoXhFXIt3WSWMNbtFB5uK5E
Message-ID: <CAOLa=ZT8H3xLXjact9it9jveviztL4Q72KNMk5nxW_ouq0T0=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] environment: move "trust_ctime" into `struct repo_config_values`
To: phillip.wood@dunelm.org.uk, Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="000000000000aa54d9064f7dd838"

--000000000000aa54d9064f7dd838
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 14/04/2026 09:52, Karthik Nayak wrote:
>> Olamide Caleb Bello <belkid98@gmail.com> writes:
>>
>>> The `core.trustctime` configuration is currently stored in the global
>>> variable `trust_ctime`, which makes it shared across repository
>>> instances in a single process.
>>>
>>> Store it instead in `repo_config_values`, so the value is tied to the
>>> repository from which it was read. This preserves existing behavior
>>> while avoiding cross-repository state leakage and continues the effort
>>> to reduce reliance on global configuration state.
>>>
>>> Update all references to use repo_config_values().
>>>
>>
>> Nit: I was hoping you'd also shed light on why this can go into
>> `repo_config_values()`. Does it need to be eagerly parsed? If so, why?
>
> If trust_ctime was lazily parsed where it is used we'd end up dying in
> match_stat_data() which would be quite unexpected, make it very hard to
> reason about the code, and hamper the libification efforts. I'd much
> rather we put the onus on patch authors to justify any conversion from
> eager parsing to lazy parsing rather than forcing them to justify
> continuing to parse settings eagerly.
>

Agreed. A note in the commit message that this belongs in
`repo_config_values()` because it's eagerly parsed would be enough.

> Thanks
>
> Phillip
>

[snip]

--000000000000aa54d9064f7dd838
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: deef50731264e3e3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZmM0VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHdWQy80K1RHYUlkaldoMlk3Wnd4LzhKOUR4ZmthaQphdVpTaGdCYnZq
VEFXTTdYMUVOOUQzRkQ5dzI1VlFLRUdTT2JhVTdubHJNRjZpanRnaElyT0NoNkhzQnZwaGZXCm5G
ZVkzejJmK3p5R0lyRG01VG5PWmRJSDBTNlpRNEZ0WDkraEpNZG9jcmJoTDFoSWNTM2NpdFVOVGV5
UmtJM1QKNnA5YkJMVmdiR2FPdkY4OVhOaXlDZDRqaEVhblg5c3VQbWd3bk9ydGd3b3ZrdHJmd3Y4
ZHpoVk5GR3JKZzNSVApQUlRoU3lWZ0ZSMlQ1amhRejRFb2VQY2RCU29HSVViMmk1bTdYYUdYc1BP
NWUrK2l2cVAxcElyU2ZrclpoWVlJCmhjc0VoM2FpbE9MUmxISDViVENldE5wQ0hEY05udzNKd09Z
Tm4wNFRvOEhpSGNjOW5ZYTZ1Z0lMQk9rSWN6OXQKcUg1Rzk4dVZiY3VJS05hVFArdVRoZjRSSm9m
Q3JiTVFGTWwxdEZRQWRvbUhtUTRZUldXdFU0OWZOSE5zbUxROQprZ1F2VHo0cVV4RUZ4OHpTb090
NEgySXg5YlZrYTZ4YmlOZW54MEZ3aWxoODNNV1RCZU1XVFd1TjAreG9lU1oyCit2YThVeGpMd2VI
MUQwMnBoeFlIOUVIaUpMZnpaSDNKRmJudXhIUT0KPXRGWWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aa54d9064f7dd838--
