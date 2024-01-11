Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20258136
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9wYcnUw"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd1a1c5addso67868881fa.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705009603; x=1705614403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkcMpaEK5QTUCzC0Wniu9ugXFLTSPMOLebjx0zVksdQ=;
        b=m9wYcnUwWKv5NoFiWrIpw/m5htHbsXo+xCCB+vK5517U9DpuA94i+OF7zYN03kwkwM
         eBf0wjEd2G4oyQ96mEXZ4A9in9tmn2Mt0QW3bwmXadgkmJE7VVbt+zoalYuuRLneaEmX
         WwkI6pjrShWRnaU9GXCk4fKtICNTMlBhBu/RBA6gFvNAwq1oovo3IOyx96ilITICRG4x
         SBnlkGjjmBQtxCK9QNqsW/cqbxkKsNs6BAZP5bM+kaEqQTpai5k2AL2TZA1Nmz+sfRuY
         BGRQZ22N3eD0suTXbm/UKJ3t4mvA7pKIcr7EeVEIb5QB28FGFSH04Y9zSwdDXfWSs5Tk
         d+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705009603; x=1705614403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkcMpaEK5QTUCzC0Wniu9ugXFLTSPMOLebjx0zVksdQ=;
        b=pA5uV28HFROy37CAoxtcCbJKQs+9o9hjwU6RJLjbV5AI/yvBFbSpWXTwm3SwcF6GmP
         fws7Y/3honRUdahgXmAEERT5Aar4032/LaMiWgGFMIvGTcz1k/Cp3PWUe07wGK6KNjEs
         AXcXZ44mZ6GFOMPbtgkfFyOTtxUTfYXdKv0+V7XJ3qC3BzkGgbr2f7KQZbNtM/Np9RkE
         B/biDHUN/6Fix6XJWG5cLaM8P1Yftpt/SIc3yigMKPkzdDinlo+BhoOHCGF0F1aghZam
         7VOeCang0RTQPpyQFEoJZ64y64unmotwttWylFFX88rqkhJVt06ysmcVg8SjDV6Ui8Jo
         1xTw==
X-Gm-Message-State: AOJu0YyvX29F0EDM9/0N1lkp5e9TZUokQhr8NskdFIB3Edr+9mxfPfQe
	/5+6UuGMtEo1a+6yChu3iI1rmFoXPz/hYOkP30A=
X-Google-Smtp-Source: AGHT+IH2Guja/vHP+7B3NlWfIkE1reua3RSF9+CS8XkzatTXoSPE7MMBH6Euur0lEzMQ/vCkGd8+2IouPAC1PVum050=
X-Received: by 2002:a2e:7d18:0:b0:2cc:61df:1cca with SMTP id
 y24-20020a2e7d18000000b002cc61df1ccamr193489ljc.57.1705009602997; Thu, 11 Jan
 2024 13:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADA7-FOE_81ze8hdaRGLPbipihnvFcEYfp9uwnPxPVxDepG4nA@mail.gmail.com>
 <xmqq4jfjftgw.fsf@gitster.g> <ZaBgqlR5F1dv9ttg@nand.local>
In-Reply-To: <ZaBgqlR5F1dv9ttg@nand.local>
From: Chaitanya Tata <chaitanya.tk17@gmail.com>
Date: Fri, 12 Jan 2024 03:16:29 +0530
Message-ID: <CADA7-FPFb5vmcT+9drdo=bYnixisvMiBqC5x8dPvFt61+FjsVw@mail.gmail.com>
Subject: Re: Add support for `git rebase -no-edit`
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:12=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Jan 11, 2024 at 01:30:55PM -0800, Junio C Hamano wrote:
> > Chaitanya Tata <chaitanya.tk17@gmail.com> writes:
> >
> > > Hi,
> > >
> > > I have a feature request to add `--no-edit` option to `git rebase`
> > > like we do for `git commit`.
> > > The workflow I typically follow is:
> > >
> > > * `git commit -a --fixup=3DXXX`
> > > * `git rebase  -i HEAD~15 --autosquash`
> > >
> > > But it requires closing the editor without any changes. I can
> > > workaround this using the `GIT_EDITOR` option, see [1]. But it would
> > > be good to have this built-in.
> > >
> > > Thoughts?
> >
> > With what is in the 'master' branch, you do not have to say
> > interactive when you do not want to go interactive.  I.e.
> >
> >     $ git rebase --autosquash HEAD~15
> >
> > should work fine.  Building Git from the source should not be too
> > hard.
Amazing, exactly what I need. And or arg order, I just typed in the command=
,
I typically use aliases that are in the proper order, but thanks.
>
> Oh, duh. Indeed, 297be59456 (rebase: support --autosquash without -i,
> 2023-11-14) will do what Chaitanya is looking for. I'll give myself pass
> on remembering that patch since it is from last year ;-).
:).

Thanks both for prompt support, I will compile and test this.
