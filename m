Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793575578;
	b=qiksmaY5VuEYpJVIx96UffyLB0h2SUfMgxUOLfj4VaxbBuf2/cHpBz9TqzOYtDTfjFX/
	 A5UzeiYZ51zxF5laujfl2nPWdB7GgQ5Ht0dlCs4lX2CPgYwHxYv2BFiljzCh8y1DLCglA
	 6kGLppaOPmH2Gjr1lFrVuWnFJjejPEYtYvWKzftSDPr3Oc3ct/FjMw9QZsux5FdkB4ohy
	 gAAykdREnF3NNeFU9U1aIO0KbgwjWNnWCdlG8ASwnPtrcAU5EYfjb5+PF0cIUzIWWbmdn
	 dTfxhYw23dwpd5Kk/5wEMGAkd9Vh9X/OJ6kCj8JxkDZWxou/qs5Ba7X0VIp5hcwg8Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=kOfDBBxXmfS9f47HwlV2Iihrj9tOwV0/+5rBBD3l1Yg=;
	b=KJScoe7g3OPiaoBYdYisbQgaOmWaaf3JPq3NgKrZewwPI3r7PTIOEjUVYL6GiRUuFQcY
	 EqvfXDvf5hAH0H+sb2fbYRbdL1hDsV1op7CoLOSpka2+u9pkODz0hHs89kyykdWRZ10gq
	 qI0BRTwKWgC8+sxdEzSAmPoIep2vpVdX/qNhGC5uGNpOEBjpyj7HK0tGEBP4YHHBvHeTV
	 fVXPsfedVR9lrGIhpa10C6uk1mU+YdBPJueSEq4lqHhoDTZzu+dZETG3U0FpbMSJp2xCM
	 fAg2sRZhxcMUiascWoO2YYhmDQSNSvKm40lbWSfCsYKH16ZdDBc4jxIBCpX1KswNQgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7N3CwCj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F6606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E2F6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7N3CwCj
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a6bb779d13so1284932fac.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:26:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793575577; cv=none;
        d=google.com; s=arc-20260327;
        b=VTvO3FgO8Su5R6YFfpD/VeR++q+kdAef4+K4L4ukkPThxKMIFyka1liHdZKa1zfF3H
         rMezLZzGU7Yx9L3hpMnSmdO3BthFix3evENoeYzg+xjusX6O6nOZIM9QC+RN5sRd3C3j
         aB73JSXH8V7+t8ZL1HKvf6bETArennnjJTobXgIH2Cf2EbeYiWpASynLZjUdWZhViIsK
         TH5NRHEF00S5gB+UzmOMPekF4IHZQViDtE26ptVYCu1RdjefVvtyQypxr3VBCbubh+S0
         FAHlDp8WglGh1vx2ORwXaPFnYnelVR2VEWi3hzlvgPEBQ7763u7wRy5GzbdLndQn7AkD
         rgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kOfDBBxXmfS9f47HwlV2Iihrj9tOwV0/+5rBBD3l1Yg=;
        fh=+Ve7dG4yAo6b6IJAJcsfAVXuA3IHmj+18im/3KFY0tU=;
        b=EXkJUjuN8CsBIw7dT3hw1GVh10x13FA/KCZQnfRcUnuBrZKcRvvXhsYE33cMzXCSvj
         Wit6dsYbOfD8oc42zwsIypATzfxbkPngHnckjzN8rrcLZyC47t6lD3hRINA8JnqUJIgp
         p9hqBDUn9EdV37j31iOjh6ZSpOW7t/yxyn6dtUuFlKALzNXWjd0xDcivPHAj9k7HE9yR
         4qVV1FTihnS4Ae2ARc+XOpLESW4ROsXhxrdHDnhLIfCtV1aHuMrfkY4uB8Z8JWE/sdK+
         MInqHt8iKTSMwlhRcYqDph7kcEI7p9Qu+8+7vef8jPvMRKSw0O7sqqIsT6ldQSy5mX4E
         zu6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793575577; x=1794180377; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOfDBBxXmfS9f47HwlV2Iihrj9tOwV0/+5rBBD3l1Yg=;
        b=s7N3CwCj/xVTLA5Awx2P8uGUoVXtkZwnW83mr6bbz+KWVme56nDUoFLh1agsy2QaSh
         Z3/NFc/wzsoGCNsWgGAk16x7JUyaKDhHiaXI+DbYlem7/HZ1xr6gKWRf3ivX4QE9mXVu
         csgx8Zbk01QNPZrWRFh7IUJjvbW7XtQFD5OXANO1EahRo6v/XXF58aZQ9IHzKpDeOi5H
         f7fv+1s0ot0/Dvs4iyAmkclJ70bN98GNE1+KRjd05HBDEShX5CLlkc94MzMd3c5S9OJI
         SGYoSTK1cRgr+ZlBkoeNOP9Myey8GlYvjnTn/i3KLoY9l4Lj3H1OpYHghS9ZKrThdCSP
         5veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793575577; x=1794180377;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kOfDBBxXmfS9f47HwlV2Iihrj9tOwV0/+5rBBD3l1Yg=;
        b=kpSzdZkdYez9xjKv0HEAvHNvHg28BmXiSw6xT1op5UA5JYEQ1AQqYN91kk2QpYyfDR
         8ZPMJFBKYkScXh3UbgnJKBa/cYJbtp2JrMclDdWrgi6U/ISHiMfvhNoxCju/rFhODHLb
         +kJEnQbbT8esWCLzOUJRQBqnLVuegRO8GSTWuGub3RcsdOsh0fAlzH+9YvvqTnAcFPaJ
         MMwrizrW3fjCkpHFNmyFE9+63WW7QV+66hCNjS0Aj0COOdNyjiBtOahzLjRHOJv3K9dR
         oEbbrHqL7x4tKym8cyMf15nbno94FoErdci5h8W8kopOreUkj1GvnYdFmwoApg/noeKG
         NEPg==
X-Gm-Message-State: AFq9FYLSIHdpf1sOZoSjWxBgI8l5/rg4lCBpYtnYJpxSRTgyZ76UBCed
	1vHwzw0ZxjVCpgAd/jw7OC6NRKC0Z3nbj25FU1XOTB7adWXOuxk/rFpqEtbiHKMtBPAvNZS7cFm
	7xBL2oyCLb6PCPcFUn0viZYPeaovfxZw=
X-Gm-Gg: AYBFou3mf+T8i9hEs4XaGcDkgIKoWSG+fwH+WonPopX/NJiJi7TdMFnPCmXiVvg5fii
	ZOlqcjTlEHJXFQYTE2ZRk6S7tH2gPhZA2mtThZVBRvrxMKDbxePSpQiqFkNHfVYp/JJ8eCmBfvN
	LgC2cIHks7pKeIhYKWO6QyCaAZRoL769x/VtJTd2NWq5jWdFjbIleQP9/hLKP1jW0b7opVMSc9c
	1CySMBUjNb6tvxc5a0/AxVhBKj8ariDvHgvY2uhBkYpx8gRTDE43XtihUjbHFfc2atN/hezFjHh
	XO6+JVlsYocJbj4JYHwlBO44VrCL4M0FUBvlirEEwQXbkonTAsNuKp3Mq6rq8nzFZyveC/4ekm1
	js15bAzBS1sVM+EwoUSWP59E++ZrrXxgmNLuG
X-Received: by 2002:a05:6871:4410:b0:48f:e107:3185 with SMTP id
 586e51a60fabf-4a90785935bmr5883722fac.56.1793575577028; Sun, 01 Nov 2026
 15:26:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <20261022212903.177261-3-andy.koppe@gmail.com>
 <atsPvF6wVdugtwrH@pks.im>
In-Reply-To: <atsPvF6wVdugtwrH@pks.im>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sun, 1 Nov 2026 23:26:04 +0000
X-Gm-Features: AclHuK_8c6mUOc1mO0Ae2eKY6Na6-PoCsvnQhHkM0WZXW9R-y7FBpsLd6sCLhd4
Message-ID: <CAHWeT-be9+8vpjmj=NVYK3rjG5MrBqmSwuX+jJvvUhkKwvKF2w@mail.gmail.com>
Subject: Re: [PATCH 2/5] doc: glossary: update per-worktree refs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 08:41, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Oct 22, 2026 at 10:28:50PM +0100, Andy Koppe wrote:
> > diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
> > index b2c582254b..eff6d23215 100644
> > --- a/Documentation/glossary-content.adoc
> > +++ b/Documentation/glossary-content.adoc
> > @@ -494,10 +494,16 @@ exclude;;
> >       interface than the <<def_plumbing,plumbing>>.
> >
> >  [[def_per_worktree_ref]]per-worktree ref::
> > -     Refs that are per-<<def_worktree,worktree>>, rather than
> > -     global.  This is presently only <<def_HEAD,HEAD>> and any refs
> > -     that start with `refs/bisect/`, but might later include other
> > -     unusual refs.
> > +     A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
> > +     rather than shared between all worktrees. All
> > +     <<def_root_ref,root refs>>, such as <<def_HEAD,HEAD>>, are
> > +     per-worktree, as are refs that start with `refs/bisect/`,
> > +     `refs/worktree/` or `refs/rewritten/`.
> > ++
> > +<<def_pseudoref,Pseudorefs>> are also specific to each worktree.
>
> Should we maybe also turn this into an itemized list? Makes it easier to
> see at a glance which rrefs are per-worktree, and it becomes easier to
> extend going forward.

Done in v2.

> > +See "REFS" in linkgit:git-worktree[1] for how to access the
> > +per-worktree refs of other worktrees.
> >
> >  [[def_pseudoref]]pseudoref::
> >       A name that can be used like a <<def_ref,ref>> to refer to
> > @@ -788,5 +794,5 @@ and pseudorefs.
> >       "working tree" and repository metadata, most of which are
> >       shared among other worktrees of a single repository, and
> >       some of which are maintained separately per worktree
> > -     (e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
> > -     per-worktree refs and per-worktree configuration file).
> > +     (e.g. the index, per-worktree refs such as HEAD, pseudorefs
> > +     such as MERGE_HEAD, and the per-worktree configuration file).
>
> This is a bit curious as you distinguish between per-worktree refs and
> pseudorefs, even though you mention both of them as part of the
> per-worktree ref section.

It's difficult, because pseudorefs are per-worktree, but they aren't
refs. I thought they should still be mentioned under "per-worktree
refs", without calling them refs.

> I wonder whether we should simply refer to
> that section without naming any examples.

Good idea. Done in v2.

Andy
