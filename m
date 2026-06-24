Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51239C64E
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303890; cv=pass; b=Phts6zTiQvFIc7YDPDVay4h5FvmfjoZTH33YzMQEsrhDbcn8mR5PIsTJnWlA3tycTHQZmwYaZRelLmKYbJZXNH+twUWD2ZT2CQ6/I/R8bEKOZ7Q3YRVe/0Fi7ySVE0WqqvVE41t3Ei9FpJGG4WrNDE+exR1UehBLlIv2MJwwK2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303890; c=relaxed/simple;
	bh=zGwg1P/oefYP9BaNjQvlPCdYDMaaqAo9gcRrzJpAc/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWDFB0bffdJ/t+AeFV4Ws3QO7OBwOI0j6bYvGytZvxocH1YlLc3XL5EjgiqaMNfjErjPWooEOco1yZLMNhubSaBhxGXQbalpqBOvKyETTuxHlrNPxZP9p9X5lGp0kzfUn9MFtDwZNTZQNeiYGiyGpPl8jS+nX+3437LTPt9ZMFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAeIzdM3; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAeIzdM3"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-662bcc30fafso930501d50.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782303888; cv=none;
        d=google.com; s=arc-20240605;
        b=WtRomC/uQsyxYG0L3tYTiIfngkDZh+R4L71mu11+vYvuTnIUOM+rMdmYdNP23qCjxw
         4I62XJiLb+cfUaCDbrEBB9GouuaTh+R8l1/YhyVI4yc4Axi/bzXxI9zgUo88WsbEHn6J
         YUnfDCrRt0itofV9HTrGZB5X1HgKcXUUTI4fwHYod/ckw/aMEuLk4nV8gAQ832harmmh
         NlNGnvqPEgDSYpiVCxrTeckQRxdVdb8z/VxBY4Vsg7HRtQ0LJaXD275jBL1uUjaa0CFY
         l0VyAai1p1531fhN20S8LfDIX7GoHjA4uzIzRXrz8wB4vcI31Q6qPbDtl5eZ6N+BWfLc
         HTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8qUeIQc4XmY+WJC14Mvz1sIr1pM4EtlVg+Nc8mOlNI8=;
        fh=CQ7AtC7rb1PIz4JYRz0jOzaYm76fSIws1AGYwKaorEY=;
        b=Ikl/emAdaancKLUUlloqsvtnHqe1G6+umg15Vl13B9VjL9Unn1JkqpF1EPRV6BXcJe
         m0cLKm1CW8zj5Bz7z8CwZWcbco+MsixdSQgWqfzNGRODKspxWyMuEQAXvT78DKfxSu2U
         k9bRergVxj/Plo3j0uuoUJbMpKnWgBExvjF4Y72NdHZMZEo2/e5gKxNYA49mwJzumwpa
         7cJRYDYn01A0hpLebZaWh4h1znInzFNwWtrMGrZM/48YTOL94WNcMcG0PDppXpWTdpPu
         iZlj2KWfFrMiQALzLD88FkxRpliSMq393YpTEYw4jf88K+0YHfKLSnR2p1jYsN6I7GoG
         cYPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303888; x=1782908688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qUeIQc4XmY+WJC14Mvz1sIr1pM4EtlVg+Nc8mOlNI8=;
        b=aAeIzdM3S10DDoRK1+qCAouzB0rMURUpRIcTLfBnuvlkz454DEbj4eKieDEA8gm3Ij
         pHVAQmZTJZQoTKFdnrURPf4n4lgd0biEh6CVQKq4P10sVfqjA5bL5xC2jxwHELsw1esB
         567c/Cu53Mc/3eLAiI8be3UKstmmHmpjbQKhQxO5d9isy3xtXIJFn8tViK+hmfUlUmr9
         JKPjwa0z2LXXkLwaz90jYpbHjkp+tYCHo/S33L3hLhBr6E5GfANFQbpjiriu8t4aosPF
         P3tT28Qg1GwaLtBYzkUsxaEDyaHGHGkaaFxqkT18m+dOTIMFeqHzwmiH43qoCRYZsBNg
         0qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303888; x=1782908688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8qUeIQc4XmY+WJC14Mvz1sIr1pM4EtlVg+Nc8mOlNI8=;
        b=ai4J34kuaaodGTKgDp57Hi70sU8vbObBcImAPYXdoIAEjRI4zBWRw/0djDdC4gWPjy
         gi2XYYpAVnsx9cUCQLqRv2/+ctDw6JVpYDwz3Ml6JfY1pOwgJfzQ2jCWJWlNf48UFG8/
         IuFTqVcQCvLtOIe23k5pZK5c0ocC11LEZbFJNxFN9MCtfV5MPaK8iPMiZ0GIEs9J8xx+
         3v1ngfGK7xzMD8pTk4KntgEHbwiEWrVO2F3Nu2z8JE69MzES2bFcpd8tRYzA5DLeeax4
         GQt9uoOINBq8R0Pz+7Tp13JrBq521YAi9dTG+GHVLA5wAlLtWWTuN+tywG/dSA+U3khY
         65Gw==
X-Forwarded-Encrypted: i=1; AHgh+RpEV/hC5EyjbqhBjwOtO4LJFWs8oVw0qBmDFdlwJAYylk0yKJSF+1r8DU+e7Gv58xnEHuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvsG8MJdVJc1gHANGKHfqzkeIk6Wj0nfmt6WkP+VWKBmtmPMv
	3btdYsGCKqiqTaICYILybDvV4D+soRQG7YYQd/sVyIqEMo4NElWotCTacIzG7NvioLUTAr6r/M3
	tFi5m9H6e8e5h6/xHNKRe2SYHuDJmQTY=
X-Gm-Gg: AfdE7cl/kE6yyCE3pL388AmcMrXjRDv9se/lIdx9A8o1Z+WfqZN3Yypspb+KvylB9kX
	VY4FzVqQO9m/ohfvIK/yojuvccOKZCljM7VtSEHjNftgV1/w8ExqogY0Jr8e1ZNOdPCfypYabUr
	ogsH5r5iMymduBhkS14f2PM2Q7pR8X5Hic3Fdi15CUb138HbtXALMX3m//chifPo/ORFNwNGyUt
	9dlEtNhRI74pBSajyNrx7sTK4Dw/WEvbxIn8r/aqsdAPmGwVAXq2xjOpCdTtQvA+zEyxzdp5+TH
	/6VxeJwUiwN7K8bJYsWvsKkQk4Lln8ubIzR4/AX1KUsmT0t7iMOT4uDTRKzS4N6ESQB9E96Zpv8
	irgrU+WaAB8EVnsPgvQSlVcAVXnGIEpUunuEnzcMm/7fWnkQdVWaQ0+WcTmKnFhtph4BaN8Q=
X-Received: by 2002:a05:690e:438b:b0:660:6f06:ae8d with SMTP id
 956f58d0204a3-6636e556b95mr2014171d50.64.1782303888396; Wed, 24 Jun 2026
 05:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260619-ps-eric-work-rebase-v13-5-3d4c7315d2f8@gmail.com> <CA+J6zkQEqTeNWkHJWDD6MmK4hesKofBVobDt9OcQ-FSVLC28pw@mail.gmail.com>
In-Reply-To: <CA+J6zkQEqTeNWkHJWDD6MmK4hesKofBVobDt9OcQ-FSVLC28pw@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 24 Jun 2026 14:24:37 +0200
X-Gm-Features: AVVi8CeK2VtCsq4JGMUqIpJ3TmdtNSsPAk-YO8OK610_fgElO7MVgXLRbwpMMlg
Message-ID: <CAN5EUNRO-HaXwq+XLTvR_DzumGws1Rv4yej9GngQDLQ36XyZ2g@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 05/12] fetch-pack: move function to connect.c
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 21 jun 2026 a las 7:38, Chandra Pratap
(<chandrapratap3519@gmail.com>) escribi=C3=B3:
>
> On Fri, 19 Jun 2026 at 20:26, Pablo Sabater <pabloosabaterr@gmail.com> wr=
ote:
> >
> > write_fetch_command_and_capabilities will be refactored in a subsequent
>
> Nit: the rest of this patch's body referes to this function as:
> `write_fetch_command_and_capabilities()`
>
> Let's use that here as well.

I'll do that, thanks.

>
> > commit where it will become a more general-purpose function, making it
> > more accessible to additional commands in the future.
> >
> > To move `write_fetch_command_and_capabilities()` to `connect.c`, we nee=
d
> > to adjust how `advertise_sid` is managed. Previously in `fetch_pack.c`,
> > `advertise_sid` was a static variable, modified using
> > `repo_config_get_bool()`.
> >
> > In `connect.c`, we now initialize `advertise_sid` at the begining by
> > directly using `repo_config_get_bool()`. This change is safe because:
> >
> > In the original `fetch-pack.c` code, there are only two places that wri=
te
> > `advertise_sid`:
> >
> > 1. In function `do_fetch_pack()`:
> >         if (!sever_supports("session_id"))
>
> s/sever/server

True, thanks.

>
> >                advertise_sid =3D 0;
> > 2. In function `fetch_pack_config()`:
> >         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
> >
> > About 1, since `do_fetch_pack()` is only relevant for protocol v1, this
> > assignment can be ignored, as `write_fetch_command_and_capabilities()`
> > is only used in v2.
> >
> > About 2, `repo_config_get_bool()` is from `config.h` and it's an out-of=
-box
> > dependency of `connect.c`, so we can reuse it directly.
> >
> > Move `write_fetch_command_and_capabilities()` to `connect.c`
>
> Nit: this is a better patch header than "move function to connect.c",
> since it better describes the exact change we intend to make.
>
> Let's use it instead.

Okay, I'll use it.

Thanks for the review,
Pablo
