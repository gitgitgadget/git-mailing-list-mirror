Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FF4028C5
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094343; cv=pass; b=GwliegaZc0fI7d0KdxqAHktie/50ieeGtb0k4AONWqXAeRNoZd1uExpAFqxiYC/RE9fRxz1Tax/KlHIlbwtHtVzMT8mp45i0AEQHT1sccXhYCxSTK8PAFeMrnFKL8DCjJ6Niy34ypE+i2fVNZKxfVIY6wbjrghg3PgWR3aGrVJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094343; c=relaxed/simple;
	bh=5Nc84zxOcxxvNywepzy+dFDtuo94ftEB5UIlLDI57CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7d+u9518ViRAb6wiAXlkIy6lvcftx6mmrseLFvGQnJFE76TJyk7/gLhTyMiKErLqxk/teICIXrdmyKY8H0steoaf530U0jCkpTt/zy/GANwVv67laly5eaTazrV0K0Ihs69nEny3nI3O88y67NenrO67tfAOHjjjdrAUPoYy2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaP3YIKQ; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaP3YIKQ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3965eab14cfso50731161fa.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 05:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781094340; cv=none;
        d=google.com; s=arc-20240605;
        b=l3ml2H6V/b2uTGUTSS+cw68p4ukt43Ea9f2iZ5kxnHs/hEqAc/WMiYDMAHaT/LUb6+
         GWzOr13kjZPZqzODO1/GAxj/W2ZUHQiicgWzrRqeyKnmMFmQlJMEkxfOIcNKJo4y7atX
         DnLLGIEF/X9nNdn065HgONVSW9DNFXWVetvIa4zZAGvykwawyRGZkZdD/9FIRAp6LPED
         axEuNd+XMRj2d6zcfIMZNdrSAMEKcy1Jiy546QnUt8d7k+A83/0D5zLD3exCEN8+TWPR
         rv6kHJpz7CFVu79sGkNteLw3E2Iaxx+0yGyxnSHglmAEG6EDQ/rzpgbnGhIT5uMc0jHx
         srtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRmXdZS6VyK3ko4Dc51gwSqQNStBtZ23B7OK5Rt1CQ8=;
        fh=GLdoyvgAouSz9QyuektsHb08Fmuu37yo1mkYZWDqesI=;
        b=XjWXfldNFidr2WMl/S9T8Wl/EynvNkAPkSbQFnLM2et3nbkBNbrirxa7ov4MlJQFDL
         lyE0gmc6WD6JASe7RDJTEZBw06Ro9Pb4IUI+NTwGR0pSkVV8fuIXJgRxkX1vfy8SfCv6
         suPLgvOxHcFy16WnJvxhkhbXvl/r7xSWP89rCfJoxwTq1SZIyQ5J2+BJMGsI97eafY/3
         wkb9/ioEERh4QSvLyhd/TOSxaW7RsU1UCRnvJK+W+XEoJpcIGeV7l43mruM0Ap7jvwWq
         CDuVaLMOtjsDCv493hNNO1U63gLdc+KeohqQ7Ug1TIc6K+KwIGFnbldIDa9qlQzczEve
         VwgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781094340; x=1781699140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRmXdZS6VyK3ko4Dc51gwSqQNStBtZ23B7OK5Rt1CQ8=;
        b=YaP3YIKQNvaIWYKNA6CGcQoAy1Pixw2CiOBG4/3vo/3119w9fpG278k6y+w6qrw51s
         vXu1A1Lc0GhVI+hAqKzvz1K4tR6dVJ9c6ZWnmNiubipvFU/Y1dyRReG/pTGmOgfiLxpj
         8a7b0D+0w8NBx9yhTYaYfIICYjCUuKKbyfRB4+P477zAbINQ7Q/6pHfYn+HLzr++3MUl
         iDZywls76/4GGlP4HlYaDP+lJ1LCMxxUOdM5+slA9iqAuHOJpzifWEC0VSri9w69W5ZL
         vziv5/D6FZPabqTSHnwKU+5go/CSNJrp21TxSaAD/bF0ulx83b5jSNYXRLxCCoL4vv5D
         dhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094340; x=1781699140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRmXdZS6VyK3ko4Dc51gwSqQNStBtZ23B7OK5Rt1CQ8=;
        b=kSX7wt4ZetsSGuAXF/Jma/oZZeJ1kV+j8ZAM8us/udL1Sd52l2acNQs9teCZz4A6qa
         7SjaheRj0H/kK5I1U6USxae9ZJVw7qhEP0PskIDmvduHepXF9zYm69K0F/Iy/hnoJnz6
         pfhP6sftURCbMl5bs5LhJ9ALViSc/DEf1cXOleTYS+G/9IYub8kKvzCBQ8hS6VmB0+6x
         RZZsfE1ZfxtkACjhb2AKp06n7kkPxByc4JqK1pPDOpeFToM1XNBj1kRJy0DfSzLl9VcN
         UhkhqttWIrngPAnCmpO7jzRoOf4DX6FzGVWGHHjimGUVGyQs1NJIr+tqvRhtOL9JgU+J
         9RDg==
X-Gm-Message-State: AOJu0YxAsVPd6Ebw7M2Ydmmi0ewyW4TTA/TgpGAY+9RyNDatoW8bOFeC
	UQ76ZFTLm/mAUt0HD0r7j7HADVgR0xay6iqrO3MXAns2UgPE0gPcO+hLmAcDf37eEhKp34ZJeN4
	o6YBMviiRZLDQAUv5pGoyVY7OIG+04iQ=
X-Gm-Gg: Acq92OHYVZvNSONNeIg5/t3lQ4451VS3EUkuLIGxY+PV0eyEk53mUlmcSHU2lxcOV9w
	Cavq5OB7Ku6wSNc07pDTZV/+fVQKUaGNbqis1ysXw1g1QRj5uoDEYd5ssOv7u7Qb345dNrCUoeV
	VR1XDrUVJCbYiy6TvNhTdT0ExsDbtXz0MDqa/iwkXcFK1mY0wb7C551iNtxm3pQnH+pw/ER6Av6
	aeZ+l6yBEvJkVb2vK2av5AOc8un6rgdigQQqu+ZrRnuQJknW8gVH6lWeCi2jgaQVt7JHa+n0oAw
	fiRAu2pLEuuXM05hUzQ6cGGWLtRLtpwIHSYhZWDpHYb7npK/Qb1RPZ63ZpHfDDrw8buSGwjLEqG
	FpuWPWpvQVBYs69WLOyV1naeqggo=
X-Received: by 2002:a05:651c:2119:b0:396:73ed:695d with SMTP id
 38308e7fff4ca-397f76fc642mr19230961fa.11.1781094339532; Wed, 10 Jun 2026
 05:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com> <CAOLa=ZRHKNNymXGk31YgECjUmF9nZ8GsPUdQb7aKBH5DKMz7=w@mail.gmail.com>
In-Reply-To: <CAOLa=ZRHKNNymXGk31YgECjUmF9nZ8GsPUdQb7aKBH5DKMz7=w@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 10 Jun 2026 05:25:03 -0700
X-Gm-Features: AVVi8Ce3U3I-RNwYq4uA95uDNQjhd98gDgEW2WwMvFEhvlaE1Hp190TtD2Xiu1A
Message-ID: <CAJ-ks9n=27u+Ujz0CBWRS+9ePNpqiiP+jkDfUrk4viMPR8qDww@mail.gmail.com>
Subject: Re: [PATCH v2] ref-filter: restore prefix-scoped iteration
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Victoria Dye <vdye@github.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 3:50=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > Commit dabecb9db2 (for-each-ref: introduce a '--start-after' option,
> > 2025-07-15) changed single-kind branch, remote-tracking branch, and tag
> > enumeration in do_filter_refs() from constructing an iterator with the
> > namespace prefix to constructing an unscoped iterator and applying the
> > prefix with ref_iterator_seek().
> >
> > Before that change, refs_for_each_fullref_in() passed the namespace
> > prefix during iterator construction. That helper has since been
> > replaced by refs_for_each_ref_ext().
> >
> > The files backend primes its loose-ref cache for the construction
> > prefix before it opens packed refs. An empty construction prefix
> > therefore reads every loose ref, and a later seek cannot undo that I/O.
> > Consequently, git branch, git branch --remotes, and git tag scale with
> > unrelated loose refs.
> >
>
> And this is the crux of the issue. Currently we do
>
> - refs_ref_iterator_begin()
>   - ref_iterator_seek()
>
> And between the two `cache_ref_iterator_set_prefix()` is already called
> which caches all the loose refs. This is the IO intensive operation this
> patch tries to avoid.
>
> I think it would be worthwhile to add this information in the commit
> message.

Agreed. I will explain that `cache_ref_iterator_set_prefix()` primes
the loose-ref cache during iterator construction, before the later
seek can narrow it.

>
> >
> > Patrick Steinhardt observed during review that iterator construction
> > and seeking accepted similar strings but assigned them different state
> > semantics. Junio C Hamano then pointed out that no current command can
> > combine start_after with this single-kind path, but future branch or
> > tag support would need to keep the namespace while moving the cursor.
> >
> > Keep the existing start_after path unchanged. The iterator API cannot
> > currently seek to one string while retaining another as its prefix:
> > an unflagged seek clears the prefix, while REF_ITERATOR_SEEK_SET_PREFIX
> > replaces it with the seek string.
> >
> > For the commands affected by this regression, which do not set
> > start_after, pass the namespace prefix during iterator construction so
> > that loose refs are scoped before the packed-refs snapshot is opened.
> > This fixes the current regression without deleting the ref-filter state
> > discussed during review or changing its dormant behavior.
> >
> > Add REFFILES-gated performance cases with one branch, one
> > remote-tracking branch, one tag, and 10,000 unrelated loose refs. The
> > benchmarks were run with:
> >
> >     GIT_PERF_REPEAT_COUNT=3D5 GIT_PERF_MAKE_OPTS=3D-j8 \
> >         t/perf/run a89346e34a . -- p6300-for-each-ref.sh
> >
> > The following are the best of five runs, with each run invoking the
> > command ten times. Times are elapsed seconds with user and system CPU
> > seconds in parentheses:
> >
> >                                   a89346e34a       this commit
> >   branch                       2.74(0.13+2.56)   0.11(0.04+0.04)
> >   branch --remotes             2.81(0.13+2.62)   0.12(0.04+0.04)
> >   tag                          3.01(0.14+2.82)   0.11(0.04+0.04)
> >
> > Both revisions used the default -O2 build flags and a config.mak
> > containing only "NO_REGEX =3D NeedsStartEnd". They were built with Appl=
e
> > clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6)
> > with a 16-core Apple M4 Max (12 performance and four efficiency cores)
> > and 128 GB RAM.
> >
> > Link: https://lore.kernel.org/git/aGZidwwlToWThkn8@pks.im/
> > Link: https://lore.kernel.org/git/xmqqikjq7s16.fsf@gitster.g/
> > Fixes: dabecb9db2b2 ("for-each-ref: introduce a '--start-after' option"=
)
> > Assisted-by: Codex gpt-5.5
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> > The series is based on a89346e34a (maint) because the regression has
> > been present in released versions since Git 2.51.0.
> > ---
> > Changes in v2:
> > - Extract local variable `store`.
> > - Link to v1: https://patch.msgid.link/20260605-fix-git-branch-regressi=
on-v1-1-02f40ad40929@gmail.com
> > ---
> >  ref-filter.c                 | 28 +++++++++++++++++++---------
> >  t/perf/p6300-for-each-ref.sh | 39 ++++++++++++++++++++++++++++++++++++=
++-
> >  2 files changed, 57 insertions(+), 10 deletions(-)
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 1da4c0e60d..5cbc007d64 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -3315,19 +3315,29 @@ static int do_filter_refs(struct ref_filter *fi=
lter, unsigned int type, refs_for
> >               prefix =3D "refs/tags/";
> >
> >       if (prefix) {
> > -             struct ref_iterator *iter;
> > +             struct ref_store *store =3D get_main_ref_store(the_reposi=
tory);
> >
> > -             iter =3D refs_ref_iterator_begin(get_main_ref_store(the_r=
epository),
> > -                                            "", NULL, 0, 0);
> > +             if (filter->start_after) {
> > +                     struct ref_iterator *iter;
> > +
> > +                     iter =3D refs_ref_iterator_begin(store, "", NULL,=
 0, 0);
> >
> > -             if (filter->start_after)
> >                       ret =3D start_ref_iterator_after(iter, filter->st=
art_after);
> > -             else
> > -                     ret =3D ref_iterator_seek(iter, prefix,
> > -                                             REF_ITERATOR_SEEK_SET_PRE=
FIX);
> > +                     if (!ret)
> > +                             ret =3D do_for_each_ref_iterator(iter, fn=
,
> > +                                                            cb_data);
> > +             } else {
> > +                     /*
> > +                      * Pass the prefix during construction because th=
e files
> > +                      * backend primes loose refs before a later seek =
can
> > +                      * narrow the iterator.
> > +                      */
> > +                     struct refs_for_each_ref_options opts =3D {
> > +                             .prefix =3D prefix,
> > +                     };
> >
> > -             if (!ret)
> > -                     ret =3D do_for_each_ref_iterator(iter, fn, cb_dat=
a);
> > +                     ret =3D refs_for_each_ref_ext(store, fn, cb_data,=
 &opts);
> > +             }
>
> This would work, as now we separate out the regular path to use
> `do_for_each_ref_iterator()` instead.
>
> But this causes a bit of confusion, why do we need to use
> `do_for_each_ref_iterator()` and why not simply provide the prefix to
> `refs_ref_iterator_begin()`, like before?

We do not. Your version is simpler and preserves the existing iterator
flow. I have adopted it for v3. Thanks!

> [...]
>
> Thanks for the patch, this is indeed a regression we must fix and the
> benchmarks are a clear indication of it.

Thank you! I'll try not to break threading on the next roll.
