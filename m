Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316082C11E4
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274769; cv=pass; b=hyVKMTjBfCz/UsCEl/L1OliDxHCKSqudDVEYCEENwv6xxzufyK86/QnLhSgHHb+SZTv5TfCE7xjyft6wa+hJSHbh321zu7Es2UqkWuf+d/6n7AZwLCYhbjk9iy/B6dm/EdjgATCyL3sd7DY9kaGAj5Bun42xrQAkGliD42NL5xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274769; c=relaxed/simple;
	bh=5VRP3P4lbHzw0DTACiLOeD39ei6emLYu7n96E/CgQnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTZ3nmx/w6dxr+xlOOP28aXVoZaTyWv/4/Df4JrPqXhaN40ztG6xsQlxiNuB9DK7s+q0GOeMR+1Z8yIf3E8cQHTV0nlCVBWlg7t7YHh+AEjLaKsTp+qrKj0D8bZMokeCSjuaG52CqMDHmdZfOn11pvLgDiOFFpJnllW/lYl2Abg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=iBKykndC; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="iBKykndC"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7efac480dc6so9943337b3.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 07:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781274767; cv=none;
        d=google.com; s=arc-20240605;
        b=RKzDBv2g8CgzwDEaxFKBOcyNk8OPwA6WDH1TdNl81CYzu4whZ2H7eja3WDtjB0xXjy
         3g74qP3XmzB2ZZAn3mvAiNyOP+YvdqBiUJhJIb6j8zdygFomv/fi78oBvKmAORXlD9mJ
         hmhdicTvFrrieLHHMMB0/kfHInCWXVCME9ygi1gTX1Z8UTIOicz5PXw9tV+wLfkDLOmf
         hj+d/QpyrxX/HgsPuIzmgfVecRGApOl0nRBQ2YHyH2RitXkbh/c8r6UpIe1nqRfuVPxt
         qlm8al4rvdMBhVEwkw/y+lrAnU0uCVfFu1J23EZHHHBw19/Cu1sbzwmITqMkPqoM8whb
         qp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L4Rz3/y6la+3H4LTcZ89iMCuhNIqzHw2NIencl7bqTw=;
        fh=2qQh3Twk/9BXP2JN1YJEg5XG37bzhSBn4OXZs4ZhyG4=;
        b=E5oenw6O+eibRCBupxHB8aKRIEuD6iAnuKNWNtEkBDu37ImNteYUc5KHZ9DLaYHmuW
         7eu958BAzLSBhvLuYI5NMEZ4QsTYUDX3hsNGIHAhYtt9Yx/c1EAz6ip8s2yKsMg/ZhjS
         IbUH4T/em5eT6Ylm5aOm7pN8y8u2YvewTSVRf5WQDMf95xS+TH08Ojgcrn8/dKokaakW
         zm1Qly5FFuYq0JYUl3ARmDdfQBgAxjcHbBjJgLC0oKfR0vkkxVHgQlh/D4cJ4sTfB+fP
         UG5A53vIJbK4+tysR4UAEz6HFvUuRuO6c5FSK5VPXK5n2kUDtLm0cl015NHjqIiTmiNP
         0IEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781274767; x=1781879567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L4Rz3/y6la+3H4LTcZ89iMCuhNIqzHw2NIencl7bqTw=;
        b=iBKykndCjrqNa7dfvSjuQPoyEAISlamKYVMig5fR3noigoJLUYiMnIAKNMmxUxSnC4
         P9IZu4enI7Aj0PTiVR2gfB/10GJX+qQ1+T9iKIql/O2VsFsclDQ7AuE5Mt2qB0l4O88z
         XcUM15sECrZ25c43BPuPB4ezDlUx0F9HmILoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274767; x=1781879567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4Rz3/y6la+3H4LTcZ89iMCuhNIqzHw2NIencl7bqTw=;
        b=cTWJ17v39UybFzxVWXuIM2gsXDK5sg5OIrCSgOrR+rk6XBC1Ztd8kAcDDu2C7rHqzN
         EZIxhKvKKLgFEVFoxJPxiaPkj6Lnn7m6RK58A87fgvJucQBn5Rb40S4Ip7cz6aH2t1Fc
         eiSCEDZcecReqbvh2Al6y+5lAtm26/Xhq4Ln7LluhQRjBOwLt2hYopoT+CAsOACND7/j
         elC026uBQg7eyOZQJvyxGHvYDhTxdOu97T8kb8SnH5S0BNYcOcFk4DzLtxcJ8d/tUHb0
         TORNdv8Goa+tufra7tWwBU47lxDNkNoVu3NiRaGaggMq54Rr2aehB0f1Mxuqy76gI4+R
         tuVQ==
X-Gm-Message-State: AOJu0YwFUAhJo3IOtam5H86rlaKtva85K9JN3+P4OzU0y8utSob2VR1+
	X1n+SSAthNdaac2ye5kqmHQ8D/MiCRboCY4HzaxrLmuFxn8Svi2N5hsWOvFfQ8GoX2Y5+Q6Sn4H
	lQoqDIs/dazrV7FWm1YyNpdeJwnX0cR3O1TAcQtIk60yaqQd3CoW9dRE=
X-Gm-Gg: Acq92OF0+FndPEUgpqCKVvF+nsQPAQrnM5QVWn+cmEns93ZlvUfyOjRAYc3gvYaGF8X
	8YugVArHmG6uybQ3Ynp9bnM4BMs91+B68JoAifgQZHrDEuYWtjrbggrkcPDEbpFsfAwP+hyv5NG
	TythKqZlygrRDHMx2LiFpSC800W57WZWuVPcQTMgbjTLLeRzobMWjn2sIux7eZ+h5LvJinUDggr
	7wLPdVIWcIb9K1/piojPqAfOMwCVPCOQS55sWW2zWpAIsttT5ZM0HbStd7IgqCM4FHg+rc3nPlK
	YfAnnF0=
X-Received: by 2002:a05:690c:3745:b0:7ef:d039:a33f with SMTP id
 00721157ae682-7f7b702e2c5mr28775447b3.20.1781274766965; Fri, 12 Jun 2026
 07:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL71e4Mp7ewv0UGS8j=iTq6quyxLXzrr0uNDbWR8JKaOsTSVyA@mail.gmail.com>
 <0b3f7429-a4fb-4f7a-bf7b-5a0edeb1db52@gmail.com>
In-Reply-To: <0b3f7429-a4fb-4f7a-bf7b-5a0edeb1db52@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 12 Jun 2026 16:32:35 +0200
X-Gm-Features: AVVi8Ceegr2KGz7lWEmORke_tWVLZ80m1QvxsbowRRvyFIUV4QFN7516LtL9Tmc
Message-ID: <CAL71e4OmPzpCXh-zZ8NsT6L4zVKnXV1gqiFZ2w0XgMJhD=LArQ@mail.gmail.com>
Subject: Re: [RFC] commit-reach: terminate merge-base walk when one paint side
 is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 6/12/2026 2:52 PM, Derrick Stolee wrote:

> The STALE bit is pushed from commits that have bits for both sides
> of the merge. This isn't something that we can learn from just
> walking each side: we need some amount of walking within the
> intersection.
>
> This doesn't matter if we are looking for a single merge base, but
> when we want the full set of independent merge bases, then the STALE
> bit becomes very important.

Thank you for the quick and detailed response and your counterexample
graph is exactly the right thing to worry about.

>    A    X
>   /| __/|
>  | |/   |
>  | B    |
>  | |    |
> ..........
>  | | __/
>   \|/
>    C
>
> In this example, B can reach C through some long list of commits.
> This makes B (and X) have much higher generation number than C.
> After exhausting both sides of A...X, we have B and C in the queue
> with both side bits and neither are stale. But we need to walk
> from B to C to discover that C should be stale.

I think your response helped me identify a mistake in how I described
the halt condition.

The required condition must then not be simply "one side exhausted".
The walk must also continue while non-stale P1|P2 commits remain in the
queue, since those still need STALE propagation - they are still
merge-base candidates.

So the actual halt condition would be:

    no non-stale P1|P2 candidates in the queue
    AND (no pure-P1 OR no pure-P2)

In your example, B and C are both non-stale P1|P2 commits after
both sides are exhausted. Therefore the walk continues. When B is
processed it propagates STALE toward C through the d-chain, and
because the finite-generation region is processed in descending
generation order, that propagation reaches C before C is popped.

If this reasoning is correct, then the walk only terminates after
merge-base candidates have either been processed or marked STALE,
and the counterexample should produce [B] rather than [B, C].

Thanks,
Kristofer
