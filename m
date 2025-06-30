Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6828C2A8
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311627; cv=none; b=Jqo0ef4MFfYbs2/4OIba8gBq7YZj1lnL3mfuteRkuj1j++qOnB23Lw7k58SWlv8V59Bpj0cdZhVo7YrZOXRn+xu3b8GTAMxHQNxnIu/kTofPIvSX/m1Pnsz8ZiiTu75WuwByKEVF2nwSzqLyFQBMMP+nM/fWyGz2rrmSoKaV2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311627; c=relaxed/simple;
	bh=3KDCoEiX/mjq9nhjdDi9fyZQaUbP7ewlZu8I6NptIbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c78huk3s+0MlmijGjlgJE9iURL2s0riSA9YyOX9lpZ7p+hENWfupIK+ePY27WmS1nJd8dz7c5Nmkd6OZ8/IWeUgpcOtv5Sn4fvwMnhVbeZmobFd7ce/+Ra33nqo0/wgM1wtGAumgOi88qJwzSDq1T3BH/6QIuDjGzu9/OIxbra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fb1ded3afeso10910636d6.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 12:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311624; x=1751916424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3Vk5cuZV6IhFOIMSSbGewVqnn41zby22Xboj9redgg=;
        b=TT5kV0BXhjomcp37pxcqYtjHEaRCXz36ej7BQUwSSmA51dTd5xBZKeyxqTEBpnoJ6z
         +4+UQucF0NPeaLCbJ7ZD/78LcX38M4JE11y92x0qdcKnfrUROALSdD04KWQHs2VHGph4
         k3sDhUqzNcuSitKG/lFp4yTsthxI+fQbq9G0uW1o/L5qf7Laghrbi9zds5OMgfeme25P
         gvfdbOiLihkUHY3CWVUXf7bkMIgIQtoZLT0EXDWG5Q81sIN6mt8R49EhbiXDs8lSUIBd
         FXraHOPVMoAAJegrCsFyMKkaPHKk3y1NiwDZOYBtpXH6zCrSo/3BkqVoe92s4a8f8HIb
         cT3w==
X-Gm-Message-State: AOJu0Yw2OOM87F02GUz2jcPYIwdAYGQ8w5mmwtRYnbn76KlRCgxdbksg
	2HYfk6tmaRXQRrJNOJjouM9twTncny02vjlRduSjU7TJId/v8DSkNIuxLT3CS0Zwd3pbXTX5lFx
	7TKI3f351szYd1ZCy/qsiGMGras3CqnnxkKGo
X-Gm-Gg: ASbGncuV9gM/0cm6/MMQizG4fLZeE8I+z+IeeiJZXfW19AX09L8scOGukVBPvcLcQ0r
	meDS95XJF8pZYWwMvyjVFKx8fTrDEh8/HoBWxzh1N5CYusl1VoOMWyqBu0ELmdMQA0lesvdIOPx
	d5kywc/rIw2pGspZd8vlCCeaaoizItBeIbdVcTDiiJcp31beUyTfqGtYpy9zOJymfj2IjevEwOp
	1T9
X-Google-Smtp-Source: AGHT+IEANhfoA9YUJq5xRLCEIAsIwjOIERbIZ/AmUOzIot434WUEkUwyn+/pRHsKnu+2bxa15L/ih878uL1ICdGsK2g=
X-Received: by 2002:ad4:5c8b:0:b0:6fa:be81:e18f with SMTP id
 6a1803df08f44-7010b8acc88mr2020186d6.0.1751311624208; Mon, 30 Jun 2025
 12:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751310455.git.code@khaugsbakk.name> <f8407f331e0e4bf66a7e26b87f9b021ab950a4ad.1751310455.git.code@khaugsbakk.name>
In-Reply-To: <f8407f331e0e4bf66a7e26b87f9b021ab950a4ad.1751310455.git.code@khaugsbakk.name>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 30 Jun 2025 15:26:51 -0400
X-Gm-Features: Ac12FXzxeq3YV57VNWDSnLYWVgC8AMwq__T2vsCRvMeIexXPrU0ESNjkVwbdHLg
Message-ID: <CAPig+cT+2vY5niZCWN_27w3gvSNTAQsBA4=+AyUHKO6iofUD9g@mail.gmail.com>
Subject: Re: [PATCH 3/5] doc: config: document --[no-]value
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 3:13=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
> These options were introduced in a series of commits from
> fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15).[1]
> But they were not documented here.
>
> Document this option and the negated form according to the current
> convention.[2]
>
> =E2=80=A0 1: `--value` is a replacement for the `value-pattern`
>     positional argument
> [2]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

s/=E2=80=A0 1/[1]/

(Not itself worth a reroll.)

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
