Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCDA47ACC7
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835040; cv=pass; b=k3WdPEJXf/NSf5FVvNi+IoheBhIwmfmiMq5UXhfqmnrL07P5JbHg0XGyRZaxkoZdDwqsJBupHtraOhfmNyr1eDRE1xOE+ae+SNqpR93vr2U3OowUJuZKEvxV69XncseQeAC+7mSauH+x2QmNJ4Y7Cb0MvmIUnv+4aiQ3nzaIf08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835040; c=relaxed/simple;
	bh=yl/xBO17tCXwwrcU4cFbl9jYf7ggd3wi9KowS3e7tMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH9m0bCRpr41Qb8OQsFwDfnlZ6g3MwbjNlIpJuEvYrtxuetrMKssC779vL1HrFvDVb1c1qlTz2DN2CScCzYSpcc654mKNklVKN+6MPW7JiZ+TxW2/DiNwLO9Q2f+VMGoCvfyatHTSCGbopgJeP91i6OSf46pjahyXMRP7WNm1hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS6IWe+X; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS6IWe+X"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93a40a9a01aso925994085a.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791835037; cv=none;
        d=google.com; s=arc-20260327;
        b=sQd3dksm8qC+pFiVluPz+OW5bK/GIDg3NPmBTufh2XzVbzx+Q5dzltiDzth3jU6cYP
         rSM3cSxIeX8mpq90nOGewieDVeGkZ7Q0vZ6rH+OgYKzZlNPag0dn4eeec1SZQoSd0Eg1
         rCN9tDDIpmzdv7oDMRV3cXOTTcXhiiIRcnvAVBSiOB2UcK1hkm/8E03Uof2o8Pio+6GG
         WRxrw0pAsQnd9hW6gNbPC9MWMhqI/NhoPpAmsQN9SxTJa7tgn8eastsGll5gkW2k97Sr
         Os06sCSeLp1UP8Yy0QvwHeTU5NQaeJmu9N64ZeAtoFLxYnt4ECa/6ubNasRIbDdOTeJo
         taHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GE+FlWC97iO59mwj7o4jEIbk0KFevYZ+HefY+6q914=;
        fh=zK0chp51+CLXsy8u1ykdhHQbF+2OcauKpdFxNUjkkw0=;
        b=bKjrRqG1zntX79p0a3FTKfNRQgvT+CRhdmiXsUJ+Qyl0reX98eVoRvckCRKYomam2K
         50R68XXrf9I1Ije68PrQ4fGM1/du0/49kPA13G2ZFhKv1/5TUqVEwlnqpMcumNOUOfzg
         ktPxScpuz96W1G9V5K+L+43mrPQK5+8fOBVc4Y+cPLDtrRazWskhxR2AoOCMJoXywz5m
         XYCfmS0xQah9VPDkCBzSR0PB0emOnsWBGUijz+eIs8rBnau2Atd0q1HhGF4eXAxrpWXn
         UYxLKYNXvrYgE9dHt95NNNJ4sViwwkbe6f6CDPI6p6j5cj6dHIoPnDvnjSYNPFJE78xB
         c32w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791835037; x=1792439837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GE+FlWC97iO59mwj7o4jEIbk0KFevYZ+HefY+6q914=;
        b=KS6IWe+XteRilqmLCs0FEvzuK086JJ0V905ulsrvEhTgc3X08Ke9wfXdexMCefra4N
         EXh2K0IznPgIjspy7Op4fY/q1g8eWCF0teML69EFdcxO4RBoMeGBNDygBw87VtF6JNy2
         jUMZF2aK2RIqbNtCpBTDyf24iqYL+xcDu5ERfNh3vKKPjkt6MCMup9jk7LukBhWEGECJ
         cW8H+1Z9qjNJfBOuv0aokugP/kvmwGda/JaglEtD7UFLuTqhYNslBM5UoSRI2kci1NZf
         s/gpxHM7Y4lJCkk+0/V/zGccyjun+831SgvyJ52xrD/oObtkcrxP7tP5tisjTz4fdRLj
         L1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835037; x=1792439837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GE+FlWC97iO59mwj7o4jEIbk0KFevYZ+HefY+6q914=;
        b=kPIsgkO9ULGTMNvC9cTwbek0vlH2JGwqfXZANnirII0HUY/XKSwJmtz42/Twbwacps
         va3yXc0aKUhTXcn3xdr0DBcdDfUf3bzszbi1nqYYGOgmXq/mtvJHJxtHVp6zedV7TqdK
         Lq6wdAWCHhJvc7crCc2C4Rq47Y1xLFSA5/wqZ9HrtGl5zht1agiqk+5Lj2H8mY7bfi6t
         3AOfztjeP7nYZ8bXtfe5iB/sh5P/2oUe6tgCHkxGAKtofb2+wRbT2AGIjpCObTV9aEzD
         C0kjDR3I524VEZnITCYeLoUnRbVNmctISVZSYEAYyNbwNbyWrr19cP/MLo/eLIBqYft3
         t0Fw==
X-Forwarded-Encrypted: i=1; AKwUvBxxR9vVsOf5RoVCh7Wj4jTb87AZ5zqPftPf44aY+zujY7l1rs9UTa82sx+MaKXEU6nLPNk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVog5ljcCzA24z4gIMTUcG93KEqQsTPxGqTISRrh7+EGo4AEin
	oWrvzM/TTXTkOMyFPLPMp6Coo7RnXZPTJ9m1JBYhzyWsnQqzX0oSSFqhDKpK2CGccdgN6xJyFhI
	vXpLE29rlJxEcFDrKnleagQRLA5MQlPA=
X-Gm-Gg: AYBFou2LILH1jprAmMbF1UFqVWuWNSgLBpI2f3C0HXcBKInI5ZVjqFJYQCjRtmA7okV
	MXpO8qlXcE9r4LsRBwUDmSYpWnKz5hWesifmFvwTtOGNVOEU9vSBnU0hhqL+7cr4P6F72VaoGj3
	Wy1NjNe/gpke2ED5Z0Mxjdo0GhdJnkATLRR9WOyMxXAqRnFKr6iB6Ig8DZEyGd7eZu4yMkSlzIy
	EoxIt3lJRNjutGWm5Jw77tC2shJlSzXjeUWxOWkTkDf2RO00JbRaaW8mr/JtgCPFw2SA7CcoqjW
	+GbOibgPccjkIqDR9Q5d/uxARMIhl9KhDd7aC+RpmZne5GFb/s8X+U7VV7WGPhXE7Vp2pkbD1/Q
	0U/D7PJy/OZ7xr8ZZnUu0Ks8=
X-Received: by 2002:a05:620a:46a5:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-93eb93ee50cmr1737677285a.3.1791835037313; Mon, 12 Oct 2026
 12:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
 <dc7ebb427bedc7318ebbf84c05ecd02063408353.1789269613.git.gitgitgadget@gmail.com>
 <xmqqh5ivyks1.fsf@gitster.g> <CAF5D8-vFCwDjNMRwk4Vkjz9SrRgkQKFW_yYVFLiTNM_sXnMHLA@mail.gmail.com>
In-Reply-To: <CAF5D8-vFCwDjNMRwk4Vkjz9SrRgkQKFW_yYVFLiTNM_sXnMHLA@mail.gmail.com>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Tue, 13 Oct 2026 04:57:06 +0900
X-Gm-Features: AclHuK8-UkavvNUJlmzyAZAbdBIdN_q05_MgTI1UzSXGEzYGF6NGU4JtRDFj4bk
Message-ID: <CAF5D8-siz_USPuW=GEc3LNvSGD_8HXjVcFgr_zUNdYkeRu7Fzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] worktree repair: refactor and reduce .git file reads
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 1:16=E2=80=AFAM Yoichi NAKAYAMA
<yoichi.nakayama@gmail.com> wrote:
>
> On Fri, Oct 9, 2026 at 5:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > +static const char *get_worktree_id(const char *dotgit_contents)
> > > +{
> > > +     const char *slash =3D find_last_dir_sep(dotgit_contents);
> > > +     if (!slash)
> > > +             return "";
> > > +     return slash + 1;
> > > +}
> >
> > This returns a pointer into dotgit_contents; it is the last
> > component of a pathname, similar to what basename(3) gives us.
> >
> > > @@ -798,30 +806,20 @@ static int is_main_worktree_path(struct reposit=
ory *repo, const char *path)
> >
> > The unified diff is a bit hard to follow, so let's see if we can
> > compare preimage and postimage more easily.
> >
> > >  static ssize_t infer_backlink(struct repository *repo,
> > > -                           const char *gitfile,
> > >                             struct strbuf *inferred)
> > >  {
> > > -     struct strbuf actual =3D STRBUF_INIT;
> > >       const char *id;
> > >
> > > -     if (strbuf_read_file(&actual, gitfile, 0) < 0)
> > > -             goto error;
> > > -     if (!starts_with(actual.buf, "gitdir:"))
> > > -             goto error;
> > > -     if (!(id =3D find_last_dir_sep(actual.buf)))
> > > -             goto error;
> > > -     strbuf_trim(&actual);
> > > -     id++; /* advance past '/' to point at <id> */
> > >       if (!*id)
> > >               goto error;
> > >       repo_common_path_replace(repo, inferred, "worktrees/%s", id);
> > >       if (!is_directory(inferred->buf))
> > >               goto error;
> > >
> > > -     strbuf_release(&actual);
> > >       return inferred->len;
> > >  error:
> > > -     strbuf_release(&actual);
> > >       strbuf_reset(inferred); /* clear invalid path */
> > >       return -1;
> >
> > We used to receive the filename of ".git", read it and made sure we
> > have "gitdir:" prefix, and find the last component, but then trimmed
> > the actual buffer.  Which means a few things.
> >
> >  - If the contents of the gitfile were "gitdir:foo/bar/baz \n", our
> >    id pointer found the slash after "foo/bar", trimmed the buffer to
> >    have "gitdir:foo/bar/baz", and then incremented id, which now
> >    points at "baz".
> >
> >  - If the contents of the gitfile were "gitdir: foo/bar/   \n", then
> >    after triming, the buffer would have "gitdir: foo/bar/" and id
> >    would be pointing at the NUL at the end, which would have lead us
> >    to error.
> >
> > Now let's look at the new code.
> >
> > > @@ -798,30 +806,20 @@ static int is_main_worktree_path(struct reposit=
ory *repo, const char *path)
> > >   * Returns -1 on failure and strbuf.len on success.
> > >   */
> > >  static ssize_t infer_backlink(struct repository *repo,
> > > +                           const char *dotgit_contents,
> > >                             struct strbuf *inferred)
> > >  {
> > >       const char *id;
> > >
> > > +     id =3D get_worktree_id(dotgit_contents);
> > >       if (!*id)
> > >               goto error;
> > >       repo_common_path_replace(repo, inferred, "worktrees/%s", id);
> > >       if (!is_directory(inferred->buf))
> > >               goto error;
> > >
> > >       return inferred->len;
> > >  error:
> > >       strbuf_reset(inferred); /* clear invalid path */
> > >       return -1;
> >
> > The caller is expected to give us the contents of gitfile read by
> > setup.c:read_gitfile_raw(), which reads the file in full, validates
> > that the file begins with "gitdir: " (notice the trailing space),
> > removes arbitrary run of CR or LF from the end, and then returns
> > the string after skipping "gitdir: " prefix (8 bytes).
> >
> > In the normal case, read_gitfile_raw() would see "gitdir: foo/bar/baz\n=
"
> > in the file and returns "foo/bar/baz" to our caller.  In fishy cases
> > we examined for the preimage above:
> >
> >  - If the contents of the gitfile were "gitdir:foo/bar/baz \n", our
> >    caller would have received an error from read_gitfile_raw() and
> >    wouldn't have called us.
> >
> >  - If the contents of the gitfile were "gitdir: foo/bar/   \n", our
> >    caller would have given us "foo/bar/   ".
> >
> > get_worktree_id() will give us "baz" in the normal case, and "   "
> > in the last case.  We fail to error out in the latter with "*id"
> > check, but is_directory() check will catch us, as the inferred
> > directory is "worktrees/   " in that bad case.
> >
> > So there are certain differences in error cases, but they behave the
> > same in the most basic cases.
>
> infer_backlink() in the preimage accepts the "gitdir:" prefix without req=
uiring
> a following space and uses strbuf_trim(), which does more than just remov=
e
> trailing newlines. This is more lenient than `read_gitfile_gently()`, whi=
ch is
> called when other Git commands are used.
> I believe the primary purpose of `worktree repair` is to fix common issue=
s
> like worktree relocation, with repairing cases where the `.git` file's co=
ntents
> were manually modified being a secondary concern.
> Therefore, I have adjusted the behavior for error cases: if the file devi=
ates
> from the standard `.git` file format, it is treated as ".git file
> broken"; if there
> are trailing whitespaces, they are interpreted as part of the path and tr=
eated
> as ".git file does not reference a repository."

The former case (where there is no space after "gitdir:") behaved this way
even before the change. repair_worktree_at_path() calls read_gitfile_gently=
()
and returns `err =3D READ_GITFILE_ERR_INVALID_FORMAT`; this behavior
remains unchanged.

Thanks,
--=20
Yoichi NAKAYAMA
