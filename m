Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F9223708
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593775; cv=pass; b=tKt1AxeH9paLhnPFy+L7rMpOiy2H4rPWBp4t3RyxBDe1lg2i8wVX1QCNxHXPnFQVMCcPmfbrtlo+4+Qqu1Z1EJ2qCJ1CD29pCsoIIFvtJLQAqtVRauxmTHEbriXf6ppx7SDg38KGoF5MUbMnPT14KQFEaacy8U1amYnw+0wa5GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593775; c=relaxed/simple;
	bh=m72pMCypD9u5ygVhRluH3NKjSti/g6sQxnh24Xc7ISw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOLbeVleHeG2vFSp16ifsyiljHkGRIK2jdy0Zw2u9Gk+1QP+7kmuvNpA4lg2+dypGzcKF/6nxJYE81M8cN8UlHhQXlCuLH/e3xO6gf2QunUmfBb3VdCsnIcB3mQAg7RslYJDoWGpN0ofGdFHlwItiRqRxeOu+uUz8c0okZ59wGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiAHHV3U; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiAHHV3U"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5664848545fso1659720e0c.3
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 01:49:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769593773; cv=none;
        d=google.com; s=arc-20240605;
        b=WnSDOPa4ATu0O9SIJ7hTAIVzi1HCCDwwDSnm44zK8qCnSf9Tr/oYnGtpJiT7DJoXVn
         G/EBlDtts5KeY2mlnyNe1rHuOE3LCXftIOGMb4XQtIB/3cubkj5OqzJ0tYw7ZJnr6Nwk
         9pkVJvjy3rm/LFvTkHVXNmOu6K5ETJI6G6ocEPebhFJg0SOXyHPKUJXBoFmk8rw4y8kP
         oqSraHZmW+hS5cA7TqHWUyJdimy2WdXnKyTmLu6/jSQJAPot5mERTlFF/myt/eT+2P9/
         J+k1hdlnExtB4K/l8i1jzrQVjCetI6MCT2ynModHxeZFWEbYw+UTwIXhI1IP5pyjei9d
         S3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/vI1IK88DDjlOCngh2wZbSKH5knKzAwDhfVSH9ouIAI=;
        fh=shWxNb8qA0DxLN80W7Sz7Tg64EW8RLYpEjyr7bUBFds=;
        b=KcdG/y/gq9P8EXop9cTAExRdLD3AlFMcuHE55uSn1S3tTstxgw6pSdoLgrkMVBoZPo
         HeRBw2227GfBF8YbVZwSyieZxDlK+OW1tt5mfoQ70nZbbwi+m2Wd60FKB3wA+2wLvy/N
         syUXTdsTu9b7U7lpUROzN8YrMBdtqY5XiurwGPdNOFQmyISovfTqU+qaj7DaW56a1Qb2
         1nPe1/dIYUAaRaE+beFYzORNszNWaGr2NKULpKUrqAofdJ/c8b/6F643GiXFkULXmww8
         pls69DALfFqKkHxouPglRVRIsMv3cexgeC+o/hMsiak9h32vIvhRuBuEabuHvaCBjdkd
         yYDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769593773; x=1770198573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vI1IK88DDjlOCngh2wZbSKH5knKzAwDhfVSH9ouIAI=;
        b=TiAHHV3UuC+c/iLMzbEbF1ocKjvCFLQ6x/Zhpq+G/uIYvrTnAPw0Bii7n7f7m4xNUC
         UyVhRmjIKrPTyuJbdImST0UR3NZRpxKL/8yhIhp0rbZpfRunreCEBQ4S8bcMyl5nyLRY
         fJXyOu+nIdQUbnKy7z745DW/xyT/wIxN0XaNDMVqtosjEm9eC9IPcid03EW8CLDJXF80
         g9JHg+fGu9JckjuzOgbRsdFvCpD9B345nl5y/l5Ggvul5D5OlnlvHMAl9msIhg09HAnj
         mNaRPmvKahND8Ni/CUytLVWTFsJW6D2vAVWxgEC+A9pg8X8spcZDlopVO9ehg9bqct+w
         JeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769593773; x=1770198573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vI1IK88DDjlOCngh2wZbSKH5knKzAwDhfVSH9ouIAI=;
        b=k6dibaiCoHv2twJT7bF9yTFy7uD++68yybT/4/4oLYT3b8J4H83aNZJhFoovJnzcvj
         JNcC7OlI3DF6g371NtJxXGrSxo2bi/c4/8T2SQ7k54z9k01/bfa8l9p9p8CIohe3zv6a
         UEDx9ZVfRAwqrVf4VrGY36tp1uiaqD7PvuV4wlSeMwNOA5lmOtKVcDOE0ThKV1AM9sc2
         LDzMagmEtzy8WgIDrSNq5lwmkBI0Kv2aoayKH2mQcvDzlkmaSZqGaaDIGBrtp6RBUAXn
         +LVHM+zbu3mee73tpUCa5QWvIzllV9x8puyTTWah7qS79/j70VbNuXto5zQFtWf11GUx
         rDNg==
X-Gm-Message-State: AOJu0Yy67jngskCnXuveM9v1RDUG6wpkSy12FQLSXP5CIOnPBO3JH3e4
	rGYbjfHrqHBjUbm3G2yLoFlPZHoDxd/6K0MgRGZ26SMLXZIoKFchBkz8cuqWaZMTUsvJpSf2kxO
	XK/vOTww4ZONLFaAJJQIkjHZ6NNELNB4=
X-Gm-Gg: AZuq6aKJttQp4Ss4c6Ts6H0ASXgdI6SDu9DaK3qRQzhbhEzrnoiAPOcYelgHPrXCAmt
	KQPaZjuwBl1Mctzq8OOcOIDfnZ0Q/UV70LvX77QW/p1/x/2pQeqkdxdoQ8C7unnt4AwN4HzLeZv
	9ZC1jlfnWRCdIQaOe1z3W9poe9xt0oS4jg+pi68+ctUJURW2Xnm7UA/ArLddz53DcAKSiOsfOLq
	hML87sT+CqfAxsjJYoHNLdaXVoBeAxB7HXO3lTjwfOmy1V1U8jKPcTFYvwGkPNSANv2KA==
X-Received: by 2002:a05:6122:658f:b0:55f:c2cc:50a6 with SMTP id
 71dfb90a1353d-566795ef5f1mr1316671e0c.20.1769593772946; Wed, 28 Jan 2026
 01:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769522219.git.abrahamadekunle50@gmail.com> <xmqqtsw7f0mz.fsf@gitster.g>
In-Reply-To: <xmqqtsw7f0mz.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Wed, 28 Jan 2026 10:49:34 +0100
X-Gm-Features: AZwV_QjhGZFyV3AuYAaMKgwYszzGTiRpr1vjWs3loZZlobMF1OUEZdk6nt8YyNU
Message-ID: <CADYq+fYBn4WKbtdeXM0bUVsTCa40wRM3TRZOK=XXst-wEep4mQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Allow reworking with a file when making hunk decisions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 6:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > If there is only one file, neither of the options will be
> > available, if we are in the second of three or more file, both '<'
> > and '>' will be available and if we are at the last file, only '<'
> > will be available.
>
> An obvious alternative would be to treat the files as a ring, going
> next from the last one would take you to the first one, etc., but I
> think what you described is just as good.

Okay I will work that

>
> > This will enable simultaneous hunk decisions between between files.
> > After all decisions have been made in a file, a prompt shows which asks
> > "All hunks decided. What now?" that allows reworking with the file,
> > moving to the next or previous file as the case may be.
>
> I forgot to mention this in the previous review, but this would be a
> change that existing users may be surprised by.  We _might_ need to
> introduce a flag to enable this as a new and optional feature.

Yes I thought about this too and it is a good idea.
Thanks

>
> > The decision to use 'q' as a submit is because after some or all
> > the decisions have been made in a file, 'q' submits them as is
> > even though in the `help_patch_text` it say `q` will not stage the
> > current hunk and all hunks after it.
>
> The users do need to _knowingly_ leave some hunks undecided and
> apply what they already decided to use, and I think 'q' is an
> appropriate option to use.  It is what the current system does,
> and I do not think it changes with this new feature.

Okay thank you.
