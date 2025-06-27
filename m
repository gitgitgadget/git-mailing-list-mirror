Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EC20D4E3
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051774; cv=none; b=Ksk7hy8z8BOCwpWIeS30ASCObiWDJv5ozql1OggyLS73eebP4JhNlhqAObv/Fw+/Nm/lDqi/Qe2AXrb4ajNx0Q4yhd6Dm/kWMyRXjfN3xUgoeIga31yxRoHvRZ1aowcmrMTlA08JObgeYmOn8jFPGiAd+TS8vYP5xNbDWx9fWRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051774; c=relaxed/simple;
	bh=4Z3Vcqkg7jR2YXuNSo9eIpETM81t7MYUWxqvPsVxTlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orGhJX+voNyNSUrTVUmwwDtJo6l/2saB2x5IlxBEJ6E3zRkdTX2f1dHROQ/x1iVY5B16jCYPnn9sVYi4QFUYWncKJamcOe82u2Fzt1FSUcjk//owPYrv3ZIZK2EH/DtCvjLBsG1GZyp/lwA4PhCQx6SxH6eoY3n+P9UIzdDEtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0lkHROL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0lkHROL"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae35c447234so186978066b.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751051771; x=1751656571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z3Vcqkg7jR2YXuNSo9eIpETM81t7MYUWxqvPsVxTlM=;
        b=U0lkHROL5x7up1Wn9G7E1KXrSrNPyR2o/U09z2cV2WAtck6KUyC/zd718amw8qTG+4
         xIo0JUlCAZXUtX1Ad5HDVyVLuJDIhCEihyDF7U/flQ93+FJDOpo2jYrJAWxLdqdZkpx6
         6vGJg7N+mrac9uMfmFhvf0IA+/TtrxMN6BToazXRKeWDE908Yqqk+Y2Fl8EFpsrssW5M
         sXZvIKwOCfz080nXE9PheGBn+59+24mu0b0YyaYBobAs7nzHP5Sb0lCrLrtGbP8yLFqg
         rapEchv7MDY7bdXm7qRIvTPapgIwM6jPOUJLrO5nf8b7eG8FalLqUeUNZYORMfPI7KS+
         +mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751051771; x=1751656571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z3Vcqkg7jR2YXuNSo9eIpETM81t7MYUWxqvPsVxTlM=;
        b=AxcjFw8mNziaNt2yoxCbCCzF7AuSpKHeizIXTWgJCskzvEVxcljrTA//2pI6DhFtLF
         xr6cd2x8t0e5AfxITlpTzsZTnxbZozKPJwTBN4F7ZX8YjE3fVxxyVFxNIExZuEgxc/hU
         neE+pUoq6k4iwZ5gqlL85ozT+e6pfUPtdcAl9ePn5CW43I9neaNbamKirBgX1GlvzOtg
         gTBwbJmaX5Ul1BCm75p1NoiaDKJwRh81nk7IFlNJy/6EGNPzgTYD/H+jiuQR58aSkMm8
         tZtgyk3Zj0y/IXMfSUaC5juT9h5ekOBdG918TT8r0iNlNDaq3Ucxy+9whQGHPkauthm0
         HDxw==
X-Gm-Message-State: AOJu0Yw/v1akWhZqRLZgksouRrbYzGHJWZQu/LSrdV41gZU/3N0wZv8W
	mL5FZjB8/xzmnq7gJugKHh/K3QvYauM3JWryPaYvae9xA4Q+IfVJZSZoafYt5v0yMoN677rnNTe
	8SwaGIHJhft6fAwRJ9BF0PmOoQjMZhePLSU5G
X-Gm-Gg: ASbGncvUBB3oQa+6bIx8a/MJAaAZkxLD6IDnCQwVdAhf31VMHC2AqESGzPmp/xklv8Z
	0GcX0Yj4zED7IokbanN38VghF2CbsnZS/mMUFyfyEL0KqppYiif7CKDjlCPN1BcM39YSRNKiGhp
	GLZU523tWbwe+kNylgjuZCdybgf6fWbQpUEsSHk94eoUw=
X-Google-Smtp-Source: AGHT+IEcEkaboy1HXqjAYlDwsvaMhHYwSfT4cNomNQz8tWXUckk+YVCzp9zIJgj6kahBQCVKwe0lGF6kDEYS4GMEunI=
X-Received: by 2002:a17:907:608c:b0:ae3:6dc7:1ac3 with SMTP id
 a640c23a62f3a-ae36dc71cccmr1822766b.15.1751051770888; Fri, 27 Jun 2025
 12:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAUd64333fEMHAaNW=-CkfUMN4HDFF2v==HdO0OFnOgm+W+Jog@mail.gmail.com>
In-Reply-To: <CAAUd64333fEMHAaNW=-CkfUMN4HDFF2v==HdO0OFnOgm+W+Jog@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 27 Jun 2025 15:15:58 -0400
X-Gm-Features: Ac12FXyWNiX28ftu1bcf1XvZY_ggP8pHyuAsrL7z_fCsFI0ZTOI6Si7zuCjZPxs
Message-ID: <CALnO6CB4voTTQZrg5OjgHOhuVP4_B71f7LuNFeHNYby4kXOu4A@mail.gmail.com>
Subject: Re: [PATCH] completion: new config var to use --sort in for-each-ref
To: =?UTF-8?B?TmVsc29uIEJlbsOtdGV6IExlw7Nu?= <nbenitezl@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 12:22=E2=80=AFPM Nelson Ben=C3=ADtez Le=C3=B3n <nben=
itezl@gmail.com> wrote:
>
> Hi, I'm attaching a patch for the Bash completion script, to be able
> to change the default implicit alphabetical ordering used when
> returning refs e.g. when doing "git checkout <TAB>"

I keep meaning to come back and review this, and then I see that the
patch is an attached file and not sent over plaintext (which was
necessary because the GMail web client breaks patches). Perhaps you
could submit your patch via GitGitGadget
(https://gitgitgadget.github.io/) so that submission is in the
expected shape for this project?

>
> I wanted the completed refs to be ordered descending by committer date
> i.e. --sort=3D"-committerdate" because that shows on top the branches
> I've been recently working on. The completion script didn't allow to
> set a custom ordering from the default alphabetical one, so I'm
> sending a patch which adds a new config var where the user can set
> their desired custom ordering.
>
> I've not added tests because I'm not familiar with the test machinery,
> hopefully this is still useful.
>
> Regards,
>
> PD. I send from Gmail web interface because git send-email for Gmail
> requires 2-factor authentication and I chose not to enable it.



--=20
D. Ben Knoble
