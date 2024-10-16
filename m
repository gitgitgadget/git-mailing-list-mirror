Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946E206E86
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101504; cv=none; b=N3LHd+7b5s+vn/tWPMjUwBaRZSKYPIb0uRlE+Q5oEVBLIi4HavagfF3oE1YobdIsicf+rexZz8Vj0wuH+D/drxNEEsE9+8yaDx0Hrt8BdGt/ewXHgYrM6m8m1p6CwGYvkD32RvnOOLFZalh4Z/VQIih3BqMIOcBMUavMO+iM77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101504; c=relaxed/simple;
	bh=GCEJ+kPCwHUQJ+rRKN69iyC8+FDvwV01zm3Bg9r116E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEo0eJxm0hjjwUra0QYL6xsP+NXIwNPxWoI7BA8VcUrR0FBE+Xor3Rxp/gHce5KncLSmcSFQKXyTwqRuMtt3YDVZyLezAvj60M87n7j8fpvxXf5R8y6x6uCvk/8b9mXeVAaWypHUHu65HT1AyIQXhadOLz2uZsrKCcq1WtGpSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAc2+9+h; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAc2+9+h"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a482407e84so14640137.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729101502; x=1729706302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eG9mLBg1a+CwWtPvW0vmSFqp/JDXif0hFxJyaVVxj/s=;
        b=bAc2+9+h8LoPQ365mx9EbUwCYgKuSo+6pEwkOnB6l/AE5hnLiCsWe9kKalV8HNYKER
         8gqsLFpOQH9Y7AdDKkgiK5K4+BusxX54tOXsT0k2W0bR4xuMWfjwaHE+ATpurthGTO+s
         JZde5Gb1D3CYW/QDaP2R8XieyRftTFp0pfAMhy1hA8hV5eB/Iy1uw8MGAZgk24bPFbwJ
         7dRAC7QJ7lkSIoS8ff8jXklxmxBj9lADQVnPrt4l8yHFH0L9QQoro6c+6RySXJqtd56v
         1WRNs7W5Xn304tDSuNYtz59leLpebIQGSAgctB/0wKPSkyK8mhPojc1dIMFbbiJXwc03
         KvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101502; x=1729706302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eG9mLBg1a+CwWtPvW0vmSFqp/JDXif0hFxJyaVVxj/s=;
        b=ZSRL+itbdaPv8gRYQDfASSVwRvv0pL02vz6ObncN+x8u86tvSEyXWDbHnh/QgyGBPt
         eqI9ewPWoO4EGe9qpPUDpKZNxy+xXxq4g7p07uNqViPzEzb8p8L8Aq0uCpdwooFWGb6P
         dSagdBnhAwkYzw6r9Nk/ZoU/ZOp6AqA2J/Dzm3YI56mlmbWNye8Fn5MpKgPDwV9lwafQ
         s8m+n0ywlYGrX7hlZhHejZ+Fha8dsDga+IVEOdh80qfHajC3cTeyB3HfNNyBhDS5L1NP
         QYKNEH2+NLdfNVs/5Bsk8sbfZqaKj2ICzCd9tVlfo6ev+UnXGL1jpxSoC72qm5GP7ez7
         KjOw==
X-Forwarded-Encrypted: i=1; AJvYcCVxRv3KeO65XPMS1yUWaqpCiLunl+nSb03dF/ovUwSENRo61G6fMHPp6ZgC2Q6zZCzTqfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEwZIqZ7U/V9f7IHRJPjzWsHLPMil+ZR/wb1ge+f0fdxINVXD
	sjntsCw0bkkr/oqwzvcEANap51FepqnpxkYelwFaoVoiZ84uzhyHnVVDM8Ph9ZSlIzXTY/xxD9T
	dlYFW03/9oQtjXzW+ruDtFZxkfxc=
X-Google-Smtp-Source: AGHT+IFMnyuOB7siSFM27Oh5DfVAWSzkQtQAazHtB98FyBITBvsg5IVbnPvH++SHTx1qoHasBuI+0fS1tvbALr1e4XM=
X-Received: by 2002:a05:6102:160a:b0:4a4:8b30:52f with SMTP id
 ada2fe7eead31-4a5b5939277mr5153196137.5.1729101502029; Wed, 16 Oct 2024
 10:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
 <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com> <CAPSxiM8-C6DAE3nYqMUCs+UgHN1R41grwVE+S-cSi6gZGvCpYw@mail.gmail.com>
 <Zw6WKuhUufWeSipU@nand.local>
In-Reply-To: <Zw6WKuhUufWeSipU@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 16 Oct 2024 17:58:10 +0000
Message-ID: <CAPSxiM_GJTVvm61Y-bzTms_DT_9Xg=L8zDnMtRP5up7DRq=72w@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: Taylor Blau <me@ttaylorr.com>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:19=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, Oct 15, 2024 at 03:17:05PM +0000, Usman Akinyemi wrote:
> > Also, for the daemon.c I am finding
> > it hard to get the exact test file to add the new test.
>
> t5570-git-daemon.sh is the test file I usually think of for adding the
> most direct tests exercising git-daemon.
>
> If you're ever unsure, I find it useful to grep through the filenames of
> scripts in t, like so:
>
>     $ ls t/t????-*.sh | grep daemon
>     t/t5570-git-daemon.sh
>
> Thanks,
> Taylor
Thanks for this, I really appreciate it.
