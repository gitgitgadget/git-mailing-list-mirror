Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263F1E502
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846008; cv=none; b=ZwfhKWiiRnHtVQSGv7/v8aGK6bvvPdaNhrHng8FpGZaP9kyThR/XchDHA88B/2Cav2bMYzZ7aaHWcNuAViyzO78AmyRRPPq7iKtVsUBuIM3ixLa5vNbeDx1Ynl759CblZnOPVSvPNmupZQk1Cvdt218Et4TsqGhyaUNmu+Uwqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846008; c=relaxed/simple;
	bh=UVtc8YHfqgkX9LWm79yAiqoZJJ61aTOZFSbZSVxNcLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF4yd8jSUJdBEtomyBl7aeeEP7ywoq+cp/+ekNHZXehFUdMn10/SmsFsIRgugysRHIUmcGkWA/ufdtsiZpGvUmwnAFLNLkn+kAgxG0CmGdjzrbR45H4UP2aGqZMw7mWYiLDrwjKoSAgHgsytq7KCsK2XpXx38s8PzdUgiAX0XVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6869e87c8d8so20614206d6.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846005; x=1708450805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mqrFbgQ0dQkEV7cyoOpgQObg8ZECve6c8b8mByyFZQ=;
        b=lX7sWJ3l9QMcVP6EZw2DWsfO951j8NCnuaXb6C+7U7ttjCSOepe2TMN6Fuv4MIIS+I
         JnYbh3ZGj7qZiwV9No/g36cRH0tuZmWSeCs1fWp33cH/DZoI1tVhINzJLuNYDI4SJxw6
         qSP0ZIWP7mJ8FscMMt++i6obJQ0tK0xz93XPbRf03RzESsiUP7KluuT6zKuUqCdm0pdU
         WEQSTZ5QP3E3jPAJHBQSliCNY9BWzMH7rG/UuL6m1iG1PKP1dsvcH2U9LEXWJtJBW/9O
         zlpf+tPKaWwgeRr5AQBbPyPMYF17m7aKGpisa3ZqV3WWwXzA76ckca+xDJmfC+ftSpW5
         127A==
X-Forwarded-Encrypted: i=1; AJvYcCV8MgQNz5G3TenKknBzT0rjMjvKZz+o3CIrXfoKnIgPqHMk8hVFKuOiTNMNdGbtoltNYztkFEy7zh00GxJNkwkGlcmF
X-Gm-Message-State: AOJu0Yz+B7cA9vbjhw3GN/IyAkVp31vCuHSSz29gNEsU+rD1tLKaAPnK
	vMsL8YgFDcj3IvL25Tujrn0BCzFGflrB6PFgZRwkke53PVG5lOd6IsrFyoha1RYxj/GiSTYlhnu
	FPvMJsAIRyO9zZSz7ttAF3zTZaCU=
X-Google-Smtp-Source: AGHT+IESUhfWQaOPzC+yqAuVbXqS3vacqLdfC2mJWlWwb1KvD0C/6gn7gOKXpgplbdE6Qh/ONVHqCkFZW6tA041rut4=
X-Received: by 2002:a05:6214:29e3:b0:68c:bcc4:f30d with SMTP id
 jv3-20020a05621429e300b0068cbcc4f30dmr178783qvb.15.1707846004906; Tue, 13 Feb
 2024 09:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cbb450b3-b333-4391-ac83-66c2daf0ae4d@gmail.com> <CAP8UFD2ypikjKEVMmHMg7=jwv8J0y5xhx6PxsiLsGdhz2+S3PQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2ypikjKEVMmHMg7=jwv8J0y5xhx6PxsiLsGdhz2+S3PQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 13 Feb 2024 12:39:53 -0500
Message-ID: <CAPig+cROxB7shLZ0VMf=4pP2h_EuEG35X+Zf6ncfXv7Rk5yBHg@mail.gmail.com>
Subject: Re: [GSOC][RFC] microproject: use test_path_is_* functions in test scripts
To: Christian Couder <christian.couder@gmail.com>
Cc: Vincenzo MEZZELA <vincenzo.mezzela@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:36=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Feb 13, 2024 at 5:10=E2=80=AFPM Vincenzo MEZZELA
> <vincenzo.mezzela@gmail.com> wrote:
> > Can you confirm if this task has already been taken by someone else?
>
> This is a generic microproject so even if someone else is working on
> this microproject, you can also work on it as long as you don't work
> on the same file as that person.
>
> > >>      12 t9146-git-svn-empty-dirs.sh:

This particular test script is being tackled by someone else on the
list presently, so probably best to choose one of the others.
