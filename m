Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A84071F2
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094089; cv=pass; b=J4p0TCfblJ4jYCa5PeJj+Qp52i0DpeaA5JaICeP/tDH6z1Vrt2AMfPbSVZW+V1VH6j8zswrgzbIHwYL2+p5c/lh0Y+IOcyex5KXCgzy4box/rWMoYcPDegNW4WfJRhZ3uq/ZQ8/SGrVwgtAA+5cw8x7h+drQIRbS63VzFd3+eOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094089; c=relaxed/simple;
	bh=Z7rj4rDNJP/+F4M4mjVpZez9NHLFrkom5RgWtIWsKwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l10m08Utp56zUlFb467obVc1Hm/L64955G7rH82oYr5ZQLWm/e83SE3AzOhBCEP7MXJuldreYuuQXqyQgmi+R7XTGJ/C64hm1H6MWnXYLZdKEUTUoRX0twZH8m5sdtAuosARNQb1fFGj5G/Co/RSWxwkxlaGEnuQVbyynBRpkjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7ypYFQ9; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7ypYFQ9"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3965d76090bso61031581fa.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 05:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781094086; cv=none;
        d=google.com; s=arc-20240605;
        b=APAGCd114bwpdQWQxmtARuaczzjyRyp2MDFmT/+Xs4xoWrSbcdbFK2h6mFiU2MkKFL
         efuX0Qe573uOOS3wposp0+5O3PgydBun8VC8yIyy2qH86GKs9PuoJtZrdbjZuikLnBqn
         qDbrW6mDbP6Wak1iE9qFSYIeZLp1uvQC6jhC8U2ljcMJEOdAICyxn58MNpv2h0j6BVA8
         jBJH9yHr3Jh8QqCvpV3Xj5TqJSGwBc72Xnojatj0odRuSPNIjoEQyl5IWUaMjqJUZigq
         z4BwQfVcWFpvRhpm0AaJOwDWTtUVuBRE3G8Z2FeibBKSj9DWvabjtMZhbardJZicLSSr
         yVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mFmen1JLlhDYgl9B21i68JPy22fhlq55BfReo35RJ+c=;
        fh=2GNm5k5kgWB8cPHZ/JEch+O7eLGcEVkhdxzQRfh/7vc=;
        b=dcEZYKuTmGGCbZ/oVvfqKHyL0y9k+cpd5p5KF6rfrDO6CYIFg4IlgPPizwHWG/Mpsh
         cKTBCw/PPkrxMKq671CQjNBso0x6cs4XQqGHpQJqArQV3niP3wadcu5k3WISzzakLUhU
         Qy/86nMFktEIKWiRQFgiQCMvF3UGU70/j8TEcw/R7Bvw/QuifsEEwxXk8yzV6u+cI0C/
         tx2Y54oPbXFGQHRNoTKjiuK6jMkHIFjNUBLn2D0KKDRCtL0R3HybDhZFcidgP25gyIFp
         ejuOIwRpx4F7BEJlSSVwiLq2BIajKho5sziVdYQj8c0UKn47YWtVrue2RH9ePrVrcDZn
         vOew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781094086; x=1781698886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFmen1JLlhDYgl9B21i68JPy22fhlq55BfReo35RJ+c=;
        b=L7ypYFQ9EExAPM+olPkV17TiFNDM/LVTmLrypSfCLMrj3swpHsMlCnr8Vs0SMqWp0s
         Nmke6s4hyWWCcxePm98AG0jp5yxQ3z+p3gjrd18zZEEq0h5QRDXfHjz6WVvSVk1Xuqn4
         NRwpbEWXba5DYXVp5ZqrKCecQ2GOkFSUSecl9grxmMc0PpYPenhyyJSZwdiWfOcZ/Ew5
         /QMaLgmL25AItSTuycGgJOTFkXAGi3rkzvkXeJxwZ7Z2jaeNcCm/xKQqxrzCRfL9alWz
         nLgy+Ra1dF6Qy81ejRHVdURFbzL57cgl59pYYK2FpYknqShV0vsifjWZXXhArgyXJEJ3
         Souw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094086; x=1781698886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFmen1JLlhDYgl9B21i68JPy22fhlq55BfReo35RJ+c=;
        b=JSoGXhqrYRTPyFO6z9M/AIaSY949ozCTlg+Rrwg22OfWEjNJ9mqPKNpU6Q9ElPb++w
         I2M75nVEy3X0EvE23czqTir+9tS6B5Qb2rvXMJCrcTS2xjf45foDeBAXgDzeelHmw8tT
         63+DduWz+3Q8ig3PS8oORkooqx3CAzjd4P2Ubzu12yam8PX+HGGq3s4kjq2XidGH94dy
         B82RUamh29ClWWNwagcTvAhavH1GhwTMaPmUwl0oSdphOsd0BXJPpOtytGZVOO/PmYt5
         AJnfdbPQnMwSiWoo2RIZJONFT2UoAayQwQ6sDZ9rJYq5ywbKUc/PkKfNRQ+7NxMR3h9y
         fzYg==
X-Gm-Message-State: AOJu0Yzd9wqKESUScozlRIn9caa4kwoVWSR9bm48q3+iYZTg1KQ9GAxh
	XVApXtGVKZvOOOe8CFeBLJMg0kYUExF3UtxoTTbK/qOsmqBfgzrsgqzD51quewwUUBwvMxe/I8+
	pQo5XGsRYpbTh9oDsn2NxOmHANpFW/dw=
X-Gm-Gg: Acq92OFeMDJv+kREeveB7YBc8UI6QQsvEcbUl6sN4L1pOc20/M4DlSDcWwQYtICEzwc
	JZ33C8+tMP+2ucqg7wvnSf5hkc1mMbyAE+KxCRRhElQdsUo5AEHSwJumeNynx5cinNQhEOhAlq1
	h615pjGoGs968aNntkKhCfIIRuWWVJnt/6Aavqdc9hvwHa2VOIjhPIK/BJS4ZVDiPtqWbQVKv4F
	yJgyr5/prbJOa02aDircPhMokM6qwtl1jl8i8tlFEh5uZGfox+Uq3rTieNeOlHG8IVQet2ZBm+y
	dV4OTh6Uxv6wr5xJS6YyWEDEtAQDn3JgCImJBerY6lWOLlfwvTq6PV2sapKBsHY8D+RrPd3Mrub
	LgnMI6XW4t69dWgeY0XibVovNDgA=
X-Received: by 2002:a2e:a715:0:b0:396:b398:5990 with SMTP id
 38308e7fff4ca-396d0802544mr46002181fa.10.1781094085972; Wed, 10 Jun 2026
 05:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
 <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com> <CAOLa=ZRFSuGrqFXhTuQ7Dk5GCQQGHom++78xwONoiNdt1h_gWQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZRFSuGrqFXhTuQ7Dk5GCQQGHom++78xwONoiNdt1h_gWQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 10 Jun 2026 05:20:49 -0700
X-Gm-Features: AVVi8CczkeanGhNxXMn_spyu3uleDDB4HismOsjg22SKvDpAV-Y309u7RqkNqa0
Message-ID: <CAJ-ks9ku=-675naKESOJJxOo0b5BmoH7=76aKZXXmUHM+=ZV0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: memoize --contains with generations
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:47=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > git branch and git for-each-ref call repo_is_descendant_of() for
> > each candidate selected by --contains or --no-contains. Each call
> > starts a new graph walk, so refs with shared history repeatedly
> > traverse the same commits.
> >
> > ffc4b8012d (tag: speed up --contains calculation, 2011-06-11)
> > introduced a depth-first walk for git tag that caches positive and
> > negative answers across candidates. ee2bd06b0f (ref-filter: implement
> > '--contains' option, 2015-07-07) preserved both implementations when
> > ref-filter learned --contains.
> >
> > The memoized walk is not always faster. Without generation numbers,
> > a negative check can walk to the root even when the breadth-first
> > merge-base walk finds a nearby divergence. With generation numbers,
> > the depth-first walk can stop below the oldest target while still
> > reusing answers across candidates.
> >
> > Keep the existing memoized selection for git tag. Select it for other
> > ref-filter callers when generation numbers are enabled, and retain
> > the breadth-first walk otherwise.
> >
> > When generation numbers are unavailable, repo_is_descendant_of() can
> > return -1 if ancestry cannot be read. The ref-filter Boolean interface
> > treated that error as a match. Check it and exit instead. The memoized
> > path already dies on the same parse failure, so both selected paths now
> > fail rather than return a result.
> >
> > Add p1500 cases for up to 8,192 packed refs along one first-parent
> > history and for sibling refs near the tip with generation numbers
> > forced off.
> >
> > On a checkout with 62,174 remote-tracking refs and generation numbers
> > enabled, I ran:
> >
> >     hyperfine --warmup 0 --runs 3 \
> >         --command-name parent \
> >         '"$parent" branch -r --contains c78ae85f3ce7e >/dev/null' \
> >         --command-name this-commit \
> >         '"$this" branch -r --contains c78ae85f3ce7e >/dev/null'
> >
> > The results were:
> >
> >              parent       this commit
> >   elapsed    104.365 s     467.7 ms
> >   user        93.702 s     220.2 ms
> >   system       0.723 s     182.7 ms
> >
> > The wall-time standard deviations were 11.356 seconds and 133.8
> > milliseconds, respectively. Separate runs without redirection produced
> > the same output with SHA-256
> > 2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.
> >
> > Both revisions were built with the default -O2 flags using Apple
> > clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6)
> > with a 16-core Apple M4 Max (12 performance and four efficiency
> > cores) and 128 GB RAM.
> >
> > Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-Kar=
thik.188@gmail.com/
> > Link: https://lore.kernel.org/r/20230324191009.GA536967@coredump.intra.=
peff.net
> > Link: https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotify=
.com/
> > Link: https://lore.kernel.org/r/20260608223430.GA340696@coredump.intra.=
peff.net
> > Suggested-by: Jeff King <peff@peff.net>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  commit-reach.c                 | 13 +++++++++--
> >  commit-reach.h                 |  7 ++++++
> >  t/perf/p1500-graph-walks.sh    | 49 ++++++++++++++++++++++++++++++++++=
+++++++-
> >  t/t6301-for-each-ref-errors.sh | 22 +++++++++++++++++++
> >  4 files changed, 88 insertions(+), 3 deletions(-)
> >
> > diff --git a/commit-reach.c b/commit-reach.c
> > index 65b618959b..83a48004ef 100644
> > --- a/commit-reach.c
> > +++ b/commit-reach.c
> > @@ -821,9 +821,18 @@ static enum contains_result contains_tag_algo(stru=
ct commit *candidate,
> >  int commit_contains(struct ref_filter *filter, struct commit *commit,
> >                   struct commit_list *list, struct contains_cache *cach=
e)
> >  {
> > -     if (filter->with_commit_tag_algo)
> > +     int result;
> > +
> > +     if (!list)
> > +             return 1;
> > +     if (filter->with_commit_tag_algo ||
> > +         generation_numbers_enabled(the_repository))
>
> What's stopping us from dropping `filter->with_commit_tag_algo`
> completely and then doing?
>
>   if (generation_numbers_enabled(the_repository))
>      return contains_algo(commit, list, cache) =3D=3D CONTAINS_YES;
>   return repo_is_descendant_of(the_repository, commit, list);

Jeff raised this distinction during the v1 review:

https://lore.kernel.org/r/20260608223430.GA340696@coredump.intra.peff.net/

`with_commit_tag_algo` preserves the existing behavior of `git tag` when
generation numbers are unavailable. `git tag --contains` has used the
memoized walk since ffc4b8012d (tag: speed up --contains calculation,
2011-06-11). Dropping the flag would send it back through repeated
`repo_is_descendant_of()` walks in repositories without usable generation
numbers.

The condition in v2 implements the rule discussed there: retain the
existing memoized path for `git tag`, and use it for other ref-filter
callers when generation numbers make the depth-first walk reliably
advantageous.

This is probably my fault for breaking the threading between this and
v1. Sorry about that.
