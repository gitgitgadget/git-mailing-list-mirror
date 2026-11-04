Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793836009;
	b=uxX/VuJpR7h+HOU+mjHlbyMBJTliNFZIDveZZe06DGUyayqTFkuUxE28ly5OciISRa8N
	 nyjScybh4rhvTZlC3jTTTNhryKld6oI2V/ToWQ07LJlmAeYu2MG5P107NjspDK1EUBQXJ
	 xFo/nhWe9etFE8Tac7ClTG471Kj4AE0WIoFCnDxqecMvtW7f1WCZIUdDcrtWOPEeGg0B4
	 nKdkPTF0w76rLbQlAmeAzzwWZUgWz/Bs2jEJpvCRh7Vw9J/sU7kw8SCkLrnrpxqQgjzRo
	 U5qhIV7P7sGZIkyCz4voqyv80dCLzWbmCN8qjNFy6jEALWRFkA+JmoPI0d4/2hzVL3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=cuEax53EL86tC9UjIrgXDqU2dI8qKDFfPvjLLzYsQSs=;
	b=VJhMq/V98d+W8BiJ0sCOR3+IhW+IHHVIe9I9nx0bpS5x+nPqJaTE/yrtVkd2wYp389X0
	 3iMBSZu9vn1SUHwS9EQZ6+ppHblGkIa66iYd7L3Qqs4MZvA0VKrKdwcnJHa5pUaHxCznb
	 d+U6ZLM3hTUD3zKEHTs+Kuu/gYoVlm4zwrdPx2/Xem/kJIF9Di0qzoFo1g7RK5c/2/1fm
	 dkDnc1op0sXHVmKO6egXb7iSEbQII56ondPQiMD0M41r28KosU7Z45Zn7GckearITiOO4
	 HdSWN9OoMIe/G7b3FfhMerKQOvjhBPmTU+NQGPGd9kSKbRgzYaZmsxMSIECPu48z97Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uELyQTtj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C799606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 23:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C799606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uELyQTtj
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so202248966b.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 15:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793836007; cv=none;
        d=google.com; s=arc-20260327;
        b=EJwrfkbvPmNFDOcK8vvZ1FDndONv7/I8lz32KxaeQ0entYcMgkE+K1tTbaSIrxOgm7
         NoUTh1aKQoM8iRY1JcY/FBiHGOdyXNxpZetP6y0ASC08985NVSD4JX6BdfuIYIXgL5rt
         otKRN4BxmiHd82wTD3hlnEbH6RHqB2mWYRmosbqfPhXj3mk+i7UADp1HSYp89BaTfRaq
         d/M1NqJ2kjBAdIG7RlwVxPd+kC957zTi5v0oZRljyn0YuZ21ZsrxyLrLTXCzCeX3lhll
         hkPoIfp0yNxpL7WUQCYEzmBIefHVS9eToKLc4W+lhlzZOy7AykOVJKbjOrwuyQr8s+k+
         4r9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cuEax53EL86tC9UjIrgXDqU2dI8qKDFfPvjLLzYsQSs=;
        fh=io6+tNgE2msewjiwioosHCcYB+/oDOrBVraMhRrselc=;
        b=izD1N/1rup2vXAs6pwbts4GFZVeJb8fb0KdDBCDdbGJok/u0Ibrqt0AXBrEez08M+Q
         G87u8GZoxr+rscWxwor3UyZv8bY+pFXsHdR/vmO4anZJH6sPoBib+8SUUoaNM/UUnYAm
         E3jrf2NB4760q4e4sPNvutS+7KaKvCDiqVMtsFDxnlBCJ6VNoMqECz/65sevedpEFW/L
         vpAh2klBTMm1ocNdd6URshASbHyLHp/Mm5wnhaVHcLYv4VQnHsR/bY3HEberxZebpmZv
         yixf9gD/CSCReSvm82a30PwXgnbO0+Tu0KzGpGFeUIFfji3UkiaiUNY+8VmJqfhJvHXZ
         Ymbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793836007; x=1794440807; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cuEax53EL86tC9UjIrgXDqU2dI8qKDFfPvjLLzYsQSs=;
        b=uELyQTtj+WmANGJl6LziasXNPSreNmOpJLtrdzEyeJZX/0ufmaNdLYR2KcXPcsTwFD
         DzDsJj5D4bUbDbQc+sSfoXqf7sHMzEaxFEmrLKxLimlWAPV9FNMjWqeLCITprahXdRfs
         u6TitjsfudspYNs2QgNZMmcLNmn3qB9l+VJoqG2aVzaAgOSkyV/w4cygQ+0vuO24l0Vp
         vTupu9wD+FN0Y3hh2bC1+/aZzto3NIx8UiAt0uHf28QEyEwMNjfvU9xtCn5Ayah4o3LO
         LrhZCMamMrF6nTWjqpL/7g8PTpWOaSQLlSkHjiZlX2UV6CFLth/rtTGJ4KfH3CNwEbWJ
         XxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836007; x=1794440807;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cuEax53EL86tC9UjIrgXDqU2dI8qKDFfPvjLLzYsQSs=;
        b=b0dzuBSnMckJNdZOwa9R75+6zfj31irpwajZY8OyAAlyXF1ogP32FGv2dS0jxu1QQs
         tgNI1X4PWLeEsX24dvEalwKbO9GWG78dyMnMC5ISB8uhj1LcQoYnZktZ6E3RUFySzVCb
         3l0CdTrsuB/kjE/mFT5lJJriVcND0R5mTmO4aGgJlU+M4BeR1pb6zy5+64TsqHPGSrsC
         stRdNaQ1mTFp01Y0OyEX3KlukdcBQvnFervg7Jx7qAtj3IDN0L5LmN1uS29niDmLVecw
         zYYogllqpS9f8ZH5TSgFprUoz+93BBB4S++ANdVBVcgXsNjCrA4K873OqSU0fE9OzGdW
         51OQ==
X-Gm-Message-State: APuU4Z9ATQKca41FnXzJCVjtOCX2MxwEQTcEUz9PMg10z2DZiGQVpF7+
	lJGo6a1+8tSS1EqzW9mSU7WthdWd3XWXer2k82IVxvV0iRUW5Gkw5+GtVPS8M+C7JTEeNVauSU+
	8hvIL/Cu7ETzNcdWriwplnLkgMEAHDLs=
X-Gm-Gg: AYBFou1n+5x7y4y6SpnJqRfjpM2HCVpEQsl8Il05HxMynXigt/OqA+uDkkvNtt3UYLO
	sq9wzB2KRwBl5xFqZt6eqGCeIAuWRmB7UMcvtgOtSoOsEfz+0ug66OuCXki4XLTu80Q5jHFLh+r
	/M4bkVUPAngjoWq2TmCTSfmmNwsi7tyjhRt+v/fJqCzeZisL2Sk6G583Wo+LsecsOvL4CB1cNbK
	xvOHMfCkmzYzpKmDstP0kxrfnqgaI8dXSrb7ypKiNnuXHY945r2JE8Un7YXqrTXFHrDZsXyJCxk
	OMZDoBMcN2GfxCUICi08DcXZ8lLBChZjvpLE+MfpHieHStKQxVzhLbYIC8qy/nvpbnyHMA+8PyI
	haiVznwBXR/FMM1EWgleyKpJhrkwQ2ujN0Lhg+VSTq3cAh5p36ttx3Ey4b1Jc7QrYUJd9wtaFJB
	uWEz6gP3LJHE/IYj1/
X-Received: by 2002:a17:907:6d29:b0:c33:dbe8:291c with SMTP id
 a640c23a62f3a-c4ca7a4dd2fmr1683656966b.20.1793836007530; Wed, 04 Nov 2026
 15:46:47 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104143741.654-1-kerylefondji7@gmail.com>
In-Reply-To: <20261104143741.654-1-kerylefondji7@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 5 Nov 2026 00:46:36 +0100
X-Gm-Features: AclHuK_Ug__5brIuh-ZEOa0k3S6VOgWGMCof-L5hV9L98dmc88Im1ag9PsUwvrQ
Message-ID: <CAPSxiM_wivLZhxvKjDAs0HQmqYRZd=Fb6xmfQK2ioqaWEXWC+w@mail.gmail.com>
Subject: Re: [OUTREACHY][PROPOSAL] Improve how command arguments and options
 are scanned and parsed - Keryle Fondji
To: kerylefondji7@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com, 
	christian.couder@gmail.com, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Returning to Outreachy this year with better preparation, I was able
> to follow the mailing list workflow and complete a merged contribution.
> Working on Git's parse-options API confirmed that the "Improve how
> command arguments and options are scanned and parsed" project is the
> right fit for my 13-week internship.
>
> Project Details
> ===============

the project details is missing

> Applicant: Fondji Tamekong Keryle Blondeau
> Mentors: Christian Couder, Siddharth Asthana
>

Also, do submit your application on the Outreachy application platform.
It is very important, I believe you can always edit your submission until
the last day of submission.

Thanks for your interest in the Git project.

Usman
