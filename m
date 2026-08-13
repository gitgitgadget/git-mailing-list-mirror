Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985943B6CD
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609215; cv=none; b=QT7G607bYb3A1L40KaQTQEwz6X4VLbe/K+6L3qxO471us1aQpuKgPuU5jeP+cRQ4Vh8js+uarF2Irtjz6GEW0LLWDuNMwmLE9joaTW+sb8429Ua25wj0WTXd8Y2i/N8t/tDodC/d7oOZsbKgCfbfwPzRjmV/zT22mU9hZ+NDhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609215; c=relaxed/simple;
	bh=jnjNMfyYbsp0a7r44e/rGmy20i9clb9/wY+on+RHwwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/EC4/xv8yCIBpJrvLJ4qdMCd0K5gwga2aEV6mOP1K4i2iFnah3CBlQfCexPXa42RuHDF6bgSoDBjNTDNPgIq069cjmrI9RE54nzl+laqF7ofa51FQfNdqwmTIzOycg1imfubmBJG+Zw5QANE7pdMubXuGZqjL920iIWD6J/Sis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMFdACjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMFdACjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972761F000E9
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786609213;
	bh=CditgxSPaHF9aJ1dSo0ICEiDLF0xwIXhTm/i1rR2ih8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AMFdACjDif/0F/1rHtmgsctNzR3Z43gshsC4SPHLyumwSdCPXp1W6eaLFjIuKhPmX
	 iuExPFP04A2PPXEM4uWIrkrHq8o3u5QtQh952st08Ugv7umAAh+c638fIXUBEnsEg0
	 /ZEEHPD9sSmTHN+ZI9o1t3Ysj7JzGNW/G0KWvokPl53VtsGfdBLeTBa27y72Kkvwz/
	 t1IjNV67R7I8SA6tqk6xFiTAUSTXFyC6sMEVAQU3Kp5dUtRnZB0PaEaKTo64rMS46K
	 vJufww8j296L8oVQ5yWrFHnqRFlJEEiOS1hpBOsZY6tfYh0kLnaNidBpfquxic/ugr
	 5mJc1W/NP6hXw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so1208487a12.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 01:20:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxvl2gtFY1JG0E+Mh51MHWKf+xTi0djRa4jGmdggMa4I4i+N4gW
	w1x68Pzr32FmMbML8hQvM962sEI+yK+RVBZpFmqujunfN3rg3XqzociYS69LmpSfkGwB0lUzjPt
	xyRz7EY6Wfl5h+gc0r4Q+HAFrV1oFGXQ=
X-Received: by 2002:a17:907:c28:b0:c20:61e0:e3ab with SMTP id
 a640c23a62f3a-c2109e5c422mr146131566b.3.1786609212558; Thu, 13 Aug 2026
 01:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
 <20260806-history_autocompletion-v2-2-7e60f52a1c20@kernel.org> <CALnO6CAssyDe7uOK+G8eZPzu1S6iyn8EiSQGqUHtWgdPcD65xw@mail.gmail.com>
In-Reply-To: <CALnO6CAssyDe7uOK+G8eZPzu1S6iyn8EiSQGqUHtWgdPcD65xw@mail.gmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 13 Aug 2026 10:20:00 +0200
X-Gmail-Original-Message-ID: <CAMZ6RqLAYMSwNK=w=Xh+O==46eQCS=wFgBoUEOtQoBbLrBqd_A@mail.gmail.com>
X-Gm-Features: AUfX_mxpDjh34goFJFPHrxOc3c7zXh7pj4WwLk5k-GPOvpNpiskdEVN2TakqzJw
Message-ID: <CAMZ6RqLAYMSwNK=w=Xh+O==46eQCS=wFgBoUEOtQoBbLrBqd_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] completion: complete 'git history --empty' values
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon. 10 Aug. 2026 at 14:50, D. Ben Knoble <ben.knoble@gmail.com> wrote:
> One other thing, sorry
>
> On Thu, Aug 6, 2026 at 4:36=E2=80=AFPM Vincent Mailhol <mailhol@kernel.or=
g> wrote:
> >
> > The "--empty" option accepts "drop", "keep", or "abort" for the "drop"
> > and "fixup" subcommands. Complete these values.
> >
> > Although the synopsis only documents the:
> >
> >   --empty=3D<value>
> >
> > form, parse-options also accepts the value as a separate argument:
> >
> >   --empty <value>
> >
> > Support both forms to follow the parser.
> >
> > Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> > ---
> > Changes in v2:
> >
> >   - New patch.
> > ---
> >  contrib/completion/git-completion.bash | 13 +++++++++++--
> >  t/t9902-completion.sh                  |  5 ++++-
> >  2 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index 7372e2919b..fe5223b8ec 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2171,8 +2171,17 @@ _git_history ()
> >         fi
> >
> >         if ! __git_has_doubledash; then
> > -               case "$cur" in
> > -               --*)
> > +               case "$prev,$cur" in
> > +               --empty,*|*,--empty=3D*)
> > +                       case "$subcommand" in
> > +                       drop|fixup)
>
> This feels a bit "inside out" to me, especially when reading the other
> completions. I think the usual pattern is to check the subcommand
> first and dispatch if necessary. Thoughts?

The motivation is to have a single:

  case "$cur" in

statement.

After dropping support for the separated option-value form, this is
what the code looks like if we check the subcommand first and the
option second:

        if ! __git_has_doubledash; then
                case "$subcommand" in
                drop|fixup)
                        case "$cur" in
                        --empty=3D*)
                                __gitcomp "drop keep abort" "" \
                                        "${cur##--empty=3D}"
                                return
                                ;;
                        esac
                        ;;
                esac

                case "$cur" in
                --update-refs=3D*)
                        __gitcomp "branches head" "" \
                                "${cur##--update-refs=3D}"
                        return
                        ;;
                --*)
                        __gitcomp_builtin "history_$subcommand"
                        return
                        ;;
                esac
        fi

See the repeated 'case "$cur" in'. Note that it is not possible to
have a wild card *) in the first switch case unless the
--update-refs=3D*) dispatch gets duplicated. In the end, by using this
approach, one part of the code will need to get duplicated.

On the contrary, by dispatching the option first and the subcommand
second like this:

        if ! __git_has_doubledash; then
                case "$cur" in
                --empty=3D*)
                        case "$subcommand" in
                        drop|fixup)
                                __gitcomp "drop keep abort" "" \
                                        "${cur##--empty=3D}"
                                ;;
                        esac
                        return
                        ;;
                --update-refs=3D*)
                        __gitcomp "branches head" "" \
                                "${cur##--update-refs=3D}"
                        return
                        ;;
                --*)
                        __gitcomp_builtin "history_$subcommand"
                        return
                        ;;
                esac
        fi

we do not see the conflict and do not need to repeat any of the switch case=
s.

> > +                               __gitcomp "drop keep abort" "" \
> > +                                       "${cur##--empty=3D}"
> > +                               return
> > +                               ;;
> > +                       esac
> > +                       ;;
> > +               *,--*)
> >                         __gitcomp_builtin "history_$subcommand"
> >                         return
> >                         ;;
> [snip]


Yours sincerely,
Vincent Mailhol
