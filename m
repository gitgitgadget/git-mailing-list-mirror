Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5D32720A
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392711; cv=none; b=OhyFvGy3kaUSSyAr6JOhKlgffDjDFvpReiADCu35fW/m4PFHVKyo1z1EpOdEf9pw1xIDgAAYpVYzZuL0WoxEHJmDbdNDQQo0lyLEb+7B0Lu2sIk1fB73HOtONMDCnk2MitgYEmrbyfHsVWrR048HR0CBZJ63ihPxqFUKpYJyw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392711; c=relaxed/simple;
	bh=0aeXE/EGn+ITbImVc5Bjj4RrDkREooVgUaKAj1NPTlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IooAtnju3DI8qwL6TyuNLXWLyh7cfEjeWAj7pffkI6tCGAc5KPL9XsGXHrEYJrerkLEjo+xeC2qkiT/fxQJXTKvfbNjXYJDdlpWnbrQM39+p7O75BR4xRDAjYAHj08g4NxlsMulxortJGG3dycJgVFzE+VhTXdc/g2llLQ/tN3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7d3F5Qh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7d3F5Qh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b736ffc531fso506675266b.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 07:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763392707; x=1763997507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag9fVoQTJldeaU6zJPZWYqAN8hB6fsKsEtUrMzdR38s=;
        b=f7d3F5Qh6qBd0zeE2XNLX1oPwoaKk+yTbXxTiLCWtnMrkpx4QnSsNWH4vcEUXRYtfT
         0jv1CWAcToBkjqv7mC2FXwC1dePhGV7VdryeEhGlO57D5MvYKQOVm/O/VN3d7l9/5ivy
         4oPNvvKKEbxWEpcURBZT/oeWH4IizsIkJwOBL0mMebrK9kI+7EJ7vQHmqAZBI33H5mEX
         C3bZ4s312OTRSTDpn+JB7vxv/ykHIoU3oEi9d//lt0qJ4stzGQxtRAhszi+9JhSRoYAH
         4IiRit6547zd+tLGXWgQin5CUmx/3ZkH9jMIjIcvcsAXLHHi5OsqqNgCW4Ysn9Dgxtb7
         PbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392707; x=1763997507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ag9fVoQTJldeaU6zJPZWYqAN8hB6fsKsEtUrMzdR38s=;
        b=GeymI5MRzdGJkzp7ctNnMgxAXs2uy3TNz9+/pjnclV1BnaCqKj8IBAOa7t+lWQGUgd
         R5hlhmFIzo9LMsMZfxo7BX1ZWAFvrTaWVP32oOmQbMqwtC2jo7M+2FxTiSftCj1SvZdr
         Wnaz9oWXXXDheasrq6lyoZTQskkAK9COskfk7w0fcVbdor4tUu5niDPtDpJUHPlwhtyA
         Nf7FY1kSCk3iYQB3wCm/MevMEfKaCOLgWY4eOkrySlVzhwgoq26p8IqexSRteqJJSmZL
         XKkDcRYlGkZb7aCfIYxiLxmogTSstHvLmr7LBw/nf3jmmd8f3hgxVrW2qvMslGoE0REl
         5p8A==
X-Forwarded-Encrypted: i=1; AJvYcCV3GXelTu9R8eItlofe8rbFCBH2ycOD1oQv35YACNxA0y8Fk9Afmv/QH4ymdBKEnJ2Gllo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/RzWvIn/LMwpQLeHeVzBxZ1+9ek/B6Y6CpgYHKTuq95IW1K2
	cXUhyw9x0RPHax4HLv9/9yGCRBeybyRLP5sb7TxkA65gOt7lDcFVBv/7d7yQsYRKyh+/MZw6qWm
	TGwMf3DMRaDAvHxH8y861NvbiInygxwc=
X-Gm-Gg: ASbGncsj9kBRgOuEAHPfSwMwsOOHkhdkdS+ut7L24WH7vTuvPM7eqtXzVSq4z9NMtjh
	l7SF5+IJ00kr+N1no0UJElA9K8mdPRZkUNJmSsM7Fd5KpgF6SXwd/DD00xheYCIUallMHaIOsSd
	QT3JVciCkZuXzkn915ppuwdg6k8gcEeTxcivqUR85cHSPv9VMc2+4PK3D19ANiqi0eLbkftcQs+
	OZD/sR6BmCeU2EgewKwY3EcBLz/tZvjZASNNVglKL0KcF2CHGsiTJ/u4nS0I1MD7zGHos2SBcYD
	6ziFO4jyazvqzFYofD9dbsk=
X-Google-Smtp-Source: AGHT+IGsN/5sEg5JDiRHbt8HMkM+K80kcuTqryILi/37DOzyz+XWrxWrInPZzfkbgXJ+JUGg+ryifX07TvpISs9TmUk=
X-Received: by 2002:a17:907:1b0a:b0:b5c:753a:e022 with SMTP id
 a640c23a62f3a-b7367836dafmr1362246766b.29.1763392707441; Mon, 17 Nov 2025
 07:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
 <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com> <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
 <aRpMW-g_rt4jStnu@kocurkovo.cz> <10ad6161-8d9d-4e07-ab62-105adac2220d@gmail.com>
In-Reply-To: <10ad6161-8d9d-4e07-ab62-105adac2220d@gmail.com>
From: ZheNing Hu <adlternative@gmail.com>
Date: Mon, 17 Nov 2025 23:18:14 +0800
X-Gm-Features: AWmQ_bmuJk0vNH1sEGXLaEfvd0x37sfkAvqygLvY5JrAbkMW1syS5TnWTgJ0DqI
Message-ID: <CAOLTT8QF9JhA-EXbgnZ30m=+T_DP+t+qbJPc1e5WmZaJhy9kvw@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: phillip.wood@dunelm.org.uk
Cc: Matej Dujava <mdujava@kocurkovo.cz>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=881=
7=E6=97=A5=E5=91=A8=E4=B8=80 22:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On 16/11/2025 22:12, Matej Dujava wrote:
> > On Wed, Nov 12, 2025 at 11:58:02PM +0800, ZheNing Hu wrote:
> >> Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=
=9C=8811=E6=97=A5=E5=91=A8=E4=BA=8C 22:38=E5=86=99=E9=81=93=EF=BC=9A
> >
> > I use includeIf pattern in a config to separate identities
> >
> > ~/.gitconfig:
> > ```
> >   [includeIf "gitdir:~/.local/src/personal/"]
> >       path ~/.gitconfig-personal
> >   [includeIf "gitdir:~/.local/src/companyA/"]
> >       path ~/.gitconfig-companyA
> >   [includeIf "gitdir:~/.local/src/companyB/"]
> >       path ~/.gitconfig-companyB
> > ```
> >
> > then each
> > ~/.gitconfig-IDENTITY:
> > ```
> >   [user]
> >       name =3D ...
> >       email =3D ...
> >       signingkey =3D ...
> > ```
>
> I think that's a common pattern, so long as one can arrange the
> directory structure so that the repositories for each identity are under
> a different sub-directory it works well.
>
> >> You're right that after realizing the misconfiguration and correcting =
the
> >> repository's user.name and user.email, running `git commit --amend` wi=
ll
> >> fix the committer information, but the author remains unchanged. Users
> >> then need an additional `git commit --amend --author=3D...` to fix the
> >> author,
> >> which does work but requires an extra step.
> >
> > For just one commit, after you fix identity (update .git/config or move
> > project so includeIf uses correct config) then `git commit --amend
> > --reset-author` should get right identity for both commiter and author.
>
> As you note below it also resets the author date which might to be
> desirable.
> >> I see your point that this becomes more cumbersome when dealing with
> >> multiple commits. In such cases, users currently need to use something
> >> like:
> >>
> >> ```
> >> GIT_AUTHOR_NAME=3D"..." GIT_AUTHOR_EMAIL=3D"..." \
> >> GIT_COMMITTER_NAME=3D"..." GIT_COMMITTER_EMAIL=3D"..." \
> >> git rebase -f <target>
> >> ```
> >
> > In my test ^ (using 2.51.2) did not set specified AUTHOR identity
>
> Indeed, rebase sets GIT_AUTHOR_{NAME,EMAIL,DATE} when running "git
> commit" to preserve the authorship of the commit being picked so any
> value that is set in the environment when running "git rebase" is ignored=
.
>
> > but using:
> >
> >    git rebase <target> -fx "git commit --amend --no-edit --reset-author=
"
> >
> > is close to rewriting commits with new identity, but this will change
> > both dates (committer, author).
> > If --reset-author is not used but either GIT_AUTHOR_* are exported or
> > --author '...' is used in a -x arg, then author date is kept untouched.
>
> Yes "git rebase -x 'git commit --author=3D... --amend --no-edit'" is
> probably the easiest way to reset the author and committer.
> >>
> >> This is indeed tedious and error-prone, especially when you want
> >> to quickly fix and push commits to the platform.
> >>
> >> `git commit --amend --author --committer` or a new `git rebase
> >> --author --committer`
> >> would provide a more user-friendly workflow for correcting identity
> >> information after misconfiguration, eliminating the need to manually
> >> set multiple
> >> environment variables or run multiple commands.
>
> I'm still not sure why we need a "--committer" option when the committer
> identity is taken from the corrected config anyway.
>

Well, if the `git rebase --fx` approach is simple enough, I can also
give up on introducing `--committer`.

> Thanks
>
> Phillip
>
