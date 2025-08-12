Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3220C469
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031896; cv=none; b=duqR8TIy6DXz4SA5NhrDopTLBeennsqEn7bHui2bajOoxIfmmN75FnT8Yh7ipbxS96k4t9/dbzE1tnmw/sb3Ei99iWkf0apowXI6WZip4ZelgXqWcfhYq2ibd+zTWpWXfKvcTwoILxnjGVGQktpi4XMum3ktYiXux0hGBEHHJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031896; c=relaxed/simple;
	bh=dfe24zzfF6tNU7oDBuFVatRtTkBfpZ3nYQhveIuch0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aARcnZTw8sbO5sIIfSy7S0mBmM1x9DPwHDBOfZDJfgXypkOeYFqCC0m3JBDRRlTmV0BKr+0c+YlHNk+Eg+bZv/XRWSPyzZSmQZKi2caqqEhzeZN68KW2/yfuwdM4EEm8sRrvDLeLf3YD3lfNA41Fc9MM+llyYyBaCggoul8XIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFutHHQn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFutHHQn"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b85413019so6987177e87.0
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755031893; x=1755636693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfe24zzfF6tNU7oDBuFVatRtTkBfpZ3nYQhveIuch0o=;
        b=cFutHHQnn0JNtIZsHYSJv2MJeGNgxZt8ebkOqJ2gEfJGEKUy7LMorD4Dl6IKUYKJGe
         3T1qsysEEDOTSPxRXGP3Ul10vk9ASktBTfy1MQEzlAE3c+LdEthwHjwQs8F05cfd4FaT
         HD8BDLUGp9r1QvoC0A7LmVeTb3cEKb7d9fRl/SgyY2XQN0fdrkSZpMdXkJLQrBxDU2/P
         ROnW2pAVnGGYbq61yughgX5u9q93qTA9R5cahCa7K72HMOF2p9QSIp8/sxAUHn5M8D+u
         Isbby8zeCDO6jxHJ1Qc7MPkirXDvR8W1l01rFplye4jyEuio9SzLiT2y+44Oi4Yd96GX
         Aemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755031893; x=1755636693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfe24zzfF6tNU7oDBuFVatRtTkBfpZ3nYQhveIuch0o=;
        b=Eo2eWjioPHtsHkHRxffEI9PHEjV+qsxsGOf4TjgOBNM8toT1b+df55B33xpjGDeJfq
         WOQCZeVZJw03YPUpWykg0NUvVeOaOatnJCwmpZaqmMwX5mJRlXsF9yckI5uFajfO3OTB
         Br8o/plhP6Xrq5i9LTadHA5qf4waWGiaFkoqf0urKdDoxOL96j8RJ0x2cyOSIMPvkPCj
         jnAtbWnLlkTst8zfrKwng8Cz+cCMHcKXTNP6viITCWoym3Sb6qMoLcK84HMa9Mmc8kjl
         8bmatczd4Bu8Ub5BlHH7l52yI1CqRgwexPKpwGThkWi6kcRjH00FvqnvtS9qPFqVby95
         2Zvw==
X-Gm-Message-State: AOJu0Yym63Lrl73aOWCQ5dGhfOTj8jJS4TLHTtgb9+YaTn2joP8bxqoE
	eO6LN9P16zLx6uBrUfvF4oHQQrC/JC/sqoV7hucgF4/5cM6TxG3N4gh1Cqcl3qXkn4cIZzpSd1o
	frYIh0Z6I2X3JkzkXZ7cdFYICgqBT3zqOzQ==
X-Gm-Gg: ASbGncvVspPaQXu8VsdF9DAyNro8VOtI3tKI6Wu/f4ZXyPcdD+Rs+fBidTc4IDhyEBJ
	TYY5fl8V7KpgtSpiNbBhsOSaEnPRV/v3sz6OWOPmij7CH6UZvLFJsrIOHFtIJAFimp+Yvee0WMa
	nIYYzA6XqQMFsq0pTgaGIeFVpRAWoN6PYdlXFNBDf8Xf2Zwd8uc/KyAfqEDe+DxJssO+4tQMJSB
	OT9fFFD
X-Google-Smtp-Source: AGHT+IFrfpp9cEZHUzM0iNJsMMZsO74XCpai2g31hAORLsrabpxzVD2okMXSLULKl8Dp2F7vj6ZMLRaRRKwkpvZVkRE=
X-Received: by 2002:a05:6512:68d:b0:553:2f47:ed21 with SMTP id
 2adb3069b0e04-55ce03c8a40mr216941e87.41.1755031892665; Tue, 12 Aug 2025
 13:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com> <f7e8e4c63a1205740c2d54368d7bcdd686882680.1755029249.git.gitgitgadget@gmail.com>
In-Reply-To: <f7e8e4c63a1205740c2d54368d7bcdd686882680.1755029249.git.gitgitgadget@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 12 Aug 2025 13:51:20 -0700
X-Gm-Features: Ac12FXy7Ndsi8m9CmV6AOAtkRNkxn6qMBKtLcdMXJphcdPKIZ8eVyRIhpFJZwos
Message-ID: <CAPx1GveEX_r8thqpux0jcbEsEyLpNOvRWEvogUp4m_cNC5=dbw@mail.gmail.com>
Subject: Re: [PATCH 5/5] doc: git-add: explain inconsistent terminology
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 1:35=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +TERMINOLOGY NOTE
> +----------------
> +
> +Git uses the terms "staging area", "index" and "cache" interchangeably
> +for historical reasons. Many commands have flags like `--staged`,
> +`--index`, or `--cached`, and they all refer to the index.
> +

I think this is also a good idea. Unfortunately, `git apply` has two
different meanings for `--index` vs `--cached` (I believe it's the
*only* exception to the "means the same thing" rule...).

Chris
