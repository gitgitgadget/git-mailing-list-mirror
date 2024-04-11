Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C91448F3
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829981; cv=none; b=gQXHqAwfJRUsHmVJeUONJZS0vq+uV4B47gG+bMLh6US+xHXl881RrctXwVRG6c6DRvGnSEFzHj/OuKFAzs1TsoCbdT3STYrPFERJm2sm165KPOGxSaa44dZqdkXGHvgb97XXbjXyqss7M0uCXtNGwcE8tf6rPO37sB+otUqotZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829981; c=relaxed/simple;
	bh=CZta4yGvWUrerl2vYe7uiR0ShZ9TvQz9rV/JufnosHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogvd89d4LRCYQBCWPaGVyFh2WYL41iWCt9aeo1SHnKyTjNxgO8MJxlxijnruxmR+RlX+z4X7HyTk10IwCvp6ODkza55ya5Q0sfQ+zEyc1dr+QOYSJ/JQMSYnvyjre90O9Mw7gB18TDjUJjribqdOd6VdtQNPzf/PLj1+spkcipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4dacb2ad01dso1645689e0c.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 03:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712829978; x=1713434778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZta4yGvWUrerl2vYe7uiR0ShZ9TvQz9rV/JufnosHU=;
        b=hHTi/81XwDFZzkkxlAE31sqJDz3IWnBaTYq576T1kzN6VZ42wwk+qYXjuRcdOgR0wz
         IlJuvzNSKx8HIhphqVG9dbbuY0Tx4zcB5ho1O8+iO/8lvZlqNZlGHm1hMNntmu7etjqt
         ec6PI9MPIjnS3hMxsqO6Hso00zJ8zGBpA00/IkqeQdNnEDag4FWu1WFPA6MGZXxnJffY
         mSFxfrRPqNCIbBar00jPILqBPUdR9UZ+rPwp+CaHPIR4JCqRTzpnwooE48vbg1QPibjF
         3omODEPs1EesAoDIKdFn1n65jm0ORkiG9Q/kMzco7A2q5l+WbeafzBZrWwd2mrFEiEoZ
         s6VA==
X-Gm-Message-State: AOJu0Yy5cXiOj9pOsRBd1vzMgW2NIYJICQo/rao8U7oRlCIvG0SSH7gj
	ShevrWexu5XhPMOLuACjQp2GpLa8XdkLkPSJrDW6SUPMZScA9Bb7nmhDjLa7fOcvtPPBRFC3/G0
	TjVBjbj0cwu5xYRwRZ+6Z90CPuC0=
X-Google-Smtp-Source: AGHT+IEArd2I30xzORLkjQpW+97oi5JFqfKls7C3LzUMHkg8g9KMJjl5xg3dwzNsxJfPkCq/ys0GCBxViv1FDHUD3Dg=
X-Received: by 2002:ac5:cc43:0:b0:4ca:80c5:753d with SMTP id
 l3-20020ac5cc43000000b004ca80c5753dmr4856946vkm.4.1712829978239; Thu, 11 Apr
 2024 03:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712235356.git.ps@pks.im> <cover.1712825204.git.ps@pks.im> <ef61b578da84dbd8087bf22c43029acf6983e547.1712825204.git.ps@pks.im>
In-Reply-To: <ef61b578da84dbd8087bf22c43029acf6983e547.1712825204.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 11 Apr 2024 06:06:05 -0400
Message-ID: <CAPig+cR19_xdKx84xQ+7c4Cp6GzeOeHSit7-ujJJQ6gE=q+f_w@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] ci: fix setup of custom path for GitLab CI
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:10=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Part of "install-dependencies.sh" is to install some binaries required
> for tests into a custom directory that gets added to the PATH. This
> directory is located at "$HOME/path" and thus depends on the current
> user that the script executes as.
>
> This creates problems for GitLab CI, which installs dependencies as the
> root user, but runs tests as a separate, unprivileged user. As their
> respective home directories are different, we will end up using two
> different custom path directories. Consequently, the unprivileged user
> will not be able eto find the binaries that were setu up as root user.

s/eto/to/
s/setu/setup/

> Fix this issue by allowing CI to override the custom path, which allows
> GitLab to set up a constant value that isn't derived from "$HOME".
> ---

Missing sign-off.
