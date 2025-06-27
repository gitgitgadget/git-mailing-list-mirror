Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376AF2BEFFF
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024565; cv=none; b=mWmOvwIX7ecbtTB8uQWTt1KcCv6FLXv+rDG09w/jB4Itgmzsybmw62z/M304FTLqmU5j1DvGuYmouz+yHvhnIgn+RV7ZMiDd5kvxswRqPgwgY9EXMq6o57Ku/DhrpyG4PvZsgRoYKPYkYiOndnNCsfEPOXQDxNzIHgb+xcCFNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024565; c=relaxed/simple;
	bh=jLIyftM34xZOcfaHVcxaH7G1sRasQEVqe6K6pxVCJU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W97rE8VGpiRKO2dP7lEXbzyZuSLOmM/yR5iaaoRhn5miqGAeN+ta5aNu/72KKajl+qtIWR9d38DcZ8vYAI/416hCTL6gHzr3rshrKh9gS1NENMA1gro2t3/mLNoJJ7zTFv/Xhpt3SnZiqVcvR7lcDJIQ5DuYM7X7Xax3rD/2ISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a884clAe; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a884clAe"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so277779066b.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751024562; x=1751629362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulgUzuP6K5iZhE148MqNMFS1VAoWNZFbKvVG/7MZJks=;
        b=a884clAehohPhnnjJW/zvApuKkB/prZhrRV2F50nAZNLmQZp+CpY59P3+tEBJgbMCx
         CwNYLGm1LXm/LGew/f7F+zT5nQnH07E5e65w/bP7nRcziORL18P/xO1RfGPCErlHlyrI
         z1PlZrhPFRhmVXVCehRr2aOD3AryDVnR4vEeCWhJRRAbio0af2hqqPZYT2KXtqe+SFly
         dE5/0Giri1KG/fck8vGF2v1BcXlvBPuHBYAsRYqboPi2AkrjLurUPFh9RTaiQg/PoODT
         ucfabI+cl8N6499cN3EUJt/XoMxZcIVHhKdPgNrGaUBil7bWwv9+E+EKwD6SDAvLiXkx
         yj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751024562; x=1751629362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulgUzuP6K5iZhE148MqNMFS1VAoWNZFbKvVG/7MZJks=;
        b=pXEfdo3+quLIqTIahnp+Vmaby0iiO4oUfVxM3MOY6L+r6KZCFIVaTBgZRimrAhebQ4
         hqdz4L525zsiQ2QM4I/LDFkclRyyUp9Caw/8iG6dOs/TtNApEpIfWTFk4BXsmN5odwcm
         7xpHyKGzmFlQhzppMwOZay0ARq0ZvJBTKNaWWMjBpF+GAQeDE57XB/Q/nblT2V81VDeG
         p3MkYe8h1WN5saQWLCHbuem/NdaZis52KLIPdYncQJA8bN2sve5pHnBF+kiJajL9TOkc
         +RgCYn8LRnir2WGbKuDPkx9QpWw1Sa72EDh9EuT0YDE6HqK1Vhh1SzbR1odrsGOW7AIC
         K6pg==
X-Gm-Message-State: AOJu0YwrG7eEIzWxLCPjXN6Ey1s/swZ5JeFpl0MVy1/jpWlkPbVY4jxA
	Afrs3RJ5jRfkxAdXRiUb/KKDveFsWwd+jtJIRZWg2XG0S4LK6656H+wr1QiXpezFr+CUbJzcq63
	bhF/bxNv2vDX7bDaRaaU/wydWAAC3ndgfxGh8
X-Gm-Gg: ASbGncswQVGufn5wRXFcJtVLtEJ5zZPk713+GtWRUGEAObHUYoI0jhfQ0DwMTGJ8t+E
	eMKhIOVuIWxfwxEWU3QnCr+feet2ryBINMVa4Bc0c+XxpTU+xXBkkwTngHimT0NcktVS/ntKbq6
	5PcudPSGjVVP8StdUOFyyvTDHyd1M+MrDZljIg8w4rGn1SoTW1Xagm08g=
X-Google-Smtp-Source: AGHT+IG63pMQzAsVwxE9B44rtyPjexLsgcFxLnekXXWhxOzaeVBI0w78T7xpASVoY/+6+hCUsCdIbgEUpshQ3xEajfs=
X-Received: by 2002:a17:907:c88f:b0:ae3:65a7:5621 with SMTP id
 a640c23a62f3a-ae365a75f82mr12395366b.37.1751024562091; Fri, 27 Jun 2025
 04:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGt9y=WktE5Tqkxf6_tb_YnaeDyJTGYZoU7vErnSGnZMpuC-Q@mail.gmail.com>
 <073cffb5-7f15-4c41-a7ac-9f8ad1f4fffd@gmail.com>
In-Reply-To: <073cffb5-7f15-4c41-a7ac-9f8ad1f4fffd@gmail.com>
From: =?UTF-8?Q?Denilson_S=C3=A1_Maia?= <denilsonsa@gmail.com>
Date: Fri, 27 Jun 2025 13:42:30 +0200
X-Gm-Features: Ac12FXx9oWHLBG0FFhL17wPuwZgyMcpBkAluLcmgVhs09PwU3J8np1numqomA4g
Message-ID: <CACGt9ym5+YFGMvqN_mnfa8T_+0u3asXWeCrD-SstvQxfmN1aOg@mail.gmail.com>
Subject: Re: git rebase interactive breaks when working on a secondary worktree
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jun 2025 at 11:52, Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
>
> Do you have any line ending or filter attributes set on those files?

Not sure. How can I check that?

I see this on the `local_repo_clone/.git/config`:

[core]
    repositoryformatversion =3D 0
    filemode =3D true
    bare =3D false
    logallrefupdates =3D true
    ignorecase =3D true
    precomposeunicode =3D true
    hooksPath =3D .husky/_

I tried removing all of the options (except for
repositoryformatversion, as I'm scared to remove it).
The bug is still reproducible in such case. Thus, I'm sure it is not
related to these options.

> > It doesn't happen every time, it depends on the commits from both
> > branches. Thus, it's hard for me to give you a minimal reproducible
> > example git repository.
>
> Unfortunately that makes it hard to figure out what is wrong.

How to reproduce (approximate steps):

1. The `main` branch is checked out at the directory `mainDir`.
2. Create a new worktree at `secondaryDir` for the branch `secondary`.
3. Make one or more commits on `secondary` that change a file `foo`.
4. Make a handful of commits on `main` that change unrelated files.
5. Back to `secondaryDir`, run `git rebase -i main`. (The `-i`
parameter is important to reproduce this bug.)
6. It will show a single commit to be picked. Accept the rebase plan
(save and quit the editor).

What happens:

error: Your local changes to the following files would be overwritten
by checkout:
        [It lists all the files changed by the newer commits from the
main branch.]
Please commit your changes or stash them before you switch branches.
Aborting
error: could not detach HEAD


Also, the latest commits from `main` don't need to be checked out on
`mainDir`. This bug is also reproducible if `origin/main` has newer
commits, but the local `main` doesn't yet. In this case, run `git
rebase -i origin/main` from within the secondary branch/directory.

Hopefully these reproduction steps work better. It seems to happen
relatively often (dare I say=E2=80=A6 consistently?) in this large reposito=
ry
from the application I'm working on. But I admit I haven't tried yet
to reproduce it on a brand-new repository.


> I'd be surprised if the fact that it was a secondary worktree was the
> problem. Is the worktree on the same file system as the main repository?

Yes, same filesystem. Both worktrees are siblings under the same
parent directory.

> Is the worktree synced to a cloud service?

It's a local-only filesystem, not synced to anywhere else. (Except
for, obviously, `git push` and `git pull`.)


--=20
Denilson Figueiredo de S=C3=A1 Maia
https://denilson.sa.nom.br/
