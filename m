Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C0175A73
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265193; cv=pass; b=Erurx6whwpWuBDOClIZlezdQdHAQGFiCZ8H+yEowH0gAEa1+ygKE/D4QaKVgD2sDOjFb/RiDnEK98T3NpFTqqW09PJRsxWDa0qyvzJNZH6ujOdq8SSNF12EgE3Ol2Y4z2ixzEqNVMNekO/bEELTI9fCOiZ9YXH9YPHNmV0l+QAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265193; c=relaxed/simple;
	bh=1cgIMThyIxyhXUyHq9j2ZoQjLOMl1t4czbR9lhd25G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+0BrlG16U6rnGAM1KCObE4S3dT+ZexUfz8eekTAY5l1T6psKAbE/1iOEjC16G1hKZlWv/3ed89K9ROU4yEv1jKmzT1tV45smBULs8M2Yug+zJM+xwP4YrWByi69SrqTFbMIY0lm1oPNWh/X7d5g6e3JDQxJqdHpBrz1fPHRdi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2be21f91e58so33172eec.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773265191; cv=none;
        d=google.com; s=arc-20240605;
        b=dRg3xKNpFUy5eSEBqrUF0PFl1rVwO5g8gwdP6X1Tg8QIox4C13M/uD5JCHwFH0oOmF
         DIw5KlOhl6kPK4KJHH0bGX+qRfhTdhcPX9eKicrzwTHjKwNLbQV6Sy7JO6nUMcWMD21Z
         K/+hKcieFOwY0OP8Rgzo/epTcCtCwMhFbv+CXhnkLfNq/sKdC8bgb5eZSxx0BTW8qW41
         hgScZeG1bq4B7hh8kiYUAkfsVKQJvA9whY3w5dyDpcOnKO7mLDKQZ/uq0gJa01Cij5Wg
         OrQ4rj/AjVYGblU6KoCoIVPQfbC0JLcc7cF099fqW9TadNrG98y3bwjsnvIgeW+R/5mC
         +X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=AS9UGAuvcOpQEJGnbaHnaNblY5jVRxpLBoQ9mfoK8kY=;
        fh=cZGfdAa+fUfVSWXMMROuWZt/DUE0/sAaE6tr9ffjYzU=;
        b=N1m6aLAiV6JDFbHcLSCTp1lNC47Yw1tePcFTt9vgeufJGg3QMDY3Aad3gRVmIedquW
         9FxGW3rfnzFyuByVcY417U4kYfXaECCgstmyAXmc8WaJ/iKgH6+Bfwq8Q4H362LRGALq
         4RNQbN+blZECY/CHghPc9AoPWMR8g13O93y2CMeO1ai829tuJuu1Wtjp72F2fnJnzLhz
         e/NtUlFdv4TOquIKw4kDD9yfajz1V2nnOyKQ90B9nctmQ9bRorsEkZVr/xjr+kZ55Spp
         o5rlTRkz/OT8VtwmIVckFvzaJXq5/3A0g0jBca2XpDLIbnw+356i+mmN1W0wcZHYPMEk
         Sbtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773265191; x=1773869991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AS9UGAuvcOpQEJGnbaHnaNblY5jVRxpLBoQ9mfoK8kY=;
        b=vKAqQ2BksMKqK0cWRGY07q9omsTHM21DrO6xoDRsfHDqCNiLDyB2rADtT9fP+hcFi2
         yziEot0Qhepwppn6jJJlQ2OUFPUkvJQ3n7MHRcbsito3uIDGQW+bOBPU/FJylHihQWeZ
         2WUF1jNNMpHvvIUMzKm1TNWWODY1ldeLYo2bHMQRkjtmuIj0l3ZGfoWD5bsjWnKMQB0A
         YZFyejIlYk5y5+iK97Q35/wnO3+Uf+u2rfvw+x1mRjMsfvXdSQLV3uAWu9YykNluvsKU
         2V5l5xv2K6NY8RIvLsg369gq7qCm91LJlOSfdSe8PclczhfvwJHCZV1wZURBpauGmxp1
         gaiw==
X-Forwarded-Encrypted: i=1; AJvYcCW09irqdfjIeuMUUNeWhQJsCkSHVGh6jJjgjOxwU9tP2boKbbHLTcFRefkcI2bJlTt4x8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1XxMbw1zGCw/cPJRVV9HyrySGKmGVDJm/lxxoN8lrAqB9PyY
	zhWIC4AizpnSFVZ6ewLBusc8fB4wV5zE1VpAASG8jOxSoIIkhqH+Z9/5VoQOM+1A7CN02tzzStm
	Ear8749W9225IIXbq3F0mRCykkTC45Pw=
X-Gm-Gg: ATEYQzy6Sv2rUNGKi3o5DxgIWoohsMdkUfpoEuU/s6cNJxVmza293nTjPCsCdEQdPA5
	2z2bqWxYeFOj6ZGpNpB/LTYQ6rtIE66RyBiU/p86PVbgIli2aiT7vbib5N+KqyUNMddu5ODlOEo
	zQFLlh9ObakIIptxgIZ+O2KkpobhcAEX0bCp91gls2w+qheOZhpzTXvRHvbO2rTFHN98j+uUWq/
	jxTZS6vNcTN3IA/mIRsUaMvG3J5f7DNkiumRe2Dac9/LaRtBYhbNPhGihTBkXUObzETqSplYUb7
	sD7mZ09WqeK2H2TUNHDbi5A/secdllPWNBfK+QpC+kzoZDLRf6s=
X-Received: by 2002:a05:7300:e52f:b0:2be:9886:d4ff with SMTP id
 5a478bee46e88-2be9886db74mr4880eec.2.1773265191429; Wed, 11 Mar 2026 14:39:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212041017.91370-1-amishhhaaaa@gmail.com> <20260228104654.80831-1-amishhhaaaa@gmail.com>
 <20260228104654.80831-2-amishhhaaaa@gmail.com> <xmqqwlzu43rh.fsf@gitster.g>
 <CAPvEtrf7gqyQYMcsii===kXY5Vut0EC_VsJ=xWUKNrq6YmA=nA@mail.gmail.com> <xmqqfr66m5qj.fsf@gitster.g>
In-Reply-To: <xmqqfr66m5qj.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 11 Mar 2026 17:39:39 -0400
X-Gm-Features: AaiRm51cs_wVDrNeEeVUuuHoR42-IuFVGa6jpL89fa-7yiB0P5U3JFQGdEMcv_I
Message-ID: <CAPig+cQ+HLjBjtGA9s_ZYYWNjRj_Bax5CkJFa98a-z=LoyEFoQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] help: cleanup the contruction of keys_uniq
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Amisha Chhajed <amishhhaaaa@gmail.com>, git@vger.kernel.org, avarab@gmail.com, 
	peff@peff.net, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 5:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> For example, in addition to the escape we see in t6030 above, the
> current pattern would not catch use of -E if it is written this way:
>
>         sed "-E" -e "
>                 ...
>         " human |
>         sort -u

Seems unlikely to arise in practice.

> or
>
>         sed \
>                 -E -e "
>                 ...
>         " human |
>         sort -u

For what it's worth, line folding capability was added to
check-non-portable-shell.pl by a0a630192d (t/check-non-portable-shell:
detect "FOO=3Dbar shell_func", 2018-07-13), so it does correctly detect
the errant -E in this example.

> and million other ways to subvert the simple-minded pattern-match
> based check.

True, for sure.
