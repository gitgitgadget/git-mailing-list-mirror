Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32227738
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947853; cv=none; b=isWarvYydlfNLsCoR4Y26bLt4W4Z6bhQNSTYm/iw/NfVGw/dePbBpy9lI4Ml14OhTlxGh6QFaU0HABdUblLrn/jmzBXE5iX+u560UvHtU/SuBxlT9i9dvhf4K0eqr3YrXbh0wps1bUi625RT91V/0xLZfoKqQfM9GsMlNenqyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947853; c=relaxed/simple;
	bh=9SSbduz2ekQIJ6ZhI13T1UsDRkeAhHonQV11fRowAso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2qcB5S4ZB3uJCENhj7AEqb7dZpHlEJ3vs2dwEzIZngQ1+ijOwUdS7r/Z67naIOT+ve9T43+obPvSeTPFh2Eqry53KaeqiVlL3VTg6sytezuOpZbc5jXZtUQ/TMrT1rsiOGEsAwXhx2m6a1X9nhwhQrOy0Otl5Rt9b1HEO9A3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhfdpN2K; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhfdpN2K"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fac7147cb8so62812966d6.1
        for <git@vger.kernel.org>; Sat, 14 Jun 2025 17:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749947851; x=1750552651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvnW3XM1tMktALBjX8lh/TPORkySULLCgJWAR6UAQLU=;
        b=lhfdpN2Kj2WgCrbh1CTxNavKSDDJD5suFHd0ZojFAsKsW3s7Ii3UfGqgEwAUQ5T+ds
         7rPtwvuDH+f59WMqicu79JFLerUuBsYOyYDsZoXsxf+1ih8pJZroT5GgDIlWkaGn1/kL
         knJiseWjcOOS/EwXf68W7szwWB9YvKPY1vShTui34YEj3NXd09o6YMBm5RMIV1CQYAbR
         BM8nqiEaHLkB/gfPM3aIdjeeKBx6gYPNLI/O9WgYhdF+ZNT5DWT+cZCCubQECZY8Iv5x
         M0YIHdQhujzaB2y4t0Gx0im0qbvijPDgmxiaQQDbKtTFdzY90CDGsLc6pIJeKStVw2HL
         XG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749947851; x=1750552651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvnW3XM1tMktALBjX8lh/TPORkySULLCgJWAR6UAQLU=;
        b=pEs83oUwiQhdnhA5xKVpRMnGoFhywzLHrZDNpa4sf+IV2Ht0uwxLwXyUMevhFRHf3B
         oL0Y7EWLJgTgrpWq3b9tFW+v80tdYvxxyZcr9B2ygDjtsZ+ZBmE4yTKve/1z5JCrDohH
         f10K2kDqwizE48FGAd6UjPgGP0mI/o1V/bFFVOzyBGtD0Uultfg8Wpz5k5SghCplcMtK
         8SD2nhtLkkTY/qip9MZ+oZ9/KfZhrh+vH4KvVRGsjKMdEM1rd7EXazbymRF+/NTVI2w3
         /0Q4VC/dFkKFI7TweFwfRgiDPoau9bOYttib2QTibNZDqiKX7YUabP+onrEDLRzjyxuI
         eTJQ==
X-Gm-Message-State: AOJu0YxtprH9/qUooyDGt/kh1FrIm4KkkwwihG2eBYeQwOPrGIr2/OQv
	hbuwDtDLXlf9htM6z+WG5Ze3BGr4jKjbvNXYJmfsWgJ/WiWosklnfjg0TRVsPdsCDKuIqVCSf6y
	g9Q9U1W/9wafim/Xph/qb3vn2sa+kAqGGrg==
X-Gm-Gg: ASbGncuNWM311KFIE0FTx1l2ztC9ezpeV7KIY3w3rSj+Re+1z1nuC+TT49XqoQoNB1D
	ZSa3J7aIy0WwQsuNzZ7vipbmxa0H4hwoD+lXSrwXmdXHbuViB/61Cdgzir2U4UX3Wn/P2FjiBk6
	IXcHuK3/eTxpvGCO2BnFPbiUwXDAbyaNj8hOQbwLwLmng5gbrwBfUhSFBCW4LFPHglEz05RGB49
	H4=
X-Google-Smtp-Source: AGHT+IEgnC/15IRvwH1yIc8Psa82l906uCItFm4tVOUzlQF7brWUx5DZjYeuuO28bU0JAuuWcmIIuEfYrGCGzh877f0=
X-Received: by 2002:ac8:57c4:0:b0:4a4:3b41:916c with SMTP id
 d75a77b69052e-4a73c4e31e3mr67974281cf.17.1749947850844; Sat, 14 Jun 2025
 17:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
 <AF617F39-7B22-44A3-BF08-D21CCFBEBD20@gmail.com>
In-Reply-To: <AF617F39-7B22-44A3-BF08-D21CCFBEBD20@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 15 Jun 2025 06:07:19 +0530
X-Gm-Features: AX0GCFubbzDyqkiKx9x3QbZIm1zhzUo1lukVoHpTbgfrWPMB8NOLAMtAkrTNRRk
Message-ID: <CA+rGoLcKfWYYSc-ORC9pCsUzsqketFdfVruwTC0Q06+BN5Gb7w@mail.gmail.com>
Subject: Re: Question: regarding understanding code base
To: Ben Knoble <ben.knoble@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 5:56=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
> > Le 14 juin 2025 =C3=A0 08:44, JAYATHEERTH K <jayatheerthkulkarni2005@gm=
ail.com> a =C3=A9crit :
> >
> > =EF=BB=BFOk so a couple of weeks ago, in this thread[1]
> > Junio advised that one of the best ways to understand git is to go back=
 to the
> > _inital commit_ and travel back to the latest ones.
> >
> > And I happened to quite like this idea, cause I still have to dig up a
> > lot of things in git.
> > The main question is
> > What are the best and smallest set of git commands to do this as
> > I can set this up as an alias and use this trick for many other project=
s too.
>
> If you want a checkout of the root commit, assuming there=E2=80=99s only =
one, something like
>
>     git rev-list | sed -n \$p | xargs git switch --detach
>
> ought to work. You could feed something similar to git-worktree. But it=
=E2=80=99s a little harder to =E2=80=9Cgo forward=E2=80=9D with Git=E2=80=
=99s data model, and I didn=E2=80=99t totally understand =E2=80=9Ctravel ba=
ck to the latest ones.=E2=80=9D
>

By _travel back to the latest ones_ I think I should have said travel
_forward to the latest ones_

But I meant to incrementally get to the _latest commit_ from the
_initial commit_
