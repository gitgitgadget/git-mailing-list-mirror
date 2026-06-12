Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367EB33C1AD
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299531; cv=pass; b=b/33FgInGmD/hB456Y5A7RVG1nDDatlAmMbkkpkm8xbgZKN29NDwuachW+xWXHI6B8g/SZ4L9E8XLJw06Pg/7t7d3o6EtQEaCRbaRTZLeEByklVAlTxHuGUXEdku/f71EooZFrClsFk+YUXGhyjmmv61yECNf6Lg76/O5rQDII0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299531; c=relaxed/simple;
	bh=ii4Db3K596neukNfF5xne2K1Bnjj7ApJEpV2wZvhtlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcACQJg1JNZVeMYlAks2eWJlMH4kqRNcmjj7HCdagk4qJsVETPsSWYzcb36wuqB4Ku2rUzhlT6zDlsvjmbOk53Ys5wVA7occNTg9EN2vm1jcyIdq1Ijp90kvMcvs08cDSdFD79ZpH8hyslKyXbiaINcSNqzHwenS+vX1VsNjobQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWtna/5H; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWtna/5H"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so1752829e87.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781299528; cv=none;
        d=google.com; s=arc-20240605;
        b=hOksT4ASna8hrhVmpC7TYIq7GUuVZECc5BnSkwMsDwPC4FaWuqQEKr7d6OycoYS6Qn
         XmfShia7Nfat7jzjpRXXNlrn3uQ3enOB8u1GyB+4LuL6g1rjogHuSLtkvNbkVziboP1N
         qpkCknQ+1XKzcZujnShfJQyO9spK/99VyZ2CQAKUHhQEACnPi2m9DUrqw6gFrpmi99OT
         8ZQPantvERTVCkwuHXWrCwrglVv9gXtywFa4cKlLEO4Kre15Vg8GthWdFpi364ambhJn
         4cftHuzcANkTJ2zxJH9NPVD9OtHnjsZ7HiOoytVZdC6nmj2v/WeV64jGAZuwDHM1urb1
         0B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CRJpklIW2lyR4DJfbKL8xyYL9+7P9iZd3f049o+vMQU=;
        fh=KNao2B39r1TD1QmIXoHf31CWuKl75p9v468vqZGCSJ4=;
        b=Qr37reuvPa3Okeo9E8XFehOIHJ3mE68DdVeqGXBlbR6SM5QfcjIqBngQ5jTf3ZODgr
         PeHWgiopTmqpT39MB3CjRkKpsDqGF8lZkFz4RJiUkCyQ9nNcUlWFQW5Afh3DFkEAY1Rv
         WFG3DOoQTAWl4Etbgrdb2tNlJXj7EVsxmKPctPSsKMg7ZKu+hkCcVo0xXuIGa3BjFBXf
         PaUuckjzznGuttUUlPtpfb13lNPDtODWh2+oht571CA8prAugT3reQ/tNihaHTKFRLiE
         SqNbpx4ri8Mdvmj9phRcquB6AzL0Fuo77mUfkUpHqR+z9fpMScWb/8yEyPIMRzpEgkul
         n4gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781299528; x=1781904328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRJpklIW2lyR4DJfbKL8xyYL9+7P9iZd3f049o+vMQU=;
        b=LWtna/5Hat/fiZ7Wt+SsI9O5bQJOYjozrcP6hROmouoijtxSqd4FPuhVN96XzE6YHR
         3lvfBdnkbor5101u0tItW/UX76j/Fih7tqa1KRQdtitsEwLewZ1PAIam3BaFPe9w76Ls
         9XV++BjU+9uD1qi66zW3tNM1Oy1yiyuxE594315kIgG86nJAcZqqDtTNV6dVlnDPWFY9
         P8cosUfdZDOY3eEAyZuBkOoXV02FMbTRW2qfIBB4sW8u9XKlH8yJC238KIdzZFuXoURA
         jnPvKOyVfQti2AoTB5s7UoGmSm+D/CxyukfletcJic5e2/EnumY2xuUjBK7o+N0Ib10g
         EFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781299528; x=1781904328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRJpklIW2lyR4DJfbKL8xyYL9+7P9iZd3f049o+vMQU=;
        b=PYDDpq6gT+C4Tb3hAil/q3BuxIYDdGexNzW8Fw4+c+69Ofb1ajCVQ/jgBk0oAZuzaU
         VKEe/wI42DwQJ2ITeedABxqkbPAu2+Ix4QTC5KhvXA/fcNFqYTFLJF9ztxybPGkhIPn+
         umDQFsdOkXdyFBRLCamHQPzb42cpo9BgJzhQ2eB69UeWpf163PMU8A6OdqZ1l2FwUQsY
         PNrzllqa/o1DmbkSdjRCXd7ejvHdS6oCsW1fF4857uSA0m1ndaZ4m/y2cXXabjxKufTP
         UXc3Hm018VU5mBYVin/O1XWBIPiY8nemgZvL1Gn4zw5xOY1vaF3ZC2hwkuRRdiW21yId
         EdLQ==
X-Gm-Message-State: AOJu0YxObiFUJvGSJyzGJuedLJfdGkRMoW8sjno9KnLZYdTxdLT0kbWg
	6s/RZ5idVxkcgy18gqn5pLZrpcHJKeqkq7HyyPiWaJcgBw6G85OzNAGdHE09ipVjMmEm0125TE3
	Py0sERV6/AkxOd3DZJcKOP9G+JcfGWh8=
X-Gm-Gg: Acq92OExCcxXztggEWBv1+Qutz+ToNcvZSbYYn2l9RVx86C8rE4r6YazBbWJuBUqQUB
	+sLhBJRkK+okk3eWrFfLdH2hEM0jl3nbyffOMB32m3mSJKfS3WDnEs2FAXNMT3g6kyxFuhD0jPq
	K8ThQCSfYvMJT4NJQqr1aGqSAJOE5O3PBxMIa/e5zVVAhDxZyBuB5yMnNkDOmjNU0sD8QYfh8iP
	bP9s+aosV8IjYAKHs+gv9/PY8j+HQuFaOr7aRcpVanbZvG3VDz7WFmcmmqZj8faySWTLzqpjRiV
	LcNbGoQKl+sb4vwOw2VJHAe2MRaY2qZ8qLL+2n4zCUplr7o0jZ72Ri3k4sO1jN7bdAMX8O4kSbU
	mwxv8jMnjpaHkNCZ8I5RJ49M4sVx/SgSbF4MPanUaYn/L7J1p/bcF
X-Received: by 2002:ac2:4359:0:b0:5aa:517b:65bb with SMTP id
 2adb3069b0e04-5ad2db69ad6mr974115e87.37.1781299528215; Fri, 12 Jun 2026
 14:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com>
 <20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com> <aivx-7VOKE_TC50R@pks.im>
In-Reply-To: <aivx-7VOKE_TC50R@pks.im>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 12 Jun 2026 14:24:49 -0700
X-Gm-Features: AVVi8CeeS0UkYzmZus7ZXNtYxkvh9rsP7M7E_LXa7FAqqSnD7hkINJlRfYsCFL0
Message-ID: <CAJ-ks9mZWnx49WXnmY3=on-n=33iLBULP7qqvh=TN2kYwJK+TQ@mail.gmail.com>
Subject: Re: [PATCH v3] ref-filter: restore prefix-scoped iteration
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Jun 10, 2026 at 05:29:49AM -0700, Tamir Duberstein wrote:
> > dabecb9db2 (for-each-ref: introduce a '--start-after' option,
> > 2025-07-15) changed branch, remote-tracking branch, and tag enumeration
> > from constructing an iterator with the namespace prefix to constructing
> > an unscoped iterator and seeking to the prefix.
> >
> > The files backend constructs its loose-ref iterator with cache priming
> > enabled. cache_ref_iterator_begin() immediately applies the constructio=
n
> > prefix through cache_ref_iterator_set_prefix(), reading loose refs
> > beneath it before packed refs are opened. An empty prefix therefore
> > reads every loose ref, and a later seek cannot undo that I/O.
> >
> > For these single-kind filters, construct the iterator with the namespac=
e
> > prefix when start_after is not set. Keep the existing unscoped
> > construction for start_after, whose seek position may differ from the
> > namespace prefix.
> >
> > With 10,000 unrelated loose refs, the p6300 tests improve as follows:
> >
> >                          before   after
> >   branch                  2.74 s   0.11 s
> >   branch --remotes        2.81 s   0.12 s
> >   tag                     3.01 s   0.11 s
> >
> > Link: https://lore.kernel.org/git/aGZidwwlToWThkn8@pks.im/
> > Link: https://lore.kernel.org/git/xmqqikjq7s16.fsf@gitster.g/
> > Link: https://lore.kernel.org/r/CAOLa=3DZRHKNNymXGk31YgECjUmF9nZ8GsPUdQ=
b7aKBH5DKMz7=3Dw@mail.gmail.com
>
> I honestly have no idea what you want to say with these links, as they
> seem to just link to random reviews mails when the above mentioned
> commit was reviewed. In general, we typically try to embed references
> like this into the explanation, like:
>
>     In [1], we discussed... and this is relevant because of ...
>
>     [1]: https://lore.kernel.org/git/aGZidwwlToWThkn8@pks.im/
>
> Just dropping the links as-is without much of an explanation isn't
> helpful.

Will be numbered references in next spin.

>
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 1da4c0e60d..9b04e3af85 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -3316,15 +3316,14 @@ static int do_filter_refs(struct ref_filter *fi=
lter, unsigned int type, refs_for
> >
> >       if (prefix) {
> >               struct ref_iterator *iter;
> > +             struct ref_store *store =3D get_main_ref_store(the_reposi=
tory);
> >
> > -             iter =3D refs_ref_iterator_begin(get_main_ref_store(the_r=
epository),
> > -                                            "", NULL, 0, 0);
> > -
> > -             if (filter->start_after)
> > +             if (filter->start_after) {
> > +                     iter =3D refs_ref_iterator_begin(store, "", NULL,=
 0, 0);
> >                       ret =3D start_ref_iterator_after(iter, filter->st=
art_after);
> > -             else
> > -                     ret =3D ref_iterator_seek(iter, prefix,
> > -                                             REF_ITERATOR_SEEK_SET_PRE=
FIX);
> > +             } else {
> > +                     iter =3D refs_ref_iterator_begin(store, prefix, N=
ULL, 0, 0);
> > +             }
> >
> >               if (!ret)
> >                       ret =3D do_for_each_ref_iterator(iter, fn, cb_dat=
a);
>
> The patch itself seems sensible to me.
>
> > diff --git a/t/perf/p6300-for-each-ref.sh b/t/perf/p6300-for-each-ref.s=
h
> > index fa7289c752..ed9c1c6a19 100755
> > --- a/t/perf/p6300-for-each-ref.sh
> > +++ b/t/perf/p6300-for-each-ref.sh
> > @@ -1,6 +1,6 @@
> >  #!/bin/sh
> >
> > -test_description=3D'performance of for-each-ref'
> > +test_description=3D'performance of ref-filter users'
> >  . ./perf-lib.sh
> >
> >  test_perf_fresh_repo
> > @@ -84,4 +84,41 @@ test_expect_success 'pack refs' '
> >  '
> >  run_tests "packed"
> >
> > +test_expect_success REFFILES 'setup many unrelated loose refs' '
> > +     git init scoped &&
> > +     test_commit -C scoped --no-tag base &&
> > +     test_seq $ref_count_per_type |
> > +             sed "s,.*,update refs/custom/unrelated_& HEAD," |
> > +             git -C scoped update-ref --stdin &&
> > +     git -C scoped update-ref refs/remotes/origin/main HEAD &&
> > +     git -C scoped update-ref refs/tags/only HEAD
> > +'
>
> I've already called this out before on other patches, but the REFFILES
> prerequisite just doesn't make any sense here as this test logic is
> generic.

You're right. Removed in v4.
