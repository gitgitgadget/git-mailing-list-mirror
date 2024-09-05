Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791A7464
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559391; cv=none; b=HTGYI/g4StKXyU+wOTxfHEha+XZ08CIAn4o+iwmvcM32Z7MzpKKWydTk9XDDvPsU6MRboHVfHwqopFZtWLx3LhzVqzB/g+DjXIxgyqLwxHzFBfNuZyQ/HJs/9QyMy9vhN+iLxQkSdpt6xeEjCMb8g2FjFdmIv0XWTJvCme8ttFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559391; c=relaxed/simple;
	bh=lN9uFtaz946iMOLENbZwGPRk18ICnrV8GbomP0Q2kT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYn2G5Fjhp2JgkeBOorPNO/0KDy+8aQ/d6xmzIJ5ozwyL3m+NvuDPOa3go0OzCI8hJEHS1QCMGx/W2KLGytABvlQGC6IVVBZ/DsFfMNkGzq/E5MeaTpzeeJSdfxNYb3HG5i4zEgKfQ/AHjNumzTezd+cHaizrQM4kpvp52Hn5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4568b41dbbaso1236781cf.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 11:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559388; x=1726164188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikdfEUKz7/kjGoLdVU7kdVkZFKBbx3vyvjFssusFMH4=;
        b=JqPYb5iauTDQ7+sgEJfz0NnJxPwHCu51uwQsLwSPA16GLwW3EQNHIM+a83fw21Sh3I
         MXtowt74jrHjPPr5xHTVahdBAYXfxv6FO3hwmKPYkkAnnignc6jE5pbSpRSfmsLbc+0c
         j8LknFyvb0DIP8snrON7gHCXdDqoGGCmu3fCxjjiphi9UpTiF3szwIviAifi8cSWQS98
         SWGUONJXCwi7ozS9UuEUQAbl69SS7RGZGSQ/j0ZK5NktaRXFZSHBYHmeGYxkP4xX/FEg
         e5uW7XysJSI4aO3IaQSpKXnAwq2P1qmwHJAL87TNPE7u7u8o+M/BGXrwa5YGC9LrkEuw
         5Jrg==
X-Gm-Message-State: AOJu0YyBYgEt7R6c+yw8g/SEVIpQ4PZI/h/i9HOqZ7VVeD9xhaF0w5WA
	B99nd9NAj2j/mMZyb3e3oppstQKa8WWk7uDSjyrZ8yG0+MZKhSCgBksWMkc56wM648TCUjBb8aA
	gXoZLr0rst6Wi6wgN8NcRTj8LbKc=
X-Google-Smtp-Source: AGHT+IFHvrPQIgLeUInJn+sJbI6um9dtED12gOrJeId8q0BOTjajALGWGpITZahkN6HH6pmAdJR/XQmcJLf+S8/1nOg=
X-Received: by 2002:a05:6214:f07:b0:6c3:5f4c:4ffc with SMTP id
 6a1803df08f44-6c52852816bmr701536d6.6.1725559387833; Thu, 05 Sep 2024
 11:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1781.git.1725559154387.gitgitgadget@gmail.com>
In-Reply-To: <pull.1781.git.1725559154387.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 5 Sep 2024 14:02:56 -0400
Message-ID: <CAPig+cSGry+QMpkkiJb8A94w1M+J_5beEKaT-xrGeL34xME4hA@mail.gmail.com>
Subject: Re: [PATCH] advice: recommend GIT_ADVICE=0 for tools
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de, 
	ps@pks.im, james@jamesliu.io, Jeff King <peff@peff.net>, 
	Gabor Gombas <gombasgg@gmail.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 1:59=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The GIT_ADVICE environment variable was added implicitly in b79deeb5544
> (advice: add --no-advice global option, 2024-05-03) but was not
> documented. Add documentation to show that it is an option for tools
> that want to disable these messages. Make note that while the
> --no-advice option exists, older Git versions will fail to parse that
> option. The environment variable presents a way to change the behavior
> of Git versions that understand it without disrupting older versions.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advic=
e.txt
> @@ -1,8 +1,12 @@
>  advice.*::
>         These variables control various optional help messages designed t=
o
> -       aid new users.  When left unconfigured, Git will give the message
> -       alongside instructions on how to squelch it.  You can tell Git
> -       that you do not need the help message by setting these to `false`=
:
> +       aid new users. These are output to `stderr` by default as they ar=
e
> +       intended to help human readers. Tools that execute Git as a subpr=
ocess
> +       can disable these messages by setting `GIT_ACVICE=3D0` in the env=
ironment.

s/GIT_ACVICE/GIT_ADVICE/
