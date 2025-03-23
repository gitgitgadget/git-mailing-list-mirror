Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE01AAA1D
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742693889; cv=none; b=TsQ/IIIakTyNcFP+BDlT/B8BNxPDfjIRzcjHd9vniIVKpw1x0IBe7jfe/jObH+wzniqHygpeyjhZ73KEtn7ausnqfQHLa/BQ4wCm3s4OAbmC6BNdyzYfSQ1AIVIZk2BeBvigdN4Xg99vw3UY/WU2kI0vWRdlhAm2l7CErWDArFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742693889; c=relaxed/simple;
	bh=7Vlscg7tiwxLdx+sUyD6G/Myw6nwsuanl6g+wvUbBjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocaIr/I/jWf7WjTauYuP8VFhr5cjH6AUTchBIGdT7/LHJ2c1suBXS8RWcSt6gVaQ2yjTuSkABB1RD+kOwWBPwJqQJIpjwDJ2eTVv3Ir3c1AbaNql1m/XhBKEbmvRhIKeLLJ1Q34h5IhvKgxXJSqtRuKHkUIE7qGUMFkteFRsGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6eb2819468dso3796706d6.0
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 18:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742693886; x=1743298686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qwwfwwyicjCNIYDszE4bqfi3WUKfLVS8hQD8xgYkeg=;
        b=Oi+4euJqsa4X30IolnlyhihfkHDXTjhyHDWpbNfjIIKGKT23PzrIwjVdj/f28CUIcv
         JfEyDdPXWLvaMWFDYImytFJqZMg2OX4NMr4Rju88CDYjtPaA3mFMIcZc69WlULTncsMl
         +RgC3QrBXa5Xqzl1f+JtOv40wokXuF8ioHAoaL8FuL5Av43w62oJYTE+ec40MD5HGp/b
         ng4iUbTp5oQqnHc4HxL+SNWlia32gMIBaQXUbClCD0Dj6Os7M32+4kJoH+ZF9sGOo0Dc
         5/p7NwGX0/imeCbjPuJ9dwVGG3i2FIH5yg5gjIazhMiRQOTEa2V1vXBJ5b8vaerZXDSq
         L4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWaFdb0vxIAMArltmpehpDtdSlUSyHBcjoW5qkpf7b86As/MLBs3dZ+snRTKNovUEXZl8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytKq3bwnwuAnTlQ71Imv4lVfP/vIRdYkWyxNF5QQowbkZyEao
	aIiNhmT4DKGXpctWHCHuxYjN2M4nQxzOOh7GBo2y7jf4/yINBC/0o9FonNRfAAINROUssJY1bZt
	DstTlOdVI87XMbWwBHBAqGiexQJAtpcdB
X-Gm-Gg: ASbGncumL/+x7vtBYJK4ljDib9oecrPQXTi47swZBD+ubQ7ovnqsfMhXiz1dvtgwCmC
	27/aZs7Dh9lznXlMKaLBB3iPjhyy5lI1Mdmu5D4xCSgTwfaw8tv3rApX8vAO8K6m5DhOcly518m
	emKBMGdUWFLw8bzi7JIntwOW/5cAszdj2gdXE=
X-Google-Smtp-Source: AGHT+IG/+PkBmU00VRKXs6aGA3Kt6m7hLr/LHPsoY/FXl7CRqrkEhcNtyNCiH6cg8YnSRcT+IfpZKly+TWpCWOIBp04=
X-Received: by 2002:a05:6214:20c1:b0:6e8:f701:f6d8 with SMTP id
 6a1803df08f44-6eb3f1b6dffmr45677166d6.0.1742693885645; Sat, 22 Mar 2025
 18:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
 <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
 <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com>
 <20230320170158.GA2614670@coredump.intra.peff.net> <CAHp75Vf8bB8o9feJHe4FpNo0TnfoRLG+C0roD4a1OaqN3NDj-A@mail.gmail.com>
In-Reply-To: <CAHp75Vf8bB8o9feJHe4FpNo0TnfoRLG+C0roD4a1OaqN3NDj-A@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 22 Mar 2025 21:37:54 -0400
X-Gm-Features: AQ5f1Jpyd5S9yorAXbX7vHu1Kv3vRupBplJZsgZafffzFIkwkCaH-qO8TcMDSrA
Message-ID: <CAPig+cSswzF_Z9TsNEVi59ufdhwfZ+aN=NBmW+AmLwD2mFg8Pg@mail.gmail.com>
Subject: Re: git rebase issue
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>, Olga Pilipenco <olga.pilipenco@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 9:43=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 20, 2023 at 7:02=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> > On Mon, Mar 20, 2023 at 02:10:38PM +0200, Andy Shevchenko wrote:
> > > > > With the new release I have got an error
> > > > >   fatal: 'netboot' is already checked out at ...
> > > > > To work around this I have to split the above to
> > > > >   git checkout --ignore-other-worktrees "$branch"
> > > > >   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase"
> > > > > which makes all these too inconvenient.
> >
> > Running "git log --grep=3Dalready.checked.out" suggests that it may be
> > b5cabb4a967 (rebase: refuse to switch to branch already checked out
> > elsewhere, 2020-02-23).
>
> FWIW, the last couple of versions (since I was not updating Git from
> the sources too often, usually once per half a  year or so, I don't
> know the exact version which fixes it to me, and I don't want spend
> time to find that, because it works :) of Git seem to work properly to
> me. Thank you to everyone who made that happen!

This was very likely fixed by 78a95e0d80 (worktree: detect from
secondary worktree if main worktree is bare, 2025-02-05); see [1].

Regarding the attempt you cited in [2] in which you removed
config.worktree and disabled extensions.worktreeConfig, I suspect the
reason you didn't see any change in behavior is because you didn't
re-add "core.bare=3Dtrue" to <repo>.git/config.

[1]: https://lore.kernel.org/git/pull.1829.v4.git.1738737014194.gitgitgadge=
t@gmail.com/
[2]: https://lore.kernel.org/git/CAHp75VfSdth4B-oW8JCt4kBkehu6+B9ueQAJL1g99=
Ev3RiMKoQ@mail.gmail.com/
