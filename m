Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2433E346
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208672; cv=pass; b=MLPLH9O5olc4RQ5DLTItkGT5CrXYGqqaxuluQJFGqU4IuyVuE2TXD2egqA7D402iRxB/pnsv8KOp25HQh6fwKd0CnxrVvZ5FdiZelCgfeFRsUVb5y62N7l2FvWTKM8A4zTEF37MMvI1J1n9L0yyBwo+r42XeReElAF1OPtVGjpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208672; c=relaxed/simple;
	bh=+4U1m5bzZUsgPEkmWkVcJ8AzJlbVnq2HIyAKODimI+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3EBIbsrrJkH6pWjkONLgfaWkq2mR97by9pf6LBJPNgrH1IMEyaNOUr2gRIMEl3fkIC/rEisTReTr5jUt/zr+JEr89On8tdeECTFPUtYztkPrv9rTpj4a+sLu+LtdLdenU4MgjfVS4jWMP99/Jg3hMNUZfVZlS/ggOiyVgcfMaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQwtW45r; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQwtW45r"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa7a7ad4d3so170912e87.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781208668; cv=none;
        d=google.com; s=arc-20240605;
        b=TMrg/ZRf5kOuSqRfK3n/VRcIZ33umIftKds1PlDIF/135V7IrijEyQ/VMb2hpS0+tM
         dBp3PnNIuCMgF2/S65T/6tHX8tbaoLgdFUPDPtRi5p8Ftd/gzzplOqftCHN9o93qujWL
         MN9ewXYgiiJRFxX4I7lo5HqG6GWghq3hZUupaeQjiU8TwCLPrcXrEsPDa71Nr2zK9XzQ
         NdrZwwQb9QJQjxzfGaT1JGIlGeE2a4yOIR7tIUWBHQi4YVr5ihC+vazB65B1CGHy3RQp
         xaJiFMB2+4zTOOckMrBKRMQVAn9/A0lmkTnBuBx/9uei8s6vExRZr9W1NWK9wW/zbmOn
         ICDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TOowSCWxGiG4B6a1WZ0mdx8CzOEjQoCRrSVY8LEnXV8=;
        fh=2GNm5k5kgWB8cPHZ/JEch+O7eLGcEVkhdxzQRfh/7vc=;
        b=ellqnGQ4tAxRd8kYvbclyRyiaEMFColxvS/uZRFesZGsARaNvY+XQdoMEOw+rznky7
         PdERvHKc3lt7zbRGoBYY2+7cQG5a+EEJpS4VWVgZtGx2lhxh/9chQpGJMGODnItTjd3n
         aejvHS1PfoopWODTkT0dd0Xg79RpDhR4WlPNyyZP29OIbd95vkmK4Kftzxzcnp/qTtcJ
         JhCocX6jXF2jvQJmdV2Z1hJCIJ5Moqjjo1KVrk00nm+QOcpSrPFSnA1OzTiCqLpps+yT
         pD/7P9j/3X4U6BLaNmWgJzDpoWnzVh2kMJr2FG5G2im5nH/xOwmwcT3FGjXU85NSsxZ8
         A3Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208668; x=1781813468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOowSCWxGiG4B6a1WZ0mdx8CzOEjQoCRrSVY8LEnXV8=;
        b=JQwtW45r0T9tgVaJb2ZMT+3hBbROciapcWHVaoAL++K3p29qy1gLg/kUiptvTBwEfW
         aCSX9lndM5wdH9/+/3Ma1bgAHIVN9it9J9+L//L6CzMx3yp6MwLIaFFpC5Otqqjs7KDv
         MoxiC8iGGjuyq9lia4Kl6mcNsHIajFIhPJa0BahjCiCCN4KJAuESgZyjLpytJ7O7BgKF
         NnrKca90rNIX1Mp9nVUTUW1UbHZfHFrs1HZUdwFjre77z4ZmCjtmeIleCvFxs2zlA/pi
         qFlkxYzaEuDx+mdaP29Kfd/EjGt37tlCz2JZE6ByN1GBbxzq1FJTBLPfBysgBk1MvoWa
         kCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208668; x=1781813468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOowSCWxGiG4B6a1WZ0mdx8CzOEjQoCRrSVY8LEnXV8=;
        b=m/cS5k03hhI2ZY2be4eC4zs9KLYbTT5bKGvCKVGfPUtAzWGFSqx6gmUwCySsX3kabH
         vHu/jCDcSIJSwpHo2nf9HvPvlN6D75TRHIwm17xAnBzaNiq32l1hzvk6+v6827U+Gg41
         Bf334rSLPt6OflO8qyd5r8RP14FiaojLrt5Zekd3WoxrM7NrttD0FiRdBU2eJ4M16E0t
         RuiwbSZT+xhjtIzvHKZibNackcDRucu5bKTczwfP02mezQV2Xnul69/50tGgPPMrBqmA
         5pMv6m3OGfy0yxQP43pZpz5aKVWsyfdHaChuPwSFFjPaxPhG6le4QsLYQv/WS9MPFOIA
         J4Iw==
X-Gm-Message-State: AOJu0Yz87N5gOLWIcLL8k9AuDhD7dyIXaboN7N78tFYLBpAQi59Cn+Ew
	MWvijCW/cnsGLuTlMv7pNeKphXQO7FO4L8ho1FxpjP1jFQQglUpdNWZcckjg7HIjwMHN9OtS9p+
	TU5iwObgnJky9B5DG20m+9BZGgLJKft6Wkom64Ws=
X-Gm-Gg: Acq92OEf5lppVOaaq69gmJt2i0MSBZOG04Ad/hkH1dqQis3beES+Aom4KMqNpns1Y+7
	kmiOf2Ur+7v6LQFWgReho9O4e7CzzWbeM5KmgLDqefKPh14/+nl5nTlQG6vzMLbvwZ8JJfIEYWL
	9GNnJfI/gJnEe9+1smz3O9G24rbGvevD/hrX+9/FbXkwDGjNj5TAWklmmh6aArG4L6c3delKKA6
	wO3EhvSTKdN7RVWJD9QfSyKoIHG/cgGLYzCCbvZn2kWuJfjTTNwQL1PL38QW1qE6chrSLKH4ybI
	WF2dM9YftkHMbHvWblEYfC0drxiDZqCG2EnKm9w//T5sQO28Rtrn3uIDXEUelxunM9NRSd/rcYa
	UG+djIULuAxgyz6r4h/lQ
X-Received: by 2002:a05:6512:3981:b0:5aa:7039:706e with SMTP id
 2adb3069b0e04-5ad27fb6ad3mr1428661e87.29.1781208667894; Thu, 11 Jun 2026
 13:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
 <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com>
 <CAOLa=ZRFSuGrqFXhTuQ7Dk5GCQQGHom++78xwONoiNdt1h_gWQ@mail.gmail.com>
 <CAJ-ks9ku=-675naKESOJJxOo0b5BmoH7=76aKZXXmUHM+=ZV0w@mail.gmail.com> <CAOLa=ZSezQOj56-TezVaAcisUyczxhJmu4VghyFBHcBB_mKJ2A@mail.gmail.com>
In-Reply-To: <CAOLa=ZSezQOj56-TezVaAcisUyczxhJmu4VghyFBHcBB_mKJ2A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 11 Jun 2026 13:10:30 -0700
X-Gm-Features: AVVi8Cdk4e-rDuuuY6EXJAoG-NA1nENpvXgdM0hU9RYghxNunCAUzH-z66HHqqM
Message-ID: <CAJ-ks9mYkiUo0_=JJGJtRnFBb4u8v_d2-mytydbJOeuoKbfOiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: memoize --contains with generations
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:16=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > On Wed, Jun 10, 2026 at 4:47=E2=80=AFAM Karthik Nayak <karthik.188@gmai=
l.com> wrote:
> >>
> >> Tamir Duberstein <tamird@gmail.com> writes:
> >>
> >> > git branch and git for-each-ref call repo_is_descendant_of() for
> >> > each candidate selected by --contains or --no-contains. Each call
> >> > starts a new graph walk, so refs with shared history repeatedly
> >> > traverse the same commits.
> >> >
> >> > ffc4b8012d (tag: speed up --contains calculation, 2011-06-11)
> >> > introduced a depth-first walk for git tag that caches positive and
> >> > negative answers across candidates. ee2bd06b0f (ref-filter: implemen=
t
> >> > '--contains' option, 2015-07-07) preserved both implementations when
> >> > ref-filter learned --contains.
> >> >
> >> > The memoized walk is not always faster. Without generation numbers,
> >> > a negative check can walk to the root even when the breadth-first
> >> > merge-base walk finds a nearby divergence. With generation numbers,
> >> > the depth-first walk can stop below the oldest target while still
> >> > reusing answers across candidates.
> >> >
> >> > Keep the existing memoized selection for git tag. Select it for othe=
r
> >> > ref-filter callers when generation numbers are enabled, and retain
> >> > the breadth-first walk otherwise.
> >> >
> >> > When generation numbers are unavailable, repo_is_descendant_of() can
> >> > return -1 if ancestry cannot be read. The ref-filter Boolean interfa=
ce
> >> > treated that error as a match. Check it and exit instead. The memoiz=
ed
> >> > path already dies on the same parse failure, so both selected paths =
now
> >> > fail rather than return a result.
> >> >
> >> > Add p1500 cases for up to 8,192 packed refs along one first-parent
> >> > history and for sibling refs near the tip with generation numbers
> >> > forced off.
> >> >
> >> > On a checkout with 62,174 remote-tracking refs and generation number=
s
> >> > enabled, I ran:
> >> >
> >> >     hyperfine --warmup 0 --runs 3 \
> >> >         --command-name parent \
> >> >         '"$parent" branch -r --contains c78ae85f3ce7e >/dev/null' \
> >> >         --command-name this-commit \
> >> >         '"$this" branch -r --contains c78ae85f3ce7e >/dev/null'
> >> >
> >> > The results were:
> >> >
> >> >              parent       this commit
> >> >   elapsed    104.365 s     467.7 ms
> >> >   user        93.702 s     220.2 ms
> >> >   system       0.723 s     182.7 ms
> >> >
> >> > The wall-time standard deviations were 11.356 seconds and 133.8
> >> > milliseconds, respectively. Separate runs without redirection produc=
ed
> >> > the same output with SHA-256
> >> > 2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.
> >> >
> >> > Both revisions were built with the default -O2 flags using Apple
> >> > clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6)
> >> > with a 16-core Apple M4 Max (12 performance and four efficiency
> >> > cores) and 128 GB RAM.
> >> >
> >> > Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-=
Karthik.188@gmail.com/
> >> > Link: https://lore.kernel.org/r/20230324191009.GA536967@coredump.int=
ra.peff.net
> >> > Link: https://lore.kernel.org/git/20260527070510.3510836-1-krka@spot=
ify.com/
> >> > Link: https://lore.kernel.org/r/20260608223430.GA340696@coredump.int=
ra.peff.net
> >> > Suggested-by: Jeff King <peff@peff.net>
> >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >> > ---
> >> >  commit-reach.c                 | 13 +++++++++--
> >> >  commit-reach.h                 |  7 ++++++
> >> >  t/perf/p1500-graph-walks.sh    | 49 +++++++++++++++++++++++++++++++=
++++++++++-
> >> >  t/t6301-for-each-ref-errors.sh | 22 +++++++++++++++++++
> >> >  4 files changed, 88 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/commit-reach.c b/commit-reach.c
> >> > index 65b618959b..83a48004ef 100644
> >> > --- a/commit-reach.c
> >> > +++ b/commit-reach.c
> >> > @@ -821,9 +821,18 @@ static enum contains_result contains_tag_algo(s=
truct commit *candidate,
> >> >  int commit_contains(struct ref_filter *filter, struct commit *commi=
t,
> >> >                   struct commit_list *list, struct contains_cache *c=
ache)
> >> >  {
> >> > -     if (filter->with_commit_tag_algo)
> >> > +     int result;
> >> > +
> >> > +     if (!list)
> >> > +             return 1;
> >> > +     if (filter->with_commit_tag_algo ||
> >> > +         generation_numbers_enabled(the_repository))
> >>
> >> What's stopping us from dropping `filter->with_commit_tag_algo`
> >> completely and then doing?
> >>
> >>   if (generation_numbers_enabled(the_repository))
> >>      return contains_algo(commit, list, cache) =3D=3D CONTAINS_YES;
> >>   return repo_is_descendant_of(the_repository, commit, list);
> >
> > Jeff raised this distinction during the v1 review:
> >
> > https://lore.kernel.org/r/20260608223430.GA340696@coredump.intra.peff.n=
et/
> >
> > `with_commit_tag_algo` preserves the existing behavior of `git tag` whe=
n
> > generation numbers are unavailable. `git tag --contains` has used the
> > memoized walk since ffc4b8012d (tag: speed up --contains calculation,
> > 2011-06-11). Dropping the flag would send it back through repeated
> > `repo_is_descendant_of()` walks in repositories without usable generati=
on
> > numbers.
> >
>
> I did read that, my question is on top of that. Do we also want to use
> the non-memoized walk for 'git tag' when there are no generation numbers
> available or does that not work? If not, we should mention that too in
> the commit message.

We should keep the memoized walk for git tag. In git.git, with commit
graphs disabled, hyperfine measured:

    git -c core.commitGraph=3Dfalse tag --contains HEAD~200
    git -c core.commitGraph=3Dfalse for-each-ref \
        --contains HEAD~200 refs/tags/

at 478.9 ms and 4.861 s, respectively. The second command takes the
non-memoized path, so memoization is about 10 times faster for this
workload. I added the rationale to the commit message in v3.
