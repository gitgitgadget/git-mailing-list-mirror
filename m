Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A92F7F0F
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311501; cv=pass; b=Znug9CdltC3TsPQOpI12kuYRbSeR6eefjjhGclC8l0gxVrjRlbCWT3prtPGazbz2Rh5gXkpQUB+DY6h1bKIILgz9Q5ec4GvH41/bAC6fkm09LccahHtYr8keBJCXQJa/cGQFOrq+HYXuqVGD8hdJqc2MwTT7xwNwwYnHQ6Y5kBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311501; c=relaxed/simple;
	bh=PEW/vL8/+SacwTcdM9V0WBHHVkXp1aEMKaKJM7XqdKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBBiSPhnRA7qWmnueZHWT6MZCVBygd4uhA73Yo8EQBNFA62wXtCrxPZr81RTtduqX5epz6KWHZcxaUbFL8EIG3ULvw+HIeRNNao+ZKR2TbNBf0kioP5Oe6fNaAwOhahySktw9dnf6aUExrB/3q78qRV9fhuY1DX3Il58QK2BZV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=NfeyMU80; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="NfeyMU80"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-662bcc30fafso1141502d50.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782311499; cv=none;
        d=google.com; s=arc-20240605;
        b=CVIpRMjvri3qX+/+YKvmaL7pqLIoIV0DaI+me5bLv+13sNAioaX/lJa6YMkqgWsEsw
         1WK+MVeBz1Dmx3YwIC1CjNkTUmWwINl9P9jS+Ny4vNrIDjP05Pb3JNIcaYidny9Rdv/6
         Zi1oUwcQ6bM/A1dRJm0hNc9O1Q4dQ+bd4U3Dy54Din0EfJpJ2kFb8mNkOr+TOZdCykdy
         putbnyIVivBKV3YoZ+67KLL3mf7uMiuBPR2MLiLNssduKnfAAPKYPUdCv8LRponsqm+S
         I/t11A1MPCX1dWQLzMhQEF4fBN+2gzRLGd/see9idLuPX0onpcu/gWd3pG8O/zJyNcFM
         RhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cEcmOcM7sXPnem4Oi0YlkTAPDk0MFYgYVRkioTO+Gj4=;
        fh=63AO9N7HgEINh64rxvpqn5HsJdxiX0pFNn2rHrm5dQA=;
        b=X2g4X7Sq/RUanUNdwPGqVqU5x2b3/l0bIsXGB12NEH9GWGmS6sWelDKtbgjNHyUXsO
         Yq7Xu4byFx3Z7xS1kVg+WPtwvTqMIZcMpsYeni5AARhyUXsRBNRXnvk+sDKTkTPw4pAz
         5wpmXEjY3w+0NdjhFtLkWsgBQhWA9MwQqdAu9DJQr6ZlhfJ63/coFf/xjovo5nowUzSG
         FbGDINtWnJ9jVj9WxQT92Nv0w1ERRWCqFmN8YkNKezlQB/Te2kdnjHUNQaRkrSYfyOCY
         JIHyqr4lLWoidISW2kQuoTAEC4nwyWLABYYGtQJ1DQ7DQKKzQ7q5NdRO5FIC/ifabAcr
         SOhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782311499; x=1782916299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEcmOcM7sXPnem4Oi0YlkTAPDk0MFYgYVRkioTO+Gj4=;
        b=NfeyMU8021N4m5pHDzSjL0lerSkXzMQT5lgYrJBXmgvqzpXqIU0LS7pSHcI5rUFvlL
         NHDnF/QEIn4eSFnKxYmVK9BR2yoVkxwIfnsALhyeYNatQduNmnvuUA68KRZ6ykm1Hi5b
         /0E5zVOqOIoHleGipm1uOBlF5JsB6Ae8qu55A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311499; x=1782916299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEcmOcM7sXPnem4Oi0YlkTAPDk0MFYgYVRkioTO+Gj4=;
        b=Uks5a1N5CKnIeGME+04cYyZioDOAKgtH49I2KzEKdGohreGXjRlsTHGNNQt5WONxpQ
         PLInS3gTK6evQnR8I77BgOIOEcGq28M2/aO2NAxAx7ywzblTYeMMh0a2xp0hpU55kDbS
         ax9VzvytLQxCpTSmxJLYKFVzNjgStB1bUL7j5QnrddSrnge7hjmt7rqALSeKm6La6GLZ
         1f/b593POcxZuH0JHLEdgNGhqKg2AqKkEENSq4ua34oTFOAKupsSMXKUGur2+nZcrzP7
         4cw75MIwxPwVphRNjAQCLyUycl2jPFmJ7p8jCncxKfW62hgEtfK6xiuyjyvNsr7UF5mC
         NC0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrCQjxiOEezmeQCStG2gQCI2f01s0+uW3cafsYEHH0WNTga0em2khDZLofzstY3VXsXY9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSJBVhiZVFuMssAi9dvk61XdoZOUoXeDFO8fFxkKp3facUMP+
	o57TDf/N3S8DnPk/A2CPZvQsIPAxxI879RmKl7PWfe8fQC8utkg/MOFuF2pjVIWZBsOex0waSN1
	BdMOCkDsSJVkSnMp7u5q9LL5nnE3yxNZEjFylJ+O90A==
X-Gm-Gg: AfdE7cme/Xqw1N2iqZqLjFGVyi4KZvrXSWVTf+fyYmJTSk2EhjV8bjr2Wyn2bFU6PaT
	1V2zrjAKOq+oegkcwO2MSCc2pHSBKIIGuQ4d83elPBKDxlvYY8tskRnSDNP3EEY0eSzxT/Sjyrl
	zSOpLp9xJ0pKCl+hl7idFBiWFR5rxFi1dcnUEM5Il5CJ+eGk0GzBu9oGZCLlqiD59e1tSLYV1pR
	rKpXtTxUs7JdRdD4qtrIX+9BOmmdVcqtVfnnr/w0JosGELXn8dcVjiYaaHetGipF8z5JTYbIm3D
	gtDJJdCi
X-Received: by 2002:a53:d009:0:b0:658:e645:7736 with SMTP id
 956f58d0204a3-6636e434524mr2978394d50.39.1782311499107; Wed, 24 Jun 2026
 07:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com> <6ade4df2ed2a836a3b4c5400ab13e8247e36c029.1782303254.git.gitgitgadget@gmail.com>
 <560c91df-3c07-4c8f-9924-ef0cc7646e08@gmail.com>
In-Reply-To: <560c91df-3c07-4c8f-9924-ef0cc7646e08@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 24 Jun 2026 16:31:26 +0200
X-Gm-Features: AVVi8CeDuj_vUKMjrTxULVUMf5ixX2nBcx1FtZLjCoIiMN9uE9LYEKEGOf2GQ8E
Message-ID: <CAL71e4O7s7y+SJRp3GZB+j9SLB_q=kK8ysCKqH9Mp2VDn0sT=Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] commit-reach: add trace2 instrumentation to paint_down_to_common()
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 at 15:41, Derrick Stolee <stolee@gmail.com> wrote:
>
> (highlighting this chunk)
>
> > +     rm -rf .git/objects/info/commit-graph \
> > +             .git/objects/info/commit-graphs &&
> > +
> > +     GIT_TRACE2_EVENT="$(pwd)/trace-none.txt" \
> > +             git merge-base --all commit-9-9 commit-9-1 >actual &&
> > +     test_trace2_data paint_down_to_common steps 81 <trace-none.txt &&
>
> I'd rather see the whitespace line before the `rm` to make it
> more obvious that it's setting up the "none" case.

Ah yes, good point, will fix.

> > +     cp commit-graph-full .git/objects/info/commit-graph &&
> > +     GIT_TRACE2_EVENT="$(pwd)/trace-full.txt" \
> > +             git merge-base --all commit-9-9 commit-9-1 >actual &&
> > +     test_trace2_data paint_down_to_common steps 80 <trace-full.txt &&
> > +
> > +     cp commit-graph-half .git/objects/info/commit-graph &&
> > +     GIT_TRACE2_EVENT="$(pwd)/trace-half.txt" \
> > +             git merge-base --all commit-9-9 commit-9-1 >actual &&
> > +     test_trace2_data paint_down_to_common steps 81 <trace-half.txt
> > +'
> > +
>
> This test is a great example. I look forward to seeing that it
> updates in the future.
>
> One thing I was hoping to see was that your side-exhaustion tests
> (from patch v2 2/7) would also include these checks so they are
> more obviously updating when the implementation updates later.

I was internally contemplating how much I should introduce the steps
validation to existing tests. My worry was that it might make tests
fragile - for example I repeatedly got some off-by-one changes
after refactoring the halt condition slightly (differs depending on
adding the halts solely within paint_queue_get or having it at the end
of the loop) and I think potentially other future work could affect it.

But I'm happy to attach the steps checks for more relevant tests,
it's not much work to change.

> One way to accomplish that is to reorder this patch before adding
> those tests so their first version includes these checks and then
> the values update when changing the implementation.

I was thinking I could keep the same order, but the patch to introduce
the trace could also modify the tests at the same time - that would
perhaps make it even more clear. Also this means I could avoid
making changes to Elijah's commit that I already _partly_ butchered
(extracted the test change as-is, but dropped the other file changes)
and I don't want to make that one more unclean.

Thanks,
Kristofer
