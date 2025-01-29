Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9E190661
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158129; cv=none; b=j5ir3CxSpjBCuaIEWh+QeEqFqEnHDscXNLY8EMtt9GCjYMkl/Y7Wbn1anIwH8g2Gi9p4t4Y4O0EK8WCJoKBCAwRKxeXg4RIH6b+Yivc4KI/KjO3zExMuZ5LW6fY6hKYCpev6YJDNpeNCuuFs2+LbwZBux9vNzuLMCO0Fpx78ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158129; c=relaxed/simple;
	bh=mziGLJ+cRFdjCskH+iIokjT3YUd5iaJXlw17qlXq9IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohssS1fKcKESRqmvGyxZyMLNiXpTStztybb8T9uj9yJPDauUEx/5NNBS4zwDGZhIK0Hy98hr+tS1ZkKU4GP9CvvpZaIkdiiUmiSETyqrKzW1ef3dp2XZ/8xbGwAv8pqYMOL+LuOlAMeEj+wHmfCqDL38f6gyGqkSYTbkF5YGS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8983825a3so6237876d6.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 05:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738158125; x=1738762925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8BfXPl+y4fWgMBn+sfkjqLPQlnU5iG5kcoQ1Ichwh0=;
        b=t7pxxyyO6YvviQIMCzMgRR1Zeg9s4L1Y2p0gUzXNz/MlDp108t8adNgLY357tXexfK
         rKLEQ5pYjzTv0T0OA0UWquuD7G3yQNSsfD+T4G0dSgj/r546YGQDKMX4dCbvyIkR05Z8
         3Ab3RxcAL9O3LvoZIk53qRnU9BqN1N6T7OeUqRMBNGt+GGxYiwwiMCVUIMmAjf/q9hET
         xbkqCxvDExSvhzZyEGHsl+28zUNH0v6dNPVuNeoBW1zXGAsj5aVmC6503gqFpy2VPSLy
         kQSzAUZW9p9+dX9VYWCQjy51KxHEGG+VmI7JKmRTuSAR3GbHo2G9EAMCwWKu0Lna/H7n
         ayKA==
X-Forwarded-Encrypted: i=1; AJvYcCWL3wq0Z6DEXPdYAGda4fIF9I0EaSmmFaGSgrZOq2k05OS8BkD//wign/CTtlmjt8aZ1sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCe1PSZC2xu6eVVxol3AXrEfrqPPkBbqE7lbXIA8QAox3yHm8E
	WTz64rA2Zr0Jepthjzu+ggD9wtPJwf1mPZdx7gnTMrcdD1rQcAd6ecAhmvfVOCLdhKIqgJM58hn
	XAjOUnl8FmZN0BoXupg75IlbvGU2XFhEG
X-Gm-Gg: ASbGncsh3i4qgC58PxD/IKomXOqrfzHEWvS81qiwDXztJgZvsh2bmNn6xA44EPZwGBZ
	po2rn6CAX848MRpUCbd5lRE9k7WZ2P4MedJCQPbUez/cNtcObkIdp9pJP/XiYXV41bLDQZfWbk5
	jn0as13QRZgcGzppiFrRtjQNKGIC6S
X-Google-Smtp-Source: AGHT+IG7ymDcbLiAvSleC0HQkfVTb94BM6B/Ts5DGpiyTxyxWhQISFb6AvWCEgtU1F7ahJdHVTviEPOEci/qvgJblJ4=
X-Received: by 2002:ad4:5aec:0:b0:6e1:8300:54dd with SMTP id
 6a1803df08f44-6e243c1d758mr19127946d6.3.1738158125146; Wed, 29 Jan 2025
 05:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
 <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com> <CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
 <116C27A8-EF7B-42E1-9606-815FDA3CF94C@shopify.com>
In-Reply-To: <116C27A8-EF7B-42E1-9606-815FDA3CF94C@shopify.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 29 Jan 2025 08:41:54 -0500
X-Gm-Features: AWEUYZnjF_OGB7_biXBhP5UHWZbqQsKHD_LiQcLyywAaAs-IsLk7xUf7umciPFY
Message-ID: <CAPig+cSdbjzTmsBOmFnMxzYLGrUzY46=mkW9S+si2KxLhS623Q@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: detect from secondary worktree if main
 worktree is bare
To: Olga Pilipenco <olga.pilipenco@shopify.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 4:45=E2=80=AFPM Olga Pilipenco
<olga.pilipenco@shopify.com> wrote:
> > On Jan 19, 2025, at 3:30=E2=80=AFPM, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > On Thu, Jan 16, 2025 at 4:35=E2=80=AFPM Olga Pilipenco via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > I found that I had to dig around a bit to fully understand the problem
> > expressed by this commit message. Perhaps adding a bit more detail
> > would help? Here's my attempt at rewriting the above (also in a way
> > which is more idiomatic to this project):
> >
> >  When extensions.worktreeConfig is true and the main worktree is
> >  bare -- that is, its config.worktree file contains core.bare=3Dtrue
> >  -- commands run from secondary worktrees incorrectly see the main
> >  worktree as not bare. As such, those commands incorrectly think
> >  that the repository's default branch (typically "main" or
> >  "master") is checked out in the bare repository even though it's
> >  not. This makes it impossible, for instance, to checkout or delete
> >  the default branch from a secondary worktree, among other
> >  shortcomings.
> >
> >  This problem occurs because, when extensions.worktreeConfig is
> >  true, commands run in secondary worktrees only consult
> >  $commondir/config and $commondir/worktrees/<id>/config.worktree,
> >  thus they never see the main worktree's core.bare=3Dtrue setting in
> >  $commondir/config.worktree.
> >
> >  Fix this problem by consulting the main worktree's config.worktree
> >  file when checking whether it is bare. (This extra work is
> >  performed only when running from a secondary worktree.)
>
> Wow, your explanation is so much better than mine.Thank you for
> =E2=80=9Ctranslating" it for the world :) I=E2=80=99m still trying to get=
 used to
> the terminology used in this codebase.  I=E2=80=99ll steal your descripti=
on
> for sure (if you don=E2=80=99t mind).

You are more than welcome to use the proposed commit message rewrite.

(If you want to acknowledge assistance rendered, a Helped-by: trailer,
preceding your Signed-off-by:, is the way to do so. Or not. It's up to
you.)

> >> diff --git a/worktree.c b/worktree.c
> >> @@ -65,6 +65,28 @@ static int is_current_worktree(struct worktree *wt)
> >> +static int is_bare_git_dir(const char *git_dir)
> >
> > Nit: I wonder if a name such as is_main_worktree_bare() would clue
> > readers in a bit more?
>
> I was about to explain how I wanted this function to be more generic
> and handle all sorts of bare and non-bare cases - whether it=E2=80=99s th=
e
> main worktree or not. However, after seeing your comments and after
> revisiting the code, I realized that generalization doesn=E2=80=99t reall=
y
> provide much benefit here. It is much clearer if we're explicit that
> the bare check in this case is only performed on the main
> worktree. I=E2=80=99ll update it in the next version.

I see. When reviewing, I was wondering why the git-dir was being
passed into the function. Your explanation above answers that
question. On that note, in addition to renaming the function as
suggested, for clarity, I would probably go a bit further and pass in
a `struct repository *` rather than passing in the git-dir itself,
just to make it clear that the function is checking main-worktree
bareness of the repository in question, as opposed to merely checking
bareness of any arbitrary directory. (At least, I would find the
intention more clear at-a-glance with that additional change applied.)

> >> +    config_file =3D xstrfmt("%s/config", git_dir);
> >> +    worktree_config_file =3D xstrfmt("%s/config.worktree", git_dir);
> >> +
> >> +    git_configset_init(&cs);
> >> +    git_configset_add_file(&cs, config_file);
> >> +    git_configset_add_file(&cs, worktree_config_file);
> >
> > Genuine question: I haven't thought too deeply about it, but do we
> > gain anything by loading $commondir/config here -- which is shared by
> > the main worktree and all secondary worktrees -- considering that it
> > was already loaded and consulted by the earlier is-bare check before
> > this function was even called?
>
> This function determines if a worktree is bare or not. I want this
> logic to work even when it=E2=80=99s called from a different context and =
not
> rely on other is-bare checks (that are a bit confusing tbh).

Agreed about the is-bare checks -- and indeed the entire Git startup
sequence -- being difficult to digest, however...

One reason I asked the question was due to concern that future readers
of this code may very well wonder (as I did) why $commondir/config is
being loaded when doing so is (apparently) unnecessary in this
particular context. The question is especially pertinent given that
this is a private helper function with a single caller. A second
reason was that, over the years, a good deal of effort has been put
into optimizing Git's startup to avoid doing unnecessary work, and
this appears to be unnecessary since $commondir/config would already
have been consulted by earlier checks before this function gets called
(assuming I'm correctly understanding the code-flow).

Anyhow, we can probably punt on the question for the moment and leave
the code as you wrote it if you feel strongly about it or if you think
it is clearer this way for future readers.

> >> +    /*
> >> +    * NEEDSWORK: the_repository is not always main worktree's reposit=
ory
> >> +    */
> >>    worktree->repo =3D the_repository;
> >>    worktree->path =3D strbuf_detach(&worktree_path, NULL);
> >
> > I found this new NEEDSWORK comment rather confusing the first several
> > times I read the patch. It wasn't until I finally realized that the
> > reference to `the_repository` here is the same reference to
> > `the_repository` in the commit message -- which confused me, as well
> > -- that I understood what this was trying to say. The actual problem,
> > of course, is that the _configuration_ stored in `the_repository` is
> > the secondary worktree's configuration, not the main worktree's
> > configuration. Considering that this patch addresses that problem, I'd
> > probably just drop this new comment altogether (unless, perhaps, you
> > rewrite it to talk about the _configuration_ stored in
> > `the_repository`).
>
> This `the_repository` structure is soooo confusing, took me a while
> to figure out what it is! I would feel guilty not mentioning that
> under some circumstances `the_repository` assigned here could be not
> actual configuration of the worktree object. I don=E2=80=99t know if that
> will ever matter or not, but I find this assignment kinda =E2=80=9Cstinky=
=E2=80=9D
> and want everyone to know about it. I don=E2=80=99t want to change this
> assignment in this patch because it didn=E2=80=99t bring any harm so far.
> I=E2=80=99ll try again to rephrase this comment, just to give a heads up =
in
> case someone experiences =E2=80=9Cweird=E2=80=9D behaviour in this area (=
same way
> the previous NEEDSWORK comment gave me ideas why my workflow didn=E2=80=
=99t
> work and inspired me to try to fix it).

Likely, the confusion is an outcome of the natural evolution
(mutation) software undergoes. The development of linked worktrees and
the concept of a `repository` structure did not necessarily occur
concurrently. I suppose one could develop one of two views (if not
more) of the `repository`: (1) an in-memory representation of the
".git" directory or bare-repository "object database", including all
worktrees hanging off it, or (2) a single worktree's
view/representation of the repository, meaning paths, configuration,
"index" specific to that worktree.

In the present state of the code, the second view is the more accurate
one, so the existing `worktree->repo =3D the_repository` assignment does
make sense without any further commentary. My main concern with the
NEEDSWORK comment is that it implies that there is a problem with the
assignment, even though there isn't. While it may be true that the
entire `repository` idea needs to be rethought or clarified or
expanded, that's a global issue permeating the entire code-base, not
specific to this one spot, which is why it feels inappropriate to have
a NEEDSWORK comment here. So, I'm not, in general, opposed to a
comment explaining the the `worktree->repo` assignment for future
readers if you think that would be valuable, but I am concerned about
giving it a "NEEDSWORK" prefix, which feels misleading for this
particular piece of code.

> Thanks for the review. I=E2=80=99ll incorporate the changes in my next
> version and hopefully it will be good to go :tada: I hope I
> responded to all the comments, it=E2=80=99s a bit nerve-wrecking to
> contribute for the first time (so many rules and instructions!) :)

Understood, and it didn't help the nerve situation when your v1 was
apparently ignored. Rest assured, though, that your submission was
nicely done and fixes a real problem which ought to be addressed. (In
fact, I'm surprised it took this long for someone to tackle it. So,
thanks.)
