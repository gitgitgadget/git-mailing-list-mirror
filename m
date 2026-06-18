Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F843EBF37
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795836; cv=pass; b=NgBH/Qtsc+h5HDcnKrb+QXPKUNDBKgtiEphC+9nfbxl2gBxrqaOFcq/O3A5CJVg/N5HyDpIomyR3jtIiZoeu4rsK87UhsinDZHjnTLnDqFFbUjDx6GeYXKYSvcWBsAX0js99ytoJeQ/2ywbF1sh46/f8WuZHyJ1XnRhtYf6PmVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795836; c=relaxed/simple;
	bh=LhKbJarp6XmmizHXIvYjcglNyhHo0MQDqXlLJPXf0/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L4T6UnaUL/cp4svd2YYnVQl/8NOdRcHsPfly+K/XUBDaGMxiPtt1l9pm/itRh8zeBrOZa6IgFKwZ0+/TZJUllZXVlxoS9kHuLaorP540DzRp6/XFkkj2tDkWr5ZcCOxhsniIYN6TCLvugZ6F0jxT86e9EQMWr6Ikl7EQikfOTUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdFG/PfO; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdFG/PfO"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4864abba33fso686651b6e.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 08:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795834; cv=none;
        d=google.com; s=arc-20240605;
        b=BYfRMZ4SbYdtA5/m26FtseTbS2l9qw64F1lMy0oW7fw1gGQARjHLBJH+HOZ9J6UzKv
         Am79LLiJn7mbuTi8iUGBWuioAHHtf94V5UGiVDkG9czd4RwuONbllPz5Mke+g4h9yIpk
         CIhVYbILnWfKk2QIjK6a/uVY9VOekTJ5//I1RzXTrApqkVA3V5Mfa+WXEqNOgXV8QRay
         zCD9Fs1X8l+bNw1tgJ+rAEosl/4cV6lCE4XS2BsqnFr4gfYsLLsisDJJCSgbKuIctdKH
         VLX9wOMWE61UliQbqyW75R7pI3JqFLb4pdhpRDklbyXRfeihUGBP9+NFgD6/nmmWZgNH
         JwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=soVQCM88vlD2cK5dVTZdKIPvJoWBIyNTLuXWDnq8Sz4=;
        fh=DagIQiKK0l3x99wdkx1I/kIIJQrmF83JC+ISm9zvzOI=;
        b=LjRfkv/N+8EHU2+7Xd8u6x/9oZkDE3WRyVTGY98QQIDnJuw4zCVmwV9DMWkd95wIiP
         MIaP9QemLVuMMTgfeR3xB/Kx/H/qZ7vMOjq/pPuLcL9Qhn+0ERvSBA7VuZgMXGLosm1o
         h/rClIbpgyNJvkuLRBeSIGSC31LCaAqyNQqIlLxBVA40+qfBXOCH7k+nF8SWaXwWWkvV
         HbGNsZVN3Ffa2XIeBeDu/nbfjTlz6+3OJ7ydNaFGeAPlRTWL9S5EfOhN5YbgBN82Ge8D
         U1ZG4SW+eKWWk+U9hvEhLf/KcRWUgC41qkrt7MbfoDCQv7hcvzkJTbGOcVNEOj/712DI
         6+Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781795834; x=1782400634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=soVQCM88vlD2cK5dVTZdKIPvJoWBIyNTLuXWDnq8Sz4=;
        b=bdFG/PfOKe4UG/ez7CTwK4hDftGYGYeJC0YFMv5BtKHrlgd1Rsz20x8BZR2SWPYdzy
         zxUizKn8VzPp1Jje0FO5ucOYCeGWsqYx7FbX2IYu/DY0sKVT5TjjbmhtYJYnw72NZFvR
         dYSSRFnEw+Al5dewS7CnUghMkSOEpam8DJWUGqChPq/iyubtYzvgml9/7nvyhVMg0iwL
         A5pqpXyMWxXF+b6XhoZucMedkHzUrT+a5a1AW2PV26xxNUxSxNT9L0Uug7OznUCCjE96
         ZQGNYYuSGOKNRQ6ZsULnw5Tj8VFDTUYF0gGID/Nfapk8jrkqG7pWUy1gpW1F55ZYEO+q
         GNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781795834; x=1782400634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soVQCM88vlD2cK5dVTZdKIPvJoWBIyNTLuXWDnq8Sz4=;
        b=o8G4wGxjfXB12cTcqiaTFB6KtzmqzRW1Tsl4ZkdWtLYY5HwIeJbkJ8d7aQ8oIYYG1j
         An9OU1kyQiF+e5cOV6AsiXWQ2u9OSAHsvq5oOYLLzYS+hJFKB1L8UdP0S3DOqe95Idbl
         ihEGVMXyrqbxd5HUU6QuHRO/sc6LlqrFiMjHxXPAXXJ8ORazSa+JlFT48YSD6yxUoCfI
         vve0q6CF0qnOkUfu1aYuuCpQSyixvJHAjDK4ZaakU6qz2GNfODagTtasLXQTys6iz/rY
         kxWKs/6pucYCD/ijYRdW5+PB2JQ61kpU5lrY598tUe9W+di72owKP6pjz27Cg0+hFI+I
         V1Cg==
X-Gm-Message-State: AOJu0YwdZ9dDOvK6fOqFm8sPRHQ2dLDc6IAdcCU/ocZZIPu0XGgB3m3Q
	NHvlipPEPkcGoBjCzud0268utfIpSbrFNXsunFQNFmKG+7i3uHkKJLd2H7fQUYPO4k0PwPMGroM
	oKmg6PZvulcH9E+5jf77ms8dQl59nkt4=
X-Gm-Gg: Acq92OGc1JRNshTYBZ6PU3fsXeFMH6sVCTLp5snGzvKtzhsx7BStHAAo1bV0ntqLKWa
	34EDgmzvEXsV69rFD8cGlIsPN06IqUyL8yPvu/4GtQIbFoy5W8q8atHcfvJ7Gpgpm47WJSLDNh0
	g9SNJQnXB16DD3TFo1FrxoKyZczWVybA+GspfEWLskgYyj9w/hNfWhszIc9V44ReglDZnujuPYq
	oFo0L8k35ysLUiICy72zGWKMr2cMgbPKBfYo5f090ZFV3+XSMvGxN0jqFrVnNzZc5fHUMUfVXV0
	FYIpWsahnuipamynUdFDF+BsH6lrA1CDGJJgmcrQxrB9kFggZPtSSy45TVezEIs538depN4EuOn
	QaLPwepOP0fzg6A0=
X-Received: by 2002:a05:6808:f90:b0:487:4c0e:20bf with SMTP id
 5614622812f47-489560f2e99mr2808342b6e.11.1781795834531; Thu, 18 Jun 2026
 08:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 18 Jun 2026 08:17:02 -0700
X-Gm-Features: AVVi8CeJdVEHgq5uEfxt07JsNd0IUF-ECSKESJuYj2heC0TF3LeT4WdYKxTg_KU
Message-ID: <CAC2Qwm+DLtWB_2ZpvLmF0AjACVQVeRW1VVPjXXiFcSSMMn4SjA@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: address design critiques
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 8:53=E2=80=AFPM Michael Montalbo <mmontalbo@gmail.c=
om> wrote:
>
> Junio C Hamano wrote:
> > +You would want to be particularly mindful of critiques regarding the
> > +high-level design or viability of your proposal (e.g., questioning
> > +whether the feature is worth implementing, or if the chosen approach
> > +is appropriate).  You want to defend your design decisions on the list
> > +first, because you do not want to spend too much effort in the
> > +implementation if the design is not yet solid.
>
> Two small suggestions: open with a direct imperative and replace
> "effort in the implementation" with "effort on the implementation".
>
>     [B]e particularly mindful of...
>     ... too much effort [on] the implementation...

(resending to fix threading)

Maybe we can even more directly say:

Do not spend too much effort on the implementation if the design is not
yet solid. Be able to defend your design decisions on the list first.
