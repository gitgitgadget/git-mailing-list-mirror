Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C116D39902B
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788690589; cv=pass; b=o0KyAeRh7wxpogay0NH2hKpGwuNiJqtbY2KNL4vtEcNZLOWy4GhYz4DYdO9/fUMKQWdYrTsaBh7tzn3WGmEr6gf7TPAZdTLGQgK3/1xgOhCxlw3+giD3A6es6lYmDWEWHrHUwkaeXObdsN1e8i1h4Wn0TaSjrDqrISziu927s0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788690589; c=relaxed/simple;
	bh=b5xh9v8RYtSmkiBr6WNQ8WSzAAYFBVLlieQI8PPIUv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWYF1fiKWf88l+3MBuXqBwnn1keXeRzdfAbQV2hYN4dBombO5HRmyC/mXigH/I+d4Mp/cvhh+CgzlDcyXTW0CD8+n5IerbHiDjFqToYkEb96tA4HZnNSzd7DweoSyuIx0XjTxp4xjgojB8STBpBJNV4kiCHUwhw9ym6/uMZGGjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=ue387tM0; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="ue387tM0"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-86162c086f8so29536627b3.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 03:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788690584; cv=none;
        d=google.com; s=arc-20260327;
        b=IkXr7efNZBFzr8HgmoiS2clSFbcGaaVGMQorIPz3ixf3pgRTPCuNvurWEJ/iOsr40b
         Cm9Qb6cHxQ+NbuUemFoGKW5mKgR9XJ2CNHI6aG83/2FN7f4X7QN4rTjQpTw8Tgrqmi2L
         fgsflqu1rfKUfmgC5wy7mm+YslkWfaWdh4GCt+up7ZiSmuMSNULNsC4zBxSa+yGSlJWs
         KlepUI2iR+DmVG7s2HS0V4ANuu8+L6hL8Al13IJAItl4o1y5YUxApw8MddVyuQnd7YEp
         gi/jKEoVPpVvkggCfE/ioa6j+hkMxqlOzPR6DlhfslKnuMWScNnsjNmhYbpJ9Mt7wW6u
         aFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b5xh9v8RYtSmkiBr6WNQ8WSzAAYFBVLlieQI8PPIUv0=;
        fh=7Uh6Bq3GCc06IiAqCO1Pt186BjfrolaRCNK3u0cYVcw=;
        b=KD0xPndm8/6NYELUubbL+YzBwrFQIRgyEpu1joyKBTHBoTHm2mtNCKmjXy8QlGhsB7
         5/kAHeGoyPj+dlPLUxZ5d2NrLoYt1trC+Py7tXnW+oN1t38tloPTfI79nQ2Jl6YAwElq
         4HbFv5dftL+hqKzgLaoOQ2ecWa4RVeyP8CoCw5pYE8sVADMI2YV+rr07kmrXtR4Z7jHQ
         +5RfvVcyZFi+PF7EvadrhDSA+bjYWGpYfbvjT5LWT/g8yQj7iRHaJcnZidg9Tv1MMURK
         Ew3nsbI1BzNxvspmgepIqUHUvF0IJLIDhz6b/K9qwLK7coqguYsdBvZldzB8WHOOQFF4
         fPWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788690584; x=1789295384; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5xh9v8RYtSmkiBr6WNQ8WSzAAYFBVLlieQI8PPIUv0=;
        b=ue387tM0PLyguALa8Z6kOPYIaiSb0iR3+c6lnnjkG0BFPW2vBRs2zPAQuqR3ehvVHf
         1GGvPperIqfpr84SvcIg44A6zL8WwW+WCKUoJtDcLK3V7ugvN7AYnyES/D8ae1PSlwos
         1UsyMsMFHCRqBL/UTY+HK4oa0/0vtkiUxwKNGtF5xmguw9ODRVipBsgaBkqWFcO/DywC
         Jjdnf6oKfWdkUWTGXrCebWfI3BI3c2cnmvxTnEtM6sOPnPm6++vrYYNX7bA5/A7ri6GB
         YNnBLD4qrf+DTFpuOwYbcSwk6Kvo184/JI1Vh6fwR7QNMl2+YHv0irlLUHFIKyOrSB7B
         UBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788690584; x=1789295384;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b5xh9v8RYtSmkiBr6WNQ8WSzAAYFBVLlieQI8PPIUv0=;
        b=j5LXJ7y8SLYEa5LrhA3BT3OS85OmN9tBB6CH1PuflBzQOJRbX7pRtAdRUNcoRlFcR+
         3l9XjyG/Bnx/ZS+jNajGFGQ9HoyhHlrmrd0GXwzk4BJ1pGBopn498hUsIC8KgZPP5WkF
         BU0FKojLpYwKrS3kDKsHqccZZrMeuwvbWq8/IeJ2V5Cy1jwsPc8pZmuiJf4GUyhJLUZ+
         EoVci0uIt+B9dE3qXJazDGhsRigScrUx8Pm57eFlnCUWjRU9KpYjIJHZqyUBONiRvExm
         jJwgWYYBHaBITGXg6WxeV3cCHvt01l55czaGAX6s864ogawv+KgO1gbfNOJ3gBaYTp3S
         fGeg==
X-Gm-Message-State: AFuF++kxBSzUf9Q5SF2Sc9EAqxlOV+W8Z1+0ShU3aB4+C5fZbr2nOGs6
	VXOeonp7IaDSX4SHI54WWvYRWTfTKG6JBqmizVcdU4nOVyah+5aQx2y/rJ9zCnGmn6pFWMJmfzW
	z8ARWFtZyH4JJIPdfLH3wxxaYnMZBBdyfajdzLzvtzhaQkN/A7Ctxdsnjm4yJ
X-Gm-Gg: AYBFou2mhWixu9E1BmA4DO8aCXmFATC1zBMn9JvMR1+idsfo8yOC7SVCl+WiFtdj7gJ
	xpYcn93BfkBULDe2qtq1cuv0boz/CnccyWPoc7avzp0F+ESYTolQyip3VmKj49xqTUSbUv8X7Vr
	W3H/t+COUIdHuw6HfG6VZsRcDuPXAd9kAT8iPf6pNWb96/oPc+6eotWH7jz0OM6oryN4XNjjQxs
	eIdgJmwCizedHKoOzln3sWF2xszgnJXT9vmd2hqU/a/9DQ/AbW8qOKzpRsNr8eMY63N32rTYDEF
	pvr4d0ZeXouYCsauQfPzeUwwarLknQEHARDGz6mCCLP/1BCpWYdWatGAaThQrx15YbeS/dwLHTN
	pk6LmKEh1yIm70w==
X-Received: by 2002:a05:690c:600f:b0:873:5c6b:a327 with SMTP id
 00721157ae682-8735c6ba708mr23862397b3.33.1788690584489; Sun, 06 Sep 2026
 03:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com> <xmqq4ig44ywy.fsf@gitster.g>
 <CAA0xjtqF_60kKC_B=-=AkBSG0ZiFd_uSjzCZ4Bup8Pvg1_uALQ@mail.gmail.com> <xmqqwlsz65mu.fsf@gitster.g>
In-Reply-To: <xmqqwlsz65mu.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Sun, 6 Sep 2026 12:29:32 +0200
X-Gm-Features: AcwNN1VfXvcFLZko3J0x02lep4FZrp51BLeSg5tS-nvymh3jCNWgpaNfp-kWNEo
Message-ID: <CAA0xjtoFD3OQqPhf82hxkUZ4-zpSH28arz6aBxSqeMeR1BqBhQ@mail.gmail.com>
Subject: Re: [PATCH v3] rerere: keep a background gc from killing a rebase
To: gitster@pobox.com
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On 05/09/2026 18:10, Junio C Hamano wrote:
> Would it make sense to LOUDLY tell the user when "git rerere" fails
> to do what the user expects to do?

It would, and the user gets everything back. At the stop the conflict
is still in the index, so "git rerere" run by hand right there records
the preimage that was skipped, "git rebase --continue" then records
the resolution, and replaying the same conflict resolves it from the
cache. A resolution it would have replayed comes back the same way, so
one command covers whatever was skipped. I checked all of it.

Your "BEFORE DOING ANYTHING ELSE" has to be in there, though. Resolve
the file first and the conflict markers go with it, and "git rerere"
records nothing at all.

Failing doesn't record anything either, and the conflict is still
sitting there to record by hand afterwards, so what it buys over a
warning is that the user can't miss it. I agreed to that trade without
checking what it costs.

> If you have a 100-commit "rebase" that is interrupted in the middle,
> say at commit #70, at worst you should be able to hard reset and
> abort it, and then restart it starting on top of the result of
> applying up to commit #69 (with "rebase --onto") to finish the rest,
> so failing in the middle is not like throwing the effort you made so
> far away.

It's rougher than that. The "you have staged changes" refusal from the
log message offers "git commit --amend" or "git commit", and neither
gets commit #70 back as it was. The first folds its changes into #69
and drops its message, and the rebase then runs to the end, one commit
short. The second keeps the message but not the author. Aborting does
work, but the user first has to ignore what git just told them to do.

That's 2.55 today, not something this patch adds, and waiting only
makes it rarer. Writing the stop state before rerere runs would let
the rebase continue, but the recording is still gone, so the message
is needed there too.

I'd rather not stop a rebase the user can otherwise finish over a
recording we can tell them how to get back, so I'd keep v3's behavior
at a conflict, where the command stops anyway and the warning can say
to run "git rerere" before resolving. The recording after the
resolution is different: "git am --continue" and a rebase's
"git commit" go on with the rest, and a leftover MERGE_RR entry then
records whatever the file holds at the next rerere run, as with the
clears. So those keep failing after the wait. "git rerere", "forget"
and "clear" fail after it too, so do the clears that "am" and "rebase"
run, and the gc gives up at once. Say if you'd still rather all of it
failed and I'll build that instead.

Thanks,
Thomas
