Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E58E2FD696
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961797; cv=pass; b=jsN15QwnujJoOOjsm9i95W7z/BgzK2QepHoHKII90Kf7QUFWhzRqYgI9X6p1qsCvTKWGCcjvUEr39AF9aunO3k8broCBLfEJQ52HGCcbveUpCoE/yN5jzC04fnC2IBijqe4enIZ/JdtB1K+DAhVr4CRv0AOHLbJcNiPoXv7sfXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961797; c=relaxed/simple;
	bh=W7CgMp3ou5LcXgJuV8pta3j1xu/FZjIC1+flaLDsft0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP9wtvCfSh+ykNx9hS45Bnb/J37/qHCJweUgHP0+CvCWq4QVfVWdCnyM8P4rQWTFmn1JjS9sVjz2aXIEQ5t6Z9ry/B8PASwQyoSh01SMO3quC8ndyy5i17bJuj1tdKoqnXSD4PaBd5EGhZ01EaPuEuF/0RCVFCALdRJd/KwrhbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXly9qpS; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXly9qpS"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39676d82b7fso48773781fa.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 16:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780961794; cv=none;
        d=google.com; s=arc-20240605;
        b=E/i8xgJpR1LSq5jv7HJYWsWC3goDWvLZeYyZ6OO7gT2jmAh0d9hivhQ9xneYEXD0VF
         49WimKB/dP0uI6+DHaAPG2SIFwSfHfLFYersijJxdOaEiNZYwE4cQnTyZas9R64MoY+u
         FS7XFXlI9jf8gO6dD9CkIz/LmOQE4/YvDqsfWvlB0sEIjsTHYX2Yp0GcYylvEP7CNN8s
         I1trkzbdrvVAVszly+JrCYxrZb5BlxQKHRAnHCSxNgsZYxiR8r1SBU69SEjEc0oRzrFL
         R2hgGIc3qqhQgDE4+xtxwT/tJlwDxFvtPmHxf+6kNpkQP2Tqt+4NxhCm9YQFGggDOdhA
         asmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L51WxqjIxeUKmdVW2+PFdc3fjkKIUy+UT/VqYEDec1k=;
        fh=0sP8vNBMoPrJt4N+8lv1KhHoaXZSY+AKtnt49/tLkeE=;
        b=dQZHai+i5J8styVueKyvWM41BwDxaHzaN4SZzR1GsgWmVo/w0XQy8UZrByBpi8mpss
         SVqJnqjEkB1PW1fYHuaF3d3Ts6QCoYI+0Uj3LSpXOa6xX7nQEVDlXvdLujEKpSlJgU4N
         U4p/b9QKAt2VZHwrxjzlhcmqgkAOvDqTP6ka6GFRbMVTUBdVFCZ+85LNHquulXrr/fbx
         vafkHStAido/Q+tQf/2r2cGfH4wj1u4bk1P803OKVIIxNgDvdv9/L2r4rG2/yG8etiuH
         tJ5yk5p1otjaLUM5WdmCeqGt5tlDUdVmzTR+V4G3bmCmhj+kTGMrMhXNaNf8nvmtTO2k
         hQqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961794; x=1781566594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L51WxqjIxeUKmdVW2+PFdc3fjkKIUy+UT/VqYEDec1k=;
        b=ZXly9qpS3opu/KhGZYvVQK0Vic3y8A9ZdmsNu9RajN48o02e42nW4Yppqt9v0gMpiC
         lTQcnoE7Y4t0vQAgToM/0ftl9abz8EFE18Dk08b+brlQfabWl4jQaOkxa5umeRCvC82u
         PDBUYaKha2wKuu0b5ffvkaVUcCTXcNCKaA2dUKmJKK5NCe/Q2HnxEV0Bxlp/S/8rm2A2
         4Q2TxKLrOKY2mUxA2/o4d8M0/JdlwmcYaPfoljDTJMYdSsaqoKxEL1936PlnTO9bhlL1
         0Lb9gFpUnakwpKEoljX0vB/ihiW49Xiu7LMXQLZrB+oWRdIS7jn7o5W9+Dn90qwW1a5a
         YM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961794; x=1781566594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L51WxqjIxeUKmdVW2+PFdc3fjkKIUy+UT/VqYEDec1k=;
        b=dR5YFJyLC9Y5QCQPk8TvRHo2Nj3TBJi3WOOervkoziBRhJ3pmM8IytRZvSl6HJWj0K
         kMzytcMqZcHGaVOSF32iRvTZxDLQqT0c9OCjCQozdbk+4g4y6SnceNJdN07+CivzlCiy
         c0JH6xCEVRwiGHwvze2gzBNvYRBc6Nlcs4DV4xzbn99vLxaOvGWuS/pioKtdvQMgfpJY
         pvSeVOHjZA5ZQVFxWW+3IRwcgNLzDzITXC/UXKBqkQlxO2IGZKofr2cdhsoRzg8JW9Bb
         cwff5mKBLvG+FLdoGNcsISWcL14aERdqoooYTNksYx8tAnXzT9QMLwly4vSkuOzWDSq0
         mUAw==
X-Gm-Message-State: AOJu0YzFh863IWMM0JQlwtzK8A/9n1Tby7cFnt0HlbS3SV0WdfztWmxj
	VfXtESuq7LnCQgnWO04yDJJ8aLCfx46xfb303GGyMOk/ZZ5nL5gxtL0wGK3Euw3lEiVcw8mSU4m
	Io9OfvfbThBaCEvmPrg0wIKyfnQFm4pA=
X-Gm-Gg: Acq92OE40/p2V5X4mimvnw0vca3cdfkqVr1X9XIKSmRcLBPisyO98BPgzJidi0d7QgS
	qNssX62PNP3UR0fPMtLlEMeudFHhSL1g85Mq+473lQjHjs3XlhI5QU2I+yw0wJC52TW0ruNvQmN
	8OmDOE1Uu7KFf/4yE/qS32u41T4WWroQFnE2Dr0G0hvMd5Ap2rPjt5boyIj1F9TTl0rnHPtnnd7
	XT4x8ofjvmydi+p61QfBcgim0zj83xpJ2EDHBmawY12cLpcP+Bu87sfwGfqyl93i/4cd8bkYNAm
	6wgPI16V+H8f6wqbMWyblcYmsZ/tGhzK0+I1LrUnnwIaeiS0AG8yShmC7c+NVPynLDagmTnfxKH
	osFcuDbtL2zs8W41dzQ70EUAy13T90Qw=
X-Received: by 2002:a05:6512:32c8:b0:5aa:6ba5:9a4e with SMTP id
 2adb3069b0e04-5aa87c233bemr5032655e87.22.1780961794360; Mon, 08 Jun 2026
 16:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>
 <20260608223430.GA340696@coredump.intra.peff.net>
In-Reply-To: <20260608223430.GA340696@coredump.intra.peff.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 19:35:57 -0400
X-Gm-Features: AVVi8CctVTEkjf675lPUM3vqPeJPquKljoebho_-aKO0i2ysQl5qWViWLsScKLY
Message-ID: <CAJ-ks9ng3Obv8jydYiBD4kxmTSZCJX8xNb0YihNeSW8_8WL5Ew@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: reuse --contains traversal results
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 3:34=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sun, Jun 07, 2026 at 08:33:29PM -0700, Tamir Duberstein wrote:
>
> > git branch and git for-each-ref call repo_is_descendant_of() for each
> > candidate selected by --contains or --no-contains. Each call starts a
> > new graph walk, so refs with shared history repeatedly traverse the sam=
e
> > commits.
> >
> > ffc4b8012d (tag: speed up --contains calculation, 2011-06-11) introduce=
d
> > the tag traversal that caches positive and negative answers across
> > candidates. ee2bd06b0f (ref-filter: implement '--contains' option,
> > 2015-07-07) preserved the branch and tag implementations when ref-filte=
r
> > learned --contains. 008ed7df930 (tag.c: use the correct algorithm for
> > the '--contains' option, 2015-10-18) noted that they should be unified.
> >
> > Use the memoized traversal for every ref-filter contains check and
> > remove the implementation selector. The cache records answers for one
> > fixed target list, so document that callers must clear it before
> > changing the list.
>
> The subject line obfuscated the intent here (at least for me). I think a
> more clear subject would just be: "ref-filter: always use
> contains_tag_algo" or something.

Ack, changed to "ref-filter: memoize --contains with generations" in v2 dra=
ft.

>
> But more importantly, I think the analysis above is missing a key point
> about why we didn't make the tag algo the default in the first place: it
> is depth first, and thus slower when the merge base can be found quickly
> by the breadth-first traversal. For tags, you tend to have to look at
> all of history anyway (because you have at least one old tag that
> requires walking back that far), but that is often not true for
> branches.
>
> We are able to get the best of both worlds if we can cut off the
> depth-first traversal early using generation numbers.
>
> So I think a better rule here is to tweak the selection in
> commit_contains() to select the depth-first algorithm when we have
> generation numbers enabled. There's a patch in an old thread, which was
> revived a week or two ago by Kristofer (cc'd):
>
>   https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotify.com/

Very good catch, thank you. I reproduced the regression with a
100,000-commit history and generation numbers disabled. The parent
took 13.0 ms, the unconditional depth-first version took 238.4 ms, and
the generation-aware version took 9.1 ms.

I didn't find a patch in that thread, so I will reroll using the
memoized walk for tags or when generation numbers are enabled, while
retaining the breadth-first walk otherwise. If someone else would
prefer to send that patch, that is fine by me as well.

>
> > The memoized depth-first walk assumes acyclic ancestry, but replacement
> > refs can create cycles. Track commits while they are on the walk. If a
> > cycle is found, discard partial cache entries and use
> > repo_is_descendant_of() for that candidate.
>
> I can believe that the depth-first code doesn't handle cycles well. But
> if that's the case, then it's already a problem for "git tag
> --contains". And we should fix it as a separate patch from enabling that
> algorithm in more cases.

Agreed, and Karthik flagged the same. The cycle handling is now a
separate first patch.

>
> I'm not quite sure how ancestry should be defined in a cycle. How does
> the algorithm behave now when it sees a cycle? If it loops infinitely,
> we definitely would want to fix that. If not, then to some degree I
> don't care too much what answer is provided, since the input is somewhat
> nonsense in the first place. And if it is expensive to track, it might
> not be worth inflicting that penalty on the sane cases. But it looks
> like your solution is just setting an extra flag value in the slab,
> which should be pretty cheap.
>
> > The branch and for-each-ref path passed repo_is_descendant_of() through
> > a Boolean interface. In configurations where it returned -1 for missing
> > ancestry, ref-filter treated the error as "contains". The memoized path
> > instead fails when ancestry cannot be parsed, as git tag already did.
> > During review of the 2018 reachability series, making parse failures
> > fatal was explicitly deferred because that series was intended to
> > preserve behavior. Unifying the implementations now makes all callers
> > fail consistently instead of preserving that accidental Boolean
> > interpretation.
>
> I think that's a good outcome.
>
> > The added p1500 case uses up to 8,192 packed refs along one first-paren=
t
> > history. It improves from 0.68 to 0.03 seconds.
> >
> > On a checkout with 62,174 remote-tracking refs, I ran:
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
>
> I didn't time it, but the probable regression case is something like
> this: a very deep history with a small number of branches diverging only
> a few commits away. Without a commit-graph file (or one without
> generation numbers), that probably makes "git branch --contains" slower.
>
> -Peff
