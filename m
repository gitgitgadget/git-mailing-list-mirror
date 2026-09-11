Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1222434984
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162306; cv=pass; b=V4WAfKVvP61WDWKh832egkF9i2cPyWoX6qipKJcqKq59bA5P5VhI7rVoNAhvW2KTVAJD0j0H1CajUeHtHpnLXbuYgQ3bWVwz6aQcZkAYsbCrr4C5YnpgJ57dvOXVWo7rVe2coW4GIjDKOvrf6/loU7x3bHjvJGSszEvF27RpkKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162306; c=relaxed/simple;
	bh=saPbXi1fpltaRBS2M5tDZ3gh9Wg7swz1SIPGN04ySi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfrKB/6lkrX8OfABKT1MDKHtpSMpvgdRFt+geQTvQJ0AL40XIgz66bEKwJoSI/292vTyLWQGVMZ3HLqmIaGoB6/9BZEIRyKSq3Xa4vklokUd5tVbX9uNajcLQQ9W9t3ccPUk/TKGWZazAGKp0oMm8iW3IHAVqm8c6wi+8bb0kpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5IBwCGT; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5IBwCGT"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso15087091fa.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789162302; cv=none;
        d=google.com; s=arc-20260327;
        b=JBU5fpQ9CuMJnwMHoS60i9JldJpIugHb05wGcNNjAdV7qKrl8efrXGLzK6QgCzBEyp
         a2+j0NmnkuGqOYR/mwdnLuzlWIR21H8deXQKl5dSZs4r0wG4UP43ZgRqu13Gagp66Tgx
         1az2bpbMsKqJQPuhCBdyBTVAFwNTUbk4nUuKad3zSbMXyJUJ2qNLOo//gB14PQdcmfmv
         /JQoyMHgXuWh1yx4qeIrfrmGo1DfzFppTizssL7wKMds2y+MXrJYUSRpRItPaK/eiCDy
         qSDw2CRWigyT3kgU3Qh+MP/isHpWKqBEOzVNRsRdDR+lCAVfL5ZTbtQM+DN8bVhkhBni
         wD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=saPbXi1fpltaRBS2M5tDZ3gh9Wg7swz1SIPGN04ySi0=;
        fh=+rxVMgasjTcw63aikTTVOCzA993n6RNNUEErhksVvWI=;
        b=i0ToaDzb0LWzgIn3o4tpA6T4vnonX0I92izrDF8OemSiVODEhstyfBUtYESGgowjsI
         78H3/rjh14UWbVVLwzXjycRQXUgCR8VBgedJMv5O1nkxH5Zc17Ps+tuAmznk6/8H3OJF
         wFYaKIke2rKbkpon/oto3lXnfP0ichMK5iR12xjRtt6sWW8jpw1RCGps2YDQvaaWwG+m
         t60yAXTP7tpsj5/QMmgYd7s0fzu6GEQDRnYARS1Lle46LLYUCjIQI0D7nig/bWhr6eZq
         hhezCVg+vxH6HSAluoHLNcFCeq+xl8sO/ec8c+98g4x2kQiaSlSlM+ccLtoiK35ek5tm
         7HVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789162302; x=1789767102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=saPbXi1fpltaRBS2M5tDZ3gh9Wg7swz1SIPGN04ySi0=;
        b=a5IBwCGTT0aKdVuAUj7r5atGAovh68sy/Nyqyy0DFhmLh0xBjecYhW5kmFUh8JRzCh
         RPLKxneZNUBH5wDY2CRXt+DKfdRKlqv7lNwavP0nxRWxaGF8XFCQyP1Gx6Rl6GhvNnw1
         reu0pW2aywPK19FvusB4n1Xknk/x9vf9bFIHJhEFHNxisFZbhN4tZrAQSCECANUX5YrP
         r2ojbKEgUQ9jDRnYcrwVa7jBgKF0DaMq8kEDz1V0GfW6lGJd3u89zdPc4zRwvMN3BYDE
         TXIc+5kQft98Evv0YXHeBvlq2HSVn9vtfuCYkQH6OtfvU84aW4oa17w2vGnVHc4b4jNv
         GZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162302; x=1789767102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=saPbXi1fpltaRBS2M5tDZ3gh9Wg7swz1SIPGN04ySi0=;
        b=IXrYo7lvharYIQLO8VzAJlYlqonuCE4X+8xMVjJyUfBvWsBtxHilYDf+ZE9e8yMstK
         7stJPOf/agfZGRgKyNIDB2VrbFsdcMOvWVXpa/5MAaXk3jFzJMDfcUiyI6MDpqfiBTC2
         xnHDlefrziNLvzGeUlZ5TWXjneziHr423c9550xnXMZB7Z0Eormt0tqX+NN1KS/pa7GV
         h1f76/3zQpBwFPouA/BX5uYlaJV0LCzehlsOeAWIRzAsqJxGqzTfyqAo9VZ7krI1flj5
         bBOl107Jf1V8Hkd7b7v5jA+cVn79F8e5DWhUUqa5F3QaUCgILDQyhLv2pKkJYtLLPKjf
         J4GQ==
X-Gm-Message-State: AFuF++n+ZvlQxH4w6K9HVUrztMQUjrqTYoDKjHMs+QsEC/Vg9t+KRnD2
	KdfJfX8bMIEOqrac+gNTAJgGaFU5rjpCLPrZCrjp7aXUwhMGRuB2ZFxvspqvQK1Ydcerr2IoAl1
	AjY7+R5DGO8Nm2XsydGFDkIKB40wsWaI=
X-Gm-Gg: AYBFou3CiLlaw0g1P8WioDA/8ViKxqfmGYUPsmK5FLB9yZYINkQ1InM0D+V9s4qCPtW
	bItluQ+E1kuUPyiJXDZQIujoUfj3Yan00iAE50wkGhNwr/ZxCMRiMsNdAj8a4UUZHTCaHVH+b1t
	BusWmeqouCz8f5rwekyDxA0c73JwdN06j/a/LdKZh+d77zPtXXD5wX/ijfpVQwRQr5grQyG7QHn
	sYg4nrsCGQkeDEYkNWV2FA+SXpoju5UE29eyL+DjHPeII/Qguv8kfoiQdaHILudF3HtynPauDQY
	cA8F5B8zRuOKj3uT9d0nIHHGYvFWdRRfuta6e8IJ+f/QGYaXrh7c0NzZsozmNsBkB03aAvWuoeI
	pknEJwdmqgbMyJQ==
X-Received: by 2002:a05:6512:b99:b0:5b6:10bc:dc40 with SMTP id
 2adb3069b0e04-5b89a349834mr2315945e87.23.1789162301346; Fri, 11 Sep 2026
 14:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802212826.1090943-1-sahityajb@gmail.com> <CABPp-BGYuQA_ngR3xS-_Mndzf_ubkn7rSc25CJG=UbLCVGdnyg@mail.gmail.com>
 <CAP=WS+sp74WQ=xndQ+2a6W-qP3Zz8=bVnEymgVpS+gwMv1Dh7g@mail.gmail.com> <CABPp-BHLaW6_CxMdPQURN7zMK1p7dEkihFMAkyWvcd2+j7gJqw@mail.gmail.com>
In-Reply-To: <CABPp-BHLaW6_CxMdPQURN7zMK1p7dEkihFMAkyWvcd2+j7gJqw@mail.gmail.com>
From: Sahitya Chandra <sahityajb@gmail.com>
Date: Sat, 12 Sep 2026 03:01:29 +0530
X-Gm-Features: AcwNN1Uek2MmEnPhvWVMdD2WPDbJeJ-M7OQU40Hj0ldwfWx3RMQ7Os3clg58PMU
Message-ID: <CAP=WS+vySE94LZ_4CtEU6Hd99DttpF-49F3OaChTU53hdbzf1g@mail.gmail.com>
Subject: Re: [PATCH] read-cache: avoid sparse-index expansion for unborn HEAD
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Elijah,
Sorry for the long gap, and thanks for the review.

On Fri, Aug 7, 2026 at 9:03=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> If you submit a v2, it's probably worth just being upfront about this
> in the commit message

That makes sense. I'll frame it as a cleanup of the TODO and a reduction
in read-cache.c, with no known practical use case.

> I'm curious if the unittesting harness could help here and avoid the
> need for the test helper changes. Is that possible?

I looked into the Clar harness and the existing unit tests. It supports
fixtures, but I didn't find repository/index setup helpers to reuse for
this case. A unit test may be possible with additional setup, though
keeping this in t1092 would let us reuse its sparse repository setup
and Trace2 checks to verify that the index stays unexpanded.

Would keeping the shell test and making the helper output clearer for
multiple paths be reasonable here?

Thanks,
Sahitya
