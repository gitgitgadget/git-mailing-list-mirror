Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0946C4C5
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089925; cv=pass; b=Uemw6rgefTCkCbrLuLgb1AgVtPjGgvQgHHlTxXFRHCFVwPe/utgjMJo8vqxEVBcPRhEC/WAiliT+FRkKUNRGQGWHCF/V+Uk2rBRMhdjgdt+I2FoK/ceUDMULBC6ulYZG/i7d1lby3EksP9Nmx5jRSvdfECv2CIm/14tm5d5smms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089925; c=relaxed/simple;
	bh=Hi1361V3xSYMHzkGwdNjYqVST/t0ZYb18/KLwpADpGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mW8jifQhe97XH2tLNSe02J6Muc0cf0W9GHosiz7MZAMEXnyD4iB57eAX/FzRmpljbMgrXh3iDHhr0+ggSte+gDNTzYtXJbRxqg1CnqrGB+9hZL/cS5pejLRaWgPDC4FVIPehlSHUqT7uE2GjMoTfk4h15T4GZn4UehkAItmpZvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1zKi9op; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1zKi9op"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b159850b16so2992503e87.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 01:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786089921; cv=none;
        d=google.com; s=arc-20260327;
        b=GeYu7ZYlO+FbPEnh3ZQR8JRbGP2/1eWMpTPk2GlmeHxZB64rJ4ebIHFXq6vdXFLWxA
         FxVSHSLuFuNXtlg/ORE1o7+zyHNz+fghPY8wAz9FKlWeSkFTeRahlsuWgzDB9r48vuxy
         7Z7UNDk4o33WbG2niXg6eJJS/StXxzts1f0oBdDsm8Xei3unZl9kFXaIOKLRqEtyawg+
         55Z4SnqynDBe7yC/GaP8xoPrhM1kdV82yRV2rlxc5aI+lpy/cuGrkDdCA6hA9J7vQLBD
         r0TtEFtSpv6Nk2MEUJGovNWA40k8azE+B7gBEEkh89icSRApAmVdZBuIN6YAxX2ZnnyA
         gOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hi1361V3xSYMHzkGwdNjYqVST/t0ZYb18/KLwpADpGQ=;
        fh=+rxVMgasjTcw63aikTTVOCzA993n6RNNUEErhksVvWI=;
        b=E1cfUK+qY2wYguY/jxRPyoXk4SM1Fh2acHkK0VWYD9kkF8g6TgZM5OZUhhmvI/FoNH
         A3+vKAOiutp8gLQjn6/101g1ARlVtfinogUv16vL51TFMHntygpXSbXDM9irLrK8N0k1
         KrjHeH27AFrFNtZ6FcShQLDLWZoHcN2qpYb7SjGMSWEsijdbazL0poNzuCZYEE5Gvqq3
         5EuD4UKmxg91BfKLXHqmATgWP1uwBDhQfl425zRTxUk54YmTfAna+t6pKmbqo6k8VUSu
         Pucxj13QQFkB52dZUVWv3nvnyEnWzJNq3GHj66bZZuaKxH9VeXckUva5Ddj6URX+K8ed
         HnMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786089921; x=1786694721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hi1361V3xSYMHzkGwdNjYqVST/t0ZYb18/KLwpADpGQ=;
        b=L1zKi9opewaS1ELFgMRMEV0bWHSSSUaUyauDZRfEIhSmitA6rnOpr41VCyrMJb0PGX
         21PvvuD/i3/NSWws6SH2bdwEG3n0WG44S1qfl3n93BhUpn+2lKh3mLxsbCIOyOSD+NP8
         MYlpmwn9LpCHHjCNvkhIv5j+Qg8BvVeM8iDmMsaK5oLqUiLui6Q12W07n0cjPmrcSJ6P
         hel0goAoH8YX4iUT8OpPAwJKyKkTg7NNeE+CDD408tgCfQk6nHm96bqWRLqJsf2vedUm
         JLvcAAI8aXlbSVezD9tyiik23lzhmfos6zjngFlIlh+ihltN20WpSNb/uKLK2+OuzPqy
         sQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786089921; x=1786694721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hi1361V3xSYMHzkGwdNjYqVST/t0ZYb18/KLwpADpGQ=;
        b=ptmum6pVP0ovFSFrNa1W7+A/B4/mDx/bQl1eCGRIgNW3mhoJnFVoPDIFd1Vs71U959
         hjzajdNny9aFPVxJo38Y1WQJY4XgaxqOl+j4vYZHAK1VF47YaQW1E+CTHj7/5lZem+bX
         gNzNicy+hWWgwbyUe0+4Siee/LCSZs7XgxAfrSYk0Z2AFy65c3mX7Pktrqhl7eYHLWvJ
         k7ubH4+bE1B4deKEe4pQT+BpFkTbRFawaVZEOyq/HQiGuRAxYwED5MoE4klEFIGPbI1v
         ZMIjAYfcqwpC2UfGrExunwGPgSLH5Jy6nkDu+P7JsAlFB3w5bhYpp9VKX9YtueOS5y8+
         egUw==
X-Gm-Message-State: AOJu0YyAkSFjuxsHmWsT+q1ruB0BW0XWShQuZJvegVRFbueP5TwwIp77
	Gaogk6845YCe12vmKGwGCq9Te4ZvzxBK45GK37u/zsorfdEHpeMHODw8/wLHt+CWQCX5QFEyjFy
	dJc+7o4pFONkE7w4nvOAEzWeEsHxM3K0=
X-Gm-Gg: AR+sD11LpnT+QLPQG5spzKsa/n/mu4ciT31QvezBlRb5zEjxpgGQlOA9bnVfYW4tHQ4
	So0dL+S0vGU49gnp1rqHNz3rSBpSl9Y5S2Kzv8O8O9V5uz1DCfpd6xcQPty8jiFfsJQV3h/fToE
	4WgRl5CdsTNHWbOZzTxZpDO+XfILfFjLGeZBR0+Ktce3JZecxw5pLAgzQa9JM1M95lrF0nD0EwU
	A4XwDY4vt3704nM2w+UFsQoyjw56MNn+LKjVveYqHaeApqY5Dzv4U054So5VJc7fosy0pxx9qrT
	LcXAUq/JEiY+60qwwBtc7u53hX/Uor6FaUz0AZQBy+zKzgyDHgwKum25Ezy/4lmQmnyMIU4lERI
	xqcg=
X-Received: by 2002:a05:6512:668e:20b0:5b0:113d:8ad9 with SMTP id
 2adb3069b0e04-5b2f4b8816fmr1803332e87.12.1786089920618; Fri, 07 Aug 2026
 01:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802212826.1090943-1-sahityajb@gmail.com> <CABPp-BGYuQA_ngR3xS-_Mndzf_ubkn7rSc25CJG=UbLCVGdnyg@mail.gmail.com>
In-Reply-To: <CABPp-BGYuQA_ngR3xS-_Mndzf_ubkn7rSc25CJG=UbLCVGdnyg@mail.gmail.com>
From: Sahitya Chandra <sahityajb@gmail.com>
Date: Fri, 7 Aug 2026 13:35:08 +0530
X-Gm-Features: AUfX_myKCBoulwss8IsdpbTgMT2DnXJCAK8BPrNsNUJ7NEK7-lciYOPleTmkJUA
Message-ID: <CAP=WS+sp74WQ=xndQ+2a6W-qP3Zz8=bVnEymgVpS+gwMv1Dh7g@mail.gmail.com>
Subject: Re: [PATCH] read-cache: avoid sparse-index expansion for unborn HEAD
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:17=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> This explains what, but not why. It feels like a pedagogical exercise
> with no actual utility.

You are right, I found this through the TODO comment and do not have a
concrete user bug report or use case driving it.

> Why would someone with an unborn HEAD be using a sparse index? [...]

I do not have a good answer to that. My thinking was simply that
removing the special-case fallback still has some value: it deletes a
long-standing TODO, unifies the unborn-branch path with the normal diff
path, and removes an ensure_full_index() call that future readers would
need to reason about.

> This seems to presume a single dirty file, otherwise wouldn't the
> printing look pretty odd?

I agree that "dirty=3D%s" looks wrong when multiple paths are
present. I can fix that in v2.

Thanks for the review.
