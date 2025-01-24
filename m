Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920823A0
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712593; cv=none; b=prvgqglIr3qaeywMudQL22NOgrNsX5T5GeYFbOaIy2CNYu9v94Req6f7Zamul8IiCd0ccv6ME4nwq8KrOR00lHFzPXuMoma6kdjHkj4mdmdOKBb69kuK6Til87L7MXrLCzODbwNjqFF1CTQqNVPGRTe4vjKoUE5yBdVYv2yeiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712593; c=relaxed/simple;
	bh=Bazpu4LocHP4vDrAAVWsdvoSIaVVGHaKm/8b9YGMdwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pULFfNc5MPNh8zagK0h3axEqIhhDMyt0xl6zfR7Ue+AM29jIgbgZeakZ0a8vjs4KKI3tKaHqB8iolaagKSJ8xwThW6zPlyfzjvnpol5LVAWjphPftmkSjG/hPYUo8dHcuu0eSqQGqgXA86W89nUfUiJIQ2cFSts/BvY06eGpQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHnIkIkq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHnIkIkq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so2887356a12.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 01:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737712590; x=1738317390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bazpu4LocHP4vDrAAVWsdvoSIaVVGHaKm/8b9YGMdwY=;
        b=VHnIkIkqs68lZmllVfxS3wTZY9A4m13AgrrrV1Qoif7Prj0n4Axdqf+zFAEcskUIiJ
         yMuluWSFMKCZopu5DgG0KyiCHjpq82aCOMX1TfUJbkOfZdJLm5PVkHdC3Fq6FfNzzg6c
         db2NN67udkY63cwnFbl5PXi4TAVhgoo1RkkPDSr46aNMzjWY+7Hx8/gl5gytZJTAS6ev
         9zj39RPILlMu/b3Js3j/MXx+7qhsUxc1ViaRwkfvAKHQMeoKkmRc9OIQybb+qVH/FFlp
         Qe4fTxnYlYAKUbLgxCDwIxAy1VhCEJpvxjGk8oc+QW2az41ArUWjVoBsFV3OWVyvcxIw
         Enqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737712590; x=1738317390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bazpu4LocHP4vDrAAVWsdvoSIaVVGHaKm/8b9YGMdwY=;
        b=Mn5z0Avd82hnYKbrwMjYCkHsfR8TKNM1nNruE8PFuUU0WOXxM5IV7uZ6uPGzLEZxhO
         sf26QPChrgsYjtF7lM4WLQTJJ4xco9KLexKZh5OvQ1QPyW4twdggPIL/VZFzT0KyjO9i
         cCT67lmI0CmHwis5NPEhAEbK9fjWH/MzY5Iajazd2/NQ1YPYCXu0V1M0s6kQ4vrW+t7D
         6hoXIKGtq5HMhrH0scqI0/AXDR66jFjKXOrybITFhTpKPZ3eOPB82OooLTQEiywB1Pm7
         wBoC5+5qT0w29Cecwxr1TMXn0HfnQslfT4UvT5H4tol/g6/2vpHsFkdPcB9Tphm4m9NF
         lZkA==
X-Gm-Message-State: AOJu0YwiNCzKXxLFVHLtsMyt/Vejkiy345RI7IUdirsdxQmpCaN92Yww
	9tkudo3qlTfW0qp/JA0LW6jWsaABQMMjltxAy8sSqoiBJYsY7ES53tyqmrtbKJGa0coX3xCkBOq
	OLEMzgfHR8ZZoMZcNArFs8ZvCNDA=
X-Gm-Gg: ASbGncuLmAZ3sOvTKjqd2dqK1FVKd6Av5Pi/h6UO7d5uFbndcnnOhL3qVVrMaDK0fWP
	aMBt2vyi9QutMakitf8IuIBls8CC4DWAa7lWoDm2DZkRo77OWRnX9E8BiuWtVTrFJ
X-Google-Smtp-Source: AGHT+IHImfoIwKXQBagk2WAnYCFW1jTgOY4RFigl3KBNnGh8hEaiXuYcw8Xd7tpJAyutteZ4j0FmnJI4X9vA3eaV85o=
X-Received: by 2002:a05:6402:54e:b0:5db:e7eb:1b4a with SMTP id
 4fb4d7f45d1cf-5dbe7eb1e11mr9377912a12.10.1737712589646; Fri, 24 Jan 2025
 01:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im> <20250110-b4-pks-ci-fixes-v4-3-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-3-6e4613446080@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 Jan 2025 10:56:17 +0100
X-Gm-Features: AWEUYZn0d5bo6xNBxwKjEKxeBCfd8x7z6XE36ZcCImG1S4GACb3uFXL9K_UADEY
Message-ID: <CAP8UFD3cdA9P6-bm6XNFCapsUqEpVQ3Nw-2-5quAQMkT_p0sfQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] github: adapt containerized jobs to be rootless
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 12:34=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> The containerized jobs in GitHub Actions run as root, giving them
> special permissions to for example delete files even when the user
> shouldn't be able to due to file permissions. This limitation keeps us
> from using containerized jobs for most of our Ubuntu-based jobs as it
> causes a number of tests to fail.
>
> Adapt the jobs to create a separate user that executes the test suite.
> This follows similar infrastructure that we already have in GitLab CI.

Nit (not worth a reroll): It might help a bit to say something like:

 "This requires installing the 'sudo' and 'shadow-utils' (for
`useradd`) packages."
