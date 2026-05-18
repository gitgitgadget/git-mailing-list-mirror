Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB63803EE
	for <git@vger.kernel.org>; Mon, 18 May 2026 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075053; cv=pass; b=gEAtZlMvHjCd+8aZnRj21PLfk/xmduJnRplzupjKVzOjvx2yPNXGKevZ3V18r3dn2d7Gmf+k8fWxcinV7D44sIk27YPMQhGpLTJnw/zufx1IL9HoTV7L9PeyvBAXPemMQdO/fVI8mmTHej8yAV8npJNCN69zGYUk87xuxOo5D9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075053; c=relaxed/simple;
	bh=PVU7E3Bf3rNwAT2tKMO6qE+R68i7wQFSAXDblzrorf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gryb2K7GQtxPZQgAk867P2jqU3Xp8iZ1waIUMe09JydqWrdI2EwcNDMqmGBoumm+GGsgY9AM/WecG1HjMZe2tqv/3B6T3yKSd6W4VOimNEEvoRfTe91Q3X1342/InhGiGAQiCBESOakZzVHabfCUyFfRoJfc1OV3VLHOuJYjXMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cymwscox; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cymwscox"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43a86d544c2so559443fac.0
        for <git@vger.kernel.org>; Sun, 17 May 2026 20:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779075050; cv=none;
        d=google.com; s=arc-20240605;
        b=hUA/jm4GAnrKiX2wSpQlj8Yjcxerm6Ll186aYtGWHQO/H5/KVGNkhAikvdV/vucVQ5
         urlJC8dTFLFSN+65sEJoJw11d1C/QbGZLEAh8NOYHAG5hGcnWSpQHw1PRuOZpj21zcKD
         uPS40qiqbmg+G1pUA6US8+iK+PpOx9BwjDccqSjiruuaAf2R7jeXiA/mKeK8pjkInCTk
         oJVMYNEPfBjpN2akD3+SgUGRhus78qKVT0Bp//c45KkymaXEFriX2psZcvPYLSHiW3JP
         PSK76Pdi9gHYp9ecOCZKq+9DVSHLnY8z84+1UT7p4nwtUsq72E0o1lVqWmdwRLnlpW9X
         oWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6IzGFBxy08JGOrqU1OmSBSkKsgBB+x1J3HQ96OqW1F0=;
        fh=DyUEzJqbRq57b41m7uKqGPyssd6wDkNSPNL+BP/0vTY=;
        b=KV0hjnbw+3O9Isb/jUpOOHbdAlxmprC/4hMXnI+aRdAhU3yvrOTb1Gc5jYwRUZKlH5
         ZKyb15Jd04x5oFBXX2eBuJL8cZt6LWvJFEhyNxUubP109k3bzqReonc08lxFmjMVM88Z
         /ixlgpfOKO6nWXXPaUKv0bLkHqHGPm48fFr6Rjro8T+qjFGPoz2wjM9veUIywxSq4n/b
         P2U6NUYG7nyeUtrOAYRHGsxeXtkZHSJH2glzizrP4mEqHcES+v89T/0Wgr8xWNMdq9CE
         i6nnSprzX8h3ouIqfLu/dMq9+FZBM+flRuASOnJB7LAk0I9RyLx0ZFkpvG0OBqQe6fqT
         dgNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779075050; x=1779679850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IzGFBxy08JGOrqU1OmSBSkKsgBB+x1J3HQ96OqW1F0=;
        b=cymwscox4AdcGCe+pnTw9j66yI2AE2VUd0H+MKA4E5Eb0Nl3Y9cz0lACqEE5ql1kIZ
         lUtdiSxD7Ht2ar6jmOCSuSdMIHGRKTYNXyUrZ9yzr1CN1j1A+rkuVRgzIUXpwacBOei3
         ye6g24FaDgjdhBLALTwsKKuQqwkiXqRF90QfjDVKsqN8eL0EdWDKX7ZX69R1b9T6oJ4K
         T+l9se+XlMmI4IvCVWd3SNaUpaFqFtXhTug4PIIyl/4cr3HUN3K9Jqgk/pKeU/LqDhuN
         aCHj4ZqIKLlLww5oq2EfWo91RNgePlfRf6AhJ53gTh1dH8/sh/UzqBUs1E4BAPCnkF92
         avFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779075050; x=1779679850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6IzGFBxy08JGOrqU1OmSBSkKsgBB+x1J3HQ96OqW1F0=;
        b=KeycrIHaIexUy6vXqSARSFPDYF5VwKNPx2rD/BGAdtSlcmpypwVGmCZ0qkx3j1UlnO
         AHMfLaHH2zBak6wFL4uuVMn9pb5J2ftw2qebWxJirtD29v3yTxSfgB5f3jru6ssVlI+P
         FHz8EInsnmLbtkOGoSWpgHPLC/SH5kdF8WWE6TeFOZCo3bbcnh4Vxq79sR6oUv6sVU72
         Kd3yCE9grd/v8FaMhB0VpB+Rtm3NkYwnwjbMsPKZBaH5SPZeW+KmFYIq1nkz7W2peFlC
         Kz8e7inQjc4YP3g7Xm9A2DnS3L/VHSYZDIDxAjZma24fwSLud+GpoPAMjyjz0tf0eQu6
         I/4A==
X-Forwarded-Encrypted: i=1; AFNElJ/8GZ6t0ITbGMNTWUDDOhScLiCMO3hNfh7acCkR7n+1eO44vHlhOMCOZPprnfW3D44qS7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNd0bfPKRY1IrAv4Skqfueh+vOuqkKPR0cg3x8JIOkhxka+8WN
	8mSV38/zjnLcvDpZgtSJ/jXVORwrnW9mFD/U4518lmftI7exHBj2wlPZJKgrskDe+r81T95kBQR
	VVqGdZT6UuUK8ZzpYwKIyoV2SboMT3UE=
X-Gm-Gg: Acq92OHT4ul5Pgg+7rGoKfUxbagMGN72J2emzc/MPw6qmeIisqPeAKPBJHi5axmRbVa
	Ncg+plOwZEkoTUWA3QX5+A/3r8tCdQj2e9wrU8n9N40ngULe/DEOYBBIwX4ee1YiYuIDaoP2t0r
	rSFNRNMX4fUk6rfTVQqVPeCm8MFOnKZbRktzfm8kFY5b/EvgKTF89aLhLWSHX5jXTJ8mnmq00DC
	ay4HL6MdPyBnkhx3/8kRpE0ZsdJ99kB4oxTx5vYYreNGBtjPDxYF6TNSYoHz/80abov0BZa/XmD
	ySa9C0A3E14Pirwj4UK+OaFg9qDfryzhwKipa3SU
X-Received: by 2002:a05:6870:218f:b0:436:a4fc:f6cc with SMTP id
 586e51a60fabf-43a2e140f34mr8982580fac.36.1779075050228; Sun, 17 May 2026
 20:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g>
In-Reply-To: <xmqq8q9migqk.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 17 May 2026 20:30:38 -0700
X-Gm-Features: AVHnY4ICu6v2rMGtEjfxkEKd4jzAcQohtRz32bSM1UpGBvgRsn1s9UvnSaPFEKE
Message-ID: <CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
To: Junio C Hamano <gitster@pobox.com>
Cc: vincent@vinc17.net, git@vger.kernel.org, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:37=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Michael Montalbo <mmontalbo@gmail.com> writes:
>
> > @@ -457,6 +457,11 @@ endif::git-diff[]
> >  +
> >  Note that despite the name of the first mode, color is used to
> >  highlight the changed parts in all modes if enabled.
> > ++
> > +Word diff works by finding word-level changes within each hunk of
> > +the line-level diff.  The line-level alignment determines which
> > +changed lines are compared to each other, which can affect the
> > +word-level output.
>
> The added text may not say anything wrong, but I am not sure how it
> helps the end user to know the way machinery works internally.
>

I see what you mean. Maybe the doc should focus more on calling out
the user-facing implication:

  `--word-diff` finds word-level changes within each hunk of the
  line-level diff, so changes that only affect whitespace may still
  appear in the output.

I've intentionally omitted a whitespace workaround recommendation for
now given the ongoing discussion in the thread.
