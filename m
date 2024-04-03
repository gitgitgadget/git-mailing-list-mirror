Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BF2136995
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139235; cv=none; b=qUloLdfyLbhp0WEX2NYHhIZtlOjdGXsZSSA7AA5NJd/juUBmlj+NxO8kEtFlSUTG1KGgMV72JwJ+C9gBaxr3H66ItJgDSsg3CqvzUYKmEBxGKIpyHbue0VT4CrAnB9SDJVllb9SnW28gYwUNzTvdcYlpree/OJbB3yfw0GocmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139235; c=relaxed/simple;
	bh=dUdd9J3zLUW6s1YmzAVdKevgyeX5nMZAYoF8HOGZigo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1gf9EIwtUdfsf4lwKsFROYZAsWFXiVFgAgdmcCksED878nL0WAC6+CT/g+fHWsrRPvWXue0nQD+4v1zydRoDCaPOm6q1O3DBi96YTVunsucgHHZmq8Gqt3DquITmw4yoTysEmf2xXIMRjk39MSdRgeWlz0BvBBkIf5Mn8Q+ins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZxs3xH4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZxs3xH4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1def89f0cfdso5968725ad.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712139233; x=1712744033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUdd9J3zLUW6s1YmzAVdKevgyeX5nMZAYoF8HOGZigo=;
        b=TZxs3xH4MBEGPCq4A6MDJ0dx+lWlleVy6fOkUWxzVGmUQMvHQGsIfmDerM5zmbbmEN
         f4VK3ruWIAMP/eQtqI68D6CrDLpAG7pt2wRLIr8hf8WIrQ9EWDyAPJyO5xghjGJRylfb
         oPkN2jUhGTxNDwXo1890Zg1yhA0ecVJFwrY8vm5uqQGypGRiJPBHA8T/egLeJ4z7UHOD
         mydhKOgXF/bfPfk2BhVJk+DlrTDPMPmKeBDyvVxNyzZf5pHnJNhLCC8pY+QymVXdTW3d
         cldbcHpOZCToY23pUaKNev6vsQdUzkbG+dto8huw4kRqnyQFL8Tjt2t3hGi0C9+agcNU
         kLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712139233; x=1712744033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUdd9J3zLUW6s1YmzAVdKevgyeX5nMZAYoF8HOGZigo=;
        b=kLYqFotT7HGUIFkthzwTepC6+/1FAHYIfIXFtvfHjbYSQ2J6qcPdkY+IwtNnS2R4Jw
         6tvbqIcrNJDbS4vKh0dmLkFq4t33GZX5Fyv4fLqVWBZPoszpZaMuM3y2jsgsMB2+6ZEm
         gIHbHeMtp03ihiDpi7qphm9odgZz/t/9DgnsvxHU9g5nyKX+mV5j09pfYuSwr3GoRIZf
         OwgG4ol8ydt5ukusCea8AogvB0yW1IQ43pNtMYORwriv/8PsL14fO6AbrQEbM19aMNnE
         uVy4cYIyRGdWqWuf1BSU5tkDajdoScgn1ewEDycxpmucym8zgm04S8+GIz5Sdj5oJ6BA
         hkKw==
X-Forwarded-Encrypted: i=1; AJvYcCWJB4huUvY1ubXL6znUVwCdoPBgWA1OhsSJviO1we858uL1Dw/C4nOB8vpyQkrKPISU/jAlv6ofOUqLLmEUOkVz9dz8
X-Gm-Message-State: AOJu0Yw37WHk7qibiEn3kEixkkOwCPYZ8pO2DMS4pclCqOhNbOddBAI1
	Vu6Ve53w1W9qORGwxy8UBM+s8Kp9LEGXRstbLAVYyw78QHao9I5CjRP4ACATMC3+ZSN6lqEeGKM
	bYzM2LIOxV+tkpyUS+spXDsPGhQ8=
X-Google-Smtp-Source: AGHT+IE/8ZFH838vZF2B/aa0QUC+8eWg9P5GZF85AKt91P+aiiqZ7+O7y2StUeqdUrU9DY0EmE4L6asNWTZ1OkQnpcs=
X-Received: by 2002:a17:903:2449:b0:1e0:9d43:55cb with SMTP id
 l9-20020a170903244900b001e09d4355cbmr2443171pls.34.1712139233221; Wed, 03 Apr
 2024 03:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com> <Zfzd8YdAwzYRYkA3@tanuki>
In-Reply-To: <Zfzd8YdAwzYRYkA3@tanuki>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 3 Apr 2024 12:13:42 +0200
Message-ID: <CAOw_e7az+S4nkG1HKDcqXkK0BOhs6cBpkb=QEGBoZW8MSEEvGg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Justin Tobler <jltobler@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > Thanks for taking a look!
>
> Cc'ing Han-Wen and Josh for additional input. From my point of view the
> new algorithm is simpler to understand and less fragile, but I do wonder
> whether there is anything that we're missing.

Good spotting. I hadn't thought about alternating tables.

I have one minor criticism:

Environment variables are untyped global variables without any form of
data protection, so I find them unsavoury, and have tried to avoid
them throughout. (The whole reftable library only looks at $TMPDIR in
tests). They're also accessible to end users, so it can become a
feature that can inadvertently become a maintenance burden.

For testing, there is a stack->disable_auto_compact.

If you want to keep that style, I would elevate disable_auto_compact
into reftable_write_options to make it API surface. This will let you
use it in tests written in C, which can be unittests and therefore
more precise and fine-grained. They also run more quickly, and are
easier to instrument with asan/valgrind/etc. The test for tables with
alternating sizes can be easily written in C.

If you really need it, you could initialize disable_auto_compact from
the environment, but I would suggest avoiding it if possible.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
