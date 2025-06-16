Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999184D08
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 04:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750047438; cv=none; b=rqlgKtdGciAjWnj4ckRWXLU9cskhonEzUMF7XV2uavs3LY7PyEgT06Qh/O+yON8od6b9P0Fsux0a8XBldU3xG0Im2QlPX1paqsMuwnhIbf4j3++yvD9e9ZmKJ74Z311L5rU/AhjpoPX1vOhnxKHFLdKyu6GEr0SlicLLpvVflxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750047438; c=relaxed/simple;
	bh=EBEYNXOPDAavsToTmU92m9FimRTAwwKvew57wPWpyj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fr6hODyV2R8UcuK9CgkCSB1IZvClzPXHGhv/VzT0WjsSb3eaVE58pgHThEqM22kMECLJaoY2hHqdk2Sc34zzKs7KjqsSdtexUdP6eXmKpomQUuGD3LPn8hUDHiykqNg8sCeHacvkqy4lkSIu8NpTmN+MXcN5XpyaKabum/X1poY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c5528c98bdso96160085a.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 21:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750047435; x=1750652235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBEYNXOPDAavsToTmU92m9FimRTAwwKvew57wPWpyj8=;
        b=Vbpj597Ir0t3HXBQ46Ql/6sCwMJ/dSrXlZsmLfmPQmEHZOTxjQxncG2NlLvyxc3GoE
         jDsdL4q4zHl5otYNgjrkK18IpVebY1DjJE3ixU1lMfOpJ7a8jr5pTMfyhV02AiNB7WKk
         hXr5pBrx7Zbacop1ptDSPQCuJf7IIkPw2hDLJNoi+p2JDYou1LxbqkxZeszx2HWfiDZ0
         pe45RVYiJP/G5zqdBEe9VOIcfi+iHTNxC8TKLI2JXmUVDOstg6nW/X9Rc3ixd9AdagnG
         Ts/P6G4MPhrx6fqP28sy2Xt+t54jxSWApjsZP83bFi1jZ0K22JA7WhaYmx7uYDvkvowh
         GEqA==
X-Forwarded-Encrypted: i=1; AJvYcCWW/9Ue0V8hzXsLQ5fP9Zs0N6+jr/6VtutayB1YOVdXMQLrfRwOQoNKJ4hwZ6FcyCZ5GzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+H5M73ifk71scnjPlLV0Z844u0ZMHcuoeYwdXwr2Q9swKBb6p
	k8Kw8cwhCs06RB6e1KZ9t7UM/MbEZABz5qGpJ7h1YKHJyDSwx/98ppd9HHub6rcJuDU473otoYM
	yh2KJPJpW8Lk59PPPR9U9cR/OM1McI6s=
X-Gm-Gg: ASbGncsHJHO8UIPXUzkht7QjmmMeLJ3/EphUbUvS/fDoISYBFi92xJTundAv6aHOdOM
	8/mb+slyiIz+hGEdH4+qXLwQB9ATJvPfwqDrBfy/ZFMANKgEYK/hvnj5rPShJ7yzoex+WjgFBC9
	QffEic+HDGVcRBQGKybF8nSErJLX/1HyGa9Z+hds/LpA==
X-Google-Smtp-Source: AGHT+IHOeHbsdZZ6DDfevwjsYZt++8LBy6PjKLjfFuo/72cZYJvFONtARaFnY9+vqcJNiWhifcjtFfCR5NR8yhIQ6O4=
X-Received: by 2002:a05:6214:3d87:b0:6fa:be81:e18f with SMTP id
 6a1803df08f44-6fb4725df27mr53806416d6.0.1750047435212; Sun, 15 Jun 2025
 21:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616020827.10820-1-rodmichelassi@gmail.com>
 <CAPig+cT1VfY8QiUvrrV3-obTBP1439b6iwaebJtGwML5MScnQA@mail.gmail.com> <xmqq1prk490o.fsf@gitster.g>
In-Reply-To: <xmqq1prk490o.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 16 Jun 2025 00:17:04 -0400
X-Gm-Features: AX0GCFsttp2Aew8A-SmKPG1Qc1E73mir1GpB0-6ex6UTqqFXUlqfGQhdgUppBG4
Message-ID: <CAPig+cQv80O+6y_LkyW0dOOYAaY3iFNva0CDLM9WSb_J9oT0sQ@mail.gmail.com>
Subject: Re: [PATCH] replace 'test -[efd]' with 'test_path_is_[file,dir,executable]'
To: Junio C Hamano <gitster@pobox.com>
Cc: Rodrigo Michelassi <rodmichelassi@gmail.com>, git@vger.kernel.org, icaselli@usp.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 12:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> From: rodrigocmichelassi <rodmichelassi@gmail.com>
> >
> > The From: header name/address should match your Signed-off-by:
> > trailer, so you'll probably need to adjust your mailer settings.
>
> This is an in-body header most likely added by git-send-email, so
> the name string is what the commit object recorded as its author.
> What needs to be adjusted is not the mailer settings, but user.name,
> if that is indeed the case.

Thanks for the correction.
