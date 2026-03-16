Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E613C918
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659847; cv=pass; b=PBAA+sA1MNTS+ZALdlAe7RNmb/p8plySo0UbV51V7vJVDwFt1BGiiCV63F7SuCGyWcoN9hEZrJXp1OpDxbBrNEPwFPj7GDx8NoquR1bgM4KJcLBPjgYzEch5yGb/E0bJioQHvBvib4m0ny4vHan6TZD/4L+6R5b2qNDDq0eIeFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659847; c=relaxed/simple;
	bh=xT9t9yevP64nrjbIBQdxpEaKpXsqgwXS8zmGS6xMOmU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ZAHoTsl9uwjuFIfiuQde4dBIu1TrEKU8naYX75Kmvwmv3H+34OWDgIaFz1OEo1KmU+ciqw9O+GRCke9nGj1bCPOq2I9BDB1rtkH27RQ+ka9UH7tShV5ncTmtzfX5ZcWd8G9eLwnydAl+DOt2PRSKZVd+BiJs1XelxVPNK/AP/kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTLgzcuK; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTLgzcuK"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94e9810221cso814038241.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 04:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773659845; cv=none;
        d=google.com; s=arc-20240605;
        b=JMBRbF3b8l9BFVCgps4fRpVoBWmOxQ1l2o9i2z1/+Ox8cZnnFjHPP0KbuYz7ihyweC
         d7nKsfzxNUqDFRO1DQUysZMsJfwNDMwcfRtWfBaE6DBGDSqd3I1Znm8idfvYgBcpFsUJ
         ihGRNzzOVHRGpMCrxdbSFERHYiACQD9PILLrrsq1GoM76KHbnfw43vMp4ipQW9cXv10z
         fwdxov5ldgXFAgw8/R37hmzgfHKcqVgik5j5rUm7p1pdWq9vrO6I8/F1JDK933/6Ox2i
         g1mvSmPpqgUj8BJE2NTE7MLzCppNIRinRUBgflpd/NuqJsCetbWq5wF7UfulYhVm+aXY
         EPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=Yz3G20SYwWr2v/DtlllBOZ6UwUDcLscqRQIDDkgwSxU=;
        fh=Y7rLwkoUge67vj+VM6w2Tw5wISxEcqtRrfH8gi3YjiA=;
        b=X74/Ejk8IE6TpKIdztQK02rsmrfgdqGEE7TL/cbEeTRY+WMMQnIddqmn73HQEYR5YQ
         TJtRIPycTumLXJxtLEHnR1HtsVln1q5vaE84E9a1fAVhIIfNtO7dE+vPKv7xuMdldwlh
         6cgWBDjhU0Uvfc/gBc3W4W8tpzbT2m3vk/CZ2I4ygio54fYm01yPq4ESBpDh9u4p2hWU
         2E4uEIQ7cjSHIJAh6mTaEoL6BEq1OYaR6GpMBLzZoMqgnVqpThOfE3SeCTLnv89k/XfZ
         IkkLDishoknJO/CoYcwZcRsp//YCtOLy6kC+P6XUiBAbwzGxZty3NhIAdLk82F9G/wRf
         y+hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773659845; x=1774264645; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yz3G20SYwWr2v/DtlllBOZ6UwUDcLscqRQIDDkgwSxU=;
        b=jTLgzcuKKzEbyUiontYvhDsXY/o6PAIR1NgPuu8MXrMyyTOLEHxnFIXz+2O6dGbZdn
         k7nwvLb8AGdDr+D0GkhMi08WAxpnVLvv6D1T2kRPnUgPT0FSHB3OSy3diQLKX1nt/vq0
         oaHvdsrajgOguKymsToDqycqnaxe7bJVB61qGQiu7MDhNp9gsR7j87/91O0dX7zuVtOS
         qLm709fda7R6RQEgai/ioG1AMzZMe+9RfQMDsGkwlT7zy/JNFI7WK7Z9ztrlSjyOjKRG
         mZPAWnSxLJVYWneQUxCZNCnKeqUVgpUULh85GW/+aVF2t5WlgPj+Kg9M46QDGoiTEGJq
         Qfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659845; x=1774264645;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yz3G20SYwWr2v/DtlllBOZ6UwUDcLscqRQIDDkgwSxU=;
        b=ZS06cEYWsZdyod7/kxP5VDVAV3tLTj1pLuAQ1r7L9HvcLEnqqSwE+J8zlY5VKAR8vM
         LNiXta8Qck+ZxZ8D6pRv+i827qWDH011G9E8q33uvLxKWHC/GBbRs+C9xAb4zkBSGPxh
         A28j0T7BXfV05s3gGbEVpwlmkXKvRVhaYQhDkPUMzqJ717yBrFSyRoYkiGQtZAJGzT3S
         JkZMVVsb3jRJzKIGBSI7ESPLOQIFnaZ/I1QePmN3zh2Go6lcOKWVFxBalYzT2Duc2ou0
         bAU4iqbywhRnK7S8ewmoIFfUVmkj2fv8IelUGKYs3uIZmm9fR28lL4r1OCkvvtnREGkJ
         7TbA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3Ee+FxZqF1MN3NXAYqwZaTdjh/PkXu/RcduAin6iuYswvCzZfiTw0svAceewsEsnTS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9sDsrQcAWQQrSkuE1MvWX2IvCMCqKwIs/NGTmLMRMwNSKnsjA
	Xw2AiZORsf+sR8o3+q3z+VZTI37NJhvHr4EsLdE/ArAvIiJ6CstsjwLNCovQQ70vspTNaXmMdf+
	IkRO7mhcahkydpbRskTSYnBzfDz0Ewlk=
X-Gm-Gg: ATEYQzwy++XxSBk1dqYIbTOveSV/vgF36MSJupRyillc5WkBa3i2HKDqsffYtZgHwqf
	fl2PdlGiWRhyoSehhg70UQjYidveDfGSCngo9pVizC6AK6y5bn5Qxga5oPgeeSWkaSeajmDtdi1
	yXCXjFwDPgdwZrxynhIW/GI1Rb9liqFdT5PEiiQBvhTi9OgxglzxEIM9ONM0OlI0znXSGAHV5Zh
	kNLSYUVkyKMk+ZXmV9QqwU/64ee+tXNKRQ5vcXOa8GMovXaimhT58L7i/zhcfyI05rGGtfCTifp
	LiJ3XuvuZ2iczSlXKgQmxFXQy4w9y9xPEFhh/IsL5w==
X-Received: by 2002:a05:6102:38c8:b0:5ed:f13:e58a with SMTP id
 ada2fe7eead31-6020e62da28mr4303187137.37.1773659845263; Mon, 16 Mar 2026
 04:17:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 11:17:23 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 11:17:23 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=Q3ifFDw4dDviw@mail.gmail.com>
References: <CAKWWG_nGhD6vqhAS1mkEwBQPrg_YX0+C3-xW=Q3ifFDw4dDviw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 11:17:23 +0000
X-Gm-Features: AaiRm50pZ7PXpk7dObWfPZ_yKkn36gNiIEgnSOXRHpy4_0Opez2JX_1WCuzKMbk
Message-ID: <CAOLa=ZQDNB+4r1s8dD=ZJmfkBMH1Zm8d4=CQjECqvRUGDNJ22g@mail.gmail.com>
Subject: Re: [GSoC] microproject idea: improve corrupt patch location
 reporting in git am
To: Jerry Wang <jerrywang1201@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000007a1e7064d225d98"

--00000000000007a1e7064d225d98
Content-Type: text/plain; charset="UTF-8"

Jerry Wang <jerrywang1201@gmail.com> writes:

> Hi,
>
> My name is Jialong Wang, and I plan to apply to Git for GSoC 2026.
>
> I have been reading the Git contribution documentation, including
> Documentation/CodingGuidelines, Documentation/SubmittingPatches, and
> Documentation/MyFirstContribution.txt. I have also built Git from
> source locally and started looking for a small microproject.
>
> I found an older open issue that still seems reproducible on my setup:
>
> when git am encounters a corrupt patch, it reports "corrupt patch at
> line <n>", but that line number does not correspond to the original
> mail/mbox as the user sees it.
>
> Related discussion I found:
>   - bug report from 2019-10-02:
>     https://public-inbox.org/git/20191002184546.GA22174@generichostname/
>   - follow-up patch from 2019-10-04:
>     https://public-inbox.org/git/ec38908d05f0d40190173158ef3f0753fa9f1184.1570226253.git.liu.denton@gmail.com/
>   - GitGitGadget issue #374:
>     https://github.com/gitgitgadget/git/issues/374
>
> I also saw review feedback mentioning additional test coverage for
> cases such as stdin input and running from a subdirectory.
>
> I reproduced the issue locally with Git 2.51.0 on 2026-03-15, and I am
> considering working on a small patch in this area.
>
> Before I start, I wanted to ask whether this still looks like an
> appropriate microproject for a GSoC applicant, and whether improving
> the error location/reporting plus adding the missing tests would be a
> good direction.
>
> Thanks,
> Jialong

I see that you already sent in a patch. For what its worth, the General
information page also covers how to approach microprojects [1].

That said, this is a good microproject. It doesn't touch too many files,
is not too complex and gives you a good starting point with the mailing
list.

[1]: https://git.github.io/General-Microproject-Information/

Regards,
Karthik

--00000000000007a1e7064d225d98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 104697f603d304de_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tMzVzSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnZnREFDamNGVDh6WmdVVDJ3Z3dKekVSTUk4ems3eQpYMGhRajBSOGtT
ZjVYZTFCR2NvNnNNczQvd2k2SllPYUlFZHhJNTNLeFBxUWhWVUJxQVdaZ3gzL1E3dUEyTTZWCmZ6
V0xpaG5BeGhkUDdkQ3BXQjB0OW54ZDhVL2ZEdWgzcWFTNy9JZEM2U1dxRUZRZTZlUkQ4d0lHdlhF
VXE4VzIKYVdta3p1VXRKQWdBcGZadTlBdUc4cHBNV2xWY1BEcE5KK0dQQ2VjMWxNVVBzSldnVDRC
U1FzTm41MTBiVi83cgo3d0JCQlI2Z1h0TUh1TkdZK05EVmtnTFBDK0orU1ZaaEoxVksvandBejlL
UGZQQVlBTk1JR0Q1MCtJODJvR2cxClM4d3RSYXJPdi9QQlMyV2RNdmZpU3FFNkZQOFc1UzR1ek1S
RTBzT2FrZEFFaEwrNWt3M1c3NDVld1ZYanBuVjcKYjV4akJ4cVh0L3BQenF1MVNNSVBjNWovSm9J
Z2lDamZZdlZ4TDhTUHc3MHJxTWs3NXVOOS9jR0I1cGI3NWZlaApoaUZVNG9tWVRGTW11RS9jR0FV
N1Vtbk1hVVFPYzNzOS9xdkYwNmw4eEFzWjFvZFRPaVFhbFVYbm5HU1N1d2gvCnBIUDVZVWtvMzZh
SXNLK2pueFBEUmNxdzNEL25LbkhDYlZyaEdpQT0KPXVNY3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000007a1e7064d225d98--
