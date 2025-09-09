Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73E4A21
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409560; cv=none; b=T4u2VxQJo0DqnPoOL/PzdM5i0ECr+1DCGoen2bxXflsS3FeWz9+tW9cYbY+Sh9xAGcRhQx4EJ29sJoBcKjhvNGxnBZO7L6koWi47Tax92M1WnK/ya9QVBLAMTKjfpyxbdYfptiYQCtz6/g8LxN52oMB52QMH81e9WFoMbos0V/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409560; c=relaxed/simple;
	bh=42veuj4zoZiYadLZqM9k0kj4chqyrxvTbeCCwbaax/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqoKQnuMw/iSMYDU2qRmF92P6yHmnSNa8ydAZ1Hf/2rmFFeV1YYLyjkR8rGkn4L8tIcrj+ZLEohykhQKBJFlqqHtFVKcnoJuSJ3pPRFpqr07TKtiRueeYMPZtI25NHbgRmxt2+5JHwk+CxCXstawJLPY6F8wKpU1xhCKx0KeZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBdXFyvl; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBdXFyvl"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-406630d3b17so20444655ab.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409556; x=1758014356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb4hP+ZrX6Bm31wsjEO0F6F6E6Ew6VaYtFpDjRLO3zY=;
        b=OBdXFyvlYRBdsYmOfgMGVA1I/hwgmfHSu4mCxky1gA7XcnoPldnUVH9e5lK2UoAKd1
         pdhrQfQ3QHK+c0K0CWOBXwM9gKLzXGmh6d1ghVIdq9cgT4/cs5wReKEzfqv7HzfDd4AI
         6Mzo0BS1L2pEixP/7fQ+iwlWhDEeJ409vOZ+V6xKgY7mVDdtu//tdB6rK2HKPNDN7U/r
         +mIzMGNqYxSf8v67fSyN7IbtX+bHBh7gQvL0y7JMP9gfcxTjk1030RjqxOuUrMDUZ8Gz
         upf6LCLFl7ubIRDdSy2Vesqhh8bgfRQE1TBvK5YIXDvQ32M9V/Y9fzEozaEVilSyM8AD
         kfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409556; x=1758014356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb4hP+ZrX6Bm31wsjEO0F6F6E6Ew6VaYtFpDjRLO3zY=;
        b=rC6EnHU7cEFIWPRKvo6ycxBSmdbG+YZkS9DoR8/9gpGWt1K2/w2SkHyI+/EN48+25+
         KXtf2EMAQuzi6dHe4lWooC8tTuVFGSBEUlqYg6gEzxOnvasgZWLiIgpmA+9sfyb36YF7
         3+MKF4QJBNZt2NzLR+Tdnp2H76stu643r5qXshvRTllxwFle/0iqKQ6B/PGjBFT2fj28
         s4QzdnXk/Zxes7G183kGpnE6PHJxa+GQUVVfqBAIkXSeJNZF/6WtMvMdvYDfgJKTeaqR
         uDxTI5wfrLExLt7S2Jy3q4GUiAorkW2+IhFAHPPofaGkj6pghJajiQPK8ZIexSovyvm5
         0xUA==
X-Forwarded-Encrypted: i=1; AJvYcCVD8LNBC+YiR3S+joIYKSR9UPh4PvmDXamkDgjsXG20t0NjRceIr5ifbJyxGPWWuHkKpJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJoXJ21yHjhVFdcfFjbZN+tyd1Ci6ldOKWZDUVz3dI0vr9Z/J
	CmAqsJstwnVYXI36+SuY3/G0cBrcR5NmXbWOvWjvGSHztKxyHuwLi/tH5ndpVZH8SNBsdvf6Q4E
	RwrkpqEnALO2rf6QM4/3GEAx8dJ/zlHk0bqxbftg=
X-Gm-Gg: ASbGncvgVsnHWD8WcDlkJ29G2287jP4imcSSGr7zHDKcl4Tb4zMgF6XOftPMTYkHGRN
	03z0dpVYCB9L4naiZoTk6nW1Jvq86PZBzUxzcrRekX3auMH+Pj+07exPtO7nYwHU23Wvsume2XN
	TFms+WsO8ffrjeRNwQmWP9PA29qy7/VW7hfNpMtmkQa0svaSXHZEiSiAo52faZD3fHGKHqGSSf4
	HpafR6HQfzLKA5eywFKlVHRoaaFAU0NxjCcHgTkc94zvZ986Q==
X-Google-Smtp-Source: AGHT+IG4Ow1Gbh3FWqNqOE6uenf2y0FoOFtO05cvYIapVXtVs73BNv1lqIum/JK+wjUsjQg3Wwm2jZ24dvU7+muebso=
X-Received: by 2002:a05:6e02:3788:b0:40f:7f8e:610c with SMTP id
 e9e14a558f8ab-40f7f8e6265mr42479855ab.3.1757409555701; Tue, 09 Sep 2025
 02:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <CABPp-BG6A_mwxQheE5ED5HQj7STVtf1_9NhSmjmzRPB7QkdWyg@mail.gmail.com> <CAP8UFD3GU5Xwq7WMihmHtpWc-GjB-guTU6JHG7BdkhxukMihNQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3GU5Xwq7WMihmHtpWc-GjB-guTU6JHG7BdkhxukMihNQ@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 02:19:03 -0700
X-Gm-Features: Ac12FXxtDEury8kuY7w-F2ZHpCCrAOFYEP7zLfEDcIm_VRk3lo8TsaledjU7f6Y
Message-ID: <CABPp-BHWjyRv_f_HKkz10Q_cOZKPvpgf=SEUR1ThmbttkQT+Uw@mail.gmail.com>
Subject: Re: [PATCH 0/2] replay: add --update-refs option
To: Christian Couder <christian.couder@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
	John Cai <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:47=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Sep 9, 2025 at 9:14=E2=80=AFAM Elijah Newren <newren@gmail.com> w=
rote:
> >
> > On Sun, Sep 7, 2025 at 9:36=E2=80=AFPM Siddharth Asthana
> > <siddharthasthana31@gmail.com> wrote:
>
> > Seems fair...but why not make --update-refs the default and add an
> > option for those that just want the update commands?
>
> If this patch series had been sent a few months after `git replay` was
> introduced, I would have been fine with this series making `git
> replay` update the refs by default while adding an option that only
> outputs the commands. Unfortunately `git replay` seems to have been
> introduced in v2.44.0 (Feb 22, 2024), so more than 18 months ago. So
> even if it is marked as experimental, it's perhaps a bit late to make
> such a relatively big change in it?

I don't think so; we marked it as experimental much more prominently
than other commands -- in the .c file, and three separate places in
the documentation.  All other commands appear to have only been marked
as experimental in one place and never the C file, so this one is four
times more experimental than any other command.  Plus, the worry about
it being set in stone and the need to make it malleable was *exactly*
why the requests were made to be so much more clear that this command
needed the flexibility to change
(https://lore.kernel.org/git/CABPp-BFrVfGHOrBk7g=3D4TkGxDv=3DoSqF1FOkhp6WVb=
xUV-2yveQ@mail.gmail.com/).
Plus, it's currently only used server-side, so it'd probably only mean
GitLab (you), GitHub (me), and a few other users would need to update,
all of whom should be aware of the warnings.

We could add a config setting to allow defaulting to --no-update-refs
or whatever we want to call it.

> > > The way it works:
> > > - By default, it uses atomic transactions (all refs get updated or no=
ne do)
> > > - There's a --batch option if you want some updates to succeed even i=
f
> > >   others fail
> > > - It works with bare repositories, which is important for server oper=
ations
> > >   like Gitaly
> > > - When it succeeds, it doesn't print anything (just like git update-r=
ef
> > >   --stdin)
> >
> > Seems fair.
> >
> > > This should help with git replay's goal of being good for server-side
> > > operations.
> >
> > I'm slightly confused by this statement; there's multiple ways to
> > interpret it -- various antecedents of "This", questions about whether
> > you are saying git replay has one goal or you are just helping with
> > one of its goals, and leaves to the reader to guess which part is
> > helpful (is it the ergonomics -- why does that matter server-side?  Is
> > it the atomicity?  Then why did you also add --batch and --update?  Is
> > it something else?)  Perhaps this sentence can be dropped or
> > completely rewritten?
>
> The way I understood this sentence is that `git replay` is already
> useful on the server side (because it performs all the operations in
> memory and doesn't need a work tree), and the new feature added by the
> patch series reinforces this because atomic operations are often
> better on the server side.

You often word things well; I like that sentence.  The original makes
me guess and wonder whether something like that is the intent; can we
replace the original sentence with your description?
