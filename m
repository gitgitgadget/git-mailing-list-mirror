Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4C431491
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440269; cv=pass; b=PJyH2x+3lfmeXLPCQVtxQ4TrgFVHXTGOZtDHPTxFYaHLBm/lr5VS9tJSTZELSDOE4vMBwOD7Y/S4WUxhnizpFUUlVu/vbhZcNrl6ziK7eJ702uFpCpgibJf38FeYHNVqhw8RR9kdn3zKPyVm/rNChO1qdlFjpyRJC2Df/zZvG18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440269; c=relaxed/simple;
	bh=n5xIVLWy9wDbIxkmtzXRFGsSyWbroaI1EMFfrzJ5pHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtLpJvqG42WJMNJsAiDP0bQDf+FcpGULSjrHmb/NN6l0LzJMSKKItfQLaMVy8NEVGU5g/7cISL4l0GqepN+1MEgw3HJY6+uHVrXP1Rbt0fzmp8E+Jl1HBEKPzheqx232U94GLSCzU0Nb5QkGiGuTlXunrMV8hKoeCbYMtkuPloE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=FL0u6M3K; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="FL0u6M3K"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664bb15d05dso6126343d50.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 09:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783440266; cv=none;
        d=google.com; s=arc-20260327;
        b=mtCDecoJsjNU8SyczVP+jFt45hpIVhdNE91/jY8BvQIavj4b8AKvSzD87A85PG4sKM
         Gb5mkiwmcWTaVNTMNbjQyhUZmM1TMc7zqG3xjq35PmlrqXvYRJV6PXh2oSG9H54Pz2Ts
         t+PXvX1MSXp5JOQWnBHgMhBkQiD3w2ZfEEovggJ+boOdzyUq6VBtJUQsGrBLGIuGIdkx
         3ZJNhkaPLN+O78APDY6bKO3zkJI4E6FtX+N3iwDOiaRdOPNRFnzqTpjzlmVqDB+c/oHR
         pu2gk0PRBbYCDkaaPDpGSMzfyNV0icW70rZtYAw9yulOhUNXM5GRVMBPzjUiGl4VqvFU
         rPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9ha/n3nNVxim1M1yEbpInhY5N6BkqjgYusSoTKsl9iY=;
        fh=8p1W5VcUNmuS9l7xhRsgRKAdbtz1Wpr3VOMDnViI3AA=;
        b=G67K545eFrX9vDm8akmuS5TwAfQMTP39bWEh+cAsN4J5jLup3Mwq52PvR3T6tJklmn
         Sp4w6gR082xS/Dmk+CaCuWMSTfzcTWD1KOgfU09Nm/iNJdC+sxZ12UQAb33Uo6ZGsP5q
         4zYsRR25TMizoUTCMt893R8k8T9MtGbfgW5Z8g391usx/qgipmDLb/T+QrhudZJ9uhgJ
         ScmWcdaEAq3U+74SN0/yCk/VDL0NmC+HgUmSnRv3D8DefCvKwcC2zr7Er7XNxexg18R3
         +U9OFZ32QRh2G/yRnDpBEUzyVoJcYttWmLnS3/Uz3u+6z1L9/mZN9PISsZdQjsi7Y69V
         I0zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783440266; x=1784045066; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ha/n3nNVxim1M1yEbpInhY5N6BkqjgYusSoTKsl9iY=;
        b=FL0u6M3KVBE37cT0ZRPTZSndwDWWHoATJ5yhk2Fv/ApPqFbJeENHoV2iPaXPxn6i7X
         GGV6miKXpQpPGacYaaEs89tueWEk3e27V1YQ8dG7ZND4VjdwR+75+7PaIUKYvLgxY2ym
         AoNWdMc3Keh/aagBe0d9cmS70HRQf/8+Xz0l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440266; x=1784045066;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ha/n3nNVxim1M1yEbpInhY5N6BkqjgYusSoTKsl9iY=;
        b=kU8Yougo0QqOWn+DPWoOvVTFTrTKgVebhHgq8MSb4/IY12bTG+11CcQv3aaqm3uSun
         oCvFhrVafqvawsE+Ecr67o+b0WZRm8ByOITFX8PRNNHxNCDsQCLDadGeyjj3rLI3ta6r
         wE1YB1/xaPnndcCOgVPoOfVnnzlVLU/q8CuABYOVyACixsKkN5AU1UIn6qXKknZj2YQH
         gKBhGiOyrBQXkAqbD8W5qbRhOHwHDaFkUvAAX5HaXxwL8S20IkrNljpwY5pH27IYoYb/
         aSxhud10dgJJqYd3jHF3WytKTngPCZXXdrCTEAaoJu4u/eHFBqn+ex1wcGIyyDVj8wnR
         uhPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqm9jD4VuBKoO/wNPlsrRQiKEPc79hT5tYpDU/C8jcXhabRt+f9UYQH4M7LwCOKGN9CHsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FZmrqGN7B9OXclaGzJTAAQfrHmKBT1vuVapHoW+5WFRxM1O2
	+6Xrl5YjmiuRcbAILi+4SCKOaw1JLirQjszWI53nVVNAPFC5Taw8V4zqTOwqliWUSY+nGNhE2bz
	7UHGZ2IeprrIVRz8mMK6fEekUxl160+kM5MQuy1ymWg==
X-Gm-Gg: AfdE7cnv8MqevN3gymPUstfV8p4iMWwbSoiwZj8eDCCQI6eC6rhYJRPyHxIDxc4PdH6
	0L+jzmCGkoDAvknE29/IRpdBx3Cs3sXPglNoMq/deh+zYb/BcmnD11wMGO8BETQNzY/Tmb2g7Ky
	iLtcNu779Vrd95goi3HBGXa8Tj5v2TbuM9QDlxUSXdjCY+fG8U34eoOt7+kK1/9TmDy7Axxz2Ti
	t1vhctTX1jRk28e1E79anV+ZbHmiiYHRNsNcbPvBKXrimhlKmU2hSlr2I2xaRIFFqeiKCdP2A==
X-Received: by 2002:a05:690e:488e:20b0:667:5e83:80ce with SMTP id
 956f58d0204a3-6677fb79eecmr3629813d50.25.1783440265929; Tue, 07 Jul 2026
 09:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <1459371d3ab2f237152e20040987b4cb6a5eca77.1783344957.git.gitgitgadget@gmail.com>
 <ak0aRtvSxSyIWieg@pks.im>
In-Reply-To: <ak0aRtvSxSyIWieg@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 7 Jul 2026 18:04:15 +0200
X-Gm-Features: AVVi8Cc5AFgRN7r96Fq-6CnBJezHqvXJBGlBc-sezldjyN-6L3GVTwJjx0YHBBA
Message-ID: <CAL71e4NQLyM1T3YCL1Q09wfnkq7B3ah6i38yBeK8ZJCx1JejgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] reftable: fix quadratic behavior when re-creating
 deleted refs
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 17:24, Patrick Steinhardt <ps@pks.im> wrote:
>
> > This affects two code paths during ref creation:
> >
> >  - refs_verify_refnames_available() seeks to "refs/tags/foo-1/" to
> >    check for D/F conflicts and must scan through all subsequent
> >    tombstones before the caller can see that they are past the prefix
> >    of interest.
> >
> >  - reftable_backend_read_ref() seeks to a specific refname and must
> >    scan through all subsequent tombstones before returning "not
> >    found", because the merged iterator skips the matching tombstone
> >    and searches for the next live record.
>
> It probably not only impacts reference creation, but also every reader
> that wants to search for a specific reference that doesn't exist.

Hm good point, I will try to rephrase this better.

> > Fix this by removing suppress_deletions from the merged iterator and
> > instead handling deletion records at each call site in the reftable
> > backend, where prefix and refname bounds are available.  Tombstones
> > are now returned to callers, which skip them after their existing
> > bounds checks.  This allows iteration to terminate as soon as a
> > tombstone past the relevant bound is encountered.
>
> This option is still used by downstream users of the reftable library,
> like libgit2. So we shouldn't just delete it outright.

Good catch! I can keep suppress_deletions as-is and just
stop setting it from stack.c. That way libgit2 is unchanged, while
we still optimize it at the other call sites. The reftable library
diff then shrinks to a single removed line.

> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 4ae22922de..8c4f119ff1 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -633,6 +633,9 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >                       break;
> >               }
> >
> > +             if (iter->ref.value_type == REFTABLE_REF_DELETION)
> > +                     continue;
> > +
> >               if (iter->exclude_patterns && should_exclude_current_ref(iter))
> >                       continue;
> >
>
> Okay. I was first wondering whether we should move this call earlier.
> But we actually don't want to, as this is the code that precedes the
> above:
>
>         if (iter->prefix_len &&
>             strncmp(iter->prefix, iter->ref.refname, iter->prefix_len)) {
>                 iter->err = 1;
>                 break;
>         }
>
> So this allows us to not only skip the current iteration, but completely
> abort iteration by observing tombstones that sort after our prefix.

Indeed, this is the primary win.

> In any case, as far as I can see all sites where we iterate through
> either ref or log records have been adapted to handle deletions.

Thanks! Appreciate the review (and spotting the libgit breakage!)
Kristofer
