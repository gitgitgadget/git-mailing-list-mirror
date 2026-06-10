Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3D349CE7
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115931; cv=pass; b=AaUjqFDbsnFLJIoNv+aAoHufY10gQsearLisNB32yDmwUj+pbE6yr8LUpWZp1daRetXPWMYEOb8NgGLrB8KIC37w5yuwf+6JFtS4hmVTNtWMKKrMoYas4bMn+29ipyrEHBi6IfKqBMgSGu0t5TYie0basUryDwZC04BPG7JIXPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115931; c=relaxed/simple;
	bh=3ftBre7ysxIdmCCtQ2YezJVSEoBLLVQNbE9bbph2+nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovi+pdPHefUSjovOtJ27R0cZR7CsnVC9KMTiJQ7scHAOtk6mRNiW65wACJflzNj6A9DV4pRYcCN9XVF3jJAEqFDPpr97o0KET5A4+/SGudMR27u+H60TLJ1IL/pYOSq880DsyQH88r7EuPKeovBGye5sOVMKlyv+K66glE5yw8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=S0rKYYNZ; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="S0rKYYNZ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7defee656dcso49259687b3.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 11:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781115929; cv=none;
        d=google.com; s=arc-20240605;
        b=fFMzi+cTgV4ihKa32DIvjb3qjUGPiaTL06dlPaYD7YS60tau6hjWp5C27k1xf9RTH6
         P79JMWkKUrAym1KR5gE6L6U9OTtGJeqekVX7g4LxKVNShWiGn1FuhhLs43y1R10fkLL/
         QwNlCusjGAs5mPkpdtzGMJXYRtk6a14KNuIBkmkdkevN7JPs6DYjD5K8vdKksm/zHfOz
         zYn9z41DBEkRI785+UerRbO+w56rj5ZGFV7cTuqlTJPHULrgV2/v7wO7aZdBnejYCn7G
         Xukmj3xcDYXPi61hMGq53Y8g1G4Mp9WHWyWJD0kGfcB/m9oOELipIdlfRouYgzKRgJRq
         9CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3ftBre7ysxIdmCCtQ2YezJVSEoBLLVQNbE9bbph2+nk=;
        fh=Q6Kqe/NXyXs2eZy4dcroH19GNMCJfrr7bMH/Yr7508A=;
        b=HzS6iD/vDRO9ZJ/f/5KyimtTcq5cE4QB9BMVL36wtjuoB7XYnHU27RLTyyt2B6duDT
         zjTslyfJuCek/KUUsdWz5YTx7mG3OMinG8TiX+2ieau8fcVRA+XhS5Zf3AiJrEl2Q+Ou
         jnj8HXQfBrFGnYCM70rP3leeWC228XobyUNpkrZXf2W1v9vXpcE9So4ZHagtljLI2Sy0
         hiBDRgKu44asoCrFpBPvFlTNho33WC0EN7vIpdyGSF53DeVC5Ov1PF/7XUngoMKgSIsY
         zJZgAO8GxJmUTWOAloSXmlvgu5ODqFMFY9vsbPfpKbCYLeeGE0afwuU2a02jBWKrsB3J
         JyTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781115929; x=1781720729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ftBre7ysxIdmCCtQ2YezJVSEoBLLVQNbE9bbph2+nk=;
        b=S0rKYYNZLw7Mb9R6jekQ+hBZll9lz2cbXiNR8xIMBjbTd7T7uB5JusNz43Yl5TyLfp
         e+T0hHVpPE6U5wIBAR8YQyhfrssVi8ZWywwaB+nodJYBVzKNVNBavoJTfli8D4zH1opp
         4y3ZLLyFh0BvThD1zo20mzCbMj8HWWKJmKMrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781115929; x=1781720729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ftBre7ysxIdmCCtQ2YezJVSEoBLLVQNbE9bbph2+nk=;
        b=VauxPM+N+yCc69gjj5qXDXCkeLMo/CdsNrj/hHlnumbxBP7ybstMudSeFIqkL37JXf
         uSfx9mhMaHmz088UYwhkCZWrU3GLoK+nzjPA+P0hKRm6K2imCkYE9dxZwyudquBMGgOw
         TsBdS12COaL8kYHiH7ULo1MwI2hIRYNCFIDQurmjtN3/wcN+I+l2A7S/+PQbeDNKwd0D
         RoXfZZHZE3zWUJpPmoTJK1+CcGCy22Qw2hrnPR56PcA0TeWnMyPJBF6Kj33ek5Bown3W
         E1dF+T6DUHDXBJb2ChELEBfun8/lbnlYYex3xkxFLOId8ti1099aWheea/02YUYFhkAe
         nYUw==
X-Forwarded-Encrypted: i=1; AFNElJ+BWPViL7TFU65BUcqUOYrQnm6PgWQPGSCQ0N9+Zas6o+yMzr3xfJo8ZGNQMAU19Iz0hM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmEYNG2VYyP2GvFRuTni4iiHey+HR6X6IPO7ygq1McV/yTnZDU
	qdr20dnqfSmldj6kMo8rdFx34bP9o1qbORuop1k2oPK5Nm2mJp4s+UhfpYt2psDMy6g20bgpuZE
	uTzmeIL4c/ygM6+AFJVxC1VKb+Y53bgdBApaWXepAFysIVcyBoHI+K9A=
X-Gm-Gg: Acq92OFMa2abDjPuWpEu8jTSMPMxYBGibiscY3gwFtm/AbCWTVeJbM1ME0/5Zy9v25i
	u5bQ/u5q4fyy+L+s+XmFTOipc5ThQDnkx3rIDKBOD1AwXrdaFhJLpRKqx7FF8v5OrPgzvShBfgH
	c1Zo+idEuRpkSzn7IkTkVcAKX3+9oOQlhjhyY+T30j/o0eVFbmi6YZkzIg/Uem14gIJbR/cBVAl
	fnQL0HhdquwYq3h90IQVBJrG2yWS+v+eu3GfHUtVmz+870svGLLvoeTWLkcb2LDsWaBDnOK3zZ4
	t7svXgBhh6ZNn0do9g==
X-Received: by 2002:a05:690c:45c5:b0:7d1:9c6a:d60c with SMTP id
 00721157ae682-7ed0d1d6ea5mr272833837b3.18.1781115928559; Wed, 10 Jun 2026
 11:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com> <xmqqbjdixupc.fsf@gitster.g>
In-Reply-To: <xmqqbjdixupc.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 10 Jun 2026 20:25:17 +0200
X-Gm-Features: AVVi8CfOh-79kdkDpgejNruK-B9rBCEcwcw7i6l5lh4CodFJyKg4k3cZfkSy4nE
Message-ID: <CAL71e4NqCD0P_=qnT2R9ThNHEQx6qo27i_7Wj3Xnb9Xg0kcM2A@mail.gmail.com>
Subject: Re: [PATCH] commit-reach: remove get_reachable_subset()
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "should not matter in practice" because...?
>
> And of course the worst case scenario is by definition not a typical
> case that appear in practice, so it does not make a good explanation
> for "should not matter in practice".

You are right, that was hand-wavy. I started with writing a somewhat
long analysis but after finding a clean way of supporting both DFS
and priority queue modes it feels somewhat unnecessary - I will
still include it here, but the short summary is that it's fixable.

Since the prio_queue struct supports both LIFO and heap mode,
it's actually quite easy to plug this into
tips_reachable_from_bases. I just need to switch away from using
the stack structure and pass a mode to choose between LIFO
and heap. This preserves the old behavior while still reducing
the code size and unifying the code more.

I will submit a v2 of the patch shortly.

I will also include the original analysis I wrote before finding
the simple fix.

Thanks for the review!
Kristofer

---
I will refer to the prio_queue approach in get_reachable_subset
as PQ for brevity, and the DFS in tips_reachable_from_bases as
simply DFS.

tips_reachable_from_bases() was designed for --merged queries where
the targets (branches/tags) can be deep ancestors of the base. DFS
is a natural fit there: it dives deep along first-parent quickly,
and with generation numbers the dynamic floor raising prunes
aggressively.

add_missing_tags() has the opposite shape: the bases are branch
tips being pushed (near the top) and the targets are tag commits
the remote does not have yet, which tend to be relatively close
to those tips. PQ ordered by commit date is a better fit here
because it sweeps down from the top and finds nearby targets early,
while DFS might take a long detour down a side branch before
coming back.

With a commit-graph this difference mostly disappears since the
generation floor keeps DFS from going too far off track. Without a
commit-graph, neither approach prunes anything (generation is
GENERATION_NUMBER_INFINITY for all commits) so the traversal order
is the only thing that matters, and PQ has the edge for shallow
targets.

So the current code actually has each caller matched to the
traversal strategy that fits its typical workload. My patch traded
that away for code reduction.

That said, in practice the difference is limited: repositories
large enough for this to matter typically have a commit-graph,
and small repositories are fast either way.
---
