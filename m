Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3492DAFA9
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791735408; cv=pass; b=OtHquEh2IIhnSBRymlgOAWhgPzdqb0aVBjZpe8zYLwngXcxqrWaedJxi4fR1HZ9l44orSxbiwqBIR6NMHv7ATq8g+u/Y59yu8IqAK3C2wxgW4EQMkCHKZQXAovVXfimvCdh7NnUexGGx4YhilRAW+YECPJy9b84ctLRHQ71ZRYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791735408; c=relaxed/simple;
	bh=kJRHtzNPGBTdqTNw0TU5CJqg78eNM0t9iO0qcyNUvFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sskM5UK3hhvWGAG4vPEBR5Xis2rGftu57DFU83olVgRvq4nZzn2yYbkscqsij3BmK9q9nHNLAWcx3FXu9XPJnkZt1Nv5yhi90v4hngzbkjWMUE1erfWjqWpw2qDYXEkdZpQd0Pvh+2Vu/FxSYKvGfK8t2668xq7kyzzQ3Kt41Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqgXl3P5; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqgXl3P5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91791ec1b83so11885166d6.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 09:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791735405; cv=none;
        d=google.com; s=arc-20260327;
        b=oicwVVe/ilIHWlx4ejbCpDzefG4igevsBfV0DdEPTMo7kOMIc1uP40RSNEaRXBt7vX
         KnnAyrO5zO4mzyj/Q9uK81yRtddHa4JbwTnfphip+l4VWf1ZWd+NH1Xkd3O0u5KIoydb
         veA7yFvKAnblFC6Hac+vHIumWdm6FF+mpwcLTGHui56eBCS3cIVlaJ6R1RPJLhfuSc0U
         h5rfe+qy49WRDVAwXfgh4PsKxHgeuz6XC7njSaEwU1O3DfFMx42/opRiTU/7AXLV20Pn
         1Jxt3bw1II7cuNQelIIz1QDfzOOHwxmsrN4aS7UP70UaDd9NjGptS+X6h6KEUKHNrp2z
         424w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KyhgnKH4oC+FbciDuJvbkCo18Vt0QHmCfK+xCVCIOMU=;
        fh=z2pDW5F46WwtnIWVrj4rhE7Gur1IzjHnKOYgn1oB4wU=;
        b=JZa4VaEEe13M1vhozZI3ltiKedeoDmuDFJhVTTYJF3LnhXLA1VjxWtEUYR4g8LyVFQ
         YglHFwOaAcFxMJfbRf10tQYsRiy75UoenVDquNQqXB1837Ds1P5JSuqs+E/ZBnwMKwCR
         4Jy52fLrkYW2tQ3BItA3wkQB5e3Yl79pQmB0LgtsUfeIC4xOLXPTDC3dYNYTDonN/1D0
         kuTWI0GZso9r1HurxIH6+KWHOsbmftfIH8pVV2tahrb+7ir8RlJh0ZDx9WJMl8ucxXju
         I7heWOTh6GrnLHEHiUDFheNeiONjI5da5+jRZefDcGQ2awYN4aayyT11+PtsTlNXkvTS
         Xolw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791735405; x=1792340205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KyhgnKH4oC+FbciDuJvbkCo18Vt0QHmCfK+xCVCIOMU=;
        b=XqgXl3P56I+Qz/LXlG1yQHm0CGcKQqDp6B82xnyH/kMJpjLKCdmNsZPB5RFn821xp0
         Vu0Anmltj5MT/JH++V6PHq9humHs6TGT29Om4M3CbcHNMdtY36QNRdfvy34aabJ2VVEr
         jYeDwNJTGauVTwoBonHtK2Sh1EH0w/gyt/Rsrh9qmA+9cJVSO76IFMfwC9Ibp3ENOZMn
         kxOqVnqNRouwLbHA1mCzTDJNKqKKAvW7Zlkrkyp9MtjfDQQjIqgdGLd4VioMHXpDzFgp
         8f6lULktGBjdOCWDfqWGYpA1XODeqG9iYJL0jiaR5hYH1HefMGp4h48f1I/eX2WXfq5O
         rMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791735405; x=1792340205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KyhgnKH4oC+FbciDuJvbkCo18Vt0QHmCfK+xCVCIOMU=;
        b=DM1717tfVHWVcvPNXVDB/PwuW89PD0BNGlzGqSiWIXfFACUX9Eg/t4UaQgyQCTC1+4
         LJLBQoqNwIgjvrmqsRRBrcrlZFufAYaJW27AnRLwuCUrf6BJR8/jjZH2Ke5zeMxi82VV
         6vgdpxpfbOi0h1+0AOgewCweSQP7Qz7abah0I4BpU2TGXGAMUKQD9kO5FO1FEGurlCjH
         I8SuEyvL6+Wvyy1HMvT2xHN2CfIn/uUreQXcpN6hk4L7gI8m3hu0piYOHxHabXdnDZBo
         5GnnFoJhomvj+ur31CcBTv8Ig1Ejge9I6duPYpviGJp+xgeMJr6BG4AufFixiPUqAQ+S
         luhg==
X-Forwarded-Encrypted: i=1; AKwUvByKW65UUIOMmeIVO97v/onBPNzxxHO6yAGRTFtNvfvd8EH0fvbo0m63Pr/QHK1FlryqMjs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9Y57GoTEyrBuX1iXg2cIEnTeamqacqjNA9HWFPCQaljetdtsL
	1SSarrAfiZXf4pljbvY1004hI/tIyxgu5VSo2DVIaYxkRMHk+ZljwC8jxgaC0yQdrFMLhI8PV+B
	OT3d1Xwjb0ieAAFoNxTx2n2XQD2FzTNRc6uaE
X-Gm-Gg: AYBFou0tyB1BqXW4uaBlLgVeCtORSf30lrA0Hm87NRo2PE4PG4hEBjOqAXSn9TPLz4l
	UPuQI1XhmVtpYrQsiMXyCx4DHa0DGGxPJhNxOPF2ngMKQb6wPQ9F/vZ/zWnaQdBeYFvdsIraZic
	ZXl8bT3PyuDoUqqJ3YOjwPAld7FYb096vgOBYOjKeLojmy7etku4yeJFrWXRLjOmtX1Jd5WfW8K
	hXudE6+azRXaPNpgZV9UnlfW8eH+VE8fzKH1l6Hm8frALnEjSO/HnB4AWYZ3UehPf9yDMs7Gvi6
	pACAvYk3URp+s3NPNG//ZaXJsOvXkZcpZVd8OTas0AV9o3dQMSghOcSjahid+Z8arDkvLdcPKbR
	rqnE9sDj1/yG1
X-Received: by 2002:a05:6214:411e:b0:919:871a:412d with SMTP id
 6a1803df08f44-91b5578a9a4mr141678386d6.37.1791735405452; Sun, 11 Oct 2026
 09:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
 <dc7ebb427bedc7318ebbf84c05ecd02063408353.1789269613.git.gitgitgadget@gmail.com>
 <xmqqh5ivyks1.fsf@gitster.g>
In-Reply-To: <xmqqh5ivyks1.fsf@gitster.g>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Mon, 12 Oct 2026 01:16:34 +0900
X-Gm-Features: AclHuK9uffuqFDvYJpNK5iWR5TxFRJnOLH-m_eBYGkC7S8vug5unDM-cLctcv-A
Message-ID: <CAF5D8-vFCwDjNMRwk4Vkjz9SrRgkQKFW_yYVFLiTNM_sXnMHLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] worktree repair: refactor and reduce .git file reads
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 5:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static const char *get_worktree_id(const char *dotgit_contents)
> > +{
> > +     const char *slash =3D find_last_dir_sep(dotgit_contents);
> > +     if (!slash)
> > +             return "";
> > +     return slash + 1;
> > +}
>
> This returns a pointer into dotgit_contents; it is the last
> component of a pathname, similar to what basename(3) gives us.
>
> > @@ -798,30 +806,20 @@ static int is_main_worktree_path(struct repositor=
y *repo, const char *path)
>
> The unified diff is a bit hard to follow, so let's see if we can
> compare preimage and postimage more easily.
>
> >  static ssize_t infer_backlink(struct repository *repo,
> > -                           const char *gitfile,
> >                             struct strbuf *inferred)
> >  {
> > -     struct strbuf actual =3D STRBUF_INIT;
> >       const char *id;
> >
> > -     if (strbuf_read_file(&actual, gitfile, 0) < 0)
> > -             goto error;
> > -     if (!starts_with(actual.buf, "gitdir:"))
> > -             goto error;
> > -     if (!(id =3D find_last_dir_sep(actual.buf)))
> > -             goto error;
> > -     strbuf_trim(&actual);
> > -     id++; /* advance past '/' to point at <id> */
> >       if (!*id)
> >               goto error;
> >       repo_common_path_replace(repo, inferred, "worktrees/%s", id);
> >       if (!is_directory(inferred->buf))
> >               goto error;
> >
> > -     strbuf_release(&actual);
> >       return inferred->len;
> >  error:
> > -     strbuf_release(&actual);
> >       strbuf_reset(inferred); /* clear invalid path */
> >       return -1;
>
> We used to receive the filename of ".git", read it and made sure we
> have "gitdir:" prefix, and find the last component, but then trimmed
> the actual buffer.  Which means a few things.
>
>  - If the contents of the gitfile were "gitdir:foo/bar/baz \n", our
>    id pointer found the slash after "foo/bar", trimmed the buffer to
>    have "gitdir:foo/bar/baz", and then incremented id, which now
>    points at "baz".
>
>  - If the contents of the gitfile were "gitdir: foo/bar/   \n", then
>    after triming, the buffer would have "gitdir: foo/bar/" and id
>    would be pointing at the NUL at the end, which would have lead us
>    to error.
>
> Now let's look at the new code.
>
> > @@ -798,30 +806,20 @@ static int is_main_worktree_path(struct repositor=
y *repo, const char *path)
> >   * Returns -1 on failure and strbuf.len on success.
> >   */
> >  static ssize_t infer_backlink(struct repository *repo,
> > +                           const char *dotgit_contents,
> >                             struct strbuf *inferred)
> >  {
> >       const char *id;
> >
> > +     id =3D get_worktree_id(dotgit_contents);
> >       if (!*id)
> >               goto error;
> >       repo_common_path_replace(repo, inferred, "worktrees/%s", id);
> >       if (!is_directory(inferred->buf))
> >               goto error;
> >
> >       return inferred->len;
> >  error:
> >       strbuf_reset(inferred); /* clear invalid path */
> >       return -1;
>
> The caller is expected to give us the contents of gitfile read by
> setup.c:read_gitfile_raw(), which reads the file in full, validates
> that the file begins with "gitdir: " (notice the trailing space),
> removes arbitrary run of CR or LF from the end, and then returns
> the string after skipping "gitdir: " prefix (8 bytes).
>
> In the normal case, read_gitfile_raw() would see "gitdir: foo/bar/baz\n"
> in the file and returns "foo/bar/baz" to our caller.  In fishy cases
> we examined for the preimage above:
>
>  - If the contents of the gitfile were "gitdir:foo/bar/baz \n", our
>    caller would have received an error from read_gitfile_raw() and
>    wouldn't have called us.
>
>  - If the contents of the gitfile were "gitdir: foo/bar/   \n", our
>    caller would have given us "foo/bar/   ".
>
> get_worktree_id() will give us "baz" in the normal case, and "   "
> in the last case.  We fail to error out in the latter with "*id"
> check, but is_directory() check will catch us, as the inferred
> directory is "worktrees/   " in that bad case.
>
> So there are certain differences in error cases, but they behave the
> same in the most basic cases.

infer_backlink() in the preimage accepts the "gitdir:" prefix without requi=
ring
a following space and uses strbuf_trim(), which does more than just remove
trailing newlines. This is more lenient than `read_gitfile_gently()`, which=
 is
called when other Git commands are used.
I believe the primary purpose of `worktree repair` is to fix common issues
like worktree relocation, with repairing cases where the `.git` file's cont=
ents
were manually modified being a secondary concern.
Therefore, I have adjusted the behavior for error cases: if the file deviat=
es
from the standard `.git` file format, it is treated as ".git file
broken"; if there
are trailing whitespaces, they are interpreted as part of the path and trea=
ted
as ".git file does not reference a repository."
I would like to split the commits and provide a detailed explanation for th=
is.

> > -     } else if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE ||
> > -                     err =3D=3D READ_GITFILE_ERR_IS_A_DIR) {
> >               fn(1, dotgit.buf, _("unable to locate repository; .git is=
 not a file"), cb_data);
> >               goto done;
>
> This is inherited badness, but overly long lines like this one needs
> to be fixed.

I'll fold long lines near the changes.

> Ah, outside the context of this patch, before we barf for "unable to
> locate repository" when we complain backlink.buf is not naming a git
> directory, there is the fallback logic, and in order to reach there,
> we have "if (!is_git_directory(backlink.buf) && !inferred_backlink.len)"
> there.  OK, so this may be doing the same thing as the original, but
> it is rather hard to follow and convince readers that this is a
> no-op conversion.

The first commit contained multiple changes, making it difficult to follow.
I will split the commit to distinguish between the parts where the behavior
is modified and those where it remains unchanged, making it easier to
verify that no changes were made to the latter.

Thanks,
--=20
Yoichi NAKAYAMA
