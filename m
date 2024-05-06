Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888C39FF4
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994557; cv=none; b=W0+rbP7E3N91gB/2iGk5rKD4Is0rEfktePfdGXe0OBG8YgS4nLCfbp9G7CHlvTkvady12RwaTSX9qd6JKVdB6Y8tOew60VHdfHwMDSOSwjeAh2mn4fDj49XVugXMCDJglTy79FDJmGK+QDEVVhPrdZF8yEqthP/8K9BtQbDfcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994557; c=relaxed/simple;
	bh=+7bKE1Si/noQi+f+tEGJazUT/sgHhzGCX9+vgDjrnDo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVHCciY0s0psaGa6xw1EsntNfe/Jf52hNVzUmxfyKSml3jshWlVZN/JZI0i8BedyD797yBdn2Xoq2n277ANCyy8Y3nhmv1wuCInMW+lo6psjjxZ8VPFSnA1eCbksPIzLDTeng35bfifgdYIjhq5XR3geji+AK4cu6MclnXYw5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7cCZU4X; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7cCZU4X"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23d477a1a4fso1387250fac.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714994555; x=1715599355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7bKE1Si/noQi+f+tEGJazUT/sgHhzGCX9+vgDjrnDo=;
        b=U7cCZU4XaGecSbQx65vHJPn1GFhRAz3vsuZAPKdRkdIAJ8yKGwH5z9nNByCHAu3fst
         cuhgdqpEXqxMzx0LA5ZgpzNufQptCHtCo8YlHDZfsRL1E+kOcKNHVVzf9hvfrCPVyMmN
         r2+IOnrJDFiUOfYmzPjCPOdvoKt/NDodKboj1VD11vC0SIn7mqphAvRMTsR4PB/VrvSX
         ftsoSgWiC7aOvzJZmaNDeu09avd8is8IaIyQcDUTpPSa34RDXQno8C+CZzJqqMaw7pqr
         UK6HQsD1NqTkuLFWerA17wMk5mXvjMPCuuds0s1iXFR4U9RHcUvMVU9qXHbIGpOGxAMI
         SoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714994555; x=1715599355;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7bKE1Si/noQi+f+tEGJazUT/sgHhzGCX9+vgDjrnDo=;
        b=Bd4sQEy2ZT3Ky/bJjAkRRHpOSoNwu5Q+MbGnNGpqdTLcElduCY0hsUDwObmRURTP6v
         rjpT8HpCs1E3i3EPUY/jzaBCNTx3DcHWRa0WGDUzDvKR/odRugkSX+1XTQdEngCDylwR
         RYXc5bOVDP+1nWbq7ZAyadXMOyUjfmI8BhRzNP0iAjXeDRnvZ+EayPLsCeJnD2+cdLUZ
         e8OgiKbcIMGzvBjuSMooDSllTy+NjYFSvrbpNAZ9wtr0FiQk5FICIG/RK7jfzI5XjSEn
         UgM9/0823Okcjh1nTxl64sIdF3hn8jnqlMpo+RulMGicDIZVCoZmmwYtKA8CjOCpuW3Z
         XOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/KHk8fiDG2THzaTLWhlu9tpS0nxZ82ZG0zZQIeoRdGddOX1bVBfvJqWYb8uV5QEnVO+RvQnKSwmffd+WaMbcwE1/i
X-Gm-Message-State: AOJu0YzcvttDkt6/QfAYRs+3o3Ml4UWkkTNam+WmdSHXXeqzdLZM00XY
	NfQFWMuUjOBuQXK64g9oLEhpr9dYqKiika1gPD+4lYhSIsDkDf7G1qx1JzlZinifConHMqijoay
	gy3XG4Ng529NlmCuK+qj94ncqf28=
X-Google-Smtp-Source: AGHT+IGxzXG0Rki8GXtJRG6IQKvF4V9A7MD447sDqGMRYssQ7y/ixQYQdPv8EQgB8x4esKiZ/gO6f6/J2qFyfJqnnIc=
X-Received: by 2002:a05:6870:d1ca:b0:23d:79c3:5627 with SMTP id
 b10-20020a056870d1ca00b0023d79c35627mr12780938oac.36.1714994554845; Mon, 06
 May 2024 04:22:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 04:22:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <dff080ee-946c-4a44-a448-294ae8ee241f@gmail.com>
References: <20240501202229.2695774-1-knayak@gitlab.com> <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-5-knayak@gitlab.com> <17c71b18-20b4-4bbd-b52c-c29ef8d3860e@gmail.com>
 <CAOLa=ZR5a0Tj1abM4z4SAVm5cw5+EA0qyoOMs8QH8MoS6eJGiQ@mail.gmail.com> <dff080ee-946c-4a44-a448-294ae8ee241f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 May 2024 04:22:34 -0700
Message-ID: <CAOLa=ZSMFVDy31W+5=iu2AWjyaR+Jy_BR5txd-bGnHu1iRsL9w@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] refs: add support for transactional symref updates
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000003bcd8f0617c749da"

--0000000000003bcd8f0617c749da
Content-Type: text/plain; charset="UTF-8"

Hello,


Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 05/05/2024 17:09, Karthik Nayak wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> I'm slightly concerned that splitting out the update-ref changes means
>>> we don't have any test coverage of the new code beyond the part that is
>>> used by refs_create_symref()
>>>
>>
>> This is definitely true. But I also caught a bunch of edge cases this
>> way because the tests which indirectly use 'refs_create_symref()' are
>> quite intensive.
>
> I forgot to say in my last mail that this is good to know. So it sounds
> like the only new code that isn't being exercised by the tests is the
> check for the old value?
>
> Best Wishes
>
> Phillip

That's correct. I think testing that _currently_ would require us to
probably expose and test via the unit testing library. I plan to follow
this patch series soon with the symref-* ones. While that's not the best
argument for not having full test coverage, I hope it is an OK state to
be since that path has no users as of this point.

Karthik

--0000000000003bcd8f0617c749da
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 64787dea2542f6a4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZNHZYZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVRQQy85azRGR2UydTVPVEtVTXNmc0p2L2Q1bW41NQpNTDRJcStMN09U
MXIrUWFMOFc4c09QTTNySFhVbGFkYWp2QzhFMXdXYVZFU3hhSVlmdzgwTFU5cm1WWTdIRjd2CnFV
WTZvaFZmTFJocUNmaTNnM2pCVnlmdjZmY0pwOWhLMzF0cHpncTFOdWxlU0VSQlAzallUSXc0aExR
eWgxMGcKZVI3VkFnQnJ4T0ZRVTg2MTNDdElmNC9FVENtTFpaUHA5dVh6aFA3Rk8xZWNuMjlIOTll
UkEvQzMwYVhuOUhPYwo4aS9US2lNZG96MS9EWmwyTUNNWHhaL3FHSVFCbEhlM3pUTW9kYXZScFR1
Vno5dkV1dndqWXhKM0NXRUxtUHJlClhCaXZMVDVTeDNMRFhSOUQ0UVdzVjBDbGpuYnVjV3VUZWFU
ZHJCZzRSSk9HK0xCSGNBSlA2RmdXM3hNbjRkK2wKelIwYTZWZWJqdHNuK0MzUXZmbW1PcUoxRjZm
UVVCVytZMWd1bzRyN2wwdlU5TlFTRHRtcXRJZHpSSCtWaE5ERAo4TWMzajc0bHIyMlBMc0cvVTJt
TkJnRDVUTXJqQWtWUjM5WFRRQUc4WGFoTnNTdGVLVDN5azlmaEFRb1Z1WGhmCnRjRDdFYXQyWkJL
b3c1S3ZhNldiVHpSb2hTZ1Z6aWpQdjh4V1RjWT0KPXROcDkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003bcd8f0617c749da--
