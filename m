Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0053F23B5
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084853; cv=pass; b=YS/1z1uZVXKgWJtdlCESlbTvlUyMxrvXB6HswMnHbJHxjOLJO6hCGFUFFrxGSSqcxX/1Wl3rIzQuqLK6MoE/ZyvkE1m0cCTvuVZ03R8XpUaWya7DpUXu/AwMuVmZtQu45SJyxi+2TJTXWVTXeuenZhkIJsZSemaXvtaoH9kwUEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084853; c=relaxed/simple;
	bh=xCUT9HQ2nQUsNZ747qW2Zqnxq0STe4qveyvTQPsCm2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxUP3iodxJ+byRn0stxdDmmiYioL4Cn1+20iwzL15uWtUdncbXME3GM66EXfxAZ6TIHMJfdr7HUQHLn+U5pswDebFU6VKHH+c7xKeu0GyGsf6OozSg2wqj3snKrN7m1X6Oc1qFjFUIdzXCIiaVWds/2cPsxx6jUcpdVNrRKy03M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRDeWThV; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRDeWThV"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0d5ddafbcso10202637b3.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792084844; cv=none;
        d=google.com; s=arc-20260327;
        b=SyNvO16vB6PrXraqVtNbzeVQFirZNzvj1lDe8N+L9GRMls7/smG7aj4Pw75eTNe4cn
         L2GEHS/N7F3nLefxX0Hhw1eLAIUnkhc8hEy1UofvEkdKmXV7S4qR82H+q2A7p6dbCsvi
         3K1cHTdDNDYF4QQ4XhW3P8/QSOiWocdUNR3vGhVR/Ast3mvUw4n2bydZhYQ+yF7bc+xv
         1mrjBLqJr0KkonnFp4TAxN0aj8WRB6WK6xvFfvw17amMj9AsaGFH0mZQcEZRuhBw7RVf
         FzlYjs5tm95sCaPXWW21gdl4CThOKOCa0iDr01UsJuWM+RHT3u+LPBNOOs1ftDOMjq6Z
         Q2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xCUT9HQ2nQUsNZ747qW2Zqnxq0STe4qveyvTQPsCm2c=;
        fh=tpUv1HxYA4iBm8ZKNZo9eBqTRfGRFlF4jy+RGNOkz9k=;
        b=gxSRUuh19IkVygxdH9k1EOE24Ok1MrEPXDmwioxOMz9btqrV3EtwmQsUyjhjO8PA0s
         tQPnhkzyVbd2BTcVU9HzSqaXtShbC7sHCqrtCIzoIlHVMw+4Zph8oueWQUTFqzlYfCma
         jGe3kfpS3N9XS0y50z7IqaPcdEWI7y5P9Ji5JLe7sJ1DX/IlYRA+CRjebaz69noHLVok
         R85aGDwNQTpJCsvwrAO3caXzkR4ONLbyAX6mfgPEfaTHBYXjBoCQorz95inxmNI/rF7l
         LLJRZPwmSWZmTJHBIXdFaE/CC8qul0RDAHtSlRkFaAAXHWbcbhGbBTjyMp9zfN4VbUK8
         2Lyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084844; x=1792689644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xCUT9HQ2nQUsNZ747qW2Zqnxq0STe4qveyvTQPsCm2c=;
        b=NRDeWThVL/KtlHaMRb81eX2FfQv2r43XuabqLPKjTaLCbaM0NJv8uvFwCdEZyBTcMq
         Ij0+bsxTJvUobPgEaKk6YMWlIrUxR2HjyqrKrPI1byd/+MQbKfU2YRvgsEPf1UBTWhLD
         YZjQRhdlcOF7jhON3x5evRfoIDKVdIQiO6LVOLK1c2OJz/fQQQ55bz11r1FU7n01XAuC
         bpyYZEvdKvVqLiTRiYhUKQLiYtfsjNv99Kd/v+DnQc9t1hZzPMjpcx4RcKU+QdEl8Z7O
         DV+z96K8H12TqZt+T/sgncwj2ImjtDByhEUC5JmISoGernNR+z0niWllagk4RVJhOvQC
         bxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084844; x=1792689644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCUT9HQ2nQUsNZ747qW2Zqnxq0STe4qveyvTQPsCm2c=;
        b=gYLUaH1SHlPcI+6yc2RrMJb5tnSpiG9JQE9QH3PwyiG63upJJkExvEucqu4fn/JkLP
         DwR+8uTpA296IX95vPMqmM4tI7108/FPREnyZU9+4ioS5lIH4kjD0EyP6jnVQeC+45Yz
         +n/GKdZitnqfDZYFcUSobBpEQ1gyR67FYofniGCqbM5k0bRfTtOedhfkY8Sq9liqwLFW
         pfBVnxYzj4VTE7tVECbmlobto+JdW9DuaVWilw9sfkJ7mMc8VNLTIjSb0E7SHL7FjjG8
         6BftwX/fKBpRYnRz6+8XkZjdurnk8V7Dii6THFfcs6NJa0h9qViG5eCOzGV/or12FyfT
         r+PQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9ppHWJw+HZNqp541obe/3UtzV/XKJw2lwYdv+MEzsuR0XjEKQDshJTwKYo+jy9f9y9g0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo3phAHZbQ855W3RQ+dBm3nz3iLxciiUhoi63VbK4HSmurNqw2
	VYh2UK2jUHXhtDbNaCxp97Z1lfgCdinHfbaKx/YYeSCY6u6ErHpuerN4Vu+mR53qoRKDMV3QiXT
	BDsHJkVghMsRs0dzGL8kOL2RIQcJA1QA=
X-Gm-Gg: AYBFou3zd92LaJeRKXBMmPKNG+UrWhCqz2jRUv4HVvgkPpREz1b/KI4L+N/dprk2sUC
	ZFAq1izO3TJ3aaNh6xtARWjmJm0WBSipJzYyk7wcXVLEZEhAYZUdZqU3yGbOF5bxDW2iiR6FAyS
	0Af9trR4WVahjJ7v6xWYTXHYN40Zt8fpBLLYyqK1PN3Upy2cigY5LzCZgwUMvfQbqRzW/uZ+UsV
	3XBDAYVFyAdk6UJCLIRZQ50AuA7GTtTZwaRRC3QCAa1KC1dc17OeWWjnF8pjEO62jJn77zXUgdm
	/2U/gC4wpyNsiqPUPv+7jd9QskjGYn9Gmf9EUyjLKzYA9k1C5lwy21UoGH7maJPGWx1ArHSmgvq
	sydR4iEVkMQ58/xcYLaIpfFB9xJmgUqJpQXkssiXoi2EAPD5nOIMebF2X0idUS+nyOJ5NnN71uh
	TnZoiO0CUeHG56IbebXH86uzyvFxHkuQpTr1Rh4hQIUdUnCmAbc3iNVA==
X-Received: by 2002:a05:690c:9990:b0:8b0:c9bb:1c86 with SMTP id
 00721157ae682-8b0c9bb2328mr19234887b3.20.1792084844067; Thu, 15 Oct 2026
 10:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015142532.48175-1-okhuomonajayi54@gmail.com> <CAPSxiM_2Dd86rBKPj7jaT8Wmazo3PFZajJaaL2bVhB1GFsfnbg@mail.gmail.com>
In-Reply-To: <CAPSxiM_2Dd86rBKPj7jaT8Wmazo3PFZajJaaL2bVhB1GFsfnbg@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 15 Oct 2026 18:20:31 +0100
X-Gm-Features: AclHuK9N7qkawdxlwa8FR0sWN3CpwW4tFJzMojiAbSjRIt6eeP2Lti7Yts_WtcM
Message-ID: <CAFpMFfAZoUgRUqc4xmiqUpPq9pKCe_MtBoPPxkxGO3t=Ux-7Vg@mail.gmail.com>
Subject: Re: [Outreachy PATCH] merge: stop using the_repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 5:59=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> looks good to me.

Thank you
