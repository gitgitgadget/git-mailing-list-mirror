Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E118C01
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWlrB3CQ"
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD3DA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:39:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50906f941so67941111fa.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698683960; x=1699288760; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyTyNpQqGVS66Q4UlekDQhhGNx0aDoyQ6UwNWZGl5d0=;
        b=DWlrB3CQjTtX6VLGnLiQHnI7S0DLFbteFkVZetQv6phqedk2ougV/RPKRieZ4YXokX
         PDJusRcs51rgH6QhzDy2Z9VN2T/LR9CwfNuacsAcNYaWkoX1fXaTwhAtVF5rddCSCcMv
         RVbdkvwBIC0q2cnQXwvH4l+34798CQFJnEfV5gzfghgVeRFaKc4UznzkIMtZlRk1zU/0
         qH69MkCtMXD8jQLYrMS+kpCxXuNnSIEoKpa0uegCD9a/BYWvsgYQFDMiTy13p+oAo0q7
         51P3pG22pyDeaOcND437Aobycl8Fplvth9EOhGwrQVlX9WSBFq4nWT/mx8wbMmq7aJ+v
         9hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698683960; x=1699288760;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyTyNpQqGVS66Q4UlekDQhhGNx0aDoyQ6UwNWZGl5d0=;
        b=T0+3uHtK0HHwiLi9PzUr0Eq/ytFloAcYb8q/lewRCMwlReB21BvkF762qA98B+FGlR
         qRzouAqUB18wmuYDQ/Ep/+0BLo7efuf1rUB36dRyOuUiJjrO4jcdMXzNb/eaZIEDx03J
         4n+3UrUkGPWIMBeyTfOQxoPV/LRbMKWIWME+trARS18Q6qcOpmvpNWX9ma3GGvoS/aQf
         WFMe1HLuNxTSEV/lRLXS6leMfZh1qHw4mwgnDwpNSIQHAZVBrxFbLoXQfg+Bw7SC977O
         5clqI85l5WRtw6bQlmXbZAk3ukJL48VZ7gDRzr1wAz9E2oEUmBogPjwGGJoTdbTaOqRp
         OiuQ==
X-Gm-Message-State: AOJu0Yzz1SrDHtjduek90VkmxBCugXGSdNtI6kFfsiS1vrRSThvVtI+G
	/SAVQZUtmBnXzqcH2yn1mbdGn7RcYQYJIKkbtbs=
X-Google-Smtp-Source: AGHT+IHZn2eWWUBaRynHMThGoLWUKWp23w/Ztj2W+yzMN7BZ2KzxEVZeNPFMAkiyM6iMtva3rqOmVm6n3xxgH3UIEA4=
X-Received: by 2002:ac2:4423:0:b0:503:2e6:6862 with SMTP id
 w3-20020ac24423000000b0050302e66862mr6825588lfl.32.1698683960190; Mon, 30 Oct
 2023 09:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231024195655.2413191-2-sandals@crustytoothpaste.net> <CABPp-BG9Y6aZ+TWdkL4QE9e12fu3n61V16G6DLtawEDe=g9F4w@mail.gmail.com>
 <ZT5p0WUw7EeaY8vW@tapette.crustytoothpaste.net>
In-Reply-To: <ZT5p0WUw7EeaY8vW@tapette.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 30 Oct 2023 09:39:07 -0700
Message-ID: <CABPp-BHWjyaj9Z0Oj5UQdeSSf1hX+4DGCtYgMF+3hpWH7j40AQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] merge-file: add an option to process object IDs
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 29, 2023 at 7:18=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-10-29 at 06:17:09, Elijah Newren wrote:
> > Hi,
> >
> > Overall, looks good.  Just a couple questions...
> >
> > On Tue, Oct 24, 2023 at 12:58=E2=80=AFPM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > From: "brian m. carlson" <bk2204@github.com>
> > >
> > [...]
> > > --- a/Documentation/git-merge-file.txt
> > > +++ b/Documentation/git-merge-file.txt
> > > @@ -12,6 +12,9 @@ SYNOPSIS
> > >  'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>=
]]]
> > >         [--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marke=
r-size=3D<n>]
> > >         [--[no-]diff3] <current-file> <base-file> <other-file>
> > > +'git merge-file' --object-id [-L <current-name> [-L <base-name> [-L =
<other-name>]]]
> > > +       [--ours|--theirs|--union] [-q|--quiet] [--marker-size=3D<n>]
> > > +       [--[no-]diff3] <current-oid> <base-oid> <other-oid>
> >
> > Why was the `[-p|--stdout]` option removed in the second synopsis?
> > Elsewhere you explicitly call it out as a possibility to be used with
> > --object-id.
>
> Originally because it implied `-p`, but I changed that to write into the
> object store.  I'll restore it.
>
> > Also, why the extra synopsis instead of just adding a `[--object-id]`
> > option to the previous one?
>
> Because there's a relevant difference: the former has <current-file>,
> <base-file>, and <other-file>, and the latter has the -oid versions.

Ah, I looked over it a couple times and just kept missing that
difference.  Thanks for pointing it out.

>
> > Does "/dev/null" have any portability considerations?  (I really don't
> > know; just curious.)
>
> We already use it elsewhere in the codebase, so I assume it works.  We
> also have a test for that case and it worked in CI, so it's probably
> fine.

Seems reasonable to me; thanks.
