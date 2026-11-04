Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793750717;
	b=ZDDEKW+eoJDI9lMd9gazeU9aJ+0dFeqscFtZQVQtmwVfaKjhqQklo7hNmZgD48zxFGpU
	 NRTyGKZOSzcqJaA7YfFrcpT/IxVSDG+R9JOcJ5x3fpvoK54N8uZAyMEsvX/GBiM8oQMZz
	 veG82+mfmz4ls78+8/R0ZcL2wO4lpikmMEF0NOTNly68V9Z2OEJMKVTOf+au8cKiq95yY
	 PqjJGfBcMFWpGt/Uc5Pgpzy1eND94hyCEcraieRJXgJGolMSQWan+R5iKgb30BdrubyU7
	 2/P+grvBBOvZ8kexKB/0qXqqU4d05qq7CXnMy2O7M2Cwrnd9BpMeKeS+DZVPDDlmy4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a6Gi7lDbA5yUmunFksNzTVbtYrasZZiJqXxDFqUXKI0=;
	b=WpPBdX3mBiLiJ9zJN7G6MieQ9jP//P5Ga6dsFVtQSOkmtDVZHe4oMj87Z0rxdwOsSSRq
	 ZkMmRCqxMqP5xhIxoMhmQXmBUNXM6SNLpHik7r8vuSvh8qnKIECY8gMcLZlqZDKvFjhW1
	 zVXfdIuoMuOtbIu8nD0FkFp+iWTSkj6HIZolcRZUHMViqY9SVLKozBfczORY7/Auy+u2h
	 ywVglZoT/4rJGPKfPqH21HnazwSlPJCVR76AR6nAoWo4FBaAcQ6VK98VrGuFP3pnR5xeB
	 ajx4LONWjoEB7FdntXJyG8mkGVDFjfKROTRozPbE40Fn9OyPMEr8kRRfdAXTbcRviSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hknb0wFi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818B606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 00:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3818B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hknb0wFi
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so120692e87.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 16:05:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793750715; cv=none;
        d=google.com; s=arc-20260327;
        b=h5rwQFhAxgpbZLEHDp/uPLJVlghhJcedXrFJzdmyopBtIU0Bqphzyi04jrrulHRZWS
         voTp14GlGgL8yEmYHyN8Cry2UfNLnhGvgDRAjnN8TkEiNxGnF096mGuKngBcAnnhCl/0
         JNoNWP/mvAMb9bhjtUYeeP7N2eu0Vj3zC2uc8MMy7evKYjcSDZjgyZ8l6/wEnHVPEnY3
         j8zwyTl8PjftGuajBYQbcpLYtNgZvTbHHlONBAVhBXwunQbglm/H0BT2GeazxxXa84C6
         0UdyfBs+ladDqtvXJD8PHwWF6LJqO+4J32uZkKdLlCITdzoxh27BiBCvgQWLN01BAspm
         s+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a6Gi7lDbA5yUmunFksNzTVbtYrasZZiJqXxDFqUXKI0=;
        fh=Qo4KJIwqFJN2IFFeSrmir0NAwfkflHLXuI8jzJFz+uY=;
        b=I2bfBO32JdTydVoRFQWD6IQpcO/LjN5wcKx4gIqGHFRFNrHgyn7H+WuC+o5mrIOMfk
         k3RS3rH3OgpPmtHWuM0YRRm224aCkha7fRILHDWbfAasONPwpCQRp5OWbxQIDFcjjGoS
         2RCax5FSUugcOj43R66dMSXzyd0tvtgwd2rAwJ1xxFDvp8MnGh5SDUoi5aGoK9lCdUJ3
         YeQXWk65bp69Gf5YRC+PDTqjVVBsoPLp2N3jxcBm376twgbngpjNZrb9ZMKJMU3jAdqT
         f9q94opkA2A8jqbomPH4NpzKrRfT54lOFUIuC6dJeVEorE6LNL1EjVUIp72f1L4bYe+3
         X50w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793750715; x=1794355515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a6Gi7lDbA5yUmunFksNzTVbtYrasZZiJqXxDFqUXKI0=;
        b=Hknb0wFik5b9KSBqVtBQOdkxBTvgAO8cBm8UcPfn9Yk0SEUpuEopCOsmBhnP9K5jo8
         P9doashclBKntOTuWi+MjEs55EyxLRxjA+OJhgrS2ppiSblkJlYHjTjl9KQ0PMABxqBQ
         RdlZ90dgqGrg+sZa912/zHa4qpqMop6kQjONOGvUuU6z+LaLTf9CUgJtC7Mgf6FiqD5R
         oVeSfcFuiLHaGUxtfxyZJIlkzNRl5Oiyr84vixYvNpraiN3Qn/zq0Hg0Xa3mxn2opeFD
         rYj80baX/hX+eYA9S1ya+KVa7XeR9ArZHjpfuqpgInIZPe8zMVChmiaYmXcNjBMg2RP0
         FmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793750715; x=1794355515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a6Gi7lDbA5yUmunFksNzTVbtYrasZZiJqXxDFqUXKI0=;
        b=ivm2jk/1NFYDh7oAiaxKvwhcn3MU4M+d2gNeRsq1PpynweGFwyWp4Pi+vhsj42E0tg
         vR8tSLiXTFIbWlqfhP9tHkKJD/duVA0TGSKPvseupzu89O4Wo6oO70Prg4bFWsHPjr9L
         pQ9rfeP4ysE+nVGhivIjgn32jseO9KLvE5e10txuCiwf5o0hIj5zqEWw4bI7lwRfX5t1
         qQbIkdSMlWXSPnUMUZhx+yFqRdtizFOJY+QQO6Q5eriSsHkadZjoF7DHpcczFtaYkgm2
         U/Tg/lsu5jKd0basmPBk+jAF+t1U3NbnaVdl7Uaq0ge795f0uQnDHzVrmsE12iSHFxxl
         IKbg==
X-Forwarded-Encrypted: i=1; AKwUvBwNJCRUAV5vCG4PWJUO0zf5hXrnEbVlszt62LF5piM4frW+Bmpc+4b3CBLIdC8ij/Yk4mU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nr8fnC0qzb1tixKr/YlhKOk/obvBxpXT3g8Yi0984n268nY4D
	5KlnJ3h6/VeRC1sV0hj5eX4tZili9YyZkHualYZiH+iuJ7o9Yd7FnrREpA7qgm6NvUERlUYJe5e
	3282qg5V8Fc+i23iMqf+dzEQdH3pK+fQ=
X-Gm-Gg: AYBFou3fDd+RDCIZhwSrwnOZoaeOjhSlMinqRr+eYw4fuOMuhrWJuYPavCJkBxeF+iL
	4VL5YHe/5tE/+/2rqypCZBPkzN55Iouz4vGHyNkqooDbzAwAKRHn7yYC2FFzZx27cjVtyoMfheM
	JFLBA8Pi/SwJdwP2xile7mybrDTLUkGskuUG7sRKdMY7B6HxFH+95Ri2E3DVF9BsKGoQfn44Ezu
	xY/JdTeLgQYROoWuwacJFfVEmPKA7wJ8vdscs1twwC8UDRz0GR71pw3T4ULjStn/lUZwZiU3vaV
	TJ2mlMPHF2PnXD616mecD5zHchvoi0bjsHYP3fmy9Jm1+wX2foMCVYQkihLMIABmQNa6ihwwJPv
	qztfluHyKfeineQbbMMUgQF0ib/ydrSKx4wDHHA71itkB3Jyso6agJcv1g4nMgFpYWlIEuNxjPt
	4BkfsRY1DND8FcLWrK5Bm4h1f2
X-Received: by 2002:a05:6512:304f:b0:5bf:cfcc:5444 with SMTP id
 2adb3069b0e04-5bfd94cc790mr5017117e87.0.1793750715095; Tue, 03 Nov 2026
 16:05:15 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102204151.MA00I%taahol@utu.fi> <aumQMJLMeI4sfeNI@pks.im>
In-Reply-To: <aumQMJLMeI4sfeNI@pks.im>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 3 Nov 2026 16:05:03 -0800
X-Gm-Features: AclHuK8FKWGocPZP0TsV4Cl6QS9pwUqWrHWj3ng1NgFLZe3l8OEejM_Kb3q1JWM
Message-ID: <CAPUEspg_9CGMtakHO3Stj--exd5nRNv7i3vW5tmMF0Arzmo=zQ@mail.gmail.com>
Subject: Re: Is anybody using .cirrus.yml?
To: Patrick Steinhardt <ps@pks.im>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org, Ed Maste <emaste@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:41=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Anyway, if nobody runs it anymore we should remove it. But let's wait a
> few days for Carlo to answer in case he still does have a usecase for
> it before we send a patch to drop it.

Thanks, but there is no reason to keep that file around AFAIK.

Carlo
