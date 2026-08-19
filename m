Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56D21CC5A
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145014; cv=pass; b=pLEVJnb5gsCz0tAn5a7txBwK6O66BBR6hTmpP6kT3ua2h6GgyRdxzQryxQSDs4slQJc/laBQp+qgAa241HV6cHzGRW8zLkXVdFQlbCV8SPP1aRayxL6Vk0XOL9Rz4RI94otWbRMnmadtvYJhkLmPrTWiYJXyVk1IqxEFWx2Tjdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145014; c=relaxed/simple;
	bh=SWCtaV+K9f/N8VxZe8kP7UoXnGhQty1h+YFVWN5+ktY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFSfuRRE//ZSfhdpTxR04Dnjoie5GVhFbIoOG/0LyJHJ6Ke1IwDT01wjDUbHp1YCFFoWtfBi9gAnwwSy9ogyKZcf0pHU+Fs71faiBHt7za1nluESNaGbVCXDDuK9tOVed1JyoCHqJXrbue9uivP55pSdb8Hjz3Yzc/3RSTEQgAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UymtCWjx; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UymtCWjx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1193050a91.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 06:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787145012; cv=none;
        d=google.com; s=arc-20260327;
        b=ax3dj4y6mFu2+1R6c/h/rE3aCS8ZpGubXYNIktrLUxP/5Q6Hytf03S/h1dm7NJ22BF
         v1Fn1bSU9XZbFsHP//aWK3/9tSSInr85tuh2GdrzEkaR0QutnVAC7mahDyBjacIK2Dle
         skmzSqBrGYERB4LGuZSe/7YUuttwcQxOBpWQNPua3iZ0XazodVmeDFt8YDkqL3E4S3Tg
         x8FkqTUeX1XGnVWs2Adu0G1+Hlq9sv9M+u1kTo4TOS94HKL2xgfO93oQrSbmRnkZEnfI
         JtlR27YEBSQHUnQ7G0Q01fcsOCWPpcwqKgFykdhahAW2NCkEIg5+IlUPasM5AXIVjcUC
         zlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aori1uqsxKVwE2uFuNT/tQfhdzqJQbP9B+CGRPEi1ds=;
        fh=uPjY8ueqdld3roU+rwxQvk+Ploi0wteBv041EUCijpk=;
        b=dJxNn2ticx/eJ5uorKtaFhFU1Dqa4BVqZ6HEXf3YW/KCY3mFSmp925Fb38Vc39NZ/P
         N0PP8NJBdacZ4gu5Z78cnqKz+zuo3g8dDL0ienZA0d8L7katBYY+ySG5fZNACHp8Bt3J
         Sh7jBUhpHI3gvyKWmnEVZYXqpnN0+A3gQnGEvFCoNhB5HwuOH1sEDRVLaErWY058PRn5
         jNW/ivX7TbWDyfYd54F8M6LNbu1MDFdNp8s5SRA6KcuIul+Ghui+LWhk9d1v8HwBFjhw
         nu5IRsa0kl+xbP7IBpacnBRHBwaqfKcdeBCSNzH5swKdO5pKY1ta8SFJX22OGNKXiQox
         zEHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787145012; x=1787749812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aori1uqsxKVwE2uFuNT/tQfhdzqJQbP9B+CGRPEi1ds=;
        b=UymtCWjxrf7p/b2hUzaMEyzqiIe+Tv+RNzFRaFxUD+ZjbyPMsRVinqjmCQDb7+sABE
         3bjg1PxnBlTWcWBPlZeAbOAKdnki+nhPAAFx5qJiCKdPH4MGJfFSPdtx5sxLjB1sdUa8
         Vy6ISmdOTPeGOhzEMyzvyxlGuen7ZM9fX1iS06fupLzfUdSTN3kG8jFOToeDElJH+ndv
         J6nHCBe/IbBFs/qFU3oxLAOTO54Txh/IJIbScJJDwIzAF9xxeREDvuAjfMhiELxwdgRA
         z5j6KRvBSuFhlpdB4FiiyIF3oiz2hHF2yNgrHAJA47NX6aPJHwBb8nDQMwQUGuhi2jCO
         RLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145012; x=1787749812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aori1uqsxKVwE2uFuNT/tQfhdzqJQbP9B+CGRPEi1ds=;
        b=HfgCEflNgTCqn9bgxKC4Zy8CtFpVKMYFmzYZuXi8p6Z6iOxn8qAMR4ikKqbvMqDhsH
         AVtd9G/iCpQQsWT1K0FM7rBT+IJwGVbonzS3RyRi5TzNdPL63d4hKLKOYw+OmWx3sbgo
         YEvjEyFBtsSWBxYyZuNWgey1l8KFq4VNoAs5mjXwXcCyv2GWjiR0XuZPf0yK5tW5ke13
         P5y0uoN+3SWID26r/vmTHgaGGpLLjUJUgWB52el3hsje+UMhMiY5gnFDaZok8u+BAiWR
         hAjy2NHDuiaTeP7cKEi/tL7AckG8yKCJ1SSbg5jynaYi5ZCyRt8VlSloGnwZqb68UIG+
         4iZA==
X-Gm-Message-State: AFuF++mGvR8XsZl6KfCqBV2B8R+g9ff6j/3dz7Z5y8ZlWmeC97noBjOs
	0OLU189HdWiNfjMPdKBH47ZsDNdkjXetmYGMQrmN/+4zV9VT2tV7tzOnvu12JTN6xayRLqPCyob
	O0T86N34dmRgFshz43qHAOX1F6bWjInI=
X-Gm-Gg: AR+sD112OxzNUlAiQNZ4Q7Ag1txks00ZpocrQlIKOHruuMDRs5wRGOQ412Lyvrhmgr6
	r3N+NM3VG2AoKRi3jSgLC9Tw8FcI1UX5pTWdl9y6Z75acx5zRIJa7gRda82n9hUY1+wLnAD9KPD
	Q1NeBjaW0mKNNvw17RuEOttxPH7l+bNVWBgm4M94sguyIzu7uIFgjIfGH6fInPzRXhoBWxYZlIU
	tXRbjWJNjklEcWVsqbir2lCBaZp4YTD0auvSoR6VLVooiH6ZtICPmrn26Bi0F9qRm1iHxA9c1LD
	jfHKMXlzG9RQ0VbJ1XlNj5KcWLPyM3qd9ozxmLou+mcLvHBcndwliqZsT5bCMrTq0Jq5BpXm/aH
	/cIBDeCaDsMI3CM7o+3uQohZlRLiUPHtYLArduU+00tqy7XNOD/rzLnzFA1Yo/+vfL2+BKGGwms
	OmtxPonFzHlH9qu/Ok2l0=
X-Received: by 2002:a17:90b:3bcd:b0:395:4290:46e0 with SMTP id
 98e67ed59e1d1-39580accbebmr9232635a91.5.1787145011583; Wed, 19 Aug 2026
 06:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787065125.git.ben.knoble@gmail.com>
 <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
 <aoVoJ3Ijoaj3u64e@pks.im>
In-Reply-To: <aoVoJ3Ijoaj3u64e@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 19 Aug 2026 09:09:59 -0400
X-Gm-Features: AcwNN1X8uV1wObs5its1WkPsU-eNyBKxL4h4Srdgrkr-rEbW5ONmZcmCWZ_nrpw
Message-ID: <CALnO6CDgfT+VXaBqSmStB8vNOwBpr5XMjvmxhMdc7v-ma-YwXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>, 
	Tian Yuchen <cat@malon.dev>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Aug 18, 2026 at 10:59:47AM -0400, D. Ben Knoble wrote:
> > Racy Git problems persist today, manifesting themselves in the
> > performance of commands like "git diff" in new worktrees [1]. We have
> > long had a build knob "USE_NSEC" to tell Git to use in-core nanosecond
> > precision when available, which mitigates most if not all racy issues,
> > but most builds we know about it don't use it. In part, that's because
>
> s/about it/about/

Thanks; fixed locally.

> > diff --git a/Documentation/config/core.adoc b/Documentation/config/core=
.adoc
> > index 340329edc3..33104444ab 100644
> > --- a/Documentation/config/core.adoc
> > +++ b/Documentation/config/core.adoc
> > @@ -118,6 +118,12 @@ core.trustctime::
> >       crawlers and some backup systems).
> >       See linkgit:git-update-index[1]. True by default.
> >
> > +core.useNanosec::
> > +     If true, use nanosecond precision for ctime and mtime
> > +     comparisions between the index and the working tree (if Git
> > +     was compiled to store it).
> > +     See link:technical/racy-git.html[Racy Git]. False by default.
>
> Should we mentino here that this may not be safe on all platforms and/or
> filesystems, in addition to linking to racy-hit?

Yeah, a brief mention here is probably warranted.

> And do we really want to link to the HTML page here? The user may be
> reading a manpage, so doing so feels a bit weird to me.

See a variation on the grep done in patch 1; we link lots of HTML
documentation in our manuals (including when rendered to manpage
format).

AFAICT, the idea is that we produce manual pages for commands and a
few other "special" documents; we produce HTML of everything. So there
isn't a good non-HTML link target for, e.g., the Racy Git document. In
particular, even "git help" doesn't know about Racy Git. I have a
script [1] that opens files out of "git --html-path", so that provides
one way to access the Racy Git document (aside: neither of my
systems---Homebrew macOS or Portage Gentoo---install anything into
"git --info-path", so that would not make a good link target even if I
knew how to write it). Patch 1/3 makes it easier to get the correct
link in the manual for folks who can click links in their terminal
emulators (or copy-paste).

[1]: https://github.com/benknoble/Dotfiles/tree/master/links/bin/git-doc
(with completion!
https://github.com/benknoble/Dotfiles/tree/master/links/zshfns/_git_doc)

TBH, I am not sure what other folks do for these HTML links in
manuals. As I mention in patch 1, the Homebrew links are broken. If
you know about "git --html-path" you can find the documents, or use
the Git SCM website's rendered versions.

Anyway, this is the current "normal" style for linking, I think.

> > diff --git a/environment.c b/environment.c
> > index 6676e6f5ae..c7f6b801f4 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -571,6 +571,13 @@ int git_default_core_config(const char *var, const=
 char *value,
> >               return 0;
> >       }
> >
> > +#ifndef NO_NSEC
> > +     if (!strcmp(var, "core.usenanosec")) {
> > +             cfg->use_nanosec =3D git_config_bool(var, value);
> > +             return 0;
> > +     }
> > +#endif
>
> Do we want to omit a warning in case the config is enabled and we have
> NO_SEC set? Or would that be too obnoxious?

I would say that can always be done later ;) Perhaps it should be
better documented, though, so let me try that, too.

>
> > @@ -769,6 +776,9 @@ void repo_config_values_init(struct repo_config_val=
ues *cfg)
> >       cfg->ignore_case =3D 0;
> >       cfg->trust_executable_bit =3D 1;
> >       cfg->has_symlinks =3D platform_has_symlinks();
> > +#ifndef NO_NSEC
> > +     cfg->use_nanosec =3D 0;
> > +#endif
>
> Can't we set this unconditionally? The respective field exists
> unconditionally, too.

Yep, see reply to Junio.

> > diff --git a/read-cache.c b/read-cache.c
> > index 6c449f393d..31888f77ee 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -353,12 +353,18 @@ static int ce_match_stat_basic(const struct cache=
_entry *ce, struct stat *st)
> >  static int is_racy_stat(const struct index_state *istate,
> >                       const struct stat_data *sd)
> >  {
> > +#ifndef NO_NSEC
> > +     int use_nsec =3D repo_config_values(istate->repo)->use_nanosec;
> > +#endif
> > +
> >       return (istate->timestamp.sec &&
> > -#ifdef USE_NSEC
> > -              /* nanosecond timestamped files can also be racy! */
> > -             (istate->timestamp.sec < sd->sd_mtime.sec ||
> > -              (istate->timestamp.sec =3D=3D sd->sd_mtime.sec &&
> > -               istate->timestamp.nsec <=3D sd->sd_mtime.nsec))
> > +#ifndef NO_NSEC
> > +             /* nanosecond timestamped files can also be racy! */
> > +             use_nsec
> > +             ? (istate->timestamp.sec < sd->sd_mtime.sec ||
> > +                (istate->timestamp.sec =3D=3D sd->sd_mtime.sec &&
> > +                 istate->timestamp.nsec <=3D sd->sd_mtime.nsec))
> > +             : istate->timestamp.sec <=3D sd->sd_mtime.sec
> >  #else
> >               istate->timestamp.sec <=3D sd->sd_mtime.sec
> >  #endif
>
> I think this would be a bit more readable if we had a single NO_NSEC
> block.

I'm not sure what "single block" means here, but I think the plan (see
reply to Junio) is to make this more readable by not needing
pre-processor directives at all.

[snip]

> There's one more site in "builtin/update-index.c" where we mention
> USE_NSEC that wasn't updated as part of this patch.

Oh, did I miss one? The only spot I saw in builtin/update-index.c that
mentions USE_NSEC is a comment that I'm sure patch 3 updated. Maybe
you were thinking of that, or maybe you know of something I left out?
(That is, locally on this branch, "git grep USE_NSEC" returns one hit
in Documentation/RelNotes/2.5.0.adoc.)

Thanks!

--=20
D. Ben Knoble
