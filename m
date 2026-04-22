Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489243E9F9A
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863688; cv=pass; b=cToVmMD5ZUwRjJCam4F8UECFDpNtWWwAUAD21xbDr+nGa1O63yYb14JuQO4G1KMwSEWDgZcZVX9GM69FlCITCG664okUFbQTQBVn8UClm+rIhB8s4h7PW2kRRG5MhnPFjB2uIKTNCtPZGxH/P0uXT1hNUniD+wch62v2r4RQFW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863688; c=relaxed/simple;
	bh=09OsDNqBzVh/o4PO3KoOQHOUn4LOOhY6fHRHctp+veA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/vrPmr6+ZOzUy+oI25ws4MPxRQAa6e45dxT4LiH1ffmvOko6zB8OIzqIs96hercCWqElB5hZayRC1uxGk2Aa/MViCWQkIfoEs+Dk9i4rdoDQ+oU1cA0qBwnO1cbCpFtwF8F54OT+ud3fF1wYH5Y0R9iWq7nWKIB1O6rwU2sndQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJNEH+Kk; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJNEH+Kk"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5675d609621so4031088e0c.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 06:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776863686; cv=none;
        d=google.com; s=arc-20240605;
        b=Ip8/8NYBdlhB1QfhdbJmp97Ph8y6u7GqRX0d4vbmtp4T4go2Pkwr3+7Aju6I0W/Soa
         Y8pz+aE5dlfmmkjN1B241MaiTFE4alcjDgz3LIIGya+m4eGl5gOUmn+d0LoZu/Q5PdYQ
         VcBy5dF4XFqyX3VC+nIorbw7ibhlrHtLcakDqmYkKhUH8r2mVVlSvkls+PmYqOPncOiK
         SRT+36rLzvFjUv2eqHKnFI0lnM8O5+Sha/CEQ5fXwhmAoCk1Epx4Ppni7E88JFY+tP67
         Zrb3nD4biBdPQutaLPKveYJIWNyfm6W5HvY6hKneJXwdoV6BfeEItDEdh3aJ+68boREJ
         PErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=09OsDNqBzVh/o4PO3KoOQHOUn4LOOhY6fHRHctp+veA=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=JETHoB5++t9J6JfnIhL+2W3MG4kMwBFm3PaM5bLXHw3zTI7/ApY6DxdQj3v7Hj6DIf
         rtr13H3nIFHaQ/Mswr4RoRGnet58Inuktivpf8COosvqh9iUK/Q9asAgnYM2rlUQx7Iw
         EIBpDD36/Pq3mZ9g1FB/VJal1MLNjepcUmT7453x4kLcb5TVWKOr8u8SZdJJtGRFu3Y7
         Oeu4WsZIRSLFjvgpJDDiBB+Wo914/BUY9hK/fsgRA3o46dra38GqSA950u7B5D5RNBAS
         mIINKaHRTVXqekzLfamDet4yVJjhs3mHG9yoNnNekPAqeD+yat3/E8TLHY+kNKA81wFM
         QjcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863686; x=1777468486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=09OsDNqBzVh/o4PO3KoOQHOUn4LOOhY6fHRHctp+veA=;
        b=TJNEH+Kk3bEMLBq693tuXQWM4st4PVAqH/tstiVDMV9vnHxPwfHB4K0O/ruZJQIHww
         B/ZbsLeSwXP6Pqm5H/rAv7aCuvXyFSH4/gqpkzU42lg7urrZc5DZ8Gqh7wxFtmsXQHSS
         nCSIKLtL8uddOCIf3Q83P7/x8TSMHcPoYNO2bpar2+3Obgt4PSM44GHKJddeCP5eBG8u
         fmDOSpMCYDLGbPPUE7SW5v4CzUP2Zig7wG0LoCTl7lBBnauD+r3FOoa+/K2Ng7etOt3y
         UiwKZntjBE9WhTU5UoA9MqWP+GGkGwcgXp0vlvFLf7HCGs85d0Z6HyyxP/SsPkj5dx8p
         Ze0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863686; x=1777468486;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09OsDNqBzVh/o4PO3KoOQHOUn4LOOhY6fHRHctp+veA=;
        b=FwsXAJADa/5L6XOzY03rzSkYtsIxQXClD8Wj1qFmfZAebspKL1ZtazI0HCogq/9vLF
         WuccivKDvbGrn4lXb3KjZ3aXyv0BHGDVbKKuKg1TicMY09qVnwrP1Nz/U0Jx2Clpug3z
         hpXpscVk62T3MoGK6F16TLIFAF2+xcf+NuuFJU9+bu6zdJ690k8Qpomit/FfIuHFmoZp
         zN7vqKnzPPblZi3XtxjuyWIaGg06lsjUIUmjJdsBkscJQaqGpj+FmbELNorJ/vdCQAZH
         TkDBPvd2wrJOsxw3ntV59qeeC3hDiVSGtwv32PX6OJfG7ONrFLkDjxFX9VMb1WWnLTBL
         npbw==
X-Gm-Message-State: AOJu0YwrxLPI8v3iHr/Hanm/84wJ/votUePPCfrKVwo+16WgpfxaOPhc
	9nmOVqTQjwmJolRjsfXhIvUlmqorMhPavk2iLmZf11kQr316Y1PQ2S+gTLq7zKRn+70+uSIOzMy
	b5iqfmWxzaCRXkK8WdPFdNY+jIKQ/ZGExkw==
X-Gm-Gg: AeBDiev0AfLfcjR177oOh28YAeCYjVxythXYCa/p9sTmWz/Fdk+88jqjZNntrzYv3T7
	2lJlj3dpaVhYeueQLNl8JjCUORizIhTcHVmhxsEuzcFoHzkcyuXWDR9TloGX5KFd/CKGOuG581k
	Y6r1XVDCruBYJaRr69cnyzHvyEGr1LdQPVr8wX6DfOLb8vac+uFtcgln+qgDEoYHT/5SE0xpI0f
	M5YoWOJSD+vIiAmXXxS91+s4hE4r3qT3hdsBrzyeGeiPJETFhYHx77v1LqxxCX5VWw78EuI2PaK
	9R76trbxJfO5OIkpSzcOP23HGEKIJBll9WjREa1706nubr8wSPLP
X-Received: by 2002:a05:6122:1347:b0:56b:815c:961d with SMTP id
 71dfb90a1353d-56fa5861c00mr10960732e0c.5.1776863686005; Wed, 22 Apr 2026
 06:14:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 06:14:44 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 06:14:44 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aeit12h5l34Wkon-@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-3-513e354f376b@gmail.com> <aeit12h5l34Wkon-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 06:14:44 -0700
X-Gm-Features: AQROBzCfleKRfe3uvKbMnn-78MPFLGB_oso3KTAuv1V2snAfWe2mb8uCtd1U0NE
Message-ID: <CAOLa=ZT55_3433Si_dGy6U+XkOK6SiiyG3h1B5fk7SysphSsSg@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: return `ref_transaction_error` from `ref_transaction_update()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d1b70106500c5055"

--000000000000d1b70106500c5055
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 20, 2026 at 12:12:01PM +0200, Karthik Nayak wrote:
>> The `ref_transaction_update()` function is used to add updates to a
>> given reference transactions. In the following commit, we'll add more
>> validation to this function. As such, it would be more beneficial if the
>
> s/more beneficial/beneficial/
>

Will do.

>> function returns specific error types, so callers can differentiate
>> between different errors.
>>
>> To facilitate this, return `enum ref_transaction_error` from the
>> function and covert the existing '-1' returns to
>> 'REF_TRANSACTION_ERROR_GENERIC'. Since this retains the existing
>> behavior, no changes are made to any of the callers but this sets the
>> necessary infrastructure for introduction of other errors.
>
> Yup, makes sense. This doesn't buy us anything yet, but will eventually.
>
> Patrick

Exactly!

--000000000000d1b70106500c5055
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5bd72ad69f80b445_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ub3ljSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1AwREFDZzZ0TzNjcGFKQ2s2MUhQTjlVTkQ2NWhuLwpwQjA0em43cCtP
Ym9QMTFvY29HWjRncDdXWXc2bXlJdEVrb1dlakhiZDJhU2RBOG9qNTdNNDVxNjc2Y05CWWtzCnB5
YVBWM0w3WEplN0N4dm9HY1lrdjlYbGcrMW15LzJieEVLYlI2c05wVTdYUnBLS2U2MUVUa0pyYk9U
eTd5QUkKU2xhMmYvR2E5eTNpNWRWTUZ2dXVtb3JTNHZyZTZBOE1oU3FOOGJGVDZKSnVaa3lqS1dz
WTNXdk5UYWVKdHFhaQpMV0FMcm81eVN6SEtQSUpNNkwyb21tZGJ2NCszbjBQdkVudUlCSjNjdjFC
UVBxOCtHNVJReW9BbkZTZ0JxTExECnlhK0JzZ2FqYnhiT0NWaVg2QmdrdVBVbTZUOUE2Uzh0Zlda
NWh6dXRpTDh0cHlubW1ycTVNVnFneDdPcWtNdXAKaVl3VkFSOUlwRzNhMWxDQTZFQXpYMDBURWha
MGdPNWl1NEI0N01va3NQRUJoalNTR2loMlY1SktMakNjWWRQaApMdDg1bXRKWFIzRktEY0lkMFlB
SHovVGdPL2dYMVMrSXY0R2NHZmpubS9MVjJlQXgwMEMrNU1jS1FHdm0vSzJHCjBDNXczY3ZrU0E2
dnNiQzBuZm5waDJqSFZhOU04QngxUTZJK3JHRT0KPWZTc3MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d1b70106500c5055--
