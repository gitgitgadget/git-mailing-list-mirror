Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547D47CC80
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628716; cv=none; b=Dy/0ahqTEk4puYynfI86vgPNH8VmtBqIim9NZygx5pmzTpZyoACliCn8+vVJiRx8dojUhlqmgTsUXtSWV6I9IWGyaVNG3/qg63L+RnSLoNdWxThCgrLy5tAkgdUIsLX5yJjnhIDZ2rVJIyV8tgKDq7okziML5j+p+eYBHP73OmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628716; c=relaxed/simple;
	bh=5Y5MXsSr85wVsQrT7rZSeQT7+z1Wzg/59QQLN3wr5gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsSXqK+jPEWg+4NMh1iakA2sL0wJjsa8ZNtBYm9UIxQmdScIAH70clDRk6C3uV9oPlV3zazkgLgLq5tkHJ7IJXlwVyTVBiew+38gbe+mpzDcGXbzTS9GpquE28blBSakqVw5b0OKHj8HghUGEV1Hmu/6FKcVUtmIaRnbmPaoKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePNHTHeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePNHTHeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1981F00A3F
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628715;
	bh=G2/u4LeydePazXsn7t0lVu7q+P+T6yoR8iKgrsdqt+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ePNHTHePW0aSoyesZYu0b4U4undtxh8E5/ceu2gzs0nBbDzx1L/V5kKGcfyR2TW9v
	 RS73L+6RQIz7RpmTFU4lt28Cw+PjLXrcxrLMtt+iHNz7WiKGuD2v+S7/I9EynwnO7j
	 4Qj+z7PU3xXFuWjyC4Q5B72Z79+qF1jDg4UKe4iDp0GHebZAVbVc7G3SMp8j5b2K5T
	 H7dnqGccefBfHu9FPHw1zZFhFfszb4LR7/O3qdmcGjYMqPIiBmXCxurU8LXQl4MH9w
	 e6TufAczHiBnvwkF9M+G0CMMqMA5OnMoEteLopho0o5eZOewDKkFkpJIJdS0rSXWHv
	 KokHd5zYcVcwg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso240954966b.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 06:45:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YxE5rkDNy5AEMLFRi+8qoH6T7SfQX/z6DQA2vst+7qwHyAfitIF
	pz+07IcZ0pxolIBjro9lc832XrGVklZ9TIzujK/7x5n/3laWaP2OuRmLU0EFs9QiKeGumoKpqSF
	w/xuwKvotUQu5WL0X/wt8BqDCojSlomg=
X-Received: by 2002:a17:906:fe0e:b0:c12:67d2:3d6b with SMTP id
 a640c23a62f3a-c2108e729abmr296121466b.11.1786628714537; Thu, 13 Aug 2026
 06:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMZ6RqLAYMSwNK=w=Xh+O==46eQCS=wFgBoUEOtQoBbLrBqd_A@mail.gmail.com>
 <00E5CBDB-7D2A-4117-9A52-FD5C64A9838C@gmail.com>
In-Reply-To: <00E5CBDB-7D2A-4117-9A52-FD5C64A9838C@gmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 13 Aug 2026 15:45:03 +0200
X-Gmail-Original-Message-ID: <CAMZ6Rq+mBKHE=mNd9QQOWfpuDQwcMK7qZ2jn1tTPdFJEkUrGOQ@mail.gmail.com>
X-Gm-Features: AUfX_mxu4F27FJbnb-Szu_vzaPlJFG7pjN7S75EA1rruSA5JSyh3thyrpxC8jAU
Message-ID: <CAMZ6Rq+mBKHE=mNd9QQOWfpuDQwcMK7qZ2jn1tTPdFJEkUrGOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] completion: complete 'git history --empty' values
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu. 13 Aug. 2026 at 13:12, Ben Knoble <ben.knoble@gmail.com> wrote:
> > Le 13 ao=C3=BBt 2026 =C3=A0 04:20, Vincent Mailhol <mailhol@kernel.org>=
 a =C3=A9crit :
> >
> > =EF=BB=BFOn Mon. 10 Aug. 2026 at 14:50, D. Ben Knoble <ben.knoble@gmail=
.com> wrote:
> >> One other thing, sorry
> >>
> >>> On Thu, Aug 6, 2026 at 4:36=E2=80=AFPM Vincent Mailhol <mailhol@kerne=
l.org> wrote:
> >>>
> >>> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> >>> index 7372e2919b..fe5223b8ec 100644
> >>> --- a/contrib/completion/git-completion.bash
> >>> +++ b/contrib/completion/git-completion.bash
> >>> @@ -2171,8 +2171,17 @@ _git_history ()
> >>>        fi
> >>>
> >>>        if ! __git_has_doubledash; then
> >>> -               case "$cur" in
> >>> -               --*)
> >>> +               case "$prev,$cur" in
> >>> +               --empty,*|*,--empty=3D*)
> >>> +                       case "$subcommand" in
> >>> +                       drop|fixup)
> >>
> >> This feels a bit "inside out" to me, especially when reading the other
> >> completions. I think the usual pattern is to check the subcommand
> >> first and dispatch if necessary. Thoughts?
> >
> > The motivation is to have a single:
> >
> >  case "$cur" in
> >
> > statement.
>
> I now suspect this is why some use the =C2=AB case "$subcommand,$cur" =C2=
=BB variant ?

IMHO,

  case "$subcommand,$cur"

is not very elegant. Sometimes, it is a good trade-off, but here, it
does not seem to be the best solution. Of course, maybe some future
changes in git history would make this a preferable option, but I do
not have a crystal ball to predict the future.

> Apologies for not thinking of that previously.

No problem :)


Yours sincerely,
Vincent Mailhol
