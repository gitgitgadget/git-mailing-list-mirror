Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093253807
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713332923; cv=none; b=pPQ8R5ty4zplcAfggbbf/78zRBKVgFZ7zORJRY6ljqDdC0O8WD9HYUrrMZIbCSdjCsFBSuYLkUoVnDkz/IfFc+TFBf4Wzb8s98Ghgw+m0z6qrsmPnarnTd8rp9+zJngF82cbSTMS6hXzEOVL7dESQtCQ65noBkoB4HJiQrXZ+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713332923; c=relaxed/simple;
	bh=SgUzli5FoYlXRSz1xB/76HUGYwMltM6PhmG8CC/EPYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkTWf7euK0wAbapaupuLB8CzBylkEclsrk/LLjWtT0jmLtMQ3SjRPVlCFMls0BfQ3ohesixZQs2vUXQ4I/OinbrSGmrvmk21huYDD+y2Um+gXZKeeCP2QjOOyT/3ZIzjE+ZjrywAwZSL/CIBH58J2vXFptUp+J0MNsS74FiVsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b16b614d7so33465636d6.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 22:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713332921; x=1713937721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAJ0XRuELvwrDgvnnu5gW5di0bipBRrgsEAoCUmmUYo=;
        b=V3Y1F5wfNw8qKMyGyYWsGtoZgDrPa2YNI7JzKInkSYtiM+LX1KfrOR8vvlExm9zXUZ
         4B0RchGn2UqO5Ar/XcjFzITewq0Be/dQ71R3VWdYKokcPygVPhNCOM+FibAQ0tgtYY+q
         eUTSDPpbrcwPOMhz538wucN/RUFb8XIr0mpeeRYGoyKU51cG2Ht8jlJRd8s1iUqThDtU
         Gj1WGWgPmFycBmgXLIICETYb0JUyIvxR4+36LNVLchre27SHS7zJOqtmgjhLKFpvrlNe
         n3QugOpaTSuiMLfjU1gOvSO+VHMJ63CSTobNFkWMcnyECsoeMt4JkP/L5yVa6tg57sbP
         Fd6w==
X-Forwarded-Encrypted: i=1; AJvYcCVC9HFxlQNd/OHXjwNc5YfRV5yc7mXUS+j1tLEQsDQMUWJv7a+YVZWUODfgVl28/Rxnr1xgJTgZ1piOHTxrk3cHN2k1
X-Gm-Message-State: AOJu0Yz2OSregvC/d7OchGIUb6SzyIPPVi7gdPz7OlacbEI9YRoyayzS
	KSz92dv9IdrqDUEOiykSHL+wte6ziOJxHr0jgVj5gLNgkq3wtlaLxvdmG4UD/4Yt1UWYghq1sZX
	W88/BBoSAmKvqeCX5+cqsE89GRks=
X-Google-Smtp-Source: AGHT+IGWvpfiEL2fEbOy1xF6TqqcI/i9hTHQrAK2EChWQIOx6PWNdQhbAioNQ0umY58byWqQFhiBTEEWF8V4jL+Ub4k=
X-Received: by 2002:a05:6214:514f:b0:6a0:49d1:d490 with SMTP id
 kh15-20020a056214514f00b006a049d1d490mr208588qvb.56.1713332920646; Tue, 16
 Apr 2024 22:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
 <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com> <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
 <xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com>
 <xmqqjzkwdigv.fsf@gitster.g> <owlyzfts52ln.fsf@fine.c.googlers.com>
 <xmqqfrvkd843.fsf@gitster.g> <xmqq8r1cczw8.fsf@gitster.g>
In-Reply-To: <xmqq8r1cczw8.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 01:48:29 -0400
Message-ID: <CAPig+cQ=xgfExyCM2qyobv7CNRz7=J8S_=w-C-VoCNZ6M6FBbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver <linusa@google.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, 
	Kipras Melnikovas <kipras@kipras.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:38=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> IOW, $cmd is just an early part of a shell command line that takes a
> filename as its last argument, so I think it would be fine for $cmd
> to be "perl contrib/contacts/git-contacts".  I did not test it, and
> it would be appreciated if people can test it.
>
> diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFirs=
tContribution.txt
> @@ -1118,12 +1118,12 @@ valuable, such as changing the Reply-to address o=
r adding more CC and BCC lines.
> -codebase and run `contrib/contacts/git-contacts` (you must have Perl ins=
talled +
> -in your system).]
> +codebase and run `perl contrib/contacts/git-contacts` (you must have Per=
l +
> +installed in your system).]

I wonder if we really need to hand-hold so much to tell people that
they must have Perl installed, especially since the command being run
_is_ `perl`. It might be sufficient simply to say:

    ... codebase and run `perl contrib/contacts/git-contacts`.]

Anyhow, it's a minor point.
