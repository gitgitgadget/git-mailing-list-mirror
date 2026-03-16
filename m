Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B429373C0E
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702504; cv=pass; b=tKH9WAKOlq6R/7vnmkgloAFNFQF8cheW82httjNdtfJY0OaTc7OH2UkLpTUn1klibzgxUjkvQR+dW67dVDKOgCaSsxA+HWay69BkwyT+xOJYWQXDwXhYR0fzETWLRuDt4GyeuUm2vwohatR91r0Xd/cLuUyBBGjnSvthqp3GYuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702504; c=relaxed/simple;
	bh=uAG3m1xmuAxJL3dcZ5tEgO4zy96dtvkIPIz2QejvC4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1CioG5B7D1l9wtpyW0wQuDMIV8T5Zw9/exkrOGtEksuAkZAW+T9Z1re3qop6cnaZmNd1FWoRnjEO4CD7JRqQKNE+5yFw6ZTJuDZ6xNWnFQgSek79Oir7x+rUGwMhH9Mo6ZtvR/AdbebFaytVfZbZ0LU9ru6lNL3ySwQxIKvWSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1nHwKFO; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1nHwKFO"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a5ad7cc52so11209547b3.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773702502; cv=none;
        d=google.com; s=arc-20240605;
        b=h2X02yYS/8XiOhpw+abetIN5DqutyR06H+tqG0AzJAgp36zwzlVSlOXPNOtc7BcKE9
         JLt76SC51yAyQkfoo+uiRlCmv5FI+e0V4aOcjm3n8/egDLhgOF75Sv9/VrgnbrtaiKnU
         Tk6rWXlj+7Yt1JeDJNDPxSRLjd+/NqySa7G8qpjLbTmoF/k1auq6FyG8FqT6Gr0mim1B
         3V6eaq2omKKSa/kWC+DpQvKrP4BGZSMxxVZ2oItDFB+nfljP5xybO6E86Hh2pxYKcYmG
         QbbnNXTmzULrevv5K7XqOK/YO93fsAQrruYLPvLdpqSdJUK7O8AzsRl8zZ3doyIkkWAb
         qWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gInx/PsIpVml5Aux84pHFzObYWZiE2UYJTWP6ji4Re4=;
        fh=dbCSF73lZFJ5AOLWDBIH7dZiOSDSmRP+Sng7AkCGcpI=;
        b=RLohmneRbB3vgCa0my7mpMbxevKxsTFUoEV6W9EGlF8qG8mXQWFK88bo1AKYVguvnU
         z/oFCyUzKRPrnDLrt8KomUeu3dy4zwwPTADl5tsWyEZtITPRlKDU+qyjhhXnV+55wFYN
         p6FuqW9S3uKeFGV3f8+WevNQBvuMMfCOkO/SJRoFTEwc6wiPux0GwlYuS9lY1W7cIwWu
         ShQIXYS2j7VvR3NLJYZyNeCgexZARYl2K31OU1fg0sgJg+Aa1zlLalAdic550E1pGHYS
         c2wCA6zpWSrqzhcWXNw222O6RD0ZvAaoJaB7uy65/n0fSQ4uNsrFREqJmc+N1heXp388
         LhkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773702502; x=1774307302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gInx/PsIpVml5Aux84pHFzObYWZiE2UYJTWP6ji4Re4=;
        b=L1nHwKFODzrti943KiQlFdjyVTKGLBoiTaNJQNHENFFXRu33cfq4vrKpQlMAmae7Kv
         l409u1sV52K+vNrMuqL0P9uwcHwkSe0+WYdv1gSQuQ0zEeuIIS1nZN210LvdTJzuBMmq
         3WhJsTQEiwoM2sZA0K/JRl8VM5mwqtSZ0l9Drk/51vqJ1fMnzILBG25BW3Obc4/WR41/
         fX+2jEcM+HS1IJxqUTkf+9efJulOKqDzMtvGIVEMpYr5acFmfvtFluaxzvZ9YePe+u0w
         2XLKf5FHUagR3r+AETRiDfpbgmBLsvB/XyOJO4YUpaYaVjkE4SZy4+Zxfy7y+4UJlLOC
         W7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702502; x=1774307302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gInx/PsIpVml5Aux84pHFzObYWZiE2UYJTWP6ji4Re4=;
        b=o2WKPdr6LVKvCfgDfuZm22Nf1gx3K3eRiPIx/OcngVRYgXF+hMqg/1gkAjhMk5HycM
         pxL3YrmqNRBnNlIURwfBR7e0TQoDZ9ekf7OG+kkZn4gG3Fpfsz1Lw9y/adgxGMRsUXBq
         1dL5USmjgzSim25pKtzcxbM/EAxujjAVG1Q7h0rhFUByQBbJj8TBhmneW1vxOm/xF+PB
         pOL3G0u2/R6vA0emQ5vPE+eFVzFAQ90Vk6/TBrXZPn7RQKXSS4CNE17c/M7R+GiNVO8g
         vZUjA1QBknntZfR/era7w+1/FUnOaIyOyA73KoLeAFyF/lX0/1RkfHZBXLSvD59AByg8
         a7vw==
X-Gm-Message-State: AOJu0YyN/FdgKRJtW5Y+lH5alIJsX+JyZ3Y394CwP5RXkRuqs4FIZC0K
	5KQzqViurTa9L6RGm2SbErgKDsV8lh20m+oFT9q1XG+iYdWrd5oEn6zhVO17CG5VdypFI8gbydt
	17KX0ynIuumyz/vdiXO7h8WsfnLBqcBY=
X-Gm-Gg: ATEYQzwLwfUICAgfHqmF9vcpG2On0O4JeCVUqW4xT8ajEHFrGQtdARGJTzo/K8E9891
	xe86P14cVY2TOfmg2dbRJc3T1G6ENzXUmMWAKXSQW+LeXe1ztqBm9MqDfsiLbXqB0K/di1ump3k
	YtCl5eSyw7oHqZlJ7vxqngxc8zNtAgbJdt7xJcfaUWDN503xWeeUowTHt3MskRKRByai+g2W5BE
	Yi91gueCjAeRQS5tCf+QXPfU3ACo5k9MwRS5L8FkL1vNwx4T9HLa0Wtpc2+1auTXbUGvvVYkaqv
	lHfhTyvTUIGq57nh
X-Received: by 2002:a05:690c:e691:20b0:797:a75e:3676 with SMTP id
 00721157ae682-79a1bee11demr113799297b3.0.1773702502301; Mon, 16 Mar 2026
 16:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313193537.62827-1-eric.peijian@gmail.com>
 <20260316045102.70551-1-eric.peijian@gmail.com> <aberRbSCbMtZrqxk@pks.im>
In-Reply-To: <aberRbSCbMtZrqxk@pks.im>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 16 Mar 2026 19:08:11 -0400
X-Gm-Features: AaiRm52fSomoKRr3JN6F4InxiUU0o6kTeeKHu9hwmGvx1Pi8HghdeS3noeBpgCg
Message-ID: <CAN2LT1DJcSEKuQOk2PHgUwORKwR4Vqo5=f2_FtNXHMH0BxvLZQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] refs: add 'preparing' phase to the
 reference-transaction hook
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, ericju711@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 3:03=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 16, 2026 at 12:51:01AM -0400, Eric Ju wrote:
> > Changes since v1:
> >
> > - Fix commit title to follow "area: description" convention
> >   ("refs: add 'preparing' phase to reference-transaction hook")
> > - Correct phase names in documentation to past tense
> >   ("committed", "aborted")
> > - Fix the sentence about backwards compatibility with unknown phases
> > - Update die() messages to identify the hook by full name and phase
> >   ("ref updates rejected by the reference-transaction hook at its
> >   preparing/prepared phase")
> > - Consolidate author identity to eric.peijian@gmail.com
> > - Add clarification in reply to the question about how to use the prepa=
ring
> >   phase for write serialization
>
> All of these changes look good to me, thanks. This patch already looks
> good to me, but I'm of course biased as I have been helping out behind
> the scenes before the first version of this patch landed on the mailing
> list.
>
> > Range-diff against v1:
> > 1:  5f9f13a84d ! 1:  fb74f21d98 Add preparing state to reference-transa=
ction hook
> >     @@ Commit message
> >          interfering with the locking state.
> >
> >          This change is strictly speaking not backwards compatible. Exi=
sting hook
> >     -    scripts that do not know to handle unknown phases handle the "=
preparing" state
> >     -    string will encounter an unknown phase, and that might cause t=
hem to return an
> >     -    error now. But the hook is considered to expose internal imple=
mentation details
> >     +    scripts that do not know how to handle unknown phases may trea=
t
> >     +    'preparing' as an error and return non-zero.
> >     +    But the hook is considered to expose internal implementation d=
etails
> >          of how Git works, and as such we have been a bit more lenient =
with changing its
> >          exact semantics, like for example in a8ae923f85 (refs: support=
 symrefs in
> >          'reference-transaction' hook, 2024-05-07).
>
> One micro-nit: this paragraph could use some reflowing. But I don't
> think it's worth a reroll.
>
> Thanks!
>
> Patrick

Thank you. I will reflow the paragraph in v3, which I am already
planning to send for the error message and string constant changes.

- Eric
