Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6FE12B7D
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902984; cv=none; b=ZGdEGX99mgalwIGhBoI0xdCukkOVsiYr/7kB+KuYrxi5WQVvQ4krKpJlAPpQt76fcQQJcJEbftRpybK583gyUAHWeDe6TwnQq0L7nspe+cY8RhrkHDYM2KX5N5na/eFfxJwjd80f7LRgqP+PIgJQdT5BawYGGrsH4+7x27J8CRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902984; c=relaxed/simple;
	bh=2c0jf7zHW2gyf0Ru/c2Txno/qxygu+dWp0YAGz40rPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGmf4WDLiSFWrX/FxhbgLPPpKktyYGDv7rvPEsO/Hfv+TO/glsO/KpgcgkHiSbuINEnsmmXeloi2O+XPQy7qz97yG27hpWjBnng2Ob04J/ojsMZm9h1dbX0SzhGrRV8pZatSn5odxankviAUI35ZfVM5WTbgHAE0nRxNguwoApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5680619276.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 19:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902981; x=1711507781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c0jf7zHW2gyf0Ru/c2Txno/qxygu+dWp0YAGz40rPc=;
        b=UFkiVQLZQxcOv1/7I/w5DcngnJaVPXTrDzgS3R95aSSuJYkFeufotFGZTJpGamokpb
         WnZykqotjGD3Xa9nUjyLIW2sLYxb0OslE8BEofEtGoSfRGtOHPCodRw1bvkgT2RnGJWM
         cJ8R+DFGj4yvzuFu5a1Zx/XLz/btjvS5YVohqn/1UDrRAoUdPW+VH45ZLreA4s3Uib9j
         d1c8ULFv+eM2Z3NVOG3UmE0W3dQSd9AHy3QyWqtMMGSU0RKmcpMSQB17x1qItLgkgpHr
         u+7okIWpcwpfVaryk1qf3mGMYrYVPd7fvGRDJ366PuUUUf07NlztfZ8rRgnOJQ3CVHTv
         K0/g==
X-Forwarded-Encrypted: i=1; AJvYcCUvSStXbAg/02UYqYKbA0aqnMPIex/UkfLDUz/Q4grVUs3NfHXzMLTgm6rxyiYGW1lR4Ce/Ar2q99EljazSYhCjoSVG
X-Gm-Message-State: AOJu0Yy/OBfkSA2GYgiUPgEfCyI5fw+VBYRtHLwptpUf3L5TrjFY7BSE
	U21AzL+gYU0BZ5kItn1PxzOVOuZlipdFuO2HG7b0mDb5jJB0jfoIzT0vpb45IV5UhFdXP+YcV9h
	O+g6mzf1TYILlzuuXftOhyn+J8vQ=
X-Google-Smtp-Source: AGHT+IHMaIccn33pyMjt9YqngeZLiYZRXJyql/7blWG9oZK3TdOCViuwD1cdgY+rMGvbkjFy973wkt/gS2oyrbBCoB0=
X-Received: by 2002:a25:a2cb:0:b0:dcf:bc57:cd61 with SMTP id
 c11-20020a25a2cb000000b00dcfbc57cd61mr15091606ybn.50.1710902981582; Tue, 19
 Mar 2024 19:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309181828.45496-1-ignacio@iencinas.com> <20240319183722.211300-1-ignacio@iencinas.com>
 <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
 <xmqqa5mulycz.fsf@gitster.g> <CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>
 <20240320001934.GA903718@coredump.intra.peff.net>
In-Reply-To: <20240320001934.GA903718@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 19 Mar 2024 22:49:30 -0400
Message-ID: <CAPig+cT9QxRZhZyZV=Txt1VfqzDZX=gDbXvFg1nO=rjeMFaBeQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 8:19=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Tue, Mar 19, 2024 at 05:13:47PM -0400, Eric Sunshine wrote:
> > The other possibility which came to mind was adding a GIT_HOSTNAME
> > variable to the output of `git var -l`.
>
> That strikes me as a more appropriate spot than an option to git-config.
> Even if config is the only thing _now_ which cares about the hostname,
> it may be something that other parts of the system care about in the
> future.

Also, taking into consideration Patrick's proposed revamp[1] of
git-config to give it a subcommand API, then git-config becomes an
even less welcome place for a standalone --show-hostname option which,
by itself, doesn't really fit into the subcommand paradigm, and it
probably doesn't make sense to add a new subcommand ("info" or
whatever) just for that.

[1]: https://lore.kernel.org/git/cover.1710198711.git.ps@pks.im/T/#u

> Some care may need to be taken for error handling, though. For "git var
> GIT_HOSTNAME" it is OK to exit non-zero, but "git var -l" should not
> bail on a system where gethostname() doesn't work (it is still not clear
> to me if that is a real case to worry about or not).

Ports to oddball platforms should probably be providing a
gethostname() in "compat/" anyhow, just as is done for Windows in
"compat/mingw.c".
