Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA86354ADC
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781077; cv=none; b=fQnQFZPFvmdOLc04b30LtfmVGA6bbYR4lIDTrK9uGEPWchkbf6bY6m/nSxKh9Qk6eoKdOVvKsazex6tTlGYkJ7a8GEMfkOAa6k1rFIvpiki+mDMUJkdSy77G5mLHMTQjD2PolQ+IPot7AkqntwxvDoeSolyoe2kWkiiM3+EgmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781077; c=relaxed/simple;
	bh=VYYa7AL8K8hEDhvNfvidsh9U5ytcfW9VC63XlCbh64c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tuanutLRjhn3CIDhqkRf2EwQD2MkgayUwBvpywLmENQ+OUGxfrcJc6wzpjM8x9yBev2fy4yg4xTnQrQmgb0KWzV8J0pRqgo4x7ljW9lNlBBgF14Feq5c6R+M8SQUEotThZHy43KOWLmH0LzmdtqT3QhLPh8udKNH+kgBxWze3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn9CxVA0; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn9CxVA0"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2907948c1d2so29989375ad.3
        for <git@vger.kernel.org>; Sat, 18 Oct 2025 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760781075; x=1761385875; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYYa7AL8K8hEDhvNfvidsh9U5ytcfW9VC63XlCbh64c=;
        b=cn9CxVA0u4IhwA5yX6LiewD7Apd25GJzF+5k8fQDpgEFM3Gz/6cay6wk+b9PBlwBkS
         q3jhHwO7xXl+upNV+avnR24F7yCylDDS6mak4aUHxCRPf6EBzRorJlbbVQeexVq7EGS3
         f9q0XFh2yaZru8WDirhZFlB7hCUH/ia/+FzLgYU+boGcqNIWS7wEL0Yn1ZJ9AXYUt+1g
         SCgQ66ztk54N56CrRjs8jEdyauoAvS9cagMG8ULVoueUdYAVpzGSApTQ/KZ1JBA8d1U0
         U7stwdm+YJYJTooUCzGjZa4cFEVNxEfJuFmNTSG+kwvt+nuAzPfDpssDj8AWOx5uL1GC
         3/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781075; x=1761385875;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYYa7AL8K8hEDhvNfvidsh9U5ytcfW9VC63XlCbh64c=;
        b=FugRYS0tCp1PVrZStGu4AIKqlcqaSMhhU7aM9TUAi6AbWUrWkmGbfnu29c0CtSYjft
         mWNZssBeRuX0PXL+UHC3HvDllT61XhyHJNVAJMgLsrPgOah6yT5/iKSYTd9XeV9v5uqj
         O4rDUbctpZUvI72V1aXeYl7iXfVxfd2d2elS9ahMB+hmI5N2SxH/j95xHXK+IO4hQzA7
         yJ9xr8+vwZfZ6XMRcvO116otCZ3PHtsljL6knBdaHrmxz1fsfE5f/yXR3mLZnVEYdnGu
         /NZWl3/BGJhZTcaEYtiVzXcFKDaAzxmux6Jt3cH4SMcsAKNOaSB+IedymO22HYkCPGgo
         Nhjw==
X-Forwarded-Encrypted: i=1; AJvYcCVgOVxj5uMy+PFRO40p9UFmLl6bWhU9VyZgS9M0f4OsHX620E6067NhbJPj1FA/B9qttfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7rUyJAfzjKKxvPX3RMWCIqfX3tj7Bz6YpNyYDezZSKX3jtMM
	9At8oEZcgCgVDtfCLOxRJOFPJbwp60ES/ClhqcO/22b42VmaxaYg7H6L
X-Gm-Gg: ASbGnct5Sv8+cTMtSUu0WC5u/ViH1uXra2b6sAiH3cncL94te8B+yFMNDXio4eZjAKp
	FTYsuCXbU3y8G4NtqLrMxbO7qItZ7hJD8BucdcmtvdysTYliqu1oafl/5GCy+7UR1XgMd+ctjk7
	fo6ydUGzdmrrtMeHhEWypj9nNorUwpyMn9pOl+9eVLxXyIbGZlWxuvrd/363k6v2rj9z9pyKUMT
	dBtyOdQEgIVbUlCT4zuOq7K/puym1wRpSQsf3HrmTQpQbbD7Ii/73l23kZJUry+bXnruMxU0CaS
	GqwgVSv2JTx2yIYtvGEKS+RSs3JrJqN5Eo/1QNLjDY+ThguC8MLyeCkx2r1fA5RTEUvLmM9pYwg
	vc8O591JG+HCj12sKbIrfos0cuPBRE0Fqgi0pXhuIl7kOPNZU4CGTQM4YES4dFbQPCy2aHyZsjR
	PTzBZZlwvn8bRmjPG5+s08e8k5aLeI5S9Hj3Og
X-Google-Smtp-Source: AGHT+IGKE3v6Q9WuCXXdqSwdHaiOpQtY/yk2HhUc3wgF27NulFycoYqP13biAcXL62phOYjswNfJNg==
X-Received: by 2002:a17:902:e881:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-290cb07d394mr91387895ad.39.1760781075484;
        Sat, 18 Oct 2025 02:51:15 -0700 (PDT)
Received: from smtpclient.apple (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebd068sm21220555ad.12.2025.10.18.02.51.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Oct 2025 02:51:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20251018094722.GC1060824@coredump.intra.peff.net>
Date: Sat, 18 Oct 2025 17:50:56 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE99A260-ECD9-4B39-9E31-B4E842DC7D04@gmail.com>
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
 <xmqqh5vx1p0q.fsf@gitster.g> <6C994C9C-0034-46D0-8112-FF88773B5CF5@gmail.com>
 <20251018094722.GC1060824@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.700.81)

Jeff King <peff@peff.net> writes:
>=20
> On Sat, Oct 18, 2025 at 09:11:34AM +0800, Lidong Yan wrote:
>=20
>>> Test that exercises "git diff -I<regex>" is in line with what the
>>> original b55e6d36eb wanted to address, but given that we saw a
>>> recent regression report like [*], I would have liked to see "git
>>> diff --quiet" in the test as well.
>>=20
>> I will read Peff=E2=80=99s test and see if I should also add some =
similar tests
>=20
> What I was hoping was that we'd apply my patch, as a matter of release
> engineering (backing out the regression-causing bit of b55e6d36eb). =
And
> then you could make more-specific fixes on top (since -I would still
> have potential problems). And then you don't need to add a test for =
the
> regression case, since it's already there.
>=20
> -Peff

Sorry I sent my patch before I noticed this message.

Lidong

