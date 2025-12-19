Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D12EE5F4
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134632; cv=none; b=Rkla1FkryN1dlx1IBJ1SKPl88AyNk3FV+KOr4P8yWqFWCCmneRd6fxnVathcZ66Ih6cCIeDJfcmTIQOgiaHxP5sMAyGVDkxbzKlk9y2cTUHobmmOEmF8GiK0ZYqRvVsEMUKHdWgYKbpt3wlak649G0wxuTIshhMTkZPgfZck5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134632; c=relaxed/simple;
	bh=oKnAquJQ7DIsdHNeo2hWWA8i4VmQDu2aCc3baIb2WkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hKCQNzdnDjXi+qS9xioKPxhFLDz2CQKykhEwoMybXK4z1zqU9SfO5V6kG+uCTKXb+yuXexMSVFgc7ntPGrWiVZnuwjINDa1cxJHwgTwcKuV7RZtrQol1LluIHefe8xY7Zae0q7dtCbeXQuNEfz2TRVnU5za9paet521NQbyuQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFjO59FN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFjO59FN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d0788adaso13787485ad.3
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 00:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766134630; x=1766739430; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAY4Fyckc4/X/mKASmJp038el1EsDWYgVFsz4v5zkoU=;
        b=nFjO59FNGs02uaIaoe/BBFwKiFnaw8QYRwdvwYHmJHluawoCbHJ5txPSC4qz7ahzRY
         7Hxx/krPwHPEOfu0JS8Uq+u4LWTzOjQ3zQ5VisOtAXTq2CRZ5Led1o1hbE3ItGjctPkq
         J9jRStriindhfvmqW/Otya2Pv/iZQrQdkcpKIOuNpdfxcKBL2PtGOoS+q0oo+hfuBCOz
         OHQUnDuIcITooEpXyijNrtZ3vK7sFj4ElslQ9DEG1caeym3jgKx57nsCGbCagIfpa0a7
         eQI6pzSpvhaE7gEoFsHpd4r+/GfJLSeEFi5czYfl/dNlm5jwkT35I/dTj443dH31B3yE
         Q1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134630; x=1766739430;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oAY4Fyckc4/X/mKASmJp038el1EsDWYgVFsz4v5zkoU=;
        b=w6l4Ls6I5jUFRR51YgRTZeIRz/t7YfWfURbXbRPbEBSct/ho/QdPvl/1QPZLf9LMwZ
         x559PaJyqZvHlP9QpOZWYZXaBIeqjO96mU3Tgt9busIDrmC3dMZQVZ1B0nWrafCQ+QAK
         SuksDH0AsTJlx1rM2UKS0G2NINiakF7gJ/7wGSFEl8fOwAFKukIpvNkmwvvT27yHWzz0
         saUWvKyb+y83sEKxyuja7Slz1/vGRWBTnjpexVb+C97UUkhIAtkzjDPxBY0+EzpcEuFi
         hQgVcljUf0sdcc/eEb1cQ7KYYXV8Re9Uo8CfupgiweeWsMMZ4Sr5Onp425gEnkJACP3g
         fmVg==
X-Gm-Message-State: AOJu0Yyj1lno67mKJ70yFkQziCPxYW47WHpl93Uj8JliVVvszto+6VLt
	lxarXHJj4EViU+WFgY9t+A78tUMjWw1r6RalYFwVMDYgzaT2eq/7gJ5k
X-Gm-Gg: AY/fxX59Av23dAz4B/liwTh3ZJV2g6YB6OtAvYug9rdtCp68LzYJ3HRtvTZNoVd6V7d
	OChyqNvEAeDngSjGbOSLePCb8gThl+gYSaLoWFsMJaTH6lJth+KFFfRPh2QZHC7yvsjL+zpWaht
	HvzFSfHyhCnrO7J30V30KOpaVfn536EZoUQP8Y6kY9/N5dAaJgF3jElaiYw2ZMJPyXzgVcWKi7/
	75injqX9aNdj0SEu3uWsX3uFJg+8pOggU6THCBCrEnu5MOz7LdMX6/+3uyin7L8cR5JLLU2NwMg
	U2QN8itrqkfKS43r3wqbZ93DFxkzR7mqJj6kGYrCTVGV0dPEpuB5Hw6XxUCJzvcpHLcJexZj88V
	OgirNGM6m5812WSK+uGVi+ShMb7jMFwnSy34rmhx1XIfEcjolVW7e6zD1z4ShREPFccpK
X-Google-Smtp-Source: AGHT+IHrTNe6xts3enwFHH3lK6gmwraVnSEG9tj9O4uQelV1QzyLgUNAiHqHdHeUxh7A9sqzU54u9g==
X-Received: by 2002:a17:903:32cf:b0:2a2:dc3f:be4c with SMTP id d9443c01a7336-2a2f220d883mr20675895ad.10.1766134629618;
        Fri, 19 Dec 2025 00:57:09 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::fde9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb48sm16214865ad.64.2025.12.19.00.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:57:09 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] diff: add --no-indicators option
In-Reply-To: <pull.2133.git.git.1766132264231.gitgitgadget@gmail.com>
References: <pull.2133.git.git.1766132264231.gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 00:57:08 -0800
Message-ID: <87qzsqaly3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add --no-indicators to replace '+', '-', and ' ' indicators in the
> left margin with spaces. Colors are preserved, allowing diffs to be
> distinguished by color alone.
>
> This is useful when copy-pasting diff output, as the indicators no
> longer need to be manually removed.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     diff: add '--no-indicators' option
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2133%2FHaraldNordgren%2Fno-indicators-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2133/HaraldNordgren/no-indicators-v1
> Pull-Request: https://github.com/git/git/pull/2133
>
>  diff.c                 | 17 +++++++++++++++++
>  t/t4000-diff-format.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)

Would a 'sed' command work for this? Something like:

    $ git diff --color=always HEAD~ \
        | sed -E '/^(\x1b\[[0-9;]*m)*(-{3} a|\+{3} b)/b
                  s/^((\x1b\[[0-9;]*m)*)[-+]/\1 /'

My impression is that indicators are wanted for diff's most (all?) of
the time.

Collin
