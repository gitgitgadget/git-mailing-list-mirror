Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C874A2A4D
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437544; cv=pass; b=Ai1sN53BbqATCK+WpDhMfROSVvWG2bH2guLeTH4xUMbW+l/aOMLGRgz0Rkf/ADNgZ+S7ojD28qLOSOUfM1I2JxqRzjXj8cltovsCWYl+oj6fri9LJ96Nfy9VyJM0tzoU/acXVcECra7whE5vzZDMuR9D6ShNbfWK9S2Z3uFIlvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437544; c=relaxed/simple;
	bh=o6kFm0lyqwSzPsD+Z56VLH7BMfipusdmXC0iPRRdgL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZrX8/B4YLp8OnqmNvyh8yq4+YE4MEZGpFjuJg5Dn6TTSt4X6meO5jO0SLTF8gBG8zNFAujq3q/k2NCSIiNSgriwmUKRC6w8uRilwcIuHOensYsrNTZnJtJ82or0ZQuAF2CyLPEOj4krkTMGChnMxIDRO14YNkoBVpIr/E/fXeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=ST59ECjJ; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="ST59ECjJ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-86162c086f8so13626617b3.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 05:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788437539; cv=none;
        d=google.com; s=arc-20260327;
        b=Y+55YufuSjoywxyJMSHc2ZXg/Q3qfyTMSfBREcvK1nYZfjp0Ez3iF6gvxWcxYgnV88
         jC9EAM6UzBnHdR5vUyJbD1wTreyFYhCLQ7AavEXGj2LMPXW/+JV8xb2ROxTJX0Bu+NRu
         fFnVdfhEWk24YoSngSpmL3gNrlpkvJFotaFZICM+A16AWAy4EK6f26gZKG39vXhFsJ9n
         4L4iD2MbuokhrLGVa0/nXAYIbfL7a1cgGrUE8N79bA7yy9Nk5AvkH1/3ltKh7LLOKkN+
         QVHauE/uUmbvImgcOeR1aeeuCUSaIIzZRsrNlBoWlbk00wlup/xWzpfwIQ46ed9VrS/v
         3bsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o6kFm0lyqwSzPsD+Z56VLH7BMfipusdmXC0iPRRdgL8=;
        fh=hMm3yLp+OIWzwVgdkEIOayc+tAS8qu3tr+/EPBbmEV8=;
        b=dRDz64MEx+Y/10gGH4B2TsRDmcPxUwRDoxmSB4iopUjup8lmCkkyurWP4CLBgoBhij
         7r3TNE3iiA1f0vtg2ciSf2LTXPKwtViCY1/U0QRcRejWHbJGlz696AquRY+bw8SSrpPB
         S8+84yzy9IbXKKToVP1HAGwvdaTjKSeFS1qWqKjzhG1IkhDkeb0KDD6b02EmFOhYyW/i
         VcBZKT3WJ3cTYV8Hg1VTz8BTeA03S70pj2UBwQloC9UWJFsVQCPyz/8I2MwKLjp6AU+O
         P3eSNgvP/BzELV70K9yiHBPyOSt6uSNNG4WvUtmTMYI8LXaFGP0plDafugCufNsk/eBk
         gkIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788437539; x=1789042339; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6kFm0lyqwSzPsD+Z56VLH7BMfipusdmXC0iPRRdgL8=;
        b=ST59ECjJoJpbKLUO4NQuKUCVuYUorv2Fd64dJbSv+KV4P0sjhKdDdFYTpsifCedKs4
         1nUHY5+k9PIAXpPqJClZqmbjt4e1PQFlGA+DoaOWwhzdR2RuAIeTqCp30ttaFrpQDHr1
         yjowZRbXEOuokBOtPwrt8A0HEGVT8v/LVREaeb/wWL//s4o8sNo0GrWftABzKbqY/peX
         ghxjW4do9z5mT9UawSUXgQZoIBIM7Pcaro5swvcV8GdaPIMQDk6nP1wfziyul4rlSvmp
         dQE8+4lms1I1eDrxQnaoz7DMPFAJj0q2/8/6QfzuHBprsMgIzjx62t9zwX0wO+RlmiGG
         WX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437539; x=1789042339;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o6kFm0lyqwSzPsD+Z56VLH7BMfipusdmXC0iPRRdgL8=;
        b=Ym6YGVdeNmWsg6aKD4whdVuQWm7mYFSDI9GfXGEQ8H8b65Q46muNm8MKCdm8gVT/U7
         xcuJoIGhxK5N3g0Fm+PcktW22Cp3NLratHw3TA2P3zv5/YylKMX5tOGfCLka5VSq5miQ
         m7hLQsNukjjnoC6TR3t5s6+djYoU5CqJu4GEHYaA8OtxS9FYyNUSSCpQ118KcEeVtgK4
         zqi4emPK7dcN5KCzuEEDyo7/i8jLqw0HcrM3AtApxVPspq7D21Zp9EXCjgNt2qxik3Mw
         29kOQoxHwxoEYh77OhQk/MatnndXLfEDTJF7U2hSq1qjpz2KaDzIp2dDAQI5yRWzid6K
         FE2g==
X-Forwarded-Encrypted: i=1; AKwUvBwO7B2zIDEGFYiIcGg6tlR0bhQKmWIvNvZvVwy759jvRzGNEz64sG5JWAUaYzyLPF3/gf0=@vger.kernel.org
X-Gm-Message-State: AFuF++nVoZKTkoReQHYYdlTPHIAFtRcvUVfQ4+/kO51SO1pXzC4BPz8x
	cSWoc9qBNJjiGXUm8GucAe25WxZxDtFAI5Fjs7Z0gSVesZgQwRCvRKDrjgbfy4Xlt75t5/yODOZ
	5NuyqXmHuLlTVwPJ9kodWzrcPT1166n638+IdWlCPcA==
X-Gm-Gg: AYBFou3I5BlZp/eD2fsxhFjQmFR5C5VAIoze9O9g83oMbwNslw5oIrdpJfJhm+1ixMF
	r3yYNBbJt2ktfs2SHXI/J9Cy9fYVkF1qs1Rde8sUQHYOGIPaYpjjWcB/oJwlE3+jlTmE7/wfCzV
	kDFql9YJnS1YoDdD1uwEnZ6gT8tTt0VhhzJFbJakne5o5NigO3DTg+YiYhM7FfnG/xd7f4I1LpP
	AUT4onL4Ci72RCn+3wHwI228IovdonjRjTZNmDSjW55b2DSKOUz2DKH4Mr0nxLtT0iUm54GRiEg
	/5xGzk8oo9fdqMrttohCFmOiOmU+x0ORZU9Sr5Xzn3JbsbvM1ztsmjEy4tRxaZVrq5doJmdzhSk
	JhyxH7Mbsokchbw==
X-Received: by 2002:a05:690c:6601:b0:85b:f1ba:ade2 with SMTP id
 00721157ae682-86e66c86f8amr28000387b3.0.1788437539026; Thu, 03 Sep 2026
 05:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <apkkVAYOqjfAsp9-@pks.im> <CAA0xjtp+Og_k7BYZfwX-LRW_8TAiCyp846+Mhk+hERM_GmRYkA@mail.gmail.com>
 <apkwpKTGaMwTf0Hz@pks.im>
In-Reply-To: <apkwpKTGaMwTf0Hz@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Thu, 3 Sep 2026 14:12:07 +0200
X-Gm-Features: AcwNN1XW32EySxPN1iEIhpqiIyaihhu1sQOTvzRlxpMvlgY3KI97xWxwfIriSjs
Message-ID: <CAA0xjtpLtWqoJ+unHZn+Okcy=6_9EozuSKt3ZLMM-j+VGyJfjA@mail.gmail.com>
Subject: Re: [PATCH] rerere: keep a background gc from killing a rebase
To: ps@pks.im
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On Thu, Sep 03, 2026 at 10:32:36AM +0200, Patrick Steinhardt wrote:
> Yes. Ideally, I'd think that we should both introduce the grace period
> for locking the file and adapting the heuristic used by the maintenance
> strategy. Whether we should completely disable auto-maintenance when in
> the sequencer... I dunno. In any case, that feels like another separate
> topic that should probably be discussed in its own series.

Phillip, this is the part I said I'd do in this series, so I'd
rather answer it here than just drop it. I think Patrick is right
that it's a topic of its own. My reason for wanting it in the same
series was the recording lost at a stop while the gc holds the lock,
and that was for the variant without the wait. With the wait kept,
the next pick waits the gc out and records as before, so the
sequencer patch no longer buys the rebase anything the rerere patch
doesn't, short of a prune that outlasts the timeout.

What it would still decide is whether a rebase with the merge backend
runs maintenance at all, the question from my last mail, and that is
a discussion of its own. So I'd make v2 the rerere patch alone and
send the sequencer change separately if you still want it. Say if
you would rather keep them together.

> I think that having the wait is a sensible thing to do, as the race was
> a preexisting one that was only uncovered by the change to the default
> maintenance strategy. It can also happen with two concurrent processes
> that both happen to write rerere entries. You wouldn't normally see the
> wait anyway, so in the happy path nobody will really care. And in the
> cases where you would see it the user is probably more happy to wait a
> bit than having Git die (or just not write a rerere entry at all).

Agreed, and that is the order v2 keeps: wait first, skip only once
the wait has run out. Since your series means the gc now only runs
when there is something to prune, I measured how long that wait can
get: pruning 20000 stale entries holds the lock for 2.7 s here,
walking 20000 fresh ones takes 0.4 s, so the one second default
covers a prune of roughly 7000 entries if it scales. I'd keep the
default. A backlog that size is a one-off, and where it does hit,
the timeout now skips one recording where it used to kill the
rebase.

My patch is based on maint since the bug is there, and I'd keep it
that way unless Junio would rather have it on master. Merged up it
conflicts with d43f701d32 (lockfile: add
repo_hold_lock_file_for_update{,_timeout}{,_mode}(), 2026-07-14) in
setup_rerere(). The resolution is to take the repo-scoped helper, and
with that t4200 and t7900 pass on top of your series. I'll wait a
day or two for Phillip before rerolling.

Thanks,
Tom
