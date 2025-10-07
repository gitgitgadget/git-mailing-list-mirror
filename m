Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DC31991CA
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828463; cv=none; b=M7FKx6O27QlgK6n5v+Ng5QexoR6RoQkyRKTwLtNNmQHUpHbumCOBwkBWHGkeYi9om92MyKyWfZwtuZwLy7KcVPuj9dPhtW2qweTDVKqUaAix2TIBnTibM0mNaCoZUaFEvaVXrHtzc62CzwPbUMI+YJclBpTxKGp9VxufsuH4YCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828463; c=relaxed/simple;
	bh=1Bgdj08FYzh3rq866zik6EAq9OwBk3Uw+fnf4qpSN/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpovxlmYmU3PtdAJAOgF9BhroYVG6YGl0+wW2jjVOzlRrBzEZ5VKb6Y0M1ITS22HVoYL7TtKbjGE5HrdnOmXjmlPzYO0M8ONeZBMWVXjTOx+fuMQxkyGNkIvYECL12IDtOOhwG1SoVIX5uTbxv8DNUn4/fHu+dv15OiNMj+GtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOups2eN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOups2eN"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so7145322e87.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759828459; x=1760433259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp0035EhU8391WFjZz4//EXr3sTzQuFlFSutyZ2jHwc=;
        b=XOups2eNPqsBsPG4fJptuvjf7W6mPxf8xAsQuBDiI2mQeahw3x/Iy9r07anAx3hP4s
         unCPQ2p/DDH+Rq/KWdSKizoXnomqcBfvJj4I/c7pxVyTuXraWD59r0V5KuhnVimkzoBk
         YuSzwtC8Th4cSn7zL9WP9WsMRRfEaYSk/f41BnTDebAJrmhQuaiRP1M1cc6TSmuwhUek
         ag7RjMoJuORus9Fdg5J2lFltGBPaws1sXwrMjd0o3iihCekFzFrHDuWf8M1nH0j/WMeh
         UIiA76v2QLv5ouYnHy7mH3cnBPpLBaJUBbkpfu/5JcW7tyL83W865v9yuRcVX63Stp7o
         nGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828459; x=1760433259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xp0035EhU8391WFjZz4//EXr3sTzQuFlFSutyZ2jHwc=;
        b=FSfqDSUEtikAXXf8k2Q3OM2E93jdAKP1+aNNIXKKA29Q4pVXfHt1hh0lvblxn8LL+s
         jnlJgXwenTWmXaNmiDwF911Gh+KMp8RstduRz/3nkW3OlgytH9AQEtWL8MQZMY+I8WTR
         F6TgOfd4Mr4Yk5GiXGM0BppYO6/myOFq1sbK16ixzPYNtVkHypIujorA881fdsKLLZtZ
         TQzSTBZxgg1XDRZOcgFvZ4r0H66Skg2jh1ICzyIxnKpAbTnUImO8QxpBPV5ETyAUc55O
         9NGorlXIFPvdpH8Sf6gShQGxTgqfsX/DYm4NB0TFeKMiJ0lWE8IDHk5LenSLZogLgVbD
         isPw==
X-Gm-Message-State: AOJu0Yzk+8icmahp3Tk2CTukZ7Vd2SxDDDWvgmV2IGQU95Hd+xrQmJen
	5v0I1c/6wCjRVIzvWuami9m1lcP9CBoVrjxgT8sRFRiItpmUtV+Yvo0SlhIpz/RhSvxXdJvABqR
	llVwo3nTiPv1DncyjWqVne3jqixqUYn3/6llcvQw=
X-Gm-Gg: ASbGnctnxIs4CcWbMKqyDdZbf6hLPKsulVYYSP5zWO5a+wJ57x56mwCDq0vkbi3FUN8
	QoGO9G84cGVS5KeFn39xpL8Ef+NZEBCQq+Faz6+S+ctggSRi73FvYphM9mJXgzKome3Dr2KOQBs
	9p+HBBwOD4TjBXJW6mq+2pI3r0RWhb0Vfl1FBGEK1Ty6Q124uf6B97DWAixVXE1BydTuHQHhtHM
	GA9fNVPlh8eV4SDpOLDZUzSaeFP
X-Google-Smtp-Source: AGHT+IHR+b5iDN48UmTWQHBW1+MzrEkTy2rAOsvplA1qXFzmuim/UaXKLc78/cepveVrnCU3woYUlzMsyqXjTVhmWPw=
X-Received: by 2002:a05:6512:6193:b0:562:d04d:fa06 with SMTP id
 2adb3069b0e04-58cbb4419d8mr5252570e87.32.1759828459168; Tue, 07 Oct 2025
 02:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV3+4k5tsgRw0g8-HoVSFGb1AwZr+2hCUXLriFGSd33WQQ@mail.gmail.com>
 <lrahpvp3nj4rtewf3zbf67qsvwhc4mg6irbmrhklbizxbhqwom@cc25oeqex4il>
 <CANM0SV38YcQ+THbAyTR5cnaX3iDfb92qG8gyAzUaJ5jMK7FfYQ@mail.gmail.com> <l62blkvi5ouzhkbfmimumhzdkv6tmszsxuxhlfkmu2lkspyihy@75466fqmo6ez>
In-Reply-To: <l62blkvi5ouzhkbfmimumhzdkv6tmszsxuxhlfkmu2lkspyihy@75466fqmo6ez>
From: Devste Devste <devstemail@gmail.com>
Date: Tue, 7 Oct 2025 11:14:07 +0200
X-Gm-Features: AS18NWB6-uw-QhsPlQokPN1jlZ3IPcn5DsuZ_EzUvwrM2PtX_pONn0o-Q-MjkoM
Message-ID: <CANM0SV1p3auirRoHTfh2r=JuP-QU7uyK4o1+PZNVPT1mCVSqXw@mail.gmail.com>
Subject: Re: Untracked files cache not used when --untracked-files is used
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Which means essentially, I have to run git status --untracked-files
once a day to keep the untracked cache up to date, since I can't
change the git commands SourceTree uses

On Mon, 6 Oct 2025 at 19:25, Matthew Hughes <matthewhughes934@gmail.com> wrote:
>
> > One of --no-optional-locks --porcelain --ignore-submodules=dirty
> > --no-ahead-behind causes it to not update the cache it seems.
> > Unfortunately, I cannot tell which exactly, because now, even when
> > unsetting status.showUntrackedFiles it uses the cache for
> > --untracked-files=all
> > This means, that if the untracked cache was created with
> > status.showUntrackedFiles all, it will always use the untracked-files
> > cache for --untracked-files
>
> You can disable the untracked cache with `git update-index
> --no-untracked-cache`. Experimenting with that, on my machine the culprit looks
> to be `--no-optional-locks`:
>
>     time GIT_CONFIG_GLOBAL=/dev/null git \
>         --no-optional-locks \
>         -c 'diff.mnemonicprefix=false' \
>         -c 'core.quotepath=false' \
>         -c 'core.untrackedCache=true' \
>         -c 'status.showUntrackedFiles=all' \
>         status \
>         --porcelain \
>         --ignore-submodules=dirty \
>         --no-ahead-behind \
>         --untracked-files=all  >/dev/null
>
> Will consistently, on repeated runs, take >1s. After removing
> `--no-optional-locks` one more run is still slow, but after that it drops to
> ~300ms.
>
> Glancing at the code: the likely cause is the `repo_update_index_if_able` call
> in `cmd_status` is only called when `use_optional_locks` returns a truthy
> value.
