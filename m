Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7D395DB3
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112693; cv=pass; b=CVCNt5tCEgkueYTdiMVZq5g+214jfd66VyeAE133joNxTLSEJPHf+X2tYVyA9Kz0zdNNHB7c5ervIBNzByTF0Hc2NsIAQ8Vy5No3GovQ9pmyS0xuhr/TSYyXTrMiWoo+FHGLx2fMKraCE0iQsGrpqv1+iPDrS94ipEMDfUSBq2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112693; c=relaxed/simple;
	bh=DYEreZkBN/gH85Vmy0HMMFJm5T9sK1iP/NVKyR0rHy0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaEG+Jrxm02BdyluG7ABNphDG7ZZccVXH7ENbCcCi3OLr/3tK2Aorge1Nj6dfPoW5rcKsVV8LU/ddqOyubl9/iTTLpQJtaKFNSLpG1vUsbEDpryryibLHdWAPG0NbP3hS8J8xu6MYSfo2XVNzLfD4yO4LasKg/qsf+K2pZOFpH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5nymT2A; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5nymT2A"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56636dc53a6so1519255e0c.2
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 01:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770112691; cv=none;
        d=google.com; s=arc-20240605;
        b=CtjwV/gzfRxSwJ155EgHVykQc4irzEqsWs0WXpmIaiUNC2VsjvIMWRJg79sc5JtL5y
         PO6PxSG90UvZ7Ewon9Dh8CcIsGSPcJyRgTXMduMmUE8ZcoUJd+BdFAkEkDOzjkL0cnNx
         oHoUy0zv3Zao8LhzFHSOBZRIZn7rR9YxuGWl5XYftUtgtjg6CFfVyheE2nhKJ6dvAmpW
         wjHAr6xgpPiTMIbQl87c7hr+SlwQU82Onabw9FrQjR3YP2B15Lq7rgSLacVB8Yp/dTxA
         +4hlFD+EIce4C1kze3tFsvd5vBZki3ePLVHcLSPTjI8ZDiWUyth9zl2r8qPNclOB820m
         HWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2DZ//+eo+0r8qgzdlYiF6s93y1xJ1NkSSRqbMG6jTjI=;
        fh=X7544WwjWqmquXpvXNTySlpj/HhYB6hoSWnc+wrNJkY=;
        b=Ft9rsRLETVO1tA9JwdZPKQTpV5SX2ZdnKpkCXiNnnBiirFEIiNkn468xjcS+gxNCzN
         OrE3BexDJEPz3Lvw9zjj+z2idvO4rOqCaDH/06BJjiKRZmvPG0xO9rzIA6oGLwBExouX
         VzTgqGrnMgRyb5T9zgr1fEpOT4Z0Ia6p0AfCTrnnGcdSRFLfj6EF4qQIgXLaxeAVnTY3
         7EvaG0iLJ9ne3wRyfhJKST+0EVPtfQqGSWTYZ6dSp1No0qVkDi3xM1f1WIVzznPYX1FA
         oU5P4jfwpw13mZQydEX69CXNXetKXCYH5YnugrIFXYOhA76uxFJRW0uzPRdSoW71K6/m
         eqHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112691; x=1770717491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2DZ//+eo+0r8qgzdlYiF6s93y1xJ1NkSSRqbMG6jTjI=;
        b=T5nymT2AgxxCmXCnyx0AjZTmFlSMxlA+0AkbgKGdzZOJ9HNl3bK7Es2+icE9nvE/nR
         J9cmFF5OBzYgov9rDsOYke4usfOnjkXTBVeWCZ1eOvkZK0T8rkdgKSVbgXOQ68KEcNOW
         oZblqXoDEQ4uLsIQkMDYRu2yMMcLnOv9SMEKDs4AsgP1Abmtx0S053OvLjfRejkG293w
         XX9V5Ict8QurJBOoIFMCZxLDqDfkmdIm8FU7zBcsPdqKUaveGkIP4B9+x/X7yZII4qP0
         RH64L4i/nCLRXdx6w0zUmnWnRqNbo8Wp60CJplYBt29x6oRUgEc2ax5vHp9ohSIvCT+f
         gkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112691; x=1770717491;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DZ//+eo+0r8qgzdlYiF6s93y1xJ1NkSSRqbMG6jTjI=;
        b=JeiTHjRjyqoTVhUflyRpBGEBYedid9x4+LrZhLzP9uEqpY/czC1c+zNAzRoxZkZX4m
         nIzQ7Alvo/fSFQyjNjRxvywaCw07z/tlsEdtGO0mxg626z6zNR/G/PGTyE0UK2EB9d4S
         Ljy7UhOCwMu5gDAH8iyMGEshZHddZDuYc2jRTCZCQUE9LtIiYQ/Vk+2UAhy282ZuUn6z
         LGoW6f1ZAD+A5z7Co9+ZphTLPI+ZNKujoeMT8B33MrMroVITD0AvDhg6y0wEUSq3cUh2
         SohszORHLr8ZRCtcRAySmia3UlQXwjzVUlhGJa9euKuCIg5SHZF+pSavolXVR7DrDUfw
         1erQ==
X-Gm-Message-State: AOJu0YwoEywhY13oOa9AhKJFBLpwCF71cYYrHTvCqqyTgQ4oeo4Jl/8I
	KwJcendt98dntCgQAPShNxpwdcQ5F0h+ojZPiw2TSWJ76DhGgHqxx9ZlBKq5Ov7NSwr3Uf2xMFi
	8+cisXS0V1K+fdm8nTC8A081X5+tdNG4KRyg6
X-Gm-Gg: AZuq6aJhxhN3XMzWMlKu0VepaGljqtvHZhH6JF9S+csSfhMxaUnGrDToD/E0SZVxWxk
	yV6NglfwWEs7JeYY5vWBXQUiY8mLd2i5m+CAqgbtUwBQK+MUgxtN8IF8XEAB+v5iRGZxZjaQQTm
	Xni9bGJMGcNhXKGM0VrcKSmMI1EFliPiYYo1/glrqczaD/tnHyRsBAO55ajaVMBbABhQVyNVHLZ
	HzDPcvCw8WuF0yCG6vmIFp3IpTB71nuoFDqA0JT8vjTiiU2u5OJ/qX2OjAlJ90vwODVdhVVmSax
	j8HdBR6MfxhHuEas8KbI8KWanXi37Q==
X-Received: by 2002:a05:6102:f0a:b0:521:b9f2:a5ca with SMTP id
 ada2fe7eead31-5f8e258d2c3mr3588902137.13.1770112691256; Tue, 03 Feb 2026
 01:58:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Feb 2026 04:58:10 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Feb 2026 04:58:10 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqpl72u7vc.fsf@gitster.g>
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
 <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com> <xmqqpl72u7vc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 3 Feb 2026 04:58:10 -0500
X-Gm-Features: AZwV_QjdI5_mVXyHnzfWmwVrstezMIjJBrAX6G37wj1J0GUy7mDKkkJeWdyG7xs
Message-ID: <CAOLa=ZQEU7kD6DEj446Wj19XUQP_1bOXYK1xsg5rbjnw7W3sDw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Change git-last-modified(1) default behavior and
 add documentation
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>
Content-Type: multipart/mixed; boundary="0000000000002ce2050649e87a2e"

--0000000000002ce2050649e87a2e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Changes in v3:
>> - Rejoined the two commits about `-z and the two about `--max-depth`
>> - In the end, drop `struct last_modified::recursive`. This ensures
>>   the effect of `--recursive` or `--max-depth` depends on whatever comes
>>   last.
>> - Added a commit to rename `<path>` to `<pathspec>` in the docs.
>> - Link to v2: https://patch.msgid.link/20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com
>
> This round looked reasonable to me.  Shall we mark it for 'next'?
>
> Thanks.

I also did a round of review and think it is indeed ready for 'next'.

Thanks

--0000000000002ce2050649e87a2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d7bdca9a945e06c9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tQnhyQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEVQQy9zR05sM0xWOHVEc1oycmZYMnl0WEZuUDBHTwpPL0tCMnp4SEJZ
ZXVQc0FlQ0RhaUtYall0RExVdmNzZUJmTng1TWNPMkRQVmVyMFhZTlcwU1FhV0xONEYyVnVJCmFG
ZThnVDBYWDZFVng3OEY5Ymc3TUl4cHB6NEgydW1QRWtrTHA2Zlh6RUttTWtPejNzTDlSd0YyRkta
bUZHM0sKcllRY2lrV3Z2U1pJTmViSkhOM1Q2Z0FNaW02VWhrTjZ0S01BVmtoZjA3QW4xSzlkaGtS
L1RiR05uZ0NBdzRsdwpQZDdJMWtNZFZIN1BaVVJRVThCS3p4QmNXdk5rdDVXYXg4NzdYOFNKYWdv
M1labUx5dUQzWnF4TkdSTkhOQlZKClRBaW13SWZobEllaEhsb0RTUStSbWhEQkVpT09ySHYwd3pP
VGt2SkgrMEQ4UWZRRWpLUkc4NjRpRStBTE5SYjEKUUlKSUR0M29pRjI2OXNkRkhWNGdXMEZ6Y09j
Z1hNQmJuMDhrL0NjUytWeWp2Mzg4MzVBRUJINnBSeU9EcEl4ego0OGozbXQrV1pvTjVqQ0RGN1dG
d01kMk5jSmVDR1J2SVdVT20zOEdidy9yRWIvZk9MdkhITkRteENSRHVlVk9ICmU4V0d5Z1AwZjho
aVFIenJkZGptc0txRHFGaTdhdnc0T2tiZjNhUT0KPTRCTDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002ce2050649e87a2e--
