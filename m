Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE282F261C
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691987; cv=pass; b=Ub4Zo8lqSc/h5uXFfluJuAx3mSybUrImliSMBFaVlqJJ0AeHZDj2pbkZ1nBOvDNIobb8/HbWMb8M5w/+SgMdK6w031LHkmuEMlERZMNV5nsTjtnfZ0f+F3e1sIp5Rq0AlXDWj5kzQKfySqDon/aHejd5dhlPyUyHGYuYIALv01U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691987; c=relaxed/simple;
	bh=gjmIcLLwtWS5H87Sk1OX1w1J4XC7LnaRIbvZGftM4NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u96S7LVvUwNEG9nTfNtQRNrygIULCWcWaf4raq6xwcdbaqA+CDOX7KluvFkZfIsCxQVN/X/paT3rWMexk8tq53Uy+sDpKiTh2nEltPC4lsoTuEeDTbd2GG02I52glnmEgUIf1s11RkM+tn85Tjq+11uo46U2DShIytAXAVcHDyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Q2ldKR7X; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Q2ldKR7X"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dfceeaf168so23489607b3.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 13:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780691984; cv=none;
        d=google.com; s=arc-20240605;
        b=kPov8Ff7yB2vIKWdE/qr0FGmh41biGCnx63AGTzLOFsgbRe75AHTYrCG3hXptgSipa
         920XftxHE6dZ8swTADtFdqjK+hPhGjlmCeuHO8r7BXy1ocMhAC25bQ11gcPsNk90shg6
         Dg/eXAIrKuScMDkYS0WefdXTjzkXOVE8IlE0eT608C0cKsrkzGJXznhjW9cX7KeVkBN3
         BWxYY6RbYnPINXvANMFqk2oiOq9TtXMZjDgPLGN82QtP93wlUeYazz/LQFnCviN6erhq
         14Y/84ssyExvpo8Y+toWTpKvqkKPd57NADNym/cU/g7XLcKLRAbPZCvvJA4HvUWuNZHb
         oOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Uja8RGM/+vmdoB2uhBDfwAD9106XvcgfdLaoE/12qqc=;
        fh=G5jRirRHmtEwXQa7i4ZTg69tahA1P1QlqeupvgSz2tc=;
        b=d5V61dr5+5CB4XhnlPn86iiDbGxTTMyu+sYyOwWzyh5/nZ3kYqIAC7cAKVeGT1I0yR
         wEcb+ucknVDEZga1UqjOKX8f9+BjVP2OemEb0DaKVyFuQHtPciEJD5MKqe0CMv9RCnVG
         hQ1ZuOPsye58FlAILAgxMX+gnAdQm+0F1qvqmKf3gk2X+nJe3oeHR6HKRNgAl7+8K1p2
         oTA6yYu5iz4p35vNBaOaOZbpOfGH4kfHE0aRhCbb2Bn/Zvt1DHtf4m0DPg54OGbnev7A
         XZWkNbCTE66zhPqfd+x3l7AhAhaISrbKxu2KuI7qBpwnFigafSc9PkhWJRKOLfhCfZh5
         heVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1780691984; x=1781296784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uja8RGM/+vmdoB2uhBDfwAD9106XvcgfdLaoE/12qqc=;
        b=Q2ldKR7Xvc4qbGcXvBLTzv+ZSExzO5UrZflpVuXpYU1p64dI9P7ZHBgMepzmOo4rOb
         jFmdaEAwIf/SALoHj7qm9qXWdTRPsiMEzyxMFCbJt9sZfTLTp5AGH63CiJRsfrYwAFqz
         MxwdoUGi3tg+MWb4sqXwpns4NTHqXn8PqNHak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691984; x=1781296784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uja8RGM/+vmdoB2uhBDfwAD9106XvcgfdLaoE/12qqc=;
        b=TauX32wX+OykCqt+s80pQApnXDCpr2Tx+W0qwyRtq1xfiPKAkL4qtsJUMU/quipkqp
         DkoYKK4USuFEF2gOq81X9AW6dk7H4fFG49M2OakwdjpNeuZ4lL99GfmEQW9hJU0z8Agv
         Le9igYO42t560ty6MqDBVGmjgqyuJ1EuMsVYFHZQNhG8RmI4viJlXQ++bum5wB5Uv4fC
         2v4xHYucj7PCCw3Pv24M31I8LejPLOSaFzLUBvT3oOpvduBCv0V4/9HzVaFEuLSWSSN6
         FJ3FMr0wG5dl3uOTcndRikbz+7WMZNPAYHxSmXwEsxSIW+EenNEdodwr+v1DQNFbdmzE
         G+KQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rz8Ha8geTUrAOOgg9tj/WfqPYdN/ZvHKSdwLyqwbzDs0iqBqfBLekLkxHp0/6cSQDMRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy16nmQLzydSy2fjTv2/5NVhFsXpW69uKt9euE+4aBUi3b2B6tu
	Bzg7VUW6q8xQCRqhODTvg5sKevMQK76JvfyG6s0/npaEAW3Fo0d4gI3xHcnLqtdSyUFegVbiBId
	UT7vtfVdFJubPhaYxq910CudKwQm+F50fTNuhzIV82Q==
X-Gm-Gg: Acq92OGNbQkAXYPp5ORk/oG263RtBqmub/0NnIH5dIykJejfSiI4KRe6F0mnCgA0ndY
	C4xSCT1dcPEFzyBwFnLkubqgoqv0EzKdXvEmxu0y8mSxOfvhtWfjM+A7MGeJMS1wyPZgmurj2ev
	jMZvqrTdUrbDIxt5Pc+ChIMN7RHHWq4psIT3Ipmqa/888jkwdMNDJ0l5rqeBlAzdtuZl1imG2xK
	TEs5zTCGnNhrFb2QML5sweLTWLZv5wJvvc7Bhe1+ps0e+epI5DOiIc6AfFVY0b6++WkBagoX2gZ
	7tDjoaT++SU+XA5qyA==
X-Received: by 2002:a05:690c:620e:b0:7d0:5c67:200b with SMTP id
 00721157ae682-7ed0b391121mr54457187b3.0.1780691984487; Fri, 05 Jun 2026
 13:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com> <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
 <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
In-Reply-To: <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 5 Jun 2026 22:39:32 +0200
X-Gm-Features: AVHnY4K-dAubYeELDDceAkLnauNhd_7JOONCcNQp5KC8S9ikmGyvK0_hg_5KVK0
Message-ID: <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I did some more benchmarking to understand how these approaches
interact, with four variants based on origin/next on my large monorepo:

  1. base: next as-is
  2. cascade: base + sift_up_rebalance from this patch (v2)
  3. lazy-fold: base + lazy get fusion folded into prio_queue
  4. cascade+lazy: both combined

Note that alt 3 is not yet shared with the mailing list so it's hard for you
to reason about it, though it's quite straightforward. I will submit a new
patch for that one soon, not necessarily with the primary goal to merge it,
but rather show how it is implemented.

  merge-base --all master master~1000:
    base            4.27s
    cascade         4.07s  (1.05x)
    lazy-fold       4.12s  (1.03x)
    cascade+lazy    4.01s  (1.06x)

  rev-list --count master~1000..master:
    base            3.60s
    cascade         3.35s  (1.08x)
    lazy-fold       3.37s  (1.07x)
    cascade+lazy    3.30s  (1.09x)

So both optimizations are valuable both on their own, and when combined,
which I think helps to reason about it. This cascading sift seems to have a
larger effect, but folding lazy_queue into prio_queue also speeds up other
use cases and simplifies the code a bit.

Based on this, my (very subjective) approach would be:

1. Land this cascade patch first since it's a pure algorithmic improvement,
2. Follow up with a separate patch that folds lazy_queue into
     prio_queue. Will post it separately soon, as I mentioned.

- Kristofer
