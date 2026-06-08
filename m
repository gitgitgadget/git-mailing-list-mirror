Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9A347520
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933635; cv=pass; b=hxS5LI3k7vW1kl5y2SzVdiEarf28z+8q2G7oe9MHYi4aXMcV2Xc9sFIpovU+lX/ogIULxUACAaSf1b9T/HFzNWvCon9c3un3J+MUL+0xx1u+c7YTV5NVEV2NtU3qEcGpUos0+Ys2Bq5m5XTnIUSgPOtyjn4queyTFlpR0eJBttk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933635; c=relaxed/simple;
	bh=R0qnA5p4GGSXWDJZvqDxRYCJ5Eg8li08KVFn1sR6+ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/ev7KXho4+Mib4aUwTbTD6MDEPHnZr3i8E9KG9RSTxNizTx9mAwhr+4V13mEka5MayIa1/lcEuN7j3mzI5LiC5ouy6MOF4I51+GROlZDijGhgYFVm2b1aWtUiHHI9xgmbyQoUYCHFwb731obeeSCign93YPj91TKWf74euL1t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/NQa5NP; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/NQa5NP"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3965adfd75fso40339211fa.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 08:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933632; cv=none;
        d=google.com; s=arc-20240605;
        b=BhoDWS6bIUgW6u47GpauH0H4pzvOEQ4CL7F1YLVSYFAI2ufmuR/SUNo4PR7q2vfOAO
         /F4x+vZVDnzMVTVyCeIkxtqXKMSBE6HmP7fOKXnsfzYRYlvdFWd9ocTpsBQSeC93AKr4
         FRJAaD+hq5TBz3be6k3gezSxKP1rl/XvEZaw81S6FuiJ3JjlWHf01taa+TMvQvC9k3qP
         DnNHtj2JGYHXG31ktatUpRzmSdKChHIgJHTyf81j88ThNNKtv/psOEVeNJanv2Ln02t4
         0IPMGcN6b1mpydPk/acf/E8WfUlzK4oPTmqzOmm1LAjwJVdGYjutECJqv8RWLNNVGHGS
         T0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8wyVQpudaZXLpdlXNFskGTxC9aUcS6xJkMGTEPMjqRA=;
        fh=nlcSYKc7XLG4P73XxYqieZJfqVKiSXepDPq9BNlwQGw=;
        b=QU0UAXrIUJUS2wVKYt81vljcRZ/Q+08KyZyM2b/x2G/Mmg67l/3m7k5dJfporXEmVO
         E7mKdznXCgc3s6drFe5Fqwko6m/fUxFQxRg5ij+URg9gLIH/LKUxi7hjHwfDa3ZEaqKy
         MhBwycbnDD/NyasmazLLzErlUcvG2yHPeO9eTQWDdOQYEW/NkpTffH+1L6/l/DnJ/Y4l
         zCaCY8PN3YSBnt51VBy3vMnJNi/DuEPjBmBvi0OjejvyMezuXBFR65j52cji1kP9iPMm
         4FmSkR6iGFjTXlpejZ6MJwUowGpiOY19hPjamA2gPEhFWn03/3JQF2gf0XVz7LzSvTUN
         P47w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933632; x=1781538432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wyVQpudaZXLpdlXNFskGTxC9aUcS6xJkMGTEPMjqRA=;
        b=a/NQa5NPl70zRrg9meWWjxbOwSxiSq6OY3rZgpKEQOQ78XuWWem7qU1fFpgLVRH+gQ
         pXIUBsilguBeSj7F5MdWkngBRamBz6/3x0Cf883jzQDLpyAXgQ9BuH/SO9qoPMtzSm3Y
         WsGBURznIdSD6hi3gpAiXTSfS86qk+VYdPqETpNWaZxc8Bk0EmNuww5GPcOsjCqTmnBZ
         6++Dqid66Zy69R2ynkHeKMEjzgXk3Ey/pok03ZB3pd5VzB1AifI7N4o5xk0Q3gfne/7g
         jgd8lUz1fBkKdWMh626VAUz0PDAQZ1MvwToYs1CuEyA9+OE1FZzx+NVPjWDJ0cflnfmx
         8eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933632; x=1781538432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8wyVQpudaZXLpdlXNFskGTxC9aUcS6xJkMGTEPMjqRA=;
        b=QUa4h/u+xCGStQD4wJVW7lByP5WM+FaWtT18zVNUe3AOQ5SG71lNMu3YEMwiXTg7m+
         shmBOcRyErNX/VHh+5gtO3emVu4eKUnQAhvPsWmjx4DHHLRz6sN+nIRgCdSEwQRloeSy
         Fr2VlDIHetePRLaBC+1wQ2SICGr8NNHbd0FCt7MWEZTemY7pETQ+344U7h1JEE2QYgXD
         n6Ny095Ob4cPJ4zVckxOUre+cNJR3AMPDa+qzrFJ0iaeV6etbfEcwZxfpGuZhydIqdRb
         S/c6sm9O0OECic5hpgaoAc4f8+Ymnwl/XnxCZJIYInPh0fqkhHjSuWybDDjSwlu4dbdK
         Bh/w==
X-Gm-Message-State: AOJu0YzaPH37Q3wzDtYH2MS1Ql8YSlKMBJx77Y6eJsyd3Tf8MCs5f019
	FBkS3wOsRafCv4B3r+p0nyp3pN7FzUH4Ci2zkJeMd0Ro5NpfkthzekHOjxoGkCYO9I6o1Wjp0G8
	Z3Hn8eM6Wn9+xsn1AIabzTImtRB0KVlGpwhKEcyY=
X-Gm-Gg: Acq92OF3GBmJjAWdTajETzDlPtRUXK4kvIVWYS8I+TQJbV/ChKco/yGC36E2f1u4Srf
	H832MRY5vgGvBqITFfUi/78litv9HyPbuSHWkTDorLPEUEqdC+nGbgboCZSJBg1OvI15z9styPx
	Rc+tRktFAb0YK72Mhg+RTstXOs9I1WaSu7BNFNyg0N4HDiri74B1oM6DtdjaQLqmtZ5YJhivBa+
	r1XMhHdv0coNY221oHHNfY40lKd/YrTIyobOgQgN4VB1iRQWfe71SKPyibjPVcJ+iIbYbj064C+
	NIW4+J66If7cZATLWcIJTVht58zf5WT5TqRcLgg3Fcj/REkDRvbZFOmxnaqosZSv67S4wThmRUY
	aG2J2JHldABoV07mUDg2zcBwNF6SYTb4=
X-Received: by 2002:a2e:bea6:0:b0:394:3b62:b6aa with SMTP id
 38308e7fff4ca-396d07e3902mr46479801fa.12.1780933631482; Mon, 08 Jun 2026
 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com> <aiZoYE8koq1UKlWq@pks.im>
In-Reply-To: <aiZoYE8koq1UKlWq@pks.im>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 11:46:33 -0400
X-Gm-Features: AVVi8Cdewy3ebxZQJtN9rj7SsIqG_ydr9r2KpO54AMeiOvkEEkklOg3zeNBOvgI
Message-ID: <CAJ-ks9nPJVM0ik=yua9f2TSKkQWUWEUkZHZBQcdRq3P+3aA3iA@mail.gmail.com>
Subject: Re: [PATCH] describe: limit default ref iteration to tags
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 11:59=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sun, Jun 07, 2026 at 04:51:53PM -0400, Tamir Duberstein wrote:
> > Unless --all is given, get_name() rejects every ref outside refs/tags/.
> > The rejection happens only after the ref backend has enumerated the ref=
,
> > so repositories with many other refs spend most of a simple describe
> > invocation visiting refs which cannot affect its result.
>
> Right. The relevant block is this one:
>
>         if (skip_prefix(ref->name, "refs/tags/", &path_to_match)) {
>                 is_tag =3D 1;
>         } else if (all) {
>                 if ((exclude_patterns.nr || patterns.nr) &&
>                     !skip_prefix(ref->name, "refs/heads/", &path_to_match=
) &&
>                     !skip_prefix(ref->name, "refs/remotes/", &path_to_mat=
ch)) {
>                         /* Only accept reference of known type if there a=
re match/exclude patterns */
>                         return 0;
>                 }
>         } else {
>                 /* Reject anything outside refs/tags/ unless --all */
>                 return 0;
>         }
>
> So we really only use tags unless "--all" is given.
>
> > Commit 8a5a1884e9 (Avoid accessing non-tag refs in git-describe unless
> > --all is requested, 2008-02-24) moved this rejection before object
> > lookup, but left iteration unscoped. Pass the existing refs/tags/
> > restriction to the iterator unless --all is given so the backend can
> > avoid unrelated refs.
> >
> > On a checkout with 124,357 refs, of which 330 were tags, I ran the
> > following command with the parent and patched binaries:
> >
> >     hyperfine --warmup 3 --runs 15 \
> >         'git describe --always --long --abbrev=3D40 HEAD'
> >
> > The results were:
> >
> >              parent       this commit
> >   elapsed    196.2 ms      63.3 ms
> >   user        69.5 ms      48.0 ms
> >   system     123.0 ms      12.0 ms
>
> It's a bit curious that you don't post the hyperfine(1) results as-is
> here.

Agreed, will include that in v2. For reference:

        Benchmark 1: parent
          Time (mean =C2=B1 =CF=83):     171.7 ms =C2=B1  18.5 ms    [User:=
 23.9 ms,
System: 133.6 ms]
          Range (min =E2=80=A6 max):   142.3 ms =E2=80=A6 198.3 ms    15 ru=
ns

        Benchmark 2: this commit
          Time (mean =C2=B1 =CF=83):       9.9 ms =C2=B1   1.1 ms    [User:=
 3.3 ms,
System: 4.7 ms]
          Range (min =E2=80=A6 max):     8.8 ms =E2=80=A6  13.1 ms    15 ru=
ns

>
> > The wall-time standard deviations were 13.2 ms and 2.6 ms, respectively=
,
> > for a 3.10x speedup.
>
> Makes sense that this would result in a sizeable speedup, depending of
> course on the shape of the existing refs in the repository.
>
> > diff --git a/builtin/describe.c b/builtin/describe.c
> > index 1c47d7c0b7..3532c8ff22 100644
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -740,6 +740,9 @@ int cmd_describe(int argc,
> >               return ret;
> >       }
> >
> > +     if (!all)
> > +             for_each_ref_opts.prefix =3D "refs/tags/";
> > +
> >       hashmap_init(&names, commit_name_neq, NULL, 0);
> >       refs_for_each_ref_ext(get_main_ref_store(the_repository),
> >                             get_name, NULL, &for_each_ref_opts);
>
> Another performance optimization that we could do here is to wire up the
> exclude patterns via `for_each_ref_opts.exclude_patterns`. But that's
> outside the scope of this patch series, and also much less likely to
> help many use cases out there.

I tried this and have a separate patch prepared.

The patterns cannot be passed through verbatim: `git describe
--exclude=3Dfoo` excludes the exact name `foo`, while the refs API would
treat `foo` as a directory prefix and also skip `foo/*`. The patch
therefore passes only patterns consisting of a literal prefix followed
by trailing asterisks, adds back the applicable ref namespace, and
retains the existing callback filtering.

With 30,000 packed remote-tracking refs under an excluded prefix, the
perf test invokes `git describe` ten times per run:

```
                                  master           patched
describe excluding many refs   0.16(0.07+0.05)  0.12(0.04+0.05)
```

That is a 25% wall-time reduction, with user CPU falling from 0.07 to
0.04 seconds.

I also tested a larger checkout with 62,170 refs under
`refs/remotes/origin/`:

```
git describe --all --exact-match --exclude=3D'origin/*' HEAD
```

This improved from 176.7 ms to 161.3 ms, or about 10%. Startup work
unrelated to ref iteration dominates more of that repository's runtime.

>
> > diff --git a/t/perf/p6100-describe.sh b/t/perf/p6100-describe.sh
> > index 069f91ce49..dfcaf59e90 100755
> > --- a/t/perf/p6100-describe.sh
> > +++ b/t/perf/p6100-describe.sh
> > @@ -5,6 +5,12 @@ test_description=3D'performance of git-describe'
> >
> >  test_perf_default_repo
> >
> > +test_lazy_prereq PERF_REFFILES '
> > +     test "$(git rev-parse --show-ref-format)" =3D files
> > +'
> > +
> > +ref_count=3D10000
>
> Let's not declare this variable outside of tests.

Done in v2.

>
> > @@ -27,4 +33,18 @@ test_perf 'describe HEAD with one tag' '
> >       git describe --match=3Dnew HEAD
> >  '
> >
> > +test_expect_success PERF_REFFILES 'set up many unrelated refs' '
> > +     git tag -m tip tip HEAD &&
> > +     for i in $(test_seq $ref_count)
> > +     do
> > +             printf "create refs/heads/describe-perf/%05d HEAD\n" $i |=
|
> > +             return 1
> > +     done >instructions &&
> > +     git update-ref --stdin <instructions
> > +'
>
> Why is this limited to the "files" backend, only? The logic should work
> for both backends as-is.

You're right, fixed in v2.

>
> Thanks!

Thanks for the quick review!
