Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D102E36EC
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442128; cv=none; b=EuEeJMU4biw7FKIPZl23CsztOK1ZeCIJ1Wnjwv9jlXeEsDmnVm/fKxF52P/b1DJFpNWykmto1uy+Pidza7OukfjrrLgb0GXFFAAkKuRBvDmcjFFbja12YPM2Idc2ksGpHYTTWlPYsOmKajiiq4VRq08t6dSyShVOrYekfC+3/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442128; c=relaxed/simple;
	bh=Z0zNRfG/GZZLT/iYwxuIiQ3IpBunEbhEmBXWJxbt5DE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bfFpFG2BR+yfj0mld5gGLyv+OdNgmRuV9OYwaaRGr2nX6yMBVztOpCPPo4S2iPqbT6g0ftpmKYV+PYJbSRsKbUF9qM+2fK2j4J6QZHKUEcroDYfK4fkttRNUdx8GG0xJQm6wg5wGdlugHI+gqCSEvuK5nji74qwrbqSXp9V5klI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtxGq7K9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtxGq7K9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31ecd40352fso5289138a91.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 18:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754442126; x=1755046926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqBBEA/TQfmQS9uYDn+dtu+PG0eAtPCMCb/hdKW75L8=;
        b=GtxGq7K9KYdNzqjSlmIu/wZ8ufM4cwGXNgRNbhiSqaqaknkj6GVPe8fvC1J+dX2uoZ
         Rz/M2bud0GVDNl3VA935Gfmhi5kAZvPdJG8vpXtkNDpXmZ67oyJuXWTsmkf9D8TC/yrw
         xcidkwnuWgy7P8d3yPCV+PSGw/t5vHWQhKr3uPi1/RYzbEPvN7WJqxsNAc5O32tPfzvN
         ej3jhWEJlnVUKe6PfmKklKDDacumA1M9DzpeWDQFrgUcIRDIpm42Pa1R+bJpbjOa6/Kg
         wFqa2C2BuDGNaGHUreQAh5pvXS7gTKjBSyX5IFS4B2QGSgglRMiQUhHpNxN9yJvHD3bm
         rC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754442126; x=1755046926;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqBBEA/TQfmQS9uYDn+dtu+PG0eAtPCMCb/hdKW75L8=;
        b=Hlm1X0f6cHtMeLvQl2Egdjz02SUQsf+ACKDalCg5MfjOpZoJNTujZe8TkjxFnfzBoc
         soH5bxbCQ7B9Ab8bbzOlTUWvEvPy1P29ohHzU1nTXJDYtXQmCXct2VA6Ju6KyVYkyeEz
         kLe4HTOJm44xH0/2SeIrX6xNIi6S3khMlcLiMlLN3rOFOnNLwnM0OWF6wPOB8GR3ALBT
         HwmtdQAt9nfoy8pl6Sb561EQR91TTbdZNVZmbMUkC8xdmhMC5AbCJk2P/fPi+LW8Vu1M
         cKJGcXip57ACwlgtPIHl5LzVElIJmg92TePfWfCDLKZTdzxMADDisgnSIf9bhCNG+z0V
         P5BA==
X-Gm-Message-State: AOJu0YxlVtVztv+8sboFsgnJ4sYi37x2YYH/sIIffExqKKOu9XcqXgFI
	hieh00Epm8kivc16y+Mazrmi5KK7XIMIGwjMw8RXkkZqoiHG6VSgug1JxKMk8A==
X-Gm-Gg: ASbGncsHOXPI6k2pS3cX+PmTDch0IhKHP6e9fhKepiTrqERMaKy1YVtphxq0h2g0SGh
	S0gs+OkvAVrWYnylS2g1mzN9uw3o2gNiIpFzNTKuphm14fW23HqmSIQLDvqJnv01POzILP+dCvD
	WWXK+xhCgbR9rl+fIv9zpVMOSKlbZgxAflj7KIqIo8FKzmPuV5ze+QAAK1iIwP7uE2OfU/ZvAzC
	PjBWoE4B1n8l09E8LlNTdWYQuK0oLxRFcxjCvUgv75E9ZewNv7aWAsZI9o3I54tq1KKux8UmPhb
	J1RLrRxUOXfcwSR4ynvYTxQL/b9TzQuNwZ80tilG1aYKAhSrDqijudH4mpcAM4ceLrLhZNSsBdm
	1p6bKG932pWfaNw==
X-Google-Smtp-Source: AGHT+IGKDVTFRakwOilm8zqlBMuyvGuteuD9ArIsDXtrc1k6uyDL/gsL51XhKU8h8IgYg5cOryNnZw==
X-Received: by 2002:a17:90b:3cc7:b0:31f:2101:849c with SMTP id 98e67ed59e1d1-32166c2d70emr1112311a91.12.1754442126205;
        Tue, 05 Aug 2025 18:02:06 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::e9a2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77efe4sm11875971a12.6.2025.08.05.18.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 18:02:05 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/6] doc: check for absence of multiple terms in each
 entry of desc list
In-Reply-To: <5806390052b7a7cbdb8dc843bfcc24102604e2f6.1754421046.git.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
	<pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
	<5806390052b7a7cbdb8dc843bfcc24102604e2f6.1754421046.git.gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 18:02:04 -0700
Message-ID: <878qjxi7oz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Due to portability issues, the script generate-configlist.sh was fixed to
> not use carriage returns in the output. However, the result is that it no
> longer correctly handles multiple terms in a single entry of the definiti=
on
> list.
>
> We now check that these entries do not exist in the documentation.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/Makefile                      | 10 +++++++++
>  Documentation/git-check-attr.adoc           |  3 ++-
>  Documentation/git-check-ignore.adoc         |  9 +++++---
>  Documentation/git-http-fetch.adoc           |  4 +++-
>  Documentation/lint-documentation-style.perl | 24 +++++++++++++++++++++
>  Documentation/technical/api-path-walk.adoc  |  5 ++++-
>  shared.mak                                  |  1 +
>  7 files changed, 50 insertions(+), 6 deletions(-)
>  create mode 100755 Documentation/lint-documentation-style.perl

I documented that this was the correct way to format them in
CodingGuidelines. At the time I commented that there were some places
that didn't follow this rule. Junio replied [1]:

> We are updating them gradually while avoiding collisions with
> patches that do other "real" work; see many recent patches to
> Documentation/config/ area by Jean-No=C3=ABl Avila for more, e.g.
> d30c5cc4 (doc: convert git-mergetool options to new synopsis style,
> 2025-05-25).

As long as he is okay with the change, this looks good to me. It isn't
that many changes, so hopefully it is. :)

Small nit, but the issue was '\n' not being interpreted as a newline in
sed's s command. Mentioning carriage return makes me think of '\r'.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Collin
