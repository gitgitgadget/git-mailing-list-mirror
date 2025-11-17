Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B61F5437
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392550; cv=none; b=YCOnr9imwMtQ+3RyLOfgFF87U/CFDL7u+XUK8pTghQtQF/9946N4GTeeTfLpWWOy8MPx3UGN4Gps+RFS3oI+PHrRvHhSCaIPQP6sVhuBlxrJGpx9oL17rOGo29YQM26GYFhXBvdSBCZDDJqIeGsVd9M0+6j3eC/vSh7MJv/PJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392550; c=relaxed/simple;
	bh=2phLoXFHDaV5gX4T0QIoNcb+ytJBu2Tjxbr1AAZBBnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DSyHufr2KA15NHEJWjAQFmhrDMWzp8vGFvnIz+LhEwQ8mfwUN2Trb7hLL54fiA3LSjNOPWN/yK33XxuBgj9u03yK2veP8AcGZqxjOiLaIHXw6TJrjknNDZkTJhxP33dzih1Vmht6YwWTtRv9kB9opaRhNHOgl/p+BNfM3tYkiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5LWTLvL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5LWTLvL"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b73669bdcd2so558528166b.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 07:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763392547; x=1763997347; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4DylljI4wiGlt5fuwbJ2qUAcc4ovYgfu58F+I85OTI=;
        b=c5LWTLvLQs/eBat13haMIfFHmxvsvi2QGPRrjOrt+T27KgNwp+w9Wy0NACc2QYVpTA
         bJHdDRHRLzZPK0FbcUchJBjKs1GR+G1jHKTHgYWTx6PsiJpDudO+qH0Jebixp8V/Nhes
         QJfF5SkWliW0/RkcV/QyvOyKUWO95cQfq4kdqyOeFILmb0j9HorPBIY6uj9k5tCOmc+f
         uwvItqftwoAXyrME77xaDx1Z52Z4uZrUNT1EXavwYNPs4xWnpFxX20c09XEE/PUB9V3m
         9j4QmtyYTygZWQ27pOuP4zZPQZnjxAYumv9g4vY/zxIW+QkJU91Ax3fBy+Hs/BqFGz1x
         Ritw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392547; x=1763997347;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4DylljI4wiGlt5fuwbJ2qUAcc4ovYgfu58F+I85OTI=;
        b=IgR8l+LfK6rYR4qIzRfm8nH9uIEe6LZ92WXkukHhRFphEtsgl5ujPof7hxK/x/7kfR
         SeCabBRDo0ImE+viefbAcQppuL4w1SMrh/I4Y0MiKBAiSffz8vvmaaAndBcXvF0p2i0m
         LW+72mmzJcsPPw1gguyVC0KqRywDBBIF/Mn/a7179pV9kNwyWgVjZqJzm2oAhXe9cddO
         RjFE1bBslUZl++to34Pyx1agFpWrTwHdm4i9JUMiPprxIvyeEn0CyBhSz+9RbrNc+Wl9
         GpxEqXugCRIkY3QAHxcODNHcYjY7oB2gg50uv3zmuQdvM/KSkgCMJxCTBmASTuVVp/PU
         l7OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdBjPw/lutH0fA+3eULPQmVb+k88eUn+kNic8RKzrRTWJ8+rInq0/6vXGmTYRBMHWhfCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5YTz6pS1lxK/BdBkWCfBWaVhnGp0W776dJr1Mu6DP+2bFLD6y
	Sn1dm/4HYaZP1SQQzEsMWGaNXoS+OB2+fhuzAFb5Rv2N5WOz7rkVIiOQ6UnC1PpYjh9visD8mJJ
	MPRyRRj66D4Pj7h5h1fU+sjaGQPt0998=
X-Gm-Gg: ASbGncsrldjXVrF2l59/es07UTvTPCw+zaWAnXjgtVyEwPF68P+q0ZpPfjeZrzWJVRo
	5VMauJCDmj0v6QQUF8td1KzkJlmXiHxz5zND8Gyc2EFzdZiXwEqwgYm5IfrvAQQDO7aH/npVtur
	5SkIor3QpFhqAroli+kkjBBO1YsBP2GnBr/GBT2jojLR3jjTs1j0wCvXGLzS/V6XsirCnI/2d+y
	uSoTJOZ2SMUBAZLgj2kopT0qZ1omNQcW+rFBdsl3FFzV/NNZcR1lJnz1/KHx7PesEoTwM+/etih
	Gp6k+q9iAkvvNzrXy2HZwSw=
X-Google-Smtp-Source: AGHT+IGQcdJczgnFMwD7hyKjb1KqYm0EDUEQDOVL0FV326uW6TJZC8Jc/6hGzOr7inX7SNneJ/W4et6tZfFRuS8R2pE=
X-Received: by 2002:a17:906:3e0d:b0:b73:7d96:5c97 with SMTP id
 a640c23a62f3a-b737d966533mr708106666b.34.1763392546637; Mon, 17 Nov 2025
 07:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <CAOLTT8TPrNTCjHwJfdeei+t8+7AxGC-dvbq-4oHJ=qNn_c+-jQ@mail.gmail.com>
 <7d99f00c-3602-4b28-8efd-4780cad41ca8@gmail.com> <CAOLTT8TLEsSAcfUomoActrUSzje5mQNE7EweXh8WtY3sOfzfkg@mail.gmail.com>
 <aRpMW-g_rt4jStnu@kocurkovo.cz>
In-Reply-To: <aRpMW-g_rt4jStnu@kocurkovo.cz>
From: ZheNing Hu <adlternative@gmail.com>
Date: Mon, 17 Nov 2025 23:15:34 +0800
X-Gm-Features: AWmQ_bl9RG1nvfMis6IqAt6ElzakH1KsnN1J0O9nw9PJxhrO_s0WU5vsp6RcAeE
Message-ID: <CAOLTT8SOSV48PA-4F3QuHTJQNB_O=Ne8G8JmRTg_uvBypjFeJw@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: Matej Dujava <mdujava@kocurkovo.cz>, ZheNing Hu <adlternative@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matej Dujava <mdujava@kocurkovo.cz> =E4=BA=8E2025=E5=B9=B411=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=80 06:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 12, 2025 at 11:58:02PM +0800, ZheNing Hu wrote:
> >Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=
=8811=E6=97=A5=E5=91=A8=E4=BA=8C 22:38=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 11/11/2025 13:01, ZheNing Hu wrote:
> >> > Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=
=9C=8811=E6=97=A5=E5=91=A8=E4=BA=8C 00:50=E5=86=99=E9=81=93=EF=BC=9A
> >> >> On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> >> >>> From: ZheNing Hu <adlternative@gmail.com>
> >> >>>
> >> >>>
> >> >>>       This patch introduces the --committer option to git-commit, =
providing:
> >> >>>
> >> >>>        1. Consistency with the existing --author option
> >> >>>        2. A more convenient alternative to environment variables
> >> >>>        3. Better support for automated workflows and scripts
> >> >>>        4. Improved user experience when managing multiple identiti=
es
> >> >>
> >> >> What's the use case for the same person committing under different
> >> >> identities? We already have a config mechanism to set different
> >> >> identities for different repositories but I'm struggling to see why
> >> >> someone would want to create commits under multiple identities in a
> >> >> single repository. For scripts it easy enough to set the relevant
> >> >> environment variables if a tool wants to create commits under its o=
wn
> >> >> identity.
> >> >>
> >> >
> >> > I frequently need to distinguish between different user.name and use=
r.email
> >> > configurations on our company's internal GitHub.
> >> >
> >> > The current problems are:
> >> >
> >> > When I misconfigure (which happens occasionally), git commit --autho=
r only fixes
> >> > the author part, I still need to additionally set GIT_COMMITTER_NAME=
 and
> >> > GIT_COMMITTER_EMAIL environment variables to fix the committer infor=
mation
> >> > These environment variables are painful to use, requiring manual set=
up
> >> > every time
> >>
> >> I'm afraid I don't quite follow. If you are amending existing commits =
to
> >> fix them up after you have corrected your configuration then they will
> >> have the correct committer automatically when you run "git commit
> >> --amend --author=3D..." to correct the author. If you are committing
> >> before you have realized that user.{name,email} are misconfigured then=
 I
> >> don't see how "--committer" helps because you have not yet realized
> >> anything is wrong.
> >>
> >
>
> Hi
>
> I use includeIf pattern in a config to separate identities
>
> ~/.gitconfig:
> ```
>   [includeIf "gitdir:~/.local/src/personal/"]
>       path ~/.gitconfig-personal
>   [includeIf "gitdir:~/.local/src/companyA/"]
>       path ~/.gitconfig-companyA
>   [includeIf "gitdir:~/.local/src/companyB/"]
>       path ~/.gitconfig-companyB
> ```
>
> then each
> ~/.gitconfig-IDENTITY:
> ```
>   [user]
>       name =3D ...
>       email =3D ...
>       signingkey =3D ...
> ```
>

This does indeed appear to be a very good standard,
but unfortunately many users in the past and possibly
even in the future may not be aware of such a good practice.

> >You're right that after realizing the misconfiguration and correcting th=
e
> >repository's user.name and user.email, running `git commit --amend` will
> > fix the committer information, but the author remains unchanged. Users
> >then need an additional `git commit --amend --author=3D...` to fix the a=
uthor,
> >which does work but requires an extra step.
>
> For just one commit, after you fix identity (update .git/config or move
> project so includeIf uses correct config) then `git commit --amend
> --reset-author` should get right identity for both commiter and author.
>

Ok...

> >
> >I see your point that this becomes more cumbersome when dealing with
> >multiple commits. In such cases, users currently need to use something l=
ike:
> >
> >```
> >GIT_AUTHOR_NAME=3D"..." GIT_AUTHOR_EMAIL=3D"..." \
> >GIT_COMMITTER_NAME=3D"..." GIT_COMMITTER_EMAIL=3D"..." \
> >git rebase -f <target>
> >```
>
> In my test ^ (using 2.51.2) did not set specified AUTHOR identity, but
> using:
>
>    git rebase <target> -fx "git commit --amend --no-edit --reset-author"
>
> is close to rewriting commits with new identity, but this will change
> both dates (committer, author).
>
> If --reset-author is not used but either GIT_AUTHOR_* are exported or
> --author '...' is used in a -x arg, then author date is kept untouched.
>

This does look like a good approach indeed, and it should
pretty much meet the user's requirements.

> >
> >This is indeed tedious and error-prone, especially when you want
> >to quickly fix and push commits to the platform.
> >
> >`git commit --amend --author --committer` or a new `git rebase
> >--author --committer`
> >would provide a more user-friendly workflow for correcting identity
> >information after misconfiguration, eliminating the need to manually
> >set multiple
> >environment variables or run multiple commands.
> >
> >> Thanks
> >>
> >> Phillip
> >>
> >
> >Thanks
> >
> >ZheNing Hu
> >
>
> --
> Thanks,
> Matej
