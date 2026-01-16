Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90F303A1E
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552246; cv=none; b=gv57w1bBh0BV6FB+VbIUtlox5Hb7IKnyQsg8UkaELlbL6Uo/nndpSYADLXkvnk2bKBoy0z202PMjl7g0s5p8uvz+BzyISl0OLGobng3j1hWEhZASaxVvESgerNqqUwryl2oUeX/HlzhjhLcnxxuUrCFaMK5tnp1hkl+r9lcSw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552246; c=relaxed/simple;
	bh=N9ktUAJ+3gUDtVVYnsK38gndKBZTq5qkd8N/kGjjMi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMOKuImuoTFxLKguCsIy799rdZ9goGMvOXRSkdlCW4Y2GTnyM7mdAi21bVlKUBdNj/xD3iX0SpwC7larvw/2nZiz1lWH8oqHTjib2GwdiIBQ1ShW0xC+qjBgedxHItnteyjYLqwc34QAHZYtC1ikpOhmv4Wy8QhmZfJ2CUat+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwpIIiSR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwpIIiSR"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78fb9a67b06so17504637b3.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768552244; x=1769157044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiBSY6HPlvqCph00pdV0fD4b65p+p0c6Hf4LzmKB3bc=;
        b=RwpIIiSRcMYlMRTEwEd4XZuQL3S89C6X4KxE1DKVuoHZg9EK+EVJMiDtuJxNDdgO1B
         7KQgHiuZ/beZkXQWk5DCaf+FctUA2Dg9Ogc2xaKIDRPwGPgyhu31KM/f+nq6i4EiRore
         ZJWNH7my7tYl6PbmxyP8IQv5pCJDrsklx7wM8QEgLoB59cXXvIZL2Fa+Y9RBteuvcKTr
         cPQDrPfRrct4aihwGB4Uvd7qmLyQiNjLfzxmNJ1KSr/AsYDIVPZfwZUlA3NqSwFEemqp
         I+Lrw2ErYn7Y3DjSBxyN0WkzgxoNCv8g894NXRV5AyCr+VNTmTdPdo0F8jybaZFaVZs8
         BbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768552244; x=1769157044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qiBSY6HPlvqCph00pdV0fD4b65p+p0c6Hf4LzmKB3bc=;
        b=MscQqAhPItWkfXovTWPy8H3rlIbMCGbAybjO8ke+UIMt4gScIgJS9Co9SQ9YIpxHgJ
         gy/v86kgw8UlYTUyPYkkjkMo1S0IKuEqoxe2KD9dp4XC7m3/i3JgCRHc0LNRoq22HI9i
         9XhxZ96H/uSUOkZD+if3HQF1Iud7dO45Tw+BalSDA+pdemYhKRpM6PdLat/x0c2lQF6X
         /LLxGVBKBwueEeKuTJtPrGjo1ifokJ2iozqf1ZRKI4YBGUglCt2fDHxV4yWFqPgyfQd8
         /ewHUPXZs9Hi/CUmSw1SUOT3qAX3z4UKYvJJxkz5azgN2sZkYkpMumQHg1OA5uKog0CQ
         nJeg==
X-Gm-Message-State: AOJu0YzSAcAFH36QqoY0TM1CO1TFFw+cc8NDkpFbJGHJiQ/49Wpu3jEB
	tMunu7GBTUpUzblxI0AGMZ7Hp0CnuEoYSHu/pg52pfFYsfxCuWQ5F7slR+b1tl3XhvM0yoVT5r4
	iV1SM4mVhLmkqLVa/fCu4Ch3NRx8rLTY=
X-Gm-Gg: AY/fxX63om0v9MWG3cK452yhB5tHkJoO3Or6ugu7kccqeoDoxUAeoBe6juysixHuI6n
	CpWBOKrMgKchU4EujYotv3nJS0riXN1SYG6HuUXhrgGYW0fAp5fF9fipB6+H8wVJgDOWUApUm5r
	S91DbpLx7/3qWNPjymS1ajxbVO9ccLMOnBGWVjHINZigDwlWcOy8nIPUZrrqQkVg3Lr6I8+OXr9
	ukZT5Z5g8FNqHre9xOqgwhNJPIhd8WrnMmWxk+DxsnIhs1VFokQlM1lmV1RBTQKuFt1tZZq87Vc
	4lObpgIc/lrmJFIASbmrWQNtS4mg
X-Received: by 2002:a05:690e:128b:b0:641:ffaa:4eda with SMTP id
 956f58d0204a3-64917763057mr1475048d50.74.1768552243861; Fri, 16 Jan 2026
 00:30:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114192803.4852-1-amishhhaaaa@gmail.com> <20260115130935.93526-1-amishhhaaaa@gmail.com>
 <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com> <fc14e0e5-93bc-4805-a20d-d2aa4eb87ddb@web.de>
In-Reply-To: <fc14e0e5-93bc-4805-a20d-d2aa4eb87ddb@web.de>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Fri, 16 Jan 2026 14:00:31 +0530
X-Gm-Features: AZwV_Qgd6Ctp27cqVJMQYDOpoGBsZXHlN-ltvJM3VblUHre2YTL_wJkTr783gdU
Message-ID: <CAPvEtrdQ7LB4p0_yCg+ef6fsWSHwxA8C1uX0SJbfnV3vfQHD_g@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com, newren@gmail.com, 
	peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It was assumed to be safe under the notion that our entries are not
duplicate but as already pointed out, our entries are not unique so we
need one of those two ways either insert or remove_duplicates, this
can be a trivial question but i wonder how are the tests passing by
removing these lines, i was actually researching about it.

On Fri, 16 Jan 2026 at 03:56, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> On 1/15/26 2:15 PM, Amisha Chhajed wrote:
> > Made the changes for other 2 places as well!
> >
> > I was also very curious about the presence of
> > string_list_remove_duplicates in the original code, from my
> > understanding string_list_insert already removed duplicates and
> > string_list_remove_duplicates was still present with it.
>
> So the string_list_remove_duplicates() calls were unnecessary with
> string_list_insert(), but why is it safe to remove them now that you use
> string_list_append() instead, which doesn't check for duplicates?
>
> >
> > On Thu, 15 Jan 2026 at 18:39, amisha <amishhhaaaa@gmail.com> wrote:
> >>
> >> Improve O(n^2) complexity to O(n log n) while building a sorted 'strin=
g_list'
> >> by constructing it unsorted and sorting it afterwards.
> >>
> >> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> >> ---
> >>  builtin/sparse-checkout.c | 8 +++-----
> >>  1 file changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> >> index 15d51e60a8..edabe7cbd9 100644
> >> --- a/builtin/sparse-checkout.c
> >> +++ b/builtin/sparse-checkout.c
> >> @@ -91,7 +91,7 @@ static int sparse_checkout_list(int argc, const char=
 **argv, const char *prefix,
> >>
> >>                 hashmap_for_each_entry(&pl.recursive_hashmap, &iter, p=
e, ent) {
> >>                         /* pe->pattern starts with "/", skip it */
> >> -                       string_list_insert(&sl, pe->pattern + 1);
> >> +                       string_list_append(&sl, pe->pattern + 1);
> >>                 }
> >>
> >>                 string_list_sort(&sl);
> >> @@ -289,11 +289,10 @@ static void write_cone_to_file(FILE *fp, struct =
pattern_list *pl)
> >>                 if (!hashmap_contains_parent(&pl->recursive_hashmap,
> >>                                              pe->pattern,
> >>                                              &parent_pattern))
> >> -                       string_list_insert(&sl, pe->pattern);
> >> +                       string_list_append(&sl, pe->pattern);
> >>         }
> >>
> >>         string_list_sort(&sl);
> >> -       string_list_remove_duplicates(&sl, 0);
> >>
> >>         fprintf(fp, "/*\n!/*/\n");
> >>
> >> @@ -311,13 +310,12 @@ static void write_cone_to_file(FILE *fp, struct =
pattern_list *pl)
> >>                 if (!hashmap_contains_parent(&pl->recursive_hashmap,
> >>                                              pe->pattern,
> >>                                              &parent_pattern))
> >> -                       string_list_insert(&sl, pe->pattern);
> >> +                       string_list_append(&sl, pe->pattern);
> >>         }
> >>
> >>         strbuf_release(&parent_pattern);
> >>
> >>         string_list_sort(&sl);
> >> -       string_list_remove_duplicates(&sl, 0);
> >>
> >>         for (i =3D 0; i < sl.nr; i++) {
> >>                 char *pattern =3D escaped_pattern(sl.items[i].string);
> >> --
> >> 2.51.0
> >>
>
