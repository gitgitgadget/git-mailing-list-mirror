Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B5219FC
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232059; cv=pass; b=TtndNpNhYyI6fqNM4OtXsGozcrVuFU/6qMdZr5BlslXL9Uzehm6zhdFgIQTTiKLYXYfakfrQOHhGjE/WwtWfBiTefddE2dmgIJHqwbtp1/ru1fyDmVguund4LfJMmnw6k2nChTmEw+9qBC+WJEolYM+uGJ1YYCdOwagpEAdshCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232059; c=relaxed/simple;
	bh=Xbtw/lgFNrdDx5o5nBdzYyg+Ky6Hv+NUUTYcrjqvDiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smrs7g4VnoCQ6DWzdQaStpPACPYgnaO3yCd+tkWs1EZv6vKfQWcuuYzSsK79xjwRoCkGKkmJrply0PlPUsj4bjQQTJqV7y2X3VHBfUikALBAMXyTBcF+zf6NyzdvQdcA499yuCVT7fXu+bfVsjSFvamrf3pY/dBX4n7omkFRZz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS+A2jm6; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS+A2jm6"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68e66128so430373e87.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 19:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781232056; cv=none;
        d=google.com; s=arc-20240605;
        b=hOZZqCaRwvWJ1a/CIeGs2EDh3cYRCDvR2TAapls27evu50n0wqRYEq6qo3JdMDX2An
         c8JqDxSP3dsJfVtuJiNpDi1aIHRtNqTwTTAo3a4t7dSzpSX3Z0sRV2rop0dYYzD3y37y
         ZhhgkFMjsqmbDvAEuHx90zBTbzFGB+TujkEuY75396EZGouGJd4e7QzpbQ3TqPV2bmPY
         V3VcuNZ/off4bGW5U7J0Uky0D7FuWZGIbmy5dAK2b02jGa4Zu4V+9aEIaUhwHkxnFJua
         SvswgMb8OQxV3YufcNuDyWdfH+MUtl9TmopaaiZ2tTyAJazGHZIKJQoAOtKMILC+r1cP
         Ffxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9V0/WJsyjNWk20IaxfuenePkcII35SkCG83cQzGYtn4=;
        fh=QuqSm4z1e6fTDPgzqH4R1/5/6gjLnj6641dss+Mhz8s=;
        b=PzEaw7CyYDLSuz9LDswNrPRVmOJGOOWWAN9DK7AN+Vq8p4xJYM8AbvRoad9caO3XrI
         RdqG7QfP7UKCuHaDNyg9TUxF6sgwvw1lfBiwdOWlbP5KyF9Qn/lgbs6tDBkGzOubzkbQ
         VpFYeRuvdc5LlTRfWOl0NlGz3OnjISxuhdtZT198PjptMrXVOpyMETDAyIEov/q/Rf2+
         bvLhKP/xIGNABQuIW0YGiG0cr1VMPDQM2ve6trKhwZNn6tJhhoY6uShSQRIsGqga9/Sd
         oaYAU7VoMzm7jyoNr4rjFBysASf8Q2TwGpgPc1si1t+QOnkhBUzeW1B1axpIoBlFtKzL
         Cg7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781232056; x=1781836856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V0/WJsyjNWk20IaxfuenePkcII35SkCG83cQzGYtn4=;
        b=jS+A2jm63aDFXXLasJ+qEQgmN9cF8Y1ROVAlROG9KPAxS90RM7kpJ59tKBa0+Ah/T8
         AR5Qadmmn5stWYK0om210uI0UjEar9TZIaleUxtJOiawvmTPlsEBnmOPlHzHcK1HWkZV
         Z0JsAmkyHYt0SRfKm105SzqrpwNWRvr90CdO0AxGa+yRYtZebOEV/epzJmiZkCTtQWbm
         XykU8DKPVBWyg06Yox+bNWgBurSVvSMcRHeYHcoDTFFMQBY0PXySc71/bcQ1CgJLpcD6
         a1UtL+ZXMYUr3w51yt8z5dMAgcGzCu7xqh5HaiN+wljaIzbgdPux5VLFFix/gsxpXWRS
         fDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781232056; x=1781836856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9V0/WJsyjNWk20IaxfuenePkcII35SkCG83cQzGYtn4=;
        b=T/lvaXUacpP0b7moeASrGVC6UKE04Ylo1y61hxU0hCRIeAHi398564StJ7NXlbLmw9
         n3K98MrtHxb5U/J5Lt99HDG1M5jyRfkzITnfviOE1zpCHfP2ztpMu1oBuXE+3bNc4xrr
         9YYHqNNbguyWwT4HJQEkIoCBNumDqRym7cJLTpZjgeLAaGAKEYZsbPC8llb5UBfd/gnV
         4KB1q35PZdsFJVPU4r4jega/P+16kCFBvoO67rhpoio6E2vIall3EKTV1DlVDi6Nz0Fo
         s/qbRErUeqUDskdTTuKnzlYyF6yAGGRVGTdj4+5EqDawSbW/YYIk51RhEpmYnJfaCqnp
         c/Vg==
X-Gm-Message-State: AOJu0Yxd58nSRibPVce8ccKGcD5BOoRVMk0wsv3nqvytr89WPsxMq2+7
	bWGVOB2xni8FVrRhoRww2XSbOaaoq+z/ofmAW8aH00bsLJ7BTIpFHzfrzxw7Br15qBWkhvEC5eI
	INzoIY0mk3ccv/hpbeP2REAC+XKG6mFc=
X-Gm-Gg: Acq92OH5CpJSHO8+R6AzcqeCGubyviIqa4qkICgzK4U/hugij6ZfKBjIkDxYqdc4Sae
	BhbR/WtR2XkrXEfipy/ZZUR+wYBVw8+1pNKu1mUvL9sdsXSIwPsl3R39JPIAh41PxvYFWdDF8Os
	dQB0pPIksQEcXJtFtmfOMqYzvyHD/lxaFA1W1Yn85KH1qAviBeeJwkIjk29+7GCj95/NThK7vvm
	IFNmqXkFfBVluYhbmnX0QFAiMWoUW90diKHD3PSHzIb2icPo/207IBHxd0/O0IcR6AMoZDbyzBS
	I4BE1m+WPU6g5mMUBLZPjksRP78p1Jl9fgwJGqfeSTpyY2H2It0C+5EWXu8mxYesD/Q3fyikwDF
	l/E8quJIdvksjRiAAQQVXjMncgVmB
X-Received: by 2002:ac2:46dc:0:b0:5a8:7029:c5e8 with SMTP id
 2adb3069b0e04-5ad2db527c4mr192120e87.29.1781232055388; Thu, 11 Jun 2026
 19:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
 <20260608-ref-filter-memoized-contains-v2-1-e72720344a7c@gmail.com> <20260611072942.GG2191159@coredump.intra.peff.net>
In-Reply-To: <20260611072942.GG2191159@coredump.intra.peff.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 11 Jun 2026 19:40:18 -0700
X-Gm-Features: AVVi8CeqdaLCz7SQjvP55mGlM_peC3_8ssBMWl5Lqb8hBgKSEex-ffmqxKHC718
Message-ID: <CAJ-ks9=E-0W2igNWFRqXVA0XCkjfqWPHbQeXRDL07QZN7m0juw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] commit-reach: handle cycles in contains walk
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 12:29=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 08, 2026 at 07:36:34PM -0700, Tamir Duberstein wrote:
>
> > @@ -744,7 +745,7 @@ static void push_to_contains_stack(struct commit *c=
andidate, struct contains_sta
> >  }
> >
> >  static enum contains_result contains_tag_algo(struct commit *candidate=
,
> > -                                           const struct commit_list *w=
ant,
> > +                                           struct commit_list *want,
> >                                             struct contains_cache *cach=
e)
>
> OK, we must lose the const here because repo_is_descendant_of() does not
> have it. We could add const to that function, though that cascades down
> to a few other helpers (see below). I'm not sure if that is making the
> world a better place, or if it is just const pedantry.

I left the signature change local rather than propagating const
through the other reachability helpers.

>
> diff --git a/commit-reach.c b/commit-reach.c
> index 5df471a313..8cede01f01 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -563,7 +563,7 @@ int repo_get_merge_bases(struct repository *r,
>   */
>  int repo_is_descendant_of(struct repository *r,
>                           struct commit *commit,
> -                         struct commit_list *with_commit)
> +                         const struct commit_list *with_commit)
>  {
>         if (!with_commit)
>                 return 1;
> @@ -955,11 +955,12 @@ int can_all_from_reach_with_flag(struct object_arra=
y *from,
>         return result;
>  }
>
> -int can_all_from_reach(struct commit_list *from, struct commit_list *to,
> +int can_all_from_reach(const struct commit_list *from,
> +                      const struct commit_list *to,
>                        int cutoff_by_min_date)
>  {
>         struct object_array from_objs =3D OBJECT_ARRAY_INIT;
> -       struct commit_list *from_iter =3D from, *to_iter =3D to;
> +       const struct commit_list *from_iter =3D from, *to_iter =3D to;
>         int result;
>         timestamp_t min_commit_date =3D cutoff_by_min_date ? from->item->=
date : 0;
>         timestamp_t min_generation =3D GENERATION_NUMBER_INFINITY;
> diff --git a/commit-reach.h b/commit-reach.h
> index 3f3a563d8a..76e82f827e 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -37,7 +37,7 @@ int get_octopus_merge_bases(struct commit_list *in, str=
uct commit_list **result)
>
>  int repo_is_descendant_of(struct repository *r,
>                           struct commit *commit,
> -                         struct commit_list *with_commit);
> +                         const struct commit_list *with_commit);
>  int repo_in_merge_bases(struct repository *r,
>                         struct commit *commit,
>                         struct commit *reference);
> @@ -93,7 +93,8 @@ int can_all_from_reach_with_flag(struct object_array *f=
rom,
>                                  unsigned int assign_flag,
>                                  timestamp_t min_commit_date,
>                                  timestamp_t min_generation);
> -int can_all_from_reach(struct commit_list *from, struct commit_list *to,
> +int can_all_from_reach(const struct commit_list *from,
> +                      const struct commit_list *to,
>                        int commit_date_cutoff);
>
>
> > +cycle:
> > +     free(contains_stack.contains_stack);
> > +     clear_contains_cache(cache);
> > +     init_contains_cache(cache);
> > +
> > +     result =3D repo_is_descendant_of(the_repository, candidate, want)=
;
> > +     if (result < 0)
> > +             exit(128);
>
> We are feeding the whole initial "want" list, so we should get a correct
> answer regardless of how far we got into the cycle, which would run into
> problems (e.g., if the cycle existed only on some branch of the
> history). But going back to the initial list will always be correct.
> Good.
>
> Two small points, though.
>
> One, the call to init_contains_cache() is redundant here; the clear
> function is documented as making things ready for use (it's a little
> hard to grep for, due to macros, but the docs are in commit-slab.h).
> It's probably not hurting anything.
>
> Two, the call to exit(128) is unusual for our code base (I'd guess it
> was cribbed off of the top-level exits in builtin/pull.c). We'd usually
> die() instead. Even if repo_is_descendant_of() produced its own error
> message, it may be useful to mention that we were falling back to it due
> to a cycle.

I removed the redundant initialization and replaced exit(128) with
die(), adding context that the failure occurred after detecting a
cycle.

>
> But even better is if we can return the error up the stack. We do not
> return errors from contains_tag_algo() currently, but it has only one
> caller. And that caller may also directly return the result of
> repo_is_descendant_of(). So could we just pass that along?
>
> Perhaps not. Looking at the callers of commit_contains(), they treat the
> result as a pure boolean. So probably calling die() is reasonable, and
> we already do so via parse_commit_or_die() elsewhere in the algorithm.
> That does leave a potential lurking bug for the non-tag-algo code path.

I traced the callers. Returning an error from commit_contains() would
only move the fatal check into apply_ref_filter(): its NULL return
already means =E2=80=9Cfiltered out=E2=80=9D, filter_and_format_refs() retu=
rns void, and
the branch caller ignores filter_refs()'s return value. Propagating the
error to the command would require changing that whole chain, and none
of the commands can recover from an unreadable commit.

The series therefore makes both cases fail explicitly. Patch 1 calls
die() if the cycle fallback cannot read the ancestry. Patch 3 calls
die() when the ordinary non-memoized walk returns -1.

>
> > +     *contains_cache_at(cache, candidate) =3D
> > +             result ? CONTAINS_YES : CONTAINS_NO;
> > +     return result ? CONTAINS_YES : CONTAINS_NO;
>
> So we actually cache our discovered value. Cute, and it might save us
> from hitting the cycle again, though not always. E.g., two candidates A
> and B share a parent P, and the cycle starts at P but does not include A
> or B. We discover the cycle and cache the value for A, but discover it
> again for B.
>
> We do lose all of the existing non-cycle cached values when we call
> clear_contains_cache(). But we have to at least clear out all of the
> IN_PROGRESS commits. It is hard to care too much about optimizing the
> outcome for this case which we expect to happen approximately never.
> So I think doing the simplest correct thing is OK.
>
> > +test_expect_success 'tag --contains handles cyclic replacement histori=
es' '
> > +     first=3D$(git rev-parse HEAD~2) &&
> > +     second=3D$(git rev-parse HEAD~) &&
> > +     third=3D$(git rev-parse HEAD) &&
> > +     test_when_finished "
> > +             git replace -d $first
> > +             git replace -d $third
> > +             git tag -d cycle-a cycle-b
> > +     " &&
>
> We usually &&-chain the commands inside test_when_finished. If they
> fail, the test harness will note this and complain (if the test was not
> otherwise failing). It's usually not a big deal either way, though
> sometimes it can catch silly mistakes (e.g., if you wrote $second
> instead of $third and the "replace -d" is quietly doing nothing at all).

Fixed in v3.




>
> I'm a little surprised that the chainlint checker doesn't catch this,
> but I guess it doesn't know to recurse into the snippet handed to
> test_when_finished. It probably is not really worth the trouble to teach
> it to do so.
>
> Otherwise the test looks good to me.
>
> -Peff
