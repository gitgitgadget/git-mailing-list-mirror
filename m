Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3BD327C08
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842110; cv=pass; b=Hq8Ty+N8lZvrgfW0NSACEqhr0SvPD9HpV8/1ywbskod/85Rrq7a6S20ft1njww409a2d3IjqQFoY2XB3byplbpxdgjJOK10cDFUuyT9xwZGRSLSoIKjxyb+62jyaENm9Hq8qAD+tgJQNMHjYXAGd/HF54Oi3i9tj+OR7rG+Pu30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842110; c=relaxed/simple;
	bh=6llHAe1x8y4ibVFy1KA4vDeUblGTsnqHCnRvfLtP0Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAfOyXIx25zP3W0i3ZvrzJMNV710DN3QreM0Y1ZjfgXUb+qT2CMfXDtDpYk3Xd5DSVOqQ16GMiRa5EkNr6EWt6lryacsliRDnukejNVfC+9kkwmfYd3p+AG1XXOlYYBVzto1d0DYD+3v+GbWK6rUB0E7CrOq6DGyZIZU1H4i4AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=On78M3XS; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="On78M3XS"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8496fd8c3so66376837b3.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 01:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790842107; cv=none;
        d=google.com; s=arc-20260327;
        b=KekSSSFUS0wKiLttKXjKufMw0I0vmOEbv2NRoJeiOI9trL/YHMlHpZCll64/k+YtYH
         syemwz8+R3Q9pWi5dYRg4J0/CVgjpDf5qBaUGDcvfZEoEO6hytsOIROwpQiIAyQzzOci
         aJUgTDW5ZHw7CAVTNhg9KQ6JHnAhs2+6Lmv59nhPIKTBDD5IrpuiZqHoVnz8VVaIayE/
         farQ/0CAyRit7/x6dUQd+2MNVGmxjQgOWlF70E6mgeDxfqeY6OBR8QwXSWEnsJ1roYqO
         xsvqIXNW+nFLr2zKL5joGXKGnMvw6RnNqYlfg17Sr/PawbODXrH3RvII6QfPtLEfQXXZ
         pksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6llHAe1x8y4ibVFy1KA4vDeUblGTsnqHCnRvfLtP0Ks=;
        fh=4mVgkBmAu9PM5TtAIg8xcMo9PSKZIk7MLS2mQ9gj/aI=;
        b=pfeW2DK60E5tu8NKipVUA9jP4aRovKdvO8op/0/qRrXpdVyEu1HDfzKQ6Wd+FizzmM
         +tn9BthcgO8FOH9B+dbufrG45YUnhstsMT0LFjudUIfR14T0XBEYia1G0Ek3wBIbRqmg
         UBq6Lai3rT+aAukk+fIWZefp7UqiPRLXfW5VkYLDjpj2KFumfYpBD9SOx+LLtghkJbhM
         TZMD2mC5rS2kluXLGlpXq5c2FMDFwbc5duJ7XpLaURdh375OdE+o8NPXEgypUnu09hwp
         NHOtzX1E7NckLGqt9anrpuR8WzopbYh0ne5xmJR6Eh0/N0gINF+X0QkiaH9OMkxgmF1Y
         Gu9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1790842107; x=1791446907; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6llHAe1x8y4ibVFy1KA4vDeUblGTsnqHCnRvfLtP0Ks=;
        b=On78M3XS1jax7Pn0pa+Npa7bho7buNnDkvRwlPsHBOJadey9DF35pfyNiy9T0YhgKu
         wUX8Stltvm9PRVEdUVqxAETx798mB25oxNNJ2/sSVaLp9cEsybKZldE6tFCnfMrf972Y
         j3BjanDWC3WAE8aCF5dhEQIpU19J8iuWUQxlrSIJ01zZfG0hiRXjHfEPmfXobEfNaAy9
         WMetE/C2DzHbzdOW7KaPFzXBcz3hjJ2Sm+Cv/7UVKD4uiM0bMB97Qnj8cWg3iUysuDXC
         wkO610lWCPPbbaJM/4dyFuqY36RL4g2qa32edZd7VxetptW1PBnvsEQLqjUPxy+WqB2M
         zWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790842107; x=1791446907;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6llHAe1x8y4ibVFy1KA4vDeUblGTsnqHCnRvfLtP0Ks=;
        b=fkTgv3TDAqN1q8f7Sye4WGbxdjqkJWPWytk7dmUiLSZZ5keTZVTwK4LqGg2GHiYHbG
         YimE8zWrr+isw0MwPnHQHp++nPEA1bi2RZ9g4YNY2jj8nMco8MrquHcFJhmnISD/TFEn
         gjnFanl7PtD2qO/Z3Q7oUBs6CWCPFm8SBchSYUEWWO/Fb+gN15K7UsI7oBc8/I9Lv1MA
         UYid8p63JqQb3olFfImDYWE5GQSx5VeHUbHXV0Z3lv8/NLiE4QH0b3xKZW/asNy90Hwq
         jdugK3iXK+1A7F4pCRbyM7GLzF8lRJm6R4wfn1Mwi27q2/w+iFpZRabS7Te+xEdhxpjZ
         gznQ==
X-Forwarded-Encrypted: i=1; AKwUvBw81OIC/sInYa2CDRJr7P3kjMQerIfIOQ/mtkWTUBk0T4+C002ah/6lwHtIsNj63CzUQFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKKh5FQGjbSdRaDHxaqgbtMAIKyCiuSTtAtDrX4mBe1Yh65d+e
	25zDV2YkvzSskgwExb1K6sJckJQoev2F/ssltWOi790zOPJMRYjhoMrjXE5gMeXONFf04VYmw/W
	7rZJPAj9/TS58BKvkI9hchba3nGBesy3qndUTf18RtQ==
X-Gm-Gg: AYBFou2WeLqn3JhlXS5MN2fjie1yExz69a38lb0BxzCD04Auz8m1lWAck5OHWIpjVxc
	XD8uXFVjaMqgdAvlPEynLBqyIPgoiPjwg3qwjGazfyJjdlzM91I96UnEFyB0xcAy4dOpnd1Ntei
	k8AWVAJ8XXLuel+KkCY1UMV3gN3uQTm73tQV6Def8SjqwXc0H9UN+VHUHL8LQMzA1WJ+HZiAH72
	CCT6YraO38iTFnf9apu8QuP9IMCgQeiOduxoMXqgRTltBFq5z4QfNt2hFICs7LzOMrqrmj77N3b
	2hVSlnktF4gMGFxmjvr5Gvj977OQzSMRETPLpqEkMfIXBE/c7YHl/o1XexmRHsY60rgyqZ296Gn
	AlYxfHZAgUpCWaFBwmiWCxY2KiClXrP4FFPV9CiwPD0n1Ow==
X-Received: by 2002:a05:690c:a189:b0:873:5bb2:6c38 with SMTP id
 00721157ae682-8ac92f2bb19mr11559837b3.63.1790842106780; Thu, 01 Oct 2026
 01:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v5.git.1790596702.gitgitgadget@gmail.com> <27673137aae961105a3d3b6ea615879e0686cc65.1790596702.git.gitgitgadget@gmail.com>
 <ar0kJPdY1WSsWvP8@pks.im>
In-Reply-To: <ar0kJPdY1WSsWvP8@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Thu, 1 Oct 2026 10:08:16 +0200
X-Gm-Features: AclHuK8U5TEvSA-RDRhZVoam3msijt5Prvt2RPpCSCk3S5zskKNnPXnio9FEp24
Message-ID: <CAA0xjtoj_uf-f+kzjRpmOkq1RsbGnkXdodeSS2ND0R-FsP4qRg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] rerere: add "gc --auto" that skips a held lock
To: ps@pks.im
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 30/09/2026 17:00, Patrick Steinhardt wrote:
> It's a bit weird to have git-rerere(1) document who calls it. We may
> want to document why specifically this is useful though.

I'll take that out of git-rerere(1) again. I'd keep the last sentence
of the rerere.lockTimeout entry, since that is where I say what each
command does when the time is up, but name the two commands there
instead of the option:

"A `git rerere gc` run by `git maintenance run --auto` or
`git gc --auto` does not wait and does nothing while the lock is held."

> How about we instead call this "--skip-locked"? We could even mark it as
> a hidden option and not even document it, as it feels very specific to
> how git-maintenance(1) wants to invoke it. If so, we could maybe remove
> it again at a later point.

I'll take both, the name and hiding it.

Patch 3 has a RERERE_SKIP_LOCKED flag for the conflict-time callers.
I'll rename that one to RERERE_WARN_LOCKED so it doesn't look like the
option's flag, which stays RERERE_NOWAIT.

> An alternative could be to instead call `rerere_gc()` directly, and if
> so we wouldn't have to add this flag at all. But that may result in some
> bigger changes, so I'll leave it up to you to decide.

I tried it. It is six lines in builtin/gc.c, but rerere_gc() dies when
it can't take the lock. A manual or scheduled "git maintenance run"
then dies with the lockfile's message and exit code 128, where it now
reports "task 'rerere-gc' failed" and exits with 1. The rerere-gc
tests in t7900 fail too, since their helper looks for the
"git rerere gc" child. So I'd keep the option for this series. Say if
you'd rather have the direct call.

I'll wait a day or two for other comments before I send v6.

Thanks,
Thomas
