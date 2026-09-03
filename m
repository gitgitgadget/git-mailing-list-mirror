Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111E2D5C83
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423082; cv=pass; b=Km7HsMSrufTnbWNk2yipvKNbKFrHQ1bNlLSRdITs9iVomDr9bv1jBNT2M8cM/XPIL+8P0aW7J2n/TroM9qxH99G2Ux06szAkuR/eweQl7U/Wcdt5jr/SkF6uFVRIIJAXS65E6yOu9A3pb3aoPqQ0oj2ucCFoC9ojO9dtyxSgy3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423082; c=relaxed/simple;
	bh=oWIdlIPQCoDphFau2p8lMwMkVyJGyaBZcPZPv0G1F/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiVJjFSnTdI6PjBnh6gbt/D9zvY9MAxd43IqDqX7pfgYYkmnFRI1OeStrEUwZ0Yy9ijSKrRFmHaqZtfGW10W6ntooOv9TnKTZwnoWFuBPUSxrjM3NzA4itCjz+WZBuAqqoBTAfoBPHQbsdhiUGR8kJuJSM6GBm7eXL5hUXqyKHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=q+AcwDn2; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="q+AcwDn2"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836c4474028so27087797b3.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 01:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788423077; cv=none;
        d=google.com; s=arc-20260327;
        b=EvbcT+52C2p1yPSTY2228r4powr47qaKtaNfAtd6iA3T89KFwJR+bL63b0T4nSdHYA
         bygomzqmyhng0zvzvPPqI4yTTp8rt/nLjG1k1DsulJTaLhkMkl0P2sjkfU3FpNIKfYgt
         DYYlNnXM2S/PtZS9SCHhQA9YUYJHO8/X83pwqAPKPkjogxgRU/vcZP0WCxF0ez4Lnc7D
         tTjnj3wgaWFlUW7uSKWrbm8TZGH7KeKiLeQg8McxD7vapiRiOX6e8hKtruHwRAqD3FZz
         v/IL3KuiH5M7w77IwWohhghbRqIwQ3mg5TLDVaoc83rTzJEULkOWeiF4A+NrQHIWb8Lg
         2eKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oWIdlIPQCoDphFau2p8lMwMkVyJGyaBZcPZPv0G1F/k=;
        fh=H5q+GNFzQQWddu3jvPC5d4syvERE0ngQShm6yy24H7E=;
        b=HajiwC4hgzGpODYVWtBadRr/cDV2j696xJgm0GxFtRcAhr6/SWqovEatZgYhddElYr
         y9XL08z988O8uXgYSW3THzvOU1L8LaVb/1xR2otQcNHpRVX6aq7W3oAO+67k5y4gJiar
         FDiNNvaHmGjzXkCWLRigNZ/SI1+eVrlY5Mf7h/tTjRE3KDogQxEyHy+qPx5xw1Lge5Vc
         xyk+RpkSueEcmWeGVWwz1wCOvx/l8kNKfSm/Mry+iXDfbEItVhCECVgawJJ8U0qhmvuS
         MvfR0T0Y9JBcBVJCuPsEqTfLfeO/NFzIS0/P3l3LhsHp5xSZIVBHsoquoWJTeeOP7RJU
         zjOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788423077; x=1789027877; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oWIdlIPQCoDphFau2p8lMwMkVyJGyaBZcPZPv0G1F/k=;
        b=q+AcwDn2D9HhYl066sLKWYwICOVwVLeX+1lVz7iai0+Gx97/IZobMdd0bhGE44AmEp
         VzaKGLOca4mZzLTF6IjhOwxc/IOKk6O+dMKu+oGC83XWtnzarURz53rEoozDmo2WAdPq
         Yg42DjDOZVMCyo0LVVJYqQTBbF/FHiPrWczRcCHMNb15h8lgTZoB+B4z3vT302wRweGJ
         C6o5WDSNbX5tNmGGsJnvCzjasLJLdVP/X/xarGAbKIuWkBA9UYHRXfUt6gtU5Xy3hrK8
         KARFEsAJmJ4wEyH1YFXBCDgoSjpC9ZJZ3Art34vdg3sxyWHR2abuLJYH/mYtA8cQsIbQ
         HtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423077; x=1789027877;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oWIdlIPQCoDphFau2p8lMwMkVyJGyaBZcPZPv0G1F/k=;
        b=kU8sqqb0/nKCdf6nzBrYAtzjhvIyLgkyfpZp3z+jMHO4oenIc7atjp+UBebSfP+q/y
         pHSkvtHTD/sBgMEL2ZGJ7SXU7sr9E6LhBv5CxDVRS9nwwvy3xuC8Rob6HVMVZlXuZhpj
         IiC2hgWPaPXSdx4IJAy3UUNDuUeWz9b0nE0fp7mQgxJbvhjNgpyorrWU5t/3Yfl2aGf5
         ej82Im5VPu7pviQTgi0pRkOSO9+JYJTP38k+6DC9/g7HYLNsBDuLnBOcccmVk0lxv0sj
         SKj3rQrcquQmIrHs+HZGlbdsuleVKwVD/H2DpV9ovhsjE/TvRosG+f7XIQSHA8NND0u5
         uS/A==
X-Forwarded-Encrypted: i=1; AKwUvBx+0j1N4V8v6GmmP0jXSdOYZuolkoLQXoDFXTcmi4nBxMQRLpzRfkhjkSGNQMfZPM8a6Wc=@vger.kernel.org
X-Gm-Message-State: AFuF++lRhcTLuE/7LqWdiDVJ28z7GC1QIMT8o3SqFOTx0fqRxU9jTfqs
	/Lxsyo9Rh/FogK2G+fPDn6uoT6F9fWA/F6Ce1V0sXOnXoA/mRW78U08eevWum9H5MElqDisVHHP
	SYbzn4bEeYG8MjFozebS3ap8+TzAi4Z7UpwLG4t+FTGgwdtwnfESN5Z8LuGZABIs=
X-Gm-Gg: AYBFou22Pq5DnhzzScwH7wgxIbn4umjUWTyPOiJEgo4eo99nwONgPsXUYFjGZ2tS5qi
	zsyN+Yb8Kbv3iOGD3DzF2ROwWOMEXre04W6bPgVHKJ583ofv0MlkEM5T46DufxIiLn6r4UxGOZN
	4O4AYf9fFAF8FJU/BXm69EEFwlU0j1KQGR3eixvxhah8kYi/XCVXDTYNsxHtNEBFdNel0wJ/UDH
	zFg5+Y8QZwEDYLq+lVU6Lb/x4fal4n6lnte0KwpIZKb01gghzS8UlyC0+A92m3cFsH0vm+Rup8T
	kpDqqarjThA27AzmDNZ5OYDnAiVGiqvRbYu2F23M+o+YWp9jyF5m1gh3qy3EGbExLLKEgPP+GLw
	Tpr34SLh02RGeFA==
X-Received: by 2002:a05:690c:c505:b0:823:2ad3:d392 with SMTP id
 00721157ae682-86c5492dda5mr59084287b3.31.1788423077404; Thu, 03 Sep 2026
 01:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com> <apkkVAYOqjfAsp9-@pks.im>
In-Reply-To: <apkkVAYOqjfAsp9-@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Thu, 3 Sep 2026 10:11:05 +0200
X-Gm-Features: AcwNN1VleSd1byvBWMVttPqpWzGfCPNuXey2u-PEoW6H2hdNT-MXBiYD1jH-7cA
Message-ID: <CAA0xjtp+Og_k7BYZfwX-LRW_8TAiCyp846+Mhk+hERM_GmRYkA@mail.gmail.com>
Subject: Re: [PATCH] rerere: keep a background gc from killing a rebase
To: Patrick Steinhardt <ps@pks.im>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Thu, Sep 03, 2026 at 09:40:04AM +0200, Patrick Steinhardt wrote:
> I think this hints that we should tweak the default value of
> "maintenance.rerere-gc.auto". The way it's currently written we indeed
> are quite aggressive with spawning `git rerere gc`, and I agree that we
> should tweak it. And in the best case we'd not only respect whether we
> have a specific number of entries, but we should also respect whether
> those would be garbage collected in the first place.
>
> I'll send a patch series later today to do this.

Thanks. Checking whether anything would actually be pruned sounds
right to me. It takes the frequency away, not the race, so I'd still
do the sequencer part Phillip asked for.

> Having a locking timeout is sensible anyway, I think. It does not only
> solve races with a concurrent maintenance run, but also with concurrent
> writers.

Phillip found the wait unfortunate and I offered to drop it. You would
keep it. I think the two fit together: wait up to rerere.lockTimeout,
then warn and return -1 instead of dying, so the caller goes on
without rerere this once. The gc passes 0 and does not wait. That
takes the die out, which is what broke the rebase. The wait stays,
bounded to a second, but skipping rerere is not free either: it can
mean resolving a conflict again that rerere had already recorded, and
a second is cheap next to that. With the sequencer no longer spawning
the gc and your heuristic change, it should rarely come to either.
Phillip, would that work for you?

> We should instead pass `LOCK_REPORT_ON_ERROR`, as the lockfile machinery
> knows better why exactly locking has failed.

Agreed on the text, which also names a stale lock. But the callers
that go on without rerere then exit as if it were disabled, "git
commit" with 0, so for them I'd print it as a warning through
unable_to_lock_message() rather than let LOCK_REPORT_ON_ERROR call it
an error. An explicit "git rerere forget" or "clear" fails as before.

> I think we can easily combine those two branches and simply set the
> timeout value to 0 in case we see the flag.

Yes, that folds into one call.

So v2: setup_rerere() waits up to rerere.lockTimeout, 0 for the gc,
then warns and returns -1 where the caller can go on, with the
sequencer patch on top. I'll reroll once Phillip has had a look.

Thanks,
Tom
