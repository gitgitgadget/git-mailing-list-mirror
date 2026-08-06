Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8B353A6B
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017190; cv=pass; b=UmJ0mIoFVwyV6Fy6S9hamdp37sJIi8rAN1BEyx7iO7vbkOxy98w4BvPZuPMtYZ7/ff9WDpWWpIx7tCOA6qOPrbq6hSkksFhixT5OXcnJFaAcfZYFH2hUdQ5vHJeoy7IZhJi/a9r4YMQDOEJM5BXUS4I83DzSSE5YyVQE20N1gYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017190; c=relaxed/simple;
	bh=N93izcGBcIVLBMT75GalphRNjELZ1dvjquv7H6fCZKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ2Tx2kmLI8fCfemWnCk0GJFExF6op5mQWWRbONWJ1FwkMV0pB3hsMUqFFLmQ9jytgcZB3Tux+cqVE4PR6gvJPjbxErysMDxeySUOfD2aIl9KjCSriV+a5glUgzfwgiahkJNt/H8rAUJlcVgJkX1F91IMln00rkfN0Eld7aRpPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRhAyz9n; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRhAyz9n"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e347638adso2313938a91.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786017189; cv=none;
        d=google.com; s=arc-20260327;
        b=nqpmyxeqWgebLJC7AxPoVIjbwXEeX4Tsre30Ye1O1lNawU4TJH6lYuVBDgAgyOSDGs
         tsf2ZRvsQadIDZbwUy8E+s+pSC6cFX2/C0heULMibZuXYg54bPWXGeinhxz3tf9lVL69
         krn1ON/cO+PCkS3hlFmMuvv18A8Y4Nqs2RKojnljXFQmYwm+G5MsWx1eoF/oN6j/2ujn
         yg3B1+A+7uGCpain1da9prcIiEyoHrmfSxiznQiXc9C+E/ZQbLSU7yWfONYZ+PB+9O/a
         tCA9HxpVZaJeFHLEJdf2zs3say5DHJCLVP7lGPYRLvX/u8HVnNReHes/0M+EErO1XTfE
         jBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kwg9Bp+fJk7j4hak88i6pa5CuhQVEEHo30LKvVx1EaY=;
        fh=QkccSqkIIt7TDjJqcxVGAZbNaI+GvLwIMw8ngDUxFTE=;
        b=pzQ5hKrhv7tnLveyMPzz2+mVx3cp30prQZRL6arj6wFQlQ+kPb+YeM7A7oE1scq81H
         NHeLgJFJTI4l0w5QajO1QGNiMQhqVByonFAd8sbckoiMEhc5pyVjvOUlgxGFYU50zpGO
         p8NedCBdRyL6aih4kw71mR2/5K9i10a+jejzm8hkl7m56XrpDYCfJSFbYsQS/b+0VZyW
         EmzgMvn3LIJWrKodLRv/0AWa/GmyQs1pilKGZ5MiRr26tHaBo6EyDXJvpK1yVuo8NkJh
         KgfPcKLswZtV5BE4C5K3lqD/9FsNkKJeM6Y7+QXd+6z4T8+gbNGDY6Cxsw321T8frTgo
         EkUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786017189; x=1786621989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kwg9Bp+fJk7j4hak88i6pa5CuhQVEEHo30LKvVx1EaY=;
        b=PRhAyz9njbncYly4+6KKZc5iK4+p0rdtvxr+6lBIyXlayRqU8S/BvjWTuBvvHV7mnq
         oao/ojZP95y1dxTYJTD0vVNRIKMdEW3swSll4Qj0yOlWGNAMnn2A89Bh8bSN0UrCwtz0
         VOzwregQfno0cKB92rvI2SMYnPyMLftL0uCtUn0LFW+m7ASw/XsqOEowiKmgpV0klI2e
         UJlMV16cwuuxNtElmqf79WhshvohljqjiPnpBwT4eE6mbspUZq/tAP1gm1jcWNYKrliF
         lm7hEVOQkRsTix4K95pvZ7NpwdBdE4HQTUrkmNMKGRooDrJ/uO1zEgCmWKHmV53y/0ks
         gz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786017189; x=1786621989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kwg9Bp+fJk7j4hak88i6pa5CuhQVEEHo30LKvVx1EaY=;
        b=NOw1lM2pO/xDCZkN06OTjzkh+/Pp9HBL5TcHuuPbVpZrYWM/I3facM870VHqb7WLTT
         yYpQpTqQL8ihM1ABhr2BKQmKYWQQNhtclF4Y2khKj9coc6gDchSOxtZWbEmv2NMdE+PL
         Zm7IQYN1RK7UJ2SL1kWWwMcEsdAwMVQpVIhwz6M2u2UT9+bQN1A7c1wXbzV/ZnL2QR91
         bggrP0Jxq96GfVSEdjz7wGV1ldaR6tSrnImU+l/YVhqKXzKE1UgTPWXpOeqRd0CswKGp
         uec/jKOIc5x3jecBkOZnak4x8wsxmNDCNk0qhZcAx/q5Tc1jz+4+GwbdprVc8dsX3ivf
         Oa1Q==
X-Gm-Message-State: AOJu0YwWIlwOQUmIgSK3cecjUrn1qSCLk49RW4sRY5wQqBGPOtFplx1+
	eirfqEwdgcoEftrdLOZD5hbUPa436RG3IiTGkCTHz9DHJfSb2qbInZcLlWIM0WdGsyGX18lmmkc
	d++RbgI0JE0M6yRRgLhwfoBGz5dA+vLc=
X-Gm-Gg: AR+sD13q2dLMS52SWBbH2vD8/w0PFxUSDsgaR5Iha7HUX+rKnaNSYm5T36kAEk0xsTb
	8w0u/QkIkb6FMU8LDrw+i6UCSEOz/41rfR0R/njRsCMhVpU9wvdWReGXsnKJOMvtl4DXZOseSev
	BF9CpIoo4yuhbd1fYPqlIptXL+wG1Gwl9VLqcT5iwpz8EwYOFCnyVcGXX8bHiNl2sEyRT3/fYbn
	b0IaXE35DlvmgV4G8cYBf0KXgfxl1x93+DCZZMpNVLDFGGsUqBOtMCoB3pl5jTeOhqIqMvOUmDy
	Jaq3dI+IH/DM9FmTI6did5MC6rJgESnxpV9/4XjIfr70slt1LCZybDkNKgyiR5yIbl3bBPHyI0p
	1DatdStS4X8i9kYTvE+LLzsJWyEO5X++hIIe7JlB8ooMvMirfARU27YUeJOxZpcUc04xM2YJXpw
	iZO/KMk+6g6abDLoAXcyNnSEP2Kuk1LA==
X-Received: by 2002:a17:90b:3944:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-3903c58f3cdmr15897893a91.9.1786017188896; Thu, 06 Aug 2026
 04:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
 <V4_trailer_comment_lines.aed@msgid.xyz>
In-Reply-To: <V4_trailer_comment_lines.aed@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 6 Aug 2026 07:52:57 -0400
X-Gm-Features: AUfX_mxSQ3Ws7ystRYURFJbB5DFlu3zdo4CVXBDEI0GBKA_R72TVwyWOtM0FQng
Message-ID: <CALnO6CB_0ucqnAowrNcPmsXmxxDfJQZPVGkbsHVuya7NLR4dsg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] doc: interpret-trailers: document comment line treatment
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Git <git@vger.kernel.org>, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Christian Couder <christian.couder@gmail.com>, jackmanb@google.com, 
	Linus Arver <linus@ucla.edu>, Matt Hunter <m@lfurio.us>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

On Thu, Jul 30, 2026 at 5:22=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Comment lines have always been ignored but this is not documented.
>
> The primary motivation here is to reasonably complete in the

"to be"?

> documentation of how trailers are parsed; this is after all the only
> documentation page that documents this format. However, and going beyond
> that point, we could imagine that someone would want to use this format
> outside a commit (or tag) message context, like say in Git notes.
>
> On the other hand, it seems far-fetched that someone would be caught
> off guard by this considering that comment characters/strings are not
> likely to be alphanumeric,[1] which would mean that these comment lines
> would be treated as non-trailer lines if they were *not* detected and
> removed as comment lines.
>
> =E2=80=A0 1: A notable exception is that Jujutsu VCS uses `JJ:` as
>      the comment string
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v4:
>     =E2=80=A2 Msg: rewrite motivation for documenting this. The motivatio=
n is
>       not super solid, but it reflects my own ambiguity on the matter,
>       so to speak; I think we ought to be very thorough about
>       documenting the format, while making sure to not use the main text
>       to exhaustively lay it all out. The information should be
>       somewhere in this doc. But not in your face.

I agree we should be thorough but not in your face, esp. based on the
work Julia Evans has done in the past around Git documentation.
Thanks!

>     =E2=80=A2 Msg: Add =E2=80=9C(or tag) message=E2=80=9D. See patch =E2=
=80=9Cnot just for commit
>       messages=E2=80=9D where trailer support for tag messages are mentio=
ned.
>
[snip]

--=20
D. Ben Knoble
