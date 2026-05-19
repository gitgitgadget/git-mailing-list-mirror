Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D263EA96E
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207978; cv=none; b=WIUPUpuzYzuhwoIQpkIRL0DaMKUvpowVxEXW1b8HRbPwgcq0fZcs9c5emD8+ADAZ1vbMJV1PFy2gssptJAEB10uT/TEACXmHbTPM2fbVUF/gvdhhYXk7+JWv+IF32V5kysDvKm9qCxC/k+xy86FZQU0blnZuA2X3mgvdRmDIouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207978; c=relaxed/simple;
	bh=djTASjgrmWTrZARtrD48+NPKvTZBgDcqanDeyPVKLkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYVFeScISymZcMsjArTXdS4mY4b3D8Mmm6nJ8Mdx4YHMiACeJBLbZcSCjWm8Nq9i+CkkJ+E5NNl7XzYCAIEtH3H6zFsVS6wNRwzUOhKCD2RDvx7lNekNDJlrU7/HICQx7Ag5VVjZ+tyTGZ622/hsZSfpjzciJ5Zr87mWzJyYkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EapZdte2; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EapZdte2"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65d071aac6eso3158887d50.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207975; x=1779812775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1EvToVXSMHMnnDnCiCNSx7pWQ0WtQTQb1dliifXUsZk=;
        b=EapZdte2EGRTuN965rlQ7dsjIw0IlkMXp+K5RHrXQSArcfB8UR7cGgf6U6chYBtTF+
         VwVml4KPd38YxqeJS6Qq/0V3QUIUyL1y30qVHuk+Ib9Pu7usA7oD+B2VjAAU1srRaADG
         7jWUfVXBJxEUMphnW9sU8Qv37uZplfOg+4aVaXXovywakLcmNKetaZgA+GjXh4FD+8ry
         dgu1jeyauoZPu2AJcVlF7EjQLcamJz7mHMtUUJKBuIB1oY4spO2s6YlyxNgxkQWSaxK6
         +cgShOAh4UYq75nFafhDr8ObxzmB1yheDECWGtbhaPO1o7kBCfPvn33jeZbu1qLZ629C
         W8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207975; x=1779812775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EvToVXSMHMnnDnCiCNSx7pWQ0WtQTQb1dliifXUsZk=;
        b=XPoHIMFWETfZKnAD9TXCJ1pHgBfbWZm9cwEpq8DnWwRGBtUjxpqA2qE4VfDhizCExW
         mkVImdvyrzgSAfk6aSFlWtmmHTl+oxHVud/EuF3xVtoeFX5ZDYhbm+uLG1+ynBdAsVYb
         bpEMPI/YCltxLIAl0Bo9S0M5hbKK8u/LrWHitnIMjSC1d0BELMAac69368xsSPBt780T
         1MlM7lt4JzWChpMM4uhqb8H2RdhWP4nzRp3xsrIUQo+92vrQgAaZGo4IKNXXTe2PWrJI
         uaDrDIW5cMiBo0TorBAZazjNK18MCz6F/H4UaQ0RNUIv4ePCRKGiEYOsS/6XhFZZEpKD
         CPPQ==
X-Gm-Message-State: AOJu0Yy+cmebPO6f8M6gI/gohJTMksza/2RRC3f3SFC3UcKtiw5umpEc
	IZ2oZGh0iDIaNbhSQfw14rSi7R9clm8XdUZGPuYeC2PosedrK7lctTwhqYRoUlUL1BM=
X-Gm-Gg: Acq92OEtJ8EIrsJtEPN0satod+ieWcvdDqcOfQtahMp8MUdsT7/pMf2LQp7dHpKnQn8
	gIcfRh7j1B/YPSdN4fc1r7MqRBijABJ4nE2yHd0tqSiIrDEkIoWEH7NHpAsmVhpJEYYdkkMFf9v
	sxG1kSLBCpta6TvDRdoIW733X7I02OULoMPRaBPxmo3ptXAV95PxIMUNtSCFOtzoXrGFsOIoGO4
	wNNQyrA/te6P3SgbFjhmVbitYG4MkshI3vc07xFClt37QeDWFESLc8v5SmThHvFHCUWn70eRuKB
	au1L/Mak+x+K4G/rPIVMKvkHVprYPTbXWYOmeevnbQKRnqze0+X2XzvhvrjKULnCxg0rjJGkWVY
	rFi/Scn0c9Qdpy3xi4pMgAIw/0TAAL5ZEh8UpuzR6M2VU5AERU7+Bw1PYLLZTYwkbZERF/1EFcB
	aaII+QNxjhXINR1NrkHMlysIiYK4oZWMuxEQFUZKdPIxWl80OLNId3srK2XxmHl2nq/VVRoxAFK
	nZWalmtWxhL5aFdVx1H1mc4XpYZHMTqF9FJtz77Ow+7hXGLJjcAs8FQ95ScFuGzNnLhs9KAquga
	ykRqCecVBA9UqoyZ
X-Received: by 2002:a05:690e:4007:b0:65e:40ef:dc8f with SMTP id 956f58d0204a3-65e40efde6emr12964368d50.51.1779207974905;
        Tue, 19 May 2026 09:26:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b124sm8073740d50.6.2026.05.19.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:26:14 -0700 (PDT)
Date: Tue, 19 May 2026 12:26:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #04)
Message-ID: <agyPJa3E2lPI9K/G@nand.local>
References: <xmqqv7clbizy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7clbizy.fsf@gitster.g>

On Mon, May 18, 2026 at 10:32:01AM +0900, Junio C Hamano wrote:
> * tb/incremental-midx-part-3.3 (2026-04-29) 16 commits
>  - repack: allow `--write-midx=incremental` without `--geometric`
>  - repack: introduce `--write-midx=incremental`
>  - repack: implement incremental MIDX repacking
>  - packfile: ensure `close_pack_revindex()` frees in-memory revindex
>  - builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
>  - repack-geometry: prepare for incremental MIDX repacking
>  - repack-midx: extract `repack_fill_midx_stdin_packs()`
>  - repack-midx: factor out `repack_prepare_midx_command()`
>  - midx: expose `midx_layer_contains_pack()`
>  - repack: track the ODB source via existing_packs
>  - midx: support custom `--base` for incremental MIDX writes
>  - midx: introduce `--no-write-chain-file` for incremental MIDX writes
>  - midx: use `strvec` for `keep_hashes`
>  - midx: build `keep_hashes` array in order
>  - midx: use `strset` for retained MIDX files
>  - midx-write: handle noop writes when converting incremental chains
>
>  The repacking code has been refactored and compaction of MIDX layers
>  have been implemented, and incremental strategy that does not require
>  all-into-one repacking has been introduced.
>
>  Waiting for response(s) to review comment(s).
>  cf. <agTw579yuy4iHoMq@szeder.dev>
>  cf. <20260513230825.GA1378716@coredump.intra.peff.net>
>  source: <cover.1777507303.git.me@ttaylorr.com>

Apologies, I didn't realize you were waiting on these until seeing this
WC report. I sent an extremely tiny reroll

    https://lore.kernel.org/git/cover.1779206239.git.me@ttaylorr.com/

that addresses the two outstanding comments you linked. They are very
minor changes, and queueing either version of the series would be
equally fine IMHO.

Thanks,
Taylor
