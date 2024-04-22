Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA972EAF1
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820346; cv=none; b=MJMkPG05cBBCbiUf3FDIhilczAXy97Hwvtv3JdwYALSRtyMsmq0ddp2HkPoo8DF5uCD+89njreHzn7UyJI32PScfBtDhK/IcsSETKzU6W4nk33uLzcPm93Zh/Kmwx8tKyUUGSwt5IVOz6K7AYUPXtOgWZOTXWXY98zx+/plEDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820346; c=relaxed/simple;
	bh=REEWWi20RyyZkN6s9QL6KxcBVTYGWPHgTtOEp5Qnv7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmd2WPVObjpZLwQD9zP9OJ0AdV8AHG1zlq33IB5Z5vabBRm57nL6fcpoqrx5rTSNdCtlPnwaDciH0NXmAIaAFOOX5ywbqdP+ac8XnLGrZGe+CBrZ0oQ+rl0rUFyG81jKJqdJNPakI5fBf3NzsIKz3bwa0wZSKgTSjx3iyPRVTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9YL0SjA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9YL0SjA"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43989e6ca42so98351cf.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713820344; x=1714425144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkUxoXv9vi9FYWN2Q3m7Mx35QxdIcLIUHTpcEILakWU=;
        b=s9YL0SjABPCJsfZEUQ668JGj6aSbIcfvSrgLQLCt79YJ69u0U6XCi84Tqm94w2SzQI
         7LSZty6/fBv8TUEF3/fJyIwGS6i+X9M/wK8R3Bx6wx81iNT3lbLaUX7Me2NAzTnlhDOb
         +80WJBv9PIXoRTD/XTGWDb8gbtP51UYaBQU6PBeOxgkHW/cCVpojbO8+VVE50ridp7ji
         +0ApYAtMRmGPUb4LDqViP9O29mZ0CMcv94vdEFKaKV2ZtLwL5W6ncDZ1fCEvdRabuJuI
         BEvuPWz+tdkiWZIxi0RgSr0xYaQgNRr/UPrZPH/+Os0hzLb6JGRcqW98AipUP9FPCn9F
         zIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713820344; x=1714425144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkUxoXv9vi9FYWN2Q3m7Mx35QxdIcLIUHTpcEILakWU=;
        b=wazhoVbuE++mT81qr/sWWXH9bb6CLBFMLYcbQW7gvoY6btr96EtBFbdQEPWpENBKZ3
         P06cdsMSpnuWVkzFdqcE4EascNT8Z9/Gm9niZa4tzavKm90W64Ax2coxC4uUSn3o9B/6
         dUxjreaSB7/BAAxIcz+yf1JipIdV/dbglQDOFopxZP31+NDdi83ovQM3ntVUIZXYsnkC
         n5QbFgmi+MGIkHQyHE+UnLcf6pBce0r18UKKLZT0cqrEE/ycOD8n2+g3k3NepRDjvGWi
         picq5QON3FQqb/8UyZ04BPHHY4Ja3IIPzcyEjQ/KWkXI4MXiNsXuoAB6hTpabPW0uS1a
         iqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGLXET2MAGkqGkMPg+5CCLukeWleZ7w7YlfIA5LIyGlfdMWrAA0zi7CDqMTcCXcUm1ihCRO8YUpHef8hQI9lu6pV7g
X-Gm-Message-State: AOJu0Yyqy4jp5YeazsXpwU0xnNYUpDSFJN9OmmwOzi7BxETGOd6R6k7K
	Fu93Tj4p5NxKZ696iK0iJbesdR8CEwaYBstLL8lx3kwmaZ0d8tSELclkgX7gwuOStu8Dqh3s5KV
	TZquPDit97c9vo4yUoFDJpKe1EtND6D1a60NL
X-Google-Smtp-Source: AGHT+IHZYS7JuMHvNLas+r55Dz/O3MMewG/XT+1zz0Nx9zS/f3ePG7sbC5y20chp0KBWlVHFTgQrK4KhSFdggSszXH4=
X-Received: by 2002:a05:622a:810b:b0:437:74fd:bd26 with SMTP id
 jx11-20020a05622a810b00b0043774fdbd26mr74294qtb.14.1713820343576; Mon, 22 Apr
 2024 14:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <CAJoAoZmOqEd9HcHMrOUwSXNJi2a8DLeO_11gW1h_HuaK79WEVg@mail.gmail.com> <xmqq1q6xw6hv.fsf@gitster.g>
In-Reply-To: <xmqq1q6xw6hv.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 22 Apr 2024 14:12:10 -0700
Message-ID: <CAJoAoZmR37h5XLa4NnJ+5iZfLNJVfzBgRs4bvaJN4sa=UDtxNw@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, avarab@gmail.com, 
	christian.couder@gmail.com, me@ttaylorr.com, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Emily Shaffer <nasamuffin@google.com> writes:
>
> > Thanks for writing this. I, for one, would love to see the process
> > evolve a little to account for the scale of work coming through the
> > list on any given day. However, that's a discussion that will be
> > easier to have once we have the status quo written and checked in.
> > ...
> > So, if nobody disagrees with the content of this document, I think we
> > should absolutely merge it. It will be great for newbies to see what
> > they're getting into, and for me to send to my boss to explain why my
> > predictions for my team's patches landing are so broad.
>
> Isn't it a bit too late to say "if nobody disagrees with", after it
> was pointed out that the world around here does not work that way
> (yet) about a week ago?

Well, so far we heard from one person who perceives it as status quo
(the author), one person new to the project, the maintainer, and me :)
I think Josh is working on a v2 with links as you asked.

I have certainly followed the process Josh described here for a couple
of large projects coming from my team - to mind, config-based hooks,
submodules UX proposal, and libification proposal all came with
discussion before any patches. I'd love to hear from others who have
been implementing large-scale changes in a different way, like brian,
or Taylor and the other GitHub folks, too - if this patch is too
different from what actually happens with their work, let's trim until
it isn't, instead.

>
> If we have an agreeable v2 already posted on the list that I missed,
> then sorry, please disregard the above comment.
>
> I still don't think it captures "the status quo", which is what you
> want this document to be, about "larger-scale decisions", as the
> Introduction of the document says.  Can we have a set of pointers in
> the document, when it gets rerolled, to an actual example of how we
> made such a larger-scale decision?  Without such illustration with a
> real world example, it looks to me that what it describes is what we
> wish the process to be (which is not necessarily I would object to),
> but labeling it as "describing the status quo" is very much
> objectionable.
>
> Thanks.
