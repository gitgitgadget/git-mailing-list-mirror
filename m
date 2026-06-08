Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE25246BC0
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934073; cv=pass; b=mUdE7dkoFts3B0gLQDaJ/93TJlnRykjL5VHm4qGz8iyMh1If4qn3SA4zfRvexV9msuyb1N1ykKK4yV5+vx8vmWObkfgtp/rCFOlQB/y26dL0y7Tpxlh3S+4/G9pnQbACZqCw/G6pe/vwOBTVJV2VPloAPm0PReVF/dXmDYS7uPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934073; c=relaxed/simple;
	bh=tbL6H0Zl0enIOKDyDaldi+z2cLjhrbsgR2XzfmlQH1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJtz1YKqEJ27Utp5+lWZaJ5t/mOU3dDcRcABnu4cHdGridLNV888r7J5/kJ5pGAQGmHwxmXva1jJCWPNUUpWPOaz1miwn3PVdsH3w4XAk37pBbRz4L0twFFplrivUDZSsTkba92/tKhoTvxx4FUPEvdST6S83jGCHjFiSp0pfqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnZPiPHU; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnZPiPHU"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39677245e15so42754131fa.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 08:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934071; cv=none;
        d=google.com; s=arc-20240605;
        b=XOkCCIdmwlUTMO/wBOt1XA9LZzTlE+AKqoGA3fLQF79mjNuZ2BR5GRljVyu3CpfwlK
         spuL2mJF3U45BSK39AT3jRNZg8yzSi+sO620Jr7o6bQMNhjvcmZJquF1VbrR6VqO7N65
         0XfANfa8ZiFK3E1ESY+he9M7GC3Is+fIts8HjV7UnXZR8VZ64TsfBWN0kWglbHNukYe7
         JlqcTtzSzas6bFT9ospEjnv1OOsPrYiicQAbAb5eJo7kQWlC5FVbvFYkvXJgPSzlGkky
         1xiBOR4Wczo5LKZJahlNx3z6yYC+LDv0V3Kbg5NF3RxGzZXRpTCmeicpdj/seT9MaGSU
         ds4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4UUngPbJjeHuZfrh5tx6JH4uutbNQLmSGvceRTc/GY=;
        fh=tazjataahvPEThod8eNR5o89+qRU+UcmvPJ7GdZX3tY=;
        b=gnOcrZgaC8jk+E5mdTlT6m0lXDQrbTSOneXChHv/GSJoGJk/5/Qs7dH4srT3JWUa3G
         JPGWQWURqi0UhBGC6ZqsAfruxMA1NUOefC+2B7HlKb5cHVUI3GomeUMG2xdbSb5iz5NF
         HebBhBRJeCxTZXlJ8LcHjjVaqKKKVEN53uk2gg/wLf0y1CPRBNyXH9wQH2yEvD+2Fboy
         dt37pGdqeCJp/640fJHghZRhoY/lW9H4BOqq26Q9u3f1J14wptCA0JoSF+iKMKWPfr3L
         ZjM4OWLnKUvKF3apdSWc4pMnqtNCjM5UnkVnt2jB7VNdgCZjRX6yrQafAKzmpQIqzXxm
         sb1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780934071; x=1781538871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4UUngPbJjeHuZfrh5tx6JH4uutbNQLmSGvceRTc/GY=;
        b=cnZPiPHUrxj5cOVV/jtDU1/y5GjwaiE3/PpXqsHTKCgWJcqryHwkFKDM3s2y22wJSs
         48BDlhubEyg9xe/Ix1FBzDHMsxYsNmFVWKyiOvDpSbNewcf6eLoxU1AIPLR6ecIMJGSk
         HfWuS3deX9/jgUeiQCJgRSNctWnOSbYms9EygKD5qY6yJVOSkCRdB7rdjuFBiiST5UAM
         gyfySaCdKd+xU25/dT18zNyBGQG02bKjkSWGjECkMum7V+TwxQ1EOa9uPrthUfEmmyUD
         IsQL3+lbl/69zGiNCeJkn7C2vVXhXCCcgNXg40S5xJYRgaSRmWKr2UG/8rUgdD7ENlO4
         j8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934071; x=1781538871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P4UUngPbJjeHuZfrh5tx6JH4uutbNQLmSGvceRTc/GY=;
        b=mgEIYw2dekMP1oQ92xn3NGj5/MRHRelV/WCkXHUgaumQ+xWB541QeKboM7l/IK27nW
         NyrY+kTZHBLW3v+uo+YLDyAZTznFP9vLstrUeqjtHAb23Ws8N69HK7C87ieErbg4hpat
         JE/c4BrnS0CBnF+PpjfEcwL9kASBUYYqrK9EVT94Yu/0ORVKjceeDkgs1F257W+rLbdT
         b+dF34jBbN4Tn2uDlN11IYQZw6y/xGWmT+6e9LAUzcvnmFSjdeBjX4EatRSFQrGxhUPt
         DQ6fGDQfOiqVO25Utl0gq/i2DkysHNctZhaFts7qhE6bcsun7mmgNHMoGmAQ2bCGrDT5
         0Etw==
X-Gm-Message-State: AOJu0Yzb+Lcop98pElL10Gd9U4l0FAdIxY903H+GChoRD67LfVBicBN8
	2Qy5P+uEDQWjEhKC2cQshPwKLzMlPMvwBbMsgQ+YTRNHiw0Oh5jjQNWQD+cYWacUpNayLzsoN95
	yyMw8gExArYL9beqYqkqLhL8HZFIoC7ixe44U9YU=
X-Gm-Gg: Acq92OGuhVX834Rayd6s6f0S3TCqMVxkCq9F8P4eayEH3IWlswAWjoM6Mh7a9imwb3Y
	1gdGDNHkZQ87LylPLi5ACBrPuU/QZqwV5zt/2U2syvt798x2mWMGdRgJYG9RRpzIbe0io4/IxJ+
	v6Dlz97mhXq7UZYQ1kRFgHgwf5vz2nU4TgP3UxIXmQALxjNUJ7MllJpQJpv8IrJKfKX+s42BZPa
	GdjONBz0FnHZCXNMRLBR6z5Fx29VSj+AUFgrjGiHRD7BuSwXQGv00Q+Vp1JzYyLqWrfb/sriTPT
	rQXSw1OerpOtm24K0vITEO8AEo7VLDYF/79iZOsyAlIXqyzFgb9LNvMn2Q87NVWz5M1kUL/HBT6
	zNscDGiWe6uzI8D4gRXMDCO4EmXmyhBU=
X-Received: by 2002:a05:651c:1502:b0:396:7547:439e with SMTP id
 38308e7fff4ca-396d07f3c05mr45678241fa.7.1780934070301; Mon, 08 Jun 2026
 08:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-describe-tag-ref-scope-v1-1-653d232b86b5@gmail.com> <xmqqecihyzse.fsf@gitster.g>
In-Reply-To: <xmqqecihyzse.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 11:53:53 -0400
X-Gm-Features: AVVi8Cfoax7Gxya26lHPxBePRA6bOiDy6-qQAwY_AKCGav_JNIDbL7j6sEsz_8g
Message-ID: <CAJ-ks9mdzXQsFpLRgC2zKRABX6aKyTcj1RF2nRb_U8jCj6iVZw@mail.gmail.com>
Subject: Re: [PATCH] describe: limit default ref iteration to tags
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:36=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> [jc: Removing Shawn from CC who passed away quite a while ago, RIP].
>
> > Unless --all is given, get_name() rejects every ref outside refs/tags/.
> > The rejection happens only after the ref backend has enumerated the ref=
,
> > so repositories with many other refs spend most of a simple describe
> > invocation visiting refs which cannot affect its result.
> > ...
> > Both revisions were built with -O3, -mcpu=3Dnative, and ThinLTO using
> > Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
> > (Mac16,6) with a 16-core Apple M4 Max (12 performance and four
> > efficiency cores) and 128 GB RAM.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  builtin/describe.c       |  3 +++
> >  t/perf/p6100-describe.sh | 20 ++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
>
> Interesting.  How would this relate to and work well with
> <20260601233727.43558-1-jacob.e.keller@intel.com>?

They are orthogonal. That patch changes the argument construction
inside the `contains` block, which invokes `cmd_name_rev()` and
returns. This patch changes the ref iterator used after that block, so
it only affects the ordinary, non-`--contains` path.

>
> > +test_lazy_prereq PERF_REFFILES '
> > +     test "$(git rev-parse --show-ref-format)" =3D files
> > +'
> > +
> > +ref_count=3D10000
> > +
> >  # clear out old tags and give us a known state
> >  test_expect_success 'set up tags' '
> >       git for-each-ref --format=3D"delete %(refname)" refs/tags >to-del=
ete &&
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
> > +
> > +test_perf 'describe exact tag with many loose refs' --prereq PERF_REFF=
ILES '
> > +     git describe --exact-match HEAD
> > +'
> > +
>
> Is there a strong reason to guard this new test behind
> `PERF_REFFILES`?
>
> Even though the penalty of enumerating 10,000 unrelated loose
> references may be most pronounced in the `files` backend, skipping
> unnecessary reference enumeration is an architectural win for other
> backends (like `reftable` or a fully packed repository) as well.
>
> If we drop `PERF_REFFILES` and retitle the test to "describe exact
> tag with many unrelated refs", we could run it unconditionally to
> benchmark the improvement across all storage formats.

Yeah, there's no good reason - and Patrick made the same observation.
In v2 I will remove the prerequisite and rename the case to refer to
unrelated rather than loose refs.
