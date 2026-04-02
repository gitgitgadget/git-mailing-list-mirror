Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679B347DD
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113394; cv=pass; b=sMxOGWPq8Facq+SQUxFdC4qgXe5+pdNSgoycHpIdNphl7krdL9DKQsRiOeh3Fqt7RoSdYuJQA783MbetV+Zqbq0i5k82XveRRPKZ6/8s9j3pspf3oi/CDq10LP7j8+Tetacehq454o6kJgJptNCHHzv6CGUE0NG6P7YGXi55zPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113394; c=relaxed/simple;
	bh=1xdlmuQrGB7B///OrKGjl5IsPM/SXYDTdmOWF0ygUIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KujIGZGfW6Hj3JTR19wNoy0uM62iEcsDrrBKszJDAwATnKpxWQY4sb9tjOW976JRrXLNGeT6Gd5mItPWIDIYloR5JGBcGT/z85vpEYA6nhtqloCQBSBLFwgQqekJNP/46utto9uWo1Okcshi5ClG4yRMJu1j7bnAjWEYxgKdM6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXzp7aNM; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXzp7aNM"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12a74039dc6so547131c88.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775113392; cv=none;
        d=google.com; s=arc-20240605;
        b=V+i0xJORLKeqIln72FHAAbWSr0AYvvIv+ShOzI85utBu8BctTKMmkMIFjSN7OY77Xl
         2BpKhzC5itpkk9OR/nib1Hu0Fs7i1QAhFQK1wzEdCy9yA/fWfgBXzmgaYL9GaG8CGnSt
         3+aUk7CJY9iS+YIDhTbjP+7QEgnX/ODmYxafWMglBfVjY8Ii+XJWVJ/YjnlHznlOrh31
         Gw5NyVUL09pcdwH+oa20+xtmvTMfIgWWmwztnUEEcjO1Dciem3eDxwIjJhXQEv6NZ9Bg
         liIWfLwe1oawHWlaTpB21Tt0gJpDIe4JwlH7A7Otxb1WQlrclEAwFksMdOH3J3/ugocO
         CCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xdlmuQrGB7B///OrKGjl5IsPM/SXYDTdmOWF0ygUIA=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=K9hezKABhmdymM05zJI0qlraKuQlk0LGa5LCo5DJV0jMA9wFpXt77XpOihreszLLO6
         qz62pC8JSIefshJ1k7HhNFr4nwh7mI2Vy0eoxttR6V3tO17OQris7YQ9Hqy4K8nv++2E
         mP8muLgz4WeXGoZviG3gkMFGeBf9dew8/X2533M0HcnKauyDPMpAmCIBMd6DUth/R1Vg
         /ZFpHWfQA0qYk9nUJkS3XI8PDHs56wPU2lZq6waze5sLRM5H3w6xD24NdS2OAI0r9azt
         omhLspC2IjObMxL0znh/S3H2xLmJKun+dGuQkp3LR1aeweOsFU4v8siyJgNL4jLGS79k
         pniQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113392; x=1775718192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xdlmuQrGB7B///OrKGjl5IsPM/SXYDTdmOWF0ygUIA=;
        b=OXzp7aNM0s75/IYR4WW23FUUQdZMYrVGV9nC/jK3a/aai9oTD3SMAlVnU6US3W7hJ2
         B4DC3KVB3zsjtH/QLqpCNPRrj0sESqezjdiD9u3E1wCnQYHikKmLiCS9W+DKtWqRk4la
         4WO04QzZYIOsR6qqEdTgc3SKWLeRegIp+6QZ2nXRLFiA4ccdMOlaXZ51omBxoToM5KCp
         IaBLh3ahPP9LO1cisdxUrnxq5RjK/SOT8V0wvZggqKX3eMFU7IBG9iVnPA5IDi96fvc1
         ox55Rhm/d9sWHNqH1bGlArhBFFwfj6mttwJAA/5gkrej9YxCDqchoo2mNM/+9XoZCZ9h
         LTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113392; x=1775718192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xdlmuQrGB7B///OrKGjl5IsPM/SXYDTdmOWF0ygUIA=;
        b=F9rxdi6VglM1Vfb2ceJ0MO3cfzQNH2lG9sQCvAZDKNKyhyJrEj/dxFrpd3t5+ZiMfo
         tUGiFNl/OZeM3jkbW2UqC3dRVW3LUdGlN+3WqMsVbm0yS9Rl55yIcxhc8ovYLpz8TDJf
         4LZbuI1k9J2+am6UI9hZqi+wBYnrxQG2GRHo7yRCQxK9qsy2EqzYYjnNvNFMNhTU8xKC
         Fzbw8BR0NEOygFzmOJU5cI/hQiwtaAvFdSVJUm+Pfsx05OcTRuTlaeMJDr0hFcWlTXps
         jmuW4V0jFQ4ahiVP6ad7VNSMBsk58oqgMt+A4nW/CtTqF8BIBv3dvNIEkgV1c/Br0BJn
         1T8w==
X-Gm-Message-State: AOJu0Yy411O1htGjd7yy/ufi3gU+7lMWPEbzszUM/klQYol1udbHfApV
	LNBY/KO/UXZ8LTe22wKVyyEST6tPz1TP0GelULfq8syPyPrHZWqwsolu4Bs62WpVKK0odRdKkp9
	g6npINGRHGKVmk/ucBPAsDzFecmEud3k=
X-Gm-Gg: ATEYQzzTHfatosoyWPcLBTS5/VNpCyfDAkY6Jlr+7ZSad1weYNm8awLVuROnkIB7uKq
	Gg7t1gjovbMhibHKhUXQOasfaDfWS2drnVer397O3ZWjBxBOA3ANXOWDsif8Q0ofEl2cMHo3Pku
	09lqXlgqVv05y3HVrZXVYRzONPySwDa3mzLigOasHcmS51sxgdm9R+Oh71hZkpLLQOB7aTuviNT
	uVWLaFMCz+GwIYEERRRMveKO0VwO5FylBeD4UoitPzIDwZg2z3ui49i2sYyKCdErDjccZEENyTg
	b95442bjiNRRZ/iTj7G604lr4A3+EhmH+JhHK4nJeiQrx9uRtTGODalYAq5eyFkyQnp5
X-Received: by 2002:a05:7022:618a:b0:12a:b39a:32c8 with SMTP id
 a92af1059eb24-12be64bdd73mr3361361c88.16.1775113392427; Thu, 02 Apr 2026
 00:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-5-christian.couder@gmail.com> <acUkqRUSyRUysf-I@pks.im>
In-Reply-To: <acUkqRUSyRUysf-I@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Apr 2026 09:03:00 +0200
X-Gm-Features: AQROBzCv-3mENjlaTEjJTTHKUl8QzHggE5MjjEzJzcE27DDPdXTqxrCZB2o2SCo
Message-ID: <CAP8UFD12BQUZOq4wfkthUE2No_ozrzhETKRWZgfgOha8UviuKg@mail.gmail.com>
Subject: Re: [PATCH 04/16] promisor-remote: clarify that a remote is ignored
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:07AM +0100, Christian Couder wrote:
> > In should_accept_remote() when a remote is ignored, we might tell users
> > why it is ignored in a warning, but we don't tell them that the remote
> > is actually ignored.
> >
> > Let's clarify that, so users have a better idea of what's actually
> > happening.
>
> Interesting that this doesn't result in any test changes. Don't we have
> test coverage for `should_accept_remote()`?

We have test coverage but we don't test the emitted warning, we test
whether the remote is actually accepted and used.

Let me know if you think we should test the warnings too.
