Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCA2E2EEE
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788726264; cv=pass; b=ojJJzNMVrSKPoY62UZOwtPypvOvsdMhux1APDWBgTBCNdZwIWJtOBhJSRbWpUhjQilkUg/7WSKjs2zV8XdYfiE/Beixy9AWeKK5UmU3YwrfD5eOcrbnERVYjKbwO+WppNB+qJhHdYyPUP7RilocfKMbW1iYkcGgvTYAbEspvHXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788726264; c=relaxed/simple;
	bh=5Voboc52MSInktoejszYvZjyWTK+wm1xfuFQRFrRvyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cF4RWiUEZdIsAY9djjNICHYRjnam5MNc84yXKLMgtdLZla3lbQ0oA6auC7ufs8S0XVtA1igYVwswd6HMs4PUhG9k5i7OsJEqUGlJGgNAlfTS1zs8kVaYnS/LTm2Yecw5gIIBxy0nzPg6hh0jAFfg2P3X+lpcytMOv4RPvQo9IrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=QMZyMhXM; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="QMZyMhXM"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b127c88220so1866111eaf.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 13:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788726261; cv=none;
        d=google.com; s=arc-20260327;
        b=TZTFmBWSurEiD3NOO/ROtXj03bKkxdV3gl7IWlH0ZndstAlZijuLDJ2oJShOSdv29b
         MJ+uEk45taE4CRKLpxKM46hGkK8pGroZFmLRXtwbskvEO58OAc2mtgz/lpHjX2rY/NF4
         6ad3MUCtsLuLBgsAEzEt7J5pNq4pRWrC7Ee4UcgyoBV9EnddeERiWVvgpmf/xv8SWkU4
         V0u2sx/80Iu0rqUWqiVNMWnFn5zO82NzRfrB9tBNKzYZQxhlz0ObWjlaS8Tpm/8SPOhe
         83lE1EamLpo6gKPkbgL3gqNCwF+3H6+vBeMYkc+jTUG3kN+V2d1md84Dy92UaqWl6DZi
         civg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Voboc52MSInktoejszYvZjyWTK+wm1xfuFQRFrRvyA=;
        fh=VZwqT+u+f7wiG3N3U4YKkWCwBjwAt/kF7Saku6gzpQo=;
        b=ouPbS9KkzMs6G6sbIgfOsi2ImSOnotXekySktZx46STgEctH14bfX6KW8d1RM6E3JA
         4OimnwdmV14g+2wG0y2kAXV5vT6EHFt1865XAiRTSyPFkgoRJRnJvYtK78dWZiiC2wyK
         vyi/jCW3NvPmqxcKtOV+Ljfjrs42fI73cD8T3K1MU9Sx3SFwEi7gniez/4dpnXf3Sg6d
         rb9x+NNpKTfCfpY9DjqIQ5z/ExqLofrYR4sAchTeSMP7HeBoeFTbxDMu0TRrnqIs01/n
         ZaZEcAKFvCKwTl4X3RFgbZSABFrbJ6RRHkYl9O9gEAhIxgO9V5nk9MtHesbZjRIbmQfu
         TngQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1788726261; x=1789331061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Voboc52MSInktoejszYvZjyWTK+wm1xfuFQRFrRvyA=;
        b=QMZyMhXMPG1lLpMm2mIPqLojdtScpzhCRn3hbur62QT5Qkv34pjdgoXNxhQLhogmKT
         9C6qzighv/9Z8cMHSaR5JqKxxOn4wf4JD2jFd1Gjvm9QzIcf6t1wiMzAWplwMousAMmg
         nWaIpoPPghMYD6EtdRKqHjDszHx3kiahA25fJKDD0IS9aco2tzLr3uuEekXNMZFefAXd
         v1E317JPoctuO1PMLbXFzywWBM9Z4B8z7Dz+A8Z5NNJh+qcsTtA4r9HvLfISqWGRL5yi
         9g16w3nAPl78AK+SNWKHQhRsnvAGyF5DU0VlPI3ECI4PweoRaTaykFgFGymTmSUef2m9
         xOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788726261; x=1789331061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Voboc52MSInktoejszYvZjyWTK+wm1xfuFQRFrRvyA=;
        b=EgkGB1G3Sq170eLJbeOFLWcJb0ixfJT7bFyoz1WrdLXakHAjfbRACnK93S5Dd7x0ky
         c6YQ2bbNwXBPHu14hU4pT7A9wFR9/5TQYJ6449GnUWo1wdCec2PZlPpEus/kUNzxZTL9
         bawY+SMkXE6xwAtDXQOPkuuBBGBNna2sZthMc/zDhtxEwAbVcEZVSy5nVrm2+v7MOUUw
         a5t3m6kv/Kro2S7kBxmNwOnD3CFVs4zTM3Sym6STkzLPFZqC4yf2lLf1tjNxmcKEA2dR
         c7k0wk+6m063TAgh/bZaReNRhvtDAFI+X1a28H1MFmIFAY3s9AZuD73icNVG6b6jbGwt
         TfOg==
X-Gm-Message-State: AFuF++kUmaTt4hWEiinUm6u5GKIDqS792J9TEZZ36TgjTYpkEW1MD9We
	1GFBX0028MczcFXWFo0s3twkzRMb8pv2tRETWN2ZX8UX7qjeQJywWeEtOtT4V3HjiC6j2ANpKd9
	v6wlk/xcxK3I2AvXZAMk1PRKoAzI96d70+bOehSD26w==
X-Gm-Gg: AYBFou3NFqoLm9QfzdnFW7iX20De9heOa7SbKqudd9RLNp6YcN1FlQAG9/BeGd6lmO0
	LLWJcgiiYUU4167yNgTDiRJSe88vP3sF6snX8qa/1s28wWAC23zt8WUomWKDHva4apuIUgiWQdq
	0RfNoOVACYUnWNpZkPKtVYK7ToRnFqDA850kUBsZpYwBKIRdmlDiHu5Kw7hzAi54Jjjsd7rVBqj
	sH1xnlt3KvmYkugSZ9fUVGzlSahbzycE2aKzEluh6QnOFsbwo3Fpiqi8Ni9Z2+h7PbzPVscVm+x
	gE7el8js/JULupIaPPvfroVvbm0wajLmqTMCOSc9K0QX
X-Received: by 2002:a05:6820:16a4:b0:6b1:b375:481 with SMTP id
 006d021491bc7-6b6f7c75a86mr18397044eaf.0.1788726261650; Sun, 06 Sep 2026
 13:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com> <D798198C-5F97-4701-9050-7868B6482214@gmail.com>
In-Reply-To: <D798198C-5F97-4701-9050-7868B6482214@gmail.com>
From: Tyler Cipriani <tyler@tylercipriani.com>
Date: Sun, 6 Sep 2026 14:24:10 -0600
X-Gm-Features: AcwNN1WNpqooe3Hd7V6qkCQ_OX0vz9xOkDnWbKpPRabeVt3pGTgWc1hBNeM8Zz4
Message-ID: <CAHLx=O=tVhtiZpaRP9TpfiBfOMS2xPe3c3=mC3VNEdBrLOioFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] push: fix --force-if-includes consulting wrong ref
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 12:59=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
> Thanks for the advice changes! One small nit on the first
> patch you can ignore if you choose.

Good call on updating the log message for PATCH 1/2. I'll note that
detached HEAD
is already rejected in v2.

> At first I hoped we might be able to stop rejecting detached
> HEAD pushes, but some further thought begs the question:
> what reflog would we use?
> HEAD=E2=80=99s is too broad :)
>
> So this may be all we can do for now.

It looks like that's the conclusion they reached on the original patchset, =
too,
based on my re-reading of the thread[0]. HEAD's reflog is too broad for the
--force-if-includes check (with the acknowledged downside being that
--force-if-includes isn't useful for the detached HEAD case.)

[0]: <https://lore.kernel.org/git/xmqqsgbdk69b.fsf@gitster.c.googlers.com/>

> At least I can replace my intuition with reading the error message again.

:)

Thank you for the review!
