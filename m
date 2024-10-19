Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB3229AF
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729315289; cv=none; b=BO6jTwHA+qvJq9zH4fdCGh60VrXQ6mI4lUsuNiFkJNLVPB2O/fVQ8TaInFoU9A2yDphppgOKC2n87AhvpNDUxGgvbHDx6EPnEF99L2KBo3tnVJ1HQ05nygmPT0rxBjHy/6qR7Y2uJoxWVrjlbEbJnybPioU1O6tIVrjQZA18Y28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729315289; c=relaxed/simple;
	bh=bN/rXsRfDnVt8H+97k6NbCOEwHDUr7LRmNDxt4+/qjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciSR5bVMrlea4cyVxuOVs7643DFTN7POStKrcyFlFORMnAHXcziUWAhMzJgmcLIyTu3Y54IMxtkOEemnbjJM6lI8rWwmLOU04mNrUyEbQx8/wcjSnHhLmlIugT/MIgx7f3Ec2TrF4EZPujM9xlVVJzHfuIMS+dLbTQtf84h2cnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46093e4dbb7so2216031cf.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 22:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729315286; x=1729920086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joN86midhgjoUuVRu6AAJssjRktpzF/r5Pe927PyfIk=;
        b=joE7u7pFV/S16684sa3OxFz0AFSVQ0nolucKY2bDj31nInkzGasXHAvjEjqD8JKgWt
         HjB/eNm5wTR5UBVsKJcyBnW5rsWpdnJ+CJa/hL9h6w65y8fekgHuvUuQ53vwyvckisBz
         r19Aeppu6MZhKCIGfQ/jp3tSuvNnTjXF7gCHEW8HHNetoapcshsfY99/DbjFb56VQv/Z
         4eCkOXRb3XBKvPzuzjUCzGBSuUKVJotKFmaPtcL61wKIdeAWBACDkmUSxX6SMnilLSDn
         NKeH/BXRW81q/z0XfcXUA/0nPVrNtu/mGx5zzDyAssV3cOGhuH/UFIOgmQMBSRXp2Ob9
         JVGg==
X-Gm-Message-State: AOJu0YzfAWl9Z8kAZV1JoO2/B+4s8SqwLLEHECgbNcuCeA/n5mPqfUwr
	dkzcVapPBOFQEyW/YrksDOdG9vsccYf0rTHdtH2Kx1ofsCq9wM0Qx2AOtZM/uFQzirtJZ8Q56DV
	ddEsmSYNN6KfAV7TQQjCRlwQWpAU=
X-Google-Smtp-Source: AGHT+IG8LvRVEXMoLV9S3B5zFGDmFGmvw4uHbHUKGQUkDhoeiikzbXHF8zubFI8/KR8nKHwJbtSQO2s5FayXGfX+ZkI=
X-Received: by 2002:a05:6214:400f:b0:6cb:6006:c98b with SMTP id
 6a1803df08f44-6cde1507d67mr33223046d6.5.1729315285832; Fri, 18 Oct 2024
 22:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im> <ac327d98e9c287b07b8d4ab0647adbefea53ed82.1729254070.git.ps@pks.im>
In-Reply-To: <ac327d98e9c287b07b8d4ab0647adbefea53ed82.1729254070.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 19 Oct 2024 01:21:14 -0400
Message-ID: <CAPig+cSZau1h47wUSqgAxS07tYWpQ7+r8e5RzGqh+=EoQiqydw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 15/15] Introduce support for the Meson build system
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 8:24=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Introduce support for the Meson build system, a "modern" meta build
> system that supports many different plaforms, including Linux, macOS,
> Windows and BSDs. Meson supports different backends, including Ninja,
> Xcode and Microsoft Visual Studio. Several common IDEs provide an
> integration with it.

s/plaforms/platforms/

> The biggest contender compared to Meson is probably CMake as outlined in
> our "Documentation/technical/build-systems.txt" file. Based on my own
> personal experience from working with both build systems extensively I
> strongly favor Meson over CMake. In my opinion, it feels significantly
> easier to use with a syntax that feels more like a "real" programming
> language. The second big reason is that Meson supports Rust natively,
> which may prove to be important given that the project is likely to pick
> up Rust as another language eventually.

s/is likely to/may/

>     # Execute single test interactively to allow fordebugging.
>     $ meson test 't0000-*' --interactive --test-args=3D-ix

s/fordebugging/for debugging/

>   - We do not install dashed binaries into `$libexec/git-core` anymore.
>     So there won't e.g. be a symlink for git-add(1). These are not
>     required by modern Git and there isn't really much of a usecase for
>     those anymore. By not installing those symlinks we thus start the
>     deprecation of this layout.

s/usecase/use case/

>   - We're targeting a Meson 1.3.0, which has been released relatively
>     recently November 2023. The only feature we use from that version is
>     `fs.relative_to()`, which we could replace if necessary. If so, we
>     could start to target Meson 1.0.0 and newer, released in December
>     2022.

s/targeting a Meson/targeting Meson/
